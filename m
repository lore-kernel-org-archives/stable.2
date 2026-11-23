Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460905;
	b=Ni9nm7n8pED5wky2+Ej9mcS2gD21RDVGCQCcevVy0K4gIAzMLFkAmekLqw84QoMTL5wZ
	 hjek6PNGQH/+GoZLGgWLrRKXhjDFIJsBpb5hUkfA5EB3W+CdfDpa1+qbb4kbEt8/0yi5z
	 6iXS3tOQTSDqupN/IaqkBfLgOGrQa17CCW9XLFaQ0RdShBz9bVoBrZJuf9HEBFm2f9j7j
	 pXrvO3ObG9aYvBiu+SA9kGS/xDbUf+HuE3KP5CGxKq0Hy22mAS9f8hlRh2uIDdVzcPAMP
	 UDYAiMFapeFtZFE+df3BlY+lNwJF0shGGqBmR1Oa7vc8khlCf5jv6EuZHseUT2ycO6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VYHxPFKmOwY5V9RAEDUHx1RPEhbWi3XhYNTJz3MSmaM=;
	b=smittIIHYg1ZaHAJCN9c70z3i3+wZpQAeXY4fbspWtQYvVTgVAotD7ibheHH/T0cG/dW
	 SaRB4RmFY7VxRGzT5Li2ggMeEUIxximH0xYl0qcTGzK7pDvAf2VcloYWi/nEOkQUyKuFL
	 8nyFjGLJn9yol1WyhIXvxDAzwISiK+I7KSxpEAUMXhRqiEig4xoBREDpIh6NCxbzybstw
	 MQ9hmh2KLMMRfVWzlaFk13MZXr2bPcWZsoldYlv1i3LmtVjWcBXd//fzI0st/u4H+HRQm
	 H4tAqgAwUejAbu0ebnpQhghxX5aEVHE8XLMp++/hHo5q3EeYhOKVpsJ/Dw8oWl/+qxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=mpU6Bd1x;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9F606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4D9F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=mpU6Bd1x
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so1942500a91.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1795460904; x=1796065704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VYHxPFKmOwY5V9RAEDUHx1RPEhbWi3XhYNTJz3MSmaM=;
        b=mpU6Bd1xNO/ofpxU+xyxw8WSfk8MLDZhj0XbqMK8hHBAVUBDwF0nX6uXxvxG7wV6oC
         qykEDHArhBqXJwIus0GnOnxcdIlEsK4VBIEW8/3tBX3H4qjFbLYkcZIUkCYgCLOIVrno
         1nUf7v+Ik7u+sXiqljQ1dDirwey0Uf6FdwOMzqkjX0dLvdxm/2Uxu6SGIpx4Oi4Diqsi
         mUQ/aBpKO4FuEvoLtdY3lxyArZhqPh1g0dradBEJVVyHwOxCkhymjc7ReFB+1iBDWQbO
         QgkTg/APAQYuGdXSAfb9ryOQxCqSXmsK8XR0HHC3tXF1YMXCJ0G71f7nq57i1MWipCNN
         87Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460904; x=1796065704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VYHxPFKmOwY5V9RAEDUHx1RPEhbWi3XhYNTJz3MSmaM=;
        b=pnzCeb5oC8SxhpN8ou042Iz2g8xm+8ckADfNqhOvhR3fepby6WDnAYSXniRHT0APB/
         1PZ7wNofMD6Q/8ZZ06+ulGWu+IGJGYe5cHNZ6Ode3ot1sGXh4VKmFybakfcpuUskRuaG
         GZY9FEh0jpbRRaOQASX8I/zM1hLSs416rOkuCxbWLO+cH/MFxOO8T3fD0rygPQGk48hq
         kL/6qLPAH6KhWkL2ACp+EhVnm/Lq3IxiXYRtSuiu6g63DIz5Zrb54sDkFbOAOiLwwowk
         y+SN6rN2b1rb29pTUpIZsG1QFeKUrRfEQeOBBvtl74pPeMFcxkBV4nb/TW28T5gBlKGR
         Qmow==
X-Forwarded-Encrypted: i=1; AL+hErG4wmDWz+yKfDf/UhZQSm0d/bZX61xEZSZhRKxMDXvQRk4Toolxah4zbFnz4lurs3YKcqOfNik=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SDuXRQxbmPVrNS39pCrD7UccJwMG9ENU6INT/2uiCcVWcpouj
	uwPS4ugXj8xVdbFrUMVWszPS/ENGRgFxlGCcF0pEKoHwnpB1DKp2djfbk7He4A93Uwl8LN4oCBT
	CwFiZP5ImgE4ozRq555+p8cRwODGfND0uTAFV
X-Gm-Gg: AZFdTZepybfuXxb0kvuIoLkWaa2GpvhJK8vIoREUev8X733fOviF8suJRnMI5Fw8Xjo
	cJ2YzZoEC/8Jc98l3/6+M7JPGJpcDCfowQyL216JuQ3FdehI6rPR4pVdPtVLg4EwLnF8rJRxmuW
	UgUYGm/UlWd6l8Pl+au+Pi4ghXSGvXR/wH7UaerqsjbKcZ140qlckhz0QkVcT9w/KXAfCPza8UT
	VNDrNYfbe02cJu4h2KCZMiamckt2HAmUhZDkdMoAK4rtRbR4nOBrRn2aLKQuKjB8hDvS+OjBFHM
	ONHxVDI7Joa+O/6NwLZ9nmMOzXXNt3Yijx197kq6YvldOVkaDyENewo5/MZTYCuJBDQv+TUHNyT
	j0pB3PuFKN4nhUxT2tkEQDPlp163kMTI+SNhRmfE=
X-Received: by 2002:a17:90b:2c84:b0:3b3:c3b9:7de6 with SMTP id 98e67ed59e1d1-3b41c8fe20emr10529365a91.13.1795460903946;
        Mon, 23 Nov 2026 11:08:23 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41d245549sm4735121a91.2.2026.11.23.11.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:08:23 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 32D0E34015E;
	Mon, 23 Nov 2026 11:08:23 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: cel@kernel.org,
	anna@kernel.org,
	trondmy@kernel.org
Cc: ebadger@everpuredata.com,
	jcurley@everpuredata.com,
	linux-nfs@vger.kernel.org,
	slingappa@everpuredata.com,
	stable@vger.kernel.org
Subject: [PATCH v2] xprtrdma: Retire the connection generation when a connect attempt fails
Date: Mon, 23 Nov 2026 19:08:23 +0000
Message-ID: <20261123190823.1680365-1-tmenninger@everpuredata.com>
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

Advance connect_cookie once per connect attempt, whether it succeeds or
fails, before waking its waiters, so that their conditional disconnects
no longer match.

Also wake pending tasks before releasing the connect lock. Otherwise, a
task can capture the updated cookie and join the pending queue for the
next attempt before the previous attempt's error is delivered.

Fixes: f99fa50880f5 ("SUNRPC/xprtrdma: Fix reconnection locking")
Cc: stable@vger.kernel.org
Reviewed-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
---
Changes in v2:
- Advance connect_cookie in one place, just after
  xprt_clear_connecting(), for every connect attempt (Chuck)
- Add a comment explaining why pending tasks are woken before the
  connect lock is released (Chuck)
- Update the commit message to match

v1: https://lore.kernel.org/all/20261120010342.2152535-1-tmenninger@everpuredata.com

 net/sunrpc/xprtrdma/transport.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index e38637c2ec787..d27de0ad6732b 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -232,8 +232,8 @@ xprt_rdma_connect_worker(struct work_struct *work)
 		current->flags |= PF_MEMALLOC;
 	rc = rpcrdma_xprt_connect(r_xprt);
 	xprt_clear_connecting(xprt);
+	xprt->connect_cookie++;
 	if (!rc) {
-		xprt->connect_cookie++;
 		xprt->stat.connect_count++;
 		xprt->stat.connect_time += (long)jiffies -
 					   xprt->stat.connect_start;
@@ -241,8 +241,11 @@ xprt_rdma_connect_worker(struct work_struct *work)
 		rc = -EAGAIN;
 	} else
 		rpcrdma_xprt_disconnect(r_xprt);
-	xprt_unlock_connect(xprt, r_xprt);
+	/* Wake waiters before unlocking, so that a task which records the
+	 * new connect_cookie cannot receive this attempt's result.
+	 */
 	xprt_wake_pending_tasks(xprt, rc);
+	xprt_unlock_connect(xprt, r_xprt);
 	current_restore_flags(pflags, PF_MEMALLOC);
 }
 

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.53.0

