Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987913;
	b=BTm7Sp/AL2UqSfxPEds1/xBe/maRQDkufOhld3sASRlbjR3UeDtTruFlmwlTRvVL3MR5
	 vjd7Pl8ud5xJkKfawULR1D1kwUDJyfdRtr4eQ61RDndmqsUSoPnoLxd38HEUI0pd2uaFZ
	 COzCdm5Lmiyp+X4e5sRnJd6HWP4prDO5CoVKAFxWx0sUb7WKeNODlOC2VtluXq2dLuZ5s
	 CUoRjQyNFN6cDdTt+cEsFbEErKAAiyuU3vwOyKJdE3OYipK3l3Ff0nVLRHxsNVoe2Sz/T
	 pka9NKZRGcd0bSo89PD++Df5cypinACIT/FbFNUEzQmcOkCD6GXkzfuH69yQ/cvBpkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987913;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=DvwQWrNQDsi6oCmlPjAhQ6lQDXeqrlYyqk44/rWhVUc=;
	b=aIy0fo+AtS6LxvoofvJiza/6nvghVphKT7G0zp8AKVilrZB9FJBRjfHE3kaSGt/TSRfx
	 3MzeBySnvgl2xqV3r19TjosnY/W4lfyk3LzkLBpp/uuQnKTnIW+iKhw95KIaQwpYcVHmT
	 HEdCQzb/sxveQ+USebdGbspqN0uVIwuYcayWiUvm9RQ2gQqnTiKjW0HkOVozsmzMGLs/m
	 v8zYCyHLoLRILQVxFfs+sS/W+CPUv5LudkM4wzMniHt7gSogMzVBXYBtq/IaclOPu4zVp
	 gZaY4OauPvmZZAFf+I5kYHhMRo4ikkNuBxcEaVIbn21clVH6kEJOLlUSn1OqbS+s+NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=eajUapb7;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056A606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E056A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=eajUapb7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793987912; x=1825523912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DvwQWrNQDsi6oCmlPjAhQ6lQDXeqrlYyqk44/rWhVUc=;
  b=eajUapb7HeXa2ZSkTQoCye9KfkJrMc1lf63pi4iolwCYFDu1IXsSqbC9
   aAbZDcS+8SG4z5DlKPGHJRUo3IhDznkEuvvij19aEzJlnI5QeEVDcc+R7
   XACXZ9WNMhFnDFw6/RqnLLo+YUIEuAqcF2TI6P2Ir8HaN1xnU6YmiNdMz
   lokaU8395wtdkV/M7W38livo9K1sxRxHI/zwKTRT5u3SowDl5ADeH95rm
   nSKqTE/gO862AW//2cU1JbpoKzOJDznfDkfknyWHNZgTWBx3UMlDtTfuC
   mgdKEpW0+uo3FmDZxgkc9ezru79ykqMef/2VdNWNsILXkYq74maNHzSVF
   g==;
X-CSE-ConnectionGUID: DiyCP6ohTQ6hyTimUcVrpw==
X-CSE-MsgGUID: SxmlFa6ITHaks0tl955W+A==
X-IronPort-AV: E=Sophos;i="6.27,197,1787011200"; 
   d="scan'208";a="33332192"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 17:58:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:1052]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.208:2525] with esmtp (Farcaster)
 id 0d91adbf-b11a-4273-87a3-673ad09ef406; Fri, 6 Nov 2026 17:58:32 +0000 (UTC)
X-Farcaster-Flow-ID: 0d91adbf-b11a-4273-87a3-673ad09ef406
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 17:58:32 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 6 Nov 2026 17:58:31 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <sashal@kernel.org>, <stable@vger.kernel.org>
CC: <linux-mm@kvack.org>, <david@kernel.org>, <yangge1116@126.com>,
	<baolin.wang@linux.alibaba.com>, <21cnbao@gmail.com>, <david@redhat.com>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, Mark Bundschuh
	<mkbund@amazon.com>
Subject: Re: [PATCH 5.10] mm: replace free hugepage folios after migration
Date: Fri, 6 Nov 2026 17:58:19 +0000
Message-ID: <20261106175819.1829099-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026-11-06-1-daily-reply-0018-mm-hugepage-folios@kernel.org>
References: <2026-11-06-1-daily-reply-0018-mm-hugepage-folios@kernel.org>
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

On Fri, Nov 06, 2026 at 11:35:53AM -0500, Sasha Levin wrote:
> Could you respin 6.12, 6.6, 6.1 and 5.15 with the full backport? The acked 5.10
> patch stays on hold until those newer trees are covered.

Will do. Thanks for the reviews all!
