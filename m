Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F159355057
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328554; cv=pass; b=Z01NhtrKOCu1Mj4A6friRa3iMhKGNio057g+5xEhhCDfJlvi+4xVy4PXd4S8imyCfCpj+1s56H9kOi201oIrPiqnq8jus9/Qa96/r5k61BUBN/GFuPlU4F8k8MkfVFQne5e1RlT4Op/RtbpMcnWymSOlHf/9HpUtidEJ7ZOgpeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328554; c=relaxed/simple;
	bh=P13/I1JpiMJObKwvzR85BZx0pPqgNlRep3BwWp/ddK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN701esz2eKDB3WehDrG0lOMS9t/a/2LainfzRlrDoVC1DLAIUPBvjSGYK4AwPSfceBPO9E81cEoqotPJVPVbNn39r2PSCBEB0zv/WMecuCIbpaBiNZ7log62jKPW01skNYDxhfrgMOPuSp8tkwJ/FaKz6WjqAInxfupoBe1s8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muO3fJR4; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muO3fJR4"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb769ca02so8280231cf.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 02:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790328552; cv=none;
        d=google.com; s=arc-20260327;
        b=AHDt3zGw+eNUiZmCBCLvTZ/YrkWMoDi/YyEJsFGtt2qWLDqtpVxkSzavfMpFi91e0h
         FQQnoTww4VBk+i11bGAphTXdrUHaD8rEi8Ygz2H+H6vw3cJjaD3DodDOSwft4yTc0vWn
         t8zZDqKlCg51ns9UOiTLvDuTRYXGvSv/oN7Ti26HaYixk5+hQW/f7PvJx5BGFEsx8liM
         KIc3ptH3t7TUGCB2hrppQr/ZOGmIxbRuc59ACFR3lEcJPvnfIeNvwAf0Yd2cAhDP3ES4
         9e7mODaXBWKgDJfnRebsZkLf9UAThfhWZejIvnkL++CxpcA5EDegDY9PhbFenU4ru32H
         abYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHsY3Xqdz/2Bt7R/n8dp++evyHtiGaZ4pzrOna//7ZY=;
        fh=jhVU2PlJA8FeV5S4COGnyJlyveGcb8V4CnPrKnDddIw=;
        b=mKWgs4UE1H4Su/irDrVDbSRWmBf8rKtQmd3Y34NpKY54oW7/52j0kpNgybQuzfvxVE
         nIh885bSLFVaSLpXsAk5JMJEgIEI9CCtniKOaHpxQEGzuguU56BG0HKzizri0P9DG37K
         Mx8WzGJmURTwl5KjjJOZTu5/bPXOG/pL83xOhOo89tBVqT0sjsP3BGnti/4t8lgzLcht
         Dxl2BnxsaXssaEzSll+FA1n3jxQ1TxclgihRjU7yXEM+LYdSWwQXfGjurbgUaAokSO3J
         2inkJuxOmY4dph9lZlIDn91et8K1uQRKje+GzNnPUxXXpfuh5S9YkhdAI5nwkSSneOBp
         NoEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790328552; x=1790933352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eHsY3Xqdz/2Bt7R/n8dp++evyHtiGaZ4pzrOna//7ZY=;
        b=muO3fJR4CPBEM/yErlZlqYi8jFWd5INwQiK7uC6mcGR1xEopp0aYKSWFawkGMWTbcy
         iupfOZmNjHxCLz/u5Q00ryK5t5leq2YXIyUwGAJzKZD0Ib8r6Eulk/6sTF11mIr8sku1
         QylrkJuJl82p3BLIC5A7x4z89wYOPHko0mVNMec/ECW50ENRW7TiBNYqyIaV9MbjuBfP
         2bZKDb+DiFDXN7WSPC86jOtkSfRZlzQ6r5YDaYlxvLyc3+Ut2+v3QhSyKzH/UEvjO5Hk
         boKQvtv9YGoIRaGqygbVNSK95A4ZpHS6JnZ2urVhKQh2nTKPktOqjbyX8rIm1sZOMMGF
         KyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328552; x=1790933352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHsY3Xqdz/2Bt7R/n8dp++evyHtiGaZ4pzrOna//7ZY=;
        b=eGJBCYhGVARPW5VzZpqyi3/GTmQdowuVE7VZG7BMo5034nsOCXMis9nQ5BFKStkeUx
         HkNAfwIuU9SolZDT20enf8lr/71liYl/BpsdZe5cl1WpRPcYhQT6zrcN75MA3i8nQH7D
         ewOyJepgIEWuMPHqmJSWS4tUYmHhUvaYRZiXan0kgHU+qMfx+1F3d0ECTpVdh6Q21YuK
         termwpBsiL6B/ijTA4cP8xSg5Ynsosq1OxinUdA2aO29DD+L0MlwyZ1fTiFoOHrKrQDR
         RAyAmCAVzNL4QJPboHTLlAOQzpDI6WbNjG7P5QVs29eZR/McJP6aJbpEhJBUn2kYDdQX
         C37g==
X-Forwarded-Encrypted: i=1; AKwUvBxlnULZ56xbawL8LybxVzAihHA4yGVJEN5MvX/03EeVnfe+b9k8I+8T1+a4mtNXKMHZuEAvNTg=@vger.kernel.org
X-Gm-Message-State: AFuF++lk5kVbc8n5eINFAuJ9rfcOOC2CMj9LvidtpoDUvOPvKfYd/oPY
	zT+4Qlxf6wku7u5W3+iWn4aaa2OiCgtkyOqQz5Q9EvkjXjY/oaJKJrVvJ8eds6ytvbrxxX9aLDQ
	Vjy8k4tOrFGk2t2WLri5+Pvt6ae2mViY8iIKisj9k
X-Gm-Gg: AYBFou0/8ApXC5Uw0w9k3o/uBDXppurLtuk5H5u0sMLaNR3bsb0EhgtoOeDkaLSXCUn
	sn53EHQi7AmqDofyB0y8e1xpR+3qeKPM0UaxIl1fjF3LNhNsCyM3+Pa2ohBBTnHxAaCCGJ8uBNT
	7IS7vwYQMtE53rbcNyVcI4sdao7ooDBVJIrB8eu7pWQ0elEOIV+V7WQaF5wehX23V4wr9VSkDhq
	mG1q5gihNafBU1M6ZdJ8x3LjyO4sWPZ4hKEMkjdRiakdOc7VaaXam67pBywShwZvpSx44+aGA0k
	pVx2vsDDyIGZzHyu8SQLDFap6x+gvvwvaC7P91j0B7J7+42msYi7utRiqGD2cbP58mjfz2YcMlG
	1B7DTU6G9sNYpheTmWpNpOfiIh3BK+3DY+HDNoc3WbDoWilgTYhONeaUKeo3qd98Zqjgz
X-Received: by 2002:a05:622a:1906:b0:532:d1db:3ef7 with SMTP id
 d75a77b69052e-5330b5efd59mr32294071cf.21.1790328551395; Fri, 25 Sep 2026
 02:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923035217.179102-4-edumazet@google.com> <179031918107.2160803.12336993632886364252@kernel.org>
In-Reply-To: <179031918107.2160803.12336993632886364252@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 11:28:59 +0200
X-Gm-Features: AclHuK9IGAC4oHL37cIUGx2H61DdhXpccW35tf1OoLmck98goTF0bm8oU7j4KKI
Message-ID: <CANn89iKk9N2j0wLBzT-uDx4fgh6ziS2rLPRcXBhyt=m=+pyJcw@mail.gmail.com>
Subject: Re: [PATCH net v3 3/5] ip_gre: compute tunnel lengths absolutely
 instead of by delta
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	u9012063@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:53=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] When the GRE header length changes, ipgre_link_update() now
>   replaces the user-configured dev->mtu with the default computed by=E2=
=80=A6

Agreed. v4 shifts dev->mtu by the header length difference again,
now computed against the tunnel->hlen sampled on entry, and drops
ip_tunnel_refresh_lengths().


> - [Medium] A changelink that publishes a new header length but carries an
>   IFLA_MTU that do_setlink() later rejects leaves the tunnel with the=E2=
=80=A6

v4 shifts the MTU even when IFLA_MTU is present.

>
> Pre-existing issues:
> - [Medium] Sibling changelink handlers publish a new encap_hlen through
>   ip_tunnel_encap_setup() but never recompute dev->mtu or=E2=80=A6
>

erspan is fixed by patch 4. ipip and sit are not touched by this
series, see my reply to patch 1: this can be handled separately.
