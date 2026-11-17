Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959205;
	b=S/vJrBLMoxOZppUuvG8j2zL/cNYZP8wFcAPDwJQwSaw4LjbLToHMKeIYtd2UUQIYAYEp
	 jjk5A+safnD4CptyNj+hQyInWJNi+GT3/UOjAjWsShFrAYZW4ewmgv+mfUzouiQYQDpPE
	 TSF37/OdaCM8bXsyktL98XY5AcZ26tC30NfrktAGV2/E8/bG08SvH2fH+4nxKCOjst+eH
	 573AVkZcCLqhQ4r3FWvMtAn/PWpENqTGQuJDhblDAT9oi8Z8Bjg3+as/+gPZHuPYrNbIy
	 GAE+kwA+u1hgDH76yMvVLKhysYaLqxvS5TzwlDqOdjEwZeubfk9sp2/SYBB2CJ9vJfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959205;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
	b=scuSHudPuKubtQOzmBnzuCmZknqtxM/sjEReyc2hQz2STC7jvbenxKMpN1H+CxjPySWr
	 EehdW9iRUtILjZEGz6xbDLP5LTgJBWyGhpxoyjgcNeoqqOA0KtpievJCrAUHPGNbgB0X7
	 kC16TvbuKew4AzuBng3L/llQ27MV2zFk5LksrIFyd2qYuJSjdF9ZhKIvoHjMu0QNlDFMo
	 NQhRFMbGig6tVN3cblg8PMCAGK1fLtPkggDu/xVrdwDOC4L48NTWWeMc0DwFr4/1oEf47
	 wUR01efQjyPN0Mo6vvR2RGkImawOhPrnuUuK7sp4OTFrri9CoBYqKRtY37LvmwhDl0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=f1lk4Z19;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D7606A331
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6D7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=f1lk4Z19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794959205; x=1826495205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
  b=f1lk4Z194pxmXnY36+UmrIkuApFwFVIVHjYCkXaq4RWwQSTnM3SPXU/r
   4MTilYu/E1991JwDvp/UpUvOyS2wz3MEphdaZxgCyHsUAmN2zlUI8gpVW
   dVzCr+/V8FYEyt/8Ksi0XFBWc+t7e0Kyy0eXSq4dHZXDJc28E+CVlry8n
   HTSewb6J9ciRmJeNp1MlanrPicThuxnbHMnq6GoLVYpxXMnGXzpsAktCZ
   jGYY8YSoZqX/kvPv5bKM1zPSTLNx2PxiOskgv1xJG4wmVr2WUiMyiHiyp
   ah2obtvUQEH+HJzP3iKfxFt1nkX9yzHayVPdvK6SRZ8d3Hzo0Eo8fIdRk
   A==;
X-CSE-ConnectionGUID: 5JCDnY1NTYG4wVFpvNFjKg==
X-CSE-MsgGUID: m62p2sBfSZ+WOlSiIbJ0UQ==
X-IronPort-AV: E=Sophos;i="6.27,218,1787011200"; 
   d="scan'208";a="34366155"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:46:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:15432]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id 6dfecd77-fafb-4dab-a19f-2b8b43986160; Tue, 17 Nov 2026 23:46:44 +0000 (UTC)
X-Farcaster-Flow-ID: 6dfecd77-fafb-4dab-a19f-2b8b43986160
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:46:44 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:46:43 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.12.y 0/2] netfilter: nft_ct: move custom expectation support to helper
Date: Tue, 17 Nov 2026 23:46:31 +0000
Message-ID: <20261117234631.165899-1-mkbund@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Also in this series:
  - 6fb421bd07f1 ("netfilter: nft_ct: expectation timeouts are passed in
    milliseconds") from v7.2-rc1 is included because it fixes the
    timeout unit bug this branch has, and the fix's moved code uses its
    jiffies timeout.
