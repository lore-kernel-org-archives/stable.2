Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54335F5E4
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266837; cv=pass; b=BfjL1WG9phlu2zcGWq823K7ah5OKU+Gc24Z6/8gOJSEQZfBlMwg4K4QkPvmrdMTyxpGCtNjB3p8JGas0xs0db+fBVube0qycPqMmOQhzFtvz8W01g9JpOv16xYCiH0L+sVQnaZfBv5TZ7bo0XTW/AxL69UuRxmwHAn/ffmY5Pew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266837; c=relaxed/simple;
	bh=tSHTd/P3p6GYKtX3WQgUaDsZrGoJS+1kuOqNXUg02HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwFlxw0JaghDqYp9ia5mz/grpT3RP1J36SG7E8p587ZQwYOeKC3MMzQCe0WfYiJbYG4qPpuWbS8MRLUwqnnQAXcJ982PoyxlMpgfEu/A+6PblhDctRglQVJKQsLw9Eeul/DPvdmlOr3M6TwB/wBkLhcZE4QW9J7nIfRMViLYSag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMV+ztTB; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMV+ztTB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d30c22b1eeso4922325ad.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788266835; cv=none;
        d=google.com; s=arc-20260327;
        b=e5wRBm5fKFHW9jgCVg7KlchuWN/B388pFGTGGnO4KxW35lTHVXD+qxed0xhgc79x5A
         CTSd34WPHvHijoy7aHMsk1miq/KwkWo1hU+W1P3QBPx4qb+qNn1tVGJpYTixrVkc7iEJ
         j4sBXCPOhE1P1UeJfkloK/B5Gjsb9m/bAPi7T4BjDfLoG/VuOiSIK5dcZUpPLwjnu+N7
         Pe7CwfedsHGtt12658BYmVm7/gAxbEmEAb/cwROO1grAQzfzrn51pWQWxD/SLS8IKylN
         Wv6cpsVNHVvsPR3PsmXQCgo9/sFklKsuAIm5ftQgAS1Xhk+JK1js3AASxwS3wYEoSgZf
         yTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YY7/nqCIyRT979Xza7vq6CHGCQir1nfRHMiFD5zxFzg=;
        fh=5+QBF3LMMI6vyM7xBHLvLGW6an6DkeLQ8XM8HBi5jZc=;
        b=lUmrjy7tWM0SFro1tWzyZB+ZUI7yB//VDxX/Rxyj5olTB5YzbAU8HMrBEI7vuC/+M7
         zdv3fCWhlpadqGf4r50s9UXDSebsmTcQ4zlo8UQf6dPG5lBuhXNPCsIxIsJ0sUoY/XuE
         EunDZLrbq2D+j75j763HMj2sq+yQVhPNka5Y0ZfI6d9ET/ZzyM1f4Nqc/n3S5e4hb3sx
         +/VteYPE/S+vlw+79qwCojPQT+2l0btLZXaeyh+hwgcgw07EcB4FOxL4wHOgZqXmgg59
         Tnz2496awk7lhckxagaRoRJwYdWetHa6MYq7hY/EMEBC681s5nS0NOqg5E8vbs1bbbOo
         8aVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788266835; x=1788871635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YY7/nqCIyRT979Xza7vq6CHGCQir1nfRHMiFD5zxFzg=;
        b=KMV+ztTBbp+57dWhCB8ygIGzr0sDdURpsksWI3HQgz9rdwNtzM2s5YhHihvwKfq5Qx
         +VgwI/6sxKEpTCe7EMbExfq1MA5O2LS0VxPnMnJfshI1mFUa0rgAMxvUJGCS+5MsUr/4
         8iTUP9qqNXURS4He4+Mq0S0DZaP7Kjc7Np6547qgjBsa6R8/PWCdAca3nAEsdsVqFNRT
         ZzNR5SGWQ+olkO2qqrisWpHRsOoxso/pUK789kgnKJrOAif1aeJD3w9FVbHH20gXmpGh
         1MxTuWOtHcNZL6cSY+sjBsbUg2sUf2cNlr8PRrKL2aMvrLSjAEdeKrSoaBBSNwHe5EYK
         A5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266835; x=1788871635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YY7/nqCIyRT979Xza7vq6CHGCQir1nfRHMiFD5zxFzg=;
        b=S96cSGcZ75qy6yvANtkc814bmK8NyY3QkOn5n0ccPR16Nz4SIDaQ7sF8NHVqy6duFa
         a2qie6n+K3OkdDJZckLJxt+kcXgD67PcizRbcSEFkmWxnvv4NBrWRJ2KorsPrBHJ6dYQ
         vMpjP7R1nbyFGT+OxDT/xNlVNoGrOho2R/6qTLzryI1GA5pD8mUaq6uaHXLLKansPF6u
         E9vJG5xMJNDKZRqRZbTunSGoJK45q6OrInluhHFUrjetcSZl2O5n3CvBGoU2JIJR10p/
         /kE3ak4wCb1WEZLUf2QzSTXHMBmdRQpMMuS8nAFSB5bfDqYGsAqSwQRHKAz58RwopvS/
         IdTw==
X-Forwarded-Encrypted: i=1; AKwUvBwuYuWCjC3y2AM7zUeomDx8ee2oTSbhOu5qTRtVZhGKLttF+1WH2vtTcriavoCY0a+Wy/e+C1c=@vger.kernel.org
X-Gm-Message-State: AFuF++ndArSTj2HMJc+NBxls6OM5SMIeKaidcbl22GkUiyXVJKcdnGrQ
	zLWpEO734DaKZ2gHklX0M6NogiOCeCMLftAccU53l0BwgJJue/Tni52tkjNAbvnsdQE6+EgNY91
	tDAdR4j3xL+ImxuLDPZ4ygSCGBywLGo0=
X-Gm-Gg: AYBFou3vCI/XAuk2fYozORf/fRfcKN6ijwOpBTjf6LRN/xeNhPDCShGuNs3dmpL4wFP
	8U1Gf101xTeYk7qAGcBnZDAc8hS83lqT08jd2AsitCm2mctFUfG6TMcizuq99lhHiuq8w9RF2wp
	SOnrsCkR+WLXj/nuMffc0b3L65UiBbPw8tB/s3/BHYknuirEm7actIEyH/pO4cu1Txy4dH+GfLc
	N8XqTZ2+PtwiamSpulT2Fmq7pZxgggBpb3+QyXl74Wvm7wn1dG9gzt8uehn7y7j95Q+7ZfNZZ0V
	RhsvdOSdPOR1G9QUA9T19fCaJkjsUI3Uc2QMCETqUzc6QBUvDDHdt//MYrA1dk6tG7gm/xsizAx
	nOuP5zvtt4cEih6Hf0ZpgdDibIto4vK+LWKiZB8cPcDQ6brfYed01C8DMD7lY
X-Received: by 2002:a17:902:d4c3:b0:2ca:ecf6:9115 with SMTP id
 d9443c01a7336-2d74df1c3e6mr300904625ad.2.1788266835323; Tue, 01 Sep 2026
 05:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn> <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net>
In-Reply-To: <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Sep 2026 14:47:02 +0200
X-Gm-Features: AcwNN1V1Jwuvmj9QXGIMvnAzaA7Q6RWpCPniGM_AD7qCT09U20JkW5qZV4zK2EU
Message-ID: <CANiq72n0sgSPQ6SmUbK+tv9S5VZktA7g5XMjHOBOFNYLo2oA2w@mail.gmail.com>
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
To: Gary Guo <gary@garyguo.net>
Cc: Chunfeng Song <springbreeze@stu.pku.edu.cn>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com, kuba@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:03=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Might be worth mentioning that this is change is only possible since this
> April's bindgen version bump.
>
> This is a bindgen version that we requested
> https://github.com/rust-lang/rust-bindgen/issues/2674 and available since
> bindgen 0.71.
>
> This will affect backports.

Definitely, if the patch shouldn't be automatically backported, then
we should limit it with a `#` comment, e.g.

  Cc: stable@vger.kernel.org # Only 7.1.y and later (requires
bindgen's raw pointer accessors).

> IMO it's little bit awkward to have the comparision be inside unsafe bloc=
k.
> Perhaps
>
>     let autoneg =3D unsafe { bindings::phy_device::autoneg_raw(phydev) };
>     autoneg =3D=3D bindings::AUTONEG_ENABLE
>
> ?

Agreed, yeah.

Cheers,
Miguel
