Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053D2E7631
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041075; cv=pass; b=Y6YxIiXlRO20/418NAHxX3UA0xUSBnN+bGgJyh9kEky8a3W2mgZpTN/ySu14/aNH763AThBflwjewEepjRGEYDaWbTxAEAE8RklqP9SSyonp+szxeWmZkN9q5Bj3JFmsGRjO4WUQaeGpwddlabDqB+P95vEbvV+aSStbURMO7aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041075; c=relaxed/simple;
	bh=bPY2/askpzxhwcWequ+nC5hFKm3khS0/ibmKIfQhbU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH0hDHYrndgyfOyx84+t1bFYDLwVJnVBd44g2wyQjDmpZjrHNl+hL1KYaar4nxb9C/P8UatBfZnxzh+lGNYZ9ymKTZPV/T+XDo5rEtbv1ZDNG3yrYyDPjmpQgrSpmQ3jpHg9+D6PT7pSZ5raWrN0Bf0woTC6CGgN0XgqqXkroj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciR2roxd; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciR2roxd"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so16390061fa.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 11:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786041072; cv=none;
        d=google.com; s=arc-20260327;
        b=m1pMfjJjy/KIknrLB/uV0FthnB+IRTPGg6Or7b01cOp4dUNLDVYPCiIq/T5gThITS8
         pEiG6BEXTw/t0OUdJ4Gy5HV3UcSpNjHK3/RySrKiGb5fR+Gfsnf2ixPzEMK0Q+okt8PG
         HwKJALDfuLeDyoU3FMG8K6LvHfJ3jVsN5AjiLtGuGhXGh5TRf6eNAdDNxdOHY/FSHz3n
         2BPkJN7/sYZCArVwd9ZIOccxg00Jf2474ndjxan+OTrR07DsT5lv86a7p6OJbtOVcgEh
         vu7ypeDXziSCEsDmSpLqsDfNu03f/naKPEcyeNl/de7Oi6zdqeA8sc0oobOGxEqEFMmh
         yU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bPY2/askpzxhwcWequ+nC5hFKm3khS0/ibmKIfQhbU0=;
        fh=kedfbrCWU9FuzR9Pa8OidO2RRrGltVbk9tEP68Q51lo=;
        b=CkrpCJ9Ra1MsQUD2jFKT0Hv6kdX3mrxBUYsFfSTNI7sEr/0kMzhIgXEUb3W50r0vnE
         KMpBkYuuDYcNpkBZv6cHFFNMqrDqqi4vke0cNLdUfNkjYC/41bqzJ04MTO2Zt8J+kMea
         9nW9PU6he46phEJ5uuYg9P5yPjNuepRt96vsDwd3m+Ue9bwIIt0sCPgtYN/jGghgyoVp
         i5R12V/d/WBQpLfyB/jIPhL3z1ZYMSikPTyEnIfwdJUWD1NUVjN3/g2wvUx/AT1qS45Z
         tUXvw0mS0RVqw3Dx7FQi5lhphbS7qN1whREUn9qYL9P0y606GDgMcv0EeovAKp8TRFLU
         r5fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786041072; x=1786645872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bPY2/askpzxhwcWequ+nC5hFKm3khS0/ibmKIfQhbU0=;
        b=ciR2roxdKQ3FICSYRVgOs8+D6vpeuZDCD4M0krgd64Pj5VV449wqq6Q2CElGIPSiOY
         QZi/zcfhE/J6NjVjJ5axRMTvTmuyL5lAfSU87IIbqEW/r2MMgojMyq3fzKe+oAja7CPE
         K0wgcM7QvgKWJ7y+QQEsiDnYZijyy1LAZ1eY7IkPwqOjTdfK0fDAm5WBccyE0k5aHI5B
         ZJAtfl7m167BYKj96DaSbj39T/BHacGVKRGNcQCD1kkNd5FIiUtFe3x/bGMpnpQfQVEZ
         t1v4GOCKfycsIOhjR1S1kGJqjpG1D3fRmRPw68b43DxyOyBv706/pJrziTdzexb2qoMc
         8aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041072; x=1786645872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPY2/askpzxhwcWequ+nC5hFKm3khS0/ibmKIfQhbU0=;
        b=QKBpmnu0L2XSpIT3bvyw0w04uxAxSRaX7raQwMZgoeYUOTx4eoqxxSFYo/3IMIQJgM
         bW77KUnZrhTMUfITcZKGYaAohTC+79CgmNVj3aoycaBCih+o9/FU6+Pg2yhZ0F3GQfKL
         GXmdwTx0Jx4dFaEGZE6pOGmrJGn26B5Vf7G6CT+EWkWVNM+W7AgFgDg+ozMa71P8r8ZS
         DiI2DeAxpyKVdv130blz/TKgX+GBg6WZJZPwEOxCOhM+/zkwssmVaZA8vMglWKQE0BL/
         ng/9Z2zfBcU5oxH2ygrI1cvFPzyZbpHE8CkB4nonBBI4etsBgCf+LxUWqs7npfpozzCr
         cxzQ==
X-Gm-Message-State: AOJu0YwL45eltO2CHsoqUeZhGLbVYQGexOEVLxatYQbDQr0gfgEK9NnO
	JnE+FFvUVTsta4jG+Xw/p3Umw7Bk2aiV/1vmRSsV4JSYrIofZeOlWCKwZT4eb26tZWmCpQ4ew5C
	uvp6cOD3XfKD6iOZusPX1GpdKp0QeVsN8iD3kVJIj
X-Gm-Gg: AR+sD137Ji8xNT7XvtMv+ihRGgtVTtJPznGM/uEcsDHUgVclAWY174grl1RdgCMSBE7
	KLJHnyGnnK1uSdrx7724pQzSUs45ApQkk9wcPH20JptSvtUTyHvRaS/DAuHJdll4rktjelhG6nE
	xsfwcg9xQGs0VU1tTy7ZHX6uuz1L0gqfaet+dK+2ZwltUF8iCEYQrY8Myi77uDGmxVpbspEQMhp
	TYNSfjDitWeVcyOsUthHaqqnoj2CAvvjPgdbkj87RHDQmwERH/YxjOWY21OjTyyH6UpbM98p8UC
	K4Epn/dCeGC2xjkz1uOLm/AWD1TYw22D4P9yQsRSn4p/i+ZpImh/zTZkC8R4enFqdbbI4zzOszm
	n7JAX5bxvwXudRXfZ7n/ak8uoK32V68YLgfMB0rXPGg1mtL+SoWl/m/QQmlRJR6NLvhUaIg7D5f
	I8rIuQQhtfSKaDXjhs
X-Received: by 2002:a05:651c:43da:10b0:39b:a75:e8da with SMTP id
 38308e7fff4ca-39fbb0666a5mr16162941fa.3.1786041071636; Thu, 06 Aug 2026
 11:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806005214.179730-1-tkjos@google.com> <20260806131000.stable-0001@kernel.org>
In-Reply-To: <20260806131000.stable-0001@kernel.org>
From: Todd Kjos <tkjos@google.com>
Date: Thu, 6 Aug 2026 11:30:59 -0700
X-Gm-Features: AUfX_mxZKJpjGEy2IyljhveaDknK6Gy6g6yRrviQgzrdeRt3NBEeRL05w2q7y8k
Message-ID: <CAHRSSEx+gmOQr74PzoMZK+VEnFTj_pE4zDbqv2SAz+VR47okWQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: L2CAP: Fix UAF in channel timeout by
 holding conn ref
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, kernel-team@android.com, 
	Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Siwei Zhang <oss@fourdim.xyz>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 10:49=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Thu, Aug 06, 2026 at 12:52:14AM +0000, Todd Kjos wrote:
> > [ Upstream commit b66774b48dd98f07254951f74ea6f513efe7ff8b ]
> >
> > l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
> > the connection is torn down while the timer is running or pending,
> > chan->conn can be freed, leading to a use-after-free when the timer
> > worker attempts to lock conn->lock:
>
> Looks good. And I can also queue up d38eaf611839 ("Bluetooth: 6lowpan: Fi=
x
> using chan->conn as indication to no remote netdev") after the backport, =
but
> your S-O-B is missing on the backport so we'll need it first :)

Oh, sorry about that. Here it is:

Signed-off-by: Todd Kjos <tkjos@google.com>

Is that sufficient or do you want a full v2 with the SOF added?

>
> --
> Thanks,
> Sasha
