'use client'
import { motion } from 'framer-motion'

const wasteIcons = [
  'https://img.icons8.com/color/48/recycle-bin.png',
  'https://img.icons8.com/color/48/waste-separation.png',
  'https://img.icons8.com/color/48/waste.png',
  'https://img.icons8.com/color/48/garbage-bag.png',
  'https://img.icons8.com/color/48/waste-sorting.png',
  'https://img.icons8.com/color/48/environmental-planning.png'
]

export function FloatingWasteIcons() {
  return (
    <div className="fixed inset-0 pointer-events-none overflow-hidden z-0">
      {[...Array(10)].map((_, i) => (
        <motion.div
          key={i}
          className="absolute"
          initial={{ 
            x: Math.random() * window.innerWidth,
            y: Math.random() * window.innerHeight,
            opacity: 0.05,
            scale: 0.5,
            rotate: Math.random() * 360
          }}
          animate={{
            x: Math.random() * window.innerWidth,
            y: Math.random() * window.innerHeight,
            rotate: [null, 360],
            opacity: [0.05, 0.08, 0.05],
            scale: [0.5, 0.6, 0.5]
          }}
          transition={{
            duration: Math.random() * 20 + 20,
            repeat: Infinity,
            ease: "linear"
          }}
        >
          <img 
            src={wasteIcons[i % wasteIcons.length]} 
            alt="waste"
            className="w-16 h-16 select-none"
            style={{ filter: 'grayscale(30%) opacity(0.7)' }}
          />
        </motion.div>
      ))}
    </div>
  )
}