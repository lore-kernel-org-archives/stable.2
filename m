Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779869;
	b=zkUvMR5zjndO+lj4TGKiPnp2QwoSeJF6Tvfn5Xna/0y/Wp/3RJUTdopAyMB5E+y5sl9T
	 H5sPpT+l9XEAmsOeG9I/W/ICPD6UY4JeHWSWgUI1iexeia2ANBsW3ANa53lSUa+dPpVmQ
	 hXmokmgVdNCx/hPZlvk46+IFjEve3j2dd1zKgR+AEfet8UufjzzNECBZAhvRtY+twJBIX
	 xMktal7bsrQcZLvFcb8olGxWYBCeKPgi6/NFlEcsO8snlQBbyMnCozcD08GlJdRuyJwSe
	 Sivb4Y5rT9AJosII0c4jyjTPykY7vuSk4tGrtR/HbpIUfo+2+hRFxiONc7hzyMJvOcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779869;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=no8c1akp7ulgV2WRnZedT63d3z/z/BLscoYXpWIfqEU=;
	b=CA5jBSDDlcrJeutvmrQQITgh8chNElHcEUgiZbciVDiwL0vlxZsrebQ8mwiZWG5sm7Oa
	 bWn7jZcFSBYgDL4vlzIDjSjznID9QOKYVyhrMoHwGQRjMqr1UfAX1wvPYXbiBAMQh/F93
	 lemuMdPwkRV/RlGi5oOi7oaoYNFyWgeOOwPa4of/SDQVFqYVoy9RDyon5Szi1cZbuBK0J
	 dgGrh0cd3ti6+w1u5oJfRqHC+OTp9b+0BvuO3/YR/qWZHk52WlLU/ZkXIP3Ck62iwteRA
	 iCuwj1n9Ze2mJ5auOX3qH92sRiIdunaVKCshE3+hDjqx93LbrzY6Ez2o24gAEVJVYxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=mjELGUmC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61390606A31A;
	Fri, 23 Oct 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=mjELGUmC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E9B1F01828;
	Fri, 23 Oct 2026 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792779869;
	bh=no8c1akp7ulgV2WRnZedT63d3z/z/BLscoYXpWIfqEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mjELGUmCidvCP5m5Pcw9owT1y+bk/0RqFxk+cTyF0zMqtdEYxzQjFUj6mz8yVLr08
	 /wdKz7PBXBIwaKMES+empFipHDE6CzTiguLZOfSO/UXz7v6d1yYcxXbWnom8DfNCZD
	 6wMg+JYi+R3DChrjRi3mJ99AI+t2dzu5mIpOZEns=
Date: Fri, 23 Oct 2026 11:24:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: linux-mm@kvack.org, liam@infradead.org, ljs@kernel.org,
 vbabka@kernel.org, jannh@google.com, pfalcato@suse.de, usama.anjum@arm.com,
 avagin@gmail.com, mirq-linux@rere.qmqm.pl, arnd@arndb.de,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: return -ENOTTY for unknown pagemap
 ioctls
Message-Id: <20261023112428.c7a84bfb2d9005e5070da38d@linux-foundation.org>
In-Reply-To: <20261023181300.3366487-1-hengyul@cs.unc.edu>
References: <20261023181300.3366487-1-hengyul@cs.unc.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 14:13:00 -0400 Hengyu Liang <hengyul@cs.unc.edu> wrote:

> Commit 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
> optionally clear info about PTEs") made do_pagemap_cmd() the ioctl
> handler of /proc/<pid>/pagemap.
> 
> However, do_pagemap_cmd() returns -EINVAL for every command other than
> PAGEMAP_SCAN. Before that commit, pagemap had no ioctl handler, and
> the VFS returned -ENOTTY for these commands. As of now, they fail with
> EINVAL, so tcgetattr() and isatty() on pagemap report EINVAL instead
> of ENOTTY.
> 
> The issue can be reproduced with a simple C program:
> 
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <termios.h>
> 
>     int main(void)
>     {
>             struct termios t;
>             int fd = open("/proc/self/pagemap", O_RDONLY);
> 
>             if (tcgetattr(fd, &t) < 0)
>                     perror("tcgetattr");
>             return 0;
>     }
> 
> Before that commit, the result is:
> 
>     tcgetattr: Inappropriate ioctl for device
> 
> After that commit, the result is:
> 
>     tcgetattr: Invalid argument
> 
> This patch will return -ENOIOCTLCMD for unknown commands, as
> procfs_procmap_ioctl() in the same file does, so that the VFS turns it
> into -ENOTTY.

OK, thanks, annoying.

> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")

Three years ago.  So if anyone had to update their userspace code
because we altered this, they will now need to unupdate it.  It's hard
to believe that this will cause significant harm - perhaps there are
correctness test suites which will be surprised (again).

> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Unknown commands should fail with ENOTTY: Documentation/driver-api/
> ioctl.rst says so and calls -EINVAL wrong, and POSIX requires
> tcgetattr() to fail with ENOTTY on a file that is not a terminal.
> 
> I found no user space that relies on EINVAL here: Wine and the mm and
> kvm selftests only use PAGEMAP_SCAN on pagemap, whose results do not
> change, and CRIU and LTP only read the file.

Good info, thanks.


