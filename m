Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1103BD22E
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231729; cv=none; b=YyNdtcodmwXg1NOZmOqKu6sVBxTjt0aYTOppoQzKVF/GmX69/4lvu4d/6DcFea0gFlvCYhhA82QwMzNQNEQRxHpOucm0/3xs6F5oEzolG5mJmSgruIEHUbGmYZ+CW4PGhhxu7TZeEUg+v0SQgLeS5E4xFEDjNYfxQtv5cJNKLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231729; c=relaxed/simple;
	bh=KwdQfLFN9qP1Uy3/R/YcRZOunp2/x7+DEgYdQS30umw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVhTLr4Tl1g7Asi09YMv5hKNXIWewdtRrdA0xpwxTxvAD5FVjvz6Hm1VOiM7WvlVUxoCWnjbn6nynsavL4yQE+OtGgR/IbG38NJ/6w1Zo9dM/DSgQY2w20ZwYQiYcihk4kwgTpW7Ju3rm5Yr8rVGLzBa4ZpevSrKvEiRe2yvyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB/S2IO/; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB/S2IO/"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so1016952a91.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790231727; x=1790836527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Lg8cX0rN3DBpAk0/WdaoBs/N2TVrxi/nNoDNY7O6wQ=;
        b=WB/S2IO//rXoRKsFY2qtbT5OHCjIG7gIDF1KxEOzJEOlWivUzysmjEDZL5E/myYEzP
         iOwBF0iLSus3LUQgxim59rVttHEjXpTfxH/7j9zfjEYq2D+DllREyBfROhiokJyoGgYS
         L/hvmAZJWn4DVwHWmbiBiYpVi6wy6sMC0YJVZ4OOWAUwiE5zoNnTF+yoy9N3c2w/2zxF
         xtoGal1OT7t1U8Es1njO+uLrowjdn3mUDIsYXyoDGwMFWj7K7ITd0mmqZlm8+qMHNjHU
         uALXdzvD6sKn37oG58YtL74X0Fxi+KiPbrQikOMuXhpP8ejRVn7Ov/Zr51nEwGFYesc0
         ERzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790231727; x=1790836527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Lg8cX0rN3DBpAk0/WdaoBs/N2TVrxi/nNoDNY7O6wQ=;
        b=a1iBLluqfuOW9bY9OHmDUuhI1Vl6W9iPlqC+6KshL0DNQz3bf7VmGHinmyd9DxfAhq
         ojnO2rvRBKv35XN9imeZL9tCdJbMqtxnm0cYpUV9bGfPF+ZlifEqEea7+0352J75B4uH
         N+YUE0xh/ChclZL2ywJfx8Jaf5FWE0UclFVE19w0A/TZrCvZ/PI80FfpdAL+K6QXTgsg
         KHG8HXFLgC1nVjVKKztkOPRnF52OF+9M577lWLlhG930YZSpS9jXQyqsgNxF2sZfAGwo
         c8+Y9OErdiINL68nCGI/IY0KkD84YYU/GhPR+h4E1yG08mlN9M2MkUbjSP7f8LPz3wUz
         WrCw==
X-Forwarded-Encrypted: i=1; AKwUvBygk5iLqk9sS1XPGxWZAD9mGnB2v6ZB2608dI5Z79SvJs54UZPuZ6U/J5IKnhIqvg7wvBLgtz4=@vger.kernel.org
X-Gm-Message-State: AFuF++lkxxkg6ok9Fi/4zBcPBBw3MP77tRmDMFxWwie7HAG5eMXSckE5
	cSX1iHIcvRkaaR99YPvzrhHnBo16SR66tC8JLTjCzy9mz17clSDocPNspmb9bbPN
X-Gm-Gg: AYBFou3F1kawivksCDqenf26c7gDT6SUJwo/WxqTnxDvlC+wBP2QNwf7Y8V+eQds6E5
	f5ejVtWZsvm2Sy9do/QfsZBxhkXJvxXnkpbG5aH7A/4g9Rr61TnIRdpWFqwDZC+rcIaEDgef/eA
	oWQi2BFamXvWmvlbGB0f2oGPwgZYhrFI1L69A//k+jvcMqZR86y5BCUFzhaJZxnRCSD3k8w+C8E
	QRhB+HplW4hv7JWMub3eJSUlrKQqNgSmRLk84U7EtIuj1h/F2DzJaj23KVEDYvCftJybOGnIxwM
	KaTTI+0Q1QZ4wOOKXkoIpViDDj6u8le4uPkhxrLn+1KEe16CU0K0TLkMnfb9Db+RtnsemEs2s5B
	inBFGMx9EVG1rPHoh8ndqf0xZ25rgiCOUZVWv2JH3WMqXW11f20ODYvqqBp2mtQSTHF11acFIdk
	hAmO6eulPfs/hdHk2beFwopqtJyE1sO7kTjNgyv9myWOZzJWyyf2qg2szYomsNBxO2kYBJG2d7d
	plwLXLYB5WNq1PnE6OWYXtl9kIDZyndWJrj/VyC0HgPVwfiwrN8N838ljkOnDS+5TxiMFxj7Ue3
	cGw0dj028BJ7iRxDgIOU
X-Received: by 2002:a17:90b:55c3:b0:39e:6a81:f34a with SMTP id 98e67ed59e1d1-3a098bb630amr1174600a91.36.1790231727242;
        Wed, 23 Sep 2026 23:35:27 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a096b8753csm3109897a91.0.2026.09.23.23.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:35:26 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 0/2] io_uring: fix CQE32 and CQE_MIXED ring refill handling
Date: Thu, 24 Sep 2026 06:35:23 +0000
Message-ID: <20260924063525.2500081-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260919203516.2581409-1-benquike@gmail.com>
References: <20260919203516.2581409-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues in io_cqe_cache_refill() and
io_fill_nop_cqe() for 32-byte CQEs:

1. Restrict skip CQE insertion at off + 1 == ctx->cq_entries to
   IORING_SETUP_CQE_MIXED rings so pure IORING_SETUP_CQE32 rings do not
   emit bogus IORING_CQE_F_SKIP entries.
2. Require 3 free CQ slots in io_fill_nop_cqe() before emitting a skip
   CQE for a 32-byte CQE wrapping across the end of an
   IORING_SETUP_CQE_MIXED ring, preventing an orphan skip CQE when fewer
   than 3 slots are free.

Changes in v2:
- Split into a 2-patch series and drop the third hunk from v1, as
  requested by Jens Axboe.

Hui Peng (2):
  io_uring: only insert skip CQE for IORING_SETUP_CQE_MIXED
  io_uring: require 3 free CQ slots for 32b CQE in io_fill_nop_cqe()

 io_uring/io_uring.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

