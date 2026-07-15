Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4642BC34
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099212; cv=pass; b=lz06ZYMYtqK9vFxWQuPsk6TrAm86qOfruD46/MjH/i/kWenwFqQIKSTwj7i6+45yg0PFaNaUL93hnsScvDW+9UL8VZrH9gWpRewbeGhO2epADip1LQthoyypoZ/+9XrBSS++/VQtFGn9Q/rx3C6MfVMqS83fHCIDtGVimSOmHEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099212; c=relaxed/simple;
	bh=p2EMMrnVxqOTtiRkqVAQnELW3imwbqh/ojHP0xwjfzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MerIV3bjvn87A0QRfp5MDmakR6mW19p7EnH89aI6e4RdV7Sv/ojCti0jomuPNtskpGnz4nt7MR3tR33FPy9zb5CalIuOjfn1xe8sMyCEycc/SakXonndxiMutv3ka0o5hNlLrtQRWri5CLpqtq4NZGpKXBFogwiYzuGySqg3nw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKL095c4; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKL095c4"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ecf499af9so6522457b3.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784099210; cv=none;
        d=google.com; s=arc-20260327;
        b=jTUaYrOYjoopXKAsw6Nq3wCzCLNYXoMUjL+oW64VAliBUJmvUmS+oaLJMtj0p+FiZH
         mZ0BxF0qt18evuwdl4oJyIZLbU3YLoMcROor597sRITXtcy4FRx85DKL1ppckRFqIBUe
         iCk8n2tzNxVq398akCuzgtS5L54ymynidT/XIa2rILDqXrF94571tUwc6WHa8cgjXjpK
         KuDrqe4cV4CpftddDbj7KCZ2vxi/99c0CSZKyrJIVoDJJOgzTVexy9rHKcFU3hZitqnO
         clUOFxmCMlmVPDUrhk6pZL1ZaOPeXjdcqH8SmKERhw3RgTLmOGqbabZq+pqd5F5KuFRO
         OPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NpZ6Jcupvh46QbV8K3TWCquwqLQ1FypJF8PP760gOuU=;
        fh=TXJehBBwkzEz880SuQoKJh9QA5HnwLq6IRkaeUwPww0=;
        b=aW9TLNvOYw/RTogpJ71vyGv4q0t88Yyuo3q3TsoHgyvGci2ecy08CiK3AtujjR0orq
         YcKfWvulEKsvQ9bNk7/lZ04zrOw5Ib1+SpU/GPetM92rjut80Hm3Ts4gyCI0EWsK3RaM
         kN/A0PcX2bxMKi8vcI4X4WW5pL/MjHt/10bD2kFpj2S1XMVNGYn/Fy4oBkuwDGItu6dB
         iufXcgpkEXRdnHXqq2wuPHFrJkkgzqUNE3AMJT9gcHXefGbTJOm1HNNKIyKQAQCmxm9e
         74oNmyadwMXHEGKXBV2QWcptXOeqGkFXVDBdpdVKEIaSx1pNvEvM0geTz+IHKSgn7MVJ
         RraA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784099210; x=1784704010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NpZ6Jcupvh46QbV8K3TWCquwqLQ1FypJF8PP760gOuU=;
        b=CKL095c4IzzglWE6n9D2L8IinB5v3V1DRHSQw9De+hQ8Ny7PHJxs3Xb5zhNjq8ypth
         rIaIOD3Svx6YKWvQ4ibmwEUOU3WcDRqnAiyTmJaqbKXKyNjnFh4B7HJzbsihXaCex76B
         bxK9PFLBKuBR+cYJ6pYZtOSJw5Eh5k4dB2M6046zuvf9bktDucpa1UCLoTFNf7z+wuQ5
         yJSxBne6x70ktp6m2tF4UTeL2qQASoLcnkMhprhp/2COiVcgOn868f47iwkxn+cvLOmP
         jbWaGtgR9r78ElgINU6ytvfpR4d/V45ICYm3/3hvWdcWz6D2NxTSSqN3NdN1IdA8RBmG
         fqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784099210; x=1784704010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NpZ6Jcupvh46QbV8K3TWCquwqLQ1FypJF8PP760gOuU=;
        b=QBScMXOSN46C6NbHc2T3Z/HXw6a6hTDEqOfCppjDzyKxTXMDcDbkHg0k5uB7wRAlnU
         vHFq1XveM0E+DRAhc2JF3tI/gfM6zzrM4stoBsHAsRAnSrYN6e35ZRO0DOMxnORjRnEO
         FhgzAokFRbbufbN3ATtHPBnmWghHxMt5X6Fw5A18GXkdzQF+dn981xXtiFZPDCMHqUTi
         n3/DNSd7HgWcbCwjWqImWQUurklWQ7md3q2EDA+OharKfIMVlTU788ua4YfwYUzauZ/d
         Jb8eO2Zi5c5TEWWKNLLwVHMddcWSxPN9fyKLS3leEiTV55T7ilSP1kK13vnb9V/cISJx
         m0mw==
X-Forwarded-Encrypted: i=1; AHgh+RqI6q2d773xdjSNNhXjnKWQJ4qeXuPO8bxE8+NXwgprlcbL/amDiONqJc8ksRt34zGQvei9Psk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTZG0gJTNbnK1c6XpgABwsFBPfYjjvLkQHSey+YlXT5MEyALy
	FoCJD1SImv/A0nkSEUp3Rb1AIw8rdG9osjvPSsZ6vgtFtJbjvGhPw76EHQZeRd2tXCvUewjBr4T
	gH8EeMPI4YAgB79ExvSMgfwg5P36Mrek=
X-Gm-Gg: AfdE7clLYW2V4bshVT30oW1dccrKF0TGqgYtm3gc+eHVhHTbeSWKxPV8wtm1uetwXCv
	H7VssJhR1ejExVT8QKyI6lhm6ethQ+ArFhIH4i6FUbPXfxhbpItV/Ziw8Izn8Hm3oOQApB27Wwt
	nL0P3fFZlq1y5+K5ILo2Vih1NG71TjSVBaWG28x6jWyJCYlteOxmCsiaTz3JH3jvyJ3hAdTw2uI
	RdVaCC8Xv+fbRX+gzrB85GkvHmcGXfMdzHHM5rVU02rvcrLGEQRzDtfj/itCepA2llGn+KSSA==
X-Received: by 2002:a05:690c:4507:b0:7e8:6a6a:dc11 with SMTP id
 00721157ae682-81ecf86d451mr12713117b3.19.1784099210433; Wed, 15 Jul 2026
 00:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713120205.1003691-1-lgs201920130244@gmail.com> <alTv3j9hIH2qjJ2Z@hovoldconsulting.com>
In-Reply-To: <alTv3j9hIH2qjJ2Z@hovoldconsulting.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Jul 2026 15:06:37 +0800
X-Gm-Features: AUfX_mwMVIoQ4P2rxDkVgjIjeTAh1lpuwURAt76LNRFtWsBtWR3K-SIy6N9kKfg
Message-ID: <CANUHTR-bUJ2H6NPavd88Knw_v5Ex70LBHMdX2CguHufgvmRuPQ@mail.gmail.com>
Subject: Re: [PATCH v2] intel_th: Fix MSC output device reference leak
To: Johan Hovold <johan@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jul 2026 at 22:02, Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Jul 13, 2026 at 08:02:05PM +0800, Guangshuo Li wrote:
> > intel_th_output_open() looks up the output device with
> > bus_find_device_by_devt(), which returns the device with a reference th=
at
> > must be dropped after use.
> >
> > The reference is currently intended to be dropped from
> > intel_th_output_release(). However, a successful open replaces
> > file->f_op with the output driver's file operations before returning, s=
o
> > close runs the output driver's release method rather than
> > intel_th_output_release().
> >
> > For MSC outputs, close runs intel_th_msc_release(). That release path
> > only removes the per-file iterator and does not drop the device
> > reference taken by intel_th_output_open(), so every successful MSC open
> > leaks one device reference.
> >
> > Drop the device reference from intel_th_msc_release(), which is the
> > release path that is actually used for MSC output files.
> >
> > Fixes: 95fc36a234da ("intel_th: fix device leak on output open()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> > v2:
> >   - Add Cc stable.
> >   - No code changes.
>
> You forgot to remove the intel_th_output_fops release callback as I
> mentioned here:
>
>         https://lore.kernel.org/all/aktZDK0NZrTdEqOm@hovoldconsulting.com=
/
>
> Johan

Sorry about that. I=E2=80=99ll address it in v3.

Thanks,
Guangshuo
