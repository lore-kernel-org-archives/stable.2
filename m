Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795192465;
	b=FbECe4A3Rck+TQR7SfphvGzVySvpAtgw9VqFZS5UduYWyapAuC3FegCkul3t+SY1zcPy
	 gGP9T7VmS6MWEnmtHm8RgnP+00FIBcUSDrlen3MZ7hPtBHFlH4Whfd8sihx2SW6SQW2Dw
	 5c43VzgbhEuqmFm1tA/pOYewFopb8QTQsqFdPAjEG/Sqdz8DPvRPf1XOb74CvEsf7jGNN
	 K0/k6OWVvaEnpFO32deRScMJgM8nLtrJXy+N16nI/z3GOUVtyxFZh6n9X/eZU23SGeiHs
	 6WT+o9RfvUisVNotgUtFV0N57KlVjtMVfwCtVGZjpcuMgOTQAwQ34aM40AJ9OsnmxNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nC3Y8PFe3wYNyqsZ4bQVAufvMs2EZ2DXu02JtfGvlOA=;
	b=XKgp7kue0V1/lCOiMR7/1U4Jpjchpwd5dZEHHR2D+mXt4gxHutwli4Di2W/btbKotgFh
	 OdwCv+Dc4VlG9K6RjOZmMvYt/WoerPx2tlcLf6t6mA4B/e8r9yO/PdygtBktbkHJ3p38p
	 UKMTXcgzgOegbb1PygWsx54dn5A3t2SU7MEVo4XftKncjOBMf4q384BTQUDnEUAVuoXtk
	 YPn2UTiPNiKhM24nCXCoO4/QSkPA+gyJ5oc9vFI9bCBZARuGnyePG9KhvXmM5y+qP+IIN
	 hrD22B/a7nQ8kuXKS/nz9qVWEfnZAmfrkt3lEW9lermS/wRXZSTFe+xF4kd+9i4pnlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBIN1JR4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD1606A333
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AAD1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBIN1JR4
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c14b6ac47eso96008e87.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795192463; cv=none;
        d=google.com; s=arc-20260327;
        b=f+v3V4D9XyAuBC+dar+jn3ZTGReF6WO5Lo+9Bh7auoeiHvsYuPvAam1XMLr8p2EsJX
         6tnAzP1sMtxPDiezgNYqgD9QiC9+omLb05A+z0lto1cX37s3ubp4FiLbl1oy5QuLM5qe
         BB9/AHbJbrtujJR76/LzKGOFQV7jerLVQlWdyvlaziquvT+6xBzGqrc83w1pglVE8dxb
         /q/nQjgky+4fA6fpm7ahPGxShKRVNLCI+JIN87G/RGdECG88Lldyikl/8Asef0Fe5ud0
         Ds2mnuDzWAVrtyoSu1pR6+poUXRnMdAVmxSWqGMx/WQ87+kI5SN5C3Oz6/JregHLqZt0
         tQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nC3Y8PFe3wYNyqsZ4bQVAufvMs2EZ2DXu02JtfGvlOA=;
        fh=8kgWzwPXp3d3m/QcnVF1ySJ6rzC0eU0Ydn8PIqWi+RA=;
        b=j+Huw98Hxh8dy2V36Wu80E4ikZxrQ/ELQXgYK/E6EbuADHC7QFzXnE0OezSxO4BNEZ
         Ae2AzAPoy8s7uImXnWMQTN4RMRUuhDzm6QTl2V2MorMM61aoYLOHvrbAYEiNP23xChJe
         ky52v9amAM7U9ba+3shGDYYVKO3/791FzQ4cqKpP2IPj9mhHEipmW2l37yN9SJzgA8Vc
         XhHCchkXAW95NRMDtB2Wd5kL/O95HNBXySe2wG140jtvdXZrl8LiHDB05C1xa+Yn7CQs
         yvSo9May41q/8dFEe+g0rMNB3Pc4SGClGZ1uoSg+h6TLcCoNnlXNMr77k/1OKL58Kabi
         ZvDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795192463; x=1795797263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nC3Y8PFe3wYNyqsZ4bQVAufvMs2EZ2DXu02JtfGvlOA=;
        b=PBIN1JR4U5r3qyhOBJhFDoZHEKQteUgVsi+UQOHvUWCMUsKte9+vLKf7/S5XxRhn3O
         WymdpLThCMjsVl438IqLfVuuksvDStQqzGh1eIoUV0NUl1m9QfVTQ5uypVvckAfkrbmi
         4bTvq5IqyTpsDHUNjCWuLqHmSneVjLbbwpdrdnHmUvbpFF+ZVhAUfFelqZSmf+s9zzZh
         muFSiSxVaodK63XtUTRDO+OBWT1ZFcQPCKpWUOVHRaUloopyY9wTdqHo3v+pV2qDDrjL
         yv/2iNNsmH6ZncQdfCZu2raj5i30B81e3k9ccKy8az6GxlsZntIlSnMNMLFHVU9CKt/J
         effA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795192463; x=1795797263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nC3Y8PFe3wYNyqsZ4bQVAufvMs2EZ2DXu02JtfGvlOA=;
        b=y81ACfDQAkUyQvyMx/yTs0ZHrYrAiAGMhrp1P9O2TG9u5oWEGb1nNM1U2Fa8o32xRO
         BRBePw98dr1J7TGbt1+ILxEHNtHtolY0jYLZS2lI8o/KIAiQdNeGBrog7qgXP4m4kKGa
         iq7lVdJd+a7wfDC8pBMB5LAdwa1E2+fKMoF6niX3origcKYDEwNydQq6Vv0ilkrhiDae
         jtQsIse+hyTncHg7EFoZFZEpIUxT4dvyQ1Ga5zEZcCn1QMhTde1lw9HseGBN/pSuGMSA
         1N+ekGQRogeCwmnGjwI1FE+DBKZjgd3y9yB8dZAKlpVxZZqRyDp7WhAHk1PJNj+U5ggt
         uJ1Q==
X-Forwarded-Encrypted: i=1; AL+hErFDVNzq/5xWG3wYlMe5xDbJ6Ep0DGD5ie8ubq8lCm100mgsMe+TYELzbZucqrmPy1VyoMdiy2o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wNENYhZD/HiTvWxqOwHprym87aqyIn3K3AwHD4tekTB2W4+EL
	jNUFpsw9OyUqQUhmDQE2cV/V0KonmngxYPf7A2Q8Nf/ACXas41RPV+n8O4EDtFQ9jP1gFI+1xXu
	NiYga8uGK+NIm7XIQyD83pjOdg9ZJZuo=
X-Gm-Gg: AZFdTZe4wV1vH/58FuV8wUq3JH/yDwum3tPocpyckmMio4d9+HeBQg475WEEFKXGGCl
	Q7esdykf9rAYC45Bb8FWUictV7WmZUi9NxPucH/41wy6Qcg5sKAZ0yJmFYO/18v8dfUalaPtLRe
	NMSU4GoAyH9Y6ZFDxWxNylCKFq3SsG+cylAwuDtDu45OCRbW38PJRdKeXZey/7G/N4VftpPTreL
	z+9wGPlNZxIA2mpBHFOK3juP37m8L0hvRPcC3ds4NIurOOv6X+9hG1gMSwlWUploFu2ldco9nCI
	x9hsrC/Leo4sEawifjVZxuOt/XPG1n7H75ScmESBFjqg0htR8PK8muk+mwMY7y8u0qreXeck/17
	w/ivQakMUoMeuCBlJMhVUnXcEp4YojNKusGQmcpITf2dbLkkSWsrTTZjQj1yrGXEmSFIAhY6zt7
	jQh35AMXrZy2mkkJ59AXYIK9MKou/47hB7rkaEIqlr7+e1M6oIxdVmiuoshUjvu/BpG8/qaOsk4
	3IXCNC/4Ui3N0AwZJKmPlNlI/N/i1QjFsOudlZ1xqsi2tQs432GzVVOrwyXwHMEmAYGyVq5X4o=
X-Received: by 2002:a05:6512:31d5:b0:5bf:f87e:3d25 with SMTP id
 2adb3069b0e04-5c1bc6b22b3mr1458709e87.2.1795192463418; Fri, 20 Nov 2026
 08:34:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-fix-schedstats-bindgen-layout-v1-1-0599dd230ffd@gmail.com>
 <CANiq72kcDMqswODJ0OqcqecDG+8mVn7Q43v48=ED5d6tsFOWQQ@mail.gmail.com> <nh-e30bf2f4-acc5-411c-89f2-b5dd827aa4d5@google.com>
In-Reply-To: <nh-e30bf2f4-acc5-411c-89f2-b5dd827aa4d5@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 17:34:12 +0100
X-Gm-Features: Aa3M54ql_SOOsMze1HazvjgluNX1SS-NF43fsAY8uNsD-xH6a3BgMusqBnpQfFc
Message-ID: <CANiq72=9EeVT74BW7RA=hVgvx7QE=41QZ80G5CyiNhmJy5yw4A@mail.gmail.com>
Subject: Re: [PATCH] rust: bindgen: Preserve sched_statistics alignment
To: peder.bergan@gmail.com
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
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:38=E2=80=AFPM <peder.bergan@gmail.com> wrote:
>
> I looked into bindgen 0.73.1. The layout diverges earlier at
> task_struct.se, and my v1 leaves that offset unchanged.
>
> I ran a reduced test and found that making the type opaque can worsen
> field placement on 0.73.0 and 0.73.1. Would you prefer limiting the
> workaround to 0.73.2 with scheduler statistics disabled?

I don't think we need to do that: `bindgen` 0.73.0 and 0.73.1 had
other layout bugs and, anyway, it doesn't really matter fields are off
by 1 byte or many, i.e. they are completely wrong either way... :)

Cheers,
Miguel
