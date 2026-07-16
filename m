Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC8435AA8
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212149; cv=pass; b=qVpic+fzOOlbNyi3oR3TZ5/7hNyX6j9fdu+FJnmdUji/a6ZFLhfPZTWInK2LMv2gVdElemNz9wM0bR9V8R6nuTT7BbjRT8VpB2Kz/028cCTfh82m+l8kF6Fl20eiulSCedSxtlC2MpdT36nT1FLfW1CePuRvjN0UjespTXNRRA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212149; c=relaxed/simple;
	bh=0EQNb5xuuVXTap9WsSSYcCI5990Gc5XWs1gKOF/9wiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8kzLvLqlG7RpM9DzKpnQUD8KgBKCrDeqm2dCzf8WutUKSG24M06Xv0Cuvp1AiDf4ZyVUdqH90Bcb9KCSlX0AoC7G/B3ik8eHVQUznJKuYcofo4LUhMnAIA6p7dBWMFjKHdcC0J08BKOkXaax2djpXryhwhQvFvmDKEK7RCt6cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXFrccJ+; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXFrccJ+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3856d4015e0so960278a91.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784212148; cv=none;
        d=google.com; s=arc-20260327;
        b=aGszNpENDL5rPiECTDCkBjVSbcXfmd4GZ3VzSt/Jqctgl8jW/Ycq4ihiFniwa9ecJZ
         /Jcb1p8af11g1IwcZ+7HQLTRdHWONskaSBGdepULKHMewQPP/VgAWvenYJGuOTnwgk/c
         Akd5ZJ24bPjdbEPQZ7D/bjpN0igXDMNgM1AcwhIW70hU/ipU2U27B9Ha3eIr4T7IXYS/
         HbK6tGvnY08FckP36O1ENIprAz19Y1FAsVetucEF8Ds3YymbGbj/7xaC48Md/PehU5al
         10UyiBHRGodK2YZ2Oq6Lv2AaGgO/IHWNnZM92vGsDf76znkq8gqQiMcYdE9GD0wyajpZ
         ZW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0EQNb5xuuVXTap9WsSSYcCI5990Gc5XWs1gKOF/9wiM=;
        fh=GoplGcBMhW0P+Nakge7WJH2NoDNq2LyABLkxEIvrk2w=;
        b=GCj8jGaLdgw3tHCmTZ1abLQRcIr8D+DFI26b56JVhFW8AeRb7y1FjzK4VSNMnWDYTw
         p0eRAWCwerxg18GkA2B85cvDG43pq515EhP2aSM3y3qI8mpSeFLZEN102j6D5kNgjvIR
         jRApB/FI0LdC/gi4+zFnNzSW6eFIH3wcN5Tyb9NZr+lWn4ZS8tnfvwQUlmXZ2D+pQqA3
         CW7Wi+XyIgNdl1Dyg3EPARBQ6RMU9z7XMDRbqxshLC8w0OYEpReH4O68VVAI4oIkmaq5
         lUaaUB94Z2AIME9z2XYqccL9xh9eAECWvET+jfBTy+GDcG3s5EdTj6fcBpkXxMLc6tU2
         goEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212148; x=1784816948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0EQNb5xuuVXTap9WsSSYcCI5990Gc5XWs1gKOF/9wiM=;
        b=DXFrccJ+h9YSX2h4l0RjuVikmiOjWczAhj9t5M6lxZhmBUBd50vS/GEOuw19CR4eQ1
         CPyOeGfxsJB94m5IIxbuo3V7zCBopCILxURqGqEu6s8OaCM9juxBMS37d+zqXDqVxnP9
         PdDIAGdMe9LXYcN+Bi4Rhv2yb1Vzm0Cjy55sOZ+LRiUJtVMcIdrPqiq0U0DKT3blE+Ee
         4QMg/hlGUPF74M7nVRAQ4IHmIFbJBDbFTa1HFnQ6THGldCShQUoTMG0qYMGDDlYgQBCW
         E9+mbRpinJdRek6ihgwKZ3cusUyi0PZG6F/RCRFvbaM2tE2CZfrnUz8M1F85FKMxuBlF
         HK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212148; x=1784816948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0EQNb5xuuVXTap9WsSSYcCI5990Gc5XWs1gKOF/9wiM=;
        b=Aagv8uzqi/AZFn5I7aYMLbyM++ZDCHrHN7xPCrS0uyoRuLp3SpVzSJa2OU6gBFii/e
         hCCHveFAJAfGL6vK+Mli87oKUnrSfSem5ZpxDB/mQ4rj6K76Z/k8MVQsnuRvs3WvDhlr
         Vv8oHJM6bu504gsauTT6+AYAnAcqQH66ytepgv4wScBT6xYS7zHoXg6vd/0UtGN1uXnp
         H0EMkmxCIZVmp1F9+SWZCJLh3EDuNv9P1E989ry2xAGh76HtoAwsdloRH/nrYL9W6msB
         zvhGeE28SVb92zzaAh9yStbu7HNk+CSqoywfSQ/v7kjyccjzwN2qq8rpWsibABp+HMDa
         yVBg==
X-Forwarded-Encrypted: i=1; AHgh+RrfZZqTiQbBfDz5FqxLvAa9ZSv6IBhVOZ8yOHQHTWmgm39tbVC+ik0xvmALt3jehU1HSnFitng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXV6nOpCgFBfDSx+d4wq3oHqTxeYm/OmyN+Ouby3cjwFiTxzXr
	gP4id6UsSfFgSED1mr9KbEdJq08e+A1rfXpAOs0AUytBZ3jiXSuOQY/Tep4jPVML0f9P/goB89t
	imhtYskYgcsDLrePJzIqkojXQEPy+wto=
X-Gm-Gg: AfdE7cnD907VZrHKJMCWE/2fVJn+vdxDtytGhgpM16p0DIG/9phFNxFkqx8Wz7bZwjg
	fqvCzIicGghOvODQpDA91TH//573Imdmj3KfRRupCgbeGTdBEAZkM4drfd25F9z1NczpjNSkz6o
	r4oyhJT3IZTvk7eTXg4YocbOmsrZRIJq1J3ciPwLFsMrBO7LWIS77kvGtW6GmAJuuE9JvWVVDYC
	rb0L98rtjdw3krwoW0udhY/Nbm01V63f4GlAP5vYnwSicnGh6q3mvHG1csUuYP7F+Sw6Gyw2GdF
	T+meohnJtGcAuOu0d85PmdnL7CYuVgQH6GuZTy3K/FYTBpXolmskqOuYEzKhpV5MgtqBbuo0ITM
	FD7O27W7XGjGo
X-Received: by 2002:a17:90b:4f81:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-38dc7bd893cmr13870734a91.4.1784212147800; Thu, 16 Jul 2026
 07:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com> <DK01SW0X7PXH.15BGNJS3Q18BL@garyguo.net>
In-Reply-To: <DK01SW0X7PXH.15BGNJS3Q18BL@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jul 2026 16:28:52 +0200
X-Gm-Features: AUfX_my1-7SKStDwlC89EJwJoC2eX-6QOKiEcBN7hBCAlw_VWUDv1UPyakhGdVI
Message-ID: <CANiq72mZuFsb_Otu2fUSBHQ+oC6TrhnM6-BzZB7KcqV97yq0eg@mail.gmail.com>
Subject: Re: [PATCH] rust: device: avoid trailing ; in printing macros
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 4:00=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I suppose this can also be argued to be a fix to the user that use them i=
n
> non-statement positions (by saying that original implementation is for
> statement-position only and expression-position usage is an improvement).

Yeah, normally I don't put that tag for these, because there is no
actual bug being fixed.

Instead, I normally say something like:

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is
pinned in older LTSs).

I will do that.

Cheers,
Miguel
