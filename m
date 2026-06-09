Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E348B36F
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028492; cv=none; b=NxJkYu2AGsYTRJWMEZo5xnkyvdJaBu5piKqBJGgaPoTaVJQZV14PCkjFpLbOvoECuWh3KeLMJFYSfo/FdbLlE38Nu4c2FHZ8RmPnATwSaCRETQx4PN19Q87HTwuSiy1O92LYmxDrVesqIsa2cd8kuuBmu0ZezeZn71wcf7s1TwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028492; c=relaxed/simple;
	bh=Gv80fVqWANIxq7l0YC2ixWxD6mTMoOIRWTXH5qo9db8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T4L37jrjhbTW92X+s15AYg+LGuj7B84aPFUdSeJmrO4/txvihX0rNlRV7ZItbMINIweTRAVld3ytIpYktDjiCZm/B/TeIGrdUMxnNoADIQNkCLMhHs7jo1OcSdfgeggFAeNWHqBeX1JjcHw7mLPNY/OyIutGIxIE5nPq7FgcvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjfeRmBS; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjfeRmBS"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43f5927e70aso2395569fac.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781028488; x=1781633288; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv80fVqWANIxq7l0YC2ixWxD6mTMoOIRWTXH5qo9db8=;
        b=WjfeRmBScytQ3/XGA+uEp5gGleIrf9mA6YT9zXK5ifIv7kMi/Z0AFGO7A4W0Ix7MoK
         FhwZIDBwgitxzGvj+fCE2Aoc5QHrFwqoPV9cf26L0YrZuyekKLaqSf5gYBkThJFyxqIW
         9dd/km+20W/0SyYVWVcf2P+0R/NzZeCB74BstfCr1TA/csXIbH9Ly4i6cKzMgimx/9do
         ACgOsJgSPr1CiOjmbQWtG9cUIXsz4ofZ/BJhCzzPAn1lhULSsK9F/ZYy2luBJuzSIApH
         tpXA7gjpza5yaNmuW9dny/rhdI9xaX2MQmERyS6qmyNiNPx7i0kNmH3uROfpdxivv2Wv
         jQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028488; x=1781633288;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gv80fVqWANIxq7l0YC2ixWxD6mTMoOIRWTXH5qo9db8=;
        b=jRLX3S5qM7tdC0E/Dja9N53wkdhn7zIeZBwe2/wllV9dXQVZufv06pjKb3Ah93w9lA
         Tip+0/6Q5b2msKjQTle5OFmcUkW8HNZZdLj2UxDC+imt0FOpObU7T7kzh4z6ieqdgANY
         z+KkTLYnU6VJhwJYyVws6L37/eGfUUgSSRr2CGy4VtS53hLrrWsUTBXjzsOdfeiTdT8X
         5B6hpy6Pvr7OsiZ/x4K8D1RYfAAga/E9sqYkQIGQMrM5p43pHuFqdXgnyE9ODn50POds
         8Qv06prIjOebAZdoyA421k6/faERmusip9/3u1vz1F8h9GOScdbaLkMUG4pkvTOMsYCF
         TP1g==
X-Forwarded-Encrypted: i=1; AFNElJ+1fsU1FZ6rXYEop4p2KVIr/AaEQyUVN4DjqzmZgXMxZE0FKvqoL8T2gCnTbv0XQNZy26+T1w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQc13DiFHlFw0a9wjl6GF5VbFXgsll5WpfSjSK4Vh4UHQAdkTs
	yJuwRwnLqaUojuEbsClLslCie66fornuDp99WvAWfh0iFVqALn/c1Gm5
X-Gm-Gg: Acq92OG82PHaIArzHsJfbJly6QlIZ0wFvLd321Gvl6/XZp+TDH99OF50cyl//UfTUaf
	biObk3+mDaSLK3SKF6efmWjztBjXFWUExnL2qC6B+vgLsL2YMSwRiflruJxVB80YSPbCpEdJl1B
	neQTGZOpMt90Dk2+lWexG8B9fOT2JnohoVzTFSfR0ZEG5pxtGm8ZAeYj2MV0aX09iEEdnITvNra
	cD2RslnlFQBLRGEHLhFrTmyNQy5EwES4WuKOPXLwXK8vgu2znUkAdY2y5YMCq80sWwddAws8DYi
	/VoTSFAGarXVhvDAMk0EToAxTSkloo+5VNRWoxW8KBYt8SGQSezGGPhCDQFGN6wh2OM5Om+JAxj
	+BQ0JGpn5zJx9CvX1B5V0hByc711ptH2Ipy4Tu8oyLwpXiyUtlvMmHr6yoEzvsLoJyPBITsL3sE
	9hTDichhhmJ0Qy4JlOspoHcKy+u2DxJWWqA1QoDRmPtoSzsx9dXzUizCVGWFYCua35HodYNxy0E
	n0+CpKFcg8pgup+mrbiQJrLmM5F
X-Received: by 2002:a05:6870:c69d:b0:41c:3225:f98e with SMTP id 586e51a60fabf-4413d6b0988mr11892044fac.2.1781028488224;
        Tue, 09 Jun 2026 11:08:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8465e00sm16402950fac.15.2026.06.09.11.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 11:08:06 -0700
Message-Id: <DJ4PWNJMKALZ.DY46EM9P97GA@gmail.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] selftests/bpf: Add BTF repeated field count
 overflow test
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Paul Moses" <p@1g4.org>,
 <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org> <c51441fb2fa48d604818dffa59b7009f396fa0d3.camel@gmail.com>
In-Reply-To: <c51441fb2fa48d604818dffa59b7009f396fa0d3.camel@gmail.com>

On Tue Jun 9, 2026 at 9:47 AM PDT, Eduard Zingerman wrote:
> On Tue, 2026-06-09 at 11:37 +0000, Paul Moses wrote:
>> From 7129e266643883a4f83e65fce3ce20c7f7269fb3 Mon Sep 17 00:00:00 2001
>> From: Paul Moses <p@1g4.org>
>> Date: Tue, 9 Jun 2026 05:08:54 -0500
>> Subject: [PATCH bpf] selftests/bpf: Add BTF repeated field count overflo=
w test
>>=20
>> Add a raw BTF test that exercises repeated special-field expansion with =
a
>> large array count. The compact element layout keeps the array byte size
>> representable while the repeated field count overflows the old u32 capac=
ity
>> calculation in btf_repeat_fields().
>>=20
>> Signed-off-by: Paul Moses <p@1g4.org>
>> ---
>
> Note that this selftest is depending on a fix:
> https://lore.kernel.org/bpf/DJ4DWMO4HXCM.3NVLDGNT2704E@gmail.com/T/#t
> W/o the fix KASAN warning is reported when executing the test.
>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>

Pls resubmit both together.

pw-bot: cr

