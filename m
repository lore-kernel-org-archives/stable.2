Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7E38F65B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613902; cv=none; b=Jwiz1oI24yFDDlyqi2PXTpmHuZvkxsKFfcxczqGfbk+IWWCn9qe4N1K+u1SwmrgFd9vv9zFol3qgAeLJ4TmRlRGxim8zmEHcuV3Kx8dtk5ECkuwqbwv6P5UYpOwFViVmyU8VUtycB23JuRnwgHPtJ6qmNPc3SZcg/XnxMULNHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613902; c=relaxed/simple;
	bh=DwUDtz0qVqyDf89GhEJEzgtREidmt/oOnefVUVeR8Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXgEY5v3XPFvunvzwLnGiU7PnpmaxAWdiOdxoU6l90rTzpDypmsUj20J5cu38BOpXg7esIW36cmE0mU/mrLTHRhXFyO9T9seVJAuhmwHI/1fNIxbsPzr5qqnAQLS4xGVUsDFAj2/w5F/4uWWYlEgfBNEG/gwi/IV8PZJ4OYM2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNdFKtuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNdFKtuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36461F00899;
	Thu, 17 Sep 2026 02:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613893;
	bh=zwV42pAapyBOQRWBGSA1N+W6L5klzR4t8b51yzWhB7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FNdFKtuMDzxvU3rW9b5zNsA535vTp40cpTXr+SzF8hHkdI5HN4fC+cHwQcgW4jzsP
	 h+glNQfBCuNoB8+XUxlxX1+qcTuydTpJw2Y0MvShJlkjphxPS+T62xUf3AIQd8w62K
	 6iX9HcJeQroxK0fC8v0X7r0mRfp9FUwiRlXkdloEL0/KgjQz1RDHOi4c5gxLH3RsWX
	 7k8JZfr4rlKBy72TkVK68D6ulG02vMJkXdN5osn/xADLsCEqFayu9g0t0+HaVUTXmI
	 Vze9I/bUWqcy8uenq5B3oKkmlg9tLr3+vSB99r0cbrm8bYU9cCCSv0bf+wawY1p7+l
	 LQcuPG0RcoaNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] sock: add sock_kmemdup helper
Date: Wed, 16 Sep 2026 22:58:08 -0400
Message-ID: <20260917025810.3934358-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025810.3934358-1-sashal@kernel.org>
References: <2026091627-sleep-poem-4828@gregkh>
 <20260917025810.3934358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit 456cc675b6d4cadd4872a477d8976ff56eef4b6f ]

This patch adds the sock version of kmemdup() helper, named sock_kmemdup(),
to duplicate the input "src" memory block using the socket's option memory
buffer.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/f828077394c7d1f3560123497348b438c875b510.1740735165.git.tanggeliang@kylinos.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f9f0068e8813 ("mptcp: pm: userspace: fix address ID overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h |  2 ++
 net/core/sock.c    | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index c1f129a532b20..db10fd405dee6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1955,6 +1955,8 @@ static inline struct sk_buff *sock_alloc_send_skb(struct sock *sk,
 }
 
 void *sock_kmalloc(struct sock *sk, int size, gfp_t priority);
+void *sock_kmemdup(struct sock *sk, const void *src,
+		   int size, gfp_t priority);
 void sock_kfree_s(struct sock *sk, void *mem, int size);
 void sock_kzfree_s(struct sock *sk, void *mem, int size);
 void sk_send_sigurg(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 2f82dc45f93ec..119ee87caedd1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2736,6 +2736,22 @@ void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
 }
 EXPORT_SYMBOL(sock_kmalloc);
 
+/*
+ * Duplicate the input "src" memory block using the socket's
+ * option memory buffer.
+ */
+void *sock_kmemdup(struct sock *sk, const void *src,
+		   int size, gfp_t priority)
+{
+	void *mem;
+
+	mem = sock_kmalloc(sk, size, priority);
+	if (mem)
+		memcpy(mem, src, size);
+	return mem;
+}
+EXPORT_SYMBOL(sock_kmemdup);
+
 /* Free an option memory block. Note, we actually want the inline
  * here as this allows gcc to detect the nullify and fold away the
  * condition entirely.
-- 
2.53.0

