Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795189120;
	b=guvUmlU34Yqpyc/hFC7+qKBgUogbcNfCJ156klTkBL7xMC9mSA8uotMOYLD6htHTqCuH
	 /s7WiGVRuXLhnSId2+2zEgmgW4Tu0cblePY1GT2915EUOVZku0rznTK90/NuehsFxln/3
	 TUrlhpOkx9MHUIZyfZiqldtFaetagxEfPLAwzuqdmSoylDTVZH4ztYJ7ZEA1GGHq/opZx
	 CzWIX5CI/ndbSHc/K1ZOcaCZczOuThsX+p4kQ+ryyrp1CTGoF0PASlyjdRdqMTBbsf28S
	 1LGMwGdgl/1bVYnJVZTc2NTazwChmZ0mCi+TGJrUv720jvIpVHs3Kc62V4UwK78Vrrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:MIME-Version:Received:From:In-Reply-To:References:
	 X-Google-Nh-Sender:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Ps+r6wqioFZ5jOTix48/157hwwLW+rUrXw7vqmb1SQE=;
	b=r+wfyv5/6T/o+sqGOoFzF/zlQ7Xk1eHMgO3mxxx1gj5RZllRQgf7duscSgau3QbHaVGa
	 o8aPMvngfZ1SpExX0Y0hsZNQQZ4AxhXRzNzkJwoevJNrSoxjfsLZLerGztVixMy9wib57
	 b3pwhJbSXfsckasNrE47OjavK4GOnYCyC4svyIsUdAxVeMnLpM2HAFMN3b1EiPhTC1MHw
	 LOu0JoM9XbK6uCkD3NHtqXXRu1uAGwCrEtRzTi52TLSHl5i2Ala16I2KAMl360/1cwVdu
	 pGH0242NDjgQBWBCr9kh5UjWujwx498TcoIgt6WlMr0v2j77oUcG25g11BbfYqgBcBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bnVGGT5F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547260A2600
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0547260A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bnVGGT5F
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b10d24345dso9903577b3.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:38:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795189119; cv=none;
        d=google.com; s=arc-20260327;
        b=i8d7ACqNcgTOXPZUDxR11a+duygP+K0qu8MGBYhtWvNiG9B8IMctYjOqFyvOtQkZQ+
         nVDL2iFngaMlKLyl/5tenIQNbjwSphySYKHo/S5Up083mrM1KqPisXwc24/1pAKaVL2U
         nwYJpMpKpBO1KIhU3JlD3LVJH4gRC9Mw8umQe12yRbcG9edKtR3pPuC5rxZ9A5/cLJtt
         I84JXGV/Uo91GdpW1tpgEMpTMe2AaSxttm6u45yngcgNiP3P3+TGAEQ6PjZfeY3H2BIe
         DpviJfWvjMEEX8t2uoRiOaXO1Rl031DXaEved8f04B+XzzEYYbCx1rHSMBIcV+0kXI3W
         Dlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=Ps+r6wqioFZ5jOTix48/157hwwLW+rUrXw7vqmb1SQE=;
        fh=T249EKD+j8FKX1AAPjB4yFMWKSoItTMiiTe+03E7iPo=;
        b=EzawwP6ktfJhPESOVdMf1db0WRvU2+WmYhWQv27D9Tvp0Ip+Rmt2KzWOAPBACIFUM8
         IPZfMLt8PJi4vpZ9teDOCTvZ2ui7d/oOsR9Xbv1tJtgLahggcWFW29/zemi7lf4lIQ86
         y+Vn0o63fewC9+7ZCMpCsqHRE8/Gxhc5Q8q4fBJbkK872vPbzz0z8lCqJOC8JFOOoziK
         F0OKIRqEdZCvgMgLGZoUipQdEv0oe+1+Q1uIs479f2MDT7YCyJutPDUnaBjMvw0SRqIu
         EN+yb0/PsDS5iXIJLO/4zUmlyvAibUHlYx0lQSsElNgfyx1HY4ukBQRjCRwci4CGVkTC
         VI9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189119; x=1795793919; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ps+r6wqioFZ5jOTix48/157hwwLW+rUrXw7vqmb1SQE=;
        b=bnVGGT5FdmfEv33S1WebbDElFiOPTlcUqXiZC55dfSFHGLQwFARnITwzxuBWLniQrW
         q8pWxUscFadJF2tPc65NGbH3a74iijEKChfdjO8i3OqgCNezzzMm+819J0XZYTOUPCT9
         2U21a8HyXsZk8rzpayrPVDyF+AeYsrff1w08u7diFt7mD7XoAuBHm67EJDkqiLCZ9LzR
         Dcti7VKSMEu3wxV1jk1BdKVtKv8NQyGKpf4BTu5yxWsqEPx9VAnagka7VyUqnB5UD/uf
         1yxZMIpKVsR/QesEP1jtp4yizg8aowpIw+GpXXKONwE+ZwGbroaQXWCMxzOQ56rKRebW
         MeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189119; x=1795793919;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ps+r6wqioFZ5jOTix48/157hwwLW+rUrXw7vqmb1SQE=;
        b=wcmKlOASvQUIz99vNpUoFH3JpHzIMSINaqnhjMPw7gIpFx0FhzCVmZrgsQ/T5R501j
         kf6onUS2h6BGgQk9jv3kbi89rXuxmC6VjrA6FYcbulP/njNOdc2MMnxTp6Q8+ycg5y3y
         WboMD4DdH2Zm5uO5BbPeyHcLty7239YUad+b44I0j6j5OB/RHaEQHb77MoP7a1d9l480
         iQ69odg87uypFxBZCE/cInBK2HhZeLIDyFQEJAapEnQQyUeC9xuMTV06EsIJn89vNRBU
         +WcWYHna9iCGWaG8UftYz0Vz+MWmfsWmiRfFElSHidtMljdnTDPc/Lp/U1QTf6ODtunh
         01ZQ==
X-Forwarded-Encrypted: i=1; AL+hErEQrceHXbSiXbAf3aYHlsmLBifNJrL51tbBSIbAsRLfCd5OZB2tpJLdEmo3sNAOWOxKxzDXet8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SowpHOqevwmFjSfM0NeSuUnsScYakn2zgXcdVACE6SKS8LI7x
	+n3K4OKovaIxEhwDCLHSkcLqaNb1Yxt57KfMXdhPkWUOwYW7LCGia/8Xp1w3X/SeCxizyRKuMjt
	rYksep+uIHjvkVu1UgmQdIYBb6mnFiGU=
X-Gm-Gg: AZFdTZd0iDUs9Vy8IoLvPNhPYmjpRqFn5x8uEutrHWDZx5hhoNl5aggfbasyIB+7jny
	eMUaXQFRbTE40jS00lP/l0UokWfyoTb4x71TFNoeLx41EqZ+cDFOqwvNBGcHECOVBO39fz3/Zvk
	9mIZrG5iwQoN1bjxxEFyw7iBAFOTT90JUsP2Af7v/8LcMFeWNN5ILofUZS4FNz8hYMZWRilPQAQ
	pLKID4xRlngq+AK3gILJPGxj2jGxY6UOQSfQ8GDnxBb+v0FRG4SapN1+5bcTSpYL+c2maBB0kl7
	OnDEtVaCsm0ldSu6xWQk16J0Lk/ZTiOmLxxnX8o35amARstDrNY5xsBBV7W0YK5uYVEibPGr18E
	6OcQmZ3+6FydsMccVZFex1KTerymAiu2/JkUY6dXp4yWl6sTZWCcAucmJHbMlc0lYg4XXlYQB1+
	LGCLjUbM2aoLjuGUGQ5MCAEhaMpjOrr25GMI8lShAWKMhy+L+C8X+WEeVn80SSKABWqUGCHKGDp
	tPY5Q==
X-Received: by 2002:a05:690c:b1d:b0:8b4:dcd0:c84f with SMTP id
 00721157ae682-8b5204eac4fmr16574387b3.47.1795189118800; Fri, 20 Nov 2026
 07:38:38 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 20 Nov 2026 09:38:37 -0600
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 20 Nov 2026 09:38:12 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 20 Nov 2026 10:37:20 -0500
From: peder.bergan@gmail.com
In-Reply-To: <CANiq72kcDMqswODJ0OqcqecDG+8mVn7Q43v48=ED5d6tsFOWQQ@mail.gmail.com>
References: <20261119-fix-schedstats-bindgen-layout-v1-1-0599dd230ffd@gmail.com>
 <CANiq72kcDMqswODJ0OqcqecDG+8mVn7Q43v48=ED5d6tsFOWQQ@mail.gmail.com>
X-Google-Nh-Sender: AW_J_Uo0_1sBs8TErsdnA0bl-M_r09fo3bmPAFKFbN5updnOD3nt4wJAkVJ_H5CTbSBmeL_sAzELV7JydptwZ3U-bKXp4hN5P0JxyGZRhaKvQbc2xeia6Am19MNbOhrETJgmIlapcSxEfkIRcK97u7m9H2ahPrMhiDDN8BPwRvv50BcSMzFFRcxdoi5ZcHMpe9wC89aIvFtv1ZI5lI1vdEbb2_Uq2euYD3oi8xW93afcjggJ4FNACxgUJWawMCo_eQgx3psl
Date: Fri, 20 Nov 2026 09:38:37 -0600
X-Gm-Features: Aa3M54rVdUxyxZnU-ZKzu4pEIUMsVnXfFp-UHkXmafb_R_K0SJjuvOWClOTzccI
Message-ID: <nh-e30bf2f4-acc5-411c-89f2-b5dd827aa4d5@google.com>
Subject: Re: [PATCH] rust: bindgen: Preserve sched_statistics alignment
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Jules Mercier <jules@les-mercier.fr>
Content-Type: text/plain; charset="UTF-8"

Thanks, Miguel.

I looked into bindgen 0.73.1. The layout diverges earlier at
task_struct.se, and my v1 leaves that offset unchanged.

I ran a reduced test and found that making the type opaque can worsen
field placement on 0.73.0 and 0.73.1. Would you prefer limiting the
workaround to 0.73.2 with scheduler statistics disabled?

I'll add the bindgen issue link and update the comment and stable tag.

Thanks for testing, Jules. I'll add your Reported-by and copy you on v2.
