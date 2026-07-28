Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014E36DA03
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 04:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213797; cv=none; b=koWPwsaZT0f2vf6g6yz6vkP+wouPpaHD51eFoM98lJSyLzNR5QmkC/gcG4CYt4fOzAAcmeDnmcNoS8K5p0ccSzjDshsn1ZvcG9PahcmpkpYPYECPP5wlj0D8xpkLuE9tEJyVu9/EQAeQTeAi/iOupm+d2WUHnnLedYsWOEVfiQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213797; c=relaxed/simple;
	bh=jJpszBGoy5FGOyrTjZQKznWbaJbD+UBBe4S38IMy5hI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=bKGP8q+twMyNRcOpy4i9Af13gyp9oYoNG2x1qUurareziintL6h2jM3GniuGxd7Cf4MI2RMAHzqQaRDd6T/yeXr8pdSkiQh47/DbtWoFCoSHMSYQNyKdt5s5wDGVdveFe3lE7NlEv4pHoUOr8TO1X1JPCUER174PYLb2NRgQj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsCflSy/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsCflSy/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf50c6f235so41544915ad.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785213796; x=1785818596; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nUw5BzeKJfn5wcTEAmcbsTWk7Oaq7UZh5ULj7ews2Z0=;
        b=ZsCflSy/C+oge9NjKaEyU+xuohZSnshGxBTfVLUibs7nUId7ELuBIXmrAj9iP4Lt5b
         4xPS/Lc8uFXDujO0oEZ4VILDTkvVxIuB925HSkCLjtKX6YCBXH9nrHO89UURTr7rrOAC
         GT8lPyo8R1+5GFmZ+/ZjGD+7+2s5PGvSE1DKfUNYmZzgN7utxi7uY0No4hU61UQby6Wq
         3Tq2ASm8w6nqvPtLZJv7kLifeCIpSOo5DL/PbR4wVZDqVRoXdPflgV2A9wGLEyZahqDh
         qvfk+BRqCY7vCNSxhvUCjCWqoLPX91PsyKhOTLKnw+OhhK4zZejk4tSK0Y0+U6Fprw2g
         JvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785213796; x=1785818596;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nUw5BzeKJfn5wcTEAmcbsTWk7Oaq7UZh5ULj7ews2Z0=;
        b=Ng8jxbaQGKzyPc1hZC9ABfuOGxsNC2OWXSxMh/QvRMuGrs1Guux/H9YkI6Agoq5Gbe
         3T+JAKEUTeGF2vyPkMuM4EtI6kXlwLRCrZGaUAe9HJ1F5acqWTll55geFr+q/A67kAuN
         WQQFFkNBK3BkbI0szaW1mqK5s2UKdV37iLMWaG7xuXGITTgF/F58xT+q0K+ql4xVu4zE
         kZORvrSyQxTWSg24hqMqBwpz6yZRNB28cjSqqrdDgMc32YElVoxuycUjYHn1fDa2kJlf
         HfeV690neLvloAlq1rE2JWTKxntTnLs2OfcbgKS182gbiKikIkImZmV9uxeQe+znA7eB
         Vuyg==
X-Forwarded-Encrypted: i=1; AHgh+RrSv7hWlcSjTYayyUw+m4AWzeNNcknjZ4iReALg+0JWzbrR9vMeU+aJdU7BoPKlKYTEPTA01oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoAopxyNmN1pziDeoRkOpsmUWFXKd5yIyM9Oc61qYJTFeQsxj
	hQeiD+RLOhs1HHLyj0y8tub1P9M5fkmFge6UqVJOtMTtsC5+nfZBo97x
X-Gm-Gg: AR+sD10+3yDbzVpwB9G8PtKNj19EVLyec0sSA5uENTPNaczQS1eqgLtonDhvyuHJVzn
	ZAkPg+WN7w3KtXfC1KXm6PvEOiprIED6FS/G/uFvyP+FtuUmMBnA3Iok/GtWyPmGizkluoA4pkO
	bFycKtYWMswU3wOtzwQrFfY0hwRXTHXuBOIIWh85DIzYgj9k60LKRLyIvtwYPjLMGb1DYzFlLEW
	tcZ9C0Qbw7pj4Oy1Kc5lSk9kJs968IFPE826sx4mL35nA4PfIX6WFFYaBhhbwFGwsV/nD5VBZdg
	Rm/BYIbNpeibtkxdXVyJjJz0Osm7tOYw6uRCWrkKrEqFCVMXRlr/rSO34vyTb0prEgLbOpEkXat
	ey0fu3QGdewKIKOQFYaLyx8fyLXyrxls6BgNsv5LHIbrZImD0zbF9mBhNJ5gyvn1uZMckHVwlX3
	ul
X-Received: by 2002:a05:6a20:7d8b:b0:3c0:9c1a:893c with SMTP id adf61e73a8af0-3c8ba650afbmr1226800637.68.1785213795815;
        Mon, 27 Jul 2026 21:43:15 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm41150994eec.18.2026.07.27.21.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 21:43:14 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jiazi Liu <jiazi.liu1984@gmail.com>, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jiazi Liu <liujiazi@amazon.com>
Subject: Re: [PATCH 1/1] ext4: fix incorrect function call when initializing s_resgid
In-Reply-To: <20260727104103.28916-1-liujiazi@amazon.com>
Date: Tue, 28 Jul 2026 10:10:07 +0530
Message-ID: <cxw7n2vs.ritesh.list@gmail.com>
References: <20260727104103.28916-1-liujiazi@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Jiazi Liu <jiazi.liu1984@gmail.com> writes:

> In __ext4_fill_super(), s_resgid is initialized by calling
> ext4_get_resuid() instead of ext4_get_resgid(), resulting in the
> reserved GID being set to the same value as the reserved UID rather
> than the value stored in the superblock.
>
> Fixes: 12c84dd4d308 ("ext4: add support for 32-bit default reserved uid and gid values")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiazi Liu <liujiazi@amazon.com>

yup, that clearly looks like a simple miss. 

Nice catch! Wondering whether this was caught by code review or did you
hit an issue due to this?

Looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

