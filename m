Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862E478847
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328690; cv=pass; b=i9Ga9yXfJrzIr8J1CUUkBIf7BK+JovLfA2+/ouATX4CMuUNdUPimLpafmF6UumkNHxfR3bf0vvqxwy+nKGQYOj3ns1pH1XoeU0g5dPev7Vskn9nwhCplmMZhvi6MH8MhCSh6cAcGcYU1UOMrrL/FivA1c/+PCiVAvjkcvVxlB0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328690; c=relaxed/simple;
	bh=P2vkUeynyQ8bhkteIxfSfU8kk6dsNYQMwky9R7uQxfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdF4jisKWOXKNfv84mK7OYdFfrk3r9xQ6mf5QyRVcQgsgaC4EbhxKiJ+4U6nQY8CvKs1hgKiqw/HTZWjHkYAajqrhdGtLlPS/HkFaTdgYxG0tj2FbDo/1XmzpFH/ZJFANdytLAsiDAMOzQAirCjxZSANbXm3rdAQhW938h7FzS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lF3LukoS; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lF3LukoS"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76543e2so3531971cf.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 02:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790328685; cv=none;
        d=google.com; s=arc-20260327;
        b=kL1WZlCTYNO1gi8DIZ0tow5nWmDjmkmkvhEKk8L70Hrqes1G+x7ISsQneLiXaGG2SD
         RB47J/eAF/H+EGPtZlEf20ZeZwhu07+rZwzf7J/xYOj/hKfRvW51KKMSzPU9aVY1trMY
         7nc4mR0dZ+koGF2TshWuc0k/Un7jhfycYbK7LZRDLE+3dpvVYH7Qiqq9V9MaBQpj6tJv
         7SkGLVtWG9CI7OxdnTt0PBFmpalK6b/PjIQBRLgASd18sKE1s8c20YhY2t1VhKn/Zc1z
         2TkLWM8aL8eus94ZMr8AKWqCaGna1yNp5HdLggbSA10aXBbaN9BiemY2SMcNwC6n1iYi
         61hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BoEGz32kOhSBAI1jaGQ8WLuGcooDte4aXDht8opxmTI=;
        fh=lIVeFGOK6AIxibkT49QNhdqWaEvUp+KPEoR71zLFdHE=;
        b=Erockqd2oOIllc4xYuRqqrrV3R2D3++fISZ+NSiVJZiLtH4E1OWkrhAqKH0EQ/81RD
         8PtZ9iZqljO4HaHScLEyFlaUnTzR7ytqOEz3q+gwozlyivonTgL2XrL04C3Jyj/uDFZi
         3td+/6hYMU8ujaQYkUvbepTAcDedRNeOOaEo0no0kMOITPyso7V2o8R9Jqx9ZXcfG6jF
         cf6ZNzkRduYVdrvcw1JK7NhkCr+1MKAI2YQTVtjAwCNVUb+ZILbNoRK12SASVwcxLLzG
         O8SN26lKnkW547OxubCOc2ewjHtQpBNXxa3AL4DEABA9zu1WB2apiuA2GhiRx5Ebj7zK
         J1kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790328685; x=1790933485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BoEGz32kOhSBAI1jaGQ8WLuGcooDte4aXDht8opxmTI=;
        b=lF3LukoSxv/RWL3NE08owNg55ranb5BFsj3nkl6hMS7SLSGCRFkLK+fgBjBJZosJ/w
         /GttFcN4+lWQ8ioQOsCpzh93h7YnokXwds/N3Zu/MdQ4PKml9cAQcwX93pytcXVWxuu2
         6ZaCffvJ4p9P3b4LFHAutl22RBKfBQXlGeBLCzjfoZPp1cAKzKNpOUr2uUwjmsansZ1Y
         XU5ntC3epqVbjNVzC6HLasrMo23+pPMAkt/qv6i43n4Cftz8fT5pLWjfCVnGETYwZyZd
         7SY4u6f1c7ZFhSkQAd8SUk7nBWVD/FGSGOKzOab07Xit5RF12P0ULVz33/q0NeopKeBy
         524g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328685; x=1790933485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BoEGz32kOhSBAI1jaGQ8WLuGcooDte4aXDht8opxmTI=;
        b=vM6B+r2FPzdCu27cBonxDJ3cnF5Qk/ucT2kMqWCEBUAYFCzQR4I/GrlI6dpiOu8FBy
         esjhGYhU9uDeVZm2U+bnWeZgwSizApox3Wb72FMrQlyT50X4iCawS1oKb0noO2CKyuHG
         KI4ZFfHaIaySd0u8NSWPW5SBOp0KPwOTYKSz8WXgcBl7hP1M0NVUtF6PwI4Bj8HFHM4b
         ePfwrInAALgAkLe/TRN/FzT176pdwOLv2CUgMRlEZxOFbMRSGepy23CGFvbWEeLpFGuO
         bB594P9g3oCM1gAgvHRDNAW0tD2NTFOY/sjaVETvsvdKd3LaMfoTzDMVYe93B6CHzD3P
         mzeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTQmVcjeXwJeKE1jTX9Q8He1bNY/ybPWNsp3U8S4PmWxNvMBTPf/nZ/oKMe2gBSYnyOCPo0rE=@vger.kernel.org
X-Gm-Message-State: AFuF++lXvTOaM4P7Gm8LzwethuzSMW+DGMeVkrO1TFg53qhTbl49gol9
	IIv+0OvztZskYaKSbGfo9jNzJKRyoNh3nfqC8cQ+xwjIF8NNXIDORHgRiVudha4Y4f9/4WJzqBA
	XwoPx0IfpKYjxqq2n+YCZQrimb0eiO5XtEwZdB7n2
X-Gm-Gg: AYBFou37+KV0iBrUWnTiPEkc+CHk/da7SeNUoJiZJyKuW4CzQF+skjVjsPP7Nu7P/LE
	KY/vloO0KT9RnUInVhbetYw66OoHlVgmUZVNf7e51vMjwR4cMTp+Eyw9DRpP2keWHZC7UHW0Jge
	V7vNtDBNQLgQAUrJv9gQFx8ZV/sEStjpbHwExnTgmeuVqnyegLuXU9kA6+a53+RcXGXvfzkSeW9
	n0k1Ph/o0Le6RcSAmDbDlUBEkKEt9v+w3sZpbf4K8MacdM02iQcVPDyM5UOEvsgWN67UkeG0sU4
	X5ER90/7G6XuAlghTgAPQImvXm8aJU2vTmYDvPvHgflqZ8eLbzUueOukwM6a4MJeJAxswtkYM1p
	2XrlX9m3DbAJt1eBj/hmQxyPQqMRZSsBcWuf4QTTA2YNZCSxdBZc6n4YtSXqxe1jZz5Y8
X-Received: by 2002:ac8:7f90:0:b0:531:1a2f:7eef with SMTP id
 d75a77b69052e-5330b6cda86mr29901551cf.24.1790328684829; Fri, 25 Sep 2026
 02:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923035217.179102-5-edumazet@google.com> <179031918219.2160803.6960367885486755444@kernel.org>
In-Reply-To: <179031918219.2160803.6960367885486755444@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 11:31:12 +0200
X-Gm-Features: AclHuK-wTGtFB7xxeHFdzo4ZSGkDq5PTwalJ6IvrEFs5zfSVV6J4DOaRlpmPogo
Message-ID: <CANn89iJyx5AWqjWaSe8ncpEeLjQ4VpG6kmU2qkyZjckXwSVbAA@mail.gmail.com>
Subject: Re: [PATCH net v3 4/5] ip_gre: recompute erspan header lengths after
 a change
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	u9012063@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:53=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 4 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message says "There is no memory safety issue", but
>   the bug being fixed also sends 4 uninitialized bytes of skb headroom=E2=
=80=A6

Right, the v4 changelog documents both ways of sending 4 bytes of
uninitialized headroom, and the GRE_CSUM corruption on version 0.

> - [Medium] On an existing erspan_ver 0 tunnel, every changelink that
>   carries IFLA_INFO_DATA but omits IFLA_GRE_ERSPAN_VER (and=E2=80=A6
> - [Medium] In a Cc: stable fix, the patch rejects non-zero
>   IFLA_GRE_IFLAGS/IFLA_GRE_OFLAGS for erspan_ver 0 and for=E2=80=A6

Agreed, v4 drops the new validation. erspan_xmit() builds the GRE
flags from the version alone instead, so existing configurations keep
working.

> - [Medium] This patch makes tunnel->tun_hlen/hlen change at runtime on a
>   live erspan device (erspan_changelink() -> erspan_link_update() ->=E2=
=80=A6

erspan_xmit() racing with a changelink is not new. Before this patch,
such a changelink left tun_hlen and hlen out of sync with the version
for good, and a new encapsulation was not accounted for in
dev->needed_headroom and dev->mtu. Plain GRE has had the same o_flags
vs tun_hlen window since dd9d598c6657 ("ip_gre: add the support for
i/o_flags update via netlink"). v4 narrows the erspan case to the
duration of the changelink.

On the headroom side, the version change alone makes erspan_xmit()
push at most 12 bytes more than tunnel->hlen accounts for, which the
20 bytes reserved for the outer IP header in dev->needed_headroom
absorb. Going further needs a concurrent encapsulation change, whose
header ip_tunnel_encap() pushes before ip_tunnel_xmit() cows again:
that is the pre-existing race discussed in patch 1, common to all
ip_tunnel users.

Closing these windows needs a snapshot of the tunnel configuration in
the transmit paths of all GRE flavors, which is out of scope for this
series.

RCU conversion will be done in net-next.
