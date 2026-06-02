Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3EB30FC21
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391899; cv=none; b=OQHjyHKPxMKJHoiteH7itxnGuPG+iQxA+j7tXwsp0QIcyulQPvN4Qzg+CZjIsFUdcDtfVeX7OZSye8l3HlhHP46PPvCAFkFOsXU5sUxCBRZPrStrsay8qNacr4to0GBOU8fi4YJ4l24w3RHwAtFPBUV7EnMAIRjS5zwaGneWCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391899; c=relaxed/simple;
	bh=FYGX+z1NHS6G0DY02oZQ6hTTBFd4DJcBw8FAvVlqv/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlUjmbhX6dFNsMdi/UY3EHTL+F17FbLgQ0Vp/y5Ng9TYdQHboMDyH6MNxd2t0IXpWzwD0ryrbqJRLaZYDccrHtA8PqQvXhCQJY5Cz/3+NqBgU/egTOzHDaVcrq/0GeTbZ8wZncP6IQG/QEf9Wegl/hmhAfB9OYrwGMil2eZfbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N9ZByfFV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N9ZByfFV"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so4327090a12.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780391896; x=1780996696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8weWZwvlicUS0dvAxblKD1HBMYQh1u5mQ2U5bxBouSc=;
        b=N9ZByfFVeFBhHG9bFqF6uwAaa3UmmgQCXvV16kc+mco9kF7bWhuafCJ0CJVKZ31UbN
         E4Iag7AZXP8vTFT2664twUfhM6cek9Mzsz35LmYYa1tD3GNi0ErjNzpdpwN43xE5fTL6
         IichCTHHgc7msv6FC6ZrIgylzA/7Bwr40LIAqk2eLTC8+N4veLYDn4gtNMMkuUB2mSt2
         u9VTvRYUD1rw5cTkAIJZAl7mg9lPB4KmabO+vZe9EUzVts1KD/aCc8s7k+/An6OkBvRX
         l38Fusca3Oz52WA0lKE7gbUz9v29W2f6b5XpwgzYj3e7UZNsR4wueBQ2byJHMvqag6id
         4Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780391896; x=1780996696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8weWZwvlicUS0dvAxblKD1HBMYQh1u5mQ2U5bxBouSc=;
        b=ITF09ENFrSkQA9iJu513CBkDU0PWzRgp7frvDv/Dvq3+Y0OOBwzguwPexU++XwO4mf
         zJPP4/LpbyE5TN3GctZQqtiE/dyMTnZnLM6Z7a6iNRLOM/ed81L5W7ps/H7GHRj0Kvjd
         BkrHug/O5lMa1ku/Ejxd6X46bFefM24VvaKFii3CPfTNxP34F8V02U07S+6L4yqDeoqf
         KNxg4kHgiWOya+IiYszcXzKlSEd9mCwn8/v4iLT4A5hiTi7tq+fib18zx7JNghdpJ8iQ
         w8mtbGAWVw9rk04Y1UxdNyUmoX54ZRXfbEtIE9GAWonHc7cWbtljYKABj2Y1Lgp5KwRX
         wW5A==
X-Gm-Message-State: AOJu0YzdhKfWIkoHS2/WyICoQVp8BJRzcf+u/6PuX9767UQhJGt023bQ
	KJ9jyF2/LfhpX8z2F16LyzSetE3tHF1BAWi95aPxAM3jI30bvIYJDofz0WdhF5+qG04=
X-Gm-Gg: Acq92OEk6zVs9cqjWECrdJsldUsUDSfI3AcVDbVI+6FYYoqWSEBppq0Ok5ajaCZNofN
	CIxUdBPldm9lZ4iN7cmEOHRidGs9PsO/knDdUJ1aPNxZ4sY1W8h2Ed28sgu8ZCLAZn8ES+dcOKr
	S1NK4yiSKGyETQJTk+W1ZHdRZgv7427R4YcuOrpxEkVDWSFxlV7BPczqN7/EcO8BiUlTIJOcrI1
	IMfsF1bYF7kxq8cSDHTSZKe93kaN7GWL1sWTfZ2QGdkmG66KqDwTVB11q08zgGito133j/OmNpa
	LvSnGpzSyBXx78jbLmrGfgRGglJPKsLer/FH3K8m5nVHqSCKNRITmQRv21IxGJx/VyMQib1XBUu
	WN28X86Fpbt3APC+UzVbJ0Od+F0ZLKV1CPze6m/7jkNKecDAHjzL7pvvyNQxlTJgMhbsF9wd4Z0
	pzBfsiDI/9Fwfm6dvtDgh17uSGgemOZ+Q5zmYlYIsyEkDM/VCcl6uZxg==
X-Received: by 2002:a17:907:9453:b0:bea:5cc7:95a4 with SMTP id a640c23a62f3a-beab03de8a1mr933593866b.0.1780391895233;
        Tue, 02 Jun 2026 02:18:15 -0700 (PDT)
Received: from u94a (27-240-75-84.adsl.fetnet.net. [27.240.75.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd91846f8sm2382956a91.4.2026.06.02.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:18:14 -0700 (PDT)
Date: Tue, 2 Jun 2026 17:17:59 +0800
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
Message-ID: <ah6dLESn8tHAtxS9@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
 <ah5pf25fhVH9WuU-@u94a>
 <ah56iBM2P_9hF3_L@u94a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah56iBM2P_9hF3_L@u94a>

On Tue, Jun 02, 2026 at 02:42:35PM +0800, Shung-Hsi Yu wrote:
> On Tue, Jun 02, 2026 at 01:47:01PM +0800, Shung-Hsi Yu wrote:
> ...
> > On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> > > Hi BPF maintainers,
> > > 
> > > This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
> > > The series is intended to fix a verifier state-pruning issue where an
> > > impossible scalar path can be kept while the real success path is pruned.
> > > 
> > > This is a verifier scalar range-tracking issue, not a helper-specific
> > > issue.
> > > The visible failure is that the verifier can prune the real success
> > > continuation, which should not be skipped, and keep only an impossible one.
> > ...
> > 
> > This sounds somewhat similar to the issue fixed in "backport of iterator
> > and callback handling fixes" for stable 6.6[1] by @Eduard. Could you try
> > to test on the latest stable 6.6.y as well at see if you can reproduce
> > the issue there?
> ...
> 
> My mistake, the reproducer you had doesn't use iterator or callback, so
> probably not fixed in stable 6.6. I'll take a better look at this later
> this week.

Two more ideas beside testing on latest stable 6.6. 

1. Can you try testing on bpf-next, but with commit d028f87517d6 'bpf:
   make the verifier tracks the "not equal" for regs' reverted? My
   concern is that it is possible that commit d028f87517d6 does not
   address the root cause of incorrect state pruning here.

   If the reproducer _fails_ to reproduce the issue even with commit
   d028f87517d6 reverted, then it is possible that the root cause was
   fixed by another commit further down the line.

2. Have you consider adding your reproducer into BPF selftests? Would be
   very useful to have in stable (though it needs to first land in
   bpf-next first).

> > 1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
> > 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
