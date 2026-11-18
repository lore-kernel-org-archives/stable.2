Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960016;
	b=HKfBWT4QaS2L7fZAtIbw10ckcUYdXcdN5W2UKszis2mXxE0cvsHkjHu+h+yxOgXea26X
	 jA7hQ4lOKGJmOFeyJqcSZhmsaLr3vP1hmMa1BSwlvSv0DiWEKLtNKLRHK3i43Ahkt9leL
	 E2f2GlyPrIPmYWJDFAH7BpIfLHbowBH28mLFOig/naTdFTkb6d7CTMauN0pTR64jfM88Q
	 9GZhtgN9jdC+ysa6AnUVInoJ0OeFYeui55sJOJOyCbkowEI3y3fqjPS/xDUAwbwpUq/ly
	 cOdbXQh/jCkzIMMwtdpZ92uyf9Fw8JMQCJ0UTyg0tH+GOPl9gC/GwnIjRTzYJeAsCBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960016;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
	b=GlihVQZ+o14xwg4wPVupqwQVrY6CnWtmobXzSXjwfheDHi0NL+mjuXHLPYphQwzrnxCg
	 UBDbqeRF/XDrZmQmt1v6eF/lvtThUTWPGaOiPsrDI6In7UEvtJY3M8oVXMdbOaxw20jJf
	 4yRLuN9zYjVg2GLo6tnO15z1JsV28dQD6WztmOmgWFpav417fZXwSWfX1K16z8f84JAx1
	 ArkITx9VLXpRAkeZOek0ALI0yBvn/h3HKNpr6i9AcP9fBHG5MQxE2uK+WaHxWUMXoW2p+
	 eng/L1bGL/+rRrEQC5IGfrUXD7GoaFO3dJsdmr6/bKRqoWoC4iX3Wodihp6amEYWDiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=oa6gXNw+;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672E606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6672E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=oa6gXNw+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794960016; x=1826496016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
  b=oa6gXNw+otzEbTyi2B8xY4oTTklcpY3SWeyOjO2tmmuN8jSDJiLu4wyY
   MYbTpvwCcNHQP+xKs3Y7q04+LjRx5UMfjN3QTlIzVgSfehdHP7zrrmOxh
   RzeBAKzpaYpPnopVdn3ZhcCrnC1q29OuK1Qy1vOl44lDLj9n5SFet429R
   oosmW/vKwd86uUEIw2ZybhxYjlPEOJAC5CTrhJvSCnSDRVI4XOXVUdBVY
   6Yo0e48TVE/2s9SMB3RtZLk4PRYQ+xSWuwSBh5fkCCggznoVeKJ4rLriT
   fz8fOs/37fNhrcwMmAYvFTkd21F9ZVv0hJJTOdznDOI3Tzivk0xSNm4O2
   A==;
X-CSE-ConnectionGUID: OG0FcHUyRR+azTgh2pDDGw==
X-CSE-MsgGUID: w/bqVj+ARtOeEm3H4xOtSw==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34242486"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:00:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:25192]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id cf74f186-38e3-4978-8e20-0278acbcfd35; Wed, 18 Nov 2026 00:00:15 +0000 (UTC)
X-Farcaster-Flow-ID: cf74f186-38e3-4978-8e20-0278acbcfd35
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 00:00:15 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 18 Nov 2026 00:00:15 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 5.15.y 0/2] netfilter: nft_ct: move custom expectation support to helper
Date: Wed, 18 Nov 2026 00:00:00 +0000
Message-ID: <20261118000000.835231-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Also in this series:
  - 6fb421bd07f1 ("netfilter: nft_ct: expectation timeouts are passed in
    milliseconds") from v7.2-rc1 is included because it fixes the
    timeout unit bug this branch has, and the fix's moved code uses its
    jiffies timeout.
