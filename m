Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E004CA788
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601382; cv=none; b=XcQgFawGX4NEnL0TaFl7DvXSzqvUYuA6F0hvN4TEuNMGyqV7wjgijiZWpoAjOTAV7jpg3F+EpAMs5AqZue037Znum0/h27KJJ6U+d/exlV+wNh/vtb5mW/l3pLPaJ8IaN7uC0tH6OpOREAa/p/GMRUoAPzk/qb+ue5Rw9kY2z0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601382; c=relaxed/simple;
	bh=M7/r9z11044BEXueI0sXKlvgGUnc/ShaXxu2aIwy058=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hF+ljcK05SKfpm+0783Jekf44fzhYDT35P8PrGdnJZOUaXsZUrZln7YjVnNHbnVaKPSN+1qxh8EDdo1ToSl9uLys20KyLWFvd2Q7bKCuMIrH8iDEIX5SyFERArAFw2SPDalN4GknVK9aTXA2WqehBOOKm44QFFDggxal8TPjhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=everpuredata.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=NJCGka8t; arc=none smtp.client-ip=209.85.208.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="NJCGka8t"
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso73605a12.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789601378; x=1790206178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2Y1/E+KkWUlA4bQH0tTik8e0gsQX6ODEq/ubCUUF7Y=;
        b=NJCGka8tqxMvZ98Y/+cA9PMV02z1Lnl7/aLM9VTpbvGj/nun+Ixtw/28Pa7pYyb5iZ
         2Kkko5ohIqKHoFVMxiqnqLk4NQuXbiw6rbzeimtC3kVm+0a5mU/ok55To/qV36uM2/mH
         cywYcNJjaPcAQivgohpl+wwH/cKnGzKqFMqrEe8C2wZlpmjNyexUOUC2wdkwA2+mszID
         wnUYBXhJhNchlcwmhBBA3UNhQPE3JAaGaDAnN0oC74eJqIrPkIkwG9ABSNKg4D//lEkm
         Zsc6L2ejy85DHeP+aYCDxiWhA6eu45kVEu3oGe4wU+Sp1r3tAGVb6FnT26HAsBXZpEaf
         ZIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789601378; x=1790206178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2Y1/E+KkWUlA4bQH0tTik8e0gsQX6ODEq/ubCUUF7Y=;
        b=Qmq4oJYJGDg1Yv9CVS9e8DfwgB8yEJ//WSPssoXYpspP98+tiX97GR35jWWMw17f33
         1cMbjmOB3p4TOH+ZBxSatkZAIof+7Ew3sm8CrnDTS5kR+/dswWgKAHUbBQKhz6k3wo2L
         Yn1zikNBCSICuA1eJLUkqywIuONqWpXj5d2q3xMjU7+NTG4oo4y/r5VMNpIROGKBbNUM
         l6JmgnghAc9CMFVu3uvgJLycAyyBU6H379pkJZ2ry1ESE+PT5Mrrbom2uesPoarAOf16
         MBkKUm0WU/AOl4zz8rzDe7v+ADIe0VcjR+Bct1R59TD+pFhs3INdHTRuFhNXI9zPdUXL
         Vhog==
X-Forwarded-Encrypted: i=1; AKwUvBxZHqYGDNbyb0Q7khZ3WoFrW+QAWylWizrWXF3IDXGeDBqWEtZtlEv0BdNgUaEcuP5aW8Rxpqs=@vger.kernel.org
X-Gm-Message-State: AFuF++kaVdqQEKTFkhxHFKP2d8OJ4dJiGl/3ylfGT+PtO+0zh4A1eoc/
	1JrxZnAE4J1El6/26cc09h9K7RV8OHhVDQt4+w8lFSDbghhhm6XvR2NEhxph+LsR03gjuWfgH4v
	ebf9Iw0ovabhjOAipIxv8lAzLm8gUdGlZi5KF
X-Gm-Gg: AYBFou3iqisxMeCXdH00PrDVPP4U9mjQVeBL3diHMuX4iJnwuQKwiEEsRPHM3YnWfEi
	pHovcgTSx1nJrrGL0vTqTS0J0wjd5k0CGD/jypjjIdZlG4nR2ksILr3yGqTPnZAXVVhMBDbDZrO
	CUEQnx2KWGFWRnMifYVgw2s74brE71GDEo5U3TCr9ncL502Zel7xEGvU/RzAAXum7KYhUO9rhRc
	B/Jn6ImPjElLw+75c1aJ7ZrVZ3GPsW/n0W+JZAR+G2ajJiANVKKJhOa8WyuD+xvCree3wZfK8ZF
	m4ZhtufznJAGJL53+qaFqLYmScGixL1u7BRFx0sTM6u3BQQbYUfGfo0st/zTu+wGkl0Jh26NwM3
	OgeoLng/Xo5UYjRNnQvYcGAPRncDnOMAXrVKuoZY=
X-Received: by 2002:a05:6402:321b:b0:6a9:9ac6:c3dd with SMTP id 4fb4d7f45d1cf-6aa22369d7fmr3504276a12.14.1789601378380;
        Wed, 16 Sep 2026 16:29:38 -0700 (PDT)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-6aa1d2440cesm1487105a12.5.2026.09.16.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:29:38 -0700 (PDT)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id DB0333404F8;
	Wed, 16 Sep 2026 16:29:06 -0700 (PDT)
From: Tim Menninger <tmenninger@everpuredata.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jon Curley <jcurley@everpuredata.com>,
	Eric Badger <ebadger@everpuredata.com>,
	stable@vger.kernel.org
Subject: [PATCH] pNFS: avoid repeatedly cancelling I/O for the same lseg
Date: Wed, 16 Sep 2026 23:29:06 +0000
Message-Id: <20260916232906.4101987-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is
recalled or revoked") added I/O cancellation when an lseg is
invalidated but still has outstanding references.

If references remain after mark_lseg_invalid() clears NFS_LSEG_VALID,
the lseg stays on the layout's segment list until they drain. A later
scan can therefore find the same invalid lseg and call
pnfs_lseg_cancel_io() again, even though no new invalidation occurred.

For flexfiles, cancel_io() cancels matching RPC tasks and disconnects
the associated data server RPC clients. With RPC/RDMA, repeatedly
cancelling an invalid lseg during data server recovery can drive the
client into a reconnect loop that consumes effectively all CPU and
prevents forward progress.

Once an lseg is invalid it cannot be selected for new I/O, so the
cancel_io() callback only needs to be invoked once for that lseg.

Record whether cancellation has already been requested in the lseg
flags, and suppress subsequent calls to the layout driver's cancel_io()
callback.

This does not eliminate the RPC/RDMA reconnect activity during data
server recovery, but prevents repeated cancellation from amplifying it
into a client livelock.

Fixes: b739a5bd9d9f ("NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
---
 fs/nfs/pnfs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 70d20f779678..1266420bf491 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -44,6 +44,7 @@ enum {
 	NFS_LSEG_LAYOUTCOMMIT,	/* layoutcommit bit set for layoutcommit */
 	NFS_LSEG_LAYOUTRETURN,	/* layoutreturn bit set for layoutreturn */
 	NFS_LSEG_UNAVAILABLE,	/* unavailable bit set for temporary problem */
+	NFS_LSEG_IO_CANCELLED,	/* IO cancelled on behalf of this lseg */
 };
 
 /* Individual ip address */
@@ -692,7 +693,8 @@ pnfs_lseg_request_intersecting(struct pnfs_layout_segment *lseg, struct nfs_page
 static inline void pnfs_lseg_cancel_io(struct nfs_server *server,
 				       struct pnfs_layout_segment *lseg)
 {
-	if (server->pnfs_curr_ld->cancel_io)
+	if (server->pnfs_curr_ld->cancel_io &&
+	    !test_and_set_bit(NFS_LSEG_IO_CANCELLED, &lseg->pls_flags))
 		server->pnfs_curr_ld->cancel_io(lseg);
 }
 
-- 
2.34.1

