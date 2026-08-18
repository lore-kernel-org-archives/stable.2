Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C912BEC23
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058257; cv=pass; b=LN4Mswfh7x10LkEsbuWxsas0fx8olz8FfZWjzvR5BOrgM8hEvV4Vw3VxyZOz9DdFHP5yNlalCjAjEoEqZjbdkJMZZp+yZ6kkfevTb4g64BhDgb3ZwtvBt/UUHjm2T1KKqPu0y23a2INEOHMb/FISVM4+MebRdqQH6CIOm95qto8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058257; c=relaxed/simple;
	bh=ploCEruzMLrsvcFKJbusqZCgx+ZRPcCM4jxMdCl5+Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVTE3zNUc4JjxyAb2O3VkWgOuQ9xGkRYCoUplC7SxeDgu1WWyAGB8cYUnLXJL+U6z1vKUeIAg5hvJYUe3uYsN3xr0eZt8dg2iJfoeAWee3Jl1FffT6i1uL3bu+A+CQmaxdkd3NJiZNP90kDLOBQc3mEh6G+YkmU6+rIjAfH3fYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pH00YnMm; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pH00YnMm"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-936c02e58dfso294198785a.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787058255; cv=none;
        d=google.com; s=arc-20260327;
        b=IogaGV8K5Eeo8tMoWl1pMUlNRuRbRjUfq44u8B9rWuiAihdWGSZPKr3ALEOVk/hjf3
         t9Qu/vPS5vcF3fs52NHePUicAE5lzAr3deJM+EGC5OptIHBb8cwnyYY64hSqIZz+4uoh
         u4qiRA7CQVKir5bTgX/+BaQgiRhZz1pUIeC1F5bmGSO+gjG0vpbNZQFxiNncQFJPyd02
         KWhPJYlhfnGFf2eLe6KIw+09Up1ep8o1t9u1XXDX4jx9EkUVUp3/mYP6FxaDBG4UZhZY
         qCDDcwo42F6aq16oI+bWespixeMtG5elImXiGwR0Y2+ZGO8qZEJpfguYNtZ8clu6h9GS
         my3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wf9pJ19y5V3dewNhrrazrtHM/xSDMX1kzRQHqyjKLRs=;
        fh=wm8bMM3gFlnqCgUNm4pjveSfcfDVdJiNLF/1NytxXKg=;
        b=Im23du1g9ApEAs+1WkCW83qzv0ZScW1S2t3+qw0iHRDoStcU/MEfoqk1JAU0EJnvCq
         pitoyHpMGAIY84n0ZrzqTLDu9oeKnMA/BBGY7tID4CJaYtM9SbtRITThKxAI5hyqAIKr
         jSkd0y6noV8wDVT4V5O4rrFSO4s4ZXXSBx1qWvPNNzc0yqUgWnzV/0nNkipJ9+AIjsue
         T2OrhjcFAaKBoIO7WWZ/ZOZFz7ZQgGetyVL7TNXYxTdfRQTMQEqjNabRfq/ubi1ZEWM2
         UBpTHAzjBiMEtjXvGeM10oIUb8XflCjH7HrJIgQoVE6+42Y8N6xdTXxnS8rBJ8ueB02F
         TWGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787058255; x=1787663055; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wf9pJ19y5V3dewNhrrazrtHM/xSDMX1kzRQHqyjKLRs=;
        b=pH00YnMmfBuR1X+DvmHlh4U02osuCqMCd7MPtguq76h8bKNjxDbac9+ZMlryuCHkWk
         uAfp1L6njsMl1rpt5UB8ZjlHQgL6lJHNPlMoUvPB+W7/oCnAqR9cWIbDQvMJNbqO9aEf
         MmI3JqKC5qWqapzx+ZxkZCINSxctondw3DU3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058255; x=1787663055;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wf9pJ19y5V3dewNhrrazrtHM/xSDMX1kzRQHqyjKLRs=;
        b=lf7RO7NUwoEXr5pApOYy/WA9OBILeULHxlW98Vu0yHDFxDlzsepOSbnFameh3GhZUf
         NH70dhjLtwDoDCGZO5AYHW/CzR6Sxn5KUW2X1jGqtTLTo9Qm7ZisSWVmKGISj7nSdLwN
         WIuU5PAzN6oSJaRgo+rBFDhjeVrC5q9LCU0HvosC/kTFkGMjPBiObD8kMj5oR3eP3OFm
         VXI0/8g+azrBoZ2JItNwbCRJcWm9vOX4Ls6P0YuBf/sndr3KcudJQcyVhfburTu59/q9
         MluM3o3cZ7y22b8XhV5f3U9J6NsobzifmGzMcI+57qhmQ9v6SnF3oDmuncBaabk/J+3J
         gctQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrtjqca+AyNrKkXexKIuMj/ymx//fSW5d7hWMzbdEadqRsY8ojs6uLnYqkpHHT7vqS8hzbyiNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpffXbsL1klf8QSfh/8k/PnPD22VoEsI/6FgjVqwPPBZUqOwt
	IrlnyZXV7wze5HOeGryIHrR5ii0goZFC55HBzHPkGneMcGsU6zuFKkL2tpDPIXTRGvUGuaqFRJW
	vn41uhcVocWsYuIJA/tpETkJbgkymzm/aoMvpuwxfBA==
X-Gm-Gg: AR+sD11UIzO6QIt3w6WAhW0B7O0twXsL6E/Mk1cDKkGdRu89gb6h18H/sanCaOAv627
	cqcnlKTYNbEKsNJ1lZ17duiq4Q169jAx3Fq27VUjCEXryR68d3eDcrf0/9KISmQSUbiZBzA0pER
	BgxdRaCsdYTWhFAJSHsC27+Br0htl4sSmpgtMN/fjpJYc1ZXIugQpPGhy/e/YqsBPxBjavAHF+W
	ancQuLTO45NcVveM7I/1+8qnRoi9oNDc85D6PpZhEmoSFB8YOwojLOsMTWgy9wvy/xa7Y+BCOFW
	tC6cmDJ9ZtsOX3DD0WXA9JH1jmXayCEhIiohl5roTLBAs9e3cBZMOJKbbyw5sXQUqAzqwoFqY2u
	U
X-Received: by 2002:a05:620a:1793:b0:937:7ea:3421 with SMTP id
 af79cd13be357-93707ea37b5mr558245685a.26.1787058254552; Tue, 18 Aug 2026
 06:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731120353.558833-1-david.lee@trailofbits.com>
In-Reply-To: <20260731120353.558833-1-david.lee@trailofbits.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 15:04:02 +0200
X-Gm-Features: AcwNN1VGq915hcsob5kNsXXFds76SFj9nmfNmaFXNVfhjgc8ZfBiwmIN9uIVwNY
Message-ID: <CAJfpegt5g5j-OOQeLXH=z-7wMXn564iKWRiUtuD8z7Fpezg_7A@mail.gmail.com>
Subject: Re: [PATCH] fuse: wait for sync init request after abort
To: David Lee <david.lee@trailofbits.com>
Cc: Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jul 2026 at 14:03, David Lee <david.lee@trailofbits.com> wrote:
>
> After a fatal signal interrupts synchronous FUSE_INIT,
> request_wait_answer() aborts the channel and returns immediately.  If the
> request is in an FR_LOCKED reply-copy interval, fuse_chan_abort() leaves
> it for the writer to finish.  The synchronous caller can then free the
> fuse_init_args that owns the reply destination while the writer is still
> copying into it.
>
> Wait for fuse_request_end() after aborting the channel.  This keeps the
> synchronous caller's reply storage alive until any locked copy has
> finished, while preserving the fatal-signal abort behavior.
>
> Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
> Cc: stable@vger.kernel.org
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
>
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Thanks for the report and patch.

I've committed an equivalent fix to fuse.git #for-next:

64b0b5cacbd2 ("fuse: wait for FR_FINISHED on abort_on_kill to prevent
use-after-free")

Thanks,
Miklos
