Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512742;
	b=fpNgfycZq5YtAML61qwpyJLgnrbtryhVv/vJ6ry6XnoFr4a36BkqMlM//kf7NgmiVFsb
	 y1EGwKDOdBz69FrCnbvtJtvwmdZ2MbGOlX61rKBgKcVKjobhKClQp9P683YqDc2ia1V0D
	 4ck3l66VYZANySAtllu67miuCG7bYKjttzB5B+QrVZ0ImQZrpCzpAd+GS8/aLScLQw+m/
	 pD6aHMMuSLf41dfedEWujP3iiPHnsPtemJeU8MvwPh2U+cgSDw5Y5LL/4KQo1zX+pOFgX
	 cVNKqTH0vi0OTUBGejgHnLoJU5VhrUapAN9sD1zVnPK7lOk2k5pOwExgbxTIK7LNUrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Message-ID:
	 Subject:In-Reply-To:References:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ud9ISIbyr7bf+XRYkVCQzyTUHoKhr948RmgOVkz5o0U=;
	b=qYfKbVek/qUjvMtL4mCE20KErttKxzRtny1clllhJ5Vqvd3fh6Ct7PirBlB59XvOM5ze
	 KFtNId2TrLMQG91jbEWj3b8R/fu23qvigyA4LkKl8iuBRDoMPOn5kXmJlIZFXXPSyFit/
	 F8U2OWV+7cD4lu54cTSfxquas1IMO3h8Sv3+LcdRmCZzls4QHUCibSFEPTfXF7SnO85aa
	 1z/XGFPKdCMgjoybaxCB0m+wJyaNmJdSKADkDBbI4L0mZ31CIffLj5osKGS6QJ7JfKNHP
	 is27Oa2UAwf9gyipzUIqlz2M17kRaTXG1xMzaKyXBazTaeu3H89bwqHfuZYxyAfJk6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E2vFNLob;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C4E606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C4E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E2vFNLob
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a0a87595so2043756a91.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512742; x=1793117542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ud9ISIbyr7bf+XRYkVCQzyTUHoKhr948RmgOVkz5o0U=;
        b=E2vFNLobuM1uNFvi1K7QF/KCmFea5TMrpE2B2KZBBxHolXTITqmS3z5yvesZqTuNb9
         AYsjwlMx4eED0vTtfK/6Vi6+8tfoRp27ziIkbRZWVh8tuIMOPkQ+jUYMb1JcyZaW3iAo
         tEKHWPNb/CMYIPi4ohgJ/5jACzo/JWKDoC5cvDRP+fuhT6WXB9ofZnRD905ZDNtZBlGX
         M3yQbDwbPZjvQBvsrfjkaCnRm3u2KgyOTMn4bxWKln9Fbo4KHu/ossuA03D6Jp/W3M04
         9B7V/zCuJsFvySIu/NMWoNMqNBnDKmEBM2EoC6moy5zyAWoctaP43qMCN0KGRIigcagL
         Xriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512742; x=1793117542;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ud9ISIbyr7bf+XRYkVCQzyTUHoKhr948RmgOVkz5o0U=;
        b=bVLj+Dp7rFxyFCussxJdY7CTpONoP4yv33+3Pz+1AW7VkFot62eFrZKw7C+LEzEK6x
         0om3h0Of8jQZXGxJZTa0WuTBKzVOudN9CeXX0jMijE+UYbCaCvZeD9icTag87TrFq+Be
         exX/780OLRfi2vysGXd6Ghb3yLWBt8+ti8c6Shtbkllhv+/FfeU9x1zZVnuhWxNIDQVN
         7rK+R1zVu18saBS9PGift+9l8OH+gRPVRkY3yJx5g1fTsroXYzH/q0Fnrb6XVAzAqzrZ
         84bINqB/IK1cdEaQypVxbzcMewBtDCALa4ujMZsLhItZsJQW/St/ga1cksP3dcKvtEXO
         qo0g==
X-Gm-Message-State: AFq9FYKlq37Gk18tL8NqFP39jKj7VfFNU3FY+pkBE873uhLjF8YlbjrD
	cEqBJsGsiiikrSPEqTPZxb9kPwBWHybxDuKt53doTVvbSBZJ9HDr4Fcn
X-Gm-Gg: AYBFou0eeumMPZmZgreBK3G/aVgHCvRwd3ykcCM4r92U9x2vtIYKR4EzWSWKjxCmHtr
	KC2sv0iXeCCVLWk1z8HH70GwXqxrTKIxkLPoJfyZMLXYdHt6lMM+ZewaBHVwj5EV4Jqz/+XN5Qo
	R79w/SBNdTl3uURSTiM8VpaIkc9nDc1l3NfZo+PvJ1t7SaFSqCxxH0khp6HDIHVGKAhkI0OCJSl
	UUcpLkZmVFINdrlCfwlXxFCKlLwrCBKmSyhYPpuSFJjG1k6AHKTqhlh3/zgC+72lTzQ2HBj1twG
	3AfaIH4fQFB3uLNK7JDDAyCAleBcorHkV5AQ0XCpMkDte19X/SB9/atncSevtTnxsmim5MCsFhM
	rzcx04cZJrbI+OX0KlcCVcXx0nRHNpQaBvadvkY6XZr+PULL/h53CEy3iEduxwFkmEs+cTy7+BG
	vgn3QHsgAEvTUAORYhSYGA9dOHFN7MyK2k4nyQHLP+Um8uGXOoT4V1msA3YY6EsXeCL1CeEUeba
	h40G9U3T3I5Az8YPMAS/UGBw/pVTQDx1Hh8WbW2v+sND8t/qy5SnWZWpDJTvSt/0CttTlfBwBUY
	oBlxKeU=
X-Received: by 2002:a17:90b:51c2:b0:3a4:f75d:d1a3 with SMTP id 98e67ed59e1d1-3acef0c891cmr10365935a91.32.1792512741637;
        Tue, 20 Oct 2026 09:12:21 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80219f83sm240190a91.6.2026.10.20.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:12:21 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-ID: <179251038772.2.11838017412675823324.damon-filter@gmail.com>
Subject: Re: [PATCH] mm/damon/core: filter out damos address filter-split
 failed region
In-Reply-To: <20261020004119.106690-1-sj@kernel.org>
References: <20261020004119.106690-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 00:07:00 +0800
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi SJ,

> Filter out the entire region if the split is failed.

The Patch looks good to me. I injected -ENOMEM at both address-boundary
splits on x86-64 KVM and checked that no action was applied.
Normal-split and filter-order controls also passed.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
