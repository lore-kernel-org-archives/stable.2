Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497E3EFD36
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545352; cv=none; b=d0aTT2HR0/BVW8s4VQv7aR2rtl9AJoI2mdiOQs13ZAIGGwftI+4yQuT+rBPMg2IcDFTU/TRUi/ZeirsyudT+qu+VAzN6OotHyVrpyJJb6k9TNrB2RtilpCwvYaYPnOEwSufqgRUaRaUM1Me5P/JfXU73VdnV91o68t7mdYnGF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545352; c=relaxed/simple;
	bh=JIonyDIPuEQrFkFWzQ5SL8GEmqFXXD/z+7p3dqgRC94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULEr4bECsFVcsbM31Z3Mv7VLUEbIDBFmMNPVNWQasIm6pON4LHNptlIo34HabvYstZ7tmvlA4oLj6iBfi+eljYWuOz0Io4zx8gpEQj3XkZPfzYbdNcyOFGScVidCVhKmmGMzZOYxMO/+CJCqw7yUS3OX4OEXAm6bfiOq47/+7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM8zHN0r; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM8zHN0r"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c999f162c9aso6210943a12.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784545350; x=1785150150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x+LqOLf1bSbbTbtCruD1zKjWdUcVSyhnCC+ieNQDkuA=;
        b=QM8zHN0rg8rCG4es57K19NYrLOBYDVd6qrPwI3iWybEESYHz43DEGEkLDPpXV6HjgF
         UWmqb363ngd4Mo4KfGW3QfHxDTsSTYcu2nKgEht4wb+QeBmyEy0k56FW/5p8jUpLMAPl
         gsKnJLuGkXaX8O3ncuLc80tqv6PoY60EjAC7CAS59uvm6k+MXQUzXsR/CkJMKOZcN8T0
         v/Js4IBreMqk5ogIf/TqlTbkpg5KyJs7n7/XOtJMGRIQEC1W1O5Mz5B9vrpjgGTv8MwN
         ZKuyjrM8B0NHn+R0IUAp0JCzSmZe2IdfUUgMYma7fTdYu4+j/dJn7m0bNgeHnD78Mott
         G/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784545350; x=1785150150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x+LqOLf1bSbbTbtCruD1zKjWdUcVSyhnCC+ieNQDkuA=;
        b=AABOVWhc64h6D7DBKGb2ExMGElJlvuyqwCyoLekjByVpvzIv/g22tCjdfzVVkKXxW9
         TtKuyRGW/1SyCuZQgZXqcYeZMQDNId/PqlSWaJf1MERUdt3oZqH57axKDoCKtdCg4D88
         Rfo8Bfmofy1y5ClIg0o1r6e6lUxtJJIJ5Hb21W0g0ObY/KRQdt1jOvgvGGvzCmg+E5f5
         Ec25p2PGwh6ibFba3ZuApdJUxTk+SRMEppA5RFL70fVs8jQOZ4hNnazexNZyzEPIvBrA
         B6NFy8EwhN60e9gbhUW4JLLJlXAOwdAzMGqrkLIk6PedsNwcEqR3kjnUpo1WdufanKG/
         nq6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqz9hCnFpXT8HlV3uH2vULIJBNVyiVT0El/wOOGvBhMG+4hOi8m+gpZkQ9Sq7VDC+W+jICkc30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMVo5JTYXZLumioiJER2x9d0uTvL0mNGJ5qEh/CoqgNg54OA8/
	24J0NcOmev+wCZ3hfGGprn08sNpSq/HMnTjGBBKf2fb2Z3s8THsd6ZKZ
X-Gm-Gg: AfdE7clWoXHssYInNl1nQilb78LpSkczBX+9a5xDBNm+k7D9fYA8gH7cUK0+3KQ7sRG
	8/5/0lzgYxTRBfucF+FRzN9cDveWsP+OpiilcrD3fdBA4hQauAXhhk5J+w2N35MX0KCnE47ttRD
	CkqGOnieGoLH6IxrFrhRY8EEH08r99GztbQfSyy66U8U9QHWlG5piloOPG2WL+qVGnFn0R/iW9d
	5A3CPfrSj7JbjYSFrpaW5/quaIJ0ISMYYoK2G3pR8mtQ57eGY+ATPvLoDoEbzYAkIswwccXFKt3
	tnwwSHGkFiDEeyOa9xzWs1PnSCxPbmKfIJyoJpaXcgcd1776fdK0FZk0CCJe82L4AcNUVMYDPwv
	W1E+pGWW6hqN3kDdF0ij0XbglK8N5yAl1Mtl39d/efq6DmPdzrZFFCC0K89+h8/0u7EGKviFVpC
	oqa/EUnAS6bAlOCmEuM73b4Il8S5gPndNaMHOITopt
X-Received: by 2002:a05:6a21:478c:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3c3ad66b538mr15799239637.5.1784545345587;
        Mon, 20 Jul 2026 04:02:25 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8d9:11d7:8597:c44b:bbf0:2c09])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2c93sm31585842c88.3.2026.07.20.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:02:24 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: gregkh@linuxfoundation.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org,
	yikai@z1k.dev
Subject: Re: [PATCH] mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()
Date: Mon, 20 Jul 2026 19:02:32 +0800
Message-ID: <20260720110232.312053-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072041-rearview-unselect-3f92@gregkh>
References: <2026072041-rearview-unselect-3f92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Mon, 20 Jul 2026 11:59:03 +0200, Greg KH wrote:

> Why is this a stable-only patch?  Did something go wrong with the
> backport of this commit that is not in the upstream version?

Sorry for the confusion!

This is a stable-only patch because this specific function was removed
in mainline starting from v6.2.

Therefore, this bug only affects v6.1.176 and v6.1.177 stable branches.
Mainline does not have this function anymore.

    $ git tag --contains 2f54908fae21
    v6.1.176
    v6.1.177

Let me know if you want me to resend with this explanation
explicitly noted in the commit message.

Best regards,
Rui Yan
