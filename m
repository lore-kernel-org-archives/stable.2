Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792698082;
	b=uNxBc0JbV+Xz0meRocKt8iLDl2oParE2Ikq7iAGWxU+ZZ1H83McUH9HNHesgfVdYTYcz
	 mPUbKY8+MyGaI8JDecDGNh4m3b71Yc/1FCGXK1eDFRomvYzNpLaKCZs6BYgc0K3M/3rKL
	 7diKMd+U0tiBktOpFDIGz5DZQ+vofv9niZ5qcvD6xrkWyS7XiD1mdYWXtKJ3vGv2Eov+C
	 M3v4AJLSui/vI/oruiKh4bAzOrtxLFDbvgtDrwIDjzgah7S/SD5dSFxwyZpAkSGdiaqJk
	 67DqmdhPIlkyrXdMAyXFdtoWjunCbzZBde3otXBOUpwlWzXQZar8zrfls8nSv3bKQFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/uPf7O7mV3UVcLoPpg1h7SlQrq05lwr9QUgDlZZcEx4=;
	b=JHDeMzPHn85ObAqnLg47QD2KyXynybalmvpu0JEvFVtkI7iVcAwMmO5ZLhzbIz/uoxHc
	 eNmHL+UtEhb6Nhy3HyFax9UYpEdCtmm7nErfxY52NKH1SjDcRtWGmfIl9NHe1ZL/O/6v6
	 gCTHhtTdUU3+A2MhgGUW48DAVV/mqvnUEv/1PVdHU9+w2mHHL/7w1qojVZuH6QVOfMfAB
	 y0inI+K5vIki0LIgnHbiKZWDpC2+oViJ65kNf3RPaWEVICEUE8mtNlFSeBxcUORgO8/sP
	 5jjepgpvHkFRXgHk/2tTLcVYwF4z1pApAkd9lgEhyl3qx5uhU8MrZ+iUrpPmtiawbwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eGuW2GMh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3B606A327
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD3B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eGuW2GMh
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93ece7a73b9so14461685a.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792698080; cv=none;
        d=google.com; s=arc-20260327;
        b=paZz6vnInQosQlqMzZf639UE7EpmszeW2vFUbzOeJR7jjmFJDMT/YTKyw5Jtte3W5W
         qJEnHDSPCZhdr38FjPbUmvF0eiM9ySdmQzGG/huvD8BZ3e3FDZJoZhZskhBiejjefFqJ
         M1PzlZCm7Wf3Hvj0LYKUsCT0pa6MrtUJRffOk4XQa93KufmSlIeAFkb8/RZNLmZCIf1q
         28GZ7KVIoK9T3PbMJY86emT3p7Vd9uMWNvpZrBPEVDIRZfw9ktt0sHdn+7kgK7KO3Mui
         sEKieS8I8fW1kp7Okk/lYP0yS4XKLnamvUADHm2NFJNa+Jz6fPigVcmbYkDCqqz0/V3b
         F+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/uPf7O7mV3UVcLoPpg1h7SlQrq05lwr9QUgDlZZcEx4=;
        fh=ow28x52RfkXoC0l29PE8EREFBbRovHPc7i1DG34VicE=;
        b=fcuzs8/D6DyQ/yTGjUmuh70yPirl9+evrx5+yhpum4V7crLaZmdPHjvPGVihasBuQK
         PILUU3kT9xUEVGwMABig6w8vh0oqaYtSvTaRTSpxeBXT9jwmz3MaZA8mlBBYQAI45dY5
         QmXzAAK7rcGOxSC8b68gQju4fSiwiDpzjRNNQt1vVFCK1bysN4DKedJ2dyCA42RK0a9Q
         ETYpL/PgzbD6nwVf7eWkYguOCWeAdq6Qx4LDnKhBCABG1Irx/Mks7OveeBWCTGYawo39
         vS9hI7menI0zK/yMgX9QgOtejNEc9LWML3lfNK9cAsyN7yfWHgjm8r+UZbD/F+S3JaZA
         Ftdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792698080; x=1793302880; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/uPf7O7mV3UVcLoPpg1h7SlQrq05lwr9QUgDlZZcEx4=;
        b=eGuW2GMhQSUXWyk5IeInmdud2HJMQfOnVPXJmOeMh6VxFknNuNoa+qkDlXNZeYEkHh
         GihGP4ebcfdPfN4VzbHut5Yjoa6IcOBeMy9rnplGsEWi9IuRHabuVA7BBjEyG75zGxKY
         ELkZwKuLUwjWElR8OJSrpVhetC5zDhZsJ3kOQf8gEdEsM9T/Ubax3hCr6oCIkXp/jDBR
         6DMtOBdOyD6Z6vKAMC++ATPdyDAAsFGJAcRengfX9XrZfxpmTXMeJA4bnOXXgeSmAbTy
         ANdKXuIkPnv4E6ycQtPA7DstjA5ZpLHYHAOWY45xmxWGB8saWofUe8lrvcSH5cSwZlDz
         +4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792698080; x=1793302880;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/uPf7O7mV3UVcLoPpg1h7SlQrq05lwr9QUgDlZZcEx4=;
        b=1cFtEenP3Ni20hDCxEtP6CIpwfFBA7D/vjRiNtvVe2b5MFFgrtTGY35nrJRH6a82qE
         /i0TfzrsYq/gqKKpUkBiQT1WWHAc840uTT8KJXRV/9enKmw8gvuI25I5g0iQ53oHmsjW
         CKIp0dH9MXp1rGjRQSavXtjFUnBmkF9Q1R0SvVxPFwm65CdlJkT0j2C+mDR41YU1Y1/z
         zbjC2/NUlIKXGONSmm/zzdqSvXyrd0LFNV/jfOi1nWORhhmqsO9YTPP0hxlwLMfvjg1f
         yEkna8QqOjvw9IuI65RGRdeulj5B/CNdgwe/BM1I7japO1ljWwzK2FvIGflbLT4KGtG1
         hRNA==
X-Forwarded-Encrypted: i=1; AKwUvBxR+SWCUlZuPmzruwGFs7aFhda8HSmrVzFRyxECWuZYoxZYzvL/f4sOdPNpDiy/p+IL4oBIAHU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCiwhdtYLAkECkrxIDpkBGiE0iYHDB4q/yPZh2tVCzA4bLSVcU
	nHPpF9/rzUoUd0Sd3CUnhQ7zUDcnAU23WOTM3f7QtXpOBJ3AmVzkMXu3nkTL5i2uhr8ZCdQZzsP
	RYdOq0Ey1XNpDGxyFgNvX6/anlDGkK3voKwrOZ1U=
X-Gm-Gg: AYBFou1BoJXNcNdYz1WqlvHIYaSqgCgiiCrn32wBqaRjvHuw1FPJZSTs4VBxqMEBUAU
	vVF0WNCMRvhilyvu7isc50oJMo+HfZh7A4lDUqCg2kT2L+3ErQ5gXGzI8v+8prfjmEsu+FGSL2z
	1xXDbkiLHT0SVxy/iRuUxbFa8NKM3lWYkXsFWz6IQIBsVqhynLiQrey9UPjc2iHTHUuMhihvued
	XC9PAhNmkd9kijULCDeNJc8dOTtgB07qW77657571kh3lrDWm3T7FeYyQubr580yEbfaai+McRx
	UXkO++J/k2uLnCx5b85ZdsEZFdSgsTPtpeWEdXIW8p/dLObep/tNp52uCN0UkoFuQCM1Xei99Qp
	W3hL/6IddR57ifEQLJehZZ/4mqhJROsN16jVKnOPHqqoLONwd0/r4y0uf0GAnL/dVmRl3+70Q+c
	QNSkoUoHJhe5f4bSo=
X-Received: by 2002:a05:620a:7001:b0:939:b057:daf2 with SMTP id
 af79cd13be357-93f6f7fef1amr89402385a.45.1792698080536; Thu, 22 Oct 2026
 12:41:20 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022033638.32460-1-thatsme.saurav@gmail.com> <16d56f7b-6295-4ac8-b0c9-8b490dd0d582@leemhuis.info>
In-Reply-To: <16d56f7b-6295-4ac8-b0c9-8b490dd0d582@leemhuis.info>
From: saurav kumar <thatsme.saurav@gmail.com>
Date: Thu, 22 Oct 2026 15:41:08 -0400
X-Gm-Features: AclHuK8DakwZw0LIt6ofHcRsAHS0pyqF6XCOnFZsjF1b3JyRhz1B6T7MRSrjzRc
Message-ID: <CAHmbrkmPc5+NrKUn-Bfi6_U4nxYNsUZe0xFNackUS3v2rbWJjQ@mail.gmail.com>
Subject: Re: [REGRESSION] i2c: qcom-geni: HID keyboard fails reset on x1e80100
 (Yoga Slim 7x) since 7.2.9
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Tested 8cb5c17be3a2 ("i2c: qcom-geni: Restore the source-clock
selection policy") on top of 7.2.11 on the Lenovo Yoga Slim 7x
(x1e80100); internal keyboard works again after reboot.

Tested-by: Saurav <thatsme.saurav@gmail.com>

#regzbot fix: 8cb5c17be3a2

On Thu, 22 Oct 2026 at 01:44, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 10/22/26 05:36, Saurav wrote:
> > Since 7.2.9, the internal keyboard on the Lenovo Yoga Slim 7x
> > (x1e80100) no longer works. 7.2.8 is fine. 7.2.11 still ships the
> > same i2c-qcom-geni.c as 7.2.9, so I expect it is affected too.
> >
> > The keyboard is a HID-over-I2C device on i2c0 (i2c@b80000, 400 kHz),
> > address 0x3a, VID:PID 048D:8987, IRQ tlmm 67. On 7.2.9 it fails with:
> >
> >   i2c_hid_of 1-003a: device did not ack reset within 1000 ms
>
> Searching for this error msg on lore found a change that fixes such an
> error on Lenovo Yoga Slim 7x Gen 11: 39e8e085710a2d ("HID: i2c-hid: add
> reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard")
>
> Could you try if it helps? The stable team plans to pick this up for
> 6.18 already, so your feedback might speed things up (and get this into
> 7.2 before it's EOL, too):
>
> https://lore.kernel.org/all/20261019135441.1420968-216-sashal@kernel.org/
>
> Ciao, Thorsten
> > The touchpad on the same bus (0x2c, hid-descr-addr 0x20) keeps
> > working. A USB keyboard works as normal.
> >
> > If I build 7.2.9 with drivers/i2c/busses/i2c-qcom-geni.c taken from
> > 7.2.8 and change nothing else, the keyboard works again. So the
> > regression is in that file.
> >
> > Five commits touched that file between v7.2.8 and v7.2.9:
> >
> >   82339215fc00 i2c: qcom-geni: release DMA channels on probe error
> >                (upstream 268aacb2e2a5)
> >   139efdb3ee6e i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
> >                (upstream cb97bf3d4f91)
> >   6c3420d6ba34 i2c: qcom-geni: Store of_device_id data in driver private struct
> >                (upstream 692e0c84db5f, Stable-dep-of cb97bf3d4f91)
> >   4edab037132b i2c: qcom-geni: Move resource initialization to separate function
> >                (upstream ed4b34033db2, Stable-dep-of cb97bf3d4f91)
> >   fb54df3645d8 i2c: qcom-geni: Isolate serial engine setup
> >                (upstream d8d3bb127ad1, Stable-dep-of cb97bf3d4f91)
> >
> > I have not bisected within this series. My main suspect is
> > cb97bf3d4f91.
> >
> > #regzbot introduced: cb97bf3d4f91
> >
> > 7.2.8 always wrote 0 to SE_GENI_CLK_SEL in qcom_geni_i2c_conf().
> > With cb97bf3d4f91, geni_i2c_clk_map_idx() uses
> > geni_se_clk_freq_match() to find the index for 32 MHz or 19.2 MHz,
> > stores it in clk_idx, and qcom_geni_i2c_conf() writes that index to
> > SE_GENI_CLK_SEL.
> >
> > On x1e80100 the QUP SE clocks are registered as DFS RCGs
> > (gcc_dfs_clocks[] in gcc-x1e80100.c). geni_se_clk_tbl_get() builds
> > its table from clk_round_rate(), so the table comes out in ascending
> > rate order. I suspect that index does not always match the hardware
> > DFS perf level that firmware set up on this machine, where index 0
> > happened to be correct. If so, the engine runs from a different
> > source clock than the SCL counters were computed for. I have not
> > confirmed this yet. So far I have only shown that the 7.2.8 file
> > fixes it.
> >
> > I have not tested mainline yet.
> >
> > System:
> >   Machine:  Lenovo Yoga Slim 7 14Q8X9 (83ED)
> >   SoC:      Snapdragon X Elite, x1e80100
> >   BIOS:     NHCN62WW
> >   DT:       x1e80100-lenovo-yoga-slim7x.dtb (in-tree)
> >   Kernel:   gentoo-sources 7.2.9 (genpatches do not touch this driver)
> >   Good:     7.2.8
> >   Bad:      7.2.9
> >
> > I can test patches or run more debugging if useful.
> >
> > Thanks,
> > Saurav
> >
> > --
> > Drafted by Claude.
>
