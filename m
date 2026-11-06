Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989533;
	b=Axg++O2qOVlSB1eDG9H8sfVldBKmCF5OOdKvbl5xmqmM+V7Kbm05Ak/I163DOH1/zALO
	 zC/l3eCN6RYRv3m1gngDixYxDEi9cx8OIdXtV9Pvh4g1ERBDDtrh7EE6evI8WOayYZQxE
	 D8P3/shyka/yliBsq2+L+n20EgHo5s+gYmOm5p6rN33lsXnpV+wBA2KX/oUh4u1WnEsJy
	 gtzCH/o7WjO1R+Ae8fki5mBJLoZXjncCnwTmRe+HhlpXGsgNSbQ2xs9ViWfyQVKgwMAE/
	 wRNcV/vcojI+FqY02V5JZsdcvt5N4+PNluh1vf9XiYStiUXLZi6wShxnS0BdyeQGLRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=liRlphP909/9LGFQW2WTMp0igXNso05hRMn9+pkhp7Q=;
	b=XaF/ri74B1ODJu8m8T/iw0FVr8QAFOpwLv5DNvBXsG45N2QSYyjPLqJUPZLd4jlVf9+5
	 +rY27kCOa2vxTrxP5y0TrGQiyAySAFBg5IQjqN5pCO4k7S3wlVe2xtlOK6+4undJPuS3C
	 OD+MJgMqWlqgHjoRkm9c+9TXr0LjuCmlJS2QYcpqeE2P/tXWcn2P1hDTEMk4V6u445w4C
	 2h0F8QbSQkdG6Vbw2ctLZaxq5H+qRdVhXU+Uuh0eaFO9+q1MpqJcpH7c0AMTn9vKQKKMy
	 tDGgWYIuAug7JTjADUJAH8avI8ADZAozwbpvK/+G1VAiIo1JdxqEVu2rkXqC1XWVlAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="1jva/ufh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A8606A339;
	Fri,  6 Nov 2026 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1jva/ufh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B63B1F0089F;
	Fri,  6 Nov 2026 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989532;
	bh=liRlphP909/9LGFQW2WTMp0igXNso05hRMn9+pkhp7Q=;
	h=From:To:Cc:Subject:Date;
	b=1jva/ufhvTzYigL+s13xaZN49VkqQtstJTL0YeLhlZHGZJEETqk/9eg0QCiCYqqVR
	 7KXUQwC1mSVhUlBXVnX31eCY+ZGWxFQHBb/Eg343zo8Wvm/cHaFNmkxbILJoAQelv2
	 CUcOnJ4VWTNEOVgfSZPlO8vjhfVPA1GiwICt5+dY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.3.3
Date: Fri,  6 Nov 2026 13:25:28 -0500
Message-ID: <2026110628-entertain-crier-14aa@gregkh>
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

I'm announcing the release of the 7.3.3 kernel.

All users of the 7.3 kernel series must upgrade.

The updated 7.3.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.3.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                            |    2 +-
 drivers/block/xen-blkback/common.h  |    2 ++
 drivers/block/xen-blkback/xenbus.c  |   30 ++++++++++++++++++++++++------
 drivers/net/xen-netback/interface.c |    2 --
 drivers/net/xen-netback/xenbus.c    |    3 +++
 5 files changed, 30 insertions(+), 9 deletions(-)

Greg Kroah-Hartman (1):
      Linux 7.3.3

Jan Beulich (1):
      xen-netback: defer xenvif_mcast_addr_list_free()

Juergen Gross (2):
      xen-netback: Fix UAF when reading statistics data
      xen-blkback: Avoid UAF when reading I/O statistics

