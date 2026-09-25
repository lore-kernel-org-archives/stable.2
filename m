Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050824BF92A
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348412; cv=pass; b=dz/YQWnBvx/ZNZso9ma98RfThHH/AdBT0uFEWTKnk3Mhtubzmok/bYelx87g5nxYRTGku1IxZwpyzuP++e63fSVczSpTkQDqcVXooZedT6CdSS5p7jn//mFqDE4iyDhK1o6J94+I1kPi8eba0wS7qZ9rxxwovoNXLMg5JvCWZB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348412; c=relaxed/simple;
	bh=G7PD1SsyWtfXJXkRv2FlPB9lAjfDo8cMbMk/Mdw9V7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4Xc0SWWNrVHFRqP5iePnHDQDgcWQvdTY2BmJtuGljtuQ9lZB/WBJhzCZ44NDVy0w6aiRy3yfGy+hauETNfxRwzDQvLPkubqp9+APNCtMjBDxvvXv3IcebMdJPmH5TGMDqpFRSJZw1uxPo6GUfHUzIekSy91MVdLq9Thkj/SI+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VU+craBP; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VU+craBP"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d0d5ae11so11245861cf.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 07:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790348391; cv=none;
        d=google.com; s=arc-20260327;
        b=npdzF3TD8m+wXKrTdGMkbqgCbcNgB3m6bP6VKFwEtpdS1Yol9tZtdZhvuDuCvrmxzx
         uYgHvJLldGsrw/z88pCPUfhcdcZJxeAoup3q1Gcea2gLELPmGYf5zjwzTVnBgqcm+SVi
         S+fpcEqwG4cFjUUAiIaYfNHS/1y+KzLL0H0zmkK4vHq7H3zyvS+9EzH4X/hm2TaXcrX3
         X9+/G1gk6KPUW0ZBYgfcbCdQlzLvvApmgW7OMx0WTb18oPpg4+e6ASX6f4KuE4YPBUZl
         1wjyw2XQgehBS2erMoWDB9njV9oNf6r0gcCHPqeFctFOE0E0yp3nhu1BWQJhNTVRjFJD
         c6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oNCxj1Tkne1Dd9zOhmWp2sMzjpmd3KFTSPzHbdHwTl8=;
        fh=HGBvUlUP9HqrDRkEyc4adwIiLR+yLWD7aUZzAzXGhYw=;
        b=Lybb8bzN79a8dWoYHYuPRpY+v6cMx/AjNAWNh7/6Pa5rem0yJLrUl1cxHlxaO6fSB5
         D3TzoXdAqjK8moIrSieCAZjITPgQFYpqiFNkRRzf2JvZFYUcENkmLNVnozCxnqdrIU7p
         jlev7Fag/MRtze1Ibljodlq2RllPH9DfaawvRvQbSZPG3OeGqcXx0cTp60JETI21F7P0
         kyE1SUo1Lnx8bFgrdxT6ku9i9WQ3BojKSkSOJksX3ckV7R/WXw6VnTl+gDSB2O/rAYfB
         D7bAZBPbjaZfUTTLlz5zVxjT2KDpzC+LqZtMXjKBl4vZlrqzbtjyvAXHQ1cz5z4bMOXn
         rnmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1790348391; x=1790953191; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNCxj1Tkne1Dd9zOhmWp2sMzjpmd3KFTSPzHbdHwTl8=;
        b=VU+craBP5sTfmgsks6GqGyE/aSlKFV/uYtDlbeOzYSOfhZM0LCRTW9xsMii7u5DKPP
         ee+c9I/OHN3XyjUODNRuDCK0Kc+tq2ddcB9We9B5h0V6rfU7Ena6Hzd3gZ9r2rPCXGqY
         gWDr2/Ff5lGSfoHuHqx1lh1188vB1iCslgZSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790348391; x=1790953191;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oNCxj1Tkne1Dd9zOhmWp2sMzjpmd3KFTSPzHbdHwTl8=;
        b=Xoq+sYPWSRSU1xTUUFK5wlNRv8hFaoTwKL8MruNyGb28Y4EeYxhzcipAGn/Eay99uv
         f+4l+MOCes+ZkdAvz0uvODswaNL2FWba9KQOt27n9kqgy878oUyckUxB3Pv9VUq/49Za
         6wrC9NI+Dsgm74Zgd4AB5tCvG6YRvg6sebhltEiZLtM2vmv/CquD5pYs37IiOzKsu2zi
         05usMnp0cN2UD2QLurAiR1Vvfx6tUNCKQy0DmPmVms/WeSfHMMAtWu/lr76lnb/9e40Q
         hle9rdsCBJOGK65UGGxYJDnmlNShF3vRk6CPbinI6Q4EhM8TzxDoDFkFisDeuo5VPV/L
         LFsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiKbgeNIDD2/4flXF/S32ckYvBDttx+4hVx0p7dF4mNu6MOVeejeWfgNq5cd2q1cWm6DkggBM=@vger.kernel.org
X-Gm-Message-State: AFuF++n7MDI1/dyvDykI6eU3+jLGJ4SjddW0DTFzFH4SUBpfxJKgrwjD
	K0btr7V0bQuCvmlT/d6bMlJMSrowZG+8OCpGgRvESHoyYR7PLmpnrakNAtP6GITZXXd4TNJMs/Q
	rw1zKIIPFknDB/GnxSsoKGHYhdrXnexRjc+PA1+/bkg==
X-Gm-Gg: AYBFou0x2kw41gIYymb71jW3ztTRNqMNf25j2zTFMYrLVm0JpF090gxmIJGXcarpm+w
	kNkBz3bGU8hghleO9m2ltQbww7V65yCulN9AShEiEBcR81D9yq1jJNLPJ4fTMqqHOxmR2UjaKGL
	R7Gx0WTqgkEnvxdXoogT5QO7PNcWQEym2FMD4TSFbIpDp/eKpibqbbRf8wsLUfjcY9PFLFEBjLQ
	7JlO91llOkgCNwSeoxd57D5MCiqR4qJlKI1xLBSNxXd28i3XzrAC3pcwmgNUwyecVdM4VfLonIJ
	l4mf6KZLi0jZ5rVWjghjimixBKEyG/EMfyMR6j7m5UVRhYk2oSNlSKkZvUqABJmpj5op86cgIWJ
	zyvDyGhcigA==
X-Received: by 2002:a05:622a:508:b0:530:2cc6:c8ad with SMTP id
 d75a77b69052e-5330b5ad6e9mr51539751cf.19.1790348391358; Fri, 25 Sep 2026
 07:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910235110.3922068-1-xmei5@asu.edu>
In-Reply-To: <20260910235110.3922068-1-xmei5@asu.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 25 Sep 2026 16:59:40 +0200
X-Gm-Features: AclHuK8PxhLjayeNK4Ioc2AfP1egLwmVYg_0ZofucCJ6SB6GJuae3F4l1SVQLt0
Message-ID: <CAJfpegsxW3gf6Dj+zVKTTHx8bsASXiMboZ6UWd5WWtBMqd8WZQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] fuse: don't BUG when the copy buffer is exhausted
To: Xiang Mei <xmei5@asu.edu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Baokun Li <libaokun@linux.alibaba.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Sept 2026 at 01:51, Xiang Mei <xmei5@asu.edu> wrote:
>
> fuse_copy_fill() hits BUG_ON(!err) once the iterator backing the copy
> runs out of pages.  Over io-uring the amount copied is not bounded by the
> payload buffer the server registered, so an unprivileged user can drain
> the iterator and panic the host - mount a FUSE filesystem with small
> payload buffers, then setxattr() a larger value:

Applied series, thanks.

Miklos
