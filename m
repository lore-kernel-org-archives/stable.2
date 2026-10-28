Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214216;
	b=qwyUucmKMjwmXl/yGwpp17uAl9UHhEW1JfiGG2cCx1JCCBB70HdmdXJFGrSs8k0KFo2t
	 yVY0EmlhDGW14MjUz4P0RjA7nCqPaIpqH0A8cd7puSYITXsprVkMxx30LC4s7rr9Afw8j
	 TXc14KDAIJopGBgzbKLGYQfVtA2o7EiwFlkxYTEzahK+9h+ctWa5O+K0e0kP1LgNvJb9Y
	 h41zyCIErppuRY2fVGYnzMkeIMWSGSZJsD6OzrWuAiCUM+9GTtIlltb0fKoVXhfqPmz1z
	 i1a9M9kRPJ/7hsFgGpuJq/PrGnCgPaZx/DtjxcHqhMMXM6Ywangq0Efx1gETHQPmSXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214216;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ItA+kX+KJYP4yRXuma4vjqeyf4jPzGo780LPkrPyJFw=;
	b=Ov6+5pd3o4nty2BMql7hy9Y06K9YBI5olxaVopjr0dJU+QElWcpEciQ5s+ZWuO9kTWZW
	 dZ4YEEDxtgsXzgT6C18bQXQ5uZWXC2Yldpymbap5nZvfExn7RDS5vUXM9/z0srCmcRowH
	 l5flHqDt5/dCqJcbs9F7i9V81TE7ZhmLho1mxYAW9vMuldTDASkDBJ4fEi/h3YBfB8uW2
	 rE/4S+p1vO9ZO0+uy56BYQwudnOJJWJR4/20/Pgq6IgiRLh4byZg1lwBETNYs8LOnjU7h
	 yc4mKPZRkSRHYm1e7KbLpTF7ACpVgvEsElmXZrWiL+ICNISINzIMJyVtpXbyp+kG5QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfjBRBfD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EE60A2616
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfjBRBfD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60AA1F013C1;
	Wed, 28 Oct 2026 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214216;
	bh=ItA+kX+KJYP4yRXuma4vjqeyf4jPzGo780LPkrPyJFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfjBRBfD5EFfijxw/EnPry7KUwi6zzOwmiQr+H1wezRnx8YB22SPYDZLZN/aoqkVr
	 XmWA6hocZOY//1nv4HSQ50uhcTUwJerdhowfZ5ArYXQAETNieZMRnSZ1uCACvJgphv
	 OPnJHrdNi1bjXoKSs/PntEp3DWBTmrCgckU9deIq7/672ajv5dYVu/NZydp8kZxNhw
	 C7d8PZ5Fc+exQdosWTuBw+sz/ulVrsBQNuUt3HkQQ3CMt0uYwzNnw/Oq5gMhbzUuOA
	 vZWK+jczTwoFAW7XLPCY5g6fNp76K3HT80cBazTMEj6ggreMYl8uMxzNnLtWvSoafI
	 NRs8AIv4r3cLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] fork: move the coredump and exec checks into create_io_thread()
Date: Wed, 28 Oct 2026 15:03:33 -0400
Message-ID: <20261028190310.2073874-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102850-unleveled-version-e04b@gregkh>
References: <2026102850-unleveled-version-e04b@gregkh>
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
index f22b79d9954a8..c82956f8fc9d5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2774,6 +2774,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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

