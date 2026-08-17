Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695413D8907
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003919; cv=pass; b=FMsMePtqv0byVXEkZKWzhALk7RzDewCEvSX5jGMMoLIA0z5nfbGQ888teEJ91Dn15g/vw7C/bWp2+HpZV4hLNg+zjpe2AOft0EEVGmTZDIl4XQx8HUP1/z134IzZnKZL8HHH5KFcOI9utUG8WF6WQhRS2TLpRtjOZKhD0qAj8eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003919; c=relaxed/simple;
	bh=CEdKirEq2+Q+UOHNlHEHrgKgh5UZWOj3QauTHmy16Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CD1yBl6iqPbfLiIJYN7NdpWOIGPCcoMWltzCGcuHd3JVA5DpgoD+UGjdaqpQRDEiva7pStrO994V7x5Tt38PivnNrN5l7Sw/nDjdjceTiCCV7nuRHFt3A/y/HOAZfhdEl+G275rShqaz07MZc9OoWYvYJD4C3mL2szYqeuEvy7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5a8i5nq; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5a8i5nq"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1600d040e4so52579366b.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787003912; cv=none;
        d=google.com; s=arc-20260327;
        b=gMUG2Avm/LGeHPmELpuumlZkxRTbaX4peCt1AbpGs9LBNt1aN45C5708iBrIG4kg2i
         Vw52uT5Gr2ji6qHWzraHjKauUimx02ntn2EuI+p7i3RZXLutndeSfvJRASHbOJ13CSqO
         75P4TK3JvZ9B2mpPiVhouC252aeDAGqhfGnri7jVT265y3mFtYZTfZ0q+dp1FjGq+tgh
         Yh/ABtG73+XYCMucFMOp8KlrHvWcverILnw0PIoRbr/gW3AmKjjD14nbgnfIJiUHKENg
         noa68FSQ3EbuZEh03rBrOcV4/DcWZILd5SZEFrGSFAd/jf+JVcLcOgdiOOzWjNovpJJZ
         nPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=okaAU3zYOn1hyhzNcOWFnCkDHyrXnj6mHvmxdNYRJ3k=;
        fh=vgL3PVBOi2inONv6kzfWFQ79sTxIWbErj0iLJzNtllA=;
        b=DovQCh88sfirYaInBAyBGjRW+goNJy0FxdmYDAqENs3v928hErjGWaob1smzfsqxB9
         88s96VD5t3WdwaxdLyjzBxhhs5tpUE2Drw1mxGsd6JplBfgPe/JThaiOrssMJtkYCk4i
         jc+6aYy3a0TCbvsnKF0tt+WbSetFIdIprjOKeNvMrPWh5OicJeRiAZ0TQcbc4QRd023O
         TBWAy2Wj6h5mu5MDBjZ4NhMpx7FY7WuqD9LgXMwRZV/80i+s1OyAL8GW94K3FWSLueEp
         jSmfQXIqZ0zqlZu/MFZIZw5z1906gnyJuHlNR+DSVxlvXmxSRUMWnwRpitC9+JeLRDon
         qw2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787003912; x=1787608712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=okaAU3zYOn1hyhzNcOWFnCkDHyrXnj6mHvmxdNYRJ3k=;
        b=V5a8i5nqbuohWfohFrNLnVCVqqHkfdYAGiGmkIZtCysd1i38yFe7rxSqh2pc24GVys
         ft1L3A7r6buXXs24sCCU5JmqfDxXFhheFlR6zTkEBoVbmoH6BdSp2pYsJBBUpKwwJ/wE
         603gi/hqqu0KiMLgVP1qe1eDJw9UoRy09E9hK9rFJwS+YxiHB8zRG2/GV0KEUznz6jBQ
         /xYiWFOiyQlLS6pirLEQS4zEqiw51Fo7fWXclVzX89CusN2/CP6DqNDdbSrLCT7LNFjD
         KW+854O2KiPhqN95rHUGfB2B87qDBFWUBlvZrsUoCEOQ7Mw+ZLxSax9UuyDwT2h+hNwf
         ofhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003912; x=1787608712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okaAU3zYOn1hyhzNcOWFnCkDHyrXnj6mHvmxdNYRJ3k=;
        b=BcdN3GE4iuc6KzC8SFSUTikaqpahqd6hJIrdMlnsHkYACYrV6TE8utesSrRWe2Q55b
         /0Dfhz3SNKYMd9abj6RH/KZKdYws5RxgDNf1sjPsH+C4oOwlJf/7o03Up5ZfU+wMwM96
         /u9CoZ3Z6ZiRrt1deXr2q3wrn7VBYLGeI5POQOD03rWf2ApgXKd7VTv0rJOM7cOyMRFO
         emrrESWkybbTQW5p1W8FFHOWVIeuF1kLzjidriuvI0b3wr2FrjVKbN9dGhiLqfaSAnj1
         I4BAlh8PeSTEALdgTiY6TQdQc4f3WWwwsmakVJyxcE6nC2NtJOkjggRWLzo2UetAuyr2
         NOnA==
X-Forwarded-Encrypted: i=1; AHgh+RqizzTZAdgk1G1guxhd6lngmKo9zKchkA6tjTSoyc7AbsdhvXNgQIn3JCTaVGlrcR1xZ4d08x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd++ISGGkyfgl/N8npittFZhUBMMmgkwn2Z7ZNTdH1SQ4Smf1W
	cBLHJzY8UPSrKURwrlmjU0Szh7B54jz2geL7i+y6Voe6AB4n23u6uDIbWkEUcKAWvatDkHXzasY
	6hJnTs2/qjUx/BlYU8wEqShDaX+WtrjQVZG+PHj0R
X-Gm-Gg: AR+sD1240cOqt8lciM3bgHrsrUZlWMMU1c0m30QxYu+veWsBdnrTlPSIirkaRJcF/bf
	iH/l9QyDkBQ38/Xsr8zHdQJwdNgfzOe0KRsP3mbISKL93dzn3Hlktq+5KlxFJsxlqdDE7FyhS0Y
	qq7zTtJDpXiJIOrdrbqC7TDhXkinyIB0H1Jip7+OTsZK3V84ooAOMsPL2whkZV19WHKsmrOqMCO
	UtZgEuVmcSstqW2p0ncmWbuUOZu/wvHaz0+0mu08uejx3338OEQn+tG0cSucLX2qn87O6twlEvD
	W+AKvfZDCG3vqKYrjeBSDBbUIfaVpDqhlWJVlD4KdDpAfS8aOe4tUFGthk4awo988YmEGvhgLvS
	Rh1mJ8Hc3AqU48btBdgIuNXu2AuA7TkSOSaIpvuxkQ5l8Cu35trbLp6C7
X-Received: by 2002:a17:907:9446:b0:c0d:7c31:26a9 with SMTP id
 a640c23a62f3a-c218d9ba953mr40425566b.2.1787003911741; Mon, 17 Aug 2026
 14:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com> <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com> <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com> <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
 <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com> <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
 <12a46993-82a5-4109-87fa-61b8fcf764aa@yoavmoshe.com> <CABCJKufoQ0fX797M01t7CkTgMEwNCELY1=ptZsxr=jWOR-KAyA@mail.gmail.com>
 <CAKwvOdnaOy-nyZ=8oLw4N-_hA9JZVdP2BhR8cweCAOhsy4VG6w@mail.gmail.com> <91cb0f21-e78a-4931-b123-937c6a01592c@yoavmoshe.com>
In-Reply-To: <91cb0f21-e78a-4931-b123-937c6a01592c@yoavmoshe.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 17 Aug 2026 14:58:19 -0700
X-Gm-Features: AcwNN1VNo3n6QqxpiSk3WE0KBl-3YmOc0Qs-sAl-zs64L7Q39Eb5f5vg2HrwQ5Q
Message-ID: <CAKwvOdk-JmqjhZWBiLjXTxKhEV+T3BAB6An+3Ara8oybmhAMpA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 8:37=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> w=
rote:
>
> On 2026-07-24 10:49 PM, Nick Desaulniers wrote:
> > Yeah, Yo'av did you test further modifications that explicitly copy
> > the hash prefix? I assumed Nathan's change _plus some additional tweak
> > to copy not just imx6_suspend to OCRAM which I assume the code already
> > does, but I would imagine you need another change to copy
> > __kcfi_typeid_imx6_suspend into OCRAM just before the function.  Was
> > that tested?
> Yes, I tried that as well and it unfortunately didn't work.
>
> I tested Nathan's change along with explicitly copying the 4-byte
> prefix from before imx6_suspend into OCRAM right before calling fncpy().

Can you share that diff? I would have expected that to work. Perhaps a
minor mistake in your implementation?

> However, when checking the compiled binary, "&imx6_suspend - 4" just
> contained padding rather than the hash, so the copied 4-byte value
> didn't match what the call site expected.

How did you verify this? Can you share the command line invocations and out=
put?

>
> Yo'av



--=20
Thanks,
~Nick Desaulniers
