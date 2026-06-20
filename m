Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905EC372670
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781938208; cv=none; b=qOYvOQZeMFvEN/vLdBB76oazsEGLAyivYA2z8rM654EcmChauhpiCNAxmK0geXHtegtNwSS5jM3RvMyx5NW7HYs2Xivl3QPrrS8Pu5fF73NbYeTYx/8RkJpO9V5rgKTwfSj2yWYQ3rJ+4EyOakfMhWVbcwgzSpwDSisb3LKJf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781938208; c=relaxed/simple;
	bh=dK82PrzfK0MmQgb2q/Ybhbo6Paemf3yKDTwrIdzHd2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGRhzoTp6/cE/0nyJm75wGRb27Dm15NAMPbguN3+8oB2IgQO1pR3fMzKC08GroBFDVXi62aPl0tscc/1gVXpOURjzhd8XWeBhApQKq/vfc+41OZdaYhdl0WDNVQmNveB7HIfJ1EO7oWqy4PPAv91HrdKAvxsqs1HJFewi3LNaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=CYXWYLoM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="CYXWYLoM"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c88cc025f54so1790474a12.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1781938207; x=1782543007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWJ6ykcaVVJ8FSV3Vgps/e2+SKPjlPS1FEpT1cmZ/tA=;
        b=CYXWYLoMsIT56/AXoEdufhmzUorm5fQ/VzIXXJvw/9/WQ4OlmFFVC2hCc1IH+uj31F
         Zj+2ElYzgTSVbKKwV1zZFiAR7AHej29JvqpYjRu/885MowQRNrPUqRBoarMWmFmIuotY
         vdybLQt4Vk5UA5ltHycfoeITd/VH4qGFFp+CPWM0CQFeIvkq5R26KXZSxLZBqD1e59vw
         kpFIygOHqGVE1PBVliFS22VPrFaU//gwSmBPtjJwahVU56JM13smUL7p58yNvYYlVKjo
         p1fgwqpqZswLG7VizwjjIabzUoMpnbSelPnx3JomSfFDgNDmD684GXZIljQ/bL+UYCQ/
         k+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781938207; x=1782543007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWJ6ykcaVVJ8FSV3Vgps/e2+SKPjlPS1FEpT1cmZ/tA=;
        b=e9pul/oPfGzSh4r9Vs6hnUIUbmtHjbuiYkEp1xQ2GVLx9rr7Dvw0f0FRe9p0/IziaU
         3eIln7zWScXvMgv4JmteF7Vk7v38tjD9TMzYUt83yIjyYjo9PO83iy/0VabbUQUvo+SO
         m2F2YLlo3wLea+BENSZVsory55Clk7kRJImsMGGRFpuEtf8IALGWgwGmnqYuftzwJEWp
         ZqbMSH2xBRAmhKKavfuOH3mxEqfIJfei52TbZHZJ/9yJIaIDYz2Fz9s8F+/an7FP8IsW
         jixXniGExcYeDFUYwG+Crz9frkwJAzhzd4XYTnf2+Ip4GY0aIscOHvtg0GfNNBFKbrNB
         50ig==
X-Forwarded-Encrypted: i=1; AFNElJ+dhDYgHgD7lI9RaGmaPbM1X6RqEzWBtZ/Is2Or+CJicHmjV3GLUoDG31pf+k5LamkFnFnr8jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2fQIMrJFOymtqv7bARYpEibqO+iq+Eanzr0/70m9Ev2XvyrR
	COJCZzcpmbnf31WPrv1DduBZtkuThY3NKgUS64IqwkTSDk7gTQ2en7p5dkdyK9iju3deBLTaTDC
	HDp90
X-Gm-Gg: AfdE7ckpsb8KEBkhmckkOisj3qiTNw1WmcbTU32iDXBIbekQvGEHzcZGszVc7wcHYMd
	vHcEV3oXaamEzDZgNHZKdy+5qE+RylMqr2ZTHzxjdRAI7EyN9CRSpb2o/nPsjSTdP8kg9RzlnF1
	yzgCt1OhOTe1g2R9ROY4JdeXqhXXdo5gx5YQQmWW7yEGE99JCFCBRQ3gJ7X3TAINqT7Rlgl5U0n
	Enou9MgNOhsEoHjzct0r2LwFCrdzkwM5GihRv2IUuLoS/iNVT8cqZKvxIoFOD61mxPt0uUd5uv+
	ls/fzPG7rq9Jx5uEeKm+HcoKcJ4DlxKfAr8i2gTH5MAY0rQ/EO+4T+BGCqe48gXM4xTHW8ucLyJ
	/jhGFJ2X27dhBwa2PsMed3TaAFBwyLGlghXTMRigL4751xRH67WTaJ7/V5WOAiCDNPRE4p1sYBB
	4Md9/Th5x6tYeRuOZhL2zuswM/R6PyVaXZ0vgq0/jEe6VgIrRDr3IQ7XVumhii17IF885RoZKim
	2yHMAffDJv6Kd5tbiD3vfnv
X-Received: by 2002:a05:6a00:2da7:b0:845:4d3d:c8a with SMTP id d2e1a72fcca58-8455616a4cbmr5905331b3a.32.1781938206616;
        Fri, 19 Jun 2026 23:50:06 -0700 (PDT)
Received: from essd ([103.158.43.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea7e22sm1394203b3a.42.2026.06.19.23.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 23:50:06 -0700 (PDT)
Date: Sat, 20 Jun 2026 12:20:00 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: stas.yakovlev@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ipw2100: fix potential memory leak in
 ipw2100_pci_init_one()
Message-ID: <722flntlwzdr5olnxilkad5rg3mmu3isgobzzhvmfwqiseibjb@si2vam2v2y6k>
References: <20260620055558.75740-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620055558.75740-1-nihaal@cse.iitm.ac.in>

On Sat, Jun 20, 2026 at 11:25:54AM +0530, Abdun Nihaal wrote:
> The memory allocated in the ipw2100_alloc_device() function is not freed
> in some of the error paths in ipw2100_pci_init_one(). Fix that by
> converting the direct return into a goto to the error path return.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2c86c275015c ("Add ipw2100 wireless driver.")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Sashiko reports a null pointer dereference introduced by the above
patch, and I realized I made a mistake in the first goto error path.

https://sashiko.dev/#/patchset/20260620055558.75740-1-nihaal%40cse.iitm.ac.in

Please ignore this patch. I'll send a v2 with the correct fix.

Regards,
Nihaal
