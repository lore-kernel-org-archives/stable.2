Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E56302163
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814910; cv=none; b=V6tid8a3c2SVrUBt4zIqfwUQvdlXrINs6GmXm+h5c1v0BGdGVPmenT516Ffq/FPFNjdZIeIO3sw8xNKbIdyuQrb1bGRGNds7lhMgj5ReVi9TnsDiq/VPiEUM2aecb/fIvNOmEIr71QG4BBweFT/4OQCdwsBEWA++m8woagGexOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814910; c=relaxed/simple;
	bh=l5SWmHOPEp/fKKXA0NMhkVfZhOFqhqmyUo8J5uUnm1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXDWDhFnU8kuEUODUyIDDVB3kBjXPZIttmpEmN0g2c1E6YSyNtxhaiPahKdO3nl01nKvPcVMM2TNT42K/TmQRP7UItCP+yEStjhsPDfU4A4BH3ds2hGlh8JhPyRUY5h6lhwxodvpqwXTzofhtfoNTuVFfVDuFLMGz9a87aWlXf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eBuaVw4b; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eBuaVw4b"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4923139e940so8136285e9.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781814907; x=1782419707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gI48IBVTEyFqc2Ik1E773JFNV7tYr6QkOjv/gDbHgc=;
        b=eBuaVw4bUn2TW4V0CC8IGUYKOzNnrfM4j2iFV3CdC/zLSyJVLJvxYgDFcnvRW21M0z
         3rawYabr/FgDllEkTrc21IFAuD9woa5qBhJ4aPOLO62Wxo0xFm+Wn2caMcLxINVbC+eI
         RorbRQ/2QFb+mYTtZuDEInyse7ijz1oBqi/LY3V4efSk7bywB5K+AVi9i2DE0t72RqU8
         C7O2E/tSfIRcGZdqAR9wjyMQBiJUpz6VXhlpMUrZFoXNHu00rvZ13haGtKwQWVAKhAi3
         fPfij/I1TOTZJa1yb5HO+nQA+rr1mvzkEuC2cY8VM27a+PI5XURoKDSaxsdJFzUUYa2I
         26xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814907; x=1782419707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6gI48IBVTEyFqc2Ik1E773JFNV7tYr6QkOjv/gDbHgc=;
        b=K/heAjdkoRdDo82sMBVNUzcNMpAhLLSW8FSfT2FJDi5MxttNMyWT5oIReoBY+PEDYZ
         qk3QKC5JBiAHdKYzyMVcBfWcHaARNBJDNKzXg+ztJmQQaeNtdceaI8DDnEl6BuLAU+Xb
         8EmxZbRGtwO5ff3+06wVgOmGyzmwd5nvTbhNAvOsjrJNwTPSDb7HJZuao5RwGF7GDluJ
         5q6p30LPCitOq9MBUzDt9zDgbu30OLVeDas5/CJ/Dy0xnR5HFLaKQ4ljwxUudA1YB9Xq
         uWPfxd1Yx+PPc655C4z73bvREn87VQW2inX038KNZt6/mwPwJXuB2FVoEfmSGD1ZoTF0
         OCjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wxdH4hXdQ0KcEtyZdONSS+3TT4ylRSgjktUwtc/qr/P/5LI2T6Lq/NxIxmWpl1stdjSCuZsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zk/20Myt+W1nlpFogvsQQmMGEGA2u0Ytg5cyNeWKjhP8eN4T
	ZrXCFAp26nzJhYJVRgMzWAVHZrbNDW4r4DTVcJoxlwyQ6LIPU+ltMx8SxbYpwjhDnJg=
X-Gm-Gg: AfdE7cmor7/K/dJl9Bbr0SAstkBqIOj+NUrNFVmdVCpk4VtHFcnSijqz6nwvTCBuJcJ
	yx8beo5n/faamiKyUd+uZrB18U0LH+omNb8lj8Z4oheMJf5cUROnL7oZp25jy2SO8wjQd7zYWBQ
	cqOmNNkUyU9Bn2FyDxCfMUorALq5IHUAbEAKtkLCY07EnAKPRZoAHcLwBwAF+B/cPnwba1Ihl6D
	SQP+jkGcplAtBrSN0+eUUlM9F0d9Nq8NxmivW827U4HmsgEaKmrZzXy37tjGK/NvYJBHcdplamn
	zIv9Cs4mkAhiEoCNF7kicT3axQbp/y+jJd6IPJsb/GdoW3qsco0rgsbwK3FgeX6lHmUPilwV9mh
	CbPe400Pscq2BltTRu7Gm6Admp2dD9A5W8eXMBh54OsRLZX4qTaK1tcKIYAEHhyqOcNTfZlDoPX
	uBH41igpKlfRjJ4h9rWAiVggsyeHW+NGI=
X-Received: by 2002:a05:600c:34c9:b0:492:2f2e:e7e7 with SMTP id 5b1f17b1804b1-4923f5a3152mr19500245e9.17.1781814907016;
        Thu, 18 Jun 2026 13:35:07 -0700 (PDT)
Received: from precision ([2804:7f0:6401:b508:d1d9:f1f3:d91c:79af])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966fc32849fsm439109241.5.2026.06.18.13.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:35:06 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/6] smb: client: fix double-free in SMB2_close() replay
Date: Thu, 18 Jun 2026 17:34:35 -0300
Message-ID: <20260618203438.667881-3-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618203438.667881-1-henrique.carvalho@suse.com>
References: <20260618203438.667881-1-henrique.carvalho@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A response-bearing attempt can return a replayable error and free its
response buffer. If SMB2_close_init() fails before the next send, cleanup
retains the previous buffer type and frees that response again.

Reset response bookkeeping before each attempt to prevent the stale free.

Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 121ae914c3cf..a7b1fbe28a2d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3728,6 +3728,8 @@ __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	query_attrs = false;
 	server = cifs_pick_channel(ses);
-- 
2.54.0

