Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E3752BE55
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766534; cv=none; b=P2+IhNuyyIoRIDwO9TZz5P7+DTw7wIOHI8HHDYyArIWhxX0KWgDvHmdw9HyWR9di7vk3Myb1jafJNwrhybP5qV2DsJLCHi5VtWAzyK9CEeq1kR/e4PuPjgZ8nNh7EmeCY75wRYnZ4pqo42gesVtDR5Hi70d/TIXgjhz+Bv+1ebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766534; c=relaxed/simple;
	bh=X9OZRbLgJLOqk1WlSsd3gudo9f4gAyD1+kyq5qwCh/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXNrtvBRLCuo6v1XuZYo62Ye+1lblBL1OMPYJ8tJ+n8LaqOjQO78W7nFBifGwFxRbrLwmJes1ejR+7imv7hHGeZF2gDeKBWX0++r1Q4+nt3KWbudtuze2CL5zX99l/ruaj4y/QTsEjBUkL7ixbzCD7QHDXpIG7WY4uC5HKvOAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uowct0ls; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uowct0ls"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8d040aso563066241.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789766532; x=1790371332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9OZRbLgJLOqk1WlSsd3gudo9f4gAyD1+kyq5qwCh/Y=;
        b=Uowct0ls3LatVKgW4aDT9bGdjAu5eqAYiFi3pqhl25mwm9UaID1a6tlkTJ7F9W/Z2R
         +XHVHBvIKKb5P/xKd3AjheebKtm0p+R4OxNFr5LHgWfkz4t3WVtt5iXnmLbfqoiOS2Fj
         KFZnNj+hwvEC3DQKX2Uh72Zz9mdnaLwxpu0ZRi3DMgB6yvXjqpt34L1SM7c/5PQ7Db4w
         P0irXiS6uZBGOVKwSEBKrDBacbYw98fMAMmtFZkAe4n4j0qgH6WpxrydxvI2Nj7MhLNO
         EJCjOnq33uD9o10JqaMYis96vc8Irq6aqbi0Tz3Q4xoY2J/mzaDHkfFv1Wiga1W9zP//
         +OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766532; x=1790371332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X9OZRbLgJLOqk1WlSsd3gudo9f4gAyD1+kyq5qwCh/Y=;
        b=WPwrYoEWoUfECdF/y9FbAIW1o50mg09lgQRYhHr3RaQIV6WWyp2gQj8Nn2Usaq9Srn
         zA7LovqtS/gqnatWXDX5SZly2nI8sTDwRXB3dLwsEQFpoHLi7fpuMPUBaHk8NXiXi4ip
         mkfc6s3C88ZfMykx8jdN30nKb+Sq4YUxp2wdenzvFDGaXS4fv1AE9ulySlXTeRogKWaq
         dqBKiKMGeT6LNFWez9aNCsF49jCS89lKUYelBuezbXxF058NzM1xDHA4Se6CXeUhHHGb
         CnwsOkMqQASLZiqLhdReQ/1po+WOQ6x5uBDNZQHej0liE+lxkHRPIQx5yfi0gBma26S3
         0ZnA==
X-Forwarded-Encrypted: i=1; AKwUvByqGKt5W8tI1OmpUtG4POEwEPBNw/oQJMLSPQtQ6/YzzdbqTDL97/4JCQ+wxphkxd80rtM3RJc=@vger.kernel.org
X-Gm-Message-State: AFuF++khPFl1KluohgTMvjQ724PuxuscdtZLCONtSuxwEw6zmg2Sg+v2
	48FXXUZTLwq9+sQiMWSgB1ejHO8IpiNIZZC2+MQ75rUGj6C6cwrf1yjd032SMZqn
X-Gm-Gg: AYBFou3OxJtO3CkD+whJnDjQAK8Z4iRessh7s6WrQPbliRIglDemVHwIgKCTJC+W0pU
	an7FmOvxOwmGnw9PDrxpdzBHvH3wYmSObJd4xtvGLBv+FZPakkHJiW7REMbALqaTfjmZw7nUhD+
	o8YGHLWf3ovGFt9MaXQ6n9G/oJE2TgvVwPvN0bkxg+wco6ZGFHy8fmzLDw28v9Mgxsq05N/pctr
	N4Y3hy5azEFwrfIwV/lCvqZP6ILdqecS2a8d2d9w4eX0LTsw89zfncf4dLc+5vBnGSBhA/bdcUg
	HTDdC9f/2YSTeUs6Wzmp/PGt9iGloZeT2f4k+u2cBMk/2EQNrW2gTs5Imjhp3bv7G7abkB726A0
	iK6A3R8yO/tbbq8sRTPz/yAu9+eUZg6/aIYv8WAmYkIcaGGLmh1ipuRQs1hWcQSyUkeZvJRFjtK
	oTV5p5AfSoTwNBfvaLRgBtbTTSy01WZty2GerWISVLWrs5oOosWNGsJnpHw1Pczw==
X-Received: by 2002:a05:6102:5094:b0:7a1:f951:664e with SMTP id ada2fe7eead31-7a55d28698bmr2162620137.21.1789766532242;
        Fri, 18 Sep 2026 14:22:12 -0700 (PDT)
Received: from beelink.. ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a6ac1bfdd0sm649155137.3.2026.09.18.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 14:22:11 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: slava@dubeyko.com,
	konishi.ryusuke@gmail.com
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] nilfs2: fix checkpoint root lifetime on sysfs errors
Date: Fri, 18 Sep 2026 18:21:53 -0300
Message-ID: <20260918212153.23651-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <13b330df140a2ee488952b4c7145e261ec884555.camel@dubeyko.com>
References: <13b330df140a2ee488952b4c7145e261ec884555.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

No, wait_for_completion() without a timeout is intentional here.

The kobject subsystem guarantees that the release callback will
eventually run -- CONFIG_DEBUG_KOBJECT_RELEASE only defers it, it
never drops it. So the wait is bounded in practice.

If we used wait_for_completion_killable_timeout() and the timeout
fired (or a signal arrived) before the release callback ran, we
would kfree() the root while the kobject release is still pending.
When the callback finally runs it would access freed memory -- a
use-after-free.

wait_for_completion_killable() (without timeout) has the same
problem: if the wait is interrupted by a fatal signal, we cannot
safely free the container because the release callback may still
reference it.

The unconditional wait_for_completion() is the only safe choice
when the caller must free the container of an embedded kobject.
This is the same pattern used by other subsystems (e.g.,
blk_mq_tag_set, configfs subsystems).

Aldo
