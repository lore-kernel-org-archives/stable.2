Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523E547066
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 04:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435483; cv=none; b=lmZ6d5vWZJuNoXv++Yykmg8qanFXCfk8ES9a9AV6uEqnW5Yv4Ks5dhGwO8YmNL9XAR9YLkh4xH8609FbhTuyMPiLRTQjeUpK1BvLtXiZRITTohsJnRLeu/SSB5nqOMka7zoa5crmJplXehhe3dg9qyLSQibgXPq2gugfjjp11YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435483; c=relaxed/simple;
	bh=ry7qcL+KTYlKF1LPNpZq7A6xD2fogGghfV5zWwdZN8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGLKov5ksrolpbIoK3v/VlIYVkG7YqJsC1JUSH5zRZoNOhriiJJQzPjh3yDGVU+bUGwnO/tAvGqrp+T2WIFVxzZA3AO4A8Yom3jqhAZ9S8gZL8D8roI9J8kSzFeeaVN1/Xovt20wkNKedSNxZGEgdZTBCmCKcUbhQKXazJ686x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=HYgaP9YW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="HYgaP9YW"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-535179e995bso26185211cf.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 21:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791435481; x=1792040281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PY3JPfz0mZiAP588/fUPy9pcwAQqSqz64bfxasIy4mQ=;
        b=HYgaP9YWWNK1FVw7WE/Nxby1AnneOsngfBTfd9XnJpNa7/G3LinJonzw1zXChUatOP
         ejg9IJhxnDQdVmLV3dV3ng8Eg00WkhNvRdNbwox6KON1MUGq0hDrbdcMZdmBphFsPX0m
         0bl944oq+oZfJvKz3AVdHhAYEq3RzRfaB2d5+L+cm6Kc0O77dMTwUO4MvZKZMWdpzwyX
         MgMuKnUju5yDXXwbseKE4VYuvuSQ5R1qJPDESBAwW7XK4vNfcfaOKoKGN7K9AKxL/QcJ
         wphCDosfQoQTWtTgKB9Bls9bQGD+Wh/hH/RBvh7C41h5Zvs9VbTkQdAQ/vGMkUU2InvV
         btAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791435481; x=1792040281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PY3JPfz0mZiAP588/fUPy9pcwAQqSqz64bfxasIy4mQ=;
        b=YkOOCRWKucI+bUZXo2+nTZgcznJaXboub5kLxJFOeQuG9066BsWIktkImztt6dMC7n
         201aIT4Gaz6aEygEClTmY5P26Fy1JvropEuHIWsrhEVlW3ibrU2DPEfxCb/q0UcmU231
         fwhC1qv1vajYcsBl7SMhKpnmmbSQro1GMfE5m9ebhXfVZPHMjgo6vqOlF58hXJVkUZt3
         jcm74gprq+4n7AdSRDSAO49hlrb5E3u3uRkqMhlf5Yhj/dhkk9cBK3BOSmR0Ds+WMi6K
         lDcNCebI4VidYlEBJlYnQ3d29awOwbUXSAMXOCB0qcbwYzI/5RTZ4Zz8v/9QXx/ZHZ5i
         ad0w==
X-Forwarded-Encrypted: i=1; AKwUvByRZtZFGIVAjKVp+5q3u90/1lIMgBX4qhUGCq0A/GQ8c+vrLoSrsSQdx8CJAfdgWhBqi6GDBV0=@vger.kernel.org
X-Gm-Message-State: AFuF++nDSbwEXJcDRplnpVrALI8RynelSrgw5aghV14/Jf9V2zg2owW4
	jZ+eWINnjEstlUcQgHdO/BGLl3vwHbz3rlYbUMNwltjIoCjKZWiBj6NiYPryWsKnxnI/fK0Pg26
	VV13shA==
X-Gm-Gg: AYBFou2Q/Mxa2FPgXGVwL2sqF4AOUOA3DrY8cTj+ReCJD3C6YceEDHY7UpmmLsRChRE
	tENHkG9Z8o/Ir7Cc6UwhGImVaarM16uV574gdarZFdhMfsSXxjhAWy88uJDubUllRlEk6VCC2B2
	lXOwwuxk0eRSNrjElp+JSuVq3yYf+paAkwsuwptptWEk6f8SHoq+UiG2yr+96RKr9NrcVJej26u
	XwQYMCrRAoDJVeXd9ZI9PuXvu90krsUMAMLU6SKXIqDR043rOd4BuXSoWz7RzbMfTC/4n9WXeHn
	z7YRoFCooJCRp8PTuFH99iwPqx3a6DDYFSsiPP7b0YWiZNOCp0k06VUYW6W996wtNQg/bk7ogaJ
	Xg/Yt/8w0reL6JDiR8NF+KUbSY/4qmGWOyW9dEa1G8lkNvKHkxDM2fKLjWd7B1vMF6q72O1Zg40
	k+eRjDXPFawxv/ESU6dHPIbLlPvy4w51fKrUI7Ax8vp8P+xMsKkLuVirbSLmGQ+lIVf02ZNdH4b
	+NEHPopXh92r80/aVlgDA==
X-Received: by 2002:a05:622a:2592:b0:535:70b5:2387 with SMTP id d75a77b69052e-535756c1070mr78376951cf.71.1791435480618;
        Wed, 07 Oct 2026 21:58:00 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996d82419sm37532046d6.40.2026.10.07.21.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 21:58:00 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: axboe@kernel.dk
Cc: dw@davidwei.uk,
	hengyul@cs.unc.edu,
	io-uring@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] io_uring/memmap: only charge pinned user memory to RLIMIT_MEMLOCK
Date: Thu,  8 Oct 2026 00:57:33 -0400
Message-ID: <20261008045733.773725-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007213903.445430-3-axboe@kernel.dk>
References: <20261007213903.445430-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/7/26 3:38 PM, Jens Axboe wrote:
> Charge RLIMIT_MEMLOCK only for regions backed by pinned user memory, which
> is what the limit is for, and leave kernel allocations to memcg. User
> provided ring memory keeps being charged, it is pinned.

Sorry for the late reply, and thanks for picking this up.

I tested both patches on top of v7.3-rc4. The test case from my patch
prints "64 rings" again, kernel allocated buffer rings are fixed as well,
the per-user locked_vm count is balanced after ring create, close and
resize, and the liburing tests give the same results as before, except
that read-before-exit.t passes again with the default limit.

Tested-by: Hengyu Liang <hengyul@cs.unc.edu>

One case is not restored. v6.13 did not charge rings created with
IORING_SETUP_NO_MMAP either. Number of rings created out of 64, as an
unprivileged user with the default 8 MiB limit, 4096 entries each:

                                     v6.13  v7.3-rc4  this series
  io_uring_queue_init()                 64        16           64
  io_uring_queue_init_mem()             64        21           21

PostgreSQL 18 is in the second row. It puts its rings into shared memory
with io_uring_queue_init_mem() whenever liburing has it [1], so I expect
the failure they reported to stay. I have not run PostgreSQL itself.

Would you take a patch on top that leaves the SQ/CQ rings uncharged for
user memory too, as in v6.13? I can send one, or test whatever you prefer.

Also, kernel allocated IORING_REGISTER_MEM_REGION regions are no longer
charged. They have been charged since they were added in v6.14. With the
series a user with an 8 MiB limit can register a 512 MiB one.

[1] https://github.com/postgres/postgres/blob/REL_18_STABLE/src/backend/storage/aio/method_io_uring.c
