Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255250;
	b=E4BFu9iQWUqARMMxcKQfa/b9UzsFzfkN46sWpxtEgulP8nSY424aJzRGV0DLP0/70b/L
	 9BrnIxjfrbALKsrDK99IPuOoic6bATwg0h4SK2bM2vXZQMT0fqmi/uSCTXh4L2Ro6a4Sd
	 m3ubvQ7PjqrwxEzMdAnhOATbuh47LpF5w6HviYySGXO+9JhQnHy2j3cGx0xFqHQ9aEADQ
	 jfHsr6oyaCRgp5Hj2bvdzu3bvK7xdJ5Q9qKg2cblVPOCoaJ2CCJaxX7iyRNoAoUwixJ9f
	 Y9ANEJ4ONTdhhvCzGlccpKbcDz9zLSfWxswh0H2RKgeiNtJYWBZyTP2RqZIPWUfSTbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
	b=n/cC5M/yJQJAvvye3bjFBirLUNOi/fs7huKHZEEH1wuf4I9Hyi3ZDlyru0nd5TR805g5
	 2OG914u+yc/PBS53QIYpuw2HRK1hmgAFoidMu6pkBvCalOzuXd/E44j4Iwo3omCQnjJ6j
	 H/cSH60R/kfNNzFNr0C9jBJ0TzX27wVxhM8SewWEC0lvWFVzf0mUdDDCfR8uR+agvOK+V
	 DIsSGjSjJn6Bw7pTZH/TxVQCVxwhjfq2Vt0YFlvJnzbHAtGH5037LU7nFv3v3YxxZ3+5b
	 t5koqHDJETI6aKf4KTfyMumYE6u6fWrYJnRLcAkwt8MQsJm4n2mzJaQXUHtBD7BnHAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=bPMMvzll;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3E606A338
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AB3E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=bPMMvzll
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so729571a91.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255249; cv=none;
        d=google.com; s=arc-20260327;
        b=CRlB5SbS/1T2pWALT5gDK7esCkWIY9w5PW3Tv0jw6VFWOrhdKbgaizxNl2IS6linF0
         GuQrrvSuq6Eqz41buhstfNd4FmmmXfgJNeEU0kx02DmyvCYI+0seOSv9Fq+lDaKUQemB
         JpVQC7rH5DDUCZOGA7NedjDHIyKM4qatPk7j+tpIqwLPJ3Gth8HduHQUixqZB6E4o1WW
         UJgH6JqhmWsXmrdezV8Sb/lIFvn0u2U9EmcNezOJzBBEUBpxdPJry0G+zGBfl4T9UK8B
         NnCCMYK+6FAWGNuI4G5fJIIRknmCWzSwCTzO/R4ROKrjzkgxTRibkM6MjUb4lZoGFH5G
         98BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        fh=eW66oBzBOuue0jGHMJphlhQ0AuxCCYbVe6kwKf4rHYo=;
        b=Dz0VqkDuUFbfmYrkJcVcw+fVKuGXSdvMJG4LH37QCWy3P94lMPIHsf728a67BsUsgV
         zyhGRxoLrq1pJXB4xDOX7fnmtOY39O4LvxnyJPBYKdK7B1hRWbUKKjdN33Az4YpLSfx2
         tkR2CjKks2tRSx4CUk4fUJvaLUBopcVJAn8uliG7MbxqsVtPG+WZw4gEtBaea22t42W5
         Glljfn5hwtyPHNIsG201StPGznjojRBEZ/y5jQfW8dNfuDanyTtSv53/eBpK9T6Go7Xe
         c0NZy3LC8mGnDlHXeu+xvdOASAbkwL6SduXlNpE+mFwC0C1e9D/H6t6AA4aecvGllGeT
         MasQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794255249; x=1794860049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        b=bPMMvzllU0yTQQX3RK6h5UbI6bmYfHGmNNP5VaRJ5GDzkjEjLchbGFjBkHWEHWVEK2
         UVDCQ/Oq+cuY5K28yKE33O/gdrHWK2TsOlIpihV1+nrZJAk6wpYBe72IS4kJq9D9D7S/
         C+ATpmS4If8e9tGs/YMSBnDvsJXO5L48Wfr0GIxatVJTgOHI1eAkPn5yJpjzpyWSBJzH
         EE2xD9Du9nOx8VLIHcCMDu84GpRqn9QthLL6xH79XsJhVZoG7KLfwySEMsHLt4TvjAaa
         B7CkeP8mxW9zMB9eeQzgd+Hh+Tq11ml6UIUa7rXVebk4yGV1EII2xqGWl+Y5bJhJyz+N
         8V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255249; x=1794860049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        b=k8j2+eYEEWrn0U8xP6JI8ECobbmR7+vxdxgEWutvZov0j7ofQBhWz9RVczzrLM8fAL
         j5iQ+kyLNNPKjdYPIiX34IOTyFgawrwBL4GJX7FBv/Y5oFpMr/xm2Erjx7s0opWKdikx
         Fknj1s81puAYVR3SesX6itweYeFSCvl0hlkYimwiIY/LLZ/jsUpENMpY9umh30Ih9A5Y
         /vKJomaZR+6uapRHNOGpHW7mtGjNIEo7ed5qhMAwPU3XPcmp6Be0+V1IN9Bl2nmfVkTI
         ulxixw5g6xiopz3cHMVbkCsrf3YEZzbIOsLISG/71zzIZ5e+Pg9ZYqbb6GlS3OZpV0zn
         8ZVw==
X-Forwarded-Encrypted: i=1; AL+hErExOuOsKGeEsEbyu9f3FbUXZDVbv2RRqACYTtpp6p7NrSTD3hkU8L1lxvoNYAy5VyIWl3etmuE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xoZj1/t30yndH4/YAgp9w6602mORySoEw1zhRXTzQXlOsgzod
	xpCBoEBUTi4qbXiLoJu97HVs6OiQOHLDn1Ycv9G2PAnIlNe7wp5LcCcTCp5fadvXuEZLrfIlAd6
	3BS/ED68Lo6rH4lK333AC6/L1IkAKSieh4GPcH5VQ
X-Gm-Gg: AYBFou37Xsn8yDbxyzYJM0UqvqqotjJD6VHx8f7y4KoPsidJWJho+XFn6TTw67Bfu+T
	7g5i4AHQqNGodZqlPuNSWx68mbhLw4uFNwvdIJDXVSdq7ydvTj9T5tkcAnL8qjrbHVZy/xN3lSG
	d+QCrMl8AuHaFJqkUNrxjzUxY6UqAQoo1gZ1a9GVDgUmc6nn1y6bYyU+GFDk89xTKGC33kiUpA9
	ytpJgRyEVjL8AiD1np1h3jM5FovAQCS7pR8cXOwqt31Pxu1i7kOGgZYGQcJmTf0tlTvWvAkobsu
	8oeKhvwewCExNmDaM0GJQgXkQ8wcz+MnPZu24Y5n3VFfy5yIXCn9Tz8NAylyENzEcbhhkGk0qHh
	8djPyYLzmRlc9hj++TZxVKFcUUGaCys81U2SD+IMWOIv9OtgLnJzsc2VpY8AIOW2ZPeH6
X-Received: by 2002:a17:90b:4c49:b0:3ac:4e18:238c with SMTP id
 98e67ed59e1d1-3b166d1dfe4mr716868a91.49.1794255249343; Mon, 09 Nov 2026
 12:14:09 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
In-Reply-To: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 15:13:57 -0500
X-Gm-Features: AclHuK_EGvlYUSv_8gjZT2YZHLuHJRnj0DOmSE59Zf5Dm3hlbe4f7hFETs2MdEE
Message-ID: <CAHC9VhR+U3i8xNce8Ps8k76EZr_AeVf+fHET_Ncu1+yO1G2zSQ@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:40=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
> socket, and tries to remove CIPSO options from the middle by moving all
> subsequent options.
> That's not allowed - ip_options_rcu can be read locklessly and must alway=
s
> be consistent. For example, ip_options_undo() reads trusted offsets and
> length values from the options buffer.
> Fix it by doing the modification in a copy.
>
> The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> propagate memory allocation failures.
>
> Triggering this bug requires that the system is configured to use CIPSO.
> (Setting up CIPSO requires privileges in init_user_ns.)
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I've sent a separate mail with a reproducer to Paul Moore.
> ---
>  include/net/cipso_ipv4.h     | 11 ++++++-----
>  include/net/netlabel.h       | 11 ++++++-----
>  net/ipv4/cipso_ipv4.c        | 16 +++++++++++++---
>  net/netlabel/netlabel_kapi.c | 24 ++++++++++--------------
>  security/selinux/netlabel.c  |  5 +++--
>  security/smack/smack_lsm.c   | 14 +++++++++-----
>  6 files changed, 47 insertions(+), 34 deletions(-)

Thanks Jann, this looks good to me.  In a perfect world it would be
nice to get Casey's ACK on the Smack changes, but since they are very
minor and basically just pass the return code through I think it's
okay to merge this in another day or so if we don't hear from him.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
