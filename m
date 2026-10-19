Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018349B5D6
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399604; cv=none; b=G2WIqGrSyZ4p+5pVHKTytXDpoVrs+8oIfY8FAu/HDROtxactZCiHogQy3dNeQUplFAIwgs+yEjT4MPGHVsK+7jmMqv90ykbtcCkav6qXqlq7DJ8rVUniXwDQiCQa7m+hzXDDYArL38lrBzKnitDprVqiVVAK1lMhtmtkdPD9mJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399604; c=relaxed/simple;
	bh=eHZnAQ4WZ6l0Eaf7O6GrKOei6GuPLKILghtVjSoOUZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8WyphfAsYcnIJNG9rOQr6sPzmw9vsAz1iZypCh+teOfyLPgiWR2Ar5+tCYLxaK0fy8ZnCVr2PhzTvZNgvtri+lnHABFqWX1kfqK77Z8f+TAqmjbPA+on/YR99TDTWi4GDeuY+FZzFvdr1yUmj3/n2RRb2MGb08dvQoYoFvgXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGCBEKQk; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGCBEKQk"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1438d9363fbso277589c88.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792399602; x=1793004402; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R81uGUDBlkE6/NsZn54/pArgBx2k2sR0sHNuKkRuNRE=;
        b=TGCBEKQkm9ByF8rvnvFnmryNDAtYJzZVjaHD7See3f37qJQ6bm4SthcPi7aoNyn3mn
         UQJhGGtiAgQkekfzYzM5ELHrgZZCcMwoAG/3Ck2xWlmvDxD4IMuD3UT9x0OcCmssenT3
         9XisLTYxJJYKEQyVtRnR6zRu/SxKw7ptJEHm/Hg+RwdMHiQifoorTHwT61RelEVzy17l
         Uq0NHQTNkJxmBJyRBHqvMJBP8zJiAJs82liG6cEBH3VE9KG9ebkzHzeBYYwhIODuVbkP
         WJk7ASSpPwYb7OZQZazYWwoCmHHg2jiZ4GSYP8nAmRit5c1MzhVQzwynfRU+jPBeNYgu
         9FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399602; x=1793004402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R81uGUDBlkE6/NsZn54/pArgBx2k2sR0sHNuKkRuNRE=;
        b=133enZNYUqfxSI8pJCsMp50lN0jfJX4DFbqlVcv8T3BKBL6pXzmsFRWlqvv33OPLwh
         7YDtld4x2TRzZzG+ifgkvgPhjZPT4iv8OfWOtrIB6bsLlrd+X6EtfhVR+VTYu+l8P/bV
         XHOsoX8R4rnVFmOeQaO93IusYWxafL0Pu57Hqn/lyQ/GlnwBLdKKvtqjPOSGaNnLrPKJ
         fc1f4jhJiiktExeoodZalS/ezkHiiGDZfkKbqWwPVAo3YkY9Mg9mo2Acc6NUj/rAoVhX
         Fwfgqejs9vOVXC2gs555MWxzLa7u1xFGbgaXeKiGeRgjKSA+vEjCFw0191tSJlXM0OFb
         FhuQ==
X-Forwarded-Encrypted: i=1; AKwUvByx24JW8toio2Op0YitVQ42xfTBOTTxkCZAGGDuson/zJefY3QIwxTsyUp40ItxL5mEVBQ6XgA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCkoFYmgl1xxtGfLMxynJDVRkSvMsuk1S/MHF3lQl4LYmgicHh
	wlD4aCwzvxR302k824s9DsohRcSGeATGMmc80/T9doJKeAEijBaYDcxl
X-Gm-Gg: AYBFou1gA3oVjoKukbCueja0JTIY9ClQP8YWIr2FWZXyLlxAWTRFaEsQZ79yUxgMRIe
	XvunTibswW4sVH1tkk7/7tghOi+K1ovQW7yPy1ZCwTnKrRxSHnsDIVAHzKMaegBnzinnMe49GXZ
	cEXYcr7a7utfMWNYiIzSZPYIbZMSpjj08pIY9QgXIgEUtz4D8CiW3W5s/C5ABEpJIqByTeXRW7H
	2dUJxAFlFlVbzw7E5APB+x9vV0IHGBt/a8T3iDXLgCNroZY0wZlSOaBgVPc/HI/4l48QnIQJ2BF
	VRPmudt26hZGwa7hDPbrX9ldIJr25KMD6zlPQkur0+SmtoeBxIafZONFu7JR7h0RHtbYrjcVebk
	RHRF4u0M5VrFNksgd7D/K5J7/Uy8GVXRztg/Vro8O67FzyE0wmRl5tiquomFPOLhmq4UZNAhgJ1
	wNBhWSBTubgm07xL+NoE4srq1cP997gCWd+ErMazGrpTKotW1wctVs50GdkFPwFs40Vrisgj5/9
	LKk7VMEthHHVBrklnhtCA==
X-Received: by 2002:a05:701b:2092:20b0:143:808b:b178 with SMTP id a92af1059eb24-1825c27d1a0mr14024480c88.26.1792399602431;
        Mon, 19 Oct 2026 01:46:42 -0700 (PDT)
Received: from blue (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm32116751eec.21.2026.10.19.01.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:46:41 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:46:37 +0800
From: yyaqia@gmail.com
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, 
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fbcon: Rebuild rotated font buffer on font change
Message-ID: <atHdEJjrSTrlZtSU@blue>
References: <20261016073023.490430-1-yyaqia@gmail.com>
 <20261016073023.490430-3-yyaqia@gmail.com>
 <3382a02c-ed79-4214-99c5-dc81ee59d633@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3382a02c-ed79-4214-99c5-dc81ee59d633@suse.de>

On 2026-10-16 09:59, Thomas Zimmermann wrote:
> 
> It's way too long and boring to read. Can you please try to shorten the
> AI-generated commit description?
> 
> 

Sorry for that, I was a bit lazy to think commit desc by myself. I am
new to kernel and a little afraid that my message does not cover all
things.

> > - Also select the blitting type again in the error path of
> >    fbcon_do_set_font(). On tile-blitting hardware, set_blitting_type()
> >    uploads the font map to the text engine; without the second call, a
> >    failed vc_resize() left the engine with the rejected font (found by
> >    the Sashiko review).
> 
> The problem is that rotate_font can fail as well. Handling that in the error
> path is not possible; hence results might be worse than keeping the rejected
> font.  Can you try to keep the original rotated font and reinstall that
> directly?
> 

Good advice, I will fix this in V4.

Thanks for your review,
Yao Yiqi
