Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5913B42CC
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616153; cv=none; b=T3ALxwoHo+WeXQKCybQfh9JfnLDadsORLjb/6eIQbUzDS1y5SIpb4APg6Z0n7UtMrmvNhM4LG4oGVHZCfdlyJheMTMXjwzhvcfy1f/AijSGXwIA2q4BwFssoCg74dt+yf2xnAk2FWKWhmo2wFDl+82UpP1FkWwEjk77aFuUMD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616153; c=relaxed/simple;
	bh=tlUM4ufP1cWzyUz4RXoqlm5GXn8AY+/UX4DkLpdy8Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI0XcFAi2NUBmCgrSG0ue8DNWOygDs/wfuEqGR1NpqO5HaTWNIFYXcgpmtSmFALhKH3z8JaBmv4IfCblRLIc2vgOalrD7fU+ETzWJNud2d4/w7J6uzCMVFScjsEYlQoO16j8pQzstFf+v6YnEh5hM3pZF13KtNyzOi/Z5bO5cgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUwdSgD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUwdSgD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FECF1F0089A;
	Thu, 17 Sep 2026 03:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789616140;
	bh=b4bLijZFan+uJclm/Jd6NmrUbPjxxtLk3pd6/Xb8Hf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lUwdSgD85TAFD0BTZy+FQIvZri2Aqfi/eOqmulLiTE9vq7rSfupYC6sDzx5kpUj2a
	 ylRi8mwgi+uB/O5Zc3+xuWV6TZfhHowizUcmuCjU4AqJVAA9+v9l2l7ia94lpG0obh
	 rI//dTfjn+O1EUZzX45fkGH15hcffMFxcdsWlzPjj49VhY2OO3nLipmkOajKObkoek
	 36TN9g1WQ11yo4wAEnBCB1xQBQnwIDjIT603rVxErQKFbpQx3tGBAAQhInhlfuMp/d
	 2PNCQiG8BBHtc/YTJZnnckWPaVIllKmIJ/mOF17F7msulTEYNZg41zxsohsDg4XzDX
	 zneMwwYNwtj1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] sock: add sock_kmemdup helper
Date: Wed, 16 Sep 2026 23:35:34 -0400
Message-ID: <20260917033537.4044281-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917033537.4044281-1-sashal@kernel.org>
References: <2026091628-sevenfold-cursive-c662@gregkh>
 <20260917033537.4044281-1-sashal@kernel.org>
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
index 9fe621f985740..d195cddb8559b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1977,6 +1977,8 @@ static inline struct sk_buff *sock_alloc_send_skb(struct sock *sk,
 }
 
 void *sock_kmalloc(struct sock *sk, int size, gfp_t priority);
+void *sock_kmemdup(struct sock *sk, const void *src,
+		   int size, gfp_t priority);
 void sock_kfree_s(struct sock *sk, void *mem, int size);
 void sock_kzfree_s(struct sock *sk, void *mem, int size);
 void sk_send_sigurg(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 2a701e0b052b7..7ad32254506ec 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2670,6 +2670,22 @@ void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
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

