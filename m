Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216686;
	b=TkGKrrIxXxX7iAfHDOvtgvG5xCaEYqIzpEPIo5eooe7nXgtdEP/aNkr0OdO9OZFyF08X
	 M4LSR9yiEhgHZ8uM4FUcrbAmqxPg2PFwqk9SQyOfSl1A5DjFkt0t4z3CVPzVC84/amtkB
	 yXqECz/qWdHfh9qL1KbIXrILuDT4H4kew4W2Fmczxg/VsU2OrsM3+GgZkXiTenf7ovkzd
	 ViT9SwBWgnaMoYmufinYU6RZIU6jQkoagjqKVZnqsab/AiaSeW2aHcfR1eKVS4nf6XbCg
	 Bp1DC9791tozWTomqzKV3R3MHsg+inWdtVMleMsZX9ei8TuKmwAAnAui7irX/fXr5RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216686;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aX5yxWLy5UqgCew+TXik/kA3SFLV0ENzFXkHOTx9H70=;
	b=NHNT+HNHQPLcyEpHm2HqaYUKMD76bmY0v07uqCgm4UHC0yQeV8VCq8vSnr1ggYC0Sklr
	 f/8RgPpQc+uPFSBXC6SsozC3Cb6ORi3tZkThOA3nIaAgbkKmf3Pdwo7WOX9RLFYvYMCNx
	 bEhIDGLpwmxYsG0Micfl2Qv/qPpYWShg8lwlGQoGJIPN2xVVxB42S7IkrkSuOADkBPJHV
	 jUtv8m8g5g+rHbrHovJYTXaj/vxjipenbwio+uo58t7uZsjf+w2IZQRFh/DlWp4jnT01B
	 r1qVGCIKGYUju1ampXI77hqTH8+xAUr5ehPR/af0OXKuCgOy+29a/GXIklQ4zYyuqqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVUEWX7a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCB606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVUEWX7a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D936F1F01828;
	Wed, 28 Oct 2026 19:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793216686;
	bh=aX5yxWLy5UqgCew+TXik/kA3SFLV0ENzFXkHOTx9H70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LVUEWX7amI3s3lnD2zPsOFJWFNoXV0QdbYjp31DHY3wYnYpwg2bJy7kZyqozRvDAy
	 nADJjSLwByA7lmP0QAX2tgQL04ZVc07sDu9jWALaEKrwxkyT552TGjX6Df6435uwD8
	 3feNgNYUkjb0MTSqEKai4dgkc//Pmf2GIDt5ehtwxGt6T1T0C5Y+yNWEFtU5V9+uuY
	 K3yCaYZAYVDtcLQSl+cxqQIkPc9FPvlKe7N8PxhzkvJiX/qT9DVpTduSeIotameIOi
	 i3PN8Bb+n7Zorb8SWXOevJxQiBmn45FiKKH26NOeLW5qWPrdvZb3q1v87x1jR0TREy
	 E2hg12lQs3nGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] fork: move the coredump and exec checks into create_io_thread()
Date: Wed, 28 Oct 2026 15:44:43 -0400
Message-ID: <20261028194315.2086603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102851-facelift-wand-29b0@gregkh>
References: <2026102851-facelift-wand-29b0@gregkh>
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
index 396a1d4b05e59..802bccf2dea74 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2867,6 +2867,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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

