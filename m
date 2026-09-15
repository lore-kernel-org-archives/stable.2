Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05601430CE5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492328; cv=none; b=Ga6Nzrr1xbY5LES/DfowrgfXjMpVLAj1RSTIi5xEqaQxF4klvM8YKwn6xmOpcsW6HGjTBRKmJS/rrwARRVunnz0yNOq/h0FKv0qvCBgsWMw9BYzdFB9bOY9djiTHtRNxZ+G9ChJJWW4gWlFF5QDbdV/0RMJrmTvzL4iyfDRXVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492328; c=relaxed/simple;
	bh=Ar50DIJIwcExT1ZRSJD/v5WeHuSpaiWekI1I0rTSM7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD7ZZirQpV3R+1/89Ov5BcpJDGdBgJc23emh+QVPBD5itVSiuJDEMCffe92tcwmwDdTZsY03ilr622TfGnNgxKLWsh/0DoYR7G/Bs6HIQI4D2Y/tIDY37kgKuLNOyqRdlKO0E/9sC/M2iGqwodgIU9fq+CJ0bpzOa1ORtwAuPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rPpBF/tD; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rPpBF/tD"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef1d0so35744211cf.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789492326; x=1790097126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uS2ss2dRiKmKR68mKWZI7ZnqjRyXAQoUa35bmbT36M4=;
        b=rPpBF/tDepfYNzodihDvHjo4xMXpo3zJLc+VkDFvxFCcRj9lDn1d5EQoo4fIOyjTO2
         ssccakFpJdH9rIVG1ZMAbsFGuVpLRum1F3B11VBeAope73LSOyziQNd3123Ko/Hhk1PL
         3ecxrh80TVL9fXYn2xnZWmqu7PFcBpNh/5Ws1flqHS9faWzfhWlEl8nHqGWAmzho5EyJ
         EAd+qJK7dv8+87VW4gCKSbuZLPET/lzEXbJLS641Ji//Z4/Hfcowv4/YS9/CadmrW1mt
         6cChpBo/FoO44uRCSNIFmhePkYINk9R4sWWv/AqU+say6lZ+xUP3n9tEyZ1y6BOJpF4J
         vspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492326; x=1790097126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uS2ss2dRiKmKR68mKWZI7ZnqjRyXAQoUa35bmbT36M4=;
        b=c191scWeQTTlLHqw6VmoCm87h7vBKWwau4T6tlHiLdh4/QWbrnpjsp6IWFfYAu8spd
         XKNwaYUS8sZSw6r4QsiPJMF8NQ5z3d8HNewOblBak6e5WjVXWYrqiN3a1gA0ebiGWgOi
         2Uqe252/rj4+kYzvNkiRa7yL45OYBbyWJ7ujfJ63sSO9PCvJ7x8WfijGDiuiKu/G9m3D
         Y2x7uTkXowjZDPbnl91DxxG3vs/J20JiXEAzbKMm9FVIbVUF8nVB/DEDqvzm6fbOdDtP
         rk1L4HWSRJqgPSjVfvq/5mV1ebNVsDjscqT3X6gy2c58HYE8N9BocTGE/pyTfqzO5KiC
         wpbg==
X-Forwarded-Encrypted: i=1; AKwUvByrCIWnPZuKMR+GBm9ArBjQ+UfbxGNX0f7eCKApFm6XVA+ARO/RuYlobc3iPX1kqgUyydiLx9o=@vger.kernel.org
X-Gm-Message-State: AFuF++lGvNAPdcjOIspctm+sH/R4x2DXrXn0j1T2UGmp5TfFDjn1eLyc
	wtJay7/TDCIbk2L38IOzVyL76ISMnm54BxGPCctToYUPgIkQFhGF2iSakJvQnaD2rD9YBNGf0cP
	ahZR0
X-Gm-Gg: AYBFou32FVMEl9m8mkUjG/MKGKa2ZTicJReLIdVAoiowIymt1R1OfIksg3mRhzaHUWj
	fhlFiSNzk7XTL7JghKUiCHHEoOkGTKzzd7FB0HkJc5mnyAWUrBPpKIfVPaBxXbjXVtfX2ur9l3q
	MUY0ftn1z+QkeqBOdnOGp6GKFg8Pp4pClqetLcD9MY5upGRnwYWVKaoiEisbj7xBYNWerkrZtJ2
	nb961mfqAXXAW29Y1SEIuJ2Lik0gYlyoqB9SuMU6oIPsqEUsLAV4haG7DAIspnU0gTNcPxWemir
	RUWNOm5Ucdg4+9EQ3vmifKvnc4EnhdNyVupe7AgbrJrsfGb1DX6qR6Xu9aI0ytnSZ9UVG4etNJb
	+fEjolqnTCDCqDZ6vpNaAlAvISqXJZYXavh7d2+Ckvsn8wweP8IpMZg6HrAIZ+JNOLhaZ5WqqpF
	U/xkCTJw7J/wHlixXGj2knfYUYw+GsJKTEK48pFOSc68XjYonrBo5ylvJGp7ZQUSsPCmFU8s04i
	2nz6NMZM81Fiws27sxALbQgdCorH/dLvLJcRBHXqZpTvp1Fm7QXTpA=
X-Received: by 2002:a05:622a:8c0a:b0:531:d7d:64ea with SMTP id d75a77b69052e-5310d7d657fmr98074341cf.26.1789492325495;
        Tue, 15 Sep 2026 10:12:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ce4ec298sm136165741cf.16.2026.09.15.10.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:12:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:12:03 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqloB0zm3RjJ47m1@gremlin>

On Tue, Sep 15, 2026 at 04:55:47PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Sat, Sep 12, 2026 at 07:08:32AM -0400, Gregory Price wrote:
> > MADV_PAGEOUT collects isolated folios on a local list before reclaiming
> > them after the PTE walk.  The reschedule path drops the PTE lock and then
> > restarts the mapping with pte_offset_map_lock().
> 
> Is this reschedule path even necessary? It's pretty bloody sketchy.
> 
> I thought the modern approach (TM) was to not do cond_resched() and friends so
> can we actually look at removing this?
> 

Sorry - meant to reply to this.

Honestly there's so much jammed into this function i can't give you a
straight answer. I can take a short detour to figure out if we can
rework this as a whole.

~Gregory
