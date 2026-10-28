Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212535;
	b=oEIuhDCBzbKqrY6qF5T0wkZLeEjy7gEq+J6onY97CgWaQC6B3YS1ROUC+W9amPP1PSOS
	 LBWGc7hFB+2BhBfDnL+wCLWtc4a3SFqVxx+ydonhe2aJz6JIN1+nbbW5e3s8Bk0tPWLEs
	 KVmbuJjaHX+TIWz5F2vku3SWdEWI+5T5pTllV2eosD3b69N4T5fFUGNMdqLPrDxlCPJSI
	 5mM4Ee4wqQ+Q+vb8VAJvwIphtV+Gh3r7E3zHA78U+UdxIj9BhINv40qqNCwkOyYhmZXHV
	 lkFLe/0tE0ShK2rdtpHjSiiCsDsl0QP96eCcc+N/6AROD8/7PJZngneSkVJexyGtkhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212535;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mr9cTvzp2DJzq4e+c1cnIXzYdS0FNBwPXrbs/G1Zbyw=;
	b=YYM5kI45t/Mb1qgVYKPORTDSAwof2UfjvYP9obL9XcMrq5BkEp9JKhqgQKiOtwln+X2q
	 64n2eAXPDVZ0p2x7NSwtyiuEI8uwWfOibi8+PBL89VOSnOgIw0c6RLJ01d98fS/SbcvsH
	 eAKVhU2y/Tc+TqJtAj+qZtPM9t/5fcUKHHRDrjA0mzuz1ysWUS/P6WJWGK3XLlkA7+ALZ
	 CP8k2WLPvianJ8PpLTc/shZ1bcoNwfjB5GcAUZDOcnuhaw5AYrSNGtaLdXI2fojhCiYkt
	 p4na8OBtQvZT4WbMU3gd5fBoKRCLFUs5Qa7vHtceM/QGdiGP7KadwTkv8TxAUFSeZPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQUxM4B8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358DE606A321
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQUxM4B8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F9C1F01828;
	Wed, 28 Oct 2026 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212534;
	bh=Mr9cTvzp2DJzq4e+c1cnIXzYdS0FNBwPXrbs/G1Zbyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQUxM4B8HQgue7CLME+XiXNG6rHo3ziuePrz5sw/+2A7kU7CUwjNpE3cvuhalVq41
	 LJK1IzhJcxX5+sYZhhfB4zmjWGzL0AOjR6PGPHl/4tKzPZd1UJW0jI0USz2T/4KKgs
	 R3R0msz3YxKuKrZ+TGOM2CU78v0RjPFPuqKm1C5EVLLaW4jiE1mHaR3Qc85tOg/VeY
	 i8eHczTauFVTxJLJ5Q3/jqwEz6nWnq6WXYRjXrxwBnXmnRNSLQZYuyjP9j0ZEv2EvK
	 dPD66vqTLxV4hN7OR5GzKIEf+qSwb++v7RNs/0zMkXmE6V5LW6AUG9Xg6gfIlMMG8O
	 oyWdkr/DSTVpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] fork: move the coredump and exec checks into create_io_thread()
Date: Wed, 28 Oct 2026 14:35:32 -0400
Message-ID: <20261028183505.1719907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102850-pulverize-satin-96a4@gregkh>
References: <2026102850-pulverize-satin-96a4@gregkh>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit e760200370e4de054b6b5f568a7faa911e2956bb ]

Only a PF_USER_WORKER thread returns from get_signal() after a fatal
signal and can go on to create a thread. get_signal() sets PF_SIGNALED
before it dumps core and before it lets a PF_USER_WORKER thread return.
That flags sticks.

The exec'ing thread itself is never signaled. But it doesn't need the check
anyway as we moved cancellation of io_uring requests before de_thread().
create_io_thread() is the only way a signaled thread creates another
one. vhost_task_create() is reached from ioctls alone.

io_should_retry_thread() doesn't retry -EINTR, so io-wq callers give up
the same way they did when copy_process() refused.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/aq0VLTyxNatFmLOK@redhat.com
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-13-8e4adb1619e6@kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: 1f978881ce6c ("fork: don't create io threads once PF_POSTCOREDUMP is set")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/fork.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 6734b94600333..bf0bbd8a569e5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2559,6 +2559,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.user_worker	= 1,
 	};
 
+	/* A creator past its fatal signal gets no thread. */
+	if (current->flags & PF_SIGNALED)
+		return ERR_PTR(-EINTR);
+
 	return copy_process(NULL, 0, node, &args);
 }
 
-- 
2.53.0

