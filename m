Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77935DA6A;
	Thu, 18 Jun 2026 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767499; cv=none; b=g35xnSD98et6HsGAMvdmC9PF+isBlvQmPksZfKfhANBIoifDk6Tdqu7cG0ibrrlIvAV7jF5LDPZcktBpLV6prNkZOUHV7EHUdBxV2NVV4ugCodvw8OmAN9MCAEfeDHnPJCDjwlU39ofiaSDUgoiTKFP0aaGLyADfFdrolwhcK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767499; c=relaxed/simple;
	bh=eMVOWU/uMx0ikdQOoo93BMnnHU4y7zNCRnmm1Qt2lIA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inO+gUQJLGqjkmVgD7ul6MWL8b8R2HSsWJlKYB2zQSPVrdFE5oYWySTrVIbQaFEB7HG4H/Xj0U7wQzxzXDOZkJ6lprMe5BVgS83a2u5kFE4kWlx+nK8qR/5PqX+Qyu7x0EnZvNLJ6ekGlXuaTwlIZgR8tB8W6Qr4H/UkOtVfBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mmB0avIp; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mmB0avIp"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 70FA820764;
	Thu, 18 Jun 2026 09:24:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r284IHQRo832; Thu, 18 Jun 2026 09:24:55 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B285420704;
	Thu, 18 Jun 2026 09:24:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B285420704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781767495;
	bh=Eg5VCvmtQtwL/jJ+RT6x7dXc6NpwkPsoEfGg0bhj0sI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=mmB0avIpZRDM8FuOAEBNrOU3jZgjRGPagIbya3Jb591qIcemYSIERZBUHKHhcOIZG
	 njo5BfZwhptaBcEieS+v74fj62epqZ4NIxtvRu7OauYoqLodWhi8RMe9eQa+a7fnsi
	 8I91jGYKOI57nXO2AmiMdcHQrA5b198dQowEbx37Av1MtZPNVLXYiWg6j6LVR5zg3j
	 nrA1cQjwFG++yyV2HyGUKoctuHafSprBiWQv6nWvp46YJ5T9Q5v82H0fjUwZeq7Wzq
	 Kxufq57NGWNvYT/nSKRj0c90O56KhgApEKejh3rWbY91QLY5BNJgCx2zDZN1Z0xvxf
	 tFSgy7WOIy1yQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 09:24:55 +0200
Received: (nullmailer pid 3963291 invoked by uid 1000);
	Thu, 18 Jun 2026 07:24:54 -0000
Date: Thu, 18 Jun 2026 09:24:54 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Aaron Esau
	<aaron1esau@gmail.com>, Yiming Qian <yimingqian591@gmail.com>
Subject: Re: [PATCH ipsec] espintcp: use sk_msg_free_partial to fix partial
 send
Message-ID: <ajOdRs75eyKgFSfj@secunet.com>
References: <68ef5bdae251f605b0743d2e51c2a5cb285e5772.1781270325.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <68ef5bdae251f605b0743d2e51c2a5cb285e5772.1781270325.git.sd@queasysnail.net>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Jun 12, 2026 at 04:11:39PM +0200, Sabrina Dubroca wrote:
> sk_msg_free_partial() ensures consistency of the skmsg at every
> iteration, without having to manually handle uncharges and offsets.
> This simplifies the code, and fixes some bugs in skmsg accounting when
> we don't send the full contents.
> 
> Cc: stable@vger.kernel.org
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Reported-by: Aaron Esau <aaron1esau@gmail.com>
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Applied, thanks a lot Sabrina!
