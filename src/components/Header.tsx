'use client'

import Link from 'next/link'
import { Menu, User, LogOut, Leaf, Sun, Moon } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { useUser } from '@auth0/nextjs-auth0/client'
import { useTheme } from 'next-themes'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'

interface HeaderProps {
  onMenuClick: () => void
  totalEarnings: number
}

const Header = ({ onMenuClick, totalEarnings }: HeaderProps) => {
  const { user } = useUser()
  const { theme, setTheme } = useTheme()

  return (
    <header className="sticky top-0 z-40 w-full border-b bg-[#3b82f6] dark:bg-blue-900">
      <div className="flex h-16 items-center justify-between px-4">
        {/* Left section: Menu button and logo */}
        <div className="flex items-center">
          <Button
            variant="ghost"
            className="lg:hidden text-white hover:bg-blue-600 dark:hover:bg-blue-800 mr-2"
            onClick={onMenuClick}
          >
            <Menu className="h-6 w-6" />
          </Button>
          <Link href="/" className="flex items-center">
            <Leaf className="h-10 w-10 text-white mr-3" />
            <span className="font-extrabold text-2xl text-white tracking-wide">
              FreeWaste
            </span>
          </Link>
        </div>

        {/* Right section: Theme toggle, points, and user menu/sign in */}
        <div className="flex items-center space-x-4">
          {user && (
            <span className="text-sm text-white hidden sm:block">
              Points: {totalEarnings}
            </span>
          )}
          <Button
            variant="ghost"
            size="icon"
            className="text-white hover:bg-blue-600 dark:hover:bg-blue-800"
            onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
          >
            {theme === 'dark' ? (
              <Sun className="h-5 w-5" />
            ) : (
              <Moon className="h-5 w-5" />
            )}
          </Button>
          {user ? (
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button
                  variant="ghost"
                  className="relative h-8 w-8 rounded-full text-white hover:bg-blue-600 dark:hover:bg-blue-800"
                >
                  <User className="h-5 w-5" />
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent className="w-56" align="end">
                <DropdownMenuItem asChild>
                  <Link href="/api/auth/logout" className="flex items-center">
                    <LogOut className="mr-2 h-4 w-4" />
                    <span>Log out</span>
                  </Link>
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          ) : (
            <Button
              asChild
              variant="outline"
              className="border-blue-600 text-blue-600 hover:bg-blue-600 hover:text-white dark:border-white dark:text-white dark:hover:bg-blue-800"
            >
              <Link href="/api/auth/login">Sign In</Link>
            </Button>
          )}
        </div>
      </div>
    </header>
  )
}

export default Header
