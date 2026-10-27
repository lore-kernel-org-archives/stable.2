Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793091865;
	b=LDe5UJYe6gOd1r9SrUGNDrFVHsCQqZYPpeDDJCMucscguBdGevt38VXAeTNmim/Z7kJO
	 X4rTwOf+RV5WxbYgLnuaLfDrTc+RFF33wfKef7e0EezQcbSnArlgbl7/4B+pbpdNC5c7v
	 exjFWUG7H1TQ4bKZ/M16sB+i1BP6vcDw4KZEjTkdYOvZoIKUFEDW5x2vfjKGF7KH88sg/
	 umHtrmQxMv6V1ClhrM7U4Ig9onH87dlTDOJbZcjf32bHYRwD+RV0jfTuuvmGQgxVFL7kj
	 S4KcQ/qiQ3ly11ZwwdMJETgrB5bORjEScET38bvctXs2SdDVvTm3Bg6+FOJJnEHjYcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IC4ICtskpaMr1BDvtcg7zj+mYWKpW8yLLny0A2JJ3ZM=;
	b=l+PG5b+roZdH2eQwinSabfaLhMGNT625opMGbFYheFbSxR1ZG11S3Lqudln3SmmppPPJ
	 Q0o04n625yCcoeNte+WDHnZt5C05LUklU6QdaZVkYwE3mAPoFszphAtecjZLBn/8piQqx
	 qmA/FpTBr0zBsq3H8+tP/28ZKF+ZmjWkUdUNm7zjELsXNCbSCdIASlbyoytzZQM1OQbH8
	 Yo3qiAsii7bEsQJefm3ep+LOswnmb3tvkJAh+0z6XcV7pxr754Syvo0kDgwVIjFOT7ivM
	 LDfIzNV5o8D/7bHstzQojFV9fGXJs9BLXT0AwpbSuX6Q+dJwK8hOFPi+FUOLUHrlxRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nuXcgjgI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775B606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A775B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nuXcgjgI
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ac8a2ac52bso9606037b3.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091863; cv=none;
        d=google.com; s=arc-20260327;
        b=NAiOBXoE7bawEmLhIZ+RpF7OiKt4BHK4eB9SUrLxIQ71agFP/kQ/iMbjkGrMiEsFHh
         DzdSxxZI7GTxhkHMa7plT5Opu1Xkyoi0ovXaVURoQcR+lNCUoNMluUepzTVMvpHxUIDJ
         dA4Aesx4/8DGq2UieozD6JVDppiOZtC5aDKMy+CbH4XBIqNZkVPEwNL9uBx+XQt9k4AN
         034tDqGtEqE4qPaElP8H7geu6h0FiwyJcgvh6t2eDYPev1gk7MM+UaguUOesap5HTol2
         RbHJZ3zi5JtrulONa2swGeaex+uzHit+MC0BXc+UGjR2XvT1Cd41vFmHWS5NVIIxPlHe
         GDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IC4ICtskpaMr1BDvtcg7zj+mYWKpW8yLLny0A2JJ3ZM=;
        fh=CG7s0/SGvpFJYi+0Dlr4/Ypl0CHAi2eYt6cv/2Z0z6U=;
        b=Wr3ADuqfZnWiFM40c5iSpLIVZ//yr8msdS7MmL9csZ40UWKEOCsMI9w/R/EBWxGoVT
         Q2vDxFulfgf0/3m6VT+5g+8j32M5q3bXTZfUqwJOS6n958vARkkiUIB9hp0wK5yrB582
         ePgoSpZsiiYxgQxoKCnPMJt8WQu6Goiz6dmqay2Uo+1A7/dEmNIdGXHaCr2aC813VrQa
         YvzDxNGY4s/lqc0QzzJ1mjO1culGHSM/iBrXnG7vYQV8M9NMFwZmK8Y/wuZlX4kmpeyk
         qmS/fqzPJWHkuJOyIkAsdqO5yflrwfZQ8V8smdhBPbiA9U0rnaKCyIxyA8/jYR8zCDXg
         +DCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793091863; x=1793696663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IC4ICtskpaMr1BDvtcg7zj+mYWKpW8yLLny0A2JJ3ZM=;
        b=nuXcgjgImRLpr33nbQdXKUCCrMD6AEqN2Xnpc+EfrpyBTbxxXk68hY0rQmm/6syrel
         u2dPxtll6lq7LM0pUYwkJWqgo/KhNVQdQkBWIwm9Yd0qB9uH6hSuqcw2p0/+CqZk6S9K
         0yQu0+Htg5AeXpEnh4Msr6+u9UGMoZj4NT8IXQZj0MCj/O6qBq0Qaz+DUTD+uq9tmE9g
         kFCUXvOVFVeRROMpTCRF+Odr833ULEPnJge1NfbZN0elhwcGdRQ7qiXcg9u1sAypjdvJ
         LCGMitjTkGnJnD8qpgZ4gxH4BhVcyKwO+bbaK92JN4UVpYBqf0+4EmgmcUkWbQ6d3ePE
         thLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091863; x=1793696663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IC4ICtskpaMr1BDvtcg7zj+mYWKpW8yLLny0A2JJ3ZM=;
        b=PywTPc91npdPWK1GrR1cyY/bOJDkKCEJjQxNf/6RK+r/k2tsK0DrsVDiENhwWB2TBr
         3J3OBjipgGZBtEpfaUpj+ebox0V8d7dSJywSoLygJThElFKn4YhA0wwULnecwS6eQX+U
         bjmZBCEDvOnduFmrvZfnhyaUURqdBY1F1X0ynffGiZEl0ZeHkximjQJCnk1dNu65yEeN
         kFwoeNuGMsAvjgOAtFnB3QB9UF+GoqtSHQn4ktfAcj/W833aNVaEY8medTSnuci67kBv
         xhyVh38FWfN0hUssmDc0jdCXsqGlXXiyLek1atXf7tln8RpMNjV1994wByi9gh8Hp7yf
         NmPA==
X-Forwarded-Encrypted: i=1; AKwUvByHQZlMmkLnhCgRPQfiGVSmpJggfPp0reuBR+KDSvN7PWpFR+Rt1mimijstUX1cS5LmvaReUNY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJL2KDXOUEuA9o68Ud+AJUSQKAGyfB2p3/DaUzallffuUQcaNl1
	i9LqPsKwUE/PvDfe3I+egEoeFJLs4Ftwwy18u9Xi3KZd/ik3dSZdpfWNj0kTmCLM1R+/jys84Uj
	fGIOnj3LyKSIS4CMYUokMeb1KXqRcCgk=
X-Gm-Gg: AYBFou3NoMb9xmAsaQBiZPbGAKMK0/PZFuED+IjcCkaGXAM8ijh5+CRVXW1Ds02hRrP
	YIIcx7ZEXCSdwp4GRL7PzMaSdJl1x5IbxLvDD5HQ2zRpOHNvK4zg5boFLf7oj2svxh030N8Sjq+
	kXUHJuNnBnGH6iQ/Z62HxsXVO8c/mLEsV5zJt0QJoBT6XDyKPP//S4VuFgaoy1ez7BQO0eWAhZo
	1J5hdse4eF1ih6T94UexjZDu72YJC7aD6riOBzlFAFznnHXNzcd1sowTEZ6xjKMz9mV67p/MYPc
	mw/ZtOY1Q7eUyf7lUJaN4DrHUtS1Z+pD2nMCynrsZtmxSrzZ0qHuYKtVD/wt8VV0ehBJgwl0BQt
	IvFocfA3ITwxTJcH7CQ3QbY88/AW7pk9DuDk=
X-Received: by 2002:a05:690c:6387:b0:8b1:567c:e7d3 with SMTP id
 00721157ae682-8b19c7985ffmr16596757b3.7.1793091863585; Tue, 27 Oct 2026
 02:04:23 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082405.1297-1-shengshilingmu97@gmail.com>
 <179309014594.3327.16979359855381839184@kernel.org> <CAGGuW1XarBs3ZD7eKeysDs7qGL3=Zgd5-vsY1ReuF57gz8aLFQ@mail.gmail.com>
In-Reply-To: <CAGGuW1XarBs3ZD7eKeysDs7qGL3=Zgd5-vsY1ReuF57gz8aLFQ@mail.gmail.com>
From: =?UTF-8?B?44K944O844K544OI44Oe44OI?= <shengshilingmu97@gmail.com>
Date: Tue, 27 Oct 2026 18:04:12 +0900
X-Gm-Features: AclHuK8kmj6WVIj8zol8TSlhzkemES5oLPxGf7X0ktRixJ_-10JdWdLfo56K8xM
Message-ID: <CAGGuW1UGKtQUGyqY5fKNhBRnmBJ5L+QggeLtbdtvXiaDo+Mmsg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: account for chunk padding in sctp_init_cause()
To: netdev-bot+sinfo@kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The missing tailroom was found by reading sctp_init_cause()
against the padding that sctp_addto_chunk() writes first.
AI assistance was used for that reading.

The bug was triggered, not only found by inspection. The panic
was confirmed on local virtual machines running 7.3.0-rc7 and
7.3.0-ga1c2b1da93f5 (CONFIG_KASAN unset). The symptom is a
softirq panic:

  kernel BUG at net/core/skbuff.c:214!
  Kernel panic - not syncing: Fatal exception in interrupt

skb_put() calls skb_over_panic() before the copy. The observed
pointers were tail 0x6c1 and end 0x6c0. The same panic occurred
for a listening socket, an established association, and an
unprivileged client socket.


2026=E5=B9=B410=E6=9C=8827=E6=97=A5(=E7=81=AB) 17:50 =E3=82=BD=E3=83=BC=E3=
=82=B9=E3=83=88=E3=83=9E=E3=83=88 <shengshilingmu97@gmail.com>:
>
> The missing tailroom was found by reading sctp_init_cause()
> against the padding that sctp_addto_chunk() writes first.
> AI assistance was used for that reading.
>
> The bug was triggered, not only found by inspection. The panic
> was confirmed on local virtual machines running 7.3.0-rc7 and
> 7.3.0-ga1c2b1da93f5 (CONFIG_KASAN unset). The symptom is a
> softirq panic:
>
>   kernel BUG at net/core/skbuff.c:214!
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> skb_put() calls skb_over_panic() before the copy. The observed
> pointers were tail 0x6c1 and end 0x6c0. The same panic occurred
> for a listening socket, an established association, and an
> unprivileged client socket.
>
> 2026=E5=B9=B410=E6=9C=8827=E6=97=A5(=E7=81=AB) 17:35 <netdev-bot+sinfo@ke=
rnel.org>:
>>
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>  - How the issue was discovered, e.g. hit in production, hit during
>>    development, syzbot report, manual code inspection, LLM or static
>>    analysis tool scan.
>>
>>  - Whether the issue was actually triggered, or is only theoretical
>>    (e.g. found by code inspection). If it was triggered please include
>>    the symptoms, like the stack trace or error messages.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.
>>
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
