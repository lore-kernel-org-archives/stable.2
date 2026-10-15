Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71C3D6CCF
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030610; cv=none; b=u2xlwsB/iHh2XyABa4rSiI75cK8vAzw78MhIBDmcURJ5glFGehyoHhdYB6gxnt1Q+ceTjk2gQ8CEqBM2zp0uW2ovsEqCpZbtbBbaPhksg9ESAiQd2nDYtouNglnrsonNichmLyq5Pg7u3tR52l6bhHzYTrT/hIuc+ZNXnKwRRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030610; c=relaxed/simple;
	bh=zifELv7LSa3E1qTgUq7IUXbs5CUOgdupnSadojsxUzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejqn0OuITZ3CT7nCThfqB5sBNLK91QiU9nRrLSbHA75XtoNjc/1/QyjAsoukoKAnHZ2Wq68KAY1lgUKMJMk8pTapaBw83rhRRk2KjXq7kCydKmCvLWOy28VLqKLais8NFkv/qzPOxf1KnMTCIbwPNEya0XRuCgZdBt5hE7xX9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtrXfjVN; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtrXfjVN"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-354ba08cfd1so7969465eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792030608; x=1792635408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UPSE/oe/bGpQQ2hBx19c7dFdVLpuBesDAHcRIJbsOks=;
        b=rtrXfjVNd/XoWK0Pvw5s0IUgXBacDf6LpkNG2yso7qa+Nn+oqB4xXzm95UfbyJX1XL
         7ujUVPjiNXOXUqx7xsNOS4pdmKu2mkqi4BzAJfr6MFkebUBqydoL3Ruy82fLPSyKM4W/
         yp35qKXUXxNBQSWuPBKMUC5mhZ/R+YdmURTYh93Mls8f4Kgbbm6ok4/aoZzJYj1eAteT
         lI5gpFkAix7MAClZl+fFWY3hI1DL8Vi7945YBr/ImrRJKdOPaEUKq3EkyR9jWh28Yjlw
         B2Gkot8oj1FfNqZU35ziah4aJZq4upoq4fAetK1bDaenWGVmbuUg1KbUNb+P8++5MvhR
         9jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792030608; x=1792635408;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPSE/oe/bGpQQ2hBx19c7dFdVLpuBesDAHcRIJbsOks=;
        b=PbxgxaSGf+bR8TjAwA+KxqLTtzNhuhkUH/JrKW7SV1RMebErKDAdaw8VCcMf6PQ5D5
         Nbsjscux4Em1IRBZ1fVsvcYWBG09BQ8XoPXXJ60NScG6csEEDBU6Lf/CbGHjpoUjkv1t
         o8aBMUrPc3tcYQ9UPFVbZ/CIwXghLx+mv/gu7AJAx9Ts2SmT8NtPi9VX/XvlN3kxLfXD
         OfB825RGKRNXHKShJOeEyZIJqQUW5pe7kuJAReAWoj7cVdSEmwdhkrEe1SrQvEAOlXXY
         7evSzzihKwHMXG7v3rb4DJbdfQsH6WabkEyEqf2SKLiaR0j0uNSILiS4UcX1gfiMKMKe
         Vguw==
X-Forwarded-Encrypted: i=1; AKwUvBxiW16D3cYQNXS2ob6dIXNUUqVh6vMiDqi9Dx7spR3iPNrFwlCPFDJ9+z5Dlfv8+wM6HG645pQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/6V3EFpRQHeyPP/d0tuvD5jjbSDXZ/t1uK1N16shRPq/CgiPJ
	EFErbsuQfEXMZWACapoMJmkx5UbCXKh+XULiOm8QH0CseyUa51576gWX
X-Gm-Gg: AYBFou2heQ7qzz+Izy7FT+KwyCu6E/IaAD0LWS66KI6TWA+WRcWzBA7f9zMkJ2oU1nh
	ywCupzDOF8XtJxgF/t6zTVr0qpt15uaWu9kN5Aue5I8S7iAK4GHFQ1uTjkFHQamgU8Q6/e+haCe
	njq4Oaqex4c5SZk790FDtzxff2nutXvIQzcLCb6eOJt7n9ROEKzFdOblnvmaGt2qN6t9q5uJGda
	zjsK20xOI74I5EZO6alye0IJbtaby6c/WhAUbPxcsia9Xq8czNBQ9wblFQ5BiCcczyGOub5KqK6
	oUNVI50Htp//2JsecQxKKBglWvSeOMQe6NXJDCLhmPPnm4eknYYuG0ly6mg53kOA7sE9vjzd8sm
	OwpdmrqBjvozN1sdbn7YU6JcYZbLogTIyMm1diDhWFfbVcRCGWT4NcY4Wx5sd7apnv5zRlf++Fx
	o5ZZBiIeg52tSs11XoVq5iUrOwj2vWZ4yO177rhRZPPlyba/avYxcypl0RCQVMQw==
X-Received: by 2002:a05:7301:da11:b0:359:bd18:aab8 with SMTP id 5a478bee46e88-359bd18ac02mr15112565eec.5.1792030607890;
        Wed, 14 Oct 2026 19:16:47 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b19c6c7b4sm31488866eec.24.2026.10.14.19.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:16:46 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Wen Xiong <wenxiong@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: run the hw queue synchronously for unplugged scheduler inserts
Date: Thu, 15 Oct 2026 10:16:41 +0800
Message-ID: <20261015021641.2948529-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <asmrlzbmQ0TU3rO6@fedora-laptop>
References: <20260930-bug-blk-mq-noplug-sched-dispatch-v1-1-ff1e49e52b00@gmail.com> <20261010023548.3666200-1-odys.yuan@gmail.com> <asmrlzbmQ0TU3rO6@fedora-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ming,

On Fri, Oct 09, 2026 at 10:05:59PM -0500, Ming Lei wrote:
> It is hard to say it is one regression cause 9cbbac29d752 is doing correct
> thing, and single request isn't supposed to dispatch via plug list, and it
> only recovers to previous behavior before 060406c61c7c
> ("block: add plug while submitting IO").

Agreed that 9cbbac29d752 itself is right, and this patch doesn't bring
the plug back. What differs from the time before 060406c61c7c is how
the async run gets scheduled: on v6.9 with PREEMPT_NONE the submitter
context switched 0.23 times per I/O, so one run of kblockd still
dispatched several requests, while on v7.3 with PREEMPT_LAZY the
kworker preempts the submitter once per I/O.

> Not sure you can observe big difference for other real SQ device.

Here is a virtio-blk disk with a single queue, which gets mq-deadline
by default, in a 16 vCPU KVM guest with the backing file in host
memory. fio, io_uring, 4k, median of 3 runs:

                        v7.3-rc5    patched
  randread, qd16           89.3K     162.8K
  randwrite, qd16          86.3K     156.7K
  randread, qd1            14.3K      14.9K
  psync randread           14.3K      14.9K
  ctx switches/IO, qd16     0.99       0.04

With none instead of mq-deadline the disk does 163K-177K random reads
at qd16 on both kernels, so the patch brings mq-deadline close to none
and leaves none alone.

> For both SQ null & ublk, you can switch to none for better performance.

Right, and ublk now defaults to none. But mq-deadline is still the
default for every other single-queue device, and few users change it.

Thanks,
Qiliang
