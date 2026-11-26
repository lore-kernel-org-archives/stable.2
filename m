Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795724273;
	b=2eBtPnnD5BELtTtLG6e+Si5hvugB4XZnaPwPrRrLhMEDjWqWFcSICPs1jqjKS8EwffHo
	 qm9lCw4dJB8+8jkcQ3tDpPvdXAOT0LHr8CW2BePCG7i5Gj92FE9zu4BTxlnNoh66UKUpD
	 rI2E6sLonSlt3El2HjlVcLqnio1xWKbrDBD1Krypv/yKdXgUxjbPH3BDFYhx8T0LXVFso
	 C3Y0U5kO7fZzdhHfiskHQzybM04pYWrkcW8CRz0Qk3JmYFQt3y0hhHecl7hS62WmxvvXN
	 6DdM+8Wtbwb0FoZNr409Un6h04h0+rS3+B7FAazVCAAuPmcAErCo89cyUDcbTFIbeFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Xm3q3UN6DnQimxetmg57VpsJBbjQoWCdFICvXmCUsG4=;
	b=p6ASIuv+pylTT4lZECWOQk2w+UV+q2yhSZhBJkiSeM/P5UGmCJcrCvFbMoPc6cEMwIE7
	 I1t21gEEbNN4CfjEnn/iRhbX1ciyBDAFZaTjaL+dp/Oo66SS3qyLUcIpM96gglaEK83Vw
	 fQzILf0X2Fl5Du5bCBGVFsUMh++XTBNfuyecs85USyOHPk/Cqsgt3Ru4Mt0lHEo+nME4n
	 ohwm2kurrrGXVhDrjQEbR4xu/GGiQsFNxpjkMzYHXjUHB7XtkMAKeSzgVZv5iJXo6wDhz
	 piMqfBtoAkSQErF3uPaQLv7z18Vs6UBy+QGOuYeFZdjdqd8J7Ahvjcd1mPdTmmaulZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ct0LcuIz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429B606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A429B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ct0LcuIz
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3adf04a55f5so5508011fa.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:17:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795724271; cv=none;
        d=google.com; s=arc-20260327;
        b=qrnNJ9siECmGcvIKSDNfz248NZnTKMh5D8057pEaXqRvFjI9TgSo5Efc/TVTyua/An
         GGZk9q2q9OJf2NnJUv5oNmHRcccrioDEJFzvGhPN63ck/vOMTS2ACOkEycRTI3M35F3m
         ErcLp9l7NhCJPfNyYI+GkS0rmZ5BqeVvltcr1gKZg60xehh2yG5h32777Q9EVTLTebO1
         giYUPKGJX4JWx2fXKuUWeC3HFiywlNHdOUjL3fWVALnPaa+9/uopXYI3RO4uyTqflN+h
         jWt+a/4pIv7VI9Qsm9LCBQhGEz6CYXWXDNWXcoc/vfArpuX7m+F8QzV4nyso5+4UFHl9
         6I4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xm3q3UN6DnQimxetmg57VpsJBbjQoWCdFICvXmCUsG4=;
        fh=a1ZuTB67LX7KusJ27hrIQHNjc6jySrDothynP76SUfo=;
        b=SJN+sWSK4IjxqB/oEq0k09N1gBdAlMRBx5nFz8+MxyvLqnw9JCetTEF2DK/TFhpU46
         NsNsIXeFrqjm8TNLaowDt60Q1rc61ithOi9iw2K3m4zZRvRxG0boycb2pf7bBb52NmkM
         TbtGc0icB2+iCs6JYBMyBsKuCElNTkQhGTS9XzThqaCt4XI1mX9WdywzS7ai4FH0NhpX
         cXYsOed3YkJ+WYDbEP74aPA9aCZE5fO1f6TMYkObnTplit2IoOjn8VQhBWpl9xvWA9h9
         ebMM7A/HC2qN8DQ/eaF21BbEJcAH+FpPF2LEESdLXJlUKPFUg7Q6gA7wFZlsyfB5Seud
         tTdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724271; x=1796329071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xm3q3UN6DnQimxetmg57VpsJBbjQoWCdFICvXmCUsG4=;
        b=Ct0LcuIzKRv0h45YFo/ToRcsQ8u3Yi1OpB6Be7V9neRnrkqExRqeGcMJe1j55xcWGx
         9ZBOPRGoLRO5pg9FZnGhuMj7nxoD9xidNgdEbnwIVRvWJNSipFqnZX8lqsWLjp8u0G1B
         x2UNqniHWTyv+/Dl4ilz9ufXmEYl2V9C60CAYPMwxWwe2tLOLgALRUQjr2KpDzNDUS/2
         DQa8sDDuwU1ZKzktctb+dOFk6uYPkPHiDqv3GHJ2tKuGDIgN+dadiI8OPvaATh4BWzVR
         kKgDw0/AArSROg8TtCCtiCW0LhbKkaMvvhSt8DPlMzzg5yV2/DFCGNVYUdH4bj5zQhRx
         nhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724271; x=1796329071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xm3q3UN6DnQimxetmg57VpsJBbjQoWCdFICvXmCUsG4=;
        b=NeIWYgyp9pmmbsMFVRnuxOQyjszBaTM534YAoEVvAuNgZ6/wcz7EhjNHiOMIV6MNeQ
         HxdKqpZtzKvvpTPda9a6wg+bbxDZcLMKltYKJf636LDDL8u2ifbxfzPDzJKOjNYHf6EA
         A8kfdukB2jFCHw7mO/IOKzAdGBN5o5+kb2J7dVKdzP3Od8NQFMn0SuEvwiEs8m8K8WvI
         5K4o2jWMwvFaYcSVbg5QcqLcR5zNNH+fINIotQDwcY+Pc5vHOd81wsyUv8SFxAH0L3kx
         +VOpA5e77dS+bVnUmEcgYc54K1XrfIFfK96d81xQhK1xA6BeP3GmVRTlRtPa77gFYmgV
         7nOw==
X-Forwarded-Encrypted: i=1; AL+hErFyOgFlV3+tPjY9zPwLWvXL60SzxHBgVmLvv7iA1XB4uIT6j+mY0nCqVN457myMx4RR+5WOExQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WAU14ZWvJ9yhi/6DgI0QBO1irkY9TZ1wwk7hhkDL7Adq9E81X
	3ZnTFb4DwXWfxqB9Z3XC+9W/INB77FWB4RIBSmUx+wA6sAnniTf/4nviwVR78ng7TOwSSlNIviQ
	Z0a71zDl0lLzPXtzwFbdI+Vi4dXHuz8w=
X-Gm-Gg: AZFdTZd1XhzNALxAU+XTrs1O4mmv8vtvMAekQzncYXRal9YcmuHXxHjAAfI/W0N+dB0
	YlZ51s8qpxcYFaVZRaCZuoTFhuysLWXenn21saUSMbQED+lB2SiB/ujWo/rW2k6Np0KBXizYXc7
	DadhFdc27Q1uoUttz3UZYP3ZoPQRGuGaNPhuovtQrpKf1tV3tIsjzZVwZO0Iy12AZjEvQ9j3ecl
	BXt6cX50eg7YDwedes0OiqZZKHf9aJK4rRw6FD2/50L6oBTaPp/IZkTQNFgNgRBlxDJV2Bu4jZW
	3ibEu8v1IUbpXasBNn7APDSzvAD1r7x0CgTOa7YcZquT+1PELUv8aR2wk5kNUFDSvStDP24p+wO
	g+zJ+pC1Kc43/VNK/pnrvs7hYFBmQo/ZBjghgASX7i/tcMP26ORqVCFvRnbQvghXVpgW2UXYMtV
	GXI0Dg0wN9ZDYgtd8hL32k6AiEypkJbu5TNSg2JgylqomdzOlu8s+iSA+ov0JKfvdc0kgVvQleE
	+qM7OfGYFyRW8t2KcyJ8lND/rUC1sPATHWQp4DuGmm3/dsNZJa7h4YQ06jQKx5E+fMz1auYkA==
X-Received: by 2002:a05:6512:2514:b0:5bf:a66f:e5e with SMTP id
 2adb3069b0e04-5c1bc57989bmr8249858e87.0.1795724270636; Thu, 26 Nov 2026
 12:17:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126131456.87524-1-ojeda@kernel.org> <DN588MZEFFDT.2Y4U95SAKPKUK@garyguo.net>
In-Reply-To: <DN588MZEFFDT.2Y4U95SAKPKUK@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Nov 2026 21:17:39 +0100
X-Gm-Features: Aa3M54oswV5lnJaWrl_I7DzaKOuGF1A-he8iYhsPwLjSRd427UdhzZBlOUROIaE
Message-ID: <CANiq72ngsLjcJQK-Tyew1JVW3rh+A9=eUFR5h8c4Sji-FbAN8g@mail.gmail.com>
Subject: Re: [PATCH] rust: init: clean Rust 1.102.0's `clippy::large_unopt_stack_frames`
 lint
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, rust-for-linux@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 3:54=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Given this is called "small", would it make more sense to just change the=
 size
> to, say, 128 and keep the stack init?

Sounds good to me as well. I can send a v2.

> Actually, I wonder if we should do:

Hmm... but then there is no fallibility for the example, no?

Cheers,
Miguel
