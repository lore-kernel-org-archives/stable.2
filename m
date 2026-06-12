Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD603D6476
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246519; cv=pass; b=IkgDwOvB0vKLjOi3lZ8IKNKmdBOFViU9KgSXIA0GdDMPpVagVgBlzRvY+hrV3t0jWhQR1QSMPq98x+tFXXGTTxRZe2UkLmVaOQUbe6l18AXB8RyCwJd7V9shTAxOjNKOyKMGNyupNZ3cN+xxbZIsLd3aeSPEF5TAsnVDSdAxASQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246519; c=relaxed/simple;
	bh=il9gLlDK2ryI0ZJU3Rk08iTfXQVb81d8dYDWL7SRAzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmPJbyrBvPt6Ic+ToNztQWD4e88Zf53cqV6lFgAKGzdSGECCaeYIq8EPfDIZdNpj6qajWHb9of3Btgy/jP1WQadnrnBk/Ck27ljwFSP3gTPKqMs7LmMpMlHAjQt0/kKUdxmWOUvMjlbB3FEnolPLRYti43Zj9lS4Nh/2CT1VWOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ViBKG8bN; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViBKG8bN"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13807d2f898so714384c88.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781246517; cv=none;
        d=google.com; s=arc-20240605;
        b=AceYg818HFBkLl0sVWlaUjHKzIcBuQPhlEXDxn+sxfNLt9lorHizVPtV4Mwuh7MWIt
         LcgUWDNIOXlpnNKF/v5iMf4gSr+2lFK2FAlrcyGQs5hP7qcOfcCl2RpsZ7AwuHxaZImv
         xd/i7sKT7znBq5KROVwiFYx/vWIVrLYU+Y1YiKymVl2upaOhaAlLWfB3TWmsj0o+dee/
         lhK/BesRKNL5P5cwLwpmU3ZzBqiVKLd8+4Hfo6wuHH8UnVuOjPrN4ya3M5Li/uMGf/aJ
         IZsZDpEwUSFWNUfuyGXPD3ZiMGokRBxalD1sqTWOSbfpYumEI9hmXH0/79JdPY3eT+rk
         4nHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=il9gLlDK2ryI0ZJU3Rk08iTfXQVb81d8dYDWL7SRAzw=;
        fh=REDPunMhtE7b1U6dmjTRagCEYLqCJ8jJHlfddKVq784=;
        b=F3h8rDqMU7VDp0/xzMb8/dH2pIFly/vbUQVT3XUQINqTwM7GEHIJ3wl1N+tVAOyXd2
         qIJ72PoIduDkDopzlHGzFSiUdWGhWFxHznP9ouYLUYsX88PYXk8h1GSUtxiTDwDdykHB
         JnwwdHMARzVTX5aIHGEJSpea+mKEue8daGo0rcAC85fuC+9/WQLjS5qx+oX2LstTR44M
         sLIYYM0dTiFO9sADZoGumgOGjkwF96QEm1Asep9uzMz8pHe9EyXgeUuB1rWpmwnd5uRe
         P6zqPE9VoNj3indfa1qNlAfShIHm2XgLvVSkPQIB8MX0nYqkvNb4oCwecVxUqxBj5xJ9
         iPMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781246517; x=1781851317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il9gLlDK2ryI0ZJU3Rk08iTfXQVb81d8dYDWL7SRAzw=;
        b=ViBKG8bN2Dc+86Ra8JFtji3ftEKhz/WdcpPwgiIRTpexMojvsr3LIfAENOZwbOLWJN
         8WTsWlTVDMCu295oCTzVI6eGiP1T1JCGxpiXRC4/2lQF4JFY9hilSlahiWZpphIbzarg
         GU8epCY1VdMbEfDpK3x4WEL2haHGFoJel16jcVD9m05Y9InEBcbIGT7Tdq+euBOauh9z
         PoTgCjSNqZwx67yfEEXU6L91kQqxIRQIHjkkeK0GP4PS7upsAiazDvHWqJFkjOJtUfod
         VWKIYLoz62rHkg8HiKHrr/vdVPBnRCF7FBCKDa1DkRcv+mnksW0URqFfzRdx0kcG0qd7
         A7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781246517; x=1781851317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=il9gLlDK2ryI0ZJU3Rk08iTfXQVb81d8dYDWL7SRAzw=;
        b=koyhGqYIkbEvJrvFRnVzjl/uqaIWTy2MUhSmL4PEbnzPsxwgovhT/d4R+2kFp6nsBi
         ikwJNkNP17G+bS8WAt0p7TQ/EA76BRPKq4uDBJhwxC7kCE02cQo6MEmbtyst5BPXQgL0
         tYMCaLxG7p+QrxBfn3ualpBAv5hn6ID4A7N/CFWhAxjGDxx8dTM2GK4PvYs7nk+13+eK
         4FwdjXZHmSRVwk+5WR0iSnHQ3/7ujXRMxzsSlcBDDiyf8E+Y4REsBqKLVzwpRZtfIp/x
         0G7LLpABTq5Jt0TE9L575s/YvfBl2U4mezQPdsWXXn+wgS7T++jPL66ghEFf0lnSoFDL
         8GXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uKuDegLqarOplaKpc3pnf9k9oloFed5Mkeyd62R9MxHj9TqRUsTsYykQy6pyXoFUxccue7hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7VAtzmNNkPjIoUBjjrbE7vOnhvAE+ivQ6AmzsOWyPYGTv/DZr
	c6y4HFq7K/au9SDWDeha2/fS2udJTQbCbdgUHyjBgrUx/nYskN/aR1vzfxtunRMaMQInRHq5Y9N
	Z2Yrms9E/WuD+UcQq9omtEkd4brvkHAiII+6Jik8g
X-Gm-Gg: Acq92OFvw6Ub41abFmK6CCgs8hurlgMeEgGMOs1rSu7maCKf0DC9+xtdnnzTm6UXIge
	K8M/R/uGtad9NK8OQ1WwjN+40fh9uQ4Z0cNA+pyqLc1H98RFIMtgY6tnT4bBVVKDaJYW8XRe8bK
	69wSMVHp8YBFYo0f+4yuLohKX0r0GYJj8dpYB36COrZBApcDcomJlgVvZvcEJhQJ64k+AGRMutl
	A6ZKPQRshgqPqKQV1YAUJUAWp8F5LWWZdklETx/RivwsLd6Vw0p/qaUbVEbEUMHpQsAoIQDZsIZ
	CL8hh6VuFBRCLsiLdrjKQBJm/vkcw3bySxGJih6kAkTTHuWiknSJGRPZg2alvzgyCyrsXN6ZL33
	Z+ePZZci/MWkFY6meQ5P8IyUABp1xIEphIHvEooGlEPUQVCOI5hp2
X-Received: by 2002:a05:7022:6a4:b0:138:407c:1d0f with SMTP id
 a92af1059eb24-1384baef0b4mr595568c88.1.1781246516575; Thu, 11 Jun 2026
 23:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-2-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-2-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:41:43 -0700
X-Gm-Features: AVVi8CeF5TL34MXY3AZ5iYUyue6WIxsN_f4iunM0aCi1eakSENdPJq2jGVYJej4
Message-ID: <CAAVpQUBnqtBAO=AzAKckuuLZdHQdt6Z0dxPDxTdT1rpcV3JL5A@mail.gmail.com>
Subject: Re: [PATCH net v5 1/7] net: ip_gre: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> A tunnel changelink() operates on at most two netns, dev_net(dev) and
> the tunnel link netns t->net. They differ once the device is created in
> or moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Add rtnl_dev_link_net_capable() next to rtnl_get_net_ns_capable() in
> net/core/rtnetlink.c. It requires CAP_NET_ADMIN in the link netns and is
> skipped when the link netns is dev_net(dev), where the rtnl path already
> checked it. The other patches in this series use the same helper.
>
> Gate ipgre_changelink() and erspan_changelink() with it, at the top of
> the op before any attribute is parsed, because the parsers update live
> tunnel fields first. ipgre_netlink_parms() sets t->collect_md before
> ip_tunnel_changelink() runs.
>
> Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
> vti6_siocdevprivate().") added the same check on the ioctl path. This
> adds it on RTM_NEWLINK.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")

This tag looks wrong, the correct one should be

Fixes: b57708add314 ("gre: add x-netns support")

This also applies to erspan since it shared the code until
e1f8f78ffe985.


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

The change itself looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
