Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227111;
	b=BY+o1lG5a0gZngJkKlXr1pGVQGWp7Rv06fkwCRaVDXb3NBBUXhGtZW92P7FREAtaQjRH
	 03Fn1htusQDpsXkszR+uCTcgrDPJjvtQnA1P03j7lzSNsGB1jaXp4NA/lSMtfUunwh38H
	 wQd7l6ChNg+3nG5JTf5jvIhAk3OpGZC3182ODgVce83g/Fr8s6ACM9ZHqjOsU0zH++/Af
	 xZBxFQ2JG9NRgJTAcOu4+rxPLEd5centm2H+u/pUswa6kT07YZsJeaFpqQXvnF7Pmd8Eo
	 SLMDG3MoN75vk9jlTEv1/L2gcTYxmYo9D1O78yMWcoonxuTSvdORnSVOuX7bCk4mVfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227111;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=krPYFvRCn7MZV7TmlVOcRGVHAdfTM4LBJcOvPC3fy5A=;
	b=iVrH7o/yd91GJrZge+iRwQ9oyn+sfPZ4UFM6QdLDPfZCaT+TuLaUx87PdhES6tGmovBN
	 2KR8eV/c4aejvpXv0qZTkw3rrgnn/0GQi8ThSO3GYjb7HDrk7gjn1wotoArGCT2Cf+lLb
	 Sugxpq75Idjq9DAJ12m9w7+55+WA/CLYRnUWugebnjdfeaOzv4Yq3z3Z4JRRMhrFfAmbZ
	 FvGnPiLjOk/EGrZtsutqvZOz9FTzDn24adlVxCnWl9rBQzzRq2T1PyYUe6eQ78EkTW6hL
	 hRIOt5w+o+PjZGcngOpkFHOPxWsAdJvUdu0DR6f1hzXJBq1o2t0DoFfYGd0Rw/46Lew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b="DHuOvQs/";
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8E553606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E553606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=DHuOvQs/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1794227107;
	bh=krPYFvRCn7MZV7TmlVOcRGVHAdfTM4LBJcOvPC3fy5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHuOvQs/Uf92vxWrkkVAO5aOiAPrUxxlS98XJQMV4aFeQpH08QjFfJ7miUAaMU7Qo
	 fwMSEANo/zVXj4Z7UqXUBHL1lchV2WyWlg/LnB9o9tJ+fv2vTK8saCoPivfWxqFIqc
	 mXkoxbhZSlJDECGuHeM6sp6usSEqFi93XhJeGC0yds6hd+sj6M/+KqTpIgS68wlkdf
	 mtYYJieZgRnNdmM1eoO84DrLoFT18KWN94k/slgry8zr9Fbj4P/WBbRAx7Tjz8t+7t
	 ioUPpqfhd+udP2hL8gtLnAhstrUb75PNFBkm5/IV/VGGDr9/kNXBdlIzOVqWpwjRkM
	 UzamUqee7dUtw==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 9A96860058;
	Mon,  9 Nov 2026 13:25:07 +0100 (CET)
Date: Mon, 9 Nov 2026 13:25:04 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] Revert "netfilter: nft_byteorder: remove
 multi-register support"
Message-ID: <avG7oLUJ39PZCken@chamomile>
References: <179422696909.5131.4005481731765358036@gmail.com>
 <179422697447.5131.3947908931395034167@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179422697447.5131.3947908931395034167@gmail.com>

Hi,

On Mon, Nov 09, 2026 at 03:22:54PM +0300, Abdifatah Suruur wrote:
> This reverts commit 3c5fb3a6c8118d15e60295e76fb5b879021eef43.
> 
> The upstream change removes multi-register byteorder support and is
> tagged stable+noautosel because nftables versions before 1.1.0 can
> generate length/size combinations that the removal rejects.  Backporting
> it to stable can make existing rulesets fail to load.

Yes, so why are you posting this as is?
