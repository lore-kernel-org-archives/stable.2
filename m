Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6103F7874
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004966; cv=none; b=IFQv6MDoFTwzxzPJIJQ27TIQmhqjUam/7hKCfFippQHeVfaiGUu0coJG24gsWLE2KPuHJbNrUXvSOtw5ctYQNXB9/iihX2wTBiyWGZdzVtZA3M1j023UtXSHLGO8e/Lox6hvWTznQcL6bzeeEGsre4mcdkK8/yu71EIu3khSU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004966; c=relaxed/simple;
	bh=uPTGsqwqW72fV9uO1Q1bBszUUqt+DIw0cPITC9fmsxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYJpE9aO07nSKA/RCmtkdDirCKEAa8GAMXwhGVR8M2C1sCsOXnKWSVYM9vByO7AxLRN+LkoUkYgz+kBwygEzdtAJZJkpXm6PTYKHudOonnOSdOfsEY54eA1JimA5dJgRoYdv2szxXH3gWOvMnGEfHpErUQ1to2x7/8WEmyMIlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e65e18969so55600885a.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004964; x=1786609764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8L67UEittnM3U78kuIxDIhdFKAHMIN1W6YC5oHWi9ks=;
        b=czH01Y/SMsHXRLFnUT9M9YGrveG2YrhnFSHQWzJ3hxiN+iPfo6AjOOmou2gBdbEZtY
         zCQE+Rb0bxP49KY/82hxKuCCOECBIVrzLth24BHMi4PPRnK6qkEESok0g0TGD2ovaKGa
         gFPfsPbjNZWUzr7s1MPSrRSNj0Y5JSHkR94DvCu9R3ACnpcK7fq1UlyxzmRDLSTJ+pJP
         eKdz54eJnD2/NRbgmQrSGhLOq9knmvmbY2vFrPZtC62ryqgqv2wFGDjJpZeXfwcEEu88
         Wen8t8m/aYRQZaaQsvCNRWnbdm3BVbzZfnfS8oAPVxcb+2jyBWM7f1+7KpCKBORYi9Ua
         QuZQ==
X-Forwarded-Encrypted: i=1; AHgh+RprbSxktylEKct8qWe36GVmrCsPVGzFYR9M+Bw5WmmmIlc1lVNa8p0GaBXMOhxuaYlLphzPLSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCKv5eX1SjmIlvY6karaLJYUfS3fO/NrFxfA4uXVgU82TaJRw
	IORm5Gzxjys2z7m62ZHntDiCNnfbC8SIp8uSgvq9tgiTQLQ2VM8gF9paBv5axUmxQLVjh6hT
X-Gm-Gg: AR+sD10YvUS+E6DnbIn3W7F7bH/Ax+rGYgWNNSMPlW0eJBt7io+ZVJngX6F7QtDDVk7
	CQu3FLqNY6tUFtefTkhoCMAgfHqlmwChwJjwaDIBLSG4q+wk6gg/mpjHvYQfNH7anhjYVKXqsaA
	Yc1EIE/t0VcqW+0gG4kKJ1W55XoWbo7ZW/erLI0tdniMfgYYB+HKeDhI2N5Af1UA9HyxbkJY25c
	nSuYYajBVk4II2oI9K5f3VWf0U4y8b/pn+AMhP9z4qkeppSOPW+AiynjeHglXUdp4qAIc1acED4
	tQVec+McXNUUEMsVKhYrRjFyDIOvYAZ6KDDh+KKrF4D2Q5YJSCa93NggDLILWEOzhCGaelPs+ro
	kW3WKMYSSlwHQJtCjJbGuyTFqUP8GS4un9nD/acDEG/7SuicPZp6Sd25mMIG0bQ7x8ju1EJ3VKE
	h8Do1h92huncDHqECQnHThANgL/xkixp/Gt2v0fMeJHlefrSHjSAWwA2WTkZLWHa5I+pYnuIymH
	jxLmnx40j9rWDkzWi3M
X-Received: by 2002:a05:620a:4442:b0:92e:e467:7f93 with SMTP id af79cd13be357-9365df32972mr225849085a.14.1786004963550;
        Thu, 06 Aug 2026 01:29:23 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9365ef833edsm79705885a.3.2026.08.06.01.29.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 01:29:22 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0cea8883so5803471cf.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:29:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpNsv2n7ZclSdfjXoBa94Z3u8feUX5CJ3AwhypAKjl1cYgMF3uwGoRxAXD3BTMLsUM6G7U5oE0=@vger.kernel.org
X-Received: by 2002:a05:622a:4d86:b0:51c:b91a:33f9 with SMTP id
 d75a77b69052e-52cfb00255dmr55127701cf.13.1786004962328; Thu, 06 Aug 2026
 01:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720201057.1862857-1-kbusch@meta.com> <20260720201057.1862857-6-kbusch@meta.com>
 <anMscoGkR5BYjSGy@shinmob> <anQ-28nxOqBmQjxu@shinmob>
In-Reply-To: <anQ-28nxOqBmQjxu@shinmob>
From: 0wnerD1ed <l7z@0b1t.tech>
Date: Thu, 6 Aug 2026 16:29:10 +0800
X-Gmail-Original-Message-ID: <CAKTh27_RnTA_Q8qAbQ60gBo9Op_OQm7J8KyamQ_tbuTRb4XF2w@mail.gmail.com>
X-Gm-Features: AUfX_mw5QWwwkKt-kO8BytpUZdN-dhibuCeCRe8GGvMpBbYSL4fmaxKXk8xK3Mc
Message-ID: <CAKTh27_RnTA_Q8qAbQ60gBo9Op_OQm7J8KyamQ_tbuTRb4XF2w@mail.gmail.com>
Subject: Re: [PATCH RESEND 5/5] block: validate user space vectors during extraction
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, hch@lst.de, 
	axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org, 
	viro@zeniv.linux.org.uk, Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org, 
	Hannes Reinecke <hare@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Aug 06, 2026 / 16:04, Shin'ichiro Kawasaki wrote:
> I took a closer look. I modified the test case to respect the dma alignment [*],
> and now the test case passes. This approach looks working. Will post the change
> as a formal patch for review.

Sorry for the slow reply, I have been busy lately.

Thanks for chasing this down. The test is mine and its assumption is
wrong, not the kernel, src/bio-full-trim puts the destination at
p + page_size - 1, and null_blk advertises dma_alignment = 1 since
commit 3451cf34f51b ("null_blk: allow byte aligned memory offsets"),
so iov_iter_extract_bvecs() now rejects that odd address before
anything is extracted and bio_iov_iter_align_down() is never reached.
That restores the behaviour we had until 5ff3f74e145a ("block:
simplify direct io validity check"), so the test is what has to
respect dma_alignment. Your approach is the right one.

One problem in the trial patch, the guard has to be against the
logical block size, not the page size. What the test needs is a
fragment that bio_iov_iter_align_down() removes completely, i.e. one
smaller than the block size, and the read has to reach the PROT_NONE
page. With dma_alignment = 511 and a 512 byte block size (the block
layer default for drivers that do not set dma_alignment),
dma_aligned_offset becomes 512, which is below page_size and passes
the check, but the read then lies entirely within the first page,
succeeds, and the helper reports

      pread returned 512 (errno 0)

instead of taking the "unexpected dma_alignment" exit. block/045 only
uses null_blk so this cannot bite today, but the check does not do
what it intends. block_size comes from BLKSSZGET, so it also has to
move below that ioctl:

      if (dma_aligned_offset >= block_size)
              errx(EXIT_FAILURE,
                   "unexpected dma_alignment %u for block size %u",
                   dma_alignment, block_size);

While there, err() should be errx(), errno is not meaningful at that
point.

I am short on time at the moment, so please go ahead with the formal
posting. I will send a Tested-by once I get a chance to run it.

Regards,

0wnerD1ed
l7z@0b1t.tech
