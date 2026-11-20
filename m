Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795134421;
	b=k/cKVjJca7/qqIBJgMqskKv4I/0yAfXAykpzevPgrrMuPv+c8SNmI0OwlMA/A6q53ChE
	 SfkWU1bqM8mvmRJRS3EiDjflRpA6li83OwXhuBZMYXW/F+LZbFFCWaeIqizxeLOnuX0xx
	 i+JFaRzr9noGBy5plZ4edyJBEMSyuQxc0It3JmOPVY7sNQuluY7IFeEHWVaPuKp5rGolB
	 R1pssY1XtrsF8kFyla/ZImd5uSxXS+tYdHZ3LcWSCUdgqGcmPknzlheIpL+ngOcNa5Ld0
	 vdzwNj+HR7Fp+x469KjDsbUcat1midRYA2ev9G2779EJ1W7yCJXd23qIEKMCEijfnpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b9j9vXtfY+EbgPv2tG2SsfgvXGNMtTujxB5ZcN9bBcQ=;
	b=XbJGHOOMIBVLhKB6saQ7mAr5qFXujRm1jGcgmTPLuaLlxLdi0sssWeEVgCQpUvZYUNbV
	 k9d+S8y8VEelrZWBktVssrHSFpIlejDVVH4zOC0fSZYmB2C2IpUMhf941+fe5/koTohpl
	 +hUxZqqB+uddpiSxQF+TR5h9D9dlID6PGI4257R2oPu4QCt/5GLoluxt57kPH4RGxNT6J
	 dHFCVSJsq1lG6u5GQNZkTlbC7ea8GFOuKLTKxeRj4mbsZacsLG/2hAD7P4n4XwKsiLlTU
	 ZLQuGLYrLRshSlZSybaSa5bFZ9OSFLEUa9M2o9xvXE6aCt+MtQwm1hY/vF3LreLecJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KlHlNBRL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA2606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9AA2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KlHlNBRL
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67db35e7953so558983d50.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795134420; cv=none;
        d=google.com; s=arc-20260327;
        b=eH1yeIO3gCmcUDX7wWBC2hOPyrCyXxY2g1nG1Bqlnx8NgX2YbD7M0WnQr4Yq9znQky
         eH7tde+7HdxuC6gbbfpDjFn/ZrYyvye8La/zSjSgjiEOq5DoRLFGAeW8B2hYIgF0o0KS
         cCLRQZ4O8Sjq0RZbcVuFMceiNrb6hLsqXuIbeq/X2vZn0vQJjqgW36U4vsuAS8Pj2LTx
         LJnekvlrWOowu6ipbh9BLPfdzzsfw+s7dXEZezHGa5MQkqKCxp8vUhDwv5GVlzDBdnM4
         UmCWdtLXKwEwUmwOBrTawpIimhfxEeUgRnDZub6TsEUY/8y/B2OTph6mWiAMEm86RjNs
         1UEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b9j9vXtfY+EbgPv2tG2SsfgvXGNMtTujxB5ZcN9bBcQ=;
        fh=tx2stVTz6k6eyhhBZN7IMJFnxSd1Pr1kYA6GWQHzF/Y=;
        b=qxWbVAjm08Avi0AhlsW5ymcmQ9Xh1lxJ0nqz+fKAvPXGD8JmbC2WSYsUksziDlvixO
         yRLdPBT4bGXM4ft9vlrFg15LfytJsvvORsK+EktZFfWXl13IhRObIKAp4Gakr2ubDv7S
         SvCch8fIr8V3IJBbAEorTYZtW28wcT/cBvJShac/gWCcHA9ZFCdwxjrXmjzHBdSF6ink
         KwDYNDeVFZD0H5ZblK3keYENGFYpwgDipkQxygd7f0PUeKV+1IuU8QDCKFYKTnnodj4P
         ucTmOv6uZIK/6XvSBBfP7X4SS9UGsb0O0bGuzCigJq9i+s8vwal/N7PgDmv3UDVVSESA
         t3gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795134420; x=1795739220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b9j9vXtfY+EbgPv2tG2SsfgvXGNMtTujxB5ZcN9bBcQ=;
        b=KlHlNBRLnkbFIkyiQ4dmD5l2RFLqJtNmjLeuxHpj1TOb2ee2RnbntdxgZUOS7qRia2
         Z1Du+D9vzUBMPZJERe5mbTyxNkcJ3/9wS6aBfdwtP2Uk7LBdC3YCCct8fO/YWGwc3oMJ
         qaRGbJbwNmIl8HOICnk1tzWdc0ucVXEg4oInUi+qS79oBguSq0lU6dBtYaoM0ytC7m7K
         zIV6+IyVgbMxnr8QBP4xST2fozCfU8ujzWrnRvhm2HoEvbuPNk2lexVqSRugvuH4lVdx
         dYOMvIhUMbSRDqxoiLaAI7pvPureGzSOIjFhNw2LXDqxuxctKdTNMP14bClGPSBPDGl4
         67Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134420; x=1795739220;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b9j9vXtfY+EbgPv2tG2SsfgvXGNMtTujxB5ZcN9bBcQ=;
        b=qCrKb/SYpqZNNhzhUJmPcis0uly3vEzCPeMhu6f4bSq/sp9ODhX0Wfw95F9Lk7Z4vn
         lZBJQizeC0AcXZNgu/LZPrisQaTG5qGwyNlpM2IfyXXZArRC2xFF5UPNqCQEIV1bCv+k
         6TCUadRI1RSg8CK8YvsqvZCX2bgMkmmJSkCMAkOCaejvcif2sERtjQsH7y+d0u5DKFVW
         tRyOTqJtSRZD67HsFmdbUrs7nM4NbQeukFmYIqWU+vg6HFPJuXWlAcCT+4nj9QI91pNV
         OX0PfjN9Kc97gNEXL2NqnJxZ772SqeaC3B7O3YRT4CtabfJXuTXxmIobMpqoExYX/VjX
         msUw==
X-Forwarded-Encrypted: i=1; AL+hErHClWz7mNpFJqedX9dyvagqk9ew3Hd+VaWAHMpj05UcJY3e7HqIHGF6CHk+Tox2M4QCVLNClN0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8J8KmTpe9X1wD+af1FL7d34fJNdYCeQlX9c9/7FwEA1fUu5Cif
	g4a5XR2wE6UvyijwQtLbSyoPc2QD21g7EvMJp86hPfV7w1NiFsjXBCnjaWVeT/SLmC5ZVYKWYNS
	W7/yglH5wqIBdtr6CUtCy4wK9O9Q95E0=
X-Gm-Gg: AZFdTZdvt7nBGt8ggWzoeTFHQQANCyvozYo3Hc0i3EpS77FZ++QnILgSKyvofUFA+yj
	zpbS0lGLV4mpz7W/AUEbwG0W0dxV/aesmyfePhmu1rz618gpFdDMrGfuanTXJ3vphivPd8rn6Zb
	p0hIpABtHDBgKq3grhReh4DyeMdLFTc9LX6He0TcKdqCGMbi9mGskCRBTkl480QLq25Y3x59aOy
	Qm/z5ZFq9Ef41XcXrFTUdE7+OFHKwr4gD5lowVDWfy9GipU3IodUwrjJGtXERBEWahBNUT3vXye
	6yHVe3zm3TD5YzidpHZOMtn3vuq/GnTLgiSn9hq/i0fwQjdiUyWyg5r1Of8Xxpsn98me2lkloRl
	Yd9iH/iVr8YwLUaVSIWxjyr4mLYxHiLMwm+3u7YQjEY3FGMeHE1MtMI+V3ksqzHiAJchWyQ==
X-Received: by 2002:a05:690e:11c6:b0:67c:4b5:d5ea with SMTP id
 956f58d0204a3-67df40d1b21mr504880d50.0.1795134419928; Thu, 19 Nov 2026
 16:26:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119232935.1708458-1-thiery.louis@gmail.com> <20261120001114.61077-1-brayniac@gmail.com>
In-Reply-To: <20261120001114.61077-1-brayniac@gmail.com>
From: Louis Thiery <thiery.louis@gmail.com>
Date: Thu, 19 Nov 2026 16:26:47 -0800
X-Gm-Features: AclHuK8HpDb3YGyRkewngiL9iq-G_WUfJKYzbVW6WD48cpmbOt2XettliD_eIU8
Message-ID: <CANox1RhDMiP2nQodMyf5KndjymFKCqgXLWRPf4kdwko2ifkCWA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/net: don't charge the folio offset to truesize
 for managed frags
To: Brian Martin <brayniac@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the corroboration, Brian. Been playing around with this for
a few months and missed your report from this morning. Happy to have
the Reported-by, Closes and Tested-by
added.
--Louis


On Thu, Nov 19, 2026 at 4:11=E2=80=AFPM Brian Martin <brayniac@gmail.com> w=
rote:
>
> On Thu, 19 Nov 2026 23:29:35 +0000, Louis Thiery wrote:
> > Only the in-page part of the offset matters for how much memory a
> > fragment ties up, so use offset_in_page().
>
> This is the change suggested in my report earlier today:
>
>   https://lore.kernel.org/io-uring/CAC+fX10wVVSqGnfCg+aazorsCxB34sUDV-XJi=
BPd6R3Kuqc-7Q@mail.gmail.com/
>
> I applied this patch to io_uring-7.4 (0659e44ce739) and ran the
> reproducer from that report. With it, SEND_ZC from a registered huge-page
> buffer is charged the same as SEND_ZC without one on every row, for
> hugetlb and THP, including 8192 for a send that crosses a page boundary.
> On the stock kernel the same run shows the overcharge.
>
> Jens, if you apply this, could you add:
>
> Reported-by: Brian Martin <brayniac@gmail.com>
> Closes: https://lore.kernel.org/io-uring/CAC+fX10wVVSqGnfCg+aazorsCxB34sU=
DV-XJiBPd6R3Kuqc-7Q@mail.gmail.com/
>
> Tested-by: Brian Martin <brayniac@gmail.com>
