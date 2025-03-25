'use client'
import { motion } from 'framer-motion'

const wasteIcons = [
  {
    src: 'https://img.icons8.com/color/96/000000/recycle-bin.png',
    label: 'Recycle Bin'
  },
  {
    src: 'https://img.icons8.com/color/96/000000/plastic-bottle.png',
    label: 'Plastic Bottle'
  },
  {
    src: 'https://img.icons8.com/color/96/000000/paper-waste.png',
    label: 'Paper Waste'
  },
  {
    src: 'https://img.icons8.com/color/96/000000/tin-can.png',
    label: 'Metal Can'
  },
  {
    src: 'https://img.icons8.com/color/96/000000/glass-bottle.png',
    label: 'Glass Bottle'
  }
]

export function WasteIcons({ className = '' }: { className?: string }) {
  return (
    <div className={`flex flex-wrap gap-4 justify-center ${className}`}>
      {wasteIcons.map((icon, i) => (
        <motion.div
          key={i}
          initial={{ scale: 0, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          transition={{ delay: i * 0.1 }}
          className="flex flex-col items-center"
        >
          <motion.div
            whileHover={{ scale: 1.1, rotate: 5 }}
            whileTap={{ scale: 0.95 }}
            className="p-4 bg-white rounded-2xl shadow-lg"
          >
            <img src={icon.src} alt={icon.label} className="w-16 h-16" />
          </motion.div>
          <span className="mt-2 text-sm text-gray-600">{icon.label}</span>
        </motion.div>
      ))}
    </div>
  )
}