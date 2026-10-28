Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206534;
	b=Tk4MhM02xIIQ7zsywK8GDyX90pMIh/773FZ78DF1fHn1mrD+dZSjggC/c93YleNpcWBX
	 aGVemwEMJTKXdq5wkO1Nk8PzxPtQrogeaTWaAP9CgUUXctx3xKa8G9yt/ELseicm1052y
	 oW4FH08Jj3xtUZ4FF6gVy+I5qL6r/d6nBMu9GIyHb2WkDF+dcr57w74eez3ftCtrYaANA
	 UcO1mTQEx0llh+2Lm1KzUp6cKa8Myr2AhDPbNwKZ1ncNlrqTH0iw0l9GuEdZAfapDolAp
	 0jkUCecTB+0N7LytEAtN0mGfiOqpEG1MxvweHMrGae5zmL0SkNs5Nw+Y8zLFONvO1sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NDWV14Iz1ezoCOyuU8ksgBsld4EXtOYOznVZ6NftGGQ=;
	b=ET4vqohtZBrXhjqZVhE1Exl6U8cb+N9JdMWQ2W6atHVI05N1NpsV9ln/UzZNwcFmZECB
	 PGvF2k71gXM+aMg4IlrpwDlYigxO7/aZzpSafswViKVj4kD66UqMTkhbPgRmUjR8gXDRc
	 6oPJXmusBpZk/6p4MEQaW0NCcgL635fGNMoGwzOG5FI+HwWIEY8t+OA+ehLnOe4+MN1pH
	 nUeXh74/42u8vv1zjb8dm72HuzzmSMHaD2zczggqG8TzwGioFi3XausArlmfJEhhwj1Kz
	 xwcTPcxGrrx+Xky16FL5ywEnZbhLkB2nMul5JjbuztOGOyGKT0fLNfXf8814bFmHrsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsLLLnVJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F2606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsLLLnVJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00D51F01825;
	Wed, 28 Oct 2026 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793206533;
	bh=NDWV14Iz1ezoCOyuU8ksgBsld4EXtOYOznVZ6NftGGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GsLLLnVJsMHX7h3DThmjLOGc0yJy6DaD7EKfrIwdhaVvAcF6GZgUajsG02hVBtmwP
	 pyOgKIfhYN8tc4ZrNrzEZ1UFzgrP8jV6rS8t4x2UfaeAlqDhvYe9iSwDZzIoqV0mYn
	 jylmYDctshUvNOG6JCB/4yCxx6BGfH6utPed7nM6swKv9fhNTnu75UppQ9/sKKrcBk
	 0FN1DNbeUV7xhSZex0Xrbl+v//9UDEVg6yYw3ODU2j4N/3c1ewx5nBAocQncrHYC+x
	 KeE+6HyDyKbU7JLQelTScNx9aLuDLYrEFGqwvIDJxjqGgCaX2+6QCD01yVxshJdmAI
	 F3p8u9sTnH1EQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] fork: move the coredump and exec checks into create_io_thread()
Date: Wed, 28 Oct 2026 12:55:30 -0400
Message-ID: <20261028165506.1601934-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102848-foster-escapade-ec01@gregkh>
References: <2026102848-foster-escapade-ec01@gregkh>
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
index efe6157fedb43..140b41702c8fe 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2718,6 +2718,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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

