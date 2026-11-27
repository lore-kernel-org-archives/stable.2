Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771442;
	b=Hoc1sxURhDyWZTNvzaKMbp83A82Cj2xH6zYS3XqbCQ6sDUQNIj7PBuXeksG3meQT5fIR
	 Zjrwg69L39axHPOnhhZiLq+e7mG9L8D391SOpJOIEyvKctHGnnyp1d9omxjHwtOSEh/f5
	 LNGQSncbbf4lDEIXlQtRLIrbC0tdnSykdijWUmdWunJRibRC8u9cnVv15lH26Ye4fHinB
	 eAxi4p9X/f+9IZUJtHtPSJWgsElYVTPM+RsPeqUMLpL/7souxyKH6aB6mIlRrjXUAnV7g
	 3VyteAkBeqZjQbfW/EARHwXSMYiQQzv0HpEWFWkLo+OtFwGvCTUlRfmHr5487974ydg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771442;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=dcm3vEaafSdM/C5J8kdxevbXyamY5QJ7Qrldbj24bk8=;
	b=b622evEGguf5bmzbUUljpqrvnU6/UOb+MRgJPw8GEBqumy1JATm2f7nuYwPfuZylTkqO
	 QUh6AfJ2O+TqFSO6v57KLFzkvOgHVjpMjeDFsONls6hQy77kRF6rWddYru95mfei0XbGh
	 nwSs6OkxUJcEFiJJunDI9x1alJ/cOmOdmi26ujL3rrqP7S8VvMS+DwGvKrs4X46L0rBg8
	 4hCjvEyeK95U7FDgQOOO9iGR3Dp4J77gLhBvXuXqgghCsm1mI1gVO3FziPMg/ZFPRm4eE
	 GDgXxCsEIvJ3cPQxmEobFmX+Nb8bOSsmOE7ULXbJxzA3/IGHEqFcSuGHukiYcDVOFZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=cF1aTWG+;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DEC606A31E;
	Fri, 27 Nov 2026 09:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4DEC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=cF1aTWG+
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2EFB720854;
	Fri, 27 Nov 2026 10:24:00 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X0G047dj0qH4; Fri, 27 Nov 2026 10:23:56 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EDAE120839;
	Fri, 27 Nov 2026 10:23:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EDAE120839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1795771436;
	bh=dcm3vEaafSdM/C5J8kdxevbXyamY5QJ7Qrldbj24bk8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=cF1aTWG+3V4v29+SEEMfMv9E5crQnBDJI+uKpUmTQ4XutlW20uU/LPWcGFLyUwCJo
	 uvlWN1wpvUqCbIog9C2Epm9zBBXiH7v8dyiqhhzLqMvSBUAxluJNZy89XE4yBdc3hY
	 35pkRdopPK54hs34a09bq/7e+dOnl21rDyxG9SKRpvk394K+SUUL6juhKvOe9HgFKk
	 CFTNz0iCxH8mrHW5uR6wGMWRwl7TzlgPEMRDWRgUIn2SSoghmKU5b3Vy3B8h3wqB/B
	 6dX7Ezw6vslH95QHdfqt9dhsb8guiKqGHzZP19AcCDBfaqvEZwrppLmcDHsKn41eJb
	 /yMrbon3eMPHA==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 27 Nov
 2026 10:23:54 +0100
Received: (nullmailer pid 3467634 invoked by uid 1000);
	Fri, 27 Nov 2026 09:23:53 -0000
Date: Fri, 27 Nov 2026 10:23:53 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Andrii Tereshchenko <opensource@andrii.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Christian Hopps <chopps@labn.net>, Fernando Fernandez
 Mancera <fmancera@suse.de>, Willem de Bruijn <willemb@google.com>, Piyus
 Kedia <piyus@iiitd.ac.in>, <netdev@vger.kernel.org>, <ipsec@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH ipsec v2] xfrm: iptfs: make room before copying a
 continuation in reassembly
Message-ID: <awlMKdcVSQEShHlw@gauss4>
References: <e417c7f2-eaee-4fb0-b365-65cd521efd6b@mid.andrii.net>
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
Content-Disposition: inline
In-Reply-To: <e417c7f2-eaee-4fb0-b365-65cd521efd6b@mid.andrii.net>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Sun, Nov 22, 2026 at 05:09:25AM -0800, Andrii Tereshchenko wrote:
> When iptfs_reassem_cont() cannot share a continuation as page frags, it
> linearizes the in-progress skb and copies the data in with skb_put(),
> without checking the tailroom. An skb started by iptfs_pskb_add_frags()
> has little room after linearizing, so a larger continuation panics the
> kernel in softirq:
> 
>   skbuff: skb_over_panic: ... len:2884 put:1442 ... end:0x6c0 dev:eth1
>   kernel BUG at net/core/skbuff.c:215!
>   Call Trace:
>    <IRQ>
>    skb_put.cold+0x1f/0x1f
>    iptfs_reassem_cont+0x242/0x760
>    iptfs_input_ordered+0x382/0x3e0
>    iptfs_input+0x24d/0x630
>    xfrm_input+0x12a5/0x29f0
> 
> After linearizing, grow the head if the rest of the inner packet does
> not fit, and abandon the reassembly if that fails.
> 
> Made with an AI coding assistant, reviewed by the submitter.
> 
> Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
> Fixes: 0b352f83cabf ("xfrm: iptfs: fix skb_put() panic on non-linear skb during reassembly")
> Reported-by: Piyus Kedia <piyus@iiitd.ac.in>
> Closes: https://lore.kernel.org/all/20261119142308.3272570-1-piyus@iiitd.ac.in/
> Link: https://lore.kernel.org/all/20260908224855.1591147-1-kuba@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrii Tereshchenko <opensource@andrii.net>

Applied, thanks a lot!
