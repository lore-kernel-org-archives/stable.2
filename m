Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2033A5E8F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613454; cv=none; b=oSyi4o49mLS1qk3954l3WkgKkUUBHclgW6y5Qy1IKK1qSw/icFM9AIOP1fF7iSvsio/3jIxqEgPakr+bFKkBuLoamwNMJfGjLWCozQPIM1AIdu8RA9WemX92VKxGyuF79c/UzuI5SJI7/yqQSdAHAjRIf2QhhLBga/d5/GPWJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613454; c=relaxed/simple;
	bh=kH4vv8Do1fodvKmMsBKlIoqw03o2SIImi4ee98O+wxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPB+uQLzTC/4R6pI3gGYeJPtw404SvFhDR5yVBwncBcDUYX1hIKo1y3twhKn7oI3o4Uqyzcvss+ObBXA5fPLwNQb6ptlA+Gv2zXTlXk094e9FtA3EOgsrxU6YV25i6k4GUY97gmukPRgbDvB5zbI2rGLhlHrzWvYioopV/9aDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA8Po8H7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA8Po8H7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFABF1F0089E;
	Thu, 17 Sep 2026 02:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613421;
	bh=hM8FpsJQ/VqGC6BoiNPu3u+BjoCIzSjFwHYQBsB/27M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JA8Po8H7f+EWb5pPrMIzDUu7sI7U/f4NzjjBe/gv276uEcTNU1Hx0J6yaCoy/9lIo
	 vFC+9cCNIgmj4ZEV9t+b4g48TTWwC3YTV04bh8U7f/pfCc3n6cLbw4E+fNRRlnm3Ye
	 9xR38A8gEdUsQLwERfxufw2VrC+Ii4Yw92em+mQBk+FlHzn/1XPka8Cp4o7YULGyLL
	 /lyfL3PAw79709mZhlxQmQVG7e0taNddsBHIPDzIJAb3OeuOsmUjuF5Ysrq5qwbsh7
	 MR/YSJkdNi1k5t3Ucff/PFfo4hzp/wDflAhBTm/BH0D/hsSku6BQXsnLHq4N74GQGn
	 UC6nl3WlCG7sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] sock: add sock_kmemdup helper
Date: Wed, 16 Sep 2026 22:50:16 -0400
Message-ID: <20260917025018.3917338-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025018.3917338-1-sashal@kernel.org>
References: <2026091626-embassy-overhead-d482@gregkh>
 <20260917025018.3917338-1-sashal@kernel.org>
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
index dffbaaa7fe493..d97e4bac6be35 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1840,6 +1840,8 @@ static inline struct sk_buff *sock_alloc_send_skb(struct sock *sk,
 }
 
 void *sock_kmalloc(struct sock *sk, int size, gfp_t priority);
+void *sock_kmemdup(struct sock *sk, const void *src,
+		   int size, gfp_t priority);
 void sock_kfree_s(struct sock *sk, void *mem, int size);
 void sock_kzfree_s(struct sock *sk, void *mem, int size);
 void sk_send_sigurg(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index e8b03cf3a428c..f90cfe4588b84 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2837,6 +2837,22 @@ void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
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

