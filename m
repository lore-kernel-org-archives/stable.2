Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B953EFFDD
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087060; cv=pass; b=OUKjz9aJOe6uyTG8WyVEhZNw5TLB4vpisglfVaGKDOgi93xJlOQXfr7GenYy3v+dx4kx/JSmf8XTwDYvPj5uQczrAKvg6bTReQ7ooRcjCv/btc1ZBVVQMFI05Bw0mV2rk3Zk6LxcAHl0/OAnNQePXmqBKjcdufoRyuVagrjuBkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087060; c=relaxed/simple;
	bh=RNTETXxBGztiW9SeIqkixJsC3INTTfvcVbOxx6w5wrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgjwqBl/YA+yxi3QgcpTNzINDvWDB4aESVGnBOkyanoWzYPE7wCszVPmx4zVbH/2z4wFLofAK//yz/GX8RDLhhhUf8mc0geYuOcyln0uib27QjhQ1fqCZnK1hWGmxAukSDC7Avc3+L8IiHr6HBNMjT83WCJj49tiyoDvQHWbVqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ei283nIp; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ei283nIp"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176bbb9384so65694861cf.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 03:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781087055; cv=none;
        d=google.com; s=arc-20240605;
        b=jqx6TIGSQJWrkuSKx54iVagzqV6Sh29EPrs1WuYXulMuRP7mhtKc7+0/Q9KZeLedDH
         nAYt6VZgi4CabRPN9juYuNpOx+Z2ZNy2TiLcPOXw69Jz7FimmnKruPfabwYQ3friA24s
         61+XGsjJ3lODEckwZGmcgHlWtJUFK6uBuxfefxAKQskwqY5IR+mNpILD9l1chUFW/dUh
         7jr+nmTrzShBM5lqwCB4Ccs+mcmFmEk8RvX+awbu09XqWu6tXGhwQ2096Mh9vFuPGxZ8
         CHqHMyk5DvXUNYzdTjsE/H6PKMwT98m/XVDwRW/GfWxRpxsM1EoE82nKgcWb7bIdgSbC
         kjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RNTETXxBGztiW9SeIqkixJsC3INTTfvcVbOxx6w5wrs=;
        fh=55Vtjg+iUXHWHHeFh3DqJ9OLHFQo56dZ6ASqaNtLIUY=;
        b=JlyWtIjKJGqaQE2QP7DaE7VBDN40AJuwxaLoR5yUU1bD1Donq8zf1g6XZyLLMW9YI4
         L5/VYCNipZJW+LGhil9VqRc5zu4tSHjVrC8RP11esWDljyrIXnzSBGEk5JfxqmcKfAE+
         axRuAiz3l1/Wa+Dr5Q1/XHD9xdaA7umvmBep/8G+Bi1PRJQXzxyZ7sBI6NkZJjs06gVq
         LybQDsuqiu4MYGfeLUbjrMZrcVNWyq5Ssqay6nW8vdDmjHHy00fLtz1/wpjG7+tYaA9x
         pQ0KK5TW3HhKWZH7U1wzaFmT7XeJVStVJJj8HMC0pQ0ucW4Fs6EPBk9TDFeUhhcQQsqT
         517w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781087055; x=1781691855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNTETXxBGztiW9SeIqkixJsC3INTTfvcVbOxx6w5wrs=;
        b=ei283nIp+QHs3RT+vWaZYZtzV9GSm7ETAPm2F2QxHfc+LlTOfb9UhpnBfKRrQBY0Uz
         UDOGsMzpVo8c8KRCeLwKJ9DREl/Fx3CghYFmbMrNiyW6blfJg7hqtwCWWeNxhUEjEmv9
         iLwc+HO3imYIGRsqjGq4bUEn7Nv6ixMNJDrUpEVHbN3HGRKdb2/wjo6bct8rvQhr/4vl
         Dg+dOSqLKR7iSBVQrrsaO246Urg5Xa0I0F3tpXgzgwslkBbj+KVymLc+n3htFnQ64Or6
         OIVGN1BOsbvx9BXIumn07RcOSHsFVDUBtWR4HUg6V8d99o+gI89t+TLXVRRholpOzgvc
         yAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781087055; x=1781691855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNTETXxBGztiW9SeIqkixJsC3INTTfvcVbOxx6w5wrs=;
        b=ZVdN7sOVpdTAv8Fo8DkaMaIsfgPviXoiY9DqVmO2uqKUHjHh/XxWGgUMtwP/iZ3GIE
         1trqDGsMGBt+E2t+ADoxdOL539rS53XmsloCd7hOGMP3udEodf1PzkT1PbDlKPaAeR88
         OX8uHNBEs8NdwLABdVAbpZOIQFIR2xxOVMSpx9XH9bJWcTYBB9pXrhVCnI4l7nG2X0mA
         XYZkiypTEwnIIMH5dD6uv/qiRjhGTyJ3aD5q7OGwQqr3Ma7WAqagOotJvuxwYD1NOygX
         SvzgmgfWUCnPNjwqbotclDsTIf/5nrQjNJQ1s6iEn+ZLVQ4fMTeur5AWyju8p8rkiY4w
         XJrg==
X-Forwarded-Encrypted: i=1; AFNElJ+9NO53CJwehsdPBwOP6WA46Grgc/T9Gx0qlkqlJmiRtTJ37YuPi7q2IvL303xff1B3RdoDPSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqp65DTpgJE8jgAbV6qmRp9LXN1/S8ORo/3EkmAMZM73ZtaAAq
	mT+I+0Ppr3EExU1Jpdrgf6Yov3sh2Izb9aT1FJ25buMT+CE6ehXseZ6IW97JVjUvMEHlZOlwoUu
	rzDkirHJMtZL9vw2XJsqetiSSB5ldLWKxb5mOMAZy
X-Gm-Gg: Acq92OHiu9h8LJbhZjiMM7XDK88a7ePOiu3HiDuacYxoWyZvSfTuHIfVgSpcZzOmZ1a
	2w1EWrUXZIewQrbEC1/Vog/Jm6Lo6OXLqGACNdXRpqJtu4d0hg6t6e2JFlBZ9tgOGEptW1yO7AO
	7/9Ux8eLiCNZ4263m4NpV/Q3GWqPHX4CPCJaTzRc/9+vIwNWkBFXWXYivR5L1xFZwsqKhGWFjGb
	QN4w2CmAhWZ8xLa1fcOmbg5O/yznIphDLWHmCLgFTygCMnFC8BQ8o7IdKooMFZlUXJ+rszUX7X7
	qZTet71pu+bTapa+c7KJP4Y92f92Tcq/0/p/VjZ1H1R85F8ipX5UHUsxkROtW09EvPYxhf6W9PQ
	x8m1gkgELZhKFB81RxvUIj05pF0iRQw==
X-Received: by 2002:a05:622a:53c7:b0:510:1325:58b9 with SMTP id
 d75a77b69052e-51795c56255mr367755921cf.41.1781087054772; Wed, 10 Jun 2026
 03:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610101839.14135-1-jhs@mojatatu.com>
In-Reply-To: <20260610101839.14135-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jun 2026 03:24:03 -0700
X-Gm-Features: AVVi8Cf251Ea_rFf8hJYPAfR31yJwCgsqIE3IE1us9aYknccYT_dL0Vw7oFA-c4
Message-ID: <CANn89iLf_kweBcio1_7Vg-JFn27R816Hnu+c118PD6EmYFJ-6w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_flow: Dont expose folded kernel pointers
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, victor@mojatatu.com, 
	kylebot@openai.com, stable@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 3:18=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The flow classifier falls back to addr_fold() for fields that are missing
> from packet headers. In map mode, userspace controls mask, xor, rshift,
> addend and divisor, and can observe the resulting classid through class
> statistics. This allows a tc classifier in a user/network namespace to
> recover the 32-bit folded value of skb->sk, skb_dst() or skb_nfct().
>
> Align with standard kernel practices for pointer hashing and replace the
> XOR folding with a keyed siphash (which is cryptographically secure)
>
> Fixes: e5dfb815181f ("[NET_SCHED]: Add flow classifier")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Tested-by: Kyle Zeng <kylebot@openai.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
