Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC339C637
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473670; cv=none; b=gnFp0GbvloIWwdiUYdOBEIzfDOVCDfO52i9dRM13f7KcVygbCtx6LNakSjjaUhF4Sn/MjYs8FS2nZeHwTSkme16LIgow6KMqXHU6kdl8IAsBSW6ksZ7y9uvW5gWzKVF3K5z08TsvJvU0fBBllLlzh5+U7ci/U0mDiqsrrqiI5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473670; c=relaxed/simple;
	bh=JQ/yBgCAUcWNM14es3udFCXtoQZC77jRMS5iOTMYSu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDaHJGbLt2OcN/H8LeI1Yo/5TvqXliVYNEttlzYm2JUr+URqYnlilfLmqZxwrSASidglQ8YmTLaXGdmLMUMBaQPzLkZMrDK7KTu33K13mW+4mVZ5dKha0+3kGyjGZkTLPTLsDZtR04l7pdvnreLC4Db4w/3ItKWVXmOy2NyZR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ZFjjE3j9; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ZFjjE3j9"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633ecdeso158105f8f.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789473665; x=1790078465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXnLznxt+LUzVKSpuZUKgVMVIlvhchloL5kq22Pk3QQ=;
        b=ZFjjE3j9PqOA2kembsSKz8nsdmpJ98MNtQayaQZWOadL/gX0qxugq/eVqa//Fj7/UC
         JsbtVfR0gfQG602Cb19kLDth0UGzDqvF+MSXt1yyPDUiHF89MQV0t7HJ6xhXrKIjGZgy
         Z0xtHzdyYQ3lAPxsZLsfgAIYXzoCCC7mSIgtcG2a34ETCzhNY1FT9gOzcOZ2nJ0q9dQa
         bhqIBcTXMBAhu/xBAw1NjQBvB6RaQueDozW8zg4jQLxj5nyOebk0tsBU37sIwDb77PS6
         oMUMa9c7sbKadd8WBS+Ad8rfo235LQbNOKtvgRociPZSCfD9Yip8bgYDGJ3aD4jISn9w
         bNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789473665; x=1790078465;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXnLznxt+LUzVKSpuZUKgVMVIlvhchloL5kq22Pk3QQ=;
        b=SM4z7wqQIpLhpI0W9IleFJ3RTPnpXHTshU23rXMaJAHZR6WbWxl2qFx3l/Ln3pnp4B
         TiNyI+zxsE0HPk20BwDTcX6lGJKnXb4oYzSd3i/bJ7X7M6NWTH6N86sCiin950Wg9DGr
         0bT1WR9lJSPX88spalZ4wPqGDRT6lvUyynoE4L81KcYKidBaerKSgXiA/CMOUvTc+zIK
         VtUyqjzXdFaEJRCAzeHLKySVCSOMzUpsnrLPRW34TP1GFomnzE8Rk7i9vupqjZhxtIKw
         Cde9UHf/JhjP8ktuWewkt6CH5zNVAdNsi+ZQCEiJgl4jS0Ds7p3t5JrhKlTQlXhf7nxU
         VRCw==
X-Forwarded-Encrypted: i=1; AKwUvBxTiMtCLIWE78RmlWQ+6/fBAnhWcGMlYs0C4/LLBxreEoGaeLeBNslKtHgCWV3uP0r0BYZl8VU=@vger.kernel.org
X-Gm-Message-State: AFuF++kdDDzFLvmUQpMTRyuje+vPSFxRzFZqvvYog+rFH5mdKPXI/Xqn
	eep6BD+w8fcBWIaacBhlPZdJmV98HYWEppCrUwQkZDHJvAYMz5BDCrMVE7PLVMxuPa0=
X-Gm-Gg: AYBFou1QjZgYzUOrfokaCQaap/QSXl48szuvzTAPz5hLBeXJpepEPOr4BTTQTm+eTi5
	ciNcHpBnzAjRvnJwRkx+fzhU5vGqLABfIlFzY2qEZgkzFylvTY64HPlVzZNi3sTKbR9Tn7U9XtC
	/ikWSW8nEAS0TjzhbBSWaOVGxYrCtxnqPL7zDv38J+boQ4LBWqkBoJRaxojxHgmCDs8GfoBRxLG
	Uxu08Ieyy44YzapA3QOp643+7ESSzJ49K0FAcfkwMrlzq3/9u2q6qsE+cmOHKYttmqKJnSeHblw
	qH6AU4f+BNgV+CLXx2mGJt5XlE44tijAwuWNzkABKfbrpTrX8mGg3Fj6w6L0Lb6aQtXdwLdkgN3
	cOqKoJQbyr+WnU25y8QH9irQIjC4v6/bgukL65RpVu7gLK4fv5FfPU7Khxm+gWw1UqvBDk8AJA8
	0Vh7rs+FSOXakLm/NYQeD2Pz2lhOU9uMVMy+jc+8TL03tIeLTDSEkVPS1inoKZRhrpm7KXNUdii
	DoMh0V4w3KfAfnpSyWDN9CoraY/vtp/0X01ijIkkG86Ckys8uLNchIuzZ0KTOR/4Tyz3GnvgXPs
	jhDh/pMbjjItEqjY+PsB68wtxg==
X-Received: by 2002:a05:6000:188b:b0:485:8bad:fb4a with SMTP id ffacd0b85a97d-4870a952919mr622437f8f.7.1789473664622;
        Tue, 15 Sep 2026 05:01:04 -0700 (PDT)
Received: from [10.160.16.196] (150.red-80-32-100.staticip.rima-tde.net. [80.32.100.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bed0sm35665221f8f.32.2026.09.15.05.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 05:01:03 -0700 (PDT)
Message-ID: <b860e9a8-9a3d-4a4d-950d-69bec1792144@kernel.dk>
Date: Tue, 15 Sep 2026 06:01:02 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] coredump & signals: an impossible affair
To: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 4:22 AM, Christian Brauner wrote:
> Hey,
> 
> I asked Chris (Mason) to look at some of the coredump code with kres and
> he found a couple of things. Some of them I had already found and fixed
> but there's some good stuff in here.
> 
> @Jens, please take a look whether the io_uring fix makes sense. That
> kres thing added some patches but I found them all not very good and so
> came up with other fixes mostly.

Both of them look fine to me, feel free to add:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

if you want to carry them. Or let me know if you want me to grab them.

-- 
Jens Axboe

