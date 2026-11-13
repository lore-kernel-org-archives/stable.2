Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590716;
	b=uDgTnSmmC9DQrFnF0ISpommZSpU8qEGhBhwTLgbl/FS8xNmu2BBUTKdeMvPPAejDHVs+
	 gutUYrSUZLBFdtGdyo/71sg52NIzQayPRZs9tR73kmd1oBzmdH/VGQ1M6k4FgSKUFBhZc
	 mc9bKWIKCbkodrF6T+Ki7aMP2/dMkKbRH2uUbaoecS42uNqwMJOhmbELEdj3RD1Q5zVbH
	 uZ8WwcDAYNE9H5GlEnevyvM7Ma0X1fQSidN7KPKwM4XWn1dSKMQ1jbdf5zLwIHI6jQn/Z
	 95ro8izNc2hQDtn4kITsUzlZeQvh1tRjYDMQKrP2wr8cPI6H6WuBNwrrJHbO1K3C/kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590716;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=HY6dI5v12oKUy5NmDl6ySHIsosdEy5nqHF9TYC9BM1Q=;
	b=U4SnGWyHupOPwrgZKGl9YH2ncyC0Ot6iJ4FRkt0jT71hz1ZU5Utsaos04v1jzpELzYbk
	 gtBDi4ZS2+PApHy3+HgbLJLVaPV0BX27l1U81jbS5sbD22KdfMnIA7NoWFRs1ivZeO8JO
	 cGYV+JTBP+NaB3cLFzE/Ztlg4ySkPCWgZEFLhPzbJ664Jva52XMwfZe6x4D5Z2B4ZJ6Cs
	 y0U+qjDV1g2MhwHiznIGVwCT26ZV/Lyyc6wqclXqhvUm+4jUB5zixcOZyXVHL6WdOALwr
	 4hD816vdUEyt1qYrTYZFEwliWR8dVhBWmQF6JqxHoRNPgmTaaaPzHAWHjE2/LAq6CRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Z4+6wKZl;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05390607A5CF
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05390607A5CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Z4+6wKZl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794590716; x=1826126716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HY6dI5v12oKUy5NmDl6ySHIsosdEy5nqHF9TYC9BM1Q=;
  b=Z4+6wKZlG5by/g2JegMrxFcx84Yon93F5YocrqlzzAQ/MS7WS9ZOKO2x
   LjO773XhkHbJwqVYzeiCiDQ4eb0KrKND+1VT10QLHsSm//4KhBMn2jzaW
   AwORvrgI4IXBWIMTHWkwFhg5eiBp8/pZ5KWZB2w9o114eZ72D5LP4zzWv
   SEcMe9tn4STSSzmZT+JoHdcgU9mC1MYyCvDpuOGrW6QGKQYprD31IQNVb
   qflGrG/oDv2OrC35fCuLlaO8XGH+Y7wZwx58nRuAMe5wBTAUxNGBcX5+Z
   xY3BTiC9bv7tJw/IepfgNhXvklJr6gcBki3xDWePwhB3kcsVYEz5kStCG
   A==;
X-CSE-ConnectionGUID: EKhLIAMGToyQ8U+xLaEr6A==
X-CSE-MsgGUID: WP6HIuPzT4CzFv3MugVdJQ==
X-IronPort-AV: E=Sophos;i="6.27,212,1787011200"; 
   d="scan'208";a="33784678"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 17:25:12 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:17296]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id 94c61fee-6155-46b8-a4dd-419e51ce07f0; Fri, 13 Nov 2026 17:25:12 +0000 (UTC)
X-Farcaster-Flow-ID: 94c61fee-6155-46b8-a4dd-419e51ce07f0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 17:25:12 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 17:25:11 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Sasha Levin <sashal@kernel.org>
CC: Bjoern Doebel <doebel@amazon.de>, <stable@vger.kernel.org>, Chuck Lever
	<cel@kernel.org>
Subject: Re: [PATCH 5.10.y v2] SUNRPC: Copy the deferred RPC Call from the head buffer
Date: Fri, 13 Nov 2026 17:24:53 +0000
Message-ID: <20261113172457.222949-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <daily-reply-2026-11-12-5417451315@kernel.org>
References: <daily-reply-2026-11-12-5417451315@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Sasha,=0D
=0D
thanks for raising this. I sent a v3 earlier in this thread ([PATCH=0D
5.10.y v3]) that reworks the backport instead of applying the upstream=0D
mechanics.=0D
=0D
The short version: on 5.10, header parsing advances rq_arg.head[0]=0D
via svc_getnl() without updating xdr_buf::len, so=0D
rq_arg.len > head[0].iov_len for every Call at svc_defer() time. The=0D
upstream guard would refuse every deferral, and copying from=0D
head[0].iov_base would drop the headers svc_deferred_recv() expects.=0D
v3 therefore keeps the skip-based snapshot and refuses deferral only=0D
once a GSS integrity/privacy unwrap has run (rq_auth_slack !=3D 0) or=0D
when len < head[0].iov_len, since gss_unwrap_kerberos_v2() resets=0D
buf->len.=0D
=0D
The same rework applies to 5.15 and 6.1. The assumption upstream relies=0D
on only holds since header parsing moved to xdr_stream in v6.3=0D
(163cdfca341b7, "SUNRPC: Decode most of RPC header with xdr_stream");=0D
5.15 and 6.1 still use svc_getnl(). I see the verbatim patch is=0D
already queued for both trees - it will refuse all deferrals there,=0D
just like my v2 would have on 5.10.=0D
=0D
Want me to send v3-style backports for 5.15.y and 6.1.y?=0D
=0D
Best regards,=0D
Bjoern=0D
