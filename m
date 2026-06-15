Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00B413244
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542454; cv=pass; b=cIOCnevtL8VkjpaCq+THqBtQ9p7aaNd6xkYcoP+ZJIX4RNnn61v2sjR/FTMwqmJby+kMdKCMKVj8scbWYMukDhvlk6iPln5WJ1IOk7lr3hPkIQn/F6K/JyWa1rncw9Ai07IckTQ5l8t32N1BQc1my0hu9ki9Y3tmSXyJmi0P2to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542454; c=relaxed/simple;
	bh=zEwHvDF/Oi5KrPI8PZGGTgCBVKgki0dlIsLL4ZGwkRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pi5mr8yahSHvvqK3h5xZJP0owMNL2hPubNSCZrgCOo40lg7O8BmN4AtRqLi87zL7etlxExYtF88Yak1A7In9739KN/4EQACZUTshcYILEz6ESZFSVlw5qD/vwheBs6msTALQWYHL4D9iUfkl0gfs/DxgBeytTe2ifbmloqWgBdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnPimeq3; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnPimeq3"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517b1f2c6adso34834211cf.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 09:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781542452; cv=none;
        d=google.com; s=arc-20240605;
        b=fK0ZE6NkXRMkMKoxIQ6kBiZEoWTt9DM7bd9K+GB3Rwh7sDEORo4eYyTP/b+yTALk81
         tHQRPsT4e2eyWNxthO3JJxTjIPVrgIXZWeU0nAadhLzg/GLFiu6pucpiHimEseVYY2FV
         ZUSM3bMcGJXFGbzIDPhYQO+GwV4+oXDlhNDCSoNeHpy9/4UgWf9ONJZ4g9StXB9OQTBs
         8gQQ7xEbEDbJ3X4X8wkLl1eJ0PxdcOqdxieN1/sa3arC7iY9mah0nb6NtWyQy4UVN+9E
         7ezxHSlhpIGTs5DtJm73YItjvnLsjaKEF2Eld8jOsgbg5DYzAAxFEuu5uthiBz9hm9hG
         HFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mywi67azb0tF9mzCm0wSWcis576R5CWVcMnbNHwMBko=;
        fh=FefRU4sQbl9S3bFhVDlThU7Rsl3rGOy/+8zgKLdMevA=;
        b=NYD/LtHth685O53sV/yrSi06+zstJdRsMvL0XsDTY9A3igC8b7P5bKA3SQAJ6OFVSF
         OK0S0q/fWTy9O47SLlSjirToxzVKlAaBAsxW10KbgnAtbSIFGDGH229tesArAUhk+yWa
         9aSqbaJR0OXOBgMPftwHEScPaywnIbEjOPKM8AJweWNcNeHtTnhLObGf2dSFY9r/PQIS
         IsmmqWWb8ZfInx8krP2kZl7LflVEkRl/JtOxzWZ8o+FdkrnD5tGHbTbn6WbNIclM4Nm5
         +h6oID0bYNIjKzYjNInhINHyfYmZTHuv0ILaNKU+7sg3629Y7DlxcT7soCfowtPSleTV
         DqeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542452; x=1782147252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mywi67azb0tF9mzCm0wSWcis576R5CWVcMnbNHwMBko=;
        b=pnPimeq3PasLW2m/m2aPTBBuHtxjcV2Hijm+v89CPObPUDJBq9cRNcjd3WjM7p6z/H
         pn2K90CX+0tYvf9DWCdkeSWKS3xiU7tTesxW9ZRokRcTIp9ia27Or0oBOWhafGjwD6By
         ns0tDASzGDGDTvko3cTiyp0vf9zwhzd5sMf6oFcxBKA+QYKch1W2EjbkxcXSlO1ByStb
         4RXtW0PFrt9tVvtZ5rq5XH9gZX/klKTTbn2IXn9KFByyFkof5IA5FbePDX/WsEncnTvU
         mhcvDE00cWvt07YOjy9V8eYPfgNyj5qAhWV60iN46Iw1TV0kX8y1HXjfl9K4QvGNLa+t
         Dhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542452; x=1782147252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mywi67azb0tF9mzCm0wSWcis576R5CWVcMnbNHwMBko=;
        b=nyki3HmcAflV+34l7ZU4ybeQOWdU8l8Zs08Edv8/qggDl15Q74el9hU9+4VnQS4EJ2
         9/Xwy1bpbQE3Qm4mFNh2YamQ0yawjjStNZQq5c9boTAYrnBasLnNcq0O+Yx2UUKivm63
         Az++Oqto8cs/RO3fBurJLvYTvyWfgLAdQHfIrE4MOYohPzkDfylilt93kZGVRpfarnH6
         q+l04DHQhLeB/84cCjt7aXZB0pH3x/5Rnpgue7s85XovGpyBjnjP1GakxVpgBVQk31CR
         QTgzu+Ba5PLMYA74BD+QS4nZBn25TNJbh2j/5dTAMU5exE5a2XionCd8zbhwGa4EQNKF
         qCHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xAepsR6h4NYWWUZ39DzG6x6sabM5iwDCaoVqbCb6Ie60cMmS2wlxJX/F4laYrbyM8j2ayWrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5T0Net2BdPUzxzSqSCBgbsjIJ1Gyzlxeb2G2uFe1tDr++g0Y0
	dKrpo7UTapDsvsLGvrKDzM7YPc760osXyM/xpZnor0lZfHrA30e195L5bg01WgFEk7NlxNb8tI1
	gNPeUQwvpPJmgN3TgnGZpvkfLwGfc56cXV/lDb9Lc
X-Gm-Gg: Acq92OHpsdJLU5oJQZvxUVyUBSBn3OOmpXkDmutra8FzzvFHQHnD4gqfxtOe4PUTybB
	cIdUAKwVmU1oqY8iALT4fVS5cfDBYcU80SEYQXn4eipiG+44lODvYCpRfSCz36J0e/0hrDgNmb9
	OcH31207qhXnoDokJuJe+yob6QmuiW61TirEFzj8z0OwjpCi9zG6IwLMWmwGArISUhVardtk51P
	B8MPoDIYmcj70k+6usJxWW8ghnfwysFTd6zRZt5nyRZJ15UU0UfGEKBlF14uPjlOD91nCEA/Y7V
	JMtHbPPpCyzX5ZOg/gJk6RhDtR4MrDSAQSve3xKUI8YhRSIuB55rq27lCc0RK47qlJDE7OKyDF9
	m62QbkgpCwR8VVIZ90CFn
X-Received: by 2002:a05:622a:607:b0:517:a02f:171a with SMTP id
 d75a77b69052e-517fe4e576amr226669271cf.36.1781542451604; Mon, 15 Jun 2026
 09:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 09:53:59 -0700
X-Gm-Features: AVVi8Cdal2O6L20-PUAih4P0EZ9-LRL2uZJ_l9mNVqrSp_BUJSjPaDqeyqTpi_U
Message-ID: <CANn89iLwy0tsB5wMrREnGSvmPrThyCkjHEz0hpWbCiTJSG0NCA@mail.gmail.com>
Subject: Re: [PATCH net] appletalk: Hold socket reference in atalk_rcv()
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kees Cook <kees@kernel.org>, Kito Xu <veritas501@foxmail.com>, linux-kernel@vger.kernel.org, 
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 2:52=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> atalk_search_socket() walks the global atalk_sockets list while holding
> atalk_sockets_lock, but it returns the matching socket after dropping the
> lock without taking a reference.  atalk_rcv() then passes that pointer to
> sock_queue_rcv_skb().
>
> That leaves a race with close().  A concurrent atalk_release() can orphan
> the socket, remove it from atalk_sockets, and drop the final reference vi=
a
> atalk_destroy_socket(), freeing the socket before atalk_rcv() queues the
> incoming skb.
>
> On a KASAN-enabled kernel this can be reproduced by racing AppleTalk DDP
> delivery on loopback against close/rebind of the destination DGRAM socket=
:
>
>   BUG: KASAN: slab-use-after-free in selinux_socket_sock_rcv_skb()
>   sk_filter_trim_cap()
>   sock_queue_rcv_skb_reason()
>   atalk_rcv()
>   snap_rcv()
>   llc_rcv()
>
> Take a reference on the selected socket before dropping
> atalk_sockets_lock, and put it after sock_queue_rcv_skb() has finished.
> This keeps the socket alive for the receive path without changing socket
> lookup semantics.  A malformed or racing receive still drops the skb on
> queueing failure as before.

No idea why linux still carries appletalk.

MacOS dropped it 20 years ago.
