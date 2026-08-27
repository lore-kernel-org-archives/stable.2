Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940D285058
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787803377; cv=none; b=SoLSPK/l8MHjBQCEkOpmyu1+F0k1mZPNBPUUTO4r/wNq5PUYUtE8O5FVkqD9Q1w1pEK/ZPqNy2dUSQ57Afd1Srr+Rb29UhqfJhFatIqFjm8FUkFEyJ/Bn4uc1Jf9gY80pek8ZE5+1NZrKu98mKfq4bGjBfacWXHVggJEy9jcr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787803377; c=relaxed/simple;
	bh=eXd83mU0DRhOPBcUnx/U3XfjG0BwFyxeO8U4P/40eOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFks1H5BD/nAZs/T8ilRyhSrg3K+IGMNl59+X233FTmz9c1l2dsKozy9EKE/OmglwMB7SLAjzYVLyAH1EReSAqrtdklBD6hPK4nC2VWFaAfxYC8mEssk3OI3Dv9l9o+4Z/tGPmqRPNr5C77hXVGSs3NuURAygHphWvOCUbcas6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYZczxJx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYZczxJx"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so102875e9.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 21:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787803374; x=1788408174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eXd83mU0DRhOPBcUnx/U3XfjG0BwFyxeO8U4P/40eOI=;
        b=LYZczxJxUUGY9C85zTs21q2apnvBUeMhcq2x3s1BlL66bB7oa+DdPeLyXxmadQdPdZ
         UmU8Gq9xBUhXuZjgzuzGrOv+Tk5VvUl4nBrlUfbdaKcoA/uXt3zJ8jI+AcVoulmkGnxA
         QykogpSb4q+O+o8gkErbrOJHF2OchH3Cv7BhZDr9TeBcAoPKptLaLkfuH0YPOjfXtPhR
         0FOelpjl8iFOFBOse1DGP2nMwi3ZNV0bMMQb44VgFFXMWB5xgZS9LE9GG3aB+zkBclyS
         9nw9AO7A+hZcS2NTDE/XFR+2blDKo/ifVw0oL1GQo7Dql8UcpgWjfAEgrSpeoM+FEaLn
         /TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787803374; x=1788408174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXd83mU0DRhOPBcUnx/U3XfjG0BwFyxeO8U4P/40eOI=;
        b=qHGxusZHe7jPPkyzTqIxO5Jj9A5whbGr8EoaVpw1cl3tzS4pNrlM230+oFtIP8HdTX
         9xxe/Yq6fgXfZLHZLtspV6kbvz8L9KnvG8q7SRkgntQQKGHr0V4hqGAYOi8Sx/tjYPA/
         QLGZbK2Uai3g/FJFn9IQ+XnPtu90NfV4hTvM38qFhN4oXsISPSxQWvciGs3UNspzOyow
         d19xXZseFIJOTwSTdpDFBLnv7MXB4iYFHLqEJ/E2gqrzd99N9WPC1SGwmvwe0rEM4c8f
         wXFr0TqBrBh5onhvOBL2xRANBLnIckUdWh636q3YHrpcZmMK9KC9xPFmN4POWcBk+ksA
         b8Gg==
X-Forwarded-Encrypted: i=1; AHgh+RoSqM+DG6h+e76LX2LtwGJbYNDgZM2IyEjJl4EMiKZ9g7VDe5GdBEFesIYE1hyfb1CFrzRb3eE=@vger.kernel.org
X-Gm-Message-State: AFuF++n5dcSfNcHdaPpKCMQOJo8DYCE9ob+c+8qp8la4qyYE3OyuxID4
	vm8HEnLqWHo5K5XFghKjgl6/6Rz3x2ZNLc94q48DBvBVImIvUwz3ef+Gqzj8KiHi
X-Gm-Gg: AR+sD12VNtq6zEQith35aMbJKEtn+mYG0XgooMODnD70p9vTQZH79uZLZ9L/36yD7Ho
	QJ+CbeJx0xQhB+ZZUDI56Pm/A/c8oSSvumKAD5UJ3IbIZ1CdCtwyx8w5l4SZMPLzYH23kKnPaG3
	yj0q7QIUsfx/yR0CjprQ6EQjcwldYsvf73vgo9aq/Y/7tqLIQlB3g0PeAKNB9KxaJp1xkjxwU4d
	HmKJDqn7j8pepguvM3H1MGhvvRIN70pycWAnHbyBDm4iy6TisXd3wKQ4BdUTC/yKXoZ6S42jM2b
	4OYnFsZ5Q2IxnfpuqNEw32d2ThYHTTS77LhC9pYcfar+MDsXTUsgTgshaX1Gn8nCwadaLPYv4vX
	ZoOt5hLBG9Qq5qnjBtibznh3F7zxdOjkDBOLGZDIngdItT7WPtMBk0Zy2p97Wj2CelXnNnDbzlC
	MDHea+/eXrTA3G1VTTKjwgUUv1awfoK75YkXZH1lIr6+E5Lr5SUB0GV1ya/tje8A1MQ2++0cpOR
	OwWjad8yvEGbxdBgJozp5kfKFYg9Z5M1NxN974ZkivQFBvkoe790WkV8J5loU3YHf8COtP08tbi
	iL8IK7wcT0r/zzE9d2IQzPfeyl3Y/Zho6Q==
X-Received: by 2002:a05:600c:3112:b0:499:db6e:40a5 with SMTP id 5b1f17b1804b1-499dc6fba17mr110628085e9.4.1787803374232;
        Wed, 26 Aug 2026 21:02:54 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-154-097.95.114.pool.telefonica.de. [95.114.154.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd5721a0sm43485315e9.4.2026.08.26.21.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 21:02:53 -0700 (PDT)
Date: Thu, 27 Aug 2026 06:02:22 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fuse: fix GCC 8 build with CONFIG_PROFILE_ALL_BRANCHES
Message-ID: <ao-2iab_bHH5ZFlU@gmail.com>
References: <20260811195733.38489-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811195733.38489-1-kmehltretter@gmail.com>

On Tue, Aug 11, 2026 at 09:57:33PM +0100, Karl Mehltretter wrote:
> Fixes: 25307ca50b815 ("fuse: simplify logic in fuse_notify_store() and fuse_retrieve()")
> Cc: stable@vger.kernel.org # v7.1
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Just a friendly ping in case this got missed.

Thanks,
Karl
