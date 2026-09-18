Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC5524B1F;
	Fri, 18 Sep 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763717; cv=none; b=qcpq4Q65oT04znevbfUtwUy8IvHlc/WkLlMD/NLZwUrrWIEWSqudiPOAPVh+lxj4asBniD5JlQVPoDkiClKxBjXwx8p2OKdIjFMJQzSAYCsExehGY16uZRcuJHUvrt4sTBcEjjS5f04cZ/BxebUfhhOYFeqpzY3WFostInmOFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763717; c=relaxed/simple;
	bh=HVAtzJ5U2BABuFs+55ExxjU4LDiPYSzIMYVo1pqtQxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XZgaNsyVpYSW+n9tm5lKl6HfPtg0/PGZpWjJsivSkIHX2G6HeIv8L5IRmU2Dj43YkqUIUkd7HdMt2ow5afZBV0mCx2ss3EcSchTac90YASNq+1lpXV8K24sUr8gLfLhE+nVB8T2H2vtqaXyxS3SmlCKV4pBmDCK5A2s58JW+his=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TMzqjsaF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TMzqjsaF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8F4FD1A099D;
	Fri, 18 Sep 2026 20:35:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C7F960649;
	Fri, 18 Sep 2026 20:35:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D44210329075;
	Fri, 18 Sep 2026 22:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789763708; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2VX0CCuPHCsxlaJh+H4kCzMlneu6/Jn+nKdTKO3KJ0I=;
	b=TMzqjsaFnJPym62GSIEblG6cIU6DSlGhLeG8h36V3vbTrhQsUzJsxpPEFIfzzvuhFEET2K
	F0IInlHWrjeE8ewildTsYWRvQ5J//slkXenENSqB3k7H3cvqxvUPvNh15rcf4DUhWD3I3l
	tpMrQaSCn2rcA3nSwdFZcdtMh8spn2Vpzmu0G+E/9m3K0LoMdhDmInIr3kO2/pA9sTa1Ug
	3qorn6sG9rzKh71ChXgudSNDJ4LBfuENtUP9TGiRHZNDw45JvvOC2jIWo2gH5B6bZ8Hi9Z
	yipi0BcKf3O6K+ba3w73L7aB+4b6hUZ92GGsou2Mvc3mDoMUh8o/CoF4RrewWA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net 0/3] net: macb: fix close races (and RX refill error
 handling)
Date: Fri, 18 Sep 2026 22:35:03 +0200
Message-Id: <20260918-macb-close-v1-0-05e32ce98813@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBBEf4Xs2Rq2GgRP/ofhwLaLrIGWtJVoC
 P8u4NXjTN68mSFyEI5wzWYIPEkU79aAhwxM17gHK7FrBp3rIq+wVENjSJneR1aWyOoTnalsNay
 DMXAr7112B8cJ6l8ZX/RkkzbNhnUSkw+f/XLCHf5nn1DlSmu0FRZ0qQq8kfepF3c0foB6WZYv0
 TNfjL0AAAA=
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

