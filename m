Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780964;
	b=mzMMfFVY/klkktjCY6qOu6fDA1WOa0/KUerpzFhDg9VYKIP6VRc9PD6CsrfQ1S1TmwKG
	 jAOojF44ZPvXPFVsD8O4hvMJ+8i9fcrSfD75cdZcD5kG/z7bIEQlXrpgEGWuKxcYlPQw3
	 kumnp2eOV60FUkfrKFjyaSa0n8Fq3Uljz/4yynTJ/lRGcg2wP/X6NU/hra98QyWWtA1QY
	 h05ruV2damsR4/ra+xqgcwneKhDjwwpBAHpFNIgYU4Afjjq3adyKRr0GmDVHPZSVhpXWc
	 wC2RVmjEezz7/bjym84rNtBMPy66YaxI8Ed0aWlmpslgMN0gdL6L7NFCma+x/vxfZsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=WsTkc8bAO4KYYktDdouwEoWdlbtwYIQKUFGzzo3SgDw=;
	b=aAKwWYvpfqzyoNvVcXzMzLXz8mPMfWy8c2SnFDLE+Pc2p0TtHzWXWhQcPuOQdYK5drcD
	 6QQnc4bTywZB5UHKNO9KNK7N/rLi+EC2IBTjv2gxBLMd+ARPBMosC6/fN75vtLtE99+KY
	 MorfcTCVq/KQLB/f02gw+ENyeQZtD8vY2RsCyFh8ghsppQsragSXQXodrx/PpNT9oEsmy
	 A0FCYsesEm5M1yitcnxwCgZmcD5obZtrVmvGlBq9Ejfpfr/PdKbUBUqUJLBD8+xNC8Jm+
	 3AjwHmNzGfveXYjMJBPMaHDJUiC3hI8JC4FoTQCHC4KDKoYImfLB8GUhhiK+1qJovOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nISgflWl;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9A606A329
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB9A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nISgflWl
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8439fe796ebso744327a34.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792780962; x=1793385762; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WsTkc8bAO4KYYktDdouwEoWdlbtwYIQKUFGzzo3SgDw=;
        b=nISgflWlWxkiadYYNA7pD/XkUhHCoxZg+EdApAd1JEEuXE8aNDY5yc4/Mo5/EgRlo2
         gl/AMXb9LY+EmsYxSTzVyG9lXNo9gZehv1LmcCHhlbDfCGRNbF3n0sn6yLjsSWVCe+io
         GU6aapMgNWvDgbfN3VZh9QpbMpUj1x1GwoCJUClnc5tOpsY0HUidZ+Cpn5M9qojyD6IC
         ChCwQMWKF3hWM10Kik9h9/OzWKlif+l7QAqb2+ohj8sYtpMKmOuTTn7rSX+JND5sljuD
         TOZcprzrhQGQDq98aXJZJ5IrDt5V6HKXU53Qr+kJXEjuPDBtfw8PWtkviTtyhYS84zY9
         e06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792780962; x=1793385762;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WsTkc8bAO4KYYktDdouwEoWdlbtwYIQKUFGzzo3SgDw=;
        b=SoHeDq53H2HJpsu9a4NsWs1lififSpzTttrraEHLL80iBjW+xLUnZ+DAon3tITpdNS
         Ry85RYRGYerIVT6AcdzmzFTRW5Eh0Zorezxlnd/IDBhC3Zx3xpOnSJsJMIX0d+81PnMv
         O6tWoM2/TJ0kXmUS5hjDh8NOHREjMgduvi+5NRlF43RSmKynR2vnjhl86xI5X6S5/s5Q
         XcMQb/Apnjv/E/bwTRnmfpp5T9LyxsJYR99vGbom+m/8p55gWCl34eSEdIVw9RA03OHi
         uArLUSipBOLF+HS47TvqfyF/cwbhF2KFqQ0q2bCRFbo6IdYkf8Sq41DhO/UvAmJYXgZC
         wncg==
X-Forwarded-Encrypted: i=1; AKwUvBz0h1nzu8k1ZID5iMoos4xv8oKzMxuW+YID0BGK+aiOckOMN32sPWcrvSzpWXYWrzyCMrKZewI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKm+kpqBabTWRtvjiJMuAUubLm6nsWyvULk+NfQjN55p228+Eec
	QZIj++BiC6J+YSdsBHPU2P713tYy/ChI7I0RQAuAV2cMWeeKJ60NNiTA
X-Gm-Gg: AYBFou1guewcNovBhnTQYBPWPSUvHenFloua1a0v9P7abMXyWzOBfUwTktUCBPPXt48
	zOAMYG/CG+85brTldCjopcb5wZiM6WAgRo1NZCH+w4K9acc5NiTx9OCD0K0/vAa6JC5bYScajvS
	KNgZ13i4xHi1hqdtwGnnEtp/Ice56/tSs/JCVsLOEVoNBePkgfCLGewhtyHRZ+IPrDUi9wmGWDB
	jTs0JDXi66b2nMcSo3Ovfj0HRNVRM0DnAYnrRjPmeQlg7mBAtatEKZgMXSxUQ+SNFS0/iM2/GSH
	sPwvcjsPmNqAqb+DPbZEGCqdqhYmC92q2G7M3ZWqxRKDOzDgsM+2kSsFPX6fv7MTrhuY6XgcYU2
	ielkEZXjOoPj4DVB1TptcY/iF+175y9icDWfUxWOF9DrS7DduW8/cDBicNSg8PsV2CXQ1YYI5xm
	uqQiEOXyfKouyUdi9gB21zjV8h7zrsTbq3BMGlFC7DLJgf1EVIS0BAZrMAsr4zCxsp1rtajtqMj
	01/biE4jLBbwToHhDLiOWNuEZby7UVPRlVNBBGYyHqU2jbo7Ow7vK7jnbPmPFB31ZyLp6Ymy/P9
	znI9rnsF587fEasAn5jB+I/fflwDql5pCc9QrPq1a3uI+s/i/ClK5XYqBhsIGfId/GxDHZJ4QbW
	2I5HfYjW4EWC921RXKSQSZ9iwKx2BBtG5JVkxjztM60hD4YJaxpnmWp+oyC1XoSoczUcbGxRxFw
	q/zg==
X-Received: by 2002:a05:6808:138c:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-55c00426714mr42788b6e.67.1792780962175;
        Fri, 23 Oct 2026 11:42:42 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55bfe199544sm336682b6e.13.2026.10.23.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:42:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 0/6] dmaengine: sun6i: fix interrupt routing and channel
 lifetime
Date: Fri, 23 Oct 2026 12:42:34 -0600
Message-Id: <20261023-submit-sun6i-dma-lifetime-next-v1-v2-0-c9e07cc44bf8@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WQy24CMQxFf2WUdVPl4TgJq/5HxSIPG1J1hnZmQ
 FSIf2+AblhWsmRdyT7Xvhex0NxoEZvhImY6taUdpi7MyyDKPk07kq12LYwyqJUxcjnmsa29Tdh
 kHZP8bExrG0lOdF7lSUtni9UuMATQonO+ZuJ2vnu8bx+6Qz6orDfw38RM38duvj7GRE4LyXIYu
 9VmSMyOMHnPBWPyBaIygIAugqo6gDHVF7QPs7SWfb95M1S0MQB4BJ+Sqjkr5XLn1II5RSQEQ5w
 CPm8x+qI51FAjKQ2loFNs2HZMQDRgVbHZ+/y8FZwxwYfKQKUCdytfuNoembYuElJ2IWlicft/3
 5b1MP/cIz/p+7v/SLeXkkqr4BgDlMhvuzG1z9celther9dfuW0aOdIBAAA=
X-Change-ID: 20261022-submit-sun6i-dma-lifetime-next-v1-53c3158f4841
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>, 
 Maxime Ripard <mripard@kernel.org>, Jens Kuske <jenskuske@gmail.com>, 
 Jean-Francois Moine <moinejf@free.fr>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, 
 Chengfeng Ye <cyeaa@connect.ust.hk>, 
 Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

Correct interrupt routing and serialize physical-channel ownership across
allocation, completion, pause and termination. Keep paused virtual channels
off the allocator, drain completion callbacks before releasing resources,
and associate cyclic state with the descriptor that owns it.

The first patch carries Hongling Zeng's physical-channel indexing fix [0],
adapted to the configurable interrupt-bank size introduced for A733. The
second handles partially populated banks, including H3's twelve channels.
The remaining patches establish the ownership locking, pause bookkeeping,
callback retirement and per-descriptor cyclic state in that order.

Based on DMAengine next at aff5e6a77fc6, which includes A733 support, with
the posted IRQ-safe locking fix [1], channel pause-bit fix [2], and the
virt-dma synchronization helper from [3] applied first. The synchronization
patch uses that shared helper for the sun6i device_synchronize callback.

[0] https://lore.kernel.org/r/20260706064123.66035-1-zenghongling@kylinos.cn
[1] https://lore.kernel.org/r/20260926171049.841335-1-tien.nguyenminh@embeddedlinux.blog
[2] https://lore.kernel.org/r/20261021-submit-sun6i-dma-pause-bit-v1-v1-1-38d286b69dab@gmail.com
[3] https://lore.kernel.org/r/20261022-submit-mtk-uart-dma-synchronize-v1-v2-1-fdaef0e2edd6@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Clear the active descriptor pointer before handing finite completion to
  virt-dma, replacing the completed-descriptor pointer.
- Release completed physical channels while their virtual channels remain
  paused, and clear the hardware pause request before reassignment.
- Keep the ownership changes in patch 3 and the pause policy in patch 4.
- Link to v1: https://lore.kernel.org/r/20261022-submit-sun6i-dma-lifetime-next-v1-v1-0-01085f684c9f@gmail.com

---
Hongling Zeng (1):
      dmaengine: sun6i: fix physical channel index in interrupt handler

James Hilliard (5):
      dmaengine: sun6i: handle the last partial interrupt bank
      dmaengine: sun6i: serialize channel reassignment with interrupt handling
      dmaengine: sun6i: track paused virtual channels
      dmaengine: sun6i: synchronize callbacks before releasing channel resources
      dmaengine: sun6i: keep cyclic state with the prepared descriptor

 drivers/dma/sun6i-dma.c | 180 +++++++++++++++++++++++++++---------------------
 1 file changed, 103 insertions(+), 77 deletions(-)
---
base-commit: aff5e6a77fc69a7c490246465940d18422d7c631
change-id: 20261022-submit-sun6i-dma-lifetime-next-v1-53c3158f4841
prerequisite-patch-id: d6398447647aa0dbb005b5e6dc6ba96e642efa86
prerequisite-patch-id: f67c1f8d8d9e014cc650f2f37648662430c3b77b
prerequisite-patch-id: 8522878df4ecd4fb007cfd32611359e6eb58a1ef

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

