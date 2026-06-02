Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0A32BF52
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382569; cv=none; b=J/swcom4a8E9rEI4PveeqSIoi/UYwf2l6yA7zRidQo/McEDv8o5QLxc+hei5x0zZe0Uo3TkVXJTqBTem320Vw10mmGLnbrC4XjsKyi7KYCIu2aDCqWC36ls7XO8BMf1LTW1n0wkbvUr7QgYE3RtjRMIm/gWuWS/OCPMNF5P7lWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382569; c=relaxed/simple;
	bh=qE///xx7EQlY0uI+1+xH8GZBQ0wprBOgoD0QacK7mPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHoN0K4yxxspOdA0gGFioT5ysHZ2u+taGRTngA4Femvfgl1kKLsuUCwWi8VkFWiw6yAtECVdERv5NfrsAgxi/p1At5EhreOUFffKQJC+8NTGFJxTtTKKsrVAYQjOCpfNIG0spWeWe90WE0m/K9u9juFazpar+nYy7GJ2w7hxrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5c3jx1K; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E5c3jx1K"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490ac357c55so15342725e9.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 23:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780382566; x=1780987366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2N/m1TM4Ju0vSdiUK1Hy2gxsTSd/KSb52qvXdhc7mG0=;
        b=E5c3jx1KDznGM/xQCCeuWsjY4ltjgWWwMQMR6WqY4ouqMxfYDFjIBa1nhXEhsWdeZD
         9WsOws/fVK+/V+oj/2ix/11XjFR2rwCoTikBDid1RTcHiPH8h5cAS2ZMJ41sE4QCLNiL
         RlueKdatJ9Qyz6Cz1xDSX4ATUq2KVPoj/Irc2ImVRNhqg9hzYk8Vl5zHbzDy3yREG+sL
         f2S898wQ7xO4IffaDH7yDS/wyEpldPJ2Hapy8wF8kza/rdPzraY1e8HUZKvBMjgd1C6l
         UHC0Ak3EDVz9mvvSxCKSecG6cBF43WhUSZuPMylTXTBO7Qiqtu/EyRjRyrmCcVvxuaNh
         ePEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780382566; x=1780987366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N/m1TM4Ju0vSdiUK1Hy2gxsTSd/KSb52qvXdhc7mG0=;
        b=P0ts4yogBPYyFDzuZ4/hucW4FrnkiAdF87wxEd087JVXeDBwk8TYdHb+XAjsg3nGKR
         2blpzEq3QpP1lGxxFHe60aBHx+Pu4pRQ1Xp2ZmksDomz3gMF90bsIU5gMMzZuPnUQxu6
         HY6XedUFwgVNhLBOWopbvAF/zMH+obmx4tP8LZdiUT4BJBaUX9Nv6kIoXrGmXEF7v4XR
         AGc98Gy/8Ls9eDpkK3TCmuB/zyC8VA+QX+f5wJ0+ZDCbuBCLaCfsTVEX6lR48b39I+Tz
         GBuhwMddvEj6U3/YYu9x4UzeAzhQvwlifAz+bnF3G8NfzognR0KUH7mQNv/GXr4UpSw4
         CmfQ==
X-Gm-Message-State: AOJu0YwJiCfaPRTKtecx1xJbvlA1OqeuHXxE9zbuqOQ4cvW8OZyQydYi
	PcwO6IKc9QQiHAp2m/sBMzMmHgilHKqhvBuQqYW+yheWXYtgIE7eyScC11pTrphImYU=
X-Gm-Gg: Acq92OEZZmRK7FmtOTokQe2eKJQlYQah3SGy7YF1JYC6g+NwbWKO9MGOf5ti+OE7rb6
	YdiuyZbLbFpVbTIc2DS8DFR99wz7T3BlzpTAkBMGadTn65BozzAA5wryBvatrPZdUtx+UM+Gz04
	AaKRL5z0Wz5FZhKzVhwRCgsO276pW7gD/NVQ9hiNdZeYn9rohZWL9eH4CTdUTBTNKoNLMmQG1iL
	vQJUVyGZFkOa5yhxMxt0udRzGDkhuSR1+Wlwb4rVC72Ol78ofTzRk39UhtCP78+J+casUhh0sYR
	qnEJ5WqW2SlWTkwCabVnbAEif7fp2QUGrqBGbSMI9RFaW6xStxMfMfcxznvfo6dWl/87vWaYzyz
	6SKVPvc+EESQ4Cenneu5SoxmWPkYIjuBfOVNUlBd2rXUOWLqOZ+HtVpzSHTvEkweFRFF9iTnFDq
	8NuiqHEbl1GjbtBC6sjly5bFQ+euxN03vKDZ0sfPybncih/8T1bRudGR74cUj6dXxAWlzsZzjzJ
	E+N
X-Received: by 2002:a05:600c:a55:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-490b0717e7dmr51100485e9.32.1780382566124;
        Mon, 01 Jun 2026 23:42:46 -0700 (PDT)
Received: from u94a (218-164-49-131.dynamic-ip.hinet.net. [218.164.49.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fdf0asm121897245ad.26.2026.06.01.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:42:45 -0700 (PDT)
Date: Tue, 2 Jun 2026 14:42:35 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	tamird@kernel.org, eddyz87@gmail.com
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <ah56iBM2P_9hF3_L@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
 <ah5pf25fhVH9WuU-@u94a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5pf25fhVH9WuU-@u94a>

On Tue, Jun 02, 2026 at 01:47:01PM +0800, Shung-Hsi Yu wrote:
...
> On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> > Hi BPF maintainers,
> > 
> > This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
> > The series is intended to fix a verifier state-pruning issue where an
> > impossible scalar path can be kept while the real success path is pruned.
> > 
> > This is a verifier scalar range-tracking issue, not a helper-specific
> > issue.
> > The visible failure is that the verifier can prune the real success
> > continuation, which should not be skipped, and keep only an impossible one.
> ...
> 
> This sounds somewhat similar to the issue fixed in "backport of iterator
> and callback handling fixes" for stable 6.6[1] by @Eduard. Could you try
> to test on the latest stable 6.6.y as well at see if you can reproduce
> the issue there?
...

My mistake, the reproducer you had doesn't use iterator or callback, so
probably not fixed in stable 6.6. I'll take a better look at this later
this week.

> 1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
> 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
