Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC544195D2
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502439; cv=pass; b=PnR20IHvdL77+Y3QtvSLdt/6A/IGDA8OIGuuXauQZPNlmAb0sxYZKsq6PzjoGTDOLh9sEsQTsc4mrRlLzS3IGGUp2NwaYPMwEr7+wjFTJ5f6YZ2MV9JlHLdMig7aIqNDY54zqiJ2Wg26+kMlMBFHF+laNCG+M5UeyDaQgxNt8Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502439; c=relaxed/simple;
	bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp3XKMoLxy68dKIo91dNU3tia+iA6e8wC2LjerjOm9Wm7wLtEFXFNLIX/OjS6+L/7fVLSlbr+uGdBKxEbYQdpLiaDiEKrDGu9QUsdKckJ6ihxzZZJL+nL0Eo5vMLJbDm/pzj6ZGqgv7OtiBi5ufl5Cfd1Ap6FV1Rjb7XNyNvBqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jdml6mr3; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdml6mr3"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a668ce86abso880715a12.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 23:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788502436; cv=none;
        d=google.com; s=arc-20260327;
        b=s9jygzyzLuhyZJE6bghDNJt/LuJjPCXPx+l6ZCRFlX7cj9GKF2Yi7ePUDrmR/RbSWH
         J46KOgFoeZZ+embz1yLE32mmD1zxiYFJ/4Vr6ZXlDmqaSjCINhHL9ZX0yP4Ome8F9Nn9
         dECc/QxtZgSrKSbPRAtpSpIBE665W/Se1JIQaVMrrrQAeGsVmXo68apDxBOdmGt1PYgl
         bjV5015lONNLEBjcP7UzOJn/KXKm0713k5JNzaHEabhIyd4XfFSD+PAhx2d+NOZrebyW
         F48GncGuD7YSC2bxKPvmW91nb3ETdYmSmbROaqd7gMmbZPd2T7bxGUCEb9yUct43L1qb
         eH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        fh=8chgXlMOQ+aahKoFMAUAc4z9ZEHcVf4Z+r+rOF/UQqU=;
        b=CLwRtJBsOfrDyT3GNXzX4Y7BXXjRl5cq1/Dn0g5I6iR51o6el4yv1kLVDIDEubdhUR
         X9Ej+l1FU5IZyRzpkupkicfXBnvlNTTGr/h0e5X6BMEJfD/vElIbrgPvFoAcn5bxhH2E
         RHtpma5PvWy9jj+G7FjmcauddbT96uDM6sAmaz6iM3G+ekZ/HGdLrBP928dZz+9bnoEM
         elX8SHc6fbVDnmZSnU/2h6ronNT2oq5R3aAmKBZxiEvaCcdUnIusRUnqefMNy+M4nFX/
         zCHyi9T+FpBtkRNk7JheYpKoFTK9b53IhmPJ1ehLjweWcqEMcd++GisDJiPpgm+o8kbd
         gQxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788502436; x=1789107236; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        b=Jdml6mr3zaJdqdlBLmwY4XR3DyaMt6UVj+RrpvUccUAgAhxLkAJrowYyrxRQFhIoI4
         SFMo9P6pmG/zs5G0i4r06tFu7OzCsJNsjtIovofmLTCa1ETNmq1ySaCoppH9xw7+jRO5
         kpa+4BFPGENcquNHvcWbiFezTJ7t+UPQTVZ8szMSKH5imCpPBYDpGeJ8oC47XpX6Pc2l
         tOm73krqlGnR5/rddSkj8pDV59Ur+mb8k/X5yfB9bOLqjbCYAbPr8LlREHKCQPjWpHwI
         TaGy6n4nCeZ87ZF8OVjnT3VRS2LFuvBDh+W0zWOjb3AHCngRjwHDiGeXMuAzRIRJxfsy
         xEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788502436; x=1789107236;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        b=lBRvDYBkHV5QJrVcp68UtMnyAEvDmR0cy1Kq6U9ROtxC7UiHQYA/9WXxcwJh5yLO11
         DPwRBUhhpd34oF4ZuBVw9c70LBeQYjE67yot4yOjjHbqsBt18DX+VMFzDnVQj6YzndXm
         c1fuJNm+HIQIWtKKvUUKRCfD4khAtInbPDvDDxIFVw9it86vgknuANEeBpAAhl+XwzRN
         79ewxuAaWc1MgFmsQafqPrW2B+E7QmIrqDqDcO9e9zBCAV+VI04sQxfDdJb+0Ay44H7O
         YOn7VVw0kpPEO38/EAzauH+0yo3c9Y7Iu8FLeo2o4Mzn8kLQSuP8NRnr/p8Drl/HNNJ1
         cyrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPwG3TRbpUB9Vpt8i/Bvceb4ebJK1c0v2yX6/lNMektjllH+vOlrromvuJBTDRBhcJtB/GcpU=@vger.kernel.org
X-Gm-Message-State: AFuF++mqjvR3JoJ68ZnBRRyD+jEwb87Lxg3cfoVA+t/XNV2+pEoZLVFZ
	xlTVj5F3vyBWMjCe/Bdec6mDR4A8FR/lQ6EioUvz1E3N2gloloH9FOs+nTIOcSOo3b/SQzdso41
	0CZ8eGkkrv/jXHDbLMf6Tt3neETOHdnc=
X-Gm-Gg: AYBFou1cjzB7FYSMxSEbOGvkahzYsxszuEEAjMnTMYVoqFwxRprgIHGhRYu/SZpmBPi
	9p+uq0POiR5OWXJOJ3XMvoMgr0hcWUcuVI2tTrOMXr2Uu5y+2WGCbse6Dx8zpwe+fZTzGbSrSoW
	/EfI04W0hL9LJ2ERwXvU6DqtCOl+80ZvzZ9MprWN2/c57pvGqmtJWduEZ7kLpHSZhlGLjxa/5+j
	6MUAPknqEwVXdOG9PJv/NctLQZjlYrsoig8n3YrVVkwfrFu2XAQGx8gL9IMTdX9frtX5oNQyBOR
	r2RAEThDHS/B9t6NAINdTFZRHPU2dNvenaYlICOZUXfD5EU/xBIku/raVdCAAwAAtpAaBegShTz
	KpBvoGb4Hm5wXxnkFgr1aPAO8WK5ySgA=
X-Received: by 2002:a05:6402:46d0:b0:6a5:f44e:a009 with SMTP id
 4fb4d7f45d1cf-6a7e8d5a9f1mr1690015a12.7.1788502435914; Thu, 03 Sep 2026
 23:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
 <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com> <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
In-Reply-To: <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 4 Sep 2026 08:13:44 +0200
X-Gm-Features: AcwNN1VrnhEuSNjXaQkRHQ6SzaIw81uvdMaGdmatxDoxs1iIKPoZwAWCS6BhE2g
Message-ID: <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Adding Michael, Yoshinori, Rich and Adrian directly, although this
is an alpha series, patch 3/3 also touches the shared soft-fp code in
include/math-emu/ (op-common.h, soft-fp.h), which your architectures
build against too (confirmed by grepping arch/{powerpc,sh,sparc} for
includes of those headers; parisc/m68k/mips/x86 have their own
separate math-emu and aren't touched).
The new _FP_TININESS_AFTER_ROUNDING macro defaults to 0, so the
intent is no behavioural change on your side. The new guard it adds
in op-common.h is a regular runtime `if` rather than `#if` though, so
it still gets compiled against your macro instantiations even if it
should dead-code-eliminate at -O.
No action needed if it builds fine for you, just flagging since it's
tagged for stable. Let us know if it causes any problems, or feel
free to ack if you're happy with it.
I've reviewed and tested patch 3/3 on alpha already (Reviewed-by/
Tested-by posted).

Thanks,
Magnus
