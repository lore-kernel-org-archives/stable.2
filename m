Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989525;
	b=xDRFnYheSiH+qXYjeVZhjly9Bp52EYptSHEngEjD3xzmm7kyRC3LGQP7Jhi3VaULWc3l
	 XTI8I/e6bjiF21xjIWUnhcM/TZCluB/UuzmlGou58PvfOpgrqqFYVwzLboYXDXxbHbh6Z
	 Nqs6ZORS6fYNPRCSkG88+x+jVvTuc7te9YlSEp3KacCQpJV6APRHvQJJ8Abk6KST2w61h
	 GHUilI1a7/U+YfYu9aZZCVaPLbzTxLvNrfJuuei5/lKzGdibnXOHC1/lgtn/XQZkr6lhR
	 9pxIdzY5WArTa0pHC0mDjWGMqNku/YuHyYhAxK9fzoGHDVpeCtE0QsTmYYLrUFKM9KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Jh5MLz+bY+59CpwRbCWQPvmTC+S9pK7GG6Py5O5BuIQ=;
	b=E2RsjLa3TDYj2ARECLEaFCxrZ1sK5WhVMZkCFSsHeUBeG43g5bN1PlEEX+kjy8s4ozPa
	 fT5PE7hL0FqpArTF/YfOVLFvKqtwW8+dOaAvoZUm7Rp8BaoRA9kPIdkuuBRtonpKbJf6V
	 kHRbxfjG8b5SbrpqUnFJ6M6fkE/9No561KHN0xIdyXTnD/Yr51GXRV3jZ1EjU2aO7lOwV
	 g+91bs+DY9DlcokZTLc+W9A33ZqzgC17TY2GIZDipyhOOtTnu7kR1WjtHMd43XPSFWPD2
	 D14O4uxV137gQfkiYX7v6xrgRvOkruVKpRqR7icpRcaoqVEECqvZZzYYu5MA7NuliEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="v/fGY97k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96B606D81B;
	Fri,  6 Nov 2026 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v/fGY97k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A641F008A7;
	Fri,  6 Nov 2026 18:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989524;
	bh=Jh5MLz+bY+59CpwRbCWQPvmTC+S9pK7GG6Py5O5BuIQ=;
	h=From:To:Cc:Subject:Date;
	b=v/fGY97kSF0N3rhXH8l1PrhQbhSX/orXyROUXdQtsSAPs650Q7VYM8vf6ob8CbM8l
	 QLGpq+9yyxuqVXOo2CSFPM4Y4LIlZIp3phH7aDK3GFdR1OKfsU8D6xgrusWXoWm+fH
	 gMV0HMhxZfg8uH6E/zIQR1CgfN54sUJ1Z74jrDjE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.62
Date: Fri,  6 Nov 2026 13:25:21 -0500
Message-ID: <2026110622-bannister-strum-60e5@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.62 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                            |    2 +-
 drivers/block/xen-blkback/common.h  |    2 ++
 drivers/block/xen-blkback/xenbus.c  |   31 ++++++++++++++++++++++++-------
 drivers/net/xen-netback/interface.c |    2 --
 drivers/net/xen-netback/xenbus.c    |    3 +++
 5 files changed, 30 insertions(+), 10 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.18.62

Jan Beulich (1):
      xen-netback: defer xenvif_mcast_addr_list_free()

Juergen Gross (2):
      xen-netback: Fix UAF when reading statistics data
      xen-blkback: Avoid UAF when reading I/O statistics

