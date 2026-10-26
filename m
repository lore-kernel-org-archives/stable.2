Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021822;
	b=yZ2XYJXxbHQtsJQ0Xvwk2+rNHKjavWWVRNdJviqkZ0HR87bqyOMC25PEk7laXGsPYXsd
	 GxEgeEbIJh7KZamO+xJCrMTEWpNNHai07Q7kClPiIF/UzaxUcSF2v80aAZI7UXe9Qpb79
	 8HjSTye0dPjxtEBlQ39Ga8IVI2G+iXhE2nYLsQTV6xkaBNH7xqRPx1c7dTIDmqsgGYMKV
	 vLbG2sbJhKp1mGaygLUdanR+/gp4WIE38x/idnID3mMK7mmaAxxtZRVrAJqDXiHfXwy+5
	 4J71WIryAxs1VVnMN9AzuxVFO15S1xrxSH8Vx8cIyOOXfA8ftkKAzq2jHj/PzBZoIWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=5tMMGpxtoQZxq0cbe4boMn3nqRQBhfDysNVoo7AMAY8=;
	b=kX1vwQgznkLwuj1enUrg7krH8mLET/GYv+XwFtn4Fc1fX8pAecqRb7sx+2WVGdvxg3tJ
	 uutC09VXmBfu8+r6TphKnklCS2jIsmJZHRSx7pRM/HnOENpMlDw+Vu0SEcUwBS1WMadC+
	 QuPVnmKMuyFhWcRkGE3I53qBw9AMEXSunYzcAtpmFyeykQ3NpbWq7x7k62CxwYGE1C8DX
	 xjqsm2nf1FmxC1AfdAKA2TncI/rJq9M35PcUvt7NrpGJ+dVSTagwXJEtXdriA0M7FyCV5
	 ugrOUX0qfDg6uLQb6EAJZquD0vwUYzuLMWakHoSB7VPOFfw0+WiHb1I0v5gjWCHdapw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=snu.ac.kr;
	spf=pass smtp.mailfrom=snu.ac.kr;
	dkim=pass header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=t8AUsbBG;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698F606A325
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7698F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256 header.s=google header.b=t8AUsbBG
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15943c9c005so3834395c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1793021817; x=1793626617; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5tMMGpxtoQZxq0cbe4boMn3nqRQBhfDysNVoo7AMAY8=;
        b=t8AUsbBGZl7j5ze9xZyez+XpgRZcYy1xDR2p4TSbQ91kJl7PLRjRrNP3+ch/7+ihjV
         u4Hyou2L3OvUhS1sw89zli36GmqqR9cx7EkfZDd4L0YEF0k/XqcYY7U8qDzXlyMwoHmn
         1nfqzZscpfXOI1byWWTMrFKq5OuK7qEVFT+C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021817; x=1793626617;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5tMMGpxtoQZxq0cbe4boMn3nqRQBhfDysNVoo7AMAY8=;
        b=oQ97SNgExpXZ01AV0sDcTbjGSTK3e9/aktm8x84zzsB0PJaZe7aAfS5sooitTJXmID
         q6CVpWutMqD+60O18DMyArqPRIOukWL7VvuC6i7v0YpRBmb2t3xqEwrRxfYcLzOrK00O
         lF4oagjVrhkHGXyTbpa8AD4PJy8EFA9lljBntHYHMMKu8+h3SrpLmh2MKZ6vEU59ZCmo
         za9oJRyHiXBfGIQFvptKTIbixPjy6ZWmCq1lOb6A0tvGyVLYWzX2eLagEgH5HSqfD5TC
         paefVIBWsjCjbVNNoBgasfN1NVMZvvW06LYrxAwK6SIBybYHi5cYcuqQFpPIrupSI7lx
         /5Aw==
X-Forwarded-Encrypted: i=1; AKwUvBwl1Eor0ZLNlZzRpPfybSjV2lM2rozJiD7hZeJRj+1XpZC3NDsd6RTMpMyGXnJ0r1QrxUdfDhI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIj0AB2O/0mwIUVR8Fa2xmSLVUYcnoJUIlu5iLg82kdv8F3JTbs
	+rfS597zIMTcbTXuZwriAXdJKl64Q/SxnKMf4Eg3bO3o8YMAJ87+LcKFzMrOAIGA6AI=
X-Gm-Gg: AYBFou2Q+cbQKSE9DWIlPhQDbkk/eJdgBw+CAZi88ej1cGVztjyD+nrY3J813AK6Qcb
	+cB6vnnZMbU8kpz7YqKbFI7qC645q08jVRUXr8PRIU2cRyQBwQUHsa0tkhKT/i64xinMujxgcvB
	6DRtWwiTft8hCfaicV4KU2OZRZ7rzWNnHd1o1xHe/tCUIl6nS2hhaARKn0Bvck8+tM6s2o3bHMf
	VpPkONHuz4dRK7ankXWAUzGeHb7IkbY+sVo+FoMPXShNvEE+iAEqcx91R86g2k+ietX5lzU4ZOr
	zPR1nXvaOCLAqSLKVpu/Man9cOZe+9REBxkWONN5xEfxBIOL1rzBjcLfBCkMrFuimta3ixkIMsv
	hgws0LzUFKOBZQ9z9NSaASsnFV1HtBRO64tu6LnbAm6v3E6uFb0T87mLKUuHzArzZDVuPgpbtJ/
	l0vl7WqnQeJ8+3p/3F3vKqWnM1QxqyvzllcqBKS4kW89Ob1HWsXppcgrUdhr8f45uSFkmbjX+ml
	ozJx8VhlBqzxbjNPx4K9TTahLIExryD27Ik0L5OigLVDnWb2g==
X-Received: by 2002:a05:7022:48:b0:16d:1e24:5cc3 with SMTP id a92af1059eb24-199375eb24amr13097855c88.19.1793021816370;
        Mon, 26 Oct 2026 06:36:56 -0700 (PDT)
Received: from [172.19.0.2] ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm22432520c88.8.2026.10.26.06.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:36:55 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
Subject: [PATCH 0/2] iommu/io-pgtable-arm: fix missed dirty pages in
 read_and_clear_dirty()
Date: Mon, 26 Oct 2026 13:36:42 +0000
Message-Id: <20261026-iommu-arm-fix-missing-dirty-pages-v1-0-115b6b1cc0f5@snu.ac.kr>
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
X-B4-Tracking: v=1; b=H4sIAGpX32oC/x2NQQ6CQBAEv0Lm7CQsCqhfMR4WGdY+7EJm0GgIf
 3fioQ6VVLo3MlGI0bXaSOUNw1xcwqGixzOWJIzRnZq66YLDmHN+cdTMEz6cYYaSeISuX15iEuN
 j355iP4TzEC7kO4uKp/+P233ff+UKJCBzAAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Fix missed dirty pages report in read_and_clear_dirty(), which is
caused by 1) unaligned iova walk address, and 2) missing iotlb invalidation.

First, align down the iova walk address with page size, noticing that
small dirty pages following large page block (e.g., 2M) because requested
iova start address can be in the middle of the page block.

Second, use io_pgtable_tlb_add_page() on visiting dirty ptes instead of
iommu_iotlb_gather_add_range(), which is called in iommu_dirty_bitmap_record()
and does not update gather->pgsize, so that arm_smmu_iotlb_sync() does not
invalidate the cleared pte from the iotlb.

Thanks,
Seongjun

Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
Seongjun Hong (2):
      iommu/io-pgtable-arm: align next walk address to large page size
      iommu/io-pgtable-arm: invalidate iotlb on dirty pte read_and_clear

 drivers/iommu/io-pgtable-arm.c | 15 ++++++++++++---
 include/linux/iommu.h          | 17 -----------------
 2 files changed, 12 insertions(+), 20 deletions(-)
---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261026-iommu-arm-fix-missing-dirty-pages-3754a7b18b19

Best regards,
-- 
Seongjun Hong

