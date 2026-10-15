Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FB54CF42;
	Thu, 15 Oct 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066923; cv=none; b=snItt7HMukV7ucr4fUrwl6dJOs3oFbgOxeaHmE+GUamn+J3UevcuK5vCyNO0e/36FyIfkfRgLm898XPKegBO9INjgouVAFGaLDL95011JEpxfVtXWNprhnwP7yPNQMJdJJq117ytxdt0NnrLs95sQQ381DXU2djVebGHB2BQ8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066923; c=relaxed/simple;
	bh=xygXq2x8twPyAOXIdlkeJZxk4SSwiJA7jUJreHh3XFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3BB8rSq2PoYqoeFs+LGxzJaVGhyDJboUlPWIJ45LFsMghfXLwaOVfjI4S3jkuwrVpna8V8G9qlQ2JIZ29vzwgHsBW9NuVTkDn5V7f9n96T4mM+VuhPG+ocObOKG6ZYes2Zg1kYGA20WG7CLwRB+ZT1SsL8yeQRkFLcE/k3IKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2pjmAAU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2pjmAAU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169021F000C9;
	Thu, 15 Oct 2026 12:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792066922;
	bh=V3nexE/wxoqo2RsoOATvcJjTF5iHEuj3mQjOpVMp21Q=;
	h=From:To:Cc:Subject:Date;
	b=2pjmAAU5R6Lauzgcfbz9OlO78VgRAXHzBNBXiYyNWM+1ZYuhNqNyE3bSqrn9gTTAn
	 0PXAepc+J7GsZZrqMHZERjdvadWDrLuO3pzT8VVtFoHYu0BvQiA7eIokLjhoa+BOXv
	 u3tyElJYYGY1qj/RoFrsPVYJUSd0ApZUYmbkKxxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.159
Date: Thu, 15 Oct 2026 14:22:02 +0200
Message-ID: <2026101503-giggly-nerd-6be4@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.159 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                   |    2 +-
 include/net/ip.h                           |    7 +++++++
 net/bridge/netfilter/nf_conntrack_bridge.c |   10 +++++++---
 net/core/dev.c                             |    1 +
 net/ipv4/af_inet.c                         |    2 +-
 net/ipv4/ip_output.c                       |   10 +++++++---
 net/ipv4/tcp_ipv4.c                        |    2 +-
 net/netfilter/nfnetlink_queue.c            |   19 +++++++++++++++++--
 net/netfilter/xt_CHECKSUM.c                |    6 +++++-
 net/xfrm/xfrm_output.c                     |   16 +++++++++++-----
 10 files changed, 58 insertions(+), 17 deletions(-)

Antonio Ojea (1):
      netfilter: nfnetlink_queue: unbreak SCTP traffic

Eric Dumazet (1):
      ipv4: free inet_opt and ireq_opt after an RCU grace period

Greg Kroah-Hartman (1):
      Linux 6.6.159

Michael S. Tsirkin (1):
      ipv4: validate checksum_start before completing checksum

