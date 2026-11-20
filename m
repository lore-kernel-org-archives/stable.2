Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136626;
	b=ev5xnwYsRHmcWH2BbCLT5mgHPB6FEC1XtvubcRz8ATQZM05+5bK9TDwMaJZIKmq+g6If
	 j86ckET912DC1olOW7IZ2gDfpFkIZHQsINNcdRJDP2jLWJzzl6knASMtRdbHM1uHMYE60
	 kLNRslj+6zZDmEEHLo5beR15RtoiGVW5M0JtTvQiivjXfOvEy4W3Ttg2VU0hAwaqJrPqV
	 Edd00ohGbrAbWbC1St8+qVvPR97wjbIFgiN9jTHJ/zdbwr1/Kz2Y2MZNiIQpoOAmEoMo9
	 Br64p6dowJV6ChwBbd6WWnuyoKwpqZdprXLjxhUZiHW2GWA0uj+Vg7x0oHVa6+XKOhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=f03S4oQ3kidU1WT5hTpJpYxy3HRw9wuocqAofdkvY1U=;
	b=DGtRgwPVVkQpUDaoy9ill5zDB13yYztRITxqetGjdrlUgDnJxjOqElaE2CHpHv8z9GJi
	 TEI40jw9JZcEhhA+BcyI/ZjMz1ELla37fZChialz2JLOTRQpHSqzVuYCHiR43Oh6ZtM4K
	 ejIDcAPI/py7vFY8lJKDcxf46l3NW3h0E84DH2k9iTYQyT9mKE2o30l/MCFpCmEpWVq2J
	 pmU8xWM/1PwxVTTgacEItbjJ1xkbN/If2EMGwOeTD1Hw/psAitGW9ydKXAIFLBsnFsaBE
	 XXxMHKmahNVJ1nc7XcyOdlslhQKuhsdDqMLNJS96JTwO6hxL+qHBm6HnqVfzuFddPMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=TDFA9N4I;
	arc=none smtp.remote-ip=74.125.82.100
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92E606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF92E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=TDFA9N4I
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-1b3acec6677so562356c88.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1795136624; x=1795741424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f03S4oQ3kidU1WT5hTpJpYxy3HRw9wuocqAofdkvY1U=;
        b=TDFA9N4IRZW+Hkx/awuaatTxRTDIxw1qJrdSIJV5P/dKRKVfaD3TS3e0MdMk6gGe19
         pfWrzDS+12bFfJx54MRHHn8RjsM2jLw/PW4UZFA4NtsK7WiFDJcXxKLXx+14HzZRcvnn
         3TLGNtYdT9IlkaFaWygtQmYqcv5Cq+YEDj2TApN71JiIPCGvFuXouY9ZDEKvasRqdno9
         YHIwoIQwGkxzMqZOWIbjXnCIIAp5uaH4q2iTRYcOjekRcwhkmzSE/CHS/6gAzKWlA6v8
         iH/FjIOYoKZEOhZiv0GdKrOp3eizLbo/7mLQIZXdFqFNxCmrfH/9SN3ZjWcBZOrES2TR
         jK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136624; x=1795741424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f03S4oQ3kidU1WT5hTpJpYxy3HRw9wuocqAofdkvY1U=;
        b=2PpW6PCEGT45bZ4/IX/CKm5OQFjeiIaCVoc3dCmbzbip+bk0ZDoxeO5uu+a8/8sJds
         7nb5/xRaFFUGUqAdpS8Saim3E6Uukun5EpEbNj9+Ig3H5pKWc4Pd502Z46JMZ593HruF
         RlaZqXbKG2s2qcMID7kRfla0SRf8/fNrobZpEJ1uNvVdBmerDoe/pVFetvYYJLyM9mfL
         JsvLjOF6Mt75E/02I0FJG8yR9Cu9SDtMGd+cfkXj89wpU4ZZFcLA8DgDUguGgYFXFSTV
         Lb4tdhsxI6IEzySRsGO/gUIUegeHTvNY4b+jGAogyXmT1S+FSySXWM1m5lw+1hAg8bTy
         kugg==
X-Forwarded-Encrypted: i=1; AL+hErG4fx6eOVx4IpXm3JtXSiNb2MAUhWcNZrRrhCjld9l1gUAoChyQiqEIMRHCTcJfo71uDexmID4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aSXoDyYl5LHTp2E4X1D0aNUSBG3wntQSIORnxfg7rB1Zy0k0a
	dTGtiV/j0rGTXz+LRlrp0/55vVPKtcvyzhB/eb72mL6XVqvdM3oc3XCtGfa608rb/Zjx4hXp6WT
	mLVkVselOWpf5QdVrjbZOWKPhsfPJXlYMgfgD
X-Gm-Gg: AZFdTZcTZW+SdJdGXXmKWpEybRMDKo4xAqRvrhYc1qReapssmrKgHzuYB7+lNgvPYU3
	dvtzn4RSuDv0g6FAVdjiPUFAdbMyFqUZa+BGNZ7+py5gqfVNCNFuVX8dh4iRohGl793HQ+vT7jR
	X8FmP9eBozZ++dgglEQw2qEdj1pA2me4j7ZlDhdotfLuwtXs6Uue9paym+mDuFFVXQlpiOuE4c9
	fb0LEaMR1vtL4exrc5dizAx6yP0sGNfbtIGIb/wE6CU38hlfmq0H91epdgyYSN3KVMxWIj3H6Jy
	a3g3sNoNOrcm3v2LzcsA+vkWBE6rs+jtj4ieKMHAF178dK0oI3gJpvGYKdUOjoQ8vvIL7k/Snj7
	5iIQQ6Z+qJ3Y0us60sAZ7274hsHDKHZnR8bk00Gs=
X-Received: by 2002:a05:693c:4001:b0:370:d6e4:e8aa with SMTP id 5a478bee46e88-38570b34fecmr1152737eec.41.1795136623678;
        Thu, 19 Nov 2026 17:03:43 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-385676c6aa7sm94876eec.18.2026.11.19.17.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:03:43 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 97A793400BB;
	Thu, 19 Nov 2026 17:03:42 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: Chuck Lever <cel@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Jon Curley <jcurley@everpuredata.com>,
	Eric Badger <ebadger@everpuredata.com>,
	Shiva Lingappa <slingappa@everpuredata.com>,
	stable@vger.kernel.org
Subject: [PATCH] xprtrdma: Retire the connection generation when a connect attempt fails
Date: Fri, 20 Nov 2026 01:03:42 +0000
Message-ID: <20261120010342.2152535-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a connect attempt fails, xprt_rdma_connect_worker() wakes the tasks
waiting on the transport with the connect error. For errors such as
-ECONNREFUSED, call_connect_status() can then call
xprt_conditional_disconnect() with the task's rq_connect_cookie, which
was copied from xprt->connect_cookie when the task started waiting for
the connection.

The failure path tears down the endpoint through
rpcrdma_xprt_disconnect() without advancing connect_cookie, so that
cookie still matches and the conditional disconnect requests an
autoclose. If another task has already started the next connect attempt,
that attempt holds XPRT_LOCKED and the close request sets XPRT_CLOSE_WAIT.
When the attempt succeeds and releases the lock, the pending autoclose
tears down the newly established connection.

This was observed on 7.4-rc3 after restarting the NFS service on a pNFS
data server reached over RDMA. Connect attempts made while the server
was not yet listening were rejected, and the first connections that then
succeeded were closed within a millisecond of being established.

Advance connect_cookie after cleaning up a failed connect attempt and
before waking its waiters, so that their conditional disconnects no
longer match.

Also wake pending tasks before releasing the connect lock. Otherwise, a
task can capture the updated cookie and join the pending queue for the
next attempt before the previous attempt's error is delivered.

Fixes: f99fa50880f5 ("SUNRPC/xprtrdma: Fix reconnection locking")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
---
 net/sunrpc/xprtrdma/transport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index e38637c2ec787..02946585e5f62 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -239,10 +239,12 @@ xprt_rdma_connect_worker(struct work_struct *work)
 					   xprt->stat.connect_start;
 		xprt_set_connected(xprt);
 		rc = -EAGAIN;
-	} else
+	} else {
 		rpcrdma_xprt_disconnect(r_xprt);
-	xprt_unlock_connect(xprt, r_xprt);
+		xprt->connect_cookie++;
+	}
 	xprt_wake_pending_tasks(xprt, rc);
+	xprt_unlock_connect(xprt, r_xprt);
 	current_restore_flags(pflags, PF_MEMALLOC);
 }
 

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.53.0

