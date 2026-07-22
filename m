Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55F397E64
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704749; cv=pass; b=P1ic/BGypnUN09NXP4K/m2pufSW1+lsBFmrkcati1ocpmraKcnxKcu8OvlG3eAA+YgehnmyLKYkXdadcYjTYrG2DdqTpOe4qUAvMG3oymkgREEVEkdUWJvuTqL65Lt0pdvJwyasFkav6lnELQ2fs99nGE6grvdr7NAFWuMXRjS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704749; c=relaxed/simple;
	bh=2EfXKAoAWHjt94nqC+jQqbpfKxdlJ24X2WPe3Q8+7yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpGLmnaQUdj/Ca5DjB0Y0yJcN+W8MlgNrYRIJtQSXEB0mK57AENs6b4YCi9jZAkOpASlF93xDAlDLD8vkb+rzABb6RSV2eXSsIdEi4A72KwKKpivvIoebDOhBGVs+fGcHmYZhAc5S9+Kgoyh+MSZn5kLGLGsmohrP8ntq3pL9Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfQnF4q5; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfQnF4q5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceeee8c46bso23255175ad.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784704747; cv=none;
        d=google.com; s=arc-20260327;
        b=s9CcAVHInjy5FJboJPt71F5CjnmlJaYuASSFouXU+cRGoisbgT0P1iK9xeuseVr7ut
         pWaTr6vnR6NgIDbmFyStM4ty7puYugXj+wYtW8EFeUKwt1Faj3YP8fHaIImbHTQksVlt
         8ogS4fUmicQu635CbrGQPyvcf2uDncPZRpqY2BSSeUisqlrwWrytCZ8NX4KrxmaM6jNS
         0GPTlwz8aWK3rpploTe3WW5tNbKpCR0JjxFYxLOgFbiOv5enCM4Pwwzro1ZE8yqcUFQM
         OIKMjqH34oJ+aU4Gm9LR6wHcbeuAqusnwMKbDR8d9cvBC2oV3DueCxwSVimbqiH15izT
         YPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ezUXcPip5zTfOmNvYGlmu7iDC5gPfyv/YbMiD7P1Bho=;
        fh=KZjbSnaJh2vZuebPwQWrtKutbkc+xnnjGfhJ4fZaoPQ=;
        b=flt7MCkC9qtDzETYkVnU7+WklaxU4iM+3x/HhEU9Avlisy+6ZpjDrQ58TgXNlFpgN4
         0dWNdqjgAKtCkz64cwGkaOpivi+7j3APz69NP2Pu1qcriZ9DbnVje8+DDFmK7gPs2PJA
         y6k8Yw+6gmDto9ErWBRbDXUo+u143BRewVuwsCP06aicAuHraAzCAI4ikXJTnTUOydy2
         6JCYUm2JagQuopvYd+qVCIL3eFRAv+N+O0BgCKHprieDJk6DOvCNTozMLF+GKyh+O3kz
         F0/14uA6V+BMcMfpD57bK/4OBj18ssAJYLi5x16HRngV2A8Jv8vFnji8IwiGyumhV7pw
         0MwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784704747; x=1785309547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ezUXcPip5zTfOmNvYGlmu7iDC5gPfyv/YbMiD7P1Bho=;
        b=gfQnF4q5PCpWQHgg0JtPdH/yE4xq/E0MbIAIkncwuaFolfXfRogwLD4hBrXP6LiFQz
         2guobVAnRJh6x27u0xPyl3SIq40eJyQCSoBGnMS93/6yeEE7xISoj1Ca2m3D2Q7e6WTP
         mNsCvX7GTSE6AODYzBxeCcmYyyZ2B69vSX8YtnAc1REpFznz7KQu5LMKzdTlAOIXtvRj
         KyvLlG4tafJkxQR7woJpkQmoNqzHlgzh+F7y9IXiPfmKhQA7FReGJdiyEGf/3TaoGDxZ
         AooBE/6B+hpWxyIW8JFfeaoRa8yhHfXgXdB32P5DRopsFy13wt4StRGjbgzTGn5U/00Q
         kWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704747; x=1785309547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezUXcPip5zTfOmNvYGlmu7iDC5gPfyv/YbMiD7P1Bho=;
        b=bhdLFDMYuGIaOUzHIDkVCX2jojKcq3j7zfGWxs/MpU91gm3vSNW+6eCxEnevSeSQi8
         TrJLx8tJ7RKGy4GfibFFYQgDvgoAK0rtTqCP5XFq0S4Nq71SE72wp0/QrXA8klp3smLO
         DKNWMLE82N1ksIxzPjguru+jVl6lMotWwfOcv0pSaCgRnjMEuckaphA5Q2GcjDwtkmYD
         r39KWPPRU+xHuonrACnyKthzjZnps/LrIQGOAuHxrAWagDXD5IITp5ZtFTkQoOyV9GUK
         ITpsq++zJUy99dO4H4N028IgHCexvpGuw0fIPW3UKD7wXmBi7usJkUqNWA9MSCsiWzcK
         Rm/w==
X-Forwarded-Encrypted: i=1; AHgh+RqtEGuhg36G9h1Ha1aLLDhn5p7obcVLT/ZycghaoKKUkCVcJSUIhF6hRP/pijuR1pcHT+RCAlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtYm8G4Kb5GcE0iH+8Luhh+Mgwcp3NipmIdtpLJcAG01D2xev
	uxqTETWTg9WjBd9XX71psF1VoAQ02+vCUWMiyaOgf6PpQF4RwcT0dygqumfxgxe3jZwwykB03O9
	Dv9EKPC28HQdahUCAJrh1oxyFzpBrFv4=
X-Gm-Gg: AR+sD13usLyCTASM1g21z4oQpthY1ggwVml7/xbkgquxBCZtwR/6RLyyhv46NWxR8Qe
	ab0fDNrrhU8MRCEULzHVe5q2XdKNMvQd4GVpTgxzZy7Giq+29z+aUl6UY1R7NYmP3vfgAtIXPkZ
	xaj1FedXGnJyuck87PBoa4d3bToESIWay1MvjsnnkL0GpHdTI5pnoQ6b+U0IkJZlRGh2RajAr+k
	Lj3D7VRFFj/TvJjmsDwrjeld1o7z3Urf0xlIYkwCIxZ8PWF96WAwBkrN3t81NTn/41OcHEjSVTf
	wt6JoGly6HebIBkM5hZHQfiUDpwpb4nScW0c/Gsw+yaAbZtt9qG5DvxcZTVOzPCfybSsp+OOusL
	myQ==
X-Received: by 2002:a17:903:1a6f:b0:2ca:e134:9e6d with SMTP id
 d9443c01a7336-2cf805e4983mr52954525ad.8.1784704747174; Wed, 22 Jul 2026
 00:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721152424.521567757@linuxfoundation.org> <20260721152425.635542881@linuxfoundation.org>
 <CAH5fLgjeGuBf3DBSwRDXbWCCc1__ZmkZ4W+5F1iwhAFCc2A25A@mail.gmail.com>
In-Reply-To: <CAH5fLgjeGuBf3DBSwRDXbWCCc1__ZmkZ4W+5F1iwhAFCc2A25A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Jul 2026 09:18:54 +0200
X-Gm-Features: AUfX_mwOEJ7jXwoYLWA57dkXxqZizmzBkkG5j42AwBq3_Bv9clL1PGHUCcjc1Nc
Message-ID: <CANiq72m5=5xL5tLMKJsxu_RS-606fA0TZUtX3urvdd_4ijBcxw@mail.gmail.com>
Subject: Re: [PATCH 6.1 0048/1067] rust: Kbuild: set frame-pointer llvm module
 flag for CONFIG_FRAME_POINTER
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 8:23=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> We shouldn't backport this to 6.1 because -Zllvm_module_flag does not
> exist on the rustc version used by the 6.1 kernel.

Yeah -- please see the instruction above:

  # 6.12.y and later (flag not available in pinned Rust in older LTSs).

More details I wrote back then at:

  https://lore.kernel.org/all/CANiq72kek9NoFe2PCFnND1p6BRbuzgv6kT2o5jw09sWg=
+wau_Q@mail.gmail.com/

Cheers,
Miguel
