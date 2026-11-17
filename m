Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959579;
	b=1vxCvKmZCjvE7W+x8sQCgCX9nxmMxdrUHnkpPf0w43GnoEDem5URLUzPMR139RTu2HCO
	 7WcOQbnpxq7asdhyG7OcaBTA6wQc3/lbrPlF2rEvPkntV4L0fYFltx2vaVmvCLow7KEFR
	 KPEcH4adFxOkUHDj0eZteSfn/DNqFr6k+Cajm+BpqPrAs6yDswO+WRQN1L9zDAic6eXBZ
	 4gE5cK519CQUKpwaCUnsZo+MVY57Rlf6bgXSsxRmXDuV/wCtlKNBcr5sgR/dp+hWl3CFW
	 AV1/rLRddslp/2j93fWCjQEW8J0f2aDXaQ9OXorzfa8lZfdUrodMvl/iGkuLAxbT4TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959579;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
	b=fJpqqpTSZebmyzzxrCm3YVsMmzc0tf/hnvGZJ0wjaaK2/eShaceRBb+4KrTfc96BW73o
	 V40iRXSIUX1lNE58CfPn3G93zC+3FTyd2k0sl2TAFQJIVGCJ+b4hGE7ME9IdlPP6HrzxM
	 rUgBqi0PEaNWyC2++sHu8XyJv6Z8gSnEH0JyOcEFGzOBWov+Wzgc33Ulz5M0e8OJxFFNN
	 au6puEGlYSzUvxOLFgcW9vqgMp79fwtthVnup0gCNIjx65fe5WJ9odlSs9W7DRVjgQedi
	 mnQRYwTygjCiYEkWnKH/kuUjq48Sxv+lu/yj5fI5eMrdBidqojg1kG7TgeoJOq++fdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WwDYqizG;
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7B606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C7B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WwDYqizG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794959579; x=1826495579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oj27ZoZRGO6f9l0rOjkFlS9AJ/pIHpImGA5GqGadkpg=;
  b=WwDYqizGkCtevghbHi8ZtOX+BTot2UpFeq/EzB5pEgjvt7LdqNUEQu9/
   xTSgBqD6R2ZDgmh0cxyoI3qCdxBiWA6Zy8fIRKmMVKDuJ490izmV1EVqx
   nZeYB3RcF7tH+zg0mtcYiFGfu3vzN/tKzFwNlXUqWJOwOjbmRz+lokJY9
   8j3Wm1/Jq7o8dAQ+1Yb97i5SKVh+FFektQSVzhFvYeCTFaaP7CxXbSFa4
   6XSrU+5CXtV9FAXjlGZQ5i/aa3DjITHnEpeZw+NqBQ+zAPFlD/L2fXPrZ
   tl6iJLCbNatWvbf9/M/4jS4yC9RFphUe2WZo42YigbGaTDNZqJW7yLRC7
   A==;
X-CSE-ConnectionGUID: ENDh3RsHTFqQhao98DSMTQ==
X-CSE-MsgGUID: 4WWWLvDZSCSBgu4RTNM/aQ==
X-IronPort-AV: E=Sophos;i="6.27,219,1787011200"; 
   d="scan'208";a="34130635"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:52:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25210]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id 87aad382-fbbd-4628-95c8-ffa3a7e4213a; Tue, 17 Nov 2026 23:52:58 +0000 (UTC)
X-Farcaster-Flow-ID: 87aad382-fbbd-4628-95c8-ffa3a7e4213a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:52:58 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Tue, 17 Nov 2026 23:52:57 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>
Subject: [PATCH 6.1.y 0/2] netfilter: nft_ct: move custom expectation support to helper
Date: Tue, 17 Nov 2026 23:52:46 +0000
Message-ID: <20261117235246.984294-1-mkbund@amazon.com>
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
