Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957798;
	b=If6+EpC/38S74ghlXyJl8nnk6O8yLqTW4hGuFaV1w2xluNQIZMPAlarxFeI6QjTmC7cF
	 uJD6kvbpVwWlqxr1A4ZgKNLq7zamXv6nybvfiTSpNs9gwOZQE8SF5/lI16p3GndT9qVv8
	 LoqGW1/vLooarcS8/MYNt7zjpbcLaskBCliiz7KV9D6mc45nCu8aKbf0xFsyM0FNbFJzh
	 Up4ZlilvSeowAWExu+sBYnfSzI1JulEu2DmhzSnjnveTFVfPdP/2dT3AVX+xmhoqmR9fU
	 IxQxOM3frD2QGwjEuGWwNGysIVuDr0zMkLVU4hP85s4uq1BudzC8HqLp1LjWRg0gMyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957798;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
	b=VjStCJXbDagxXshR4BvyOPOvUNlhU9Lrd/QCTBthbOwBY/w0AbMcYR9ACPvgHvJK1CO4
	 dAWWlHLip10Op56xCTzTommc8sIbEyK+4k1XC9z3J53tsG2+Dv0yKmksEwYEa3ieSOnFN
	 9n0XY1Lc1B4Zm6YYev6mVQJvzAA4V7zwX1a4BmfkAnNdTsin9B95d1JiCe/DRcxKZ1EyS
	 OVWQjn5ulbOOg8iMX9CkABegJdGBo+zqA5XXBTOpuDfjUqObrs7bG/JOQDqEVTOiyF5ss
	 NW03n5cxdX7+9mGjPYSFU9Kht1rOh9H/XbNb3OajeFcDz4s0qMUNkRvXsVFSd+njjUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=a4PCjkNI;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946F606A8A5
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2946F606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=a4PCjkNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794957798; x=1826493798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
  b=a4PCjkNIv1CM+14/3cN5TYjvm2HBx5FbKpcxZD1ZFEp5z87yIRwQp1Wq
   nlbLTl7wFd4e7A+GTJmg/FU5n0woPshZC3r4gsWXhpgf74bAQd7qYkWOi
   2kDzzH7loNa0EtFjLCgYTjhgAjpOMvS+6PCS1EEgxmePtucHOt/xGMlDz
   g8L7gw3D8ZgTZY7dHezw2bOpaH4KNdMahGyUw7ntZEYP1F4/6HqfHsJ+u
   /3Ho07+N2umxRUJao5WWA7f4p01FFTOw2nYh5n8nqIQovRCj/LS/9/ax3
   dCvCtwfqLAijyHsLaywi6m6Rzn8nMKGmIE/EFf7nXtUBD9jzOpgHcHkfT
   Q==;
X-CSE-ConnectionGUID: /fwtF/K2R+uUzWmYwALDxg==
X-CSE-MsgGUID: e92UkxRuSTGqUnTaUeRW1A==
X-IronPort-AV: E=Sophos;i="6.27,218,1787011200"; 
   d="scan'208";a="34322343"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:23:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:1072]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id d98e8a6b-44ce-404c-909c-3b94ddf398f7; Tue, 17 Nov 2026 23:23:17 +0000 (UTC)
X-Farcaster-Flow-ID: d98e8a6b-44ce-404c-909c-3b94ddf398f7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:23:17 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:23:16 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.18.y 0/2] netfilter: nft_ct: move custom expectation support to helper
Date: Tue, 17 Nov 2026 23:23:05 +0000
Message-ID: <20261117232211.stolba-3679da4ad8be-linux-6.18.y-v1-0@amazon.com>
X-Mailer: git-send-email 2.50.1
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Also in this series:
  - 6fb421bd07f1 ("netfilter: nft_ct: expectation timeouts are passed in
    milliseconds") from v7.2-rc1 is included because it fixes the
    timeout unit bug this branch has, and the fix's moved code uses its
    jiffies timeout.
