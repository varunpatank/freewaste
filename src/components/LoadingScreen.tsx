'use client'
import { motion, AnimatePresence } from 'framer-motion'
import { Trash2, Leaf, Recycle } from 'lucide-react'

const wasteItems = [
  {
    icon: 'https://img.icons8.com/color/240/recycle-bin.png',
    label: 'Recycle Bin',
  },
  {
    icon: 'https://img.icons8.com/color/240/plastic-bottle.png',
    label: 'Plastic Bottle',
  },
  {
    icon: 'https://img.icons8.com/color/240/paper-waste.png',
    label: 'Paper',
  },
  {
    icon: 'https://img.icons8.com/color/240/tin-can.png',
    label: 'Metal Can',
  },
  {
    icon: 'https://img.icons8.com/color/240/glass-bottle.png',
    label: 'Glass',
  }
]

export function LoadingScreen() {
  return (
    <AnimatePresence>
      <motion.div 
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        className="fixed inset-0 bg-gradient-to-br from-blue-50 to-blue-100 flex items-center justify-center z-50"
      >
        <div className="relative w-full h-full flex flex-col items-center justify-center">
          {/* Logo Animation */}
          <motion.div
            initial={{ y: -50, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ duration: 0.5 }}
            className="absolute top-20 flex items-center gap-4"
          >
            <motion.div
              animate={{ 
                rotate: [0, 360],
                scale: [1, 1.1, 1]
              }}
              transition={{ 
                duration: 3,
                repeat: Infinity,
                ease: "easeInOut"
              }}
            >
              <Leaf className="h-24 w-24 text-blue-600" />
            </motion.div>
            <motion.h1 
              initial={{ x: -20, opacity: 0 }}
              animate={{ x: 0, opacity: 1 }}
              transition={{ delay: 0.3 }}
              className="text-6xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-blue-800"
            >
              GreenHero
            </motion.h1>
          </motion.div>

          {/* Waste Bin Animation */}
          <div className="relative mt-32">
            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ delay: 0.5 }}
              className="relative"
            >
              <motion.div
                animate={{ 
                  scale: [0.95, 1, 0.95],
                  rotate: [-1, 1, -1]
                }}
                transition={{
                  duration: 2,
                  repeat: Infinity,
                  ease: "easeInOut"
                }}
              >
                <Trash2 className="w-48 h-48 text-blue-600" />
              </motion.div>

              {/* Falling Waste Items */}
              {wasteItems.map((item, index) => (
                <motion.div
                  key={index}
                  className="absolute"
                  initial={{ 
                    x: (index - 2) * 200,
                    y: -500,
                    rotate: 0,
                    opacity: 0,
                    scale: 1.5
                  }}
                  animate={{ 
                    x: 0,
                    y: 0,
                    rotate: 360,
                    opacity: [0, 1, 1, 0],
                    scale: 1
                  }}
                  transition={{
                    duration: 2,
                    delay: index * 0.8,
                    repeat: Infinity,
                    repeatDelay: wasteItems.length * 0.8,
                    ease: "easeIn"
                  }}
                >
                  <img 
                    src={item.icon} 
                    alt={item.label}
                    className="w-32 h-32 drop-shadow-lg"
                  />
                </motion.div>
              ))}
            </motion.div>
          </div>

          {/* Loading Text */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 1 }}
            className="absolute bottom-20 text-center"
          >
            <motion.div
              animate={{ 
                scale: [1, 1.2, 1],
                opacity: [0.5, 1, 0.5]
              }}
              transition={{
                duration: 1.5,
                repeat: Infinity,
                ease: "easeInOut"
              }}
              className="flex items-center justify-center gap-2 mb-4"
            >
              <Recycle className="w-8 h-8 text-blue-600" />
            </motion.div>
            <p className="text-2xl font-medium text-blue-800">
              Loading your eco-friendly experience...
            </p>
          </motion.div>
        </div>
      </motion.div>
    </AnimatePresence>
  )
}