Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960160;
	b=0GGln1+OvZNJyL2pEJLm02qcbfyuSwkkqahEW3C+4gzW7HM2x6aa4L8hQf3WubeCy4lA
	 6L3JpGL1hXwkjvaQ5SRaHMhzZKHd9xwUjlXHJG3b8D3uK23utG1Yk/4+B4pkfY6jwn4qu
	 USyYmKrWZR8HRnVGN7FIg44jvextDInA7A6aP5SUVMihEJravz8JOXKndzl7T9DzikzGH
	 33Tmax6eH61tRZPLXuN6B0vcQpVjzPe/YAkwjmwkdPfaThZne0Du7oLOT5ULG3FgzMXtW
	 EDLu8tW+DJIkG4/YLt3FlG4qmAM66fMT3Gnu7+yp/32z7TshfpH69H/3M29DKo0xp9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960160;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
	b=wqGGRi3SNueB8Uzl/3MYkJhzF/Us2ule168v2gTLHNdRpj+Pnv5CRBn5DGBHc6G03d+5
	 6SXGgsUnfRh61qndwd57ZQuPAm0W8fkmsveugJUJI5Y3maGXkDfsedOsV1pN8oBaeIgaM
	 KSGC+lC6m6TqRE6aLA9fnJF/Sp4dAVdXwulAonmXZ/ebGNBCSuqvh0Yf1aCvtJSgHH1Av
	 UhecSa1xBxBDfdyNHgKHHUHv2ckXqhIJAARUD4vhvcP/oPktMHowXMtWeeUsXJgPnkQsJ
	 xQvIMXWnIn0kFtUZKwFwlUwxcHkhADpFa/wojbGfsRBJb3kg703UvgDGKE5y2OejA8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=a1mm0ZSA;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0F606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AC0F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=a1mm0ZSA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794960160; x=1826496160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
  b=a1mm0ZSAMEcLJ7mvxM2RnSKNbSISFy8ZRZhGJA+hLFj0NCRdK1n4iHpq
   qh+7rF5n7NvvaaZhgvCeEIe0Et/ztGTT3fNH0j4ibheE0ZLnWA7wG2hoi
   YPA/4zWnYvppDr2Y/Bn5O+egGW74PV88E6mGWRO9/8TD2PKikO9zEZFpi
   onF6zzsVK+HyDjnzJVg3RiRlwYqdiMOfyr5WygN1aqiT5VgGrXEViv/Q9
   j1Y6h2kAYpsZcEAjVyVUInegMnHT1tNiFcjoOxvOiXObd0BJLAGypQT9r
   jbQu0kzzayAdJ95rH7Fh1g0Z3qYePr1qV3cUoW0FdA2UGLCAHEAS6dLPc
   g==;
X-CSE-ConnectionGUID: 1OvdjkyeR2yVEmC3AZCaOg==
X-CSE-MsgGUID: P1+7i63qSB+sfVafFiQASg==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34215681"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:02:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:30387]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id ddc5b461-fae1-441c-801d-3196406e4e50; Wed, 18 Nov 2026 00:02:39 +0000 (UTC)
X-Farcaster-Flow-ID: ddc5b461-fae1-441c-801d-3196406e4e50
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 00:02:39 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 00:02:39 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 5.10.y 0/2] netfilter: nft_ct: move custom expectation support to helper
Date: Wed, 18 Nov 2026 00:02:21 +0000
Message-ID: <20261118000221.493214-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Also in this series:
  - 6fb421bd07f1 ("netfilter: nft_ct: expectation timeouts are passed in
    milliseconds") from v7.2-rc1 is included because it fixes the
    timeout unit bug this branch has, and the fix's moved code uses its
    jiffies timeout.
