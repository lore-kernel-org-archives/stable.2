Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794908102;
	b=R1eGgrSRHYxz6KSYfcadZeAESfWDFt3fr/+F9QD2BIsAXwuR+yvfExmRlpY3MmcNu0b+
	 LSYHu8FBYpKSZQH/iwCvuZUvo6QjeuEpITXB40Hn7Er3bFQDjPCaEMGvC0bfpVKWY5J7/
	 ILbV7Do9nVVR7XIP0VkJhiuTmE7jxiLbxKVGJmA263UEmBU2vck6ZnSLb0N+J0aX0T+cO
	 KUcjMdplRb/LjafDH6o9LaYWLVdboqUVnh42djnW5Kh/BNEVYPs5NYtfFWjiw6RyYr4yS
	 iewfk48ncljhXnqfcjESBiJ0ptLeUw0RtbmNy36TvCZuJvA/NCMVE8IBtjhDwujHnjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=k43+4NXoe93Lu6IXLeFrYJXGLcVxquToj/t7KJWYnQw=;
	b=GVH5skn+3iODTH3NROdTpIy1DQ92BSRrvhg6xL7RdAQDTRlIKAP6HkaGi2FH/ERPXAXm
	 KmOx/FxBoesi9r8O1gZIfPNs7IbqjVc+eyTOgzn+t1v/b/bdCzO/DD3/nf5BuBiHIrO+6
	 E8ziEgX5jc7pC10wByAGZA3+ltfx6IhuVjYQxEkCSWD4ujQHLfXtjMxsf5eXvRaCWjO4D
	 GeZ00cteyhIV7W2HVjdef9GR6jgWGPT9fa4hzj08nGnZsv7u2NSnsHEZvD+EmjxAtSMDN
	 CE74/P3a2OrGlzVOYvwEY9dwlCSbAYRT6Xj9eKB/NlY2Ulh440UhwCilbMC7Qa41pHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QOBf4hu+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D46606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11D46606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QOBf4hu+
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so5239652c88.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:35:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794908101; cv=none;
        d=google.com; s=arc-20260327;
        b=n+yEgMaA9BAidRfEq5KArM/te5pLapEFUxid5se9B3PDkakpn1wmf95yEPhDONcG4d
         x+aeOJlBtTtc/Zohjz2Z/LgE9MN+2nCcdZk1JuHbiJfXs51W6qa3xx4rs1Jg4SdUDaaS
         w869Zr9Dwm5oE7OpkkjPNVdoyKP3ruw2a4lf9MEpC779ZSmD8hhaBVL/SyGsPoJxxtTf
         jmh2VCScO7mo3gFRxyjC1nKRLPEdoK4lBuLkI4tia23qBu/ynB38K4sxO/Ez0wyrdpbR
         EGncrQytE/iqmefENNq6IESQLjWWaGvZ1+8DRoXQppChuH7RXjFKq4ETBBjO1pYBkup0
         ejnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k43+4NXoe93Lu6IXLeFrYJXGLcVxquToj/t7KJWYnQw=;
        fh=IkfbL+jszYe8lgxscZyi+UBc6AnfIgxmPWhC9tI7YHI=;
        b=cJa1PiCA6fmrOsSiLxoaWFPtqsFzn1htFg/Qw5t0ZoLjnF1mpXqwMQ2KG19j+/vlIP
         YNGXaKH/+Aq6wSLPBnC8XvC3TRv9lJqM9/067tKjAyadZtGjOYT7t8qsTp+fuPmbXd6e
         By8/sEbU7RBHfUUYDflN01SaC/ejvJKhTKnraczWaMpFZkTPJQKo6n7GfLwrT/4E6MIw
         z3st6hWzFyhm/n7x7Cus+8LVKX6bkdGeHHXY/l88nghQBolfkI2LdKTmY5c7h2r4zKnr
         Qos/IPJSJjuZb31UqBRHR7RpkOlC7A/Dkc0jkrFhznKOx+72sD33xDlP5gFmxvL/YkF3
         bOjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794908101; x=1795512901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k43+4NXoe93Lu6IXLeFrYJXGLcVxquToj/t7KJWYnQw=;
        b=QOBf4hu+e9P7Tj0w9vSuBeMPpOphD6LpjtcGj1L/uNVodpZ/F5Y9N78nPLRRMAuCEH
         gkDJ2f3/TF3vY/4zLaT/jlJxAldC+6SH23dYTMfq/sv6IpCNB0jDR4vwz7QE3TYQHvg7
         sQsLEJ6da1vKC3PazmpxeXhFh/1q24M58jpc4DmCl8NNnAKDk2Hy5+e+mh9nwUjTFpca
         BusYl7ltL8rCRM79KoWi16IKedQ5KMVcrGXpkAFFNPt2+roB34rX5nD/x2Xes67LmwPP
         NOUwoGYdafEGrCj0KmT6hM8f29woMERR7R8gG3aYEjAoiUKpawViwgFZBqFMAVEDuojr
         EDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794908101; x=1795512901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k43+4NXoe93Lu6IXLeFrYJXGLcVxquToj/t7KJWYnQw=;
        b=nI/rBniZI0l6bLQ3uyJdXRcQ3E0anzjwMY+3hXyUcK36EK6bPFqo1zGGDRIe+xG8yw
         H39uk6z2YO8UI7Irzy4l0FK5JVsv+S/tl9y4eIfip04tnRCi1ABiw146CXKsQ4g7wJi8
         iSPVJylckP4Q++h6XYULFcsxqoAVt3nGMmiu3K7REW/MD8sTR/dDtbCvZx/14NzrT/ja
         GMxpRDan0OF4M+cHSQkYkr4mhwKFGVGGfe+A4aIdaH6qXNFKZ64PicfkjWsjPGq+ZmKT
         1I6hW35s4ciTSl5kVrH7DeqHaTtLtfEcEnM5qVzX7YMqUB9ol7jC90r+q4Xr68+KjIWZ
         nGbQ==
X-Forwarded-Encrypted: i=1; AL+hErGUvtI2u/dIONJqDtCm8tt1VYUReghaStlfFM908N/ItwtOKy+kwHhuglaD8CjwtvQqGP+BLpA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NO7YqggIUtNE6Jn0DCzApaZ1ZmFBv4XBfrvfoltINWYPlL83H
	5pH7DLAwBrlVP1QxC5ODjD6HowcWfFCNw/5nbgkK9jCHyiuhI+Xsk1y5AY384LM1wkHRssKn1L/
	q+FBL6FP731N5g4qV6HSkrq5qEvHr6MA=
X-Gm-Gg: AYBFou2o2xwoMVxkfu8sZ1abjkfil0DlcM/sBfsGQz05wTyjhS4YwWrCToW1Yxjx7sP
	PDmHonxbTFRQvW7fzD8yC77NwDscdaiRyd3OD85rjhvA0ePq1GGnChoxsXhG4t8dCiq7r6U+Xi5
	XxANFX4apByOdocz0Eu+oLKiHEgccjrdbHKHeTgeo5LuUfxStJ9ANqoulo+wDbTkyzAo4sGU1h0
	wzgPUcAwcZXzoubQUIoiCArXDKvrVRceWcsgia/FaGn+URB1C314XR6aB6m7MRQpkCNz/zKcWyo
	BeA1T6cW2pKa1WV+n6uMAtilP91FnoAVxcHULtToMUbmqPpFDaP3HxQWnGAQGhLpO4qzzsDeRAH
	liLUmV6G+akcjL7ae0tay8iYHtNtng+53bZN1ShgKfiZxtc4FXA0/1vfr8vn+0QoMDzb9
X-Received: by 2002:a05:7022:1583:b0:195:e4b9:d326 with SMTP id
 a92af1059eb24-1b503112a76mr12794044c88.12.1794908101016; Tue, 17 Nov 2026
 01:35:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117092157.85513-1-hj351016@gmail.com> <179490763326.3291.12558236650605974154@kernel.org>
In-Reply-To: <179490763326.3291.12558236650605974154@kernel.org>
From: khj <hj351016@gmail.com>
Date: Tue, 17 Nov 2026 18:34:49 +0900
X-Gm-Features: Aa3M54qHHMqn46yygTWkKBN9mkAPbQt_LCbx1KdUTLuCMqi04h-jEycpKTEF0pY
Message-ID: <CAGr5VtO-aiy-RpUsnw=dKVFP0wgvBnQ7uw-NWr-4391WHV7iHQ@mail.gmail.com>
Subject: Re: [PATCH net] l2tp: reject short IPv6 address attributes
To: netdev-bot+sinfo@kernel.org
Cc: James Chapman <jchapman@katalix.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Chris Elston <celston@katalix.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue was found by a static analysis scan (pattern rules for
NLA_BINARY attributes that are read with a fixed size, LLM-assisted),
then confirmed by reading the code.

It was triggered at runtime on 7.4-rc1 in QEMU: an unprivileged user in
its own user+net namespace creates an L2TPv3 IPv6 tunnel with a 0 or
4 byte L2TP_ATTR_IP6_DADDR, and L2TP_CMD_TUNNEL_GET returns 16 bytes,
the missing ones being stale heap data:

  sent 0 byte(s):  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41
  sent 4 byte(s):  20 20 20 20 41 41 41 41 41 41 41 41 41 41 41 41

There is no KASAN report, since the read stays inside the skb head
allocation. The leaked bytes are non-zero only with init_on_alloc=3D0.

2026=EB=85=84 11=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:27, =
<netdev-bot+sinfo@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
>
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.
> --
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
