Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680444AD7DF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448465; cv=pass; b=f0mtIsb/YHUesh6mCg3P6pkW5yurRcLgnlaEZvU+wr6QNDw8KTu1mDS26cUxWdguYzDArOn6SirZdlwDCEC7ic1btynkyRA3qQ/rMq7X5Yv8XLa7xBHLpewb1LMNCennk2044oT1nMCeAUMPZdg5anE+/lLrQAZKFohiPW4Xr+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448465; c=relaxed/simple;
	bh=8Yw/QBF8luPBw/qJa+N3sx/paqHaZ2mTOwk3Osh8g2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIIHSdvbFhq87LgaNEX6sD6HWufhczADwDsQncs3I3UFQMFyoqzNL7UG10u4j907djlL/oB0/Gzi4q5WWDU6mrGqmVaaJ+kSaIL8D4hck0DjPcI7dMVh2rF1kJq4Lwp1qqFuv/NoCW3SQnHcnW0O9WPrpCWs8zapBYaeInzuDpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXRHgUd8; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXRHgUd8"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbe4592c193so930a12.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 08:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788448463; cv=none;
        d=google.com; s=arc-20260327;
        b=dpnsnQtH/ukijM8DKEk37/DnZeuucLvMx7OZJnMyVi0oQJGjCoQ7jcGarajeIqNsEA
         TCDXbVfmJyhwii8LAiX5+e81sR4cTueDt+etPPmMMJH5XjifJ+Z8tBRyvghlQSAiuk3z
         QhGuPW3mICZPdPd/aNBNuYBsQdZQYvKBEoyHfDXD9i/tGkuH43oWoSTRg5AnH/03yy48
         rRtLOO8GKOeJPHQINJMnW+nmmo5zGHu1g/48C9VvzgFI6qOmWH8G/AZS+sSPG2JCg3fs
         WT7PzRfOQ4HW7g9Qp5qK+AOIpOvT8aeqoTSZ6RnTjhHP6UTm+mJY2sA5S2+O0IbQwXw5
         AbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Yw/QBF8luPBw/qJa+N3sx/paqHaZ2mTOwk3Osh8g2U=;
        fh=ZXH18aCZj7OO1l//4N7B6hPTg2oFZvRPQM/FrAh8Iac=;
        b=QXZFpTrGgj7+vz34Ml36OffEq5QzCcEAW3/i8afWgaF4csIlC0IOQaCcFPvak6/M75
         OePd1unB/craDQuHjXrFXp2nD+xpEBw09hv6jvxiiSOmwrQBpd5rAUSMO4O9IMp6cvgK
         cgB+J68yFGLZG5qKKBiibQ+NBf4ZgHP6ggxvq2n7OSn6HmBxa/pvtfrSlLagryLzrC7G
         45/uNx48bDotnqgcLtJXrNjoF2UbzzPK/fzV5Z1bd9hTQX220sc+CD+EPYAFm3UvnjM4
         eEnl8KuJiwRWg7Sjf3OdWdAhl3HrhAlKWjg9jAQR3ARrX1zb6CO4tbrcNXl9GdkZgyO3
         eA/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448463; x=1789053263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Yw/QBF8luPBw/qJa+N3sx/paqHaZ2mTOwk3Osh8g2U=;
        b=jXRHgUd8bCRcbbCJi/c/x5r3mnYdR263cX7lvZb2VPnpDKHWy+GwW5A1KCXR98uqkI
         adAZX9MpBy0hdYT4GD0/eJpm2pHAmv/opSW0MtlMiQb3vH2yhXLD7cuutoRrXUnFICO8
         goqdbXQF12aAVvtHYAu5Dri3RK9MDaiadOUZDvRUKe13pIqgc75J7B+8KquieYoZZIFw
         CQabkufyjy4YY8f91K0TNfDK7k2er5MqKXmo76VUJeqqkcpW4Ed6O4b/MPe5RkPzRfY+
         +Lo//RZOt//A+ZKRoyK+3zdMaAU6e5PKywc/rhGJfni/wQhRCCA3hrgZFW6f3fNCY5Uz
         mfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448463; x=1789053263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Yw/QBF8luPBw/qJa+N3sx/paqHaZ2mTOwk3Osh8g2U=;
        b=a4qCP2JTRtM0ugUQjorZP5DMcB/czjwoJokC+NzUDSRiprJToGd0xoK9OTtC4rJzcZ
         9BpMYgKUMz7c9oP8QHUgP9oYkuYQUmEVhFJ953wC2zB6NXKd17PLXnpNPoLOiWNZjROH
         ZvRa5xOHnnigv3kWmbwscvQ0eTWCxQdS0bxC/ofcjaXWj0zjuwE6IVe/B2o5rjUjtIWl
         FxlQUS6NxipgmZcEEd9mxSfVZ/5HqBS7WCqdsvg75fQq2zR6kRkAdhfumidxtOK509XS
         2WJqQsUC3OWMZZxCAjqYhYI+J9LUf2+msScNd66v7kOSGI0dhwIlyyO1X20P+jR9vtpy
         zAaw==
X-Gm-Message-State: AFuF++k6E8fn9i+pDZUjHAGdCYSOLqzir7EJojZIJcmfa/kCGFHBr8XL
	bBNFysBbcpWXkRjJJE+UeZdlKoKLWUcKy+PzYUCXKIj5slYlXZI8iS6ef15ojZyPA+AKCL28b/p
	vIPXyz2zNvCDcsohIoKIHkFOUprQ2ZF0=
X-Gm-Gg: AYBFou2gbethiCMIFb8J0yeNlyL/znSemTCvY+ZzoO54zYdV1xXXrKOYc/YptY1IQEl
	hRuPmylZj33MIDNQdBwoMZvSEcsDo4Av9nQePlKUaUGDmApX0LvAcFDaEQeWsaZZOQzo0jg+2Dy
	aAig9LLf3hEu/XHJ4unUlNrCt0Vluvu+G9Td94mcURePcYbLGs7qSRRSjQlkcus+IM/0bQ2LtwP
	9Ck5T1LXBT12oPB2+pnMpx/RbM3oMGcKPiT7+qaurDmpSzgf2KrmHez2T4RE5zUCA+yUFiR8c7P
	MR33tESZ8w666AkIDN9+zNIt/10u7gexzSGszuTvFbC/8QhC3xyNjHjCgA2ELY/MtBdeoBCJcc8
	6KTtu3b4M/YbvcH+q5+F5xyyQMNpxYqGW12lSxlbS6qRVFhDjobc1ycLLqxv7Gmffwriwd9aq
X-Received: by 2002:a17:90b:1c89:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-39aee12649dmr11476083a91.3.1788448463122; Thu, 03 Sep 2026
 08:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090302-mumbo-scorebook-4564@gregkh> <20260903133614.760808-1-sashal@kernel.org>
In-Reply-To: <20260903133614.760808-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 17:14:09 +0200
X-Gm-Features: AcwNN1WMt7OqDVdUt_GtvALTCBK4buZcC4x5npUs7g5beeMsc0Eb_4G6rCKV_Lo
Message-ID: <CANiq72k=jTJ-CWUzkoynU49q1SPWJpe-0QArVhurHfLz--6Kbg@mail.gmail.com>
Subject: Re: [PATCH 6.18.y 1/3] rust: rust_is_available: remove warning for
 `bindgen` 0.66.[01]
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Tamir Duberstein <tamird@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:36=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> [ Upstream commit 41cfbb4295cf9fcdffa6c89ddc84dca2fa392c98 ]
>
> It is not possible anymore to fall into the issue that this warning was
> alerting about given the `bindgen` version bump.
>
> Thus simplify by removing the machinery behind it, including tests.
>
> Reviewed-by: Tamir Duberstein <tamird@kernel.org>
> Link: https://patch.msgid.link/20260405235309.418950-19-ojeda@kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Stable-dep-of: dc01dfb37b34 ("rust: rust_is_available: warn for `bindgen`=
 < 0.72.1 && libclang >=3D 22")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

No, this should not be backported -- `bindgen` 0.66 is supported in 6.18.y.

Cheers,
Miguel
