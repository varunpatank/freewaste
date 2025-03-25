'use client'
import { useState, useEffect } from 'react'
import { ArrowRight, Leaf, Recycle, Coins, MapPin, ChevronRight } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Poppins } from 'next/font/google'
import Link from 'next/link'
import { getUserByEmail } from '@/utils/db/actions'
import { useUser } from '@auth0/nextjs-auth0/client'
import { motion } from 'framer-motion'
import { LoadingScreen } from '@/components/LoadingScreen'
import { FloatingWasteIcons } from '@/components/FloatingWasteIcons'
import Image from 'next/image'

const poppins = Poppins({ 
  weight: ['300', '400', '600'],
  subsets: ['latin'],
  display: 'swap',
})

const images = {
  hero: 'https://images.unsplash.com/photo-1493246507139-91e8fad9978e?auto=format&fit=crop&w=2940&q=80'
}

export default function Home() {
  const { user } = useUser()
  const [pageLoading, setPageLoading] = useState(true)
  const [userData, setUserData] = useState({
    totalPoints: 0,
    totalWaste: 0,
    totalReports: 0
  })

  useEffect(() => {
    const timer = setTimeout(() => {
      setPageLoading(false)
    }, 2000)
    return () => clearTimeout(timer)
  }, [])

  useEffect(() => {
    const fetchUserData = async () => {
      if (user?.email) {
        try {
          const data = await getUserByEmail(user.email)
          if (data) {
            setUserData({
              totalPoints: data.totalPoints,
              totalWaste: Number(data.totalWaste),
              totalReports: data.totalReports
            })
          }
        } catch (error) {
          console.error("Error fetching user data:", error)
        }
      }
    }
    fetchUserData()
  }, [user])

  if (pageLoading) {
    return <LoadingScreen />
  }

  return (
    <div className={`min-h-screen flex flex-col ${poppins.className}`}>
      <main className="flex-grow relative">
        <FloatingWasteIcons />
      
        {/* Hero Section */}
        <section 
          className="relative min-h-screen flex items-center justify-center py-20 px-4"
          style={{
            backgroundImage: `linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url(${images.hero})`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
            backgroundAttachment: 'fixed'
          }}
        >
          <div className="text-center text-white z-10 max-w-4xl mx-auto">
            <motion.h1 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              className="text-5xl md:text-7xl font-bold mb-6 bg-clip-text text-transparent bg-gradient-to-r from-blue-300 via-blue-400 to-blue-500"
            >
              Make Our World Cleaner
            </motion.h1>
            <motion.p 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2 }}
              className="text-xl md:text-2xl text-blue-50 mb-12"
            >
              Join our community in making waste management more efficient and rewarding.
              Together, we can create a sustainable future.
            </motion.p>
            <motion.div
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: 0.4 }}
              className="flex flex-col md:flex-row gap-4 justify-center"
            >
              <Link href="/report">
                <Button className="bg-blue-600 hover:bg-blue-700 text-white text-lg py-6 px-10 rounded-full btn-glow flex items-center">
                  Report Waste
                  <ArrowRight className="ml-2 h-5 w-5" />
                </Button>
              </Link>
              <Link href="/collect">
                <Button className="bg-gradient-to-r from-green-400 to-blue-500 hover:from-green-500 hover:to-blue-600 text-white text-lg py-6 px-10 rounded-full shadow-lg transition-transform transform hover:scale-105 flex items-center">
                  Start Collecting
                  <ChevronRight className="ml-2 h-5 w-5" />
                </Button>
              </Link>
            </motion.div>
          </div>
        </section>

        {/* Features Section */}
        <section className="py-20 px-4 bg-gradient-to-br from-blue-50 to-blue-100">
          <div className="max-w-6xl mx-auto">
            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              className="text-center mb-16"
            >
              <h2 className="text-4xl font-bold mb-4 bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-blue-800">
                How It Works
              </h2>
              <p className="text-xl text-gray-600">Simple steps to make a big impact</p>
            </motion.div>

            <div className="grid md:grid-cols-3 gap-10">
              <FeatureCard
                icon={MapPin}
                title="Report Waste"
                description="Spot waste? Report it easily through our app and earn points."
                image="https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?auto=format&fit=crop&w=800&q=80"
                delay={0.2}
              />
              <FeatureCard
                icon={Recycle}
                title="Collect & Clean"
                description="Join collection events or clean up reported areas."
                image="https://images.unsplash.com/photo-1618477388954-7852f32655ec?auto=format&fit=crop&w=800&q=80"
                delay={0.4}
              />
              <FeatureCard
                icon={Coins}
                title="Earn Rewards"
                description="Get rewarded for your environmental contributions."
                image="https://images.unsplash.com/photo-1524253482453-3fed8d2fe12b?auto=format&fit=crop&w=800&q=80"
                delay={0.6}
              />
            </div>
          </div>
        </section>

        {/* Impact Section */}
        {user && (
          <section className="py-20 px-4 bg-white">
            <div className="max-w-6xl mx-auto">
              <motion.div 
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                className="text-center mb-16"
              >
                <h2 className="text-4xl font-bold mb-4 bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-blue-800">
                  Your Impact
                </h2>
                <p className="text-xl text-gray-600">See the difference you're making</p>
              </motion.div>

              <div className="grid md:grid-cols-3 gap-6">
                <ImpactCard 
                  title="Total Points" 
                  value={userData.totalPoints} 
                  icon={Coins} 
                  delay={0.2}
                />
                <ImpactCard 
                  title="Waste Collected" 
                  value={`${userData.totalWaste.toFixed(1)} kg`} 
                  icon={Recycle} 
                  delay={0.4}
                />
                <ImpactCard 
                  title="Reports Submitted" 
                  value={userData.totalReports} 
                  icon={MapPin} 
                  delay={0.6}
                />
              </div>
            </div>
          </section>
        )}
      </main>
    </div>
  )
}

function ImpactCard({ title, value, icon: Icon, delay }: { title: string; value: string | number; icon: React.ElementType; delay: number }) {
  const formattedValue = typeof value === 'number' ? value.toLocaleString('en-US', { maximumFractionDigits: 1 }) : value
  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.8 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ delay }}
      className="card-hover p-8 rounded-xl bg-gradient-to-br from-blue-50 to-blue-100"
    >
      <Icon className="h-12 w-12 text-blue-600 mb-4" />
      <p className="text-4xl font-bold mb-2 bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-blue-800">
        {formattedValue}
      </p>
      <p className="text-lg text-blue-700">{title}</p>
    </motion.div>
  )
}

function FeatureCard({ icon: Icon, title, description, image, delay }: { icon: React.ElementType; title: string; description: string; image: string; delay: number }) {
  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.8 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ delay }}
      className="rounded-2xl overflow-hidden shadow-xl hover:shadow-2xl transition-all duration-300 bg-white"
    >
      <div className="relative h-64 w-full">
        <Image 
          src={image}
          alt={title}
          fill
          style={{ objectFit: 'cover' }}
          className="w-full h-full"
        />
      </div>
      <div className="p-6">
        <div className="mb-4">
          <Icon className="h-8 w-8 text-blue-600" />
        </div>
        <h3 className="text-2xl font-semibold text-gray-800 mb-2">{title}</h3>
        <p className="text-gray-600">{description}</p>
      </div>
    </motion.div>
  )
}
