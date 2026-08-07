Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4230364935
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121921; cv=pass; b=WaO0a/NdCuObSsZGutPK5f0eR44zQgh0E+9fBro8l7iVWRK0InM0OcWOEN66dY9c7zPOYERY+ZOndu9J74nE50DFWfrJljA4Xl4T993S9r/wtsMnXSvziHol78EqJuiCtoJQvra0BvOlxKYCBfoT9lZH+F7e9z44a5upMQZrvYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121921; c=relaxed/simple;
	bh=+tCnoMwAZEVH6hwh/t816bcFUV2OI7xzKPLQHdVVPMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tttk6HXB5ntchNvdcTiMcLdnZ6QC3UigJxc7yXR8BPl0eSaIQuLrC3qKLqZMIcwUWTgStpyAkBSd29tgifhjeYSvvQbeFFIFgL+d/gA8x6vwvxbJWh9pgIYolVPTFlWTGsn8rlRwj22xP9bVOd5DMs/bxBirAqZ1DkWkpgnLRRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXI5rzhw; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXI5rzhw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdce28edeso4790725ad.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786121919; cv=none;
        d=google.com; s=arc-20260327;
        b=Em/9QywhRMeXNiuZPB9AVby6jM4tiTU4bRWONpLugGlpd/2pGIukYjv58Im+0dMG2p
         JmMlu0eaFLhok7FOETZSZLGw1B2+33uThq/lZb6Mc8eUFgEbdi2OqT/1he/2GLXUGElS
         YDsY7uJcl2Uma3G273nbTzWHKLSP4hjFTIgxA79rGqsD0mVYeZ8qlcKITigzdF5iWWJ2
         C3U2nT9MT0TKT9njWJNr13PF9ipmNNHNWjyhuWoQF/7sda63CdZLP1tPpSrU2Ah4AtE0
         LRGJqSJTaylwgzkdTTosTPgJlp9Gc6yUvt+eZRGW/RAXvb4rAxvrnlq9+nw0yK2Ihk0F
         9+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t5/8EoE3A4Oj0hVOSm9+FPla2LLANPRLURLGqzSc/qs=;
        fh=Xu9VbgSFgq0qLigFGFnh/ijpHbrglggph9S89ga67EA=;
        b=OXlrmrsRQbe3ySn3zfilE7keLWWmIyTtnZQ2s3r4aXm9D9KhmmkX5GasogYpWlN7lJ
         jzF1+9yGmU8dlQjEn3UARxNBw4lYgdVHcpNYAuN0/r7ew92NaxI+S9eoK64TfK5W3vBT
         mgYxYI4cs/DXAMejU64TP5FweRJcroa4heYUx16trbC/bvusO/PquwEDGH4mYqRgmg1z
         TDVmbYKx5rrO5R3daw+21AgUvjvXq8T+M6Npg/1p1Kq5N3evvOn0HUEJ/Ti9bUdsX5Vc
         tQMNeo/3FS2WSAXglG1Akxszckz1F8Atu6rnBP4zxJUSMAmbMJwo1qP3rbK8IlUTjwJN
         EtJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786121919; x=1786726719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t5/8EoE3A4Oj0hVOSm9+FPla2LLANPRLURLGqzSc/qs=;
        b=VXI5rzhw3+KHlnZ9ng+7Al9FT+sv5GOO4owkoUjl3x7nX0mQthbzdav8d2OtcdJrPX
         4qmkJTVQvUKEzD4Q0/xqqKM7F+4d2WppTp/jZugX1MpaTVu4jkjC2Cm3HDRl/QTsZZws
         EvyFfiHpJ//gmti+nybh4pUMlr4L/4XwzNRKdlkatNslHqX+zmcq9yFQ4Z5QKTFLwZIv
         r+Bkb5JZgNstwFrPbCfFcMY7jD69Jsuq0eI/h+3sNH/r4j/PuRqd/Yn60/uWSoNSZSup
         yobrExJP+PiN+RdpY/uNffjBHSg3hJOdO2OyfG54xcfy6ELjOIF3IbmiiKSAOHqmFvFn
         gO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121919; x=1786726719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5/8EoE3A4Oj0hVOSm9+FPla2LLANPRLURLGqzSc/qs=;
        b=tMHF2BCMZ1c7OYzUtqWKwko2UCzRfQPegvMXfioXARW5a0IQdPtz2Wuabf+OeiGsdb
         IoEyHpscfxptUjJVUjbM00s4eQfTBq5qOVFi6bmC9to4R2UvDUf9FbBMibqAIDfHOGBP
         84v12ZZ+b1JiNab/hhiI159tQXSXHIjlraYsY3QCyhta7ZoRmawKO0wWYo0h2s4FIRv9
         uHD0NU92q+dtF9u32IpyilMay1YbqQ7I2MdA/eeHP0WwOvahiL05PQpzvGSB0a8phXEh
         niQd+Zf+yWcEC1rbjWWw4IsS2btVJKkWluzHkF05LnIsHXlwUdFS2EXaHnLLWHSVpxvS
         SzWw==
X-Forwarded-Encrypted: i=1; AHgh+RoWZegTKCGZA2bynbtUoRmmpPYW3cwEnig1Sw1jSOlypab7egP8y3dSF+DxnHXS2MUrEgngQiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3WA12pmBFfILMtPRx1TQqPNu/I+60jQ68+e5FKpv1XhcTKKIp
	wt8GBfXZf9xUNJ9myby9DFkJaEJZ6M4OLDQmNBEYAMR8RzEU+nWYzXtbJl9frRxxKbwFugg1/Yr
	9W0Gq26Cpy9oohGvQSa/1NPLfFSM/pwI=
X-Gm-Gg: AR+sD10EU9nbfJ2B51tPdyDD59xN5jDMm5Pa3yNvBxHPz7or6U1hUDuIyvL8POqRD9D
	O8OiUkWENBQWwsmeSAksiHCQSjRZRUomQWdzKuZ2EiYWLqSZ/8KEQ409ZB/1N2l7LpMF4t8vNZq
	lUQZDkuVnZvgI+ccL055mmufrPhj09TfPKOM/54DbhLeUuBTT7PvHqL4xLqNvekVfRyEVO5009w
	asB2gLKI2zKBDTpm0mBhyuX5kmc1y4ZbZrBYZysz8oIvpqSKaYGiMCh9jLsgkfL3IoIvdopmMAO
	6JgrRyb0j2Kvsg3nXuZJZiUw9bOU+V5NWyWWwuDLC/mS52kyO1hV53y9EFPWh0d2JsYb4ebNK48
	hDi6yvYHzDxTeGYS2fLFXFoVC8xnixY5cGTh+04APjm5WgZ8UOiv22NApONsj
X-Received: by 2002:a17:903:19cf:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2d0caac211bmr212771735ad.3.1786121919232; Fri, 07 Aug 2026
 09:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807151715.7247-1-chang.seok.bae@intel.com>
In-Reply-To: <20260807151715.7247-1-chang.seok.bae@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Aug 2026 18:58:25 +0200
X-Gm-Features: AUfX_mxB5cUeTLsklAcFAEo7uDCbOw1Ap5yy1mkxNcthyEJAuCZGMoHk7dyfwLg
Message-ID: <CANiq72=bEB5-GvvroXigiCVtHjGtkhs1ARkk+mDbvjNAR4XKVQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/build/64: Prevent native builds from generating
 APX instructions
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	rust-for-linux@vger.kernel.org, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, ojeda@kernel.org, 
	nathan@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, 
	work@onurozkan.dev, Omar Avelar <omar.avelar@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 5:43=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.c=
om> wrote:
>
> Omar reported this broad concern to me, when resolving a separate issue
> with his custom module. CONFIG_X86_NATIVE_CPU=3Dy allows builds to
> opportunistically emit APX instructions when the build host supports APX
> since the commit.

I think this sentence may be cut? I guess this refers to the commit in
the Fixes tag.

> For Rust, APX must be explicitly disabled because any backend supporting
> APX may otherwise emit APX instructions with target-cpu=3Dnative. Pass
> features=3D-apxf through the generated JSON to avoid unstable-feature
> warnings.

So, just to confirm: is Rust 1.88 (with a new enough LLVM) enough to
avoid the warnings? Maybe a link to the tracking issue would be nice:

  https://github.com/rust-lang/rust/issues/139284

> Support for this gating also depends on the Rust/LLVM combination. Rust
> 1.88 introduced the `apxf` feature option, but versions prior to 1.93 may
> emit an `apxf` attribute which LLVM 23 or later can interpret. Restrict
> native Rust builds accordingly.
>
> Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option=
 to locally optimize the kernel with '-march=3Dnative'")

This looks like it exists in 6.18.y+, so I assume this should have:

Cc: stable@vger.kernel.org

Thanks!

Cheers,
Miguel
