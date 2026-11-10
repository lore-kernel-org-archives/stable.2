Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.68.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348053;
	b=xzegM7SHkDCBRL+FOvcfpXFhni0B64pSTbRlZEYcKa9SuWhve84yIMwJHNPKWoGriv74
	 KHqUlFVLDZTDCwxkZ4/zjwDVzbo94n4E4rDc/EHE+rE1bQfz4MvErLPmvurpBrmeDpnWu
	 X4IayGB+u0Rbigi+ho2UVoifzHdVxklOPHqoVHToBqyMv+JiM3Xp0I4owo3fBKm17qYVS
	 BxvmdKcGBp5zOZYxO3brYSldgbOscGHpbrLm55mZo2Y2G93ElMvP1F2U8V2E1VLGhd4zt
	 8DxE8zR95qLJrYtVKMyBcLE/BNOwFxlQwwj+nIWYbq199JwFBvpcavV/GBg3KQtg65A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348053;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Vv7dNVzIrUILO8od8syEGQggxT4QfI/iKHG9PeOeLsw=;
	b=JjktJgN2Tb2DgFrPhCdvtFEQ0NnpBGP1eQVTUBHkdtVcN29XkAdxxSNBIVqHXKHQR4fL
	 T7hADCqy1HB+gl53CoIJH+UIMyoAqdGu6+51wC9qMyVQsiA7orARb8b6P41JNq78UC0Fk
	 Iy6/oMYmxgdBLQP+dIqEvl/ZUdyb93+5BLLVTsN0ATgNCfBMdK5jklnZOCkHVYnZsjCj4
	 udPdSsVP26oCfXJcOv5+Iz1o92lJZJu5bVqw5gsn9KglZAZM4X+AHptdf9VzwQbKeLI54
	 ovq/OEpM29Mwg3zGIHm/5eu8w0O2CJdl1h5Ff7i5zAFsMNhBa5RlRk8mWY8t1wCpJLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Vdm05jOm;
	arc=none smtp.remote-ip=44.246.68.102
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CD606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC2CD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Vdm05jOm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794348052; x=1825884052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vv7dNVzIrUILO8od8syEGQggxT4QfI/iKHG9PeOeLsw=;
  b=Vdm05jOmHsOvFtKriw7wOkAdU7SB+3qt50bR1p+8w7KxMab5V+w0dqRa
   k9c7pXpZMlzXYxlsbMyc6JZXg9QE2aR+sXfzbxAdhwwmduwRwODQvKDOh
   33mSLmjy+ESNk79Qwg23VkJewGsoBdyn6agT5EatqztquJ6M6LEAwE7zF
   r+ZOs442RBZ8XwUJ8iGx23jTVI/a/tNQJYmXrm/MyzBiF6NJfHhe71pel
   KoavZQsjtv9Yl8lEgJ9NVV4LDfB5mOiDThmu+Rjhyz3Ig/5u94PezGkwt
   HTgIRotzy2SlcCtPfFkKtcWjJh5/llhd7BHSqPo6+D0w5XbKSaeTveTV2
   A==;
X-CSE-ConnectionGUID: IdC9D2Z7Ra6h0t7Z84UEHw==
X-CSE-MsgGUID: 132yf6aPRSi14wuzQIGaSw==
X-IronPort-AV: E=Sophos;i="6.27,206,1787011200"; 
   d="scan'208";a="33576604"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 22:00:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:10595]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id a47f0fa5-7764-4648-99ce-99640a84f1d6; Tue, 10 Nov 2026 22:00:52 +0000 (UTC)
X-Farcaster-Flow-ID: a47f0fa5-7764-4648-99ce-99640a84f1d6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 10 Nov 2026 22:00:52 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 10 Nov 2026 22:00:51 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <linux-mm@kvack.org>, <david@kernel.org>, "Mark
 Bundschuh" <mkbund@amazon.com>
Subject: [PATCH v3 6.12 0/2] mm: replace free hugepage folios after migration
Date: Tue, 10 Nov 2026 22:00:04 +0000
Message-ID: <20261110220006.3259056-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026-11-08-1-daily-reply-0005-hugetlb-6-12-v3@kernel.org>
References: <2026-11-08-1-daily-reply-0005-hugetlb-6-12-v3@kernel.org>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Full backport of 04f13d241b8b ("mm: replace free hugepage folios after
migration") with its fix 113ed54ad276.

v3: rebase on the current 6.12 queue (Sasha)
v2: https://lore.kernel.org/all/20261106220835.2878368-1-mkbund@amazon.com/

Ge Yang (1):
  mm/hugetlb: fix kernel NULL pointer dereference when replacing free
    hugetlb folios

yangge (1):
  mm: replace free hugepage folios after migration

 include/linux/hugetlb.h |  7 ++++++
 mm/hugetlb.c            | 50 +++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c         | 12 +++++++++-
 3 files changed, 68 insertions(+), 1 deletion(-)

-- 
2.50.1

