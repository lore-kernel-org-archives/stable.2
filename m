Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE333C1084
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365281; cv=pass; b=hesbNJr5h9HsNWFDmMtgQmDr3luLJm6IrOP5m3wcp3cAjtS9o0jSsocg3yxtF39gqwzIUqVU+ll5ZUb9+ANMudl9mf4uzNcmPYFpIV0H26W9Hu/fBnWcDpwqKCLiek4FhTPlnOldCaFgm8C59Io+61p+vwIWqjKk0iQjahnWt7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365281; c=relaxed/simple;
	bh=dtKLjTcWTmmZCLt0LPCx7GQl+y5wIqZNaXxYRVvoK+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WO5K1sOoEqP/9stlPAX677/RjdLrzBEsMGdgkJeN05aS575ZJEOSpzy61T0N25pCYin47rGJC7ja8hxB0oaoI0KsGg2lt+4Gc5/reNU668Qz/mIZILshFVEibkcwwu3zomtWfd4zuuzY5Mb77jXWQG0LUk3rbQ1Sj53lXPZyeII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ84QQlc; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ84QQlc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cca0c5799eso13088935ad.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 12:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783365280; cv=none;
        d=google.com; s=arc-20260327;
        b=ECFQCuuwTdVg/Psp/PwTffUBfVnZjPmd5dUudTWcEyaWnJ15/478++koZh1L0aVJfF
         aT4HlXyfEg/nmJv3nMjNawe8cJWkdnkjKRd26T5wVqfFfqzqRKxVtQu2nrcUFnFBXcF0
         n7SXCgnXeF64u1VEFn5V0HgdDmHAjNt+5XkRSvf2SAKjMzRcuHf5oM0FPnwrND0Jd+5U
         8Z3LvXecvw5gy9YOCpFN+7IXKxyfHDVVJfb7hfwAD3uSRznDsXMNSg4FIJ/JdNmU1mMD
         W3rXsiW/622MeU4kcmexk59qfd/n99RdAfGt1nbKBq7XQiZR5jD2m2awPgCVp3pTOrb4
         +YBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQEAoD6d7NSb85+gVgjEj3HRj1z1a8fwJTB/7nh0TM8=;
        fh=IPeiciDujzPDI/b63Mm1cJoGgH/QUKq+3sQYGe/OC+g=;
        b=EGd/unwu45PBoflpxIruKdwiPqNXO+lv7Upf+sR/+IOhn4CoKt13jfbstXAfUv7E0P
         HMf3P/escZ8xKw3+whIDGITXDbT5n7opfQZXlvduCFEW1cavBTQsxC2mbBHfpv+14SSh
         zh1IxrmmEZaoc27ZOSkSiw9kAAc9oijiRO7126mhx3wHyHwXPlopdvHqCRONaCBn7vgH
         prBZfB7IKyZT+wMra7oZd+S8RWmi4BaPZVQS6z2ja9Nmf2fEcNBInvsM5rsZR+LnCBm5
         Mzvse7e+18GZFhfq/ll2eWwf6029gD/gnfaiSav/G0LwgGoKrkJQWshNFYx42G69CZ6D
         8cGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783365280; x=1783970080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BQEAoD6d7NSb85+gVgjEj3HRj1z1a8fwJTB/7nh0TM8=;
        b=GQ84QQlciH8fZcISjYDm9V4M3vi2Jyg+cvvIQcdHYSIZP2MlJhaZcufwH2RxwB2llB
         oFBucEKIFF8fkvNNxvkAExZW+LTIB0TAJiCUut++p3UoKrdaGXAZM680dqMYCBq740ho
         gjvgvGjGszGKYJ6gW+7LuRKYqPPiv1paVsuOUIt0V+W5PW3Cy7AeNYdWzpHD1sO0KDP7
         IEG40QBs0D+fsfTbDxQ4b5kB7/1XmNmf2/qRwp3fRSf1/o8+XreXVplwUQZYYvR3RCMl
         DVDvsnf30VZcwoH49OgvBEfS9P3Uk41LSksng76LuplEokQ+GqtqQcBroV9kTYPFgfSF
         USew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365280; x=1783970080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQEAoD6d7NSb85+gVgjEj3HRj1z1a8fwJTB/7nh0TM8=;
        b=ZYu017KQZ8x3FEwwvJTD056zx9uroU8xTNEr56b/bQLUSi26T73kg6viQqvp7HVIdp
         JrLcrubN9unMVWT1WbL5vYkO2eAQS9ZfsWixfUNEoDaDcQUjwh3KtgpEYx5uWEZcmDAh
         aztEAHRVWTrSdhH7BpZKQDpQpQR1NwbfqWo4Z2bSUlnq0yBIoIrEOjjOC2/KTWh3lk6x
         GMt2HmbOJRG76kGwGcGyp2K4xmvN+XJAvLNufssdz8QSHWo3e6wYETsAveobg6eCUY8Q
         P+aOlP2iDyqXfpEgd4AL7LncR5pj/Csu1WBgAbRNJeUvmf0wN0RoNK9a2gb36vHqnlaA
         1pew==
X-Forwarded-Encrypted: i=1; AHgh+RpZXer5szr+yOQ5Q1QbT3LXreHrkl89B/6SoXOoGbh4e0p237OxCmTLdSuFdX1jPIA6t4RYom8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2Y5bw4HnaesRwqZskoCL4Opy5p5cPNYcftTfp5Qrzwb8GafS
	WQpeyLdqSUFqzvijGIMqzam5VHEWMZ8dASi5D8bw2lVIqmkf1POehPhXiH6RRpcSvKJ3DybFRwt
	rMK+pcoGhM5DQdG2bVebPgNGARD0eU74=
X-Gm-Gg: AfdE7clUg2+11k6NH89UwXX7oDE/U3idPrI9JPXubvqbiwKGdcsTe8RHE3UXYSZSP76
	YF8gntSzRVpW0E3fEvOi0nffOfMRwq7S9qhbvWek5r5zHVho7O3efArx/beS33CGg/TWBpTHkAY
	AffSKOgkuFrNr/OWteyc5BVAxo603iAbWFBAMYNbOexqBaBt6cPYj8xpdQPgzi9wUzyvJmPBlpG
	UZkB0uh4Q7PxX5Z78qjn63Rqz4vz/+dbrio/ClUPr7X3X8sHIzQmJ5wjrHf5C9WwEJzRdDi
X-Received: by 2002:a17:903:4b47:b0:2ca:ef49:f5a0 with SMTP id
 d9443c01a7336-2ccbe617daemr22777955ad.6.1783365280075; Mon, 06 Jul 2026
 12:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625235336.3641828-1-tristmd@gmail.com> <0fa8e2f769f889368756a1ed1f12ea8e@paul-moore.com>
 <6a45ba8b.940a5a52.377c47.efec@mx.google.com>
In-Reply-To: <6a45ba8b.940a5a52.377c47.efec@mx.google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Jul 2026 15:14:27 -0400
X-Gm-Features: AVVi8Cdyc_zjpATIJYfI6E2rma6h-ejzGaNVAm-7sY679ZmklOm3--pJpDxUamg
Message-ID: <CAEjxPJ6Q+_qGCjtxx2XO7nMrb5Q_L7pk5zX6kpCrpXdhbOj8MA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tristan@talencesecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:10=E2=80=AFPM Tristan Madani <tristmd@gmail.com> w=
rote:
>
> On Wed, 01 Jul 2026, Paul Moore wrote:
> > However, there is another issue relating to the SCTP softirq code paths=
:
> > the fact that we call into sock_has_perm() in both
> > __selinux_socket_bind() and selinux_socket_connect_helper().  The
> > sock_has_perm() function uses current_sid() as the subject in the
> > avc_has_perm() call, and in the softirq case that is not what we want.
>
> Had a look at this. The ASCONF softirq path is:
>
>   sctp_rcv()  [NET_RX softirq]
>     -> sctp_process_asconf()
>       -> sctp_process_asconf_param()
>         -> security_sctp_bind_connect(sk, SCTP_PARAM_ADD_IP/SET_PRIMARY)
>           -> selinux_sctp_bind_connect()
>             -> sock_has_perm()
>               -> avc_has_perm(current_sid(), sksec->sid, ...)
>
> In softirq, current is whatever process was interrupted, so the subject
> SID is effectively random. Meanwhile the port/node bind checks further
> down in __selinux_socket_bind() and the port connect check in
> selinux_socket_connect_helper() already use sksec->sid as the subject,
> which is the established pattern for softirq context
> (selinux_socket_sock_rcv_skb, selinux_sctp_assoc_request, etc.).
>
> The approach I would suggest: thread an explicit subject SID into the inn=
er
> helpers. selinux_sctp_bind_connect() would pass sksec->sid, and the
> process-context wrappers (selinux_socket_bind, selinux_socket_connect)
> would pass current_sid(). That keeps sock_has_perm() semantics
> unchanged for the normal path and makes the SID choice visible at each
> call site.
>
> I can send a patch for this if this approach works for you.

I am not Paul but FWIW this approach would work for me.
