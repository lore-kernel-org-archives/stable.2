Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983939A054
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267089; cv=pass; b=VyFhmHThF6OfgndC5bUOenNOwY5yyvRzcIUka4HXVhHJVziJSaNV6kyCrAoFlvUBzneyXbfMIacbx3pfkyZt4d1tAk+7TIxOEJXUgy8n4y1ek1UNywpJa/o1BJH7ODTkxic12sk0yvoGQBYRbsFs9FvuThG/tykF+QvoN9JV5fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267089; c=relaxed/simple;
	bh=zkSL/F7B47mfagP4g1AKTiiFQpy9Jb+QcrEEKKNEnrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGanGBZWHhC31HAN2kJlSyi1zDneqPo5Rk+ZZfrhcm0zGsgsa0qjlAyJWg6+8cjr3WojAHB8S+fdQgQrGbpT+/7VbESkg5tzbRBV6uLfifnsUIs32J8y2AXZD90YxUIVpCVT3WsLr1yjaWRUWiiw7DHg5QZIrT/qZ/vbP2Vn1rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqvevHhR; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqvevHhR"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbe41618110so808386a12.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788267087; cv=none;
        d=google.com; s=arc-20260327;
        b=BB3m2Yy67zuFymNCMhChaqN1fmkAG03UJZsOvhQffDSJwAu4XkqMcbWgRe4TGWJsVJ
         y1gD97EpyMScqVN+KL41c0pXeWcIM2H97aQdHjAolozmXwVtPkUQF8t5dG46vV49zuAx
         o2CVjzk+cPTL43uA7c4A8RTOgv3KBk9mG5ttpoZEwjS2FD1RE3SuxqFt0BkDgtIIXGRT
         ZOjqaU4W8cygF2/mxRTC4AyKUeB5oJIT9iPX5jOOXf5XUm79AC2NB/oMSZ10V3jUp50p
         E+s8jPjebPk4uGYQTQ80vmgwyyjtjfNWLmPkGZMjk2m+thY4mjcBdS/97WEqRcbnwHcq
         MkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zkSL/F7B47mfagP4g1AKTiiFQpy9Jb+QcrEEKKNEnrM=;
        fh=vi6inutJ0O7P/DFJGe9Q2qaH8vBgkgTVbdizVrBQcuo=;
        b=KZA7ClOsp5Wb2FSOg/dkNfXuTc9E5Jn9cqHPMcKW0uSsjKM3UXqlE8yA+E8NZxtxwd
         4EabJMdMXbsgW1+1afxLY7OSsxaUeZh9aCsHfKqquZXvFVKedg0qG4uFSGZdv9dMR65r
         bBiZm819MVYb6IHXRV8RggEfM02G7y7x/FIPNK01whW698+PCdHv/+pMy18NY5vEZKL/
         bpl9wuI+ZQvsUVDTsBnd0ONAm6DZZDY95l1yGBabRMB3Euovoa1dp4ffaDazcPdtI7lf
         SHC0EkSd81hH21LCveisipjTVm5v+oip21By0fa5gIHVuxvfUUrcbdKCvlMWnPfZy9mf
         4Oog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267087; x=1788871887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zkSL/F7B47mfagP4g1AKTiiFQpy9Jb+QcrEEKKNEnrM=;
        b=ZqvevHhRPih9Z/ZZWEWxEtQfTSSZ7lqDEGJuyOktUWysYTJ8cOpKRtCD95Zjjz00qf
         qrqPHyl/GJinRA0ldpjnQByQLC2ijRNclc5kBV9jtHiuy+WmWZchYHq1cySBjfOgM8PF
         dRh5viOXmf8PfX7KSCPHXkXbzyIYMc72m8JCoYV2jRJ7mqO6q+QlWul0m/cL6CfFGuFF
         2ipWJV6GnuWfMNtw9Ed9RGadsnhqDytJmAuNzVb/4hACi1mvnL1tKXt3VB4nPRmBylFy
         LBtvUGox4vq2UctToFVhbGjDtfnxFBWE+vinWOQhA2qSW2YJaNIMd/jI5Ch0qU8JGKqB
         cKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267087; x=1788871887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkSL/F7B47mfagP4g1AKTiiFQpy9Jb+QcrEEKKNEnrM=;
        b=C99+UNQ9Mm287QrqIyLhaa4/BPNDnWBkDXeuVzodyq/f3AUD5sLrZmRNaq06RJVSiJ
         VaeYoLAv8rsLNsnrGW303zgJho+WXk/odNfb71GXSuNxn5yu1G/d/SKpn3RDT4bPQD/J
         kXRm/CbtR4IHDv5eWIJeuHp/pelI7jc2gwiPw03685tZiLaIqtj42xGXF48u2Ye2mkQt
         ls5OjWqbIEqq0OHDCYpXqBanCrz5GGt0qBLBSny7c/2jUUXMeXM/YOwAPeter3KFZToS
         wsf6zHsyDBvlNuWIJa/j1SFNRe3IthIHWOkPMGsd3B8fYpOYwhxBvopAVBAHtX1azKga
         AAjA==
X-Forwarded-Encrypted: i=1; AKwUvBwC0YKRnKEq/4O1+vDgg1IucQUYNv5V/IpugLIi0r8U3LklckmkbsWA7ZHwpEHJpFBWP53f2GE=@vger.kernel.org
X-Gm-Message-State: AFuF++m+4Gue/SCFAXwkqZdkQiCQlb1V9dygyH20bMbsYaAutls7yWQP
	ILZbf8fJ7MLOP8tmPoOj+HFOQaLVLcJ+GyDNA6CCKbFVtbCDvZBNSvz2UnaGNmC9FI8VUe7qOVE
	3tN0f7TAjFkRCSmSKNImo49FWjgLF7gA=
X-Gm-Gg: AYBFou01HijalcBarVMZFmy3b0Evp6bpzYycnccU5CfGhz4G+UlsecZGtFO0yR15bM/
	n59lkbjTYiH9k2jggZ/kwfbff3rRAiEmjZxG7+qUzWI++36N5BhJDEtPqcAlrh1sUJI/uTmaZro
	zinvLKqwMBjP0+jyL+umaV7AnPyTE8r58LjnjuA3JCp3gg0kfaf/c10GoIF/cY3N0ErijAL69K0
	eCRB1jroKGg1SV2IrxlegDR3o7IqNzKtw35SpJWpPiCt/au70Yo82dz9Om9qFQwbWvMG0s02ZWW
	Kac6d9fSJXjKbE8PvE5/CtAvoM5oY+Mgo8jOw0IiDAjaWOolv9p8/u5d0yy/Px4UQliGpujGZOs
	ea6W9JaJceBH+6gafHpLpiLKBXIY9iKJ/qpz4SmiUYKbk4rclQEWmfC+9leIc
X-Received: by 2002:a17:90b:17c3:b0:398:bada:832b with SMTP id
 98e67ed59e1d1-398bada8463mr19308227a91.6.1788267087455; Tue, 01 Sep 2026
 05:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn>
 <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net> <c4740d62-6d51-462a-9d47-0af8477d39e7@lunn.ch>
In-Reply-To: <c4740d62-6d51-462a-9d47-0af8477d39e7@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Sep 2026 14:51:12 +0200
X-Gm-Features: AcwNN1Wezo3mACTAKMu_Q5y0Y2CqgBBUBpNqp2vbnQUgiNLHKhzdgS-L_bRKqgw
Message-ID: <CANiq72mXDgdFXy6w1qy=fewJwrjV6ognGrTgNkn_O6zVpzbgYw@mail.gmail.com>
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
To: Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Chunfeng Song <springbreeze@stu.pku.edu.cn>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	fujita.tomonori@gmail.com, kuba@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, hkallweit1@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:48=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Probably a FAQ, but what is the policy about toolchain versions for
> stable kernels?

As far as I understand it, we are supposed to avoid changes unless
they are truly needed.

So there can be exceptions, but I doubt we can easily change a minimum
version without breaking a lot of users (e.g. distributions or users
using those distributions that have a particular version provided).

But Cc'ing stable just in case.

Cheers,
Miguel
