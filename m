Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239874A6CD5
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344793; cv=none; b=rxxMg2iMhZSOx6I/xOtCcrt2iA0NjD2HgnpFuDBI+wKI/i0ZfHdpjbtEXRJbv6LycL/7inNuWeEjoPLu09JfQVyglh8t6/fN5Mqendit+hq4hXUFfclwB+3HE3i1OWMTwcF+A7cbmicmZcSc2iYI8Z110EibBfRUzEPTlWiFQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344793; c=relaxed/simple;
	bh=rxgqcxMBzyiCaShIe6oKqSQwEXJpXEvJGCpXStURPY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t2xpl3pMDnepYEwdLd1BYvCFIVn8a51cjZQLSZHf7wpdNE0zmzBgkIZeVFdICXSd2OowQUVUMyoAdITKwDO1do9ky9WJ67pi0zwsP25Z65mocS3GMYhpDGwK6+2j3O9Jlyjzxhz6n+fz5laEUQO9U8naSGZ9kLYTCuypq0zDbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ayToTLTg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ayToTLTg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DBA8D1A101D;
	Fri, 25 Sep 2026 13:59:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD9D46073B;
	Fri, 25 Sep 2026 13:59:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00A77103293B6;
	Fri, 25 Sep 2026 15:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790344783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=XS8Dc0EYvbktyBpK0cidB0SJsr+eMfdYCTUgJ32Ne9E=;
	b=ayToTLTgy2T2GLhsJemTzmA4zW9w+BidfcpCFU68eFsTsQ5wkby7iOuBP6o+NPDzvHsvpm
	KhZHeVkRTwkiA5wcXlVBQGmyiBWktzkb4FXH+dvUe0VWvyrdUeswvmZBtsxLVPCsw+/ESh
	thbhBvhe0ztRpQtr1vGaPT0+iM7HoSXwlMAFupH6SBVkVhx4/DoEh37eamffvn+/Lhpz8l
	8E5J1K+xrJnZHdOUZGgKyAV9nvE006doTyOGr5Ys1RjF7sy3jF/037kRGKI63Og9zjdils
	ioMVV3sGgySJmlxx1nnOspCOWPs2uPOiDRDMjgVF9wIXvzm/djhMk9v5kNNEsw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net v2 0/3] net: macb: fix close races (and RX refill error
 handling)
Date: Fri, 25 Sep 2026 15:59:33 +0200
Message-Id: <20260925-macb-close-v2-0-360efa565914@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBREr2L+2pq2KLauvIdhwW8/UgOtaSvRE
 O4u4MpElzOZ92aERNFRgtNmhEiDSy74OcjtBkxb+ysxZ+cMksuSa6FYXxtkpguJmEW0ssA9qkb
 CDNwjNe65yi7gKUP1KdMDb2TyollmrUs5xNd6OYh1/Ms+CMaZlMJqUeJRl+KMIeTO+Z0J/eL5C
 /EDFdKQVkoUX1A1TdMbvigzrfIAAAA=
X-Change-ID: 20260918-macb-close-dbbd23b4b8f2
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Antoine Tenart <atenart@kernel.org>, Eric Dumazet <edumazet@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

The context-swapping series [0] has been ongoing for a while. The most
interesting part is a proper hardware shutdown sequence, which is truly
lacking in other parts of the MACB driver: at close, at suspend and in
the HRESP error task.

Instead of introducing that sequence for a new feature, apply it now to
fix the main offender, the close path. That fixes the races listed in
patch 3 and will allow the sequence to be reused later.

The first two patches are also fixes, but not related to the shutdown
sequence: they address allocation-failure codepaths. They are sent
alongside patch 3 because they touch the same code and would cause
merge conflicts if applied separately.

Now, let me list issues I'm aware of that we do *not* fix here, to make
the scope explicit:
 - HRESP task should sync with all other contexts. It frees buffers
   under the feet of the whole driver. The hardware shutdown sequence
   will help.
 - Suspend callback is also racy with BH primitives. We'll be able to
   reuse the hardware shutdown sequence.
 - Even if we assume tasks are frozen, the phylink ops aren't and might
   trigger between suspend and resume callbacks. Here we need to
   (1) early return in phylink ops and (2) at resume put the HW in its
   proper state according to phylink ops that occured.
 - Alloc failure codepaths aren't perfect outside open. Hardware and
   ring buffers are left in a sad state. We can probably do better.

[0]: https://lore.kernel.org/all/20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com/

---
Changes in v2:
- P1: ensure gem_rx() and macb_rx_pending() don't consume the
  descriptors where alloc failed.
- P2: gem_rx_refill() now only propagates an error if zero descriptors
  are ready. We tolerate partial refill hoping the next one will help.
- P2: we do *NOT* fix the set_ringparam codepath reported by Sashiko.
  Proper implementation will come with context swapping which will
  reuse the infra put in place in P3.
- P3: the hresp_err_bh_work/tx_lpi_work Sashiko-reported race has been
  fixed in a standalone, *NOT* here.
  https://lore.kernel.org/netdev/20260925-macb-netdev-register-race-v1-1-752f90ce1c39@bootlin.com/
- Take 2x Reviewed-by: Nicolai.
- Rebase onto latest net/main (11536ee3d3e0), nothing to report.
- Link to v1: https://patch.msgid.link/20260918-macb-close-v1-0-05e32ce98813@bootlin.com
- Nicolai's v1 reviews (duplicate thread):
  https://patch.msgid.link/20260918-macb-close-v1-0-221d916b7961@bootlin.com

To: Conor Dooley <conor.dooley@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
To: Antoine Tenart <atenart@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

---
Théo Lebrun (3):
      net: macb: never give hardware a NULL RX buffer
      net: macb: propagate RX ring refill errors
      net: macb: quiesce IRQs and drain BH on interface close

 drivers/net/ethernet/cadence/macb.h      |   7 +-
 drivers/net/ethernet/cadence/macb_main.c | 133 ++++++++++++++++++++++++-------
 2 files changed, 112 insertions(+), 28 deletions(-)
---
base-commit: 7c416e8f8423e6fe9b48e0b9c174bd902789f8db
change-id: 20260918-macb-close-dbbd23b4b8f2

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

