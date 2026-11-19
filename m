Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048503;
	b=qp2OXSTLNprdRkL0W62VWCglKcx5xoRszKpNlTetNndirlrJCxllOIpHe6v1VLs709gE
	 BjIL0h3x3968nXedBjDjOEI8Cz+yNlX9J0IwZ/UpN3bU91beLgxJ5H4Acf3Rn87gSfkOr
	 w5PK1ZFkAknTe1FxNVkv7WWlJCmToPviLX9woOHDy4j41DXDQGPavOnkkthTK4DslqcU8
	 L/7jv5JRV4lXeojFrC56QOwSk1B8NO7cBDcXBwRGSAR61hSxlQwq7/2ZC0RhjrqtMfWdc
	 bzv6Wthr0e1cVLFFsB6BjTaF7GnPstVR1vijHxWtyYRogCOSWsEtbTqEHajdh17y9rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048503;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=MBBdgGDR7k0GmtCp45XGw03/tk3C3N8PKF7SzK43N5U=;
	b=MviQg+qDQrSZ4YuDLhdMdkyJRbCDrJhz3pWq4Ct/tPEYSL99KG+taKdNkFFMBDRokp5i
	 SjwOoNKHVvhNbvWJKNVK1KQqJOqU1V0EGwTaGDfAe0+LNUuzPePNLZPnFdpo9Fnfm6utJ
	 RO3E1VvudShXbL3btKoaH8ddSR95Z618LXl2+OcXGLUFHHggNQCl4pGH4UoshJvmHyzfs
	 Z0JXUZCpL+mwHr/8gB9AISEoXrpEk3LIMdVnh0CoJforA21xJYvLH4DvCU/+9JUvbhExE
	 q2wLB+K2e4fXQK6+fiX6F8wdvTG5a83IniaAGOjbhwfrs3jWfsuInHKmKnsbZIsPh1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzdZfoOz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2EF606A32F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzdZfoOz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD07D1F000C7
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795048502;
	bh=MBBdgGDR7k0GmtCp45XGw03/tk3C3N8PKF7SzK43N5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hzdZfoOz4qhWIzfgruDW1Kd+gft1453MXvX7LgOndhJMKzkuW7bajHsyoNI4vFFEy
	 35C3B7xRaej32NwRr0CIJIsPQlhjCgBOc/d9antnXYkHB4Ly+PjIF3vek2LprObnXZ
	 dA84J4lXBePzLxKz3NwVFD4e5nlB5V+RZgGD25rpRsD6I/LHJ1ytwQ2vQkAZJ82LVh
	 0p2NF/kSGjeYoKbo+H/nEtfQoRGSpzTx07vkJeCiuKb6T9DiiadItZAZ7BfD4er4jf
	 43BZbYwB2Z4s7Dk7uyz5MXBeatmUqbgiShw4HNaLmJ5w1tS8GL5hZQdY3lADZ0XMyO
	 kg7KLNwdyoG8g==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c511c0e2826so135164166b.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:35:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGoAvwSV2Z3dw1pds4mAMVa374nnHZbNl8DE6wg3oMD3iedIhkAhQbedBpjAcXWSNRty04L2hk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PW8G7GBvUv1LbziQA2IHJeOwc7REDTGUcseoYWL1shVV0VbkQ
	shRfsAmoT/oytP/rYdhSXCNgvSur17suSAgn26gQMMym/6TCWflmxRmxbuTff3lxU/VVXCqNDiR
	VCP+PMban2e4gDqbKZqpyAnLgU4u7Z8U=
X-Received: by 2002:a17:907:9811:b0:c2a:cf73:63fe with SMTP id
 a640c23a62f3a-c510debebf5mr392519766b.6.1795048501493; Wed, 18 Nov 2026
 16:35:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118174000.76954-1-icb@fastmail.org>
In-Reply-To: <20261118174000.76954-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Nov 2026 09:34:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8FnWOeohb9gzST+x0oe6_QK_=JqXfqLKZYzzq6Z8EBzA@mail.gmail.com>
X-Gm-Features: AclHuK97zaeMYjWZZ83Hgsf-wGk-vKxVOO46xSw5KQzFmTQ4PV1AujEyr7nL6Xs
Message-ID: <CAKYAXd8FnWOeohb9gzST+x0oe6_QK_=JqXfqLKZYzzq6Z8EBzA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: clear DACL_PRESENT when the query omits the DACL
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -1077,8 +1077,9 @@ int build_sec_desc(const struct mnt_idmap *idmap,
>         pntsd->sacloffset = 0;
>         pntsd->revision = cpu_to_le16(1);
>         pntsd->type = cpu_to_le16(SELF_RELATIVE);
> +       /* DACL_PRESENT is set below when the DACL is requested */
>         if (ppntsd)
> -               pntsd->type |= ppntsd->type;
> +               pntsd->type |= ppntsd->type & ~cpu_to_le16(DACL_PRESENT);
ksmbd can set DACL_PROTECTED or DACL_AUTO_INHERITED as well as
DACL_PRESENT. But this patch only removes DACL_PRESENT.
Thanks.
