Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10151DAF6;
	Fri, 18 Sep 2026 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763542; cv=none; b=NQ/R7k6oZY50pDFkMcO4y8Zmzkzv2LiSd8MznZWmH7sxwC3xyXe95WlQH8s95+304RB/qEYXGE4+jeesTsdCIS1xWnPpKy5mH45b87wYi1VOT8ojc6sPOTJFnMLXKG2brNsAsVOgbpw7KA8hKm2F2yAsVBZ1sHbWksv8UT2NROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763542; c=relaxed/simple;
	bh=HVAtzJ5U2BABuFs+55ExxjU4LDiPYSzIMYVo1pqtQxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KnWpgzHrkp8W1bbJJYwyPqKyaPZvvz+c1cjPaFbuaLnmWrSWThVZlr89krQ7Gpg+6uxVZ7P7F5gJ2fBPPu8nuPqem4fisOriRYT9GmfHBL+ADqfSAkNPNoXA2qarlSRY7sfTxoSN7dqHkWfEyfuhlUI2CEY7z9eape+dvrFGWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uCWwrLfH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uCWwrLfH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 39ACAC5846F;
	Fri, 18 Sep 2026 20:33:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E5AC60649;
	Fri, 18 Sep 2026 20:32:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CB2910329075;
	Fri, 18 Sep 2026 22:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789763531; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2VX0CCuPHCsxlaJh+H4kCzMlneu6/Jn+nKdTKO3KJ0I=;
	b=uCWwrLfHGptD+ypseLy+70sNGeF2t+5t7CR1qgkBVVsUxkv3h7NQ3vU/fOz2QorFfMofP6
	GZgqhmpiLKpega2wGKoEcDXt1F7PLrLJxDlpojFUVodPmKgnwQwY2Al8E7TZk7d1d8Oz7K
	T2ZZgZ4UPTnFs2QQwhBi2T0sITLDb1332KOi0/v+33xlmytI7XS8sMXi7aicdM0ZLk9iOG
	/oylsUdu6fxaSbfPc63d8R8QkdRPQzQSMTcLZnlBH4q/htJ3zteOYb9izRF1+BWeH7Ja95
	HnuzcvKPqSeui4vCZTw0O8xvUohfw0QFHgUvnhgzcSI640RhSyXQDoPGyeI/oA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/3] net: macb: fix close races (and RX refill error
 handling)
Date: Fri, 18 Sep 2026 22:32:01 +0200
Message-Id: <20260918-macb-close-v1-0-221d916b7961@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDWhRHAVsTDtYMRfOohE3F2x/
 BbvXSDkmATK4AJHBwsvs0ccBmD6Zu5IsfUGHeksKuJcTY1BZcZFSFlEqxNMMW81+GB11PL5zar
 6t+w4kNneA9z3AxSI52FuAAAA
X-Change-ID: 20260918-macb-close-dbbd23b4b8f2
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Antoine Tenart <atenart@kernel.org>, Russell King <linux@armlinux.org.uk>
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

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (3):
      net: macb: never give hardware a NULL RX buffer
      net: macb: propagate RX ring refill errors
      net: macb: quiesce IRQs and drain BH on interface close

 drivers/net/ethernet/cadence/macb.h      |   7 +-
 drivers/net/ethernet/cadence/macb_main.c | 119 ++++++++++++++++++++++++-------
 2 files changed, 98 insertions(+), 28 deletions(-)
---
base-commit: 994db8ab9d90c64dd641b7ead6efe2eaea7a50dc
change-id: 20260918-macb-close-dbbd23b4b8f2

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

