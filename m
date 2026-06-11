Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4E4D2ECC
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203163; cv=none; b=HrOXXPbgCrbwqKkEfwjJmfDlrZKGyIUeYAb421rDaUOtEFAGzToqIb6gQb9matfOtec94OjTHpbzjJeW4ABZqox3pp5FZka1BZvXSJCiBCVuPtqbVjXp4ydbrfljbVLPYrskgqRescdlEVoGBUeHo2j3gUerKvBIXuej9G7tFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203163; c=relaxed/simple;
	bh=umO5DFW5EcWoAgilQ2RtuVGrb6J99JQZBfqeOfDjBhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7aRpphFn6K5HVyDSb8kazqugYiFhws/SCvtfio5gea6MBp6pdVLk9I/3J8E4T8vXYqwr6OADPUcV1VytZp04yRv4J39dUS3o1PaTymvJ9M9/QuFILu1ku3wyOif390KPrUnm9cYoACgfNGXTIuOryP2G7qopqlaR2IJhdO1o6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I7RdgEet; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I7RdgEet"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 712A120B7167; Thu, 11 Jun 2026 11:39:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 712A120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781203143;
	bh=GU4z/IiDEL3THNKz/dG9OMy+D0d55stkPSMejtG0Jho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7RdgEetfOcOB1k+ypB4y18dL0vHpfgfkKnI2F2sG+8+Ezgxp8xWXw1RI+5nYaVy3
	 NM7Lf4XgeLkKVdmrdCpJjwoFvkv5vys+AWlaCmDa5DhB+HWRsiTdblrwJxa/qGUco2
	 np0C6of2lN1qNFE6atfkplkMINv7MFhl0V45MiUw=
Date: Thu, 11 Jun 2026 14:39:03 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, stable@vger.kernel.org,
	xfs-stable@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Message-ID: <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250322143418.216654-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322143418.216654-1-pchelkin@ispras.ru>

On Sat, Mar 22, 2025 at 05:34:11PM +0300, Fedor Pchelkin wrote:
> Incomplete backport of series "xfs: log intent item recovery should
> reconstruct defer work state" [1] leads to a kernel crash during the
> xfs/235 test execution on top of 6.6.y stable.
> 
> Tested (briefly) with my local xfstests setup. Additional testing would
> be much appreciated.

Any idea what happened to this series? It resolves an issue that I've
hit in a production environment FWIW.

Series is:

Tested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> 
> [1]: https://lore.kernel.org/linux-xfs/170191741007.1195961.10092536809136830257.stg-ugh@frogsfrogsfrogs/
> 
>  XFS (loop1): Corruption of in-memory data (0x8) detected at xfs_trans_cancel+0x4d9/0x610 (fs/xfs/xfs_trans.c:1097).  Shutting down filesystem.
>  XFS (loop1): Please unmount the filesystem and rectify the problem(s)
>  general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>  CPU: 1 PID: 2011 Comm: mount Not tainted 6.6.84-rc2+ #12
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
>  RIP: 0010:xlog_recover_cancel_intents+0xad/0x1b0
>  Call Trace:
>   <TASK>
>   xlog_recover_finish+0x7f6/0x9a0
>   xfs_log_mount_finish+0x386/0x650
>   xfs_mountfs+0x1405/0x1fb0
>   xfs_fs_fill_super+0x11d6/0x1ca0
>   get_tree_bdev+0x3b4/0x650
>   vfs_get_tree+0x92/0x370
>   path_mount+0x13b9/0x1f10
>   __x64_sys_mount+0x286/0x310
>   do_syscall_64+0x39/0x90
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>   </TASK>
>  Modules linked in:
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:xlog_recover_cancel_intents+0xad/0x1b0
> 
> 
> Link to the original bug report [2].
> 
> [2]: https://lore.kernel.org/stable/6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg/
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Darrick J. Wong (4):
>   xfs: recreate work items when recovering intent items
>   xfs: dump the recovered xattri log item if corruption happens
>   xfs: use xfs_defer_finish_one to finish recovered work items
>   xfs: move ->iop_recover to xfs_defer_op_type
> 
>  fs/xfs/libxfs/xfs_defer.c       |  22 ++++-
>  fs/xfs/libxfs/xfs_defer.h       |  14 +++
>  fs/xfs/libxfs/xfs_log_recover.h |   4 +-
>  fs/xfs/xfs_attr_item.c          | 115 ++++++++++++------------
>  fs/xfs/xfs_bmap_item.c          |  92 ++++++++++---------
>  fs/xfs/xfs_extfree_item.c       | 117 +++++++++++--------------
>  fs/xfs/xfs_log_recover.c        |  37 ++++----
>  fs/xfs/xfs_refcount_item.c      | 127 +++++++++------------------
>  fs/xfs/xfs_rmap_item.c          | 151 ++++++++++++++++----------------
>  fs/xfs/xfs_trans.h              |   4 -
>  10 files changed, 326 insertions(+), 357 deletions(-)
> 
> -- 
> 2.49.0
> 
