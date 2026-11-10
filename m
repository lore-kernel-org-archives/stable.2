Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322304;
	b=cw83VdurWXnAF+6CksccvVEGCJLWOL77IJbzcBEqOvIuWzex2nDhesWbfmdwplffBx7s
	 trGdPPle0lhG8PnY9JHeczjMT0KQURcmZPEyjiLLBcEPvkHLtfrfAVwCelzsVXtbcI5Os
	 NdZXKL/vYSMzclCakKb+AeNyibOiAJYaoPEwi1fEip0587nAfN2or99+1NpzMEVPLqMC5
	 s3yzjj9jWek3J3fuUj8ty3R8n4qJdT/vdl8s/E3piS/qDEBnJ9EUl9ZRESKolK/1XQ7BI
	 dkFEBkmw6ytpfcUyCya8SulQxZYjE7eKfxDvDnon8yLH6hdqR34fGJ7Va5sb1BC9NPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
	b=BvdGcawMhQwUizst7J7tX+DTVqeDQ1fdq94K5x5OqcOB1KeWmHWTCL40kL1rMHrPRKP7
	 oKZ0YR22IFGYb+lJ9UX5dWbY6yg77nu6cJqQLe0eR4jVw1UxDtc6TDUeb5xmoOI40fbh5
	 ZSEw6pFsG0MuDgZDOch2QK8grIh4SHZJ5am76tfTdf7fh3qVkPPEf+xGSqcMCcNIR4Y63
	 eJWEFZAOixhLbOg/prbS5bKf//iFkyRI8KCJ55doryucvlWpxrXbbmKJL0CDs7+bZwg/8
	 IllVe1C2mWgAfVk5Tz9sAF3lML/G7tQnTYx9mG+lKMyy3VNLiFWUqKGp7lchU8a1FGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IL+8xDhW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D663606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D663606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IL+8xDhW
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so1197695a91.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:51:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794322303; cv=none;
        d=google.com; s=arc-20260327;
        b=f+IeZKIEcF1LeHRw6ROaWs3OoTfaWOHIBOj3HxaMi3um/VQLMlf5sm2F2+LQVGyn/l
         L/Tp8/azHQX59DSgWphDCv4DYjbsT3AqciYf5JjS5HDIfUl6Pqq38VSvbYVBReklLClu
         nr/uNOH8pC38KT2YzcdoCqfKjq3rQtKcal+vbHIEep8FWYwaWvDw7wwYaZn12zSuIcGa
         xCDa3Jd2HqU2LhE8cFZwhR4a5/SFwKKvw9QfO9TT3nkorc8fqMCBT4Eg/XeZwwra8VTQ
         jHxcP33LAXQQm1QSGfmrgUEfYTnhtAGZfRPfxBBNQWUBbkWTGdA708zyXYHykt2WtETp
         KKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        fh=xwX/DzAHDjlk8CBDGpm5U2KoYHFc+luY/AjwLIpUzLY=;
        b=JthJntscW62o8LCakE1QPZIlkAc0J9WaEjceE9efbSChXQJCTLre0IDNKeq5TccfHq
         WisB0UjmioKgw4N0HUN0Q2vhhfXoIJ1t87b68j9D0/3LYnz9sdc54BNg282DW0iS0Nyn
         xuxjh5amjmxHG64kgAfaFqhDBPcLP+2pScheO0Hquc7fPT+dSXzg35ZbaHMo8B347S3l
         HHgg2MbFQz6QfH7i1QLzUVIH1JlCFFT95lXtsnMnhCCZdCvygD3pf1llkZwRUH0MSdaE
         plaIcdHQ3jOjPIfGR1f+GhXYhkC39P1pvmNiuP6D80qEgzczOxvfTX7RiGOEEHd3HMVd
         h4jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794322303; x=1794927103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        b=IL+8xDhWvbsY97lbmrxhet0Jxm/GEejFE1wA+kHdDdoy3r2HY0qfy9+Zo5tDyA1HCU
         92dTAWSC18xJKt+nqY3o9ZEOwugPfnvfyKVxgXTJccL+yGQZq3uA5w6FcKOdBgNjQCVS
         07UkwU1Ush9oWU9aQSyczjXfKDIKK13bz1vvPKKKZnAAbDJNUxO90oBj9mzTVwalm6uJ
         MzZxNoOFc+uElONJCp/htKG7NEjYziL9FbA761f4NJZqOMyMijk6azV7Si9VVAUAXV+J
         Tep1WbavDGNkRYBusn+me12VrKAKvlJoaba+qozCGl1bDCWa2Ghni1rfY8UzwuCjm2U4
         /4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322303; x=1794927103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        b=1Qk5FWnTzzL8Joci3Qyxla8pGTfzSygjaVYSrOhOfoMlK7e0W81bWD2We9kyaTLP70
         AcgWHIVIJMNp1OR5UoeZvXIGeZlkRE5u+gjsrGSjjkRS4y6kBY8bTE9D8EtxTWLK7ym5
         xdz4LYAzIrovrGAnLRjpvwdXk0dHoAfozQTkk11UBrB1YXxkvTobLvsf+o+qBy3LKIoC
         8fvK6nR1k4FaQ//i77aNXnSfYj5fmkkBjT0rJZJRV6wWmdKLT+dSN0CrdkH8d+7KqP1C
         Qw9x28jEWjF+JzhHr7YO0mO3zoBbV0GIM+SU8wwwDzALkfDC5CU/xU//8l1yNDDShe7Y
         flfw==
X-Forwarded-Encrypted: i=1; AL+hErEKNws1jDQzPdmrTAhHk81hkZa9eamHWcXJadgKyv61BQYQe9WvzkKdrhspnBbRXP7uepUEoqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TwzBK21XFs7IPsyLWOYboYNm8CHQ8r74nuHh3XEVK89mD1DR3
	kVejzKL5ZIYcc0wz3eEUf4F3WUsyyA8kf7mZkufsbyh96GWdpGC8aLZ7sTMJSAtBFpNKpffCoFK
	gJ3MbYqfuafB7CcRom9kjLt3LvKzS5rVnL5uaffXW
X-Gm-Gg: AYBFou1fcgUtnz9I6Vzs7etC5h+q9152tcUR1n5lQerMYqUNT0MgyvyTaCV8HWgWaEj
	Q4thCL7klmXIsl9Q0r7hDrZJRRRhBArCpiZYjdUnN2m3ekmn1EnnaI4YFdNXA6vRlexXrImSh5r
	6EVyIdTn2A3Rptlr5pQmHTpeIfWIRD8qgqm6CoaqbM9BxU+6g9GEUoRWLZV6zGrRYsOKzD9BgWu
	wyberdBq5htqtarhG8h3/vKX7vObDCm+buJ0cbnKrjR/VcahXuoPBCFj7e28rV/U4MttBpQhlcQ
	wqOa1gP1F8dQA3sgl9MJxHdjq7eXQz8Zea3f1Bo8hoVyN9gL8l8++ky0VFwFzbKG2F8pczO/rLc
	o2qZ6TF9cJPnXllFu5H41AklBamPUvaXvu6ySjdnWRHANusIVvHk/8isrj8FjN9PipWkU
X-Received: by 2002:a17:90b:4a47:b0:3ac:17c:6e89 with SMTP id
 98e67ed59e1d1-3b166cd4924mr2650628a91.19.1794322302909; Tue, 10 Nov 2026
 06:51:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110144205.2404088-1-mic@digikod.net>
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Nov 2026 09:51:31 -0500
X-Gm-Features: AclHuK9azAwCWCYb7rf35P_Qkz1YTwRFSpYVlH2tFTGhGa4I1jRp_1554UKlQOk
Message-ID: <CAHC9VhQ7xMe8J+wRYK98Lw-Ff8dg=wJNEWgJp-MOqFixeZkiZQ@mail.gmail.com>
Subject: Re: [PATCH] userns: Let LSMs deny the CAP_SETFCAP snapshot for
 mapping uid 0
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Josef Bacik <josef@toxicpanda.com>, Serge Hallyn <serge@hallyn.com>, 
	Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"Andrew G. Morgan" <morgan@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:42=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> records in parent_could_setfcap whether the creator of a user namespace
> had CAP_SETFCAP, because a creator writing its own uid_map only has
> capabilities in the new namespace.  The snapshot uses cap_raised(), so a
> task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
> namespace it creates.
>
> Use security_capable() against the parent namespace instead: the
> creator's credentials still belong to it at this point, so commoncap
> returns the same result, and only LSM denials are added.
>
> Do not audit this check: creating a user namespace does not use
> CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
> that later fails has no LSM audit record.
>
> Checking CAP_SETFCAP when the map is written would not work: the
> writer's credentials then belong to the new namespace, where commoncap
> grants the creator all capabilities.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: stable@vger.kernel.org
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>
> This is independent from Josef Bacik's series, which reworks this code
> to close other ways around the CAP_SETFCAP rule:
> https://patch.msgid.link/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@tox=
icpanda.com
>
> That series still computes the creator's CAP_SETFCAP with cap_capable()
> and cap_raised() in cap_setfcap_level(), so it would need the same
> change.
> ---
>  include/linux/user_namespace.h | 5 +++--
>  kernel/user_namespace.c        | 8 +++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

Looks reasonable to me.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--=20
paul-moore.com
