'use client'

import Link from "next/link"
import { usePathname } from 'next/navigation'
import { Button } from "@/components/ui/button"
import { MapPin, Trash, Coins, Medal, Settings, Home } from "lucide-react"

const sidebarItems = [
  { href: "/", icon: Home, label: "Home" },
  { href: "/report", icon: MapPin, label: "Report Waste" },
  { href: "/collect", icon: Trash, label: "Collect Waste" },
  { href: "/rewards", icon: Coins, label: "Rewards" },
  { href: "/leaderboard", icon: Medal, label: "Leaderboard" },
]

interface SidebarProps {
  open: boolean
}

export default function Sidebar({ open }: SidebarProps) {
  const pathname = usePathname()

  return (
    <aside className={`fixed inset-y-0 left-0 z-30 w-64 bg-white dark:bg-gray-800 border-r border-gray-200 dark:border-gray-700 transform transition-transform duration-300 ease-in-out lg:translate-x-0 ${open ? 'translate-x-0' : '-translate-x-full'}`}>
      <div className="flex flex-col h-full pt-16">
        <nav className="flex-1 px-4 py-6 space-y-2">
          {sidebarItems.map((item) => (
            <Link key={item.href} href={item.href} passHref>
              <Button 
                variant={pathname === item.href ? "secondary" : "ghost"}
                className={`w-full justify-start ${
                  pathname === item.href 
                    ? "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-100" 
                    : "text-gray-600 dark:text-gray-300 hover:bg-blue-50 dark:hover:bg-blue-900/50"
                }`} 
              >
                <item.icon className={`mr-3 h-5 w-5 ${
                  pathname === item.href 
                    ? "text-blue-600 dark:text-blue-400"
                    : "text-gray-500 dark:text-gray-400"
                }`} />
                <span className="text-base">{item.label}</span>
              </Button>
            </Link>
          ))}
        </nav>
        <div className="p-4 border-t border-gray-200 dark:border-gray-700">
          <Link href="/settings" passHref>
            <Button 
              variant={pathname === "/settings" ? "secondary" : "ghost"}
              className={`w-full justify-start ${
                pathname === "/settings"
                  ? "bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-100"
                  : "text-gray-600 dark:text-gray-300 hover:bg-blue-50 dark:hover:bg-blue-900/50"
              }`} 
            >
              <Settings className={`mr-3 h-5 w-5 ${
                pathname === "/settings"
                  ? "text-blue-600 dark:text-blue-400"
                  : "text-gray-500 dark:text-gray-400"
              }`} />
              <span className="text-base">Settings</span>
            </Button>
          </Link>
        </div>
      </div>
    </aside>
  )
}