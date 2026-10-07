Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF94DD3B2
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396814; cv=pass; b=M4R2ueQQJ2WwQ4f0VW/tRuQdeve8nSqGD34VW+X7naaIsnDRXKjQ9RjtJYK4bDkp6egaELRDzQM1utidQax38FZYQdaRKVuOKs+n5+NNwtX2HlAz2d4yGce4NK2ZEkydt/xBIrI/5UxzRUwftOLqxs9k9uBzwuVj2nJg29C56WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396814; c=relaxed/simple;
	bh=0wykPVPExtMfhxKcAfrp0hErspx+nh4RqrQTL2Nlv20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XO+SDeQo30uUCLwnNWx1FoJqu2lpl1qV+48OwPKU8MKapHYFxHLdBugn7HacPm1GwK0exvC/la2kgo4z4akE0R27V/t0d1xmrrm118rcGA8kAZgRQ/8TgIpCP+RBv8/0cdb+x0Y313dqBd+l87iqF6ER4YmCh62Dqq+s2hXoQX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qI63g4X0; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qI63g4X0"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso1342a12.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 11:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791396811; cv=none;
        d=google.com; s=arc-20260327;
        b=GLuLYKc+ITZwg8f7GQCuAHti8TKOKRMbpc+WfNnP4fto1zikUL/NzpzdTeUxNtsLd0
         gOFi1XI5I3K3iT15tQo/OVrY7RRqhx27BbADW+jr+zl1g5YR6QZ6zBNE2XQwkSqSmQHX
         eXqhzyPeS1bMnfSIfZwSt6YMpBn8LhgW10hUhxJ2HR/dkQObEGiW817jkW0dCDGpQWV3
         J9y9uWrKAMFH93lirDkpEwoI5vPAwymQieS8YMP9sIz+N92WawFZdT1iRzu+1oqu2vp8
         vVJko+H/UWZDtTmHM6IkYF8Bw6Bneu7uVxuZv2beEXKaVlb4Nwp1c6ErjZH66LekBQqR
         vk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WxmdSGUkA1DO3egL6WOHUvJBsfcKWsZyIgmusUzN/4E=;
        fh=wQVKrPIYvx5CfL8OhibtmqvQMFTCsjGV2YR8tExwNj0=;
        b=mcfqOA6SFLtcoV3/hsiGsHgkOp7IBaOLewBC3eDQajMfWkj2pk2RIXze6Qg5gUa38q
         oPT+/wv2BNeHtEO/IkgT//9zr+cP6dPBx0wyr0E2l/fuTdNryFOqOgU42e2dqg9LE0hG
         zKQ7k8aOA55VmEFLWuJURPDo0MPZ5gPencs2bbWYLb7sxxoDhprkkyVS/4iuRyzFKBcC
         yECxEC7D2KOaCpeziWQ2v/ibtqiLTs92w1gRiembEMT19nYlSMS6B5x2RV4Q2JzXAVnM
         /qvw/mExWDzZSKCZ1mP1FZ6/tv2v5Ze9EZG0mRRilpMFpOze6g2U2YU0+lRbB9I06kqt
         Fc0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791396811; x=1792001611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WxmdSGUkA1DO3egL6WOHUvJBsfcKWsZyIgmusUzN/4E=;
        b=qI63g4X02xZmzfuK56jJO3gVELnPNwY9BOz6Ihn9TOyI9AFwgoQpwvzlDVvUiTwqsR
         AmObwXOxqTNnE5VY2JJ3rydhVx4IznQ2Sjuaq3D6MJ1xyntwKriG0DDL/EB0tnwEA/X4
         qb5gBrTars9FqNksC5PdJHCjyQ8+heR5SIZrrFTno6yMEi8WJ2UbYRuAwqmRBkDFVDaH
         5ABPrkvOyauYd0aHCygF7I0CcghUbtcdIBKoYUWe+nWfd6lsnbGpUNbajMDnkOUxOeS+
         cUM5DbhQJQ2deHOs4ppxIxLEEPnjJZQAB93gyUda/bjyROXErAFAj4bc/vW9i/osz03P
         QuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396811; x=1792001611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WxmdSGUkA1DO3egL6WOHUvJBsfcKWsZyIgmusUzN/4E=;
        b=jumqDkjcqbfUIJPJLeJ9cWpoMlX91QZGYc/0NpuicXKBZ9iX9vAr9b3PDir7+bIUoM
         R3nvMgjj+QPSla6SN+i//nstuQ7qyOAlMwUzy1lnQhpipzDNklU7YQDjfrZd3KjEtz/t
         sFXvAGHfsV/8d4ZYm+v8FtZj/4jeuTkJVKpwpv5ynjQpDv5P4UWfNCpn64A9JjTTD0iz
         oyJydUz+B2/BTWH/96S5gJxkUvX9ZC8EYHcn0rUCgFzZcl/cazfWdHXnYkPFTJEtsRuU
         DZp0DdnR8N/pHDu0XVR9oeowJg9gSZPZ+5UnCOxO3OpupczSlW7F7cuQF4Eexix/8YzT
         WdTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKBdWqoSMis0a9a/NcvcI0oC2BqIw1bJpxlygDdTyV6pxtkTdI6pU8U44utGaFBImMQhyYJ2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjNt3jhKMbwgjEseWfTzWvxEqlgZ2AwiSrSr5CDHpNKpDPSHA6
	7dnCvHakXkizyp3dfYREIZZhJhwlGpQkv2gq7b7i/lvd1gE3q6Wr5ctSlxLvHltyHv2b8e3MxYD
	bla7iznb/H0tRIE8Mx/z0cjZjp4ZHE4iAuP2Yxw5k
X-Gm-Gg: AYBFou06fMnU90G9/xLd/t/I691NIr4WBvabQd/f9qfjk+Mrd8i4b9GulR3lZ6vPnwb
	++pGbwSvmD3ByO7/WRy4L3p/Lw4CX/P8rCXIVv1P6hwiLxfZK5xyh3OWTMLG9EC80MaSTEjJNNC
	w2Kstu/F8lMaUUoya2gXAxzJaHzjFb7KkNdkaShsLOGKlpd8yR9gXA1GNVSA8T/l9X83cCFM6yk
	snNsVJtN3Uo/79IloTqIlokjgknXKaLQfLXWHSufhj8LFyySaiGUSnoqTIUDaHfOscIYfhT5agh
	q+dZk7Vl5m611CiSVZ/1JBjZwJsIPj9ivoT9uoQkch5W6LYKEidLpw==
X-Received: by 2002:aa7:c38f:0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6afdca6dbcbmr143558a12.15.1791396810631; Wed, 07 Oct 2026
 11:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
In-Reply-To: <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 7 Oct 2026 11:13:17 -0700
X-Gm-Features: AclHuK-_n_A8xp8YB-RDEaIVKPCVRrxiagUfshfsGewdeFBoQIHEykC2h8UN_Ns
Message-ID: <CAHS8izNHr1o922jw05y5wmFr-Ac3+VxfybX-LMOng6cXeP8Yrw@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 10:29=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
> after copying only the linear part, and the rest of the caller's buffer
> is left as it was.  The callers copy into a buffer that is about to go
> out on the wire: an ICMP error quoting the offending packet, or a
> driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
> is zeroed beforehand, so whatever was in memory there gets sent.
>
> Zero the part of the buffer we didn't fill.  The checksum usually
> won't match the data any more, so the receiver will usually drop the
> packet, but either way it no longer carries anything it shouldn't.
> Only zero for a positive @len, a negative one from a broken caller must
> not turn into a huge memset().
>
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

We probably need some better csum handling with unreadable skbs
eventually. I took a shortcut in the initial implementation and
returned an invalid csum because there was no way to return error from
the csum functions. With LLMs now this is probably easier to fix.

--=20
Thanks,
Mina
