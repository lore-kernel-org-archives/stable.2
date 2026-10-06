Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC035F5ED
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262245; cv=none; b=cFcLYPqfogM++p8hrBE0uyQFtGvsnS8P2wg5qrVBNPOrVeCIIDPh6A8bAXE/JkWUG1baTGscmixX1iGjLXn/d942NXxmTIvZSOmlrcpsWaihe6V4jt9z+ITKaKi+wGVRBGH/+kQAP+DwRcm3zLjrJUoN9PEiZICR6TDPV4NhZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262245; c=relaxed/simple;
	bh=N2dqD9oDAslSmVXglflxtsPusgZbGIROFq0AkRcGJuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obaZ93mDz0jJunPpKcR7EnKPuXvBwypWBeiDIpl96RYJSg7kqOaUpwRvrRgBjbWZiT2t3F3ZBSczfw8FxtFFHSQSL3uulSv37DP4DnfobnBwCxuYKUkN/XNOEkthpOYnuZ2KAQDFXyCq+JrrJozc/kW/II2R4UuZXJxXXHNGje4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA6l4r8w; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA6l4r8w"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso163839f8f.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791262242; x=1791867042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AZTcEpNIkmijk+TrbdyJk/7ltqjN6rjFrhnfuYd+A6c=;
        b=AA6l4r8wXhwIjavrQUNOvEdhUriQ3HJa8lH5kzOLkJxVjyh4IFqdK18xpOVM4XMJS/
         2D7CyrZ5Z8aeih+FIAvzeg5PvBh2QBTHc4D1fV4bLUIxK2LvThCCtq3eCkgYqHM7qjo5
         ojAhir7ri1vsTxHRScFbuC3/B5/y743im6YNJqq2wFORQ3b8K6BMgHQfmNtg1vuliM4+
         u8mvexLpSpupxTdmqUSqN9O2EsK4qcDvq9HJLAKTxAXS4FZOrKrKM3mX/qNFp9NAY4/r
         B17XqR3KBdq/lCQJz+EdnnELRWDpb9BRjaZhSI/nqzPeZHlpWZdSy21mhe3/DBHJsLUI
         2M4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791262242; x=1791867042;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZTcEpNIkmijk+TrbdyJk/7ltqjN6rjFrhnfuYd+A6c=;
        b=l6NXPDIQViikokkxXn01JtZ1K9/uMMYxQBd6ItyK74kCmOngBxfZ897Vc/ksvkgjk0
         A5mqnHpjXaN2COYr8LuaYeA/CwPd0qxh09E8tEgpxF1gvIh4yvUtOFv71MDWNQvdI8XZ
         YAvbBqo3HE1mBWblTHYXKXvbBvUI/DOf7n4iI4PZy0stQwFI/73bNTagv82xIgZhhq3d
         oAu93S5cQsaT1Ll38u1ocsQoRC7Vl8jNxCeZXHhTP1r2PSeO3bH/L44eHBOgsDzzRWuN
         fZOG/EiZdfnH8bPCRKub+KpZHVYTUp5wHFM6TfG3NdHm2GKPeAc9pT5/xokjqihOdGD+
         7JOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGAMN4viEHPGpe0HApaCUONdeBy0lALw5Pqomztq1bFsz6C/9jWO9r+tw+8+UPPUsPO0C3WcY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPDgUvo4Z7OlJe6HE2OGgSGiUuGcqEt92WHo+eOPDqvJZiG0xz
	Hppj1JUajo6VM+iwUWQbpJB+8+xfGYy0hoJicapJQ84Jqx10DPBBR9Ay
X-Gm-Gg: AYBFou3kPjIQKjrZE78jk6W4yvDDbCeaEsMQ6X1UKTzLDxfVf8mnIDDjuJtsoy6fTVl
	fsibwywN0avkpLdP0q+QEzFkcSKPsG4n4/CqqYMYQlzF+Gu2fuFai2ziIJZJRqprcwSBnJZnb9B
	QmQRkh+erb3fC9WQPoo7LWEKtrUNDdsj1iCbytMoC8zntm1l7fEgMezV/a5z8kHZ3sE4+jtazix
	1xiPfbNCr7AQEv3Ry3+iVN8PSLco1wynLSf/3ydfsUuruwEPiCxzfpf5Fwu616TjmH0mrlhtOGx
	OkOOkyM09985XWCKIeZ5yh99z8s9E+2FnSj3nr9E9MwX94fZM0v5snPtwhcC4HxQHuz6hyegCjo
	iITpV0eQ/OPMsAa9k4cfBL6seG3thf59BMQ3/m6EU/0gtckvxYL2YVfPiqyClpwbNWR6ysjHcxM
	vwEGZLxB8fTlkr4mK+skoxJOQUE9VdWsU3nZb/VuIHfyUqZpN03vrbDDhed5Y3LLE8RVoUtJEFb
	fjKjlsWzkFYbixfnVCoOTpKpWQz+uyKL2AjsesRXMVNMxBrCdXTGjMeaAyCn/fdMTscVas0SfnV
	xV2/F41rxBoyW49OVKOuUFosLkgUkwO2
X-Received: by 2002:a05:6000:40da:b0:487:88b:4681 with SMTP id ffacd0b85a97d-48c6d16d91fmr350123f8f.10.1791262242252;
        Mon, 05 Oct 2026 21:50:42 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-117-040-097.95.117.pool.telefonica.de. [95.117.40.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622704a5sm18265831f8f.15.2026.10.05.21.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 21:50:41 -0700 (PDT)
Date: Tue, 6 Oct 2026 06:50:10 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, ntfs@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ntfs: fix two kmap_local bugs on 32-bit kernels
Message-ID: <asR9jHZMwy6Atpmz@gmail.com>
References: <20261006043810.5393-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006043810.5393-1-kmehltretter@gmail.com>

On Tue, Oct 06, 2026 at 06:38:07AM +0100, Karl Mehltretter wrote:
> Karl Mehltretter (2):
>   ntfs: fix kunmap_local() of advanced pointers in check_mft_mirror()
>   ntfs: fix kmap_local leak in ntfs_check_logfile()
> 

Oops I sent patch 2 with an old draft version too. I will send a v2
without that. Sorry for the noise.

Thanks
Karl
