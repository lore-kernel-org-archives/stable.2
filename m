Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A73AC0D9
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084278; cv=none; b=K2nMXAO212TA2rUMF1+MnTL/t3U5ufnntTtMjIKPV4pSzfwe/S1th3CiJ04RqxIaNC/FVP0tt+F4k9mBmmIuOBocVhTlHAK0XZJFgJ6w3KlkhNoKANDHP0zzBKbqPrRjAdCtEHywBiVfE/WZptd4qdWq1ZRexBBcL8J8pO3Sgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084278; c=relaxed/simple;
	bh=OCNiS8J/vtMzaYGJaTFJG+hDAr7/vODQZ8hG3+Sh0ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8j1XyPxo48IMspWaGBHMlXH1DzWDhCUzKN2YwJjtp13cDEhkdGZ0QP7F5QU+nxcq0X42/ITbxDJ1vfZ7pDiu1n/If5ehcgdoqjRLdq78C+sWWxS4DySggiwNQzDO0qz7b1q8RkC2uhj7XdFp7NjWLCNT6tnjQldFa6utCfNltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=SvtEZn8L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="SvtEZn8L"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d9520b9155so2939565ad.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789084276; x=1789689076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+O46wIvOTz3djUW9pqtLqktDx+oddxG2jyQv83ES8M=;
        b=SvtEZn8LL2fhWKS36//StADSTGWLfMQpN1Ufr2Waw9qAT+xwzIT3pTNYCbhJfo/Niu
         oNmBJIH6jJUryFdvh20M93xKUpFdmPja7EAc9NnN5xHKzVPE+vj2LaKDFZrbhcVe9nKP
         x/zQK0mNSRsH7OMdJVxdiYxNxB0fqcsksCDN3CXSqP9BOKKL2PGTKzgbPMJp4e1cqP/n
         NNgmepXWwpR7Rveue7O2OlpY958mESQkQlgCM1XVr9S+gOUzRhi3QPgEHdB9ycLfm44+
         wBku1MWBQsjIhRaOjAPbzOEVa7syAR/70mkD7Z2UrIj5Qv1CiW6VduWx12dcuGHOYKM2
         lQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084276; x=1789689076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+O46wIvOTz3djUW9pqtLqktDx+oddxG2jyQv83ES8M=;
        b=LaRutlLX2d9cYqWstbD4oArK0zMmNRSAqgLVr8ZN4U/jq/YreOVhnm4fK9acMJOlOi
         Q2XPEv2HztUdDEEzOFawYUgxf89XrCNE3t9EASQkSfdP6WslgZoUtOAEGSy2oFLjpBa9
         fwc/CMeM4hZD2VCD1UvfsassaUA3IL4Yz+Vj0gr+W6UwPN5rl2imruikMP1ngwuVBWY+
         NDfrXFFtAiQAYUOEU3BAm4wjhHDbUoes4hSApTIwyMsI8FnKfV42ifVKOV5RT6M3SL/v
         h512GSrlJg/TgctHf/4ZG8LFlbTjsrtDK9/ToFkmxFg4ZfjQOShH8aV5i7rR5LCHniGY
         hUkg==
X-Forwarded-Encrypted: i=1; AKwUvBz2uuuw9gmrpsSZTKNa8R6+zpePiFqeXjvSHu4be47JFSCAHOHQYBJgdgi7p392V3kYbogDzsM=@vger.kernel.org
X-Gm-Message-State: AFuF++l7vgxU8S7N8uV2/fr8UiTEX+nn3mmGvuHrbDd/36yaWkwNAMEs
	9vB7omoYDDQGEesHf0JILRe4wFoLRibqR1iNxnbWxnWOKFaxNLLZ4l9wmIQkHYRZYA==
X-Gm-Gg: AYBFou0lEE99vgMGKAtvc2Asa8xu5LLOJhTdspmtIH9BTCFYsMh4d7f/SyAcbPER0Do
	KWxNCw99NKkQfz9fNpy/xqn90IH7fj7QqgIkRO1x/aJ7pNjPnZ/hvOD8EwCzaPJSoAnIDw2nZbu
	SL52/a8VaJzOlwLZaVIlRLVhvCT+zrAwB0XMH2XbhOB1bKuIxYPE2d29+UgkBB2h+Vnm0awmaoq
	PTbTiTqoZ3aW3LYz/AChT+Vu0L32Htbkj1i+x2e10TFvYLb74p4pLeZ5FEAdaIZJ4dJobyI2Ini
	lxUki/N90YPCinp8UFBJwb8SybNLdKRDfzHHHuWBok2g4eUwJb7wRp45ZEq+qBSLBajO6cKKkj/
	r3St+IH2QbwZNwtNAtzNikjFmwbtqKijbZodCE8uTftEKmXeDz+UXF+fvkolTr/AjVUnnziSlaf
	X0RM/8sQawm/UgC7GA1YrBCdx5QwQ7IxYreNvKF8FAjqulFO5P/W64V7w+B2+x5aUUsda4052bI
	q3n4C/aQklwawxpjigsIfFUCA/DUVFqQSiciNC18mRRr2Vg
X-Received: by 2002:a17:90b:5388:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-39d9c0ac792mr2047057a91.15.1789084276484;
        Thu, 10 Sep 2026 16:51:16 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm1680718c88.11.2026.09.10.16.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:51:16 -0700 (PDT)
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
Subject: [PATCH v8 2/2] fuse: return -E2BIG for an oversized SETXATTR over io-uring
Date: Thu, 10 Sep 2026 16:51:10 -0700
Message-ID: <20260910235110.3922068-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910235110.3922068-1-xmei5@asu.edu>
References: <20260910235110.3922068-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dev_do_read() returns -E2BIG when a SETXATTR does not fit the
server's buffer, since the value may legitimately be that large.  The
io-uring transport fails the copy with -EIO instead.  Map it so both
transports agree.

Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v7: new patch, all that is left of the v6 bounds check
v8: comment on why -EIO is unambiguous here; add Reviewed-by

 fs/fuse/dev_uring.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c6dd420c4034..460776cd69cd 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -893,6 +893,12 @@ static int fuse_uring_args_to_ring(struct fuse_req *req,
 	fuse_copy_finish(&cs);
 	if (err) {
 		pr_info_ratelimited("%s fuse_copy_args failed\n", __func__);
+		/*
+		 * fuse-uring does not use pipe buffers, so -EIO here can only
+		 * mean the in-args did not fit ent->payload
+		 */
+		if (err == -EIO && args->opcode == FUSE_SETXATTR)
+			err = -E2BIG;
 		return err;
 	}
 
-- 
2.43.0

