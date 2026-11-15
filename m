Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794735194;
	b=JxSz3oF5fNDuk/uOWm7l1ghxDzEf+Xg6OtX+Ajf5kM8WwUSnsG+2f3wH/PjTdiQdl4Wf
	 OI4G22vWqQZfP+lTnqUSZjV8Mu0mOWFRM4y2IAwa01Kedf5YqRNwHbeV23jiXylsZYwyM
	 fbkomRKMrMDNHkE/ZbuFN2n1LAeXS05sIVDD9wxkmMvXOi4qAbHSrW2teOhXJOvKcftt8
	 xipYO8afzDrvjgK5j0bjXWgxQepdSuSGCSdoKBq/Egq+JUJa+6ZzQKMu9iCPjQMkNVfBC
	 WkaAq3z0knbPtCGj9GjPrMn1D0dsNooNV2Vpc15oOHO4SgrDLODbJhDRv8ZX6WuVDLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794735194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=5e7EmmrAmNsJKP6AOjhCJAku3QB+VBI4feI+to/QFAw=;
	b=xFGGBza9UCoQ2AKvCBd1N3KTxlh0WlAPVO6xWxnRRp7K7QugFLMu+iFpzm08zrRhJgCx
	 Pm4/CsLOOMJ2s9c3n9XEjr4ZpjOpDOFOQpLJdJIzqbt09dob/SMc85+ImmehlvzRlLb2S
	 aKXSAI+XeDQrhZvmoaJswiVYoTDI5fIQeizJtcQLPI9JJbnhio0q4tV/WzPrzjeL33D+e
	 g2OQTTZ8Ue5jaJXHj9C5xJce8FuETWnCqVGEsD5lEyUhtgG4tuAFHdB07vMeFFdpospGF
	 Aa0kOKnmGpZ6uYh7qykaSiyfi+BzWVYTU+LXldMXoKCp1ddkgX5K0DzhsUy10zf8EnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Zdb+e/m7";
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06C606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 09:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E06C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zdb+e/m7
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f84a55cc06so2166293a34.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794735192; x=1795339992; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5e7EmmrAmNsJKP6AOjhCJAku3QB+VBI4feI+to/QFAw=;
        b=Zdb+e/m7WUnnamoKHXqxBf+AsLeq65dwpdG8qXqHS6iNoVGn6swRNaDDiiDqUuCvsb
         t1ZI1ODUdPNp8hEy3BuZoBlVew2AUqwjUH/B4WkOJDwZfrBQVFdo1QBPDJ3urn2dnerT
         ZDDenP9Z6FQoyy5tjBjb6KKwEqZG74Cong5Y4J0g+KmFL/X0fZudI7Ro+Is9IaapiztA
         O1kx2WwRDAtX/0MU2C6RdZOWL8Ozj3Zbsbnp8qnYJXulygA0NjBn96plRfJDYeVVg2VM
         x++x+3UuDWs+bTVCHk5kFBzCyYmErOjRRfBRVQiGLhQSsST4K6FcO04d4malaqYVbNsp
         vbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794735192; x=1795339992;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5e7EmmrAmNsJKP6AOjhCJAku3QB+VBI4feI+to/QFAw=;
        b=gmtLNx4x/OHsw5c1UsH1Uetpa3MOQ89HlfTeZoSd12tMsq5auGeMdIgbnE4QyBmpso
         geGzaztWAU8X+wBIEyTWbW74jbJLzdRAxhNaDtPquITlIruHZcgN/HOT6++UtlYLljwj
         cdw6H5/DdmGsvV8omAzgpYbiRpa4aaUvoDkMBbU1NUMCaENthsGvlTALyiR2JoU4T9SB
         1Dxdpujoihqw43MM+z+riUYG6zBAWlQAY7rXDEgioryK8g7QiZftHOru0+3WA5qomPI0
         S7Abug2X+xybRaEhratgP1hNpGBhXKEUxQvglD9rYRq8xgh3l3Pp0jouRyGIID69Ithw
         vkXA==
X-Forwarded-Encrypted: i=1; AL+hErH0D1Yi549h97qQls/KOQq/sUjY2DASUJe41p9ZSPPylmVpr+djieR4vugjnE25mxdbNu642NM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9O8GEvKq0VWjbEyDrVlwkZaoBgHOrWbd513oRwZc5egSJ4cJ5U
	KvKmKX9BYU1lCwWDUxo0BQy8C7fEVhtS9nfKboPDyZTaeLlFsay6NBotlKb/Qw==
X-Gm-Gg: AYBFou0lP970N3Z08T5J7a3z3VtkzIWMRfbHuDSOdnqMmGRXdRKDTlUsEl0XbHUrMgR
	1VOFP+ECDiuv/tTitnFxRdwZQivPq4hs/ZecZ25rPuB1305tAJF+wSPQTST78yVnDmZDcQMtS3V
	zPLYulbz4CZZ5Aqa7til6UVRIPwVmCQjv6JLmWXoJ1/ozoauIKi8M9WvRyOt5PBgd5iyasHvLaL
	8S8KjJgVQTp64mBdVHy5eMWxteIecm7vYt8kDKZSbv4y/8Fefb37yPLzwFcpVNjU0ComudzdBX/
	DIOny7FvJe1EQEWhjKV1bhcnOKw6qkuBg7im14gaexAcgu0eiOfuNX4YS+biNiYC+X8dsrlBURR
	1fcMAyQW+uUa8DSMPMwaWpqOq3QThaj02e6vTvBs8AfGu1K7msxqFqQcCWFJz7+zhninOhH6Vrh
	kSa0OkJ2lxHNwSFrsHP9Kf32fVssyoFELmamoXfJKyE/sWwAsOViRraX/pp/kocV/1ucCIYxhoF
	EDpgv7J0OBhaKfoTMpIx4oNM2f07m30sVC9BoHoZj9Hy3v6XfCfQbPM3NAYZRlhAkRMjIN9vRdh
	1tizv3hcXadpMEMfxWStri7DbWRC8MiiUCNKgEvfJANtbW1t4Ksk+Xm2TH6v6IuxlAm38gVsdZQ
	K2jGz8ZDbtQPSGo4pzVuXE590LQVsxKexEukQCrs12rJtW2XKw9ZkUPxuZ0UOOf1W/ZCCe4kszy
	HVJySi8fiznUR/Q5yrT8JPblohiT8gKRxA0OqJ8yVRNpwRXBgYW4g=
X-Received: by 2002:a05:6820:617:b0:71a:e82c:1eb8 with SMTP id 006d021491bc7-71ae82c267cmr724986eaf.7.1794735192405;
        Sun, 15 Nov 2026 01:33:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab43347b9sm5933617eaf.12.2026.11.15.01.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 01:33:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v4 0/9] dmaengine: sun6i: fix interrupt routing and channel
 lifetime
Date: Sun, 15 Nov 2026 02:32:48 -0700
Message-Id: <20261115-submit-sun6i-dma-lifetime-next-v1-v4-0-043cd476a45f@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XQzW4cIQwA4FdZzblUBoyBPfU9qhwMmCxVZredm
 awSRfvudSY9dHtqJCRkyf788zatsgxZp+PhbVrkOtZxOWuAXw5TPfH5UcxoGk8OHFlwzqzPZR6
 bfmcaps1snkaXbcxizvKymas1wVdvQ+qY0E7q/Fykj5e9x/eHj1iRH1K3d/hPxiK/nrX59pE2F
 V7F1MusrY4HIpckNqxUXKip2dStxyCeHTRnk8vMEgV3ird60pmPh0Y+J8RIGJmhlQIQShBqynA
 mIXTSOdF9VadYbU8ttSxgsVYK0F33yiSdAz1UX2Is91XoI2AB9UqkmLlx6EAlh8wBLCCE6BEyT
 +/7n8a6XZbX/eRXu6/7ievqA6NmCp0S1ty/Pc48nr7qsXb96v4W/f+ITsWq68ZaEUtP/4r+06J
 XUbrlWqBIpDvxdrv9Bqn1lJV2AgAA
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

Based on DMAengine next at 6628e7d4c6b, with the posted IRQ-safe locking
fix [1], channel pause-bit fix [2], and shared virt-dma synchronization
helper [3] applied first. The synchronization patch uses that helper for
the sun6i device_synchronize callback.

[0] https://lore.kernel.org/r/20260706064123.66035-1-zenghongling@kylinos.cn
[1] https://lore.kernel.org/r/20260926171049.841335-1-tien.nguyenminh@embeddedlinux.blog
[2] https://lore.kernel.org/r/20261021-submit-sun6i-dma-pause-bit-v1-v1-1-38d286b69dab@gmail.com
[3] https://lore.kernel.org/r/20261027-submit-mtk-uart-dma-synchronize-v1-v3-1-aad7a6b3c62e@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- Explain that reading the pause register flushes the MMIO request
  before returning to the client, following Frank's review.
- Collect Frank's Reviewed-by tags on the interrupt-bank, lock-ordering,
  ownership, completion, interrupt-retirement, synchronization and
  cyclic-mode patches.
- Rebase onto current DMAengine next, retaining the upstream residue
  snapshot and NULL-descriptor fixes.
- Use the standalone shared virt-dma helper from MediaTek synchronization
  v3 as a prerequisite.
- Link to v3: https://patch.msgid.link/20261023-submit-sun6i-dma-lifetime-next-v1-v3-0-ef1acb0be768@gmail.com

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

To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Maxime Ripard <mripard@kernel.org>
To: Jens Kuske <jenskuske@gmail.com>
To: Jean-Francois Moine <moinejf@free.fr>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

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

 drivers/dma/sun6i-dma.c | 184 ++++++++++++++++++++++++++++--------------------
 1 file changed, 107 insertions(+), 77 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261022-submit-sun6i-dma-lifetime-next-v1-53c3158f4841
prerequisite-patch-id: d6398447647aa0dbb005b5e6dc6ba96e642efa86
prerequisite-patch-id: f67c1f8d8d9e014cc650f2f37648662430c3b77b
prerequisite-patch-id: 43704b0efab7679ada5f06b959a501040573409a

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

