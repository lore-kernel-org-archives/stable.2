Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218432;
	b=j09od8rF751Ail/GCfZi+mY0MWfd2qvuRpzFQCuN5pwPfH6F1J36kU+08jEATH5Jph7l
	 T0OdcF8IYuKzEZ7AJ4nYl9azAiDMu7r2w928wmVPMH7UyfiPbaUA4clkYWvZmgw96ZjPq
	 Lf5zwL0i4ZcJ5rb7cUzZ0kllaSYGXANMCG1a0/wmX3iQM7N2RPfw5jQU/FGfcBDjXpc4h
	 jrUFdk7ZPYez+9ODWgFPSp5kJtITbr9Bn1XwdyZT/U+6FhiZ8HTZSpG87z/eMA7p2ko+e
	 jtq+inWEJzf8Ra5NDbXQmEKGq152T2WDN70vBSHSyMIb9+PcBPiVqA2xB2msFHKCiUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=URdRqICX8m+dqDt1YkS4vifkLf3JR3q8LozRp/GzypE=;
	b=xYKdRlR4BMOLYJRWCoFpEYfnAkK+bIHyBv3CtbLhDoXz6gpiq8x0qG/KKL/gpJm+ux9y
	 AJyCC4G02KBjing+1chXl7SKXLeqBe+v9S7QCO+x2jhCwyeZBoKn2DFROyvUP5KWmFHqw
	 +OhRTEIHWNkediiYq7PDaU29eNtl3mS1E7w97BFvxI4cWwgKuMiUI5+kGHDNKjpcl7WMf
	 0B1tdGYVzoBirUb/9zhNvSB+JpCTr04WW9EvmuwqUMLTGAtO8LSDPrThCPYPUM6mLgDDL
	 xEvTEL8nFM8hXv8Ee0LkYXqtXWZajm+85boA/gt8wilbl0iuHv4pBFJNZx/c7bIZT/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKqrad2J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF97606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKqrad2J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383231F01828;
	Wed, 28 Oct 2026 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218431;
	bh=URdRqICX8m+dqDt1YkS4vifkLf3JR3q8LozRp/GzypE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKqrad2JrUWhJByMbYmGN9KNfO9Ppv+SpU+SpcytKUlb2cYqgvyjWkxdbE0sSlfUC
	 a3jweiq5vhIcOsNr9auC1KF7U9irAGQ++sM425URXDz1eqW9rOYzm/CTmi9D7py5Mf
	 0LoRaYa9fSr9LFxwBot1V66+YDcQFGhHQtfwxQlYPkYPYJhTxh9o/vIx8xV+ngOhiQ
	 kwbe+fwcZ1GriVr3r7qobiEw4ZuhQjenxqA+ClqbIdjD5hvgj349bz7+ejXzNgq0un
	 g+3eRJU2yUX0N/vDOzON/4VdBQoYLuflohlXYIk/EU4CwgDJebXGMUOsvZvLtPIG8j
	 wlKzmDHMzikAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] fork: move the coredump and exec checks into create_io_thread()
Date: Wed, 28 Oct 2026 16:13:49 -0400
Message-ID: <20261028201321.2133809-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102852-deprive-survive-f09d@gregkh>
References: <2026102852-deprive-survive-f09d@gregkh>
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
index 37c5d6123cf62..21e37a4ecc9de 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2714,6 +2714,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.io_thread	= 1,
 	};
 
+	/* A creator past its fatal signal gets no thread. */
+	if (current->flags & PF_SIGNALED)
+		return ERR_PTR(-EINTR);
+
 	return copy_process(NULL, 0, node, &args);
 }
 
-- 
2.53.0

