Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798712;
	b=sCtbwQTOTjvS/hjQW/4HRDnOZpqvx6qgrzLiY1eTU3XWEK+ghFbkqVyYVXLu1EKoauVH
	 uCQ3HoRh0iKkIHDqYMjyATAVjcLBMmdUWNaxVz+NX9YPmmO3ADh/tHzfuF21nP95ZvYfn
	 vzDuQHNqueeXFU7wb+qaycDC7sOeHw4MKWS4fj7S0tPIABvM2eLPpUaHeXhNxbcR9WLzE
	 4DWGsskbBSKFz5cL9P5DG1v80Mn+HcXJkvW98EH2dbJ1Hbbi2cn1EjoAqITSP16r7DgU8
	 ORgXB7Ou8lgntStxgFHBdZovvWewhCXwuObPekvzXvcM8VbJHrjladldz/p8MMwukaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=5TT2qKFHVhSy1i/+TLyLe7Zn0Ot6zl7si4UQtRA1syU=;
	b=383faOe6E9PlONZmTBZE4WAdbOF5jP10yFncSLAurg1m9/n++RajfnGHPggwf3zcPoQE
	 TS9OmX3ciRh97/se1s3mHnQkjLPGBB+yUtzyqAWMoz6b3OBEKwBCuZbrojNxaACd1YSC+
	 z6tM2H8FwxeM4Co+hguOWbjz1McwVP/5ue0colTUBCqWJ79ijhV0vHRnGSqBm/o3nziXn
	 tUd/DzjimEscDY29XOgq1XM7qzz60VgXfjfmDqkdodfNJuziYLVZU1r9fFCyJAumJMfOH
	 eSvhR37CEa1F7Fv2nml0ieKhvdGFRf0czTGwP7zzk6e8g7h8YjXqdMFua5bc7K7H+BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pr78gAlz;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27902606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 23:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27902606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pr78gAlz
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4a75171af39so512220fac.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792798711; x=1793403511; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5TT2qKFHVhSy1i/+TLyLe7Zn0Ot6zl7si4UQtRA1syU=;
        b=pr78gAlzIXC2FbL8sNXrCmDIy6hbfD5+knzM2ksncadeYNbBT+mbUxTIsKetSu2pkp
         nm+3OiY2AXnrd1DBeSuwR2KtTDvgbnY/0xOlSdXDYnvi2lw3YQvjbD+lJkrR4s9ILHIS
         F3ZhBMjLk8pMlfASxX2R7+HF8Vhub2/7/x8jQwaREFdoPw0ftZ2ohtdy+72lR81qU6Tq
         lc5GxvxDeUPBFYGMcnNtoijA6+zEL02Y/VmMKokouG48V5/jqSZYKyU0oAOvi1BBgx7z
         AKFCp3yKeiRZcw3k9wHkst5PZ8i7fMbcCqZvfHLTwz51ft+/6MtFjK0X0rAA5FMImT+F
         j9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792798711; x=1793403511;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5TT2qKFHVhSy1i/+TLyLe7Zn0Ot6zl7si4UQtRA1syU=;
        b=b8dWzrQrkH6LHLhcBEQFEgy3eHJX+luDqj6yTY9Mv58gZFrYuyUArdMmRNeM82suBL
         PhWl2lJos7GJGEYCnF9ObxcDDQuVGOQoCxH3eEaxPRcTuwIfa2zfh6e37/3+WCwJ01rE
         Dhci5daH1Vz76mGeotpBu+JpbeaQwfkjS0pSINrXFcgEAkXm0AchbtQHWx7Ke41DYBQ2
         ryxh07dsoIWu7xPPh8pElgnFp/SJAMAZ5PXxiTkN5wz4SdqUA5tuuDGMCY7yz14RbR2j
         BCWElIG0wVAmXfWPJdmvqZxw/4wtP15aPzkbwxhPCkrUeKXuIKKvAO2SfBiFv6i481vk
         u9ww==
X-Forwarded-Encrypted: i=1; AKwUvBykYrXwY2QA+YsKVt0Lezb6cLmfCCRf+YGv/0tAnObfzEl9HzBYklGAbk2Qqr+g9VM+nrYXwa4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpWOfpC2WDQ1cvPtzKDiMqtsgKQVpJvFyKbhpKc2Ri02aBobnb
	BoMgYJ1dEq9AAmMhPFJtLmdcJimg5j1ubtfStgI4y8cssiCopcmfaZ6p
X-Gm-Gg: AYBFou1FwG7nFWGe8/039HWvSCDn9LcSrodZ264qTl+Zm5C3oMmjVftIK3PA/hMEjBk
	QZRf64b3afPHwvTzwrXRaOBFVXYW3Zh4Xit48Eo4ZCSo++t533FRy8vW+1OjK4faG1Au9uhx8My
	xG0e5Lt9AOFFIMFVE6kOFlSuWrfM8jkXjPh50hIvVaqTmdNp8ImNAcHMcqUnqS4uz4x8JZHV/Q2
	7JV+gCTuzHwoKgKe57cx8cVPdq4bFbUKikGIt61GIyWyTWlbvA323z8VBCkANbKrCoAtqJz9w3L
	Shand2dtqt8UCvonJOEa7InjsDj9Jn+bOREQ3ElKIdbuS4ogFG0xNCC1t7pOWnX3kP21MvUgvC9
	qB1FZcNorAzrirQvVriZtprAr2cE6adUFZTm2O9oT/9TkxFe9Tj0b81uLN7+4PRK34rrPDTE0Uk
	L0hpSQtwLjcLttgzs+6HZi/IANpMbfioLav1RuYd566sJ9Qu37VbcrX8mQXVEPpBD7Do+72r42Y
	7wD8hyH/fJQERgwVc0anGV2adJSgMNR+lGYO6aMvzIWlxA3YVtsvrk8RFSMauJbFLtSmhHibkuf
	6axTelVVaQrHj6J9/nL+vk7GSXVoAAoVL0hjOrAKyXZju0W3/oUiEN8Mx8gT6fukDZnpFa8nkWD
	x46zRinOaAOG4HeoDPdsETM2hJdM32obt+PR7HOXzNOWX5BebVrD9qfjPpcYXWVUQWCjfCzBn4y
	nfKWPE
X-Received: by 2002:a05:6870:71c5:b0:494:a88e:3ec7 with SMTP id 586e51a60fabf-4a83f5ecc73mr613357fac.39.1792798711052;
        Fri, 23 Oct 2026 16:38:31 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a843225d69sm284345fac.15.2026.10.23.16.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:38:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v3 0/9] dmaengine: sun6i: fix interrupt routing and channel
 lifetime
Date: Fri, 23 Oct 2026 17:38:19 -0600
Message-Id: <20261023-submit-sun6i-dma-lifetime-next-v1-v3-0-ef1acb0be768@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WQzW4CMQyEXwXtuany4zhZTn2PqofEsSFVd2l3F
 0SFePcG6AFurRQpGsn+xjOnbuap8tytV6du4kOd625swj2tOtqmccOqlqY7qy0aba2a93moS/t
 GrKoMSX1U4aUOrEY+LupglHfkjI8CEUzXOJ8TSz1ePV7fbrpB3pmWC/h3YuKvfTNfbmNdTjMr2
 g3Nar1KIp4xhSCEfQoEvbaAgL4HXUwEa0sgdDeztNC23bxeFXR9BAgIISVdctba58YphDn1yAi
 WJUV83BIMZCSWWHrWBojQa7HiGiYiWnCaXA4hP25Fb20MsQgwFZBmFUiKa5UZ53tGzj4mw9Jd8
 m/rvOym72vlB3ON+49229NKGx29YATq5WUzpPrx3Mq60g/2nuj+QrSNSC1uIALIEu+J5/P5ByH
 21fMkAgAA
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
The ownership work is split into lock ordering, physical-channel locking,
completed-descriptor retirement and interrupt cleanup. Pause bookkeeping,
callback synchronization and per-descriptor cyclic state follow separately.

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
Changes in v3:
- Split the ownership patch into four commits covering lock ordering,
  physical-channel locking, completed-descriptor retirement and interrupt
  cleanup, following Frank Li's review.
- Document why virt-dma still takes vc.lock independently of sdev->lock.
- Check pending interrupt status first in the per-bank loop condition.
- Link to v2: https://lore.kernel.org/r/20261023-submit-sun6i-dma-lifetime-next-v1-v2-0-c9e07cc44bf8@gmail.com

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

James Hilliard (8):
      dmaengine: sun6i: handle the last partial interrupt bank
      dmaengine: sun6i: take the device lock before the virtual channel lock
      dmaengine: sun6i: serialize physical channel ownership
      dmaengine: sun6i: detach completed descriptors before invoking callbacks
      dmaengine: sun6i: retire interrupt state before reusing physical channels
      dmaengine: sun6i: track paused virtual channels
      dmaengine: sun6i: synchronize callbacks before releasing channel resources
      dmaengine: sun6i: keep cyclic state with the prepared descriptor

 drivers/dma/sun6i-dma.c | 183 ++++++++++++++++++++++++++++--------------------
 1 file changed, 106 insertions(+), 77 deletions(-)
---
base-commit: aff5e6a77fc69a7c490246465940d18422d7c631
change-id: 20261022-submit-sun6i-dma-lifetime-next-v1-53c3158f4841
prerequisite-patch-id: d6398447647aa0dbb005b5e6dc6ba96e642efa86
prerequisite-patch-id: f67c1f8d8d9e014cc650f2f37648662430c3b77b
prerequisite-patch-id: 8522878df4ecd4fb007cfd32611359e6eb58a1ef

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

