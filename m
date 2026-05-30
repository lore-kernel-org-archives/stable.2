Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E848334695
	for <stable@vger.kernel.org>; Sat, 30 May 2026 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157365; cv=none; b=Rf6dKZC7QtAjZpUDlUHeQjsldpxzzlvkTPOizoOoySGPHwljStFXc3fqs8G68dEWujt9tv5Bf7ZObThKC18IYwP15qNieuGtrQyuBtK/GpHX12mZel1pfVj0/SgbVyYJXg5KHKYkdxGVTXqCocefIoiVaapLoMXIqUzpHBddHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157365; c=relaxed/simple;
	bh=jB5Q8xfKTeyrR0xITQGC4yib3p3To1ECXidWijf1Thw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxiXCX9hNkHtZlor586WhdSTvRIJbhcMgkzubXSXUYLyvipCZHbPpJUugYgoX9TOi/N9Pfp3rfGAvCwBxNrXF3B/s+MB14WNoxbijXu4ANkCwCLk5X4efU0H6PACSc0uCd/PkINIaPtflX2EuGZ2BLAaee3L+zpYCR5Jj5EJw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSvgDH4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSvgDH4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B7A1F00893;
	Sat, 30 May 2026 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157364;
	bh=VP2L3bBO+I9BYrX8bY7W1fTeUwLgvmNmr8sZwYLYG6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FSvgDH4iFnG3bugMG/Orr9KgDtwk4UTUkpuzKtN2c1ufqBJJXfyx9znjYhgO+hfKI
	 HtvIp4HnxXZFGA5zXT8tnVMSl3bu9WzAJ7m4QK1iTtwb4AR93ql6O82b6vdqpupnwj
	 qmiRwWIX5j8eJOGsJ77U4m2ZoSmWJ2Qf7VCXlyB370fIb6DjfWvIm5HBC9aj6q0ygt
	 cfF7GJEwCfWNmTxA5eqD1VGAdaFmmsU6AB9CrxZ9RymSD03MQwnIteDRLFQ90bVmJ6
	 MELiFEp2hjmASZITALk2yXGuTHhRt4yHn3/K+apoANutUqIckicjTO088VL2yQCL/K
	 X7A+0W34uo5Yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] af_unix: Cache state->msg in unix_stream_read_generic().
Date: Sat, 30 May 2026 12:09:21 -0400
Message-ID: <20260530160922.2835319-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052802-epidermis-spotter-7887@gregkh>
References: <2026052802-epidermis-spotter-7887@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 8b77338eb2af74bb93986e4a8cfd86724168fe39 ]

In unix_stream_read_generic(), state->msg is fetched multiple times.

Let's cache it in a local variable.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250702223606.1054680-6-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: be309f8eae8b ("af_unix: Fix UAF read of tail->len in unix_stream_data_wait()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 87908ae74efb3..e434d38ec4d7c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2712,20 +2712,21 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				    bool freezable)
 {
-	struct scm_cookie scm;
+	int noblock = state->flags & MSG_DONTWAIT;
 	struct socket *sock = state->socket;
+	struct msghdr *msg = state->msg;
 	struct sock *sk = sock->sk;
-	struct unix_sock *u = unix_sk(sk);
-	int copied = 0;
+	size_t size = state->size;
 	int flags = state->flags;
-	int noblock = flags & MSG_DONTWAIT;
 	bool check_creds = false;
-	int target;
+	struct scm_cookie scm;
+	unsigned int last_len;
+	struct unix_sock *u;
+	int copied = 0;
 	int err = 0;
 	long timeo;
+	int target;
 	int skip;
-	size_t size = state->size;
-	unsigned int last_len;
 
 	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED)) {
 		err = -EINVAL;
@@ -2745,6 +2746,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	memset(&scm, 0, sizeof(scm));
 
+	u = unix_sk(sk);
+
 	/* Lock the socket to prevent queue disordering
 	 * while sleeps in memcpy_tomsg
 	 */
@@ -2841,10 +2844,10 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		}
 
 		/* Copy address just once */
-		if (state->msg && state->msg->msg_name) {
-			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
-					 state->msg->msg_name);
-			unix_copy_addr(state->msg, skb->sk);
+		if (msg && msg->msg_name) {
+			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr, msg->msg_name);
+
+			unix_copy_addr(msg, skb->sk);
 			sunaddr = NULL;
 		}
 
@@ -2917,8 +2920,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	} while (size);
 
 	mutex_unlock(&u->iolock);
-	if (state->msg)
-		scm_recv_unix(sock, state->msg, &scm, flags);
+	if (msg)
+		scm_recv_unix(sock, msg, &scm, flags);
 	else
 		scm_destroy(&scm);
 out:
-- 
2.53.0

