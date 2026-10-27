Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793092069;
	b=NPS8cTu76QSvLp7dGXk8DQUDTHFb0ZlvnXv0+QWc92+OKDdNXBhuOHi1biVcIPdJ9QYD
	 8mUMHa0JIaKzmliRd4XR2+9Ig3/2O8l9LQP0VZx4S5Z/ha3r1mEPH26+pyGXo/4p654S5
	 g0SCJ+Auvave0DLKZ1OPhJhOS4bqc1aY1CZ9c5X9X8di8aK4rpz0UMm1ydn3vTM50w9XK
	 Gh/yjz29TqTr3WRcxJEZxUDcJ3kFvNJMiUGahXzub11LLLp16WGXn57GsKq9s1oHPJW2O
	 wNwwXGEVQVZjXuMXkY8x9jOe3qyG7TvI7hO/b9bXkn9rZudYbXqeUKVfBt4H0GN4RhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J50MjdbeXeR0wrBPwx4kRTNSm8kxLqeUdZkQeCxWhMw=;
	b=XfRdyF/dju2dB8ELVVLp6xicNQdUo7oHp4XmVpNEh8nWaCwlKCzEEP+4BYRuL+o2lyrc
	 mZY9c1QWwOKUSyG+XHjPRloSShMWfouJ3vJnqpVnO2e7YmgcUMo6jXPFvc7IW6NNQrFz6
	 j4Jex8AWYgB/76EWJLRj/dF55eaSvV6S+S1cPRuAsnb0EjN3wjLO2RGwB53FckweRWKjN
	 ivmEL5bL8DMejDL14nCsMVuZaTOl3zb3G22auXWyu5Ri/sUkzVEe3HJoJSnLPm+sdSdAl
	 Q8uvBwnseVUYyQwjMJ9cNN1YoAdvEjcCVzhzHFa+VLkkhpoiiikHbvMi1YmNUznsjkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132A606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B132A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso2050736b3a.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793092063; cv=none;
        d=google.com; s=arc-20260327;
        b=ExJdCvjBWeUhWH5YXMTRypMlKIhkcCcDO6ER5SjGhOelNCdrpQjoY25h5ibhmk0xCW
         zxcgTOmc8aGmiIrduAMLUnpszdt1ZmSTFvKJNwdSUYNp+zQKOakLAX/rjp+4U6nxyF7X
         bZXlheTFJRkbfzjbsh171Tu4aL/B0HxoZ/RnH6iHNSfyxVtxWEF2wieooBFS3DAjxKiK
         x5xkoITpzVAiIL4XbMR6IQfKIhFipdMQmnoGp++4SCT1NjS2QZ+i+0iqBjCMWE1W+YX9
         5UKi9B9IeSnM0QpGeBOihUGjIO1SntuWOBkfZb1VKFqj09KOCYPDcBLQ1VCiDUxb2Tny
         IOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J50MjdbeXeR0wrBPwx4kRTNSm8kxLqeUdZkQeCxWhMw=;
        fh=xKUBF/RAB59ne67yxWEoEaaR2BrPcTClf5s235shtOI=;
        b=jmdepzQF2pj7Mys0T5VrWWTDQhcHB8AZOZr+7s6YgPgE0igqjBkSxciJtAwhjBelIe
         ++im1lSnorsL05PEDF1YnMFK6rER2innhRHIGVccLq9NptZyj9rLQq3/PmL5tjLDLXls
         3VbqbD7rtEQ6yWA1cOLhAOd5+sDWzvoXx60j6SMuW+PXnEJmybrgeK2mYKdNYrTb0yJM
         1RRUsMMuNeR838DzBnFuUj1t0mqbXZwbnwEglNwensvsGhQpYBDCWnXqQJqIHPZiOuUL
         BfbA44EBxVMbFDQ221erQUQagU5e3eDgVNe7X+Lt6RCWp5whMVlAOs47a3zzRuYMOTII
         w1fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793092063; x=1793696863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J50MjdbeXeR0wrBPwx4kRTNSm8kxLqeUdZkQeCxWhMw=;
        b=G84K39SCwuHHBvc+MO5/wCRtcI3mXN7cKHRkHkiE3pY7m+FKUJa6WEGgo0KVwCJoWm
         34NYLJK07mpqdKBTmxO2iklWV+MJLFe2bcPvJkLLDFYPjLHSNxW3LdCx1tu96RBXVwU2
         O5r0AC2sSHXTH3cBnCNy3pjOixYYwQWexJS1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092063; x=1793696863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J50MjdbeXeR0wrBPwx4kRTNSm8kxLqeUdZkQeCxWhMw=;
        b=OpEjjp737QvEXGuhEF4wBWV5IjEVdTt5FsnhL6y02fxcpnBGRacxRZHCuhI17d1voK
         vhQuX4Pg76oLG63QRQXXHDFj273MEwakmkj2MK7743eiLvYgvdpBsPrrMNrzH6Cz03kw
         vRIvBWO1Z5tut2pm6ZLSs+5H6fx5zUz81abvX3XCvuyqJyXL4w+ctvvH4j4TcaeZNLP5
         A7ivJmFzaMv9wKdqHVcLpPeRpGWdrAZAtPmj0uwUTPXfzsjmWVf4kKj3Po58e+I7GRc7
         CWYF+ucFl/Jj5WDNvR3q8CGeNlBKi59OmmEzzD4i+mfMMh/qW+f0jYTcyEB4GhAS3n0N
         dsag==
X-Forwarded-Encrypted: i=1; AKwUvByZmX8QxNfC5VKr+E+HIYpZalAvpbRm7tgyTEsP0IrkFyuPspPLHJfHQ5PJ7i75ofcqSDLyFR8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJq7XYMDGE2zbPZsjojplvyuMvVoC3H0PgfVomAc8Y/RoR7d+X
	XuxV1iga/c4Ag5Tl9gFy4skPn7TUJuizClzp8ma0S4LpIvVSaOB/yaY72JrBn4yb+S0r5cYFhY9
	q8F1erBAbWHz/ZdjF6SIudu+oip9deTgSsbGbixVR
X-Gm-Gg: AYBFou0WG7ucjgUy8JnBELuAonHPRzCd3a5mK66nJDe57y4MKD421E3dQClNQeB+S6a
	1zFeRY2BKbTYSP6ixUinxwXVv3LxFkA5DA2ulr9z5CojvMwgJAowlU7H4Pw+y+bukD0KgqwgMOS
	OZAZxEPrxBbYJBlIGT+RfNc/lf2A8qHGbfMg6VCpoEVolwS3LccMz33JJu7pxINMHfgi+OBNMH3
	M2t63Xx50GdDcIMQLoKfzUBHE7PfPoFXW0UOS1G4mryZ39rt8IRUqmka4dypTZ/UMPeKcnnHb21
	XE8vhY9y+ujdfmyTrge664WS0iqOtO39ccZwOIFYqQvNHjrJbzBaMCOWFMsDXzgQvtP44rKbMo4
	0FnApaAijxkQ+gQuW1Bg1OocTLSarPvcx8y5KVhMDogxs/VRExJpaUCNFlxiuS3d15z5sS2m3uP
	H83K4/b/OZjMKI6Kw=
X-Received: by 2002:a05:6a00:2406:b0:8a0:3c:a8cb with SMTP id
 d2e1a72fcca58-8a364e531b0mr6883577b3a.1.1793092062949; Tue, 27 Oct 2026
 02:07:42 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com> <179308810546.3327.8505039495265223974@kernel.org>
In-Reply-To: <179308810546.3327.8505039495265223974@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 05:07:30 -0400
X-Gm-Features: AclHuK_Cr6xryEy8YJzQiqxJYKCJVeHztHClEIm6xa5N_nPm9qgWgpwlRoLVrKc
Message-ID: <CAM0EoMnHOFLc6m3zYS7YdC7ZA8LvwXvGjPg+fUKqCJ-+RrVczw@mail.gmail.com>
Subject: Re: [PATCH net 0/2 repost3] net/sched: sch_teql: fix header-cloned
 write and retry strip
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cheers

On Tue, Oct 27, 2026 at 4:01=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

My bad for not explicitly calling it out in the commit this time to
avoid you sending this email; answer is the same as before:
https://lore.kernel.org/netdev/CAM0EoM=3DyCSeB9+Q8gFsB8sjQhddM9qWh8DOfSqqNt=
p6byubv2w@mail.gmail.com/
https://lore.kernel.org/netdev/CAM0EoMnb78SoNwrqgH5308B_+Mh1sBtm+wJ=3DSFXtM=
HS-L2zfXg@mail.gmail.com/

cheers,
jamal
