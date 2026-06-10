Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59684374A0A
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079784; cv=pass; b=PJKMv1O8LNfNpT0reQQrzap/Fwmk/j5vPuQDu8hklG06+hGgeyvCCAvG1l3UVOfb19j8aW3eeYuyCGrV4VYUUnw/PWHSAEwpbsjDwnXiKaktEV5KhUHp9UZn7lSk8Vnf8y69olFiaYWebG23kNXWKJeHryQK3H529Ds4hzyZ6Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079784; c=relaxed/simple;
	bh=4cNtNZAWWq+jGeeWgIyl+McQ74gysZrBI/pMSmDn30M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suXfsimIZ5FBdKzYda9R8PFEhIdTOXVWu0c5yxH84bShbv8iSFiqwU+MqTjveBZ16nA8akNW/xgPoBX8p+YAXiwvZWz+MQ+KZTMJLAxgs72NGTPRYLmJ0qSu9a0aNVkq9rTrxsKkhUHZkCgZ5mVwBwyheSVsk510NN+vv7ni8E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=o5fnqchZ; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="o5fnqchZ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176fc0cc72so65445101cf.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 01:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781079781; cv=none;
        d=google.com; s=arc-20240605;
        b=DQh4v7B62d7fLDMO5aHA1Q7AlcskXbAyAT5vuh5INpFEGjTWHsOg50o3IAF8amBDxm
         Na/kwl4a3m/YHJ532jhFgG3pDlsqpcacSKk3H5i1SzB+Juli/gnFnXcocinRyN9mn9ML
         igth/kCeDJ5bBMzOejUbST9Hbq2upDV6mNuWqVpZ39GlOhgiqVHtZ1MBemUhHPG8TRUT
         z55U4sBSK8gYb63szf2VWhtnjT/BUZca+6+lVBjowTu6TMLRoYjPJerASPZ6Ud8zigDU
         yK5UuXJAbkoGghmwby4PJqEuqZnYyB3gOLdUhgGpCbSUanLef10+ZDv35Ge5hDKaeGrm
         9oWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wag08FDWRyT2U0JBvi5dpn7zBxyQeFgc7pRrkMGY82M=;
        fh=jxwVyPvW/vyAM5jZYUAiGH5R0yaeqEuilzkooKfAQNU=;
        b=P3mUJhXs51lyJm3KY+dsYMDta+TmMvmtZihO2zepeybH9WW1+ndqWtFrQFsMhWIoFp
         mpnFfeX41zWgfgQcNKc5wcPUvRsfTtaziRjErXCbH34ZV+ceeS7C0473pomnv4Io0ClD
         LMyDVfubt5bhmfGRdO2NSTQUqsNLLiTNYWIlSgBTMU3oklKKtjXk5JLzQNdPETKzql8u
         duDeuy2zS05+7uQ6W0m1OzDqz0p6XD7mQMt/aZqeDgviEoAk7d9HhxPBlwgzsgD7fvXv
         CHIsOakT9WYthDLHQIhilOepzNz6t1xRInPznkjaHo/AkXEtzqayhV2HKCXumJPjmUwZ
         UlUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781079781; x=1781684581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wag08FDWRyT2U0JBvi5dpn7zBxyQeFgc7pRrkMGY82M=;
        b=o5fnqchZHzh1ZR8kF1TVGtk9MHYMwlhWgUT+WdZGrvoYVm3jheTRInMqqE3LVHnJVx
         9vR5VO0l/iWl8V8s6XXBB1MPKMoDhKpKI+4UQmhgvlZc3s7hOa3equQjmuxEAymlLHO5
         xtuw7Ux0c00WwovfaSThCfHwSyr8GmlatFLhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079781; x=1781684581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wag08FDWRyT2U0JBvi5dpn7zBxyQeFgc7pRrkMGY82M=;
        b=S0tdkPO8v4kbdERKas00XrzVyJKjX8UinHaZf+tTHitj4BBAjJqoCqkdaH7Bun1tmh
         KX+5oZnbQlqL3+7qEwigHmOVI5rtV6bNem2pqORqzC/RunfTJO4sUwahfvWsmGPwlHH4
         xkir4wcD+sEjI+EWG7wDO+bcBkqdpNcZOdswYYNqWJsEbL9yYfMH0RAWNxQaTRArf1Gw
         BLcxTlk8dqvL0y0tikxLZEGoyF7R2p6db2LLSVu2oGmWcUis6F3YgJGMLsVNHF3tbuGU
         ldQAVlchVhbQTvOEzYBt5EAUTLzf4QKEuzV9/Ly7k4gNBErA7MknNpzr0aIRvA6XrJqF
         pUGQ==
X-Gm-Message-State: AOJu0Yxdph8WqxdtUBaJO/dy3AGlOxxBz9/mDzSaPJhOQsbEoBTlwc9O
	dHV2TAws85PF2k7r+CQNZzAihhnqLRRXY8YM5QXx6oDaT/5u/Pl49kJS2e17QG/uzF8WlxNsZNc
	ZC5rxWXVuvmYXG5jLClbjkQghWNRygR/aDMCAvexhDg==
X-Gm-Gg: Acq92OF2zGe0CqowtGH/AXpBm1mty5LVbA9qUuq/5sDnCSPNp3Snb63Uz1dw+73nwdE
	WZIIqpXUafFFf+IN2yBVZknbMbwPd3VDv4VXMmgompJYwd2P8F5dMAORPMij3QmCvByWfd0OM73
	BCkd+5kDtyRUiH1QtXhATD1z6/DYGTNepJ2OgnNutXiGyTbulERCmTt/fapzwsbZ0zfaZBxEO6e
	zv+Wg3VqmVNTlBi6yGrmCIW7rzf05aEGAJgbElu58LUzyAoE7Sy8t3D780crpTe02I1wfR/by8z
	741smbHEew1McPk99pafmYFGrawEFnuL4abEo0Yvq7Cz6DqEFrg=
X-Received: by 2002:a05:622a:4c07:b0:50d:6b06:a453 with SMTP id
 d75a77b69052e-517a12d2d82mr287271101cf.18.1781079781442; Wed, 10 Jun 2026
 01:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
In-Reply-To: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 10:22:48 +0200
X-Gm-Features: AVVi8CeomsE3hVw5JXLSytVgyxPdlTl65ZBd7heug3uFquccxMZA1_dt84I2azA
Message-ID: <CAJfpeguWuuhmA0sPZkGjefhg1G8VCo9A4xi+SOF+R6GpPw1iBQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: avoid 32-bit prune notification count wrap
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: stable@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 at 02:38, Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> FUSE_NOTIFY_PRUNE validates the nodeid payload length with:
>
>     size - sizeof(outarg) != outarg.count * sizeof(u64)
>
> On 32-bit kernels, size_t is also 32 bits, so the daemon-controlled
> count multiplication can wrap.  A prune notification with count
> 0x20000000 and no nodeid payload passes the check, enters the copy
> loop, and asks the device copy path to read nodeids that are not
> present in the userspace write buffer.  In QEMU this reaches the
> fuse_copy_fill() BUG_ON(!err) path.
>
> Validate the payload length with array_size() instead.  That accepts
> exactly the same valid messages, but avoids wrapping arithmetic before
> the copy loop consumes the count.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Fixes: 3f29d59e92a9 ("fuse: add prune notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Applied, thanks.

Miklos
