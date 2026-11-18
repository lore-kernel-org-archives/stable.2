Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019984;
	b=iAoIKLxwl0PSs+Zdhhs0lEH434R/4wAM56hRJEo0wExu60+Ko2zL2zkMXreTJBkqYNp4
	 /Y+1B3RVacBx+iqgOwf+IXmJ2dT3gFtj/dImeurYdjhunvVbw1eqrG5MtZYe32tGh2WDS
	 80TwTyYvIZrjh6HtTK9NcDFEyAJ//ucXi7Do26wAUZO8a4bheMs5fUVM//xU9RB24fYFc
	 OmllA5nW5U54AWMvlHu27BPxJlxCcEgdXvCaG7EVGkfs1LVjDnBcMUzUSV5OXkv2LbBQa
	 2YPeKvf3D8481OBGwtL6hs1e2z8grANiFhZOkn7TfdGS1Ch8gWKU3i13GMrIcsSd0pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=y0TMrCzbGMAXa1cTU4qckddvOIHma2PxgVYHTYEMX2w=;
	b=zJg0fkHlvr/zuXwouJDJ8VangVsC/ma66eNZJcn7hqA2U8MbR7yHSrBEXnEXRLjhD90k
	 c6r6I4QdkcrMDUG72YQArHKBDgl0cFQVy3eE9gQm3fDryJVOPT5ZJXkmycXFnY85tpoTM
	 EO9aXdahcNa14H4Stf1unkWH+fIHHkwBOuN45Fb92F5SDr3I80WXXgC9vwlbuB8h9XilZ
	 t37iSdTerWOg3Z73JmShdHGC/MUHz0o6Bgb8uax6XiTIU/zfzzdwBPnOxnFwsBxr6MzzL
	 91Wr4pYWNy/8ma39w5F/+GHN5hu0MpJ2SkD7q/WP8amxkvcIsDuotYqzgXtVUbCsJbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=CvdgewD9;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB53606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FB53606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=CvdgewD9
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso1733a12.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795019983; x=1795624783; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y0TMrCzbGMAXa1cTU4qckddvOIHma2PxgVYHTYEMX2w=;
        b=CvdgewD9cRAYlUY2D7eJ5rsBhzbflbaP9q6WplNlDPxXo0EJ0uTXZjlEcha5xX/cWl
         D9hq2RB42YueQv5m8YegdBlAkCZeC2wnNL6RJEmPpZhNn9BXseuW6y1UTBNolzBcBjnl
         HathacXpqLzQqr76pKjyCPpBxk0TEsuKB0cxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019983; x=1795624783;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y0TMrCzbGMAXa1cTU4qckddvOIHma2PxgVYHTYEMX2w=;
        b=sW7eG1Ln83F06ZWGQkWqD2W417tBzlmhjpUDJ23hpW6iGAcB/kGa87bhQgmh5oWsAO
         ZYLzkKw/ZKqKnybxsY2frIcwvvO117cIpf7e2rzebJelWO5DEyvjjrBTOMRBB5kl2ZEy
         4v8ckDVCwUqClE7htKPhhbrIFepTTDZ6uZKwQanRP5MPfkBSrBiakvldtne//faN8u7h
         /IU874sGz9WzdhZuQipy6Nqsxpw9/lDE6tVmFCFQzvGzsnnHeGYGEq2ncRNXUKly5CaJ
         j73BbcwivlDs9CeNY724Q/UmHNZ+jmsEUvL+hcb4kLgQO6SpaM08UvioNLVhgAPESsFr
         Dn3Q==
X-Forwarded-Encrypted: i=1; AL+hErHf1FYS0EaoLffAHa11taG0w79Wh/DBcmGoMF4Q2qnQhy+HaBU8P5n6QOgWRej/urf1EnG8e44=@vger.kernel.org
X-Gm-Message-State: APuU4Z94cQnvRXWm1nv/K2TBvOkgSeLK2llVg6FBLxmJynFrxsik+IHw
	+Y/nU+cKcRuLpj8IEkfqiCxLjXtTDOU9E2nadjf1D2oESGDo158U4Nhc5LkthVb4OJPgrnyUyNJ
	1KBXv3P/9Xg==
X-Gm-Gg: AYBFou0ti+win+yJs/rphTVkDg42YHz4ujbxEOV1PZrg+p3Y/XYqEbVsHmi2dwbPeSU
	9cdIRvDbc1tTRCrOpUEkv4BAWaBI9fJztw939CoIgP6EXLr3Ye64ccArFAxlZgVR63jswhwcNki
	1JXfrlyuNUnqIoSnQsJ8IxROzqT3zdVRkpybUsuHglXgDFX/zGC69di03pc8YYIznmnxWtdWMR2
	vW5UiDSjbbydu4EbwxiPAlxhhlFOMYexjqQQYAuz+LxN+yoeAnSG8UIXRL6oqlHnjmaPITj4pDb
	n7ywEfXMMo86qSRXR+7Fwpzx4CjFBg7SwKHbCbdlUODsb+s3cBrNGxI2a1pwaz+EmG3NpPaDWiz
	kN2chhOxUZXZF6IxieFNhTnC1S5fv9/FapaselslWs3jtZd7c6LY03t6kt64QLhhJoCr7TBpeHm
	cmA/Xecg8OMzbYlPQVoIOjuGMOuZpUQBk8u9qt2LOZlkTxjBkhwS5cqmftvU+pA0kiemK7wIIz0
	r0tl2ikW3VEhRuXV6tP4NcAHpYfgIYFXSxr1fOWwjApYctIPlr6olVnP2Ci1PZPaz8WJUXCDroj
	NTA6ucnmJcn5hgka0S7z1tbdAAml3kWZ4BZ5L2xzKbDxKZj5jSiUNOt1hvfL/+O/oMpp9D1KYpU
	F0WT/si00+FzxYngtnc/p7iy4Mw==
X-Received: by 2002:a05:6402:910:b0:6b8:7fca:9291 with SMTP id 4fb4d7f45d1cf-6b9a963dbd4mr17147a12.4.1795019982693;
        Wed, 18 Nov 2026 08:39:42 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889c23658sm1344871a12.16.2026.11.18.08.39.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 08:39:42 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c40e30c26a4so274266b.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:39:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGW0Yrvbq7knpYDfNnY6cNBY/jC4YQpJ8IstT0ngsKaTVo26/zcbskkXAr0AlP9di0XLDCnirc=@vger.kernel.org
X-Received: by 2002:a17:907:1c9b:b0:c4d:31be:1f27 with SMTP id
 a640c23a62f3a-c51260bf92amr3511966b.9.1795019980203; Wed, 18 Nov 2026
 08:39:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com> <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com> <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com> <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
 <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
 <av2juQijIISJAgyf@redhat.com> <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
 <av3SmRMGDLVAwMzK@redhat.com>
In-Reply-To: <av3SmRMGDLVAwMzK@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Nov 2026 08:39:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wifUn5X6LeT+-A3mW9JtDcfx2x-5xsWpTxXzThibsK6Ww@mail.gmail.com>
X-Gm-Features: AclHuK8yADyTYfgQF-cxDlxPVAPrNzQpmw9eeowiVPqEa19tx8pNj1uFwz9vJyA
Message-ID: <CAHk-=wifUn5X6LeT+-A3mW9JtDcfx2x-5xsWpTxXzThibsK6Ww@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Nov 2026 at 08:30, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/18, Linus Torvalds wrote:
> >
> > Some duplication - with explicit naming of the locking status for the
> > special cases that are called with the lock already held - is much
> > preferable to dynamically doing the locking
>
> OK, this was my plan B ;) I'll try to make a patch this week.

I've applied my cleanup patch in the meantime, it was obvious cleanup
and I didn't want it to cause unnecessary conflicts with anything you
do in this area.

I haven't pushed it out yet, I have a few pull requests pending that
I'll go through first.

          Linus
