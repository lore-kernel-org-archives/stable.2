Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989493;
	b=hrUMdeygZ6JbSZ47HhlPmJxKNThzqMAHADrKk/OtEDoDrWJ5ObQb341rXS1YGTx4mLvb
	 YFZcDz80uKqb9OPqHTbAACwWSp1y5QEMxWmEqaj5eWU2n5sd0n74pFbv7dknViqi4TaMP
	 SS8WgprSJKqr5m/IyGhLluS7eryJUaekr/PO7vfaahiFntKKEOq/IGfipjinib6QWzOWU
	 mMlEPswkFDYwHMKe6PBDaMEyVyNdot6OVpSltLx8dXTb55ULaq9IgGtyIEkZ/3g4DlrZb
	 bhx+s0Ai9sz6Flak0Xpq0o/zEuTUtJq7jAJ1ynA7QI3BCbHOrHbvwOXFWcw1Dtg1Cpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i1EzCFQcSJtpPukvHnsNjx36ay3cgK6PTfdduzWqHsk=;
	b=18D/dukfsyS7ilTygAewzkqz99Wmf1u2G+KbsQfiyfXwzg8VxBBGHOZQyhrvdBzuhJrk
	 uEqrjFbwQ+NIzOjXr7dqDhCTMtCOx74CHJMkgPjuCM0pemhTm6JrkChN3VcFZnkf45hE9
	 03enjNEBY0FbzJabUBKIpTN1Lcff6u6Y+VXgXTfwa9z9YZRkWpU8Fm/qr7yyrPtKoj+N5
	 A/cXuaAWZx4l/Ak8NGHjuncMRSHUwcuNSbII11174QJck0aXzPtmm8dR52RWxMj7QS8CZ
	 TBh8DlKvR8680XYAC2B0nQTebUv4N+B+wwHDmkBe2dclBFTEYjUs5bCttKu4/Uz7dWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lUJ8tX0a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982F606A326;
	Fri,  6 Nov 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lUJ8tX0a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA3F1F0089F;
	Fri,  6 Nov 2026 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989493;
	bh=i1EzCFQcSJtpPukvHnsNjx36ay3cgK6PTfdduzWqHsk=;
	h=From:To:Cc:Subject:Date;
	b=lUJ8tX0amGI9S7iyX5Sg01QkJR2oCi6OGsRg4RwsRg8iO7KXeIKduDpIK8L9wDX5w
	 eczLffl/UX/Ivh+b15u2YckOFx4BOfur+0iJNT6cphFD2uyYbScJwAPrjBBLK8FEDO
	 5z9AZhaMulxW+8GJl6gbowKojJBNp/QnpPjsTXsE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.274
Date: Fri,  6 Nov 2026 13:24:49 -0500
Message-ID: <2026110650-various-fantastic-2eef@gregkh>
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

I'm announcing the release of the 5.10.274 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
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
      Linux 5.10.274

Jan Beulich (1):
      xen-netback: defer xenvif_mcast_addr_list_free()

Juergen Gross (2):
      xen-netback: Fix UAF when reading statistics data
      xen-blkback: Avoid UAF when reading I/O statistics

