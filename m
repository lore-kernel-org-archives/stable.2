Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3C2D7DC6;
	Fri, 12 Jun 2026 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261179; cv=none; b=GF/IwwKkM5mter7L0LwGukNlc2XwEquFEl2GPekK2ZbU/Ej3Fo8zfZLmWMoB2nrePiN9vipcgMWfFnLvjrW11GLifeisd0gKk6mZkrIB28Htiy2baoAbvwBgLHaMU2kkr7mtEF+pRuFkBGYlUspKsAZo8prt1sITEDRxTFBVijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261179; c=relaxed/simple;
	bh=+sILituN4KG82vNPJYjOPPX6BS6Qew5yOJXh51BZ52M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8226wNUw7TgaP9o/vclujvR/lOBEr1an6SCVGO4urbv9zp/x3y3zn7eevNTPLIcNdqg/Jy33gQSndGu67nJJ5rJ0c5GE9TfN3xxVZM5OgUMK9go1Q6U5nKf+SSqSny4gg8VIyvpxoWabq3v+CCbXYPSskzhJIfZgkyEKjBxp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=No2gSJry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z23LG65q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="No2gSJry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z23LG65q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 31E2FEC0119;
	Fri, 12 Jun 2026 06:46:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 12 Jun 2026 06:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781261175; x=
	1781347575; bh=c7KQeGUqHX958aPT1jVdCDA0II0KEOujcrQ0cCHR8xE=; b=N
	o2gSJry5dq1qayTFRlLvQALYiB8ujYssMgZ3R6SZHrhXqwKURKMtJhexnjxdpRhp
	2aYhlF3sPX6lUhgJTOUC3qkoPmH2mmthLCOd0j//K1A0DonE227M1TbBWhEw4RbU
	QGmO3a9yMRR3siV7PUh/XcWeXsEBEfFKTReMg5ySVmRk44i2hrzroxY32jalqWuC
	nRNUY2zcgDTNl5Ewq0Fp5SrM886kPtEbvM7hSfmAjGEe2OCpdzbDphW7E0Jc+Fl5
	oUNwh27srbUWW36FOLe02mXbGCN7y9HcATSx8/fi76g0Py38vRd8ulOhnkMsjpiy
	A5YbDLKEnubDI5FrWm2nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781261175; x=1781347575; bh=c7KQeGUqHX958aPT1jVdCDA0II0KEOujcrQ
	0cCHR8xE=; b=Z23LG65quTUdmnsUqta4q1ZeabWUczpUEpVKCrEYfFY/uOCos7/
	QRsIRFfnaI84p56awHsoVFEgGT8+bzKA3qfueuwl0FGuLnco9padEd7gdCLIylvM
	LbCWStaZ50yJEN0pDnwHO6JjrYWkjeHsl5xw4YIaIKC1F5NqPdJW+38rl8DF1W43
	8U4aOwzB4N1ShhOjUzm8c8rcqNnKJXuCxcXOdgvzJyxgM8J5pTYDcacviR5pVz+F
	y6+7gg8kS1r1aH/MvhZQ3LsxN5HhG2v3yXTAEZ4bO5MrdDzmaXP+FWL13AvySlvg
	vqDAp24G7UlPwDbkQsZbrRdXwyWUWD5xUmw==
X-ME-Sender: <xms:duMravlqSeT8YTuIXvBGBINfbGcwG31OyGodJ69gbqXJ8Kb_5qPpkw>
    <xme:duMraigEZT4PlRsoAiadddr3pr5ehvQt6FKWGXR1VFwrUHqzGxjQk6AWhgg-G1ROp
    DqJPZnVr7r3WE1rd5gXmVcrim9PBUBMywJFn_zIH93kT_yMvMl8wjgY>
X-ME-Received: <xmr:duMrahQ7FzoMJqpWNCKLEgzVCT2l4nZGE1B9rhHY5gcE1YSFE2n5EUuLXE51lE6tASlb_86fFgmWBVFwa3aszLc>
X-ME-Proxy-Cause: dmFkZTGju7ZVUaDs3BUuCyZVhqHejPxvERccukbFBq77MdOy8+3OshSwJ9GSDuvf+YE/Xb
    CDSNf70pmGSlfSqjOQjjZ9G1xQWMudeOXEOwZlfvB17r/fHWiV1tfnxxXuheUf7P8QzzYQ
    xvlup3CVxbsPJ3KHPcBoWYok1DCUyCH+7TNTrPx0uIvUrlsLDNLLx1e8eJMPuIdmgVdIP0
    BP6F5HTcovJ5PruKYWGRLhrI35ZgaVzdQueuqnnN+2xg+Z+z9KZ/gUba4D/BSE+9KSkUtF
    x2YIeo8+GCNFwUzSosK8+PXm2XnZ1AILGSVQygnoxu6+OdXXIZfjzleO9rIfg8bLsWflO8
    y0/d4SyZryNKx6ewoIxmnEKqQjcgsE4QZRGLmxOU+Zqh/QWTKhEV5AY5LIq+Bfy+Z08Em2
    jkSwLXcYqVbRxwhg1Bbgxj03VpP5wkZgYeEwCui/1ffYfJql9LZZ/tM7oyd1Z0dVwiy8Es
    //Tucoh7oYfpDs9AN3pzr9n6u8L7GO4H8Kzc67Q9wF82G/NqbbWv4QtMCS9D8GTqNELDqL
    ISOMr/Jdi2nY/bKyJnrvyPX2+ztMDA7ckOcLwVxQp/2dX9nS2I87H85X8i55bV47FDeF3R
    FTVYWIKoEwM4ro05MLQX3Kll5WN338D4y3NZ1WshWgP/xD8lcApfuugtJ/dQ
X-ME-Proxy: <xmx:duMrajZjtmCxBhx68bYdxBd84aSqUMSGEwVlJk2Ru_cyDNclVyGLoA>
    <xmx:duMrauSUd0sVqE9yaURiVJUozq94VJlL8hvtOOelSWmPFc5FY1oADw>
    <xmx:duMrai9Yqluz5Pn8OXhygsV9v2BjaTrYXGReB5NZhzAy5KqjSweb_A>
    <xmx:duMraugwR93BzZ1FfewL4lmn1iahF4HD1TpgJ6qY0WL6QanPOOGzwQ>
    <xmx:d-MraiMyT94ueAG8eNZXbOG_nKpkOeR9UB8T8UCU0B8c8InaKkwDdMJZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 06:46:13 -0400 (EDT)
Date: Fri, 12 Jun 2026 12:46:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tls: fix encrypt_pending refcount leak on -EBUSY error
 path
Message-ID: <aivjc6MMhZIk1sNa@krikkit>
References: <20260612020133.11427-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612020133.11427-1-vulab@iscas.ac.cn>

2026-06-12, 10:01:33 +0800, WenTao Liang wrote:
> In tls_do_encryption(), when crypto_aead_encrypt() returns -EBUSY,
> tls_encrypt_async_wait() drains pending completions and restores
> encrypt_pending to 1, expecting the caller to issue the final
> decrement. However, if tls_encrypt_async_wait() returns an error
> (rc != -EINPROGRESS), the function returns early at the error
> cleanup block without decrementing encrypt_pending.
> 
> Since the -EBUSY path never submitted the request to the crypto
> engine, tls_encrypt_done() callback will not fire for this request,
> and the synchronous cleanup path (atomic_dec at line 599) is also
> skipped. This leaves encrypt_pending permanently elevated by 1.

No. Please fix whatever scanner/LLM you're using to generate those.

-- 
Sabrina
