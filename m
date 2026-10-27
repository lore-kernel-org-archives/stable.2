Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119696;
	b=tRFeGFK6gUOAvGkKSLhPy1IIbsEXmsdg1HShqcbd+Qy01+UKZb19C6gw9+QOUDFcEBtd
	 A5K52IKH4+TECWkXoRBLJi/e0McgSq6WiaRWJWifjkBsc/Uvi7P4SViPRxv4/4MKfmN2U
	 MW6obfOPAvfvlnjqLEGnozsiV5D4SPJqWWWKYSjv0BAOu6TtY6N1OzJDV+5ANpJvpItfl
	 4c3yzaNbis6AaIUHq3d27gO6GNLQEqgRnCQIFBk6tEKynWtKhyui2b7BcmbXQdiXDhwsB
	 i05ZacyXdRz1lBkHf4ANHmr0c6136fFs76AdncSwbH5sTd1HI5DRA7ZK0/fhdrNuPgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=EQjVci2hf0W6p4qb5pdX2Gom0JjwGilCqdEkj+MUey0=;
	b=IKNDB1e5cKwAG76kpYZpE+L94yuCF08l37I3x7Se4r5l4f1JKvuxO+SOAW16LmYYcnDD
	 N2wmR94tGYj3c0Z/V0xv+qf6kwq2NohsZeQVyyoYiEiqXfJ+ZKjDwpcO1lsDGRdble1XG
	 z8DXb7e55AzKUoT6XSlXo7egL2vdoeigcIhwrGZLT3Tx5XJs8R2hYFkbMyVBN95uCj9fJ
	 BvdHl0uN8gWEa1++dfSoblSIwScLq+tAmviF3eDWF1Lg2eKE6ubmQjCBqcikFopHI2Kb4
	 sGrXJkEx2f9v8e/KyiBFilYDHGL8ucgYk6bBmhLCtmYgejFunPqFLLWnPWxLw9g2o8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AIKEZ/F1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83C606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB83C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AIKEZ/F1
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so184504366b.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793119694; cv=none;
        d=google.com; s=arc-20260327;
        b=fgLiDho38gzygprRm1N0nkp8KFj8cfGMqacjMb0cSvAVGN/mj/FohUkq+oRkBtV/Ge
         IxlHSmihb7WCC5qkVfzhDoMZM9mzqYOQJfMRB/08jgyTQ+7Zjo5khr5vnSxyxMDraVXP
         8hYU9RdxPi6I4BPmADb84wCiMs6WqjLmvCxD2kOU3ZyplNKEBosFqG4jH6AgnyHsgcG7
         jvEC9aTL6WCERiqtTYoA7KGh2zNn+mwSLYsAB+oIGswqxUosWDFXFqQFvGayHD5wEA+p
         8zHudydpu7zRmm3tj5Pu1LQE2Nd6fxw+Cy9biHB4dq7V3MRXhb7oWZHe2jqp00ughdJl
         Fdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQjVci2hf0W6p4qb5pdX2Gom0JjwGilCqdEkj+MUey0=;
        fh=ZhNTXjHww0KEYDG60L6sdnYqoUSyJM342eDE17xjgXY=;
        b=nYHyjuhRY6ffeBNhetrLbjE/saRqPYKTa8RaM6gSSOTrRlrg+NeF4Bchr9N0pX8hHd
         cRnRFm/1z70LYD3sT0CaILfodqacEu7ixRLI/2MGutAaRkcjgDTvTTulzyeUwfnHakcw
         k7B1kWzRIiWexvLF+vUdtfT7ECWZCrdBqHj1u1TLV6FbbgQFXNyclpWjDKM/725/eIBn
         3wGoPNErzP2IJay/3tSK+91/OBQnEBprZPIKlUThXYEkoUNzjJlJOB7Gg7bAMM/oH+nH
         zXJ+5zmTHoVrz8iz2eOlHZQYLjede/a3rZTIgXOu0mYFOVT+Cc64Ss1Yes3gB8736wTn
         4ECw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119694; x=1793724494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EQjVci2hf0W6p4qb5pdX2Gom0JjwGilCqdEkj+MUey0=;
        b=AIKEZ/F1vRctyn6m0c1CXuU/Y2L+/28iEGUArazDJUSXSCLIgstjzpoUx0YNB51RpO
         rlyGozWUvRIZRj5dzOal6yeIqh+BLfIlOVJJTtkW+7e+e+pqv79R1HTzpJTWssBdbHw/
         ms4DdHfH9P8RKd6Z6EV1cAiN2nk9YZpatX/NYcIv29QA4LSS9b05GpPCcySwE8at5qSw
         j5wophCVc0eIrslz7iJOLv8Z9ULR+JKvUCDhYQgPXEk429SV7KNarAmsOJMko2T9Bvnh
         IuPcTLBtxobr0XxiPIaUw1R1lIts4J4Z1Ygk1vvGhzgnYokGCEf7zG3hl1pzEK3fYvPR
         +CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119694; x=1793724494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQjVci2hf0W6p4qb5pdX2Gom0JjwGilCqdEkj+MUey0=;
        b=RS7wzRBBCIUkUPYufcLDKF0AVJwHsYdfvumR2Pj+6nzkqzlrx+08ne0UsDnK1wjev5
         OiylK9fKlXQ02uHANlvZqSovnCEOG+bGJbAcWMbzr6AXhuAsE+/sbhsi1S3OEXPy5ENE
         iHGexr/kZVU+bgPGsu7AREQW3zonSc2WM738fhtVwbn9+TH7unforK94Kw7JyNDmKOHd
         2tXefDwOaf9e/eJUWp+BRqIGDCg9c9/42N+9IXMvrm1Jbb4KeEj1HAV8d68t8u3wB5jS
         17CL1IYXfUgnU6etvlLXcoPepr4aXNNNV72h9i0wANQn9qHWHGxwP46EDBWylXliZlEs
         utUA==
X-Gm-Message-State: AFq9FYJgbjkeFbAtNhf+0IsTEpe4spjO00HS0AmFVoKe0UR/SLtG3XsA
	1f+wUtqpTy6xFX9I83DcrenhkTt8irdWFFQoia3DlouTSxP/GbHDknnG8+0PL+8nC9o8HDWBW30
	HLSfyWsGdCc/KIvXGb9GCsBCf/P1V8XE=
X-Gm-Gg: AYBFou0Yuc/2qgoa2chy/KcvVz5eYOveHqL/1mp+r7bvZx8kJrhoFa6m01ublNF84sA
	luakHIf7s3dBf3puEATOrFc3PwhMy+2z6H1UTKLCOQu2euu471Yg5kvmCGQpuXVt3grbn4wT8Yf
	UzGCI9MytHXeuIgGAAHl1yjzmgRpBT2lN30Mi52Ra4MXJLU+0udmwlaH8GYfmk+KLEMyNiyxePL
	c+cZsyJmBlf5MtqnNQrsjVFAywp61d2quv5EwC9u82tNCEzYUR1FA3i9Hqjq2/iNi789ObNJKk+
	BGgnbhaHbKmAabONrLN4VOgn3/GRn4PifE+Vy9hyOPLhl+IXnljjtoSHmA5Nbw/RhsQGLHm5iH2
	8h54GiFKzs7asOHWikdff9+oXo13NoViFVD6y0+E26qzx4p9edZVV95BPZAZ8DWMsN0oADhd1zh
	t+ck4dhyqaRuEtzZcEMw==
X-Received: by 2002:a17:907:9494:b0:c46:9745:ac13 with SMTP id
 a640c23a62f3a-c49a7480d39mr282381866b.32.1793119693863; Tue, 27 Oct 2026
 09:48:13 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CANTrAmxiBn6GT+N5qivdf=xtGg6yFksK5qN_PhpoNdxXDSpikA@mail.gmail.com>
 <2026102733-sinner-baguette-1d07@gregkh>
In-Reply-To: <2026102733-sinner-baguette-1d07@gregkh>
From: =?UTF-8?B?7J207ISx7ZiE?= <ihopenre@gmail.com>
Date: Tue, 27 Oct 2026 23:47:59 +0700
X-Gm-Features: AclHuK-jR9KeCd4-1ulfy0atNQaFAsyObEdHdBLGJ2PEjFclYxSOA967pfi9Ni0
Message-ID: <CANTrAmys9yD+KB4Nhkqo5Z1R7vJCbyoXpizDeV6kM5YA4nEMiw@mail.gmail.com>
Subject: Re: Backport request: ksmbd and smbdirect fixes merged in 7.4-rc
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:44PM, Greg KH wrote:
> Why no tag?  What happened to prevent that?

For 3) that is on me. When I sent ef85bad39cf2 on 2026-10-15 the
commit it fixes, 25e414db7033, was only in 7.3-rc, so I assumed there
was no released kernel to backport to and left the tag off. 7.3 was
then released with the bug before the fix reached mainline, which is
why I am asking now.

For 1) and 2) I am the reporter, not the author, so I cannot say why
the tags were not added. Namjae and Stefan are on Cc and can answer
that. I only noticed the gap when I checked which of the fixes had
reached a stable tree.

Thanks,
Lee Seong Hyeon

On Tue, Oct 27, 2026 at 11:44=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Oct 27, 2026 at 11:07:48PM +0700, =EC=9D=B4=EC=84=B1=ED=98=84 wro=
te:
> > ```
> > Hi,
> >
> > Please consider the following fixes, all merged into mainline during
> > the 7.4 merge window, for the stable trees listed. None of them
> > carried a Cc: stable tag.
>
> Why no tag?  What happened to prevent that?
>
> thanks,
>
> greg k-h
