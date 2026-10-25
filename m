Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792948478;
	b=z3p4LQHyuEoDzQhgQg2Sh/l/DvR6uWmzwkR4n6OE6cGmKTSjMsOq3dLSes5q0DxpDe4z
	 7qD5Nx319T9jntnuGlO4dzGjNXkQKxQRonImMA288k3zhrzoEe4bcRq/1bGExXJ90E4wH
	 MaHC0xtNc/zSbwoKChp1XAzkVSpyHBULl7zG83abYaUpBj6JZlZ61uMafQGkEonM2fwiZ
	 gCDGZf3asMLvFIdZtGZNDxAQsj1ManKFevvnl1QjR08sVG7n25zzisedr33auu+GnAjVs
	 LGv8jstutvjpxUke9ZSYngcUr4+FtdG/O3Ggcw5puZuL2fIy0v9VLzjMSUr+ae0B65g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792948478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=sEy0j/RTCNKSx/ZED7H6UZ0ZuCG3MgcRugWXcsq/UZc=;
	b=FWtD9O6i8hFgTirXjDDqtIl/HJpDKAyUa4EUmZInwLR2Xq5cLrPEuj9ip2lE6QnJaHeg
	 ELbzrt567HP0g9WN6FZr6rf4V9SQdnd72+UsXvnvPI/qTl0kvzAjkaKeYY5KEZRUNlqAH
	 pQ1Siy3pPOu1YVpHmvPlEq0GA2DNgtzo4+3qellEwWQwekJKJOQToJomtjonuOmg/ALkr
	 PMts+GwKudxPX6B2dmWZIVHjrUeCPhFUDv5B620Ny5d+6MMBMoe7YlSAYBOp2GIGWF7e0
	 fWa1jWLt7iJ8N2Ymhcq3eocAM/7MoPsmtWgKeHTIfUQgrTTV5uyo3hgO8exdXFG16eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OaUxUWvv;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA1606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 17:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13FA1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OaUxUWvv
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so13018385e9.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792948476; x=1793553276; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sEy0j/RTCNKSx/ZED7H6UZ0ZuCG3MgcRugWXcsq/UZc=;
        b=OaUxUWvvo96I0gbBBTVJGCTiDFWTjFtq4JmfXzwKTGchYPQNikYA+cXnZtbEGsnV4s
         8b7n7Qtd6NJmMDJ8zW3QmTyQ8pFzpOPBiNen61a6/SXRbG9GRxqnOIR26buIC1nk63Jg
         N6bXPWFNvSeyhMZGzqhXMjAgM0tPvgDdIRjPvhM53IyoVxIP3cf+IuT0UkbALIvJGIAS
         +cTUXRYsmvUwgNqVtD7g4AT9x3eDodedjrglFufRNsCL1GplIHWbwLFBHgCOrZlShSAv
         3zbLNPX0C7VJagGB88xDJRCwUWpdD5Kp/3E4QCm4fI5HffAxw0VHfLHXCyAHZ7WhS79Q
         b0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792948476; x=1793553276;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sEy0j/RTCNKSx/ZED7H6UZ0ZuCG3MgcRugWXcsq/UZc=;
        b=sQbWu8PcT5Sm3BxtRvBqKOZ7wG0bw/w2JqSxr5fU2puFoVpRxGJIrWJLn2ZPXyqgaH
         p1PzHEExjMfUj1bOiRieQUtOt79BIvyRZqGFUl7EUo9YYSrvpuss0/DqgME+j5aUMdEf
         lBMpra26Q4RYpgtRADFUY5U/ihhAMp7UM5boBNNqfLDXVBV52plDTi26h7O5k1QQcK5p
         cmyB6OT6MGrfGW6K7HSs5+Tg5qWUzjLPu91Hdpdc9efV+7mMDR+ekJqhkoWnoABQAdex
         /bp5G8SBFu6+y452GcQJCQ3CjTGJD8NIkMkdHx9+8IX/GwqBe2cpKwzOYnRfixlZOwY0
         /hjA==
X-Forwarded-Encrypted: i=1; AKwUvBx8u5mG2p0QXnNF+zUhxJUJmi1ER/uhHU7Zv/chevnysOPdne8PmyI2YXtYh3ZO1iUBWIAIBb4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7K4hW1Tom+VttyPbRmnBwU25Lo2Tdm8RBtDsbPAvk6JeYfAP1
	LTuQAaxJqdA59X6nBDZFlLKuIMZ52colMvsLmTWZ3G9wupT3fsL4dE9A
X-Gm-Gg: AYBFou2azgV2QxP/VeHPGd5FX/GDPBQJjvjYcq5lUgWCdHmq9cwB4i/siJb3DyKG5Y0
	eW3Lw4LhVf3Py0ZH0Zy+lEopILUzv8QsIR8e6Ff7HqE5SagMdTbzKYK/nnC8P/+xIA+ifIpjcem
	cyT34aHS/lK2vLs8PMZI2YX1HxD1dSz/bwow76fXijXwl9SDcd8iO+2AD6YQ/hrr4gqYSB2ytDt
	QEekbzVfQf6Uhl4KaW0NIi2EdtLVQVkKWI+W7U1Vr8ZiOAzO28Q76Of14gLTR2hthSWkm9nwO+6
	jqDl7GTsCNnRD8cZJaS7Zj3u9aTGPMb6OZnJGMp8gcL9cl5n6GAiXOg7wjT8yb8NWOwjVzEk8jF
	ezCnvuo294NPGHDME0n82oY+xMl0WEe0k6fc/O3ytLIgTChCnmnJ8x/aVJVorVVdDNCAJhvYEEU
	6Z9EZ7FBrpHS8WCgpZRsJSH3gMej1L0hJ2Hqu8HM32BPwYyT3kE726Mu7LGijC7/grMxvTCmAVz
	iHFrFsbDhYmwFlB1q288uHx6P4xX4/qdER8Nvig6ReR9xxpOgQ3YQt7fVG35FXTGM0reQ==
X-Received: by 2002:a05:600c:3155:b0:4a2:1cc:6551 with SMTP id 5b1f17b1804b1-4a35accc591mr91899325e9.35.1792948476454;
        Sun, 25 Oct 2026 10:14:36 -0700 (PDT)
Received: from timur-max.localnet ([62.245.128.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a56992dsm126575185e9.6.2026.10.25.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:14:36 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: qchcio@gmail.com, amd-gfx@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 stable@vger.kernel.org, Brad Drury <drury.brad@gmail.com>
Subject:
 Re: [PATCH v2 1/3] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Date: Sun, 25 Oct 2026 18:14:35 +0100
Message-ID: <oVwVffbwQ9mrJnRml_R8-Q@gmail.com>
In-Reply-To: <20261022073638.724414-1-drury.brad@gmail.com>
References:
 <20261015095713.20560-1-qchcio@gmail.com>
 <20261015095713.20560-2-qchcio@gmail.com>
 <20261022073638.724414-1-drury.brad@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On 2026. okt=C3=B3ber 22., cs=C3=BCt=C3=B6rt=C3=B6k 9:36:38 k=C3=B6z=C3=A9p=
=2Deur=C3=B3pai t=C3=A9li id=C5=91 Brad Drury=20
wrote:
> One thing I noticed: on 2 of the 4 resumes, about a second after
> resume, vce_v1_0_stop() logged:
>=20
>   amdgpu 0000:01:00.0: VCE busy: VCE_STATUS=3D0x2, SRBM_STATUS2=3D0x80
>=20
> VCE encode worked straight afterwards, so it doesn't seem to break
> anything.

The following patch should fix that:
"drm/amdgpu/vce1: Fix checking whether VCE1 is idle"
https://lists.freedesktop.org/archives/amd-gfx/2026-October/154367.html

Best regards,
Timur



