Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C3317145
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602785; cv=none; b=czxTR75b3h4ETtYG/ggZKB2bWgqaMsrlXJ8Da/itcyvsGJv50KTnaBiGVDpN42z7e+RN5jUUaZ/K9pVHz+DzoUiHERmZEWpDqbsjIVUjamMtCbGKwWPsEVyKDPfP76ohtr0Ww69B7w1xeh4ITq8o32s6PWEOWp5cpNuMlgZqU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602785; c=relaxed/simple;
	bh=jjLBs07ViJdXNJPrxWP5BQfdokoeqRxY+sJayNFc16s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeZtLN8JJIyosu/e718OHgqczIlWtEQDv0Aaw4wERTlPgIxVYHuHbdG/BbpUpQwHcQHgHl6CJnqtdQRReoyeeWx5AQAZjHtNQSQnb/Nx/0rI2Yd/GJwT/RXtJtUjaEVflVK2PvS9Hr7zt4CqWQi7bPlcBxJ96Hq1iHUXhzHIds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzuph/cN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzuph/cN"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52b3934af3fso43437421cf.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602783; x=1788207583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dDQCrhRKJv1CgmBzHk5DV2Zi2hk1jJel0LnyJEuda+g=;
        b=mzuph/cNbQta2Sm2LkBtHyvHSsoKFSeZTy+X8dwv418xpQAOxp1YwY/DvRrQ3TZEiI
         SacfgTquq5G3MpCR2eVKQpNuZVcsdoIr7HVUuOCTD35Hq85YwCmQJ4d7nURDfFlVYbo9
         HhFq/v0Jhcel2KNBR7/+VT6otQY/S8DGjg1PyDQ88WU/9Dp+rrhnCHEC2WE5jB8xgvwv
         5wSVNrmQM8McUlC/pCzlFbdxzjhI/NTVThjnHCL41Fo719XgIdaGJ/ghQE5lPtFKgUgo
         fcFo/xVl/Eh9sdqx2whQdT7i+vnMFqU5HvUc2TkxI/WyU+ViCzlk1B5TOZYMbcA56zuq
         hHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602783; x=1788207583;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDQCrhRKJv1CgmBzHk5DV2Zi2hk1jJel0LnyJEuda+g=;
        b=rHmQKL+TQL8grgGKmjj2SvZZq15Qw6NMZjvsl3E+jFAXZAIuk05b0hcAEEgP8P5MP1
         s1xigQrcHoRZhkT/ohts5CXS6lpQ7DhJaW0neTQAppeMHnqhW39Xz3BCoLRNUaFruqR+
         hXrH+7DpQnaFiBQF5XNFs05gLWdX6dx8U230NQXfexe/cskhnvRmxuCgA5NipKDj1k7M
         OMtj1iRHUkHFhlVCpKg4eSedX+uiSsls+L1TJtWB3XI9lbLup0mWzIo0Qy3Y5/AS/cQZ
         zBWsPZmsNfcCiA1u9OrTnZv+uxKY0l/qlnynJ4ve/2yYQKzFXu4fUH1UngUleIky53hl
         SBmw==
X-Forwarded-Encrypted: i=1; AHgh+RrdLfXkPFseqhD5LZsnN2qDn/uJQ5k+ycYg0EmUJpHbqpHu+Kq+LmzswvLNf1XyGOnh0HXmFeM=@vger.kernel.org
X-Gm-Message-State: AFuF++kcyN5CRhyDmjtj1EAeqch8OtL9ZfkSlXZFMeOX3T94LSvYS1P3
	iaDqZhtobk35MRhIpjXwkSe11eWRsJ+oFXI2YDt9haauZOmf2pA6d4xWmMC/PjSf
X-Gm-Gg: AR+sD10q3kJstW6gnO2zCxDlNfmpampWEqh+6WG1m+VkFXp48ToXci75tyzG+D/BcOO
	8NWYVPrwIzZKQj9iPytzt85IYUUPkIgIImK7ZFpaG0Pz/dho0la9EJUsOEeV5jW0X8kvA+0T99J
	HbKptfKT6d3iat60PWK/5BUQ2tT2E2iIY5UasK/dZ52MHfoCu4MjwY9tYshwV/QT/pQJGqu3+Ps
	7fVImygDshN1UjU5IM7UzycT7RIQpbM9nkB/BDi39wojW0b+vmvNs9xmo/wKE3bYCNFFtAwKshT
	ORJr0VdnEukz2xMuMV3rVgBwM17FzsnaIn/UfMwpyuij2dYBgbvkdmAY4KAFaWAb5/VdTkV2TxG
	kVuelmt0xv06zO2s2m9T0ejpXq6PEa+Mf2iE7gec/PLppJ8Fj2FVUptPP3yxu0xx715tl65GdVv
	uQKaKj4UDraZCG7OPQNXSXd7JtFpGPKaCEsT4JozW6IAAl0NJkU4+ZVjpXiA4tQp+E27mwk2dDs
	bUd6BjSVxTbddnVuzcldRM=
X-Received: by 2002:a05:622a:1f97:b0:51b:fd82:22dd with SMTP id d75a77b69052e-52e2f092d74mr19871991cf.15.1787602783060;
        Mon, 24 Aug 2026 13:19:43 -0700 (PDT)
Received: from CW-D0XG2Q16P7-L ([2600:4041:5d54:8900:65b6:6c48:5883:571b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c939332c0sm69720456d6.28.2026.08.24.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:19:42 -0700 (PDT)
Date: Mon, 24 Aug 2026 16:19:34 -0400
From: Maxi Saparov <maxi.saparov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, sdimitropoulos@coreweave.com, 
	Maxi Saparov <masaparov@coreweave.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] kho: do not reserve scratch memory in the kdump kernel
Message-ID: <aoylgHzZKP8av1pN@CW-D0XG2Q16P7-L>
References: <20260803193938.8778-1-maxi.saparov@gmail.com>
 <20260811161857.3096-1-maxi.saparov@gmail.com>
 <aoF8zPXiKpjt2Nsv@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoF8zPXiKpjt2Nsv@kernel.org>

Hi,

On Sun, Aug 16, 2026 at 12:03:08PM -0500, Mike Rapoport wrote:
> Hi,
> 
> Please don't send vN+1 as a reply to vN next time.
> 

Ack, sorry about that! Thank you for the review.

Maxi
