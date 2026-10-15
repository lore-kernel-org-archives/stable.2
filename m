Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF952BE34;
	Thu, 15 Oct 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066911; cv=none; b=DG0OZaliHqbPMlaYBIFjk+Zp+N8zp9wZX7o//CvJSsVrcyHsYUHsWFmlpdD6YN86Ixz1b4XkJkIwsmaDZD3urX9vhs2Dae0MCdmvbco349HwT/x0RHKrVasqImLvlDq2D0Y57R5tHyd3PR0U9oyqF2iCLMvnv9IWtYmbyuk+ams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066911; c=relaxed/simple;
	bh=HiFzXAr8ojRsSV2FVk3GIgzcLddfIKTgI847JZYLEHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Td08pWbynENaaCDdrPK6NOitL6+jV0hFVbx+ZKK+iD7ISy2Nfs4S1HmpUvdTbbvs0TPHg0Xg3w/8cT2OaEcK/GsKL5Nqe3Yhv4gluGbOO2xWsmlsQxvL8Slw6JxIZOCcUDileaeVyounOAjrDuZDon7uFp2hfx0kSljMQN1GBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sj1mvl7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sj1mvl7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADB91F000C6;
	Thu, 15 Oct 2026 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792066909;
	bh=Vgq8qdVf/UcIXUZQmRrqxnwBcmINhFgKn0aY0V4EQQc=;
	h=From:To:Cc:Subject:Date;
	b=Sj1mvl7whqM3tIXGvMJ0Y75/jlI+l7czpf9pOrdBGNkmedz4v18yIw7EXqxf89JMi
	 w9RiAM2BDgTfxMQRIfktuHscoM/IHt2jkHw+W67D8JSIymRGKXVEky8aWmJYZkI+OL
	 D/rQ6KYfLSxdcyqm9glvm2LtpQMldHfXlpTeBRPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.223
Date: Thu, 15 Oct 2026 14:21:49 +0200
Message-ID: <2026101550-fifteen-symptom-216d@gregkh>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.223 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
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
      Linux 5.15.223

Michael S. Tsirkin (1):
      ipv4: validate checksum_start before completing checksum

