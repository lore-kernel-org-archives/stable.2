Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7A3C1F
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791596076; cv=pass; b=eqsuE8E+/IurlnJVY4S7arXW74ZRjja7PYHU7HBJ68HEjFvyEM6ZdLXHXcPOZKM8tgeuhnPWeZE+kv4MQd8S2mGKgLDPqdJjPlkuz1dadssVxjD85M9bKN4rXGfhAyzkFveAzvvoBjJtiUWl639gSa+/K2jrx/17OJ5mhkpV15w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791596076; c=relaxed/simple;
	bh=RBZoIK02FXTZMOejEdU7KRpP3/DfoMjBE76QQq5xDqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOlUCkvTmKSBJuCf5dY9tm0J+ZlgZkf+TTvN4zi8aVDBekW0B8On8LwUJXvyXQTcpVi4rrK9DcdmvOWVw/YUwPgmIbpTpOQrkMyuFyGVXuGNpmyODDtQckBfgB3iJtpECMNPw4CC2g/HYAdVm4OtG6xw8QnCY7f9Fgwt0JeWh7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ofijy4eX; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofijy4eX"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a75f960be4so3076331fa.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 18:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791596073; cv=none;
        d=google.com; s=arc-20260327;
        b=GhGr9lIaBn9JlLYeXHWOsH2J68leFCXaGClF+4ezZyfMTjzMSaDMHpHMCHyW2aoCaE
         yOY6GfpYlOb3W5WzTLr7+vqX/vIGtZ60yQuFQUEnknzSYefVueSrfo92GZtx2j+niBjK
         PqK4M8S64vbBvB2DUMs85xGCfWOOiFzaWpkppOCp/qAcm4OtF8KtYPXjquG2Cuho2LpM
         nNU3NfT+Oe9GM79fVal8dNUimBy/elPBV3XlfaVNI+tE6PqyWkzAQfSadw97NdzL42GZ
         QQCF2Qn0styuJVX/Ayh1eptgiBlv8k9iI3JhxJtY5pmZ6UrSuADimpUEvypRdbOGZZAy
         LQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RBZoIK02FXTZMOejEdU7KRpP3/DfoMjBE76QQq5xDqU=;
        fh=gtnnY8DZ5pYcrWeEGNVWVCX0nIamAXOBgIvgtGgwNUc=;
        b=itV6ato3xQgFB1tQ0m4BLdCYDc8j8reRRxrAtcaXRDQ2WLh0gYgqi6ImpWNzYi6gGg
         s03uFayOwwnTI/vzXCeFP2REbBiCZebvuwUxKntkHSX++ey4oJ3h/04nLupVoKUFqbgZ
         TfGsrk7mbRDfbDc7bUyljThxcQesYaxgI9ssZ3htKa4Hr/FAHgXL1yx4UxiHUSOzpMj6
         MRihEbavJ2duWVntZGv2kBfr7oYcA/EVd9HOzcfwz9YTE0pDdft9eDLcgY7HptM0dctA
         RBNOO6yfRucPjOjsjCc3lxqdfgSHfIMdAksJ4sdTumyw6jKdvkEMXcX1t+LY/WWK3W3h
         PvCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791596073; x=1792200873; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RBZoIK02FXTZMOejEdU7KRpP3/DfoMjBE76QQq5xDqU=;
        b=ofijy4eXnvsOjZ/KsDrgt84cmJkc2+EpxCuvPiJXW5MVP0xaDWb9rgbFOepZoCG6DD
         SgiGHTraZIB/E5WUGhZAt1asrG0qX7AjMe3dn420t8XjKShRSS1EXNJyA/hQeCdW4I0F
         Nx6krJBrVzGfaqKdojbrUftYRW7jy361JvQcODGTDQ1FYlMfz7bqO0MiOG+gjmqP+ZSb
         I1j23wfmMgKs++DWRo0olQVzgxcmX9jYH5/y7zhl39cw1zHC/k3rfiyFWKDo2xOWFSwK
         ejErI4KJDONLwf5YUf1816IJ5q0W8LtjNuKM1UxlMwYhmj6dm1USJycoDFWiwaQR31z5
         3iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791596073; x=1792200873;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RBZoIK02FXTZMOejEdU7KRpP3/DfoMjBE76QQq5xDqU=;
        b=GrsP2tCBHsKq7roxoBLeCHec6znOfdc23uwA9DTD8os1j50wVBr0j5IAwVlRl3t5EU
         VTqBo59Vk3r0U9CHte7Iih9Lhyw5Hwdc3fC+fimktGdfBw52kLiEzNfjwuvnxTn2pM0w
         6byRPRnp2h8I97M4blHCYIfUtIrCBMetAGq65EWzKoSzAqaJY/wIfZ40ChcpcIqXupaB
         wu6S15cRwLKYvXKKRMzF1cWM5ezo3HwY3a0Gzl8OE1kRkAG3l7BYXES+ziD2Y07CQ7w0
         W6z4BIq8YPo5A+0mJAPMS3C2e8di5nnYyAhEQl3PJqqb7muWK6ju5zfvaEq3zuS2lV09
         g+cA==
X-Forwarded-Encrypted: i=1; AKwUvBz+g5l4KjVzPGTSJOzbI65y/f6HpzrcVYaMBkVq+jX1JDOXv+dnwhplW4MQC9+P2GgKYX0siOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQWqtmjP2HU0Cfm9VHYxwZav5ATz9btBcIOwVfZHyQQWdXCHyA
	j27kcX8gfWrTc6tpFevwm6aTMQfyk96taJv4/aSHcIpgRzMXgxpMK590juQeNjTsSkdfvWB3o4/
	lKqneKyRufCJOLDncTDSWJKny2iAtagw=
X-Gm-Gg: AYBFou1hq2p6kv/e0+IUBwhVYG+HtJOwuof3qdCXSLSJuYjjZbDImfBEvyqh6JB06K9
	TzqKqaMVs1CwPRXAN9Tebp4JOZgI+ZhY028SJz2rXP67Ffk+zxze/DSqVsP/i6ttjLs36howQqC
	x24bCdvpi53oxaey9jGhpDCLZRSLa1JJ3zzCMXKkIUlBu4W9rgMApdZvp6rvGWuzlxAdAAnr2x7
	KZdgeIpx8QqwDqWMVB+lET8G4WMXWwDNI9+GYvgEjOwi9P3nDzNQKCfexajeYWdJepv/qZxstpd
	S1cnpA31o84xVm63QGyKR20K32E3FqlWjtFL8ktSpZRHRQO4spNacMZ0Lz8YOc5+TlqLJ8eTJN/
	DKtWQMmMkNzQvpLU2J0dkmaDPJsg2yL/s4OjQlcj7UEHYstk04OLz7Bi9ZQPC1bqZ/MR7Wep+jQ
	6+qTod1Q==
X-Received: by 2002:a05:651c:b29:b0:3a9:83f3:ee73 with SMTP id
 38308e7fff4ca-3a9c55c7a69mr8139591fa.19.1791596072901; Fri, 09 Oct 2026
 18:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009212501.971158-1-linmag7@gmail.com> <20261009212501.971158-2-linmag7@gmail.com>
In-Reply-To: <20261009212501.971158-2-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 9 Oct 2026 21:34:20 -0400
X-Gm-Features: AclHuK91lXz82mshEmNWJGl1kPK5uU3pgI_eu7NyeDs55T-QedcNXRAggubZysw
Message-ID: <CAEdQ38GQUKnKLiCLpceTrYNviEag57uJhoUXntmrbwYcL6J8nQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] alpha: do not clear remote MMU contexts in migrate_flush_tlb_page()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 9, 2026 at 11:19 PM Magnus Lindholm <linmag7@gmail.com> wrote:
> Fixes: dd5712f3379c ("alpha: fix user-space corruption during memory compaction")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> Message-ID: <20261008195608.965266-3-linmag7@gmail.com>

The Message-ID trailer is the v2 posting's and should be dropped.

The patch is unchanged from v2, so my Reviewed-by stands.
