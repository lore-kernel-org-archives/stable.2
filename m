Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793206722;
	b=HEo/WVumpkIwOuT/Q7x3eU3SGzRyxF2eIo0Ftalw6pr+RosJXuVxePg2l/5fapjZP3bF
	 j2YAhhJNXwj/nC4vpPVk+Wk419jWMl4g8xFTrrTtltrKDaZEZj8eTByNaVnU9aYlGsaYB
	 nZRb/t3zr7bjJIPricHvMOwshhiB0mamH8BVkpojPUsil8BjgZK0MvXeJsDWk0yeRrTJz
	 261sdvS9ZusoLElDM2BZ7D31iTQMH4UaLQZDpFxxbsMrvzvSUCHURwtU95ug84vyBOdnL
	 TUWPPaxZgJvipTQZOi5HK/EVDMymHFlUniezZ1AbsOsxZXOctO39cPKGSCMdda5li4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ofD1f6oQnTuXn5+ZWN9fgQFsKj7OpffaK+7o/04+4t4=;
	b=Y7419SygeJK7yjJDumEQNJ9FHjLINB3+bMiC9LZ0DPImNbmKWs5heLQae5spaoD/d2DV
	 0j3gvd4ZCeuOUcyYu0IY2Gf6R0+uqlr7Ebbbs2HFewLISz62F4JIcB8KjLM/BKt2+sX7p
	 9DaCH9odhw3fpCT+D/6wlr/f+LLhsI0e7SbizgZUzOTBqR/Au/MsGumi1QJpC9xxxvMXw
	 M3o2jk1goeJ888FXJcnL3GoEnG+0GafO0zftiym39GGpF3By8e6W97Fei5ZAunR3RWaxY
	 1C3UOiJZm1xVdRv0fAKYU4knDpEi8cea3UDq4hCOqry0JASOUmMso8Zs+9LqM2dp/WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D9606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so11773955e9.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793206710; cv=none;
        d=google.com; s=arc-20260327;
        b=Kfz6bLSyp2E00I3FCfRoyjcaIH41TdS/p07E3N7NKlXEQd0r1clfdeHPBgPztvCsu/
         yGzkjxnphaBNch8eCjeHfhFOTQ5gJMgfbnR9ZtRYfGpPEvqohoHnrKr6Jt96JKDTMC5F
         FA9lBSRTTCz1EdzO3L2W5UwkUfnbFpAI9eFHT4QqNTGihLjqY3kM+EKoBACzU5beaQe4
         xD3Rkk3WAy3Fk/eTPSzv5BW1oeLJSwWEDiy1ENSMo6mMMYH+xP810SQrDIE+EqdagLHS
         1yL1FCYKHpq4o+JGv3z+e8YXElNSIfPV0LJnl6Y69T/XbWJSBGs9EMkrjVQPx05qktGX
         ZEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ofD1f6oQnTuXn5+ZWN9fgQFsKj7OpffaK+7o/04+4t4=;
        fh=uBt9WNha9zUCBQPNjijyBReRuB/lLSJOacHorYuAqtY=;
        b=CQeXvPkFdb1CIAP0ELRPJL1FTI6pA6dStP4wUi50GORiXv/4ocjfdQ8O2eMg47Pzz/
         w3Vaik1VtCGiHRpOP7eEFIsWTetV95S45HEBwaEJi5ek3sLEKZMdlAEuBk25oiXHfDYl
         p7TV8VTwv9QxwelnzhJayBIfKX+zYtyUhe/5wYIZBsFd7utB35aGAz9674dYvNd0dXuf
         QuddxYRVzICh/l50KAGzlltSybcr30MRYdyOGQYHWFhLN5TuY1aMTw0rkiPVD7W2AlPb
         /zAXRemAbnaNnWWMjPyr7E1Y7lQFgCqH1P+yySnL1YmbipIiScW5i5JspdGlj7/yBjJd
         Lzug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1793206710; x=1793811510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ofD1f6oQnTuXn5+ZWN9fgQFsKj7OpffaK+7o/04+4t4=;
        b=fZvoaGfst6ORdRvAXEl6UJOkgc+9JvviynvCVVu/XF3BDJg3hzeWOZGaWUWgEmv6ql
         kJvYmnb+wzZaLWgaXotDJ7M3Okfv8MuER0P4BLUeyutUCTXG0Y2H42G9AkT3S+xQNLs4
         KkOUHVA4dXY5OXy0YyiyFsgq/mFXkACYV4vXRkyLnN4za0ODXIatIi/0Yo4vw9+3Ydeu
         8sxwR6/PF1FMbOQJyw8M9hp1GDN/JvmW0EBr3svYt7Pr0LRnFDBkUQ+lK8Og7+4U5Oex
         C5scxx8MHV1T060uR79AwebwXajsa24r9e95x80McgDfwf0OV1X3DJOUeEZqZNB1d9OO
         ngCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206710; x=1793811510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofD1f6oQnTuXn5+ZWN9fgQFsKj7OpffaK+7o/04+4t4=;
        b=Q/zVaYiDXPglwC8e+MjpZR0QR5xMvN6BOQK/DBdWy2ecCPQ/Qigp9MjrxMs7ITKZt1
         eQHeH7MaJE1jLSvMaNU7oLK80BwwyVvRAB0xUz0GJvqh67TGZHGjrRvg2PlDsFN/x6QF
         3B1SWFQ+KHoG1gJNKezWeTlV9fZsuSLPcIMJYQuRSx6oA0KhmgoXwz5KMUm3b3yYW3Du
         5G19cAHGDP21+135IEpLY+Lz1im67LKViiK7MzYVJRORFaeZBu7pPlKKMulUWSS5fqxM
         rx39NeiJfNwXN3AXCwe9+4QHpPLNLRivibCqTpNYAdnuVidbw/KX+m68GDhSfyEmWqHs
         QV9Q==
X-Forwarded-Encrypted: i=1; AKwUvByG5xj4UuJCyu7x2Yp/PJtZeBXF8kL8vc95roSth3pI70KUB2xPtHLVmd8A3e7mYfLkfEINzp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4gectzNnoVirHBmZge64GBrMoOKaNVCZzoEl73b8KKBVSsDam
	sJbiPD+N6rWUC1y4pqLqp3EpntmAOtJ83q4IG4KM9ddIjII7R7kKxPxnWMvxQbIHPkJ0ISxR8C6
	xHah4rPtktDiKV1kdgYY7KXqkwEYJI3LiM84ywuSGxClintTF78Pk
X-Gm-Gg: AYBFou25cTomHX8PUL91cudyInX0WWlJZ6z08cxXFzkgOn4PrxOjXl5+ytRQDsYEXyX
	9YtyaLG4+fx+O9RKY+SSn+KwJfZamUS139ptSBT3s6Jb5PxxYLk9CM3GDqSd4ew0PJjyn61dnT4
	MTJLkiWCrfcyj71vsfAMPmLIjhx2eqV8Au9tlz7Ii5/zBNUHQhK9A4X9bszOjJ6BdMlyvlV3WMS
	keVa/o9iEZbrsuE21J5bde7gTA7lpx8Mw5vMfTtOJmRWEYnScIiR+xH402wrcm3o5VNKIgxQOUI
	3P/c6VkNBOODgaXEk9YWepoFBj00+DLTazqFX+tCxKsFy1/XhjLB3YaIJUDhdEkjsAcMkdO4Rxa
	RoJ7ksIGvw/eGV1GOEh41gmIOWQW8+a+J44/BwrcRgoZJCxgUocLIwtiL2xCHEFnclnw1M218gY
	Ku3O1QXOOQaiLZMGA8Br8QTYZ7COqoVhsGJDSDUWxXUpq1Tw==
X-Received: by 2002:a05:600c:4445:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4aa83e0adefmr4884485e9.0.1793206710235; Wed, 28 Oct 2026
 09:58:30 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021032443.44412-4-shubham@octane.security>
 <179290103732.3134.18298634182061634234@kernel.org> <20261028164349.GA257209@horms.kernel.org>
In-Reply-To: <20261028164349.GA257209@horms.kernel.org>
From: Shubham Antil <shubham@octane.security>
Date: Wed, 28 Oct 2026 22:28:19 +0530
X-Gm-Features: AclHuK8HPth5FoQdhYFleU3o7yVQURAnBdI4t3AFjYlVmMJjxx-cf02cRxHSgng
Message-ID: <CAEBzjKGrrBhOJM01D18AURz=0m6uOe+G6fpXZzc11h4ui_MqwQ@mail.gmail.com>
Subject: Re: [PATCH net v6 3/6] nfc: nci: uart: quiesce callbacks during teardown
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, david@ixit.cz, 
	oe-linux-nfc@lists.linux.dev, gio@octane.security, stable@vger.kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

I am still looking into these issues and will keep you updated.

Regards,
Shubham Antil

On Wed, Oct 28, 2026 at 10:13=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Sun, Oct 25, 2026 at 04:03:57AM +0000, netdev-bot+sashiko@kernel.org w=
rote:
> > Thank you for your contribution! Sashiko AI review found 3 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 (3) =C2=B7 Medium: 2 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
>
> Hi Shubham,
>
> The text above requests a response to this email, and similar ones sent
> for other patches of this patch-set. And I would appreciate it if you cou=
ld
> provide such responses.
>
> FWIIW, the Medium issue immediately below is of most concern to me.
>
> >
> > - [Medium] When nci_uart_tty_close() tears down an NCI UART whose NCI
> >   device is up, the NFC controller (NFCC) is left running in whatever R=
F=E2=80=A6
> > - [Medium] Baseline decision: fixed later in the series.
> > - [Low] Baseline decision: not a bug in practice.
> >
> > Pre-existing issues:
> > - [High] Pre-existing problem, not introduced by this patch: during a
> >   Marvell firmware download, the UART peer (NFCC) controls a 16-bit=E2=
=80=A6
> > - [High] Pre-existing problem, not introduced by this patch: the Marvel=
l
> >   firmware download copies from the firmware image at a peer-advanced=
=E2=80=A6
> > - [High] Baseline decision: pre-existing and fixed later in the series.
> >
> > --
>
> ...
