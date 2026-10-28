Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207628;
	b=CUvjlnYuSVjTSBjz0OIHRnLGg4tpS+MO/VchwdVB+fz3vAkSm+r+jDfariz9j5Io73UW
	 DHffgTDJATFFMNruGU9SWM8cXkRETHCiLnDge60UrEAnGOn9Gkz3IMNIZ1gBblwmuNhyC
	 660hq7vNWoq5Ciy2/0KcxuqQfAZLFiinkBKSk5pEuwgXYU7Ls7+Xub/kFu538FaJNc8E2
	 tOXs3kFFLTTddulj/f8QDwLgGyqcmD3DBvXZ/1Cpz9jlVPoCmvZ+pV+tX6h82gEHYxrzO
	 cpt7xSorMqJJGYjS1th6CEfXMou+vTJQoGGMA1Jez38CwSCxU2poGh18gBb7VahHiDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fxpi70qsm8hYFpqYicBgb+DCzRe2fK2pChHfxCYW9R4=;
	b=AeJ2zqsyr/ThH5VaqfyXqI9tL6dhEpO4d/ieqF7l9vsMiXxKe6W3hHpVENUHyjWo8N0T
	 YrTgzGNYzTAjYs4pTtMCWbOSkWBwKeMeEPK+2KpBcP18Biv0MrCnI+dPYG/pED4LUG2uq
	 WXS+ZfUQbPy34LrtqQ9PqOuStDFp3QTKLlyWC825CiapLXyU83Z1nd6Qmr7Yav2owTIsu
	 X7Armvcl3ODVNS4w6wnIMh2wyQeXtGTMq1aL2+a8D1N4DaAKi0fhECDgoCiilY8nYfNFo
	 uQN2GNT29kPLejI7dvGKvG/zMnHSXccDcccXmEw6IRFwwNn8M7MJxG/exLoVNhpWFkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dqe6wInQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E67606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dqe6wInQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1925C1F01828;
	Wed, 28 Oct 2026 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207627;
	bh=Fxpi70qsm8hYFpqYicBgb+DCzRe2fK2pChHfxCYW9R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dqe6wInQH1BbAXfkBFF/iyWiN3yK+Dck554SDMbIJ52YurSfSC18Y3K3sxW70tyxE
	 DubKk7z6SrxaIU4BN3G/OLnmRJh+Vur3/vEk2qsaLF0GS8/FAVSuBoxtRUKijv+bZW
	 H6g8sgJwaxC6GBRBjJayaULvUn06woLdB+stxWdsCa80c7i/VzHmag5woHJvL2F2yY
	 js4IywmfEw616EGaL7hiERujKQv8RBgxxhOrGvth0SJFyacpEosPBojv4A/v2mU1+U
	 fGH1CU64eY4F26Bs6pJuKqt1iuQWzT5pmX1SpcTnUFuiTPPtRgf3Z5Tlo4noW1pyFW
	 ThQSFrrf2YDkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] fork: move the coredump and exec checks into create_io_thread()
Date: Wed, 28 Oct 2026 13:13:45 -0400
Message-ID: <20261028171308.1613661-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102849-headphone-cattail-5c79@gregkh>
References: <2026102849-headphone-cattail-5c79@gregkh>
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
index 26485ba0dac7c..73239e4ba6fa4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2689,6 +2689,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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

