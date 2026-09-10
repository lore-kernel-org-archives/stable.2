Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B637DEB2
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007119; cv=none; b=eiw6J5CLh6UpUiOqcF7SCM02Plae1V7wIZr2ObbIbZjtukBFu5MLjIAz8XQ1BSsyCwwPgWzMWhr1fHeVSZ08IZLhnza8etD4GzDroz6xzVCtPB7GGEWdTsLAsWb45s/pl3bedTUuMHD8FxIOMWsisuwL6/v+H6GFRNwRfaXRt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007119; c=relaxed/simple;
	bh=h7jlRf2IsDI9qQdqGv2bSdvzHPNhhTR1Nonfg/W40cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/n0B7Z5CL0naj71Z12YfsabCk3ksLnFPSRCCpdnJ5CcuRJI5BVUBKi/3JyP2GDE55Py+yK+ztRQdFRQGIIs5YVUSFAfBqsojbZU2VpveTBCf4Q+4cvYUgeXpZOqE97xOwxbqaGYTFCmzqtkYnUnmpRycRK13mwGXsSPUKTZYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=L2whPWgI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="L2whPWgI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d91ff7d9acso57217865ad.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789007115; x=1789611915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+mClRprXurGsMr2UxPPq1/QlRUj/VLPAMpoAcj6a2AM=;
        b=L2whPWgIXodOTfJfr3JwG3F5vO9y5tCMyLCBh7Z4vmFpj2dt7DB6UHuxwMiCCmP+Yj
         q/WaU65CJNtll58G8iWi1U6FmeYUpgzWz/BUqnqvNxzNKeWtuloSvajiNxFWTX7kpEQU
         tH7hWa7bSFcizXwOH7V/EO8GksAhwNL+orLBq6K6SVD82LTEeiBmmnKoyqzUgEcg4fYr
         IO64HT1l7kAjd4MyCZufmvWg1rmnh1NFZGrxgyWX1pDGTvf/oAJs+2nIgZ/F4zTK4q4l
         WGW5yWIeffU/yGjcnyn6FWu0ZlZdAH7EZkURia20epwBhGaT+OLPmm5qNNjTt1dYW1cf
         Xd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789007115; x=1789611915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+mClRprXurGsMr2UxPPq1/QlRUj/VLPAMpoAcj6a2AM=;
        b=B4n9iyq2yefk+9srPkM9pevStps+6ItVFADuzgZSHbhQneicWRlx7a5V1Pj6fb3DgI
         wu777PRbf/8FyvxmuX4N+ae5TwR6eyfeAhvdB/iGR9j+lcvVktgxvhTHsytsf7er0yQA
         ePnlZP9oxvyNIOaw8XRBbNWhBlS+YI+moME2BC+7usiuIBRaD07ziJpzN3Jxk2iTwC4l
         3wA/zj/1/zA2P/jmPogxwzMyBUActbLRFafYWWMSTDt+Ihoml2ygmUhR7grdthxPDYCZ
         XE3Wo0cOtg2SWUEK3MF78obLWy4DCWs9EfYrYtzxwFsUKo8daIsp4M8lhtvUkkOZ4zoL
         Roqg==
X-Forwarded-Encrypted: i=1; AKwUvBww9jJUioi3RPJncbdjU+vvmd89oGetCl3hNZ0n07u0A1ZNU2VAV6OKVUQZH6D53Yy6sDn/gYs=@vger.kernel.org
X-Gm-Message-State: AFuF++ntgM4fdm9Q1eugZxZHVgzi5pvHxRhuZgW3uIcoaOmrh2aZkbSd
	cju1/bMJWsAEWamBhhzTn+8RQvkeAhVO1RhtblbskQ0jz0EqEdB33Vx2Z6ZVh2gO8A==
X-Gm-Gg: AYBFou0g4rG4kMKAiM7NIuctahTeqZVYcyrKjUGB/0LPbfJtK1DOztHCMh2fpAv/tTF
	0REP0yv+ctdnv4rWGXaqzi8WEutVsGKIhufj5/pWycKMUtAt1YGxFOINNUOD5cBaySBQyYlWdAU
	BV4YpxIEiKQhcVJM8o6JuMCByAvHm8kIeyzKF5amPKpDxV9cplL+4nnN1Bh6Q7U+6FZ6URQ7VB7
	IQ7BWBQ3mut5kIn0PO8n4Mo5dkfxfSk9uCeFJZmZ2X+WmGJhFzjH6DRL9E3/L6wKtH9NefC5v13
	AvlwE5SCFiIaDCEyRfA4PhSIUlee01w9qNFSPr3DUUhAe0mj7g6SMsN9KffsNSwTMayLD58/SMi
	PoaDyQmr55qeNFkSebFFk+/xXzmf4dmZwFTgc3aKTS3xqDlsIOGbfkXShciyW9IyP5SpL13/moY
	Ieb5J/dCvE7s9u7PS47tyhuNFgueR8idTmm1CS9k90geSDvkIeWyCq6pF/UsbE7671vE18ELGxV
	svEgo3uQNzKpDD+CFuJNKynji33elR90yjllqaGc41I4w==
X-Received: by 2002:a17:90b:498c:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-39b260d3351mr53425599a91.5.1789007115401;
        Wed, 09 Sep 2026 19:25:15 -0700 (PDT)
Received: from p1.. (129-219-8-31.nat.asu.edu. [129.219.8.31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1435c2ae6b5sm2688847c88.1.2026.09.09.19.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:25:15 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: fuse-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v7 2/2] fuse: return -E2BIG for an oversized SETXATTR over io-uring
Date: Wed,  9 Sep 2026 19:24:42 -0700
Message-ID: <20260910022442.3594649-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910022442.3594649-1-xmei5@asu.edu>
References: <20260910022442.3594649-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dev_do_read() answers a request that does not fit the server's
buffer with -EIO, except for FUSE_SETXATTR, which gets -E2BIG since the
value may legitimately be larger than the buffer and setxattr(2) reports
that to userspace.

Over io-uring the copy fails with -EIO for every opcode, so the two
transports report different errnos for the same condition.  Map that
-EIO to -E2BIG for SETXATTR.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 fs/fuse/dev_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c6dd420c4034..6351f2470e09 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -893,6 +893,8 @@ static int fuse_uring_args_to_ring(struct fuse_req *req,
 	fuse_copy_finish(&cs);
 	if (err) {
 		pr_info_ratelimited("%s fuse_copy_args failed\n", __func__);
+		if (err == -EIO && args->opcode == FUSE_SETXATTR)
+			err = -E2BIG;
 		return err;
 	}
 
-- 
2.43.0

