Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923349;
	b=3TyOfQhnZ0ksmHy1Pt/Hfa3sI0Wc9r4vVqghNyYgefbR3Opob/iXgp9a6lCgkKVstcsV
	 V2Ktzb2Ds0ASEVRA9y4txwNGkS9A3Z7AxiKBaXTpyjwycNo4OwbSOiftGYM4DA4g7OFbp
	 gyev9S8xPyeO/+oexdBmOCXoAsO5Twb/rnnwyxRZ8l6QLNXhykCVGLE70hh4LC+YFvB1p
	 bhTE3/6asMSESZEopdtV9UZoUpnQUTtAsCgmcb7FEf1lnAJHUE0mB6igMhP+dTPLiNAND
	 eVxrq7flwutldomZ9QlC/GH7qg8Mu8a7+d5LVKcqUmJLIg2l3JUM0UQ5Y4RvdZqnO2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923349;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mBuZBK21hY2yAPxrYe4Z6icl9OWxEs7agGCHIkxmjNw=;
	b=e9Lx8ld5zYF+4GCdx/slVgy6g1TLT9rSi05cin26UWhiqT9Fe/icj4JGnKEqNos4hlAL
	 Mp+mqEb0ARGCEFAEQgTClc/uz7crw0SX6SSXP+S7bj/Kv8C9FOQNdCZhxTfaMda5VznM+
	 GgJneQaqZ/UhjBnPOSzjpbWEowtfcdd9tPbpqxa4aMtmJxgCjP6xsgRC2lbAwqs/tqI5/
	 7Gn+m/IWJn3g/KUBCc9Da0eJn94G31j5PgKFCiQhxglomh52ITzQrkv8Gtx/3psgPjiGG
	 RNQaBpcAMoe5UkkK0cOVlBBnT1vTgmA85PPaEhVTuPJ1m5aSOxZljfctLUC0CEibssA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=IQMZXMua;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBF606A326;
	Fri,  6 Nov 2026 00:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34CBF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=IQMZXMua
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1E0DB40E01D2;
	Fri,  6 Nov 2026 00:02:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SMaI-plM8zrb; Fri,  6 Nov 2026 00:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793923336; bh=mBuZBK21hY2yAPxrYe4Z6icl9OWxEs7agGCHIkxmjNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQMZXMua6hzw0Q3nxxL8AyXSsgOgMJHSR3/+AjLKyEa7m0slwk8opYnmTVDR+EirX
	 myjANDQ14OeX7pzy4Iwf5p+NMypmwc4bBJFLUqyaoEYeh/rbNT55kKggOrGGP3Xh0u
	 G44smmF2lY9K5eMA0J3A+0ZEKTu4WZpihyeDqT7AKfxe9nPPMX3cNHyNaXAnoRrukY
	 yGcz1tSIPEh1hNDMi6HdR0R5PXl6xLDNNDtMxnKYbulTc+lD6ctUuLy8+SfwK5rrry
	 Dxfev90cW6dBCgQiK9n6T6EiPNLX/+/TqML7MZExlsfUl6mPsRoRX5sgzjxRvcdtVf
	 +DnmHi76WjLFR3RA+6fRsoqYxeBCR7aZ7b5XwOok7sk+ofmBsMwtsEVs3NHtCZH0nH
	 XtVqp0JuNWUC+9h6G5bz7L17c67N9fTxvUybvT57BuErAQ0YWfbHTpMCMAuoPiRV2x
	 Iywc/9qyWmLIBN6I97KJPxrA8hiHbBKew9hoXpd9lKxvyhUqF1LSLll3llgOooJlJ+
	 Xny8o5Uv3wwHlfDC54tdBHwtIl/fzKeye5BgM0XxaJO2ujIn9Sc7mu26QVAN6N+aYY
	 CVRvD2GHbYK3MS7/IReDe6dl8tWG1ktbgJiqzw4JM6LiXSfN4fH0iptYiR0aZdsO8I
	 QaVjMLJsWzjRtCNA5OmIzVSM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 015C140E015B;
	Fri,  6 Nov 2026 00:02:08 +0000 (UTC)
Date: Thu, 5 Nov 2026 16:02:05 -0800
From: Borislav Petkov <bp@alien8.de>
To: Weilin Tong <tongweilin@linux.alibaba.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: Re: [PATCH] EDAC/amd64: Fix double free of private data on
 registration failure
Message-ID: <20261106000205.GBau0Y_faMvFp2_fM6@fat_crate.local>
References: <20261021062925.1838750-1-tongweilin@linux.alibaba.com>
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
In-Reply-To: <20261021062925.1838750-1-tongweilin@linux.alibaba.com>

On Wed, Oct 21, 2026 at 02:29:20PM +0800, Weilin Tong wrote:
> If edac_mc_add_mc_with_groups() fails, init_one_instance() calls
> edac_mc_free(), which frees mci->pvt_info. probe_one_instance() then
> accesses and frees the same private data, causing a use-after-free
> and a double free.
> 
> Clear mci->pvt_info before calling edac_mc_free() to leave the cleanup
> to probe_one_instance(). The normal remove path already clears it.
> 
> Fixes: 0bbb265f7089 ("EDAC/mc: Get rid of silly one-shot struct allocation in edac_mc_alloc()")
> Cc: stable@vger.kernel.org

Stable because?

Are you triggering this or some tool/AI caught it?

> Reported-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
> Signed-off-by: Weilin Tong <tongweilin@linux.alibaba.com>
> ---
>  drivers/edac/amd64_edac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 0c0d11c72925..edced7cbe83f 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3975,6 +3975,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  	ret = -ENODEV;
>  	if (edac_mc_add_mc_with_groups(mci, amd64_edac_attr_groups)) {

What a mess this code is with passing pvt up and down the chain and making it
so easy for people to mess up the responsibilities of who is supposed to free
allocated memory... :-\

>  		edac_dbg(1, "failed edac_mc_add_mc()\n");

In any case, this line needs a comment explaining why this ptr is getting
cleared because it is not trivial just from staring at it.

Something about probe_one_instance() as the one who allocates the memory, how
that one should be the only one which frees that same memory.

> +		mci->pvt_info = NULL;
>  		edac_mc_free(mci);
>  		return ret;
>  	}

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
