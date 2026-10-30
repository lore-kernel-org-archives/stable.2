Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324420;
	b=yZiUp39lX3MYs8TkJI7OuVSNsxHBFa5iNWXdDTbGPk5bPuAM6DlFlswGG6a3Kc9TOW45
	 TjYONbrUFCk1uoGXORUpke4I4gt9VVIkG5AATSZdThannMNIGZR3pNl8ODUH8TGeOD5yr
	 T+WYUSN5Yf1icB31X+XPVkt/e7wZLgigMzh1j1I6KzclZCg4iJIQ7v7bk6uh5/KkoCa+F
	 cSsSkX42oZQ2lEayKXrFCJGQtTnv530P4bFLcKGgQXoGgxf+uAUW37P+jbYIiQZEnuywK
	 jGhBau2FpMv8vjqM3hpYPoEFaR7orNR2aaK7Pw5KEZuq2IQ1Y1PRdPEAmwxduAp7rXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324420;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VEkXJPVCGMQj6Y/n87EANQzozi9+FFWXoXie9y/WXBU=;
	b=gvWVr7mOVKVZW7eZfyplVBCh3vnksoaG4Fjtam2AhrJLU6+7s8n+DwEktVEsMoJjLbSw
	 YYJ4wbF3nd6g2d1MS69W/Ol1P6yDjDwQmtL46UNYg0T4K2116av53pfMQ+zwPr1zxSwzM
	 qvOdnNlm2/s0KLlwiJXwwUEe2vgchRZVVLP+k0oywERmu8fxT+BAZ4asRXXPenyj+frEU
	 Y/Bs3LqnnCp/iimm+LiPO33vipI3370GFGjHFEoZ2Lonb3XwoqoRph+EDg+c4Thjo1wM6
	 8PimkhzQtVYROSnoG6yOrfzFiLa+t7Eiank6iDgmU5j+bm4WTSgkZnVSKqhH89CDbHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YRy4MZ9A;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1F606A31A;
	Fri, 30 Oct 2026 01:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC1F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YRy4MZ9A
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793324410; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VEkXJPVCGMQj6Y/n87EANQzozi9+FFWXoXie9y/WXBU=;
	b=YRy4MZ9AWLG4IoKeOf4xW31dMSLGsY8LrPtYNwQoAcpJIdP0GXJdRFRKRs+QYuQbN4Czl6cQ1W8KDx6K4B4kxG1A+7hS1DwtTrSRN1GB/ON9HRQkFiUH9pE8J448ykbjWtILHFj0yiXgFrDlFZaF2iMtCyKsJnDX0HCryGoQA+8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDkd91f_1793324409;
Received: from 30.221.129.214(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XDkd91f_1793324409 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Oct 2026 09:40:09 +0800
Message-ID: <01d0b4dd-1bd0-4006-a721-92566113c82c@linux.alibaba.com>
Date: Fri, 30 Oct 2026 09:40:09 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] ocfs2: add fl->fl_type check in ocfs2_flock() to fix
 use-after-free in lock_get_status
To: Alexey Velichayshiy <a.velichayshiy@ispras.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20261029232633.165310-1-a.velichayshiy@ispras.ru>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261029232633.165310-1-a.velichayshiy@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/26 7:26 AM, Alexey Velichayshiy wrote:
> No upstream commit exists for this patch.
> 
> The KASAN-reported issue described below is no longer reproduced after
> upstream commit f7e33bdbd6d1 ("fs: remove mandatory file locking support"),
> but that commit removes kernel functionality altogether and is therefore
> not suitable for stable branches.
> 
> In ocfs2_flock() the __mandatory_lock(inode) check is performed without
> taking the lock type into account. In the reproducer an FLOCK is first
> taken on the file while its mode is 0100755, so the inode is not
> mandatory-locked yet. Then chmod() changes the mode to 0106743 (S_ISGID
> set, S_IXGRP cleared), which makes the inode mandatory-locked. Finally,
> close() triggers a repeated call into ocfs2_flock() with
> fl_type = F_UNLCK (0x2) and fl_flags = 0x42 to release the lock. By that
> point __mandatory_lock() returns true, so the call is rejected
> with -ENOLCK before reaching the unlock path. The FLOCK lock is therefore
> left leaked (as reported by "Leaked FLOCK lock ..."), and a later read of
> /proc/locks dereferences the already freed inode in lock_get_status(),
> producing the use-after-free.
> 
> ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
> Leaked FLOCK lock on dev=0x7:0x0 ino=0x4322  fl_owner=00000000d09f0d4d fl_flags=0x2 fl_type=0x1 fl_pid=1111
> ==================================================================
> BUG: KASAN: use-after-free in lock_get_status+0x947/0x9e0 fs/locks.c:2930
> 
> CPU: 2 PID: 1116 Comm: syz-executor141 Not tainted 5.10.260-syzkaller #0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x167 lib/dump_stack.c:118
>  print_address_description.constprop.0+0x1c/0x220 mm/kasan/report.c:377
>  __kasan_report mm/kasan/report.c:537 [inline]
>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:554
>  file_inode include/linux/fs.h:1343 [inline]
>  lock_get_status+0x947/0x9e0 fs/locks.c:2930
>  locks_show+0x178/0x270 fs/locks.c:3005
>  seq_read_iter+0x50e/0x1230 fs/seq_file.c:230
>  proc_reg_read_iter+0x20a/0x2e0 fs/proc/inode.c:310
>  call_read_iter include/linux/fs.h:2042 [inline]
>  do_iter_readv_writev+0x574/0x750 fs/read_write.c:738
>  do_iter_read+0x2fc/0x760 fs/read_write.c:801
>  vfs_readv+0xf0/0x160 fs/read_write.c:921
>  do_preadv fs/read_write.c:1013 [inline]
>  __do_sys_preadv fs/read_write.c:1063 [inline]
>  __se_sys_preadv fs/read_write.c:1058 [inline]
>  __x64_sys_preadv+0x235/0x310 fs/read_write.c:1058
>  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> 
> Following the pattern used by other __mandatory_lock() call sites (in
> particular, the changes made for ocfs2_lock() in commit ee860b6a6503
> ("[PATCH] Skip check for mandatory locks when unlocking")), add
> a lock-type check to ocfs2_flock(). With the patch applied, the KASAN
> report is no longer reproduced.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 53fc622b9e82 ("[PATCH 2/2] ocfs2: cluster aware flock()")
> Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/locks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
> index 7edc4e5c7c2c..1712f99ed120 100644
> --- a/fs/ocfs2/locks.c
> +++ b/fs/ocfs2/locks.c
> @@ -103,7 +103,7 @@ int ocfs2_flock(struct file *file, int cmd, struct file_lock *fl)
>  
>  	if (!(fl->fl_flags & FL_FLOCK))
>  		return -ENOLCK;
> -	if (__mandatory_lock(inode))
> +	if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
>  		return -ENOLCK;
>  
>  	if ((osb->s_mount_opt & OCFS2_MOUNT_LOCALFLOCKS) ||

