Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4AE305E28;
	Fri, 12 Jun 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262842; cv=none; b=UF7r1vSQ08IUefKWrckAQ/QfwbhkOv2Ftyn0otGmXhfjPBFeLzDX6FQIoH27BNKErYv3J9CGOPaaPC61G+1Y9KWLQRE4wxA74MIh1jcaNYos/9o6IxOAGnbq2DvZTqIxpqSu3Bj00bQa5gRZYBLTsu2S3+Ovym51lxQIvXXBzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262842; c=relaxed/simple;
	bh=TqIkXlTFp5tApvq9Mrb+l8MKhAe5UPxRBAGol8+33xA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rVFUfe1/3VpCGaq0XQYPFTSoUGKvHWl0kBpOVGuaO/tieaSDcu5HhFcwQkU4VdX9xZHVFueKK8zGrQP/gRXAyjWqOQb0z71NWiVMONDNF1zR+BBOOgZfi7/PWbAxjjVsrV778VHQ7GB62xgFgDlNcj2zXKZV73lss5UYV+kRdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=ecgnTixA; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="ecgnTixA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781262841; x=1812798841;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0i0Xr9O8UxEcIij+JC3Z+Aqveb1gor3RZ8LiH1ODBQA=;
  b=ecgnTixA9FfmxFjlLtyRJ/mDr4kNRZPqop+/CiUPHiDRncMaBWgctCnj
   bElhFWlt4IU0wEBxAI8cGZj9deDpuF1PoYolWtllj7wFPfoOzPbdO6SHz
   b/CavpclvQif/gpL6reqCznI6f1jFNrSOw4YEfpfEDGqSpzBVFD/kPFXa
   +tmmXCoGWtz13GZ61nPFqLlYpOwKEadHDNJTP15CfuHI8OdaJOf6kyOeV
   hrCxFals4Wr0m/ZDTkem6tmNgvdtcNvwUDYzSy2fp5cXylbEcaOqp71Iy
   pFkZkPcOt+FNw4Y4fHzk05QDGvW3O4PXfJlM0cSU9zTaMQntD8+CT7XqE
   g==;
X-CSE-ConnectionGUID: Yd/9YFuPTimWpvn67A2L8g==
X-CSE-MsgGUID: 8K607Q6wS8yUuzFwGcFxNg==
X-IronPort-AV: E=Sophos;i="6.24,200,1774310400"; 
   d="scan'208";a="21503094"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:13:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:25644]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.146:2525] with esmtp (Farcaster)
 id 131e37a3-9451-4203-9589-7f337fc28249; Fri, 12 Jun 2026 11:13:57 +0000 (UTC)
X-Farcaster-Flow-ID: 131e37a3-9451-4203-9589-7f337fc28249
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 12 Jun 2026 11:13:56 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 12 Jun 2026
 11:13:54 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Simon Liebold <lieboldsimonpaul@gmail.com>,
	<sashal@kernel.org>
CC: Simon Liebold <simonlie@amazon.de>
Subject: [PATCH 6.12.y v3 0/2] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Fri, 12 Jun 2026 11:13:25 +0000
Message-ID: <20260612111327.1613710-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for the detailed analysis on v2, Sasha. Here's v3.

v3: Backport b05d42eefac7 ("xfrm: hold device only for the asynchronous
decryption") as a prerequisite, making the tree structurally match mainline so
the fix applies without the lifetime gap Sasha identified in v2, where the
dev_put at resume: dropped the ref before the re-hold could cover it.

v2: Restore unconditional dev_put at resume: and instead take a fresh dev_hold
immediately before transport_finish (when async && !xfrm_gro), avoiding the
reference leak on nested transport-mode that v1's suppressed resume: dev_put
caused. Prerequisite b05d42eefac7 ("xfrm: hold device only for the asynchronous
decryption") was not backported as it restructures the lock ordering and resume:
label semantics of the decryption loop, requiring non-trivial adaptation beyond
what a minimal stable fix warrants.

Jianbo Liu (1):
  xfrm: hold device only for the asynchronous decryption

Qi Tang (1):
  xfrm: hold dev ref until after transport_finish NF_HOOK

 net/ipv4/xfrm4_input.c |  5 ++++-
 net/ipv6/xfrm6_input.c |  5 ++++-
 net/xfrm/xfrm_input.c  | 25 +++++++++++++++++--------
 3 files changed, 25 insertions(+), 10 deletions(-)


base-commit: 1d3a00d3bacff25652c96e1527610c69e91f7c38
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

