'use client'
import { motion } from 'framer-motion'

interface PageHeaderProps {
  title: string
  description: string
  icon: React.ReactNode
}

export function PageHeader({ title, description, icon }: PageHeaderProps) {
  return (
    <motion.div 
      initial={{ opacity: 0, y: -20 }}
      animate={{ opacity: 1, y: 0 }}
      className="mb-8 bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-2xl p-8 shadow-lg"
    >
      <div className="flex items-center gap-4">
        <div className="p-3 bg-white/10 rounded-xl">
          {icon}
        </div>
        <div>
          <h1 className="text-3xl font-bold">{title}</h1>
          <p className="text-blue-100 mt-1">{description}</p>
        </div>
      </div>
    </motion.div>
  )
}