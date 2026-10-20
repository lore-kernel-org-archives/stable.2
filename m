Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507072;
	b=KImeShoUe5RMPtV0gO0OSwyq0V5KwIsb0hP/MRuqNWBwO7MPLXtqF2RelEmqmttCQnhp
	 dJ4MhrOrfe8UiAB/VrfFzklAcU2HeCrSWC/RprnnOzlwTXrBI9PACW+4KaSbGaXRy/qFO
	 mvN0Jwjp/S8l8pacPgLWSeeg2l70r6vsXzqNcaqHz6bQNpckjbZsIWhlNuEZj2rB7E98D
	 swhfOCVDMN+u7qrkUqUSefr9QeouxgJAPuW5Lv0cqxrHOKUbJzEDZr72mo1/m2BeA9RY+
	 Z5B4KQZ6Qb32unOxA3VEXYVvvcmG0SOwApVsE4JIiCXjFERXGw+OFwZZ8o2ld1LObgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507072;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=5LRGHN8ntoxFrPJWrn1Xk1SCNt11RbrFeIIOupsDSQM=;
	b=lj7O/4JIhS+nzEHeerYgvyU54i93icfwRDoDvTl9wkwA9O72uTw0PTj+62po5CZYjN1C
	 P2tkGYrOfm1OHywm11D/GqXv985ijNgZCnyQ1CwcsJZIPrCisIr0GQTCvY8wuYNO+aY6X
	 mCC3uhTRS+Wg39TWlZ8WVJoy3Xh4bmZAabQdfTyubecGX9LO6nhWNGJ9q9BLp1kYbB55Y
	 KDdZqtjr21+3NtXL07HVhx4dDk/tKbmrCYH6VoCjvfv2iva1+CGnMBxbg/yrrkGJkunlU
	 M1n4tZG29a45S2K81bdqSTEYgRzfA9pgipien8Q6dGcOvCld7UyDLigUkHvL/eCBK/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=VwsdkBBp;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3E606A321;
	Tue, 20 Oct 2026 14:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00D3E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=VwsdkBBp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792507071; x=1824043071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5LRGHN8ntoxFrPJWrn1Xk1SCNt11RbrFeIIOupsDSQM=;
  b=VwsdkBBpuN+I7Fdmb31hkVRQG7S3shPV/IxRWL/u4Tl63rs9GH37ZAZm
   EOUEgj6x1npPQcWPma1iIRR35OAV1K4stZ1pwwYkfHb8l5vtzsAsS8v7F
   vZznuc/nw7TVBPzfuNrf8ZFRndqkOOz5YaalL+ZiOOKt5sZscZB18BEbn
   68McxU9CmNjuLOXoijm0w5Iw6q1dCi+Himo6BWDN8LvAKB4WsC1Sf3Pzs
   9BcyswT7VqHy3Qrc0C76a0t9S4Z9kO2ExtQuY+M/XPac4k1BQIvZ52GGj
   WYtQrUj6hG8gm6uImunDYmusEL2eBVlY3aLRY/2vy17f4noE9rVxMiliO
   A==;
X-CSE-ConnectionGUID: ECEm+QCsSqCyXSgn9k7Kuw==
X-CSE-MsgGUID: zvOFRcvFQQSX/LtWEJd9qg==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31743108"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 14:37:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:11916]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.1:2525] with esmtp (Farcaster)
 id a382078a-ae68-482a-a6ab-df5e639d8f90; Tue, 20 Oct 2026 14:37:49 +0000 (UTC)
X-Farcaster-Flow-ID: a382078a-ae68-482a-a6ab-df5e639d8f90
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 14:37:48 +0000
Received: from dev-dsk-avivb.amazon.com (172.19.102.34) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 14:37:47 +0000
From: Aviv Bakal <avivb@amazon.com>
To: <sashal@kernel.org>, <patches@lists.linux.dev>, <stable@vger.kernel.org>
CC: <robin.murphy@arm.com>, <ilkka@os.amperecomputing.com>, <will@kernel.org>,
	<mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 6.18] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Tue, 20 Oct 2026 17:37:45 +0300
Message-ID: <179250706537.3484860.18363532452101434862@amazon.com>
In-Reply-To: <20261019135441.1420968-145-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org> <20261019135441.1420968-145-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Please drop this from AUTOSEL -- it's new-silicon enablement, and its
parent commit 56603c28d916 isn't in 6.18.y, so the static_assert in
arm-cmn.c would fail.

Thanks,
Aviv
