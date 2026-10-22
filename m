Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706197;
	b=Lmg0oMScQ/JeeCKhBUAPJWHXy05duFltaNtuku9AsdvFPz1+tw86066BDWwnUtn9h9MX
	 ZA44/ACIf2CntDX/gfJURJA6eOwj0qqvN/XS2ESqaFacM5gRTiNWJ6FzLCItYDF5c1Txp
	 zKuRn2NpY3NdgMKGaDCL/sX/g3/qCu3uOQw0D+Z8p3poVRr8olVDGD15WHrOq+dsPuwkM
	 w06dCQJjsHMApKNPtJ78HoZ9rSlxaTPGoHJxTulOXCuNiHf75q+GlCECPuhqyGIE9nqP6
	 xLJ5bTpcaWJ5FJlo8OalauWo6YxyebKY5lllOJRRYbzTBdqTzh0PvPFcyKC6obUER/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706197;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=2ht9hKwW28qoWc+14Mw1SyYDIPjZuysuA2Hx3kQMIKA=;
	b=GQ94dg2JRMNA1QTxnS25Mo3d4EYRUWt1jfBLktn8jXUHA/ecu4W0oRpPnp2tKWJHU2DY
	 8Wf8aCyLRjKGvY6eY6cI9h9mzvTVl0cmToJXu7eZh3EDydvcaSG8fBdjAG5E0N9UiWo4y
	 nEQ2Ore2HuNKiizOyeteJpdHT05nf7yp8swPhRNu8XHMCA6bOhw1cOtI6O0cXupYYYJu+
	 3URiSQcu97M4JaFyteavkOgX6akormlurcpj9dFeUWYiWrEk3PiNPETKShqEiFKwhyp8i
	 pxLTvqHputpRoc8iQMrUBrNv+CapwGwA4yMNL70TX2o0KBH8ZDmkJaBBlMsQBUIDaDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WDHPSxFR;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F5606A31E;
	Thu, 22 Oct 2026 21:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 117F5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WDHPSxFR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792706197; x=1824242197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ht9hKwW28qoWc+14Mw1SyYDIPjZuysuA2Hx3kQMIKA=;
  b=WDHPSxFR71gXp9tI5Dw07MLQi5dNyJObdEI8FgBwolxQ3HTwLz17vo41
   V/ZqR2wRAENpfQJ6AoK08llzNtufWVG6nrpIx9i2kFeTxCposH7n6ek+A
   dwtFyLGoGD2G1ikrYoIbzuarPoscuRmYk2SEit3ksCmZyUwbN9Z3OVGxH
   HAi4ZBAxYHo8cruQD2MqZZjxVJ3zE1ni2kz1oqsZ94aHc40rR5sHC+Opi
   hP2eLsM/7QSHzCbxaw+4LfHEFkiUTRSyrgGj4f8G/B5z1y9e7/m2sAmhy
   tBtpYuNFhQfeSGn2ollod7OSzoqSUuut+slICvgDHzS0V8wsMIjzgXdyx
   w==;
X-CSE-ConnectionGUID: LCI1end2Sb6fngFdlw/Gzw==
X-CSE-MsgGUID: nfiZVH3/ToeEW8S4v4kpiQ==
X-IronPort-AV: E=Sophos;i="6.27,173,1787011200"; 
   d="scan'208";a="31988313"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 21:56:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:24904]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.188:2525] with esmtp (Farcaster)
 id d8e9a9be-d13f-4da0-bedd-40b1306289a7; Thu, 22 Oct 2026 21:56:36 +0000 (UTC)
X-Farcaster-Flow-ID: d8e9a9be-d13f-4da0-bedd-40b1306289a7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 22 Oct 2026 21:56:36 +0000
Received: from u34cccd802f2d52.amazon.com (10.187.170.23) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Thu, 22 Oct 2026 21:56:35 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: <stable@vger.kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, <linux-kernel@vger.kernel.org>, "Haris
 Okanovic" <harisokn@amazon.com>
Subject: Please apply e74798f2f8e1 ("genirq/proc: Fix missing CPU header in /proc/interrupts") to 7.3.y and 7.2.y
Date: Thu, 22 Oct 2026 16:56:09 -0500
Message-ID: <20261022215609.2203554-1-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
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

Please pick up upstream commit e74798f2f8e1 ("genirq/proc: Fix missing
CPU header in /proc/interrupts") for 7.3.y and 7.2.y. It applies
cleanly to both branches.

It fixes 171cc0d9eed1 ("genirq/proc: Speed up /proc/interrupts
iteration"), which landed in v7.2-rc1, so both series are affected. The
fix was merged into mainline after v7.3, so it is not in a release yet.

The bug causes the CPU header to be missing from /proc/interrupts on
large systems, such as the 192-CPU 8g.48xl and 384-CPU 8i.96xl AWS
instance types, which breaks userspace tools that expect the header.

Thanks,

-- 
Haris Okanovic
AWS Graviton
