Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D93F788F
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785006260; cv=pass; b=URnF2Rw1kPUHPNIvqY5F4bcOQqn/1WxFA951Y0FyZ/QO/Q6oS8XSjfwiP8X6bcvHdz5NyjvvHW42xo85wun26KViJt47z3Ls3TA0IHgnsAR4L/h9q5Zhb1BDQuSeMip3rXUpLFlnhZKPyQU2TTJM0EqhTFzqkGBemFMJNE2OExo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785006260; c=relaxed/simple;
	bh=qwQwbP341/2bZNekgfUgSX9yOTMMPEMUIow+WHBmQIo=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izO2EuYVaDelyETfssgQJUn/nY5nejbZWruyhVORIjrpS884khOOrQNfYwUCVTLPnBx5Ng9520rwakPHeIuDRt4ns2FVkxodse6iw5hmpaFj1IcpRvs3xTCyrMA4EEs58KVICqDKkU/IbkLkMW7o0Fje2CEWum3hV15Em4Du3Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=PDOy5Pvf; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="PDOy5Pvf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ceab75934dso18741525ad.2
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 12:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785006258; cv=none;
        d=google.com; s=arc-20260327;
        b=hpvEr5+Q54hb2SyUbVMHco5NlR7bxZIxa7gg/AyTok0WNPxQ/qFy6ecRpF/yxmTYqv
         fyVntdPGIV63pU4YaZ25teez3irXiVVZp93sWy/Fw/XZjiqjc/ANeLH7mOaxs6itadFv
         P+Ecv8zFdeB42tMxCln5XR244SsXh+IzlDE+tsBr8t4NbCj9Q/7pJ48CTb7f0G2cHDMM
         Z26eyRm0grAZL0GxzKC0yCLHzZ0TuYnsqtJQsgoTR1D8r4x9XRCR6/JpT1m4A4/7cWSn
         1PBs+cXvXhtaBrL8t8cWzacx0THw6Uld7iNZ0+XoZTAUmftmyAyEXnc4YKyd99sheyZc
         eg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature;
        bh=qwQwbP341/2bZNekgfUgSX9yOTMMPEMUIow+WHBmQIo=;
        fh=Q+ea4brjpO9JEpvPrplFO6hUCTa8d8dFqQorJuDtz38=;
        b=ntKEUrJPTH/xA/6M1aqj5Jr3WEHzVyYRO7HnDtPTanFfe7evIC+dGovbXgNsW3GKwT
         JDuAlYdGLBONORToTVuROrbkfO2g+0SjqkYUdsGcO1jaEKkAufRogpapZYFJOO37Wqn+
         m6QkOJbNkEi0ZhQin7A1y50y8ndIU3pUyJ0HTsdaJLk525X3aj5RfIlqbbjdwoeD+scy
         fZPzhBZRCjnU2d0LsUYIFdNDUQ2tFf9/v1nPjuOuSm0CUQI0E37tTzFjKmqWBhaeqOmC
         VO7BhQ5YYfDqURsTJIyeQX0LT5EGpX228xA9xqfYoyhc2558k/EkHqyEmbR+I1iaN/WT
         de3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785006258; x=1785611058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qwQwbP341/2bZNekgfUgSX9yOTMMPEMUIow+WHBmQIo=;
        b=PDOy5PvfPgwtXK9SdVB7wcrhuN77jTm9+SL7vJ3S3ueWHCLimJ8yW3K7H92qTtKWwJ
         44cBspyExjobDUbQrb5b9B9qOqPKX9z06AdM8lkHKSVXF5GlF8hZ1gGjUs1CkA6WyK1H
         QjIRSIYnyTDIpElm4/I1xr0sxzMhSLqTXezhHsvTzH95qUzWZqNYo+X9YvB0KmqH+REe
         9sxozs26V3i8NwvkZyLzbqOoEJFiQwPbag5J/zcUCi3a8ZUSd36Cb4TM2zNtrmU/1MlH
         pILStcpFHX5pOnIsEESR1lOtUbiZGfonIcXSbqPsyMziR5lyMR6oE9wBsv+aTXCBZ7LW
         xujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785006258; x=1785611058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qwQwbP341/2bZNekgfUgSX9yOTMMPEMUIow+WHBmQIo=;
        b=grmJRfeEvWG13fLJc8YhQZFVf8opoWuEXrhzcTAFuR9nFleNDcFPhQI7wIk36+E4cw
         bzzajiDyRBNztNRWUPGF5CI3CkhUt39LMdPmxCSAVisGVB7ez03n2fkE3oZRQC+bMBYM
         ROAJrWwWxV6abT8xLtn0UgigCYgxydMjiNVcEKRKpuFGPgb4bwpxitzt+4QwgQG7ORz6
         IiigL2ja/0LIqy5Dq1gQVIYrkXznCJSMtMhyi5j1QoHLBTusqC3+t9dUIoqHanOtYWMA
         krOF1yijkz6Meqnz1ymAyLmnyOh470/ivHMN+X8raeEZWejggYRFXF1PmgosccWPK/Ac
         1Y8A==
X-Forwarded-Encrypted: i=1; AHgh+RpIW2OhUUuBlsYBQj9nbYkCiFkRs8NDUQH6qfaJMBo7DWN3qQnGSJjpXa6awnURUXEvk11Qzac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQbpI1EU89Av3Wp9SHuQQVbG8N/1sVMWhp3RezYJQKZKfp3Am
	6Tz6z+rKLKpIklzgZl+Yz6MAPQyQPPdqJuBY87he5NNFAUmU5b8IRElPpJB607RicGUsxhD7Aid
	JfxCm2fkHD2iJqrK9BMGBeC8pXSY0KRl2Krb+ybczvS4=
X-Gm-Gg: AR+sD11aDApty4sTgW0NR/9BMm5PteXGXe9dVbtW2oNZaVv0Hyr/UScGgBpu/sdCfgE
	MMPxGuCEkEGkqrpwfPI1HppkLvx8xDYALKtBZ9O9WDmTYbE03D6jFxxyVMXjId3T2rdRmjfx8jL
	vCI8wbzpVy+sNX6qZWqXm3ZLN+GbHd9uplz+K5kquwBozWZVycvPiIgLFSkgifxJK1S7mB5j9VW
	KbVWbBKBYOy7FFd7cAW91qR0q6C+n2HCF6X+BTjS6CcfaedVH7wDgmbXBLQsnAhcQjvtuvG2Z5g
	YUme2Jw5pqcJ44EKPj1w307M5hJT9enjpfFb3pqxPtO4EAuCcJi+CcOQcA==
X-Received: by 2002:a17:902:ce84:b0:2cf:7d44:e14f with SMTP id
 d9443c01a7336-2cfde8669b2mr32553095ad.26.1785006258440; Sat, 25 Jul 2026
 12:04:18 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 25 Jul 2026 12:04:18 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 25 Jul 2026 13:38:36 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260723145111.GA236955@francesco-nb>
References: <20260709100800.7026-1-doruk@0sec.ai> <20260715185543.14478-1-doruk@0sec.ai>
 <20260723145111.GA236955@francesco-nb>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Sat, 25 Jul 2026 12:04:18 -0700
X-Gm-Features: AUfX_mxks0bVv51B7wFCAaXX5vk8iDj3Pumnc3-ZbqlNRSLgRAT5gQP9nhcLjR4
Message-ID: <CAPdMp1rFFgKdq+PQiAwVga6bbCsuzmR_eGM9+LjKhDr3cnQ9Sg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mwifiex: validate HT/VHT capability and
 operation IE lengths
To: francesco@dolcini.it
Cc: briannorris@chromium.org, kees@kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, for bounds. cfg80211_find_ie() parses the IE stream and returns
NULL if an IE header plus its declared length does not fit in ies_len.
The len field is still on-air, attacker-controlled input, but it is
bounded by that parser.

The check is therefore only a minimum-size test before the fixed
cap_info read; it is not relying on len as a trustworthy value beyond
the parsed IE bounds. I=E2=80=99ll make that explicit in the v3 commit
message.

Thanks,
Doruk
