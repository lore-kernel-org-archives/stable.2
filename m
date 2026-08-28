Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0001DF98F
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912194; cv=none; b=I+/cumDpL3zV7V5TSpf1m0fi/tlAy7d82lIFQTtElTigtY0to6UZ+jU1KfYrAielvShhYSg8EkkAHyZzaNIM2xJzWnXzPIDrEQi+21rf2ZhP2QYuNliXT2rOzHdmh1oTwVRfSQQFu+bNoy5W+L1viOB5BPl/ut//zGHb4HbaVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912194; c=relaxed/simple;
	bh=mL5wXhAUA17zffxtD/O8nf+NAAh7PCUWFmHkdCtDct0=;
	h=To:Date:Message-Id:Content-Disposition:References:Cc:From:Subject:
	 Mime-Version:Content-Type:In-Reply-To; b=rvzkKo+e0w1WTvwhDnWp4hN/OOoPLX5+wggEfi1SdnF9Xmxl+JN38FSrOyj9TrfCxXWYPnDwKORxWZSTSqM/HoXCulGQSbthUYE0i47PNb/u4f2Cpl9hXbIa4GIpPAGsL0jJGfpw2SR1ydAesKDZs0EKpdcQEnu3EBbbzXEhaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=sIOSlB7w; arc=none smtp.client-ip=71.18.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="sIOSlB7w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787912188; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=NTtymu3QcPJIr6UXvu2by4+Uusv1ReFlqWLnM3no9vA=;
 b=sIOSlB7wXVavq5vFrcAy+N4undITotsFoaH6tF50slmOUkM1PK1JneJOMhp7e5fh0ToZZ8
 Ciyvm7JT3jYRHYvRJKcnTahEickR8A+LVssuffE2cxYRwI0nQVMPMgz+JaQS05ZpXMfLdZ
 wJw9n68hHxiJtJVzRBxjxXGZ+ySUzAMB05iZOaNO3X/QWm1sdu6baivP9rxfSyP7VdwROr
 qIP3/PGxK15O2dbBl3g5hY6ckDINu/oUyzh+o/FOtQC+r1pg8LjKFoFXHn8TH0IbbahfqF
 XJWtgSsnCWETjy1++vvJblqVygZDx8Lmxvo54NzwCbMTnOIpm6zk16oMJP8IQg==
To: "Breno Leitao" <leitao@debian.org>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a915ffa+3f3c18+vger.kernel.org+me@cherr.cc>
Date: Fri, 28 Aug 2026 18:16:22 +0800
Message-Id: <apFf9i99-DxoVqpd@pve>
Received: from pve ([111.42.148.146]) by smtp.feishu.cn with ESMTPS; Fri, 28 Aug 2026 18:16:25 +0800
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20260828-atl1-cancel-reset-work-v1-1-9a2140dab074@cherr.cc> <apFZbMGEnfRRz2IF@gmail.com>
Cc: "Shengzhuo Wei" <me@cherr.cc>, "Chris Snook" <chris.snook@gmail.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Tony Zelenoff" <antonz@parallels.com>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: Re: [PATCH] atlx: atl1: cancel reset and link works on remove
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <apFZbMGEnfRRz2IF@gmail.com>

On 2026-08-28 02:49, Breno Leitao wrote:
 
> Is 03662e41c7cf the right commit to blame?
> 
> Both works, and the unregister_netdev()/free_netdev() sequence with no
> cancel, came in with the initial driver in f3cc28c79760 ("Add Attansic
> L1 ethernet driver."), no?

You are right, thanks.  03662e41c7cf only renamed tx_timeout_task to
reset_dev_task; the link_chg_task, and the remove path with no
cancellation of either work, are already in the initial import.
v2 points Fixes at f3cc28c79760.

--
Shengzhuo Wei
