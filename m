Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=206.220.120.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291369;
	b=H//40LJkfFk8LeAC4tWn7E1SX4NU68KyGhE0HuWp3TQ8i9NK0FPgd34PPAwSXNaE+j60
	 ODyNdasuQwhRAWwljzxOO/YsPWXnwmPvFBYobFAgIz5DMDj4r8hRsZDv4OmrY7bShB3Q+
	 ETn5EMzercmS3NCMYFRSla3u49qIIdBEAQOpQl9TU/J0xWJwmn0GmE8g+4j90jTo0R8Hi
	 dWdXAsSdbARGycpx2qsyGyd1PdjkJs0lJuBtkcnzLH1do30mFKRsGM7BU3et/BQgNZE+u
	 CieWl8RA7TWdB7YeXVO4PHNF+r8HKVnJyH/OL3ePBpFjH58fKhMnTnwiC1+/jO8Cu1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291369;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BrDzxLEbeU4uco9ipa6fnS9nVVE6+Zz5bW9TygcDdP8=;
	b=LCWjo6xpDapl5+hdpwIjzHWgv1k3HqUXCKzbabQ9zZRxwwIWOm+sJIX/2bdh6DfErAwM
	 /i9S1MK0YC10DQG01ZTXpinEojKpQ4BegUsqYlKVtjcRRsAv0Utoul5VtkhRQC7hIvVPy
	 vJMkY8A5UGHICOGHPp4h6KN7C48Bvp8xILmWlUq0LjOiCLta8ywMoRMNVS0i3KmZ6eRYX
	 1YcwvU9LnoqrJZPEy7mfbUPvlndSPVw8d8xLVGXlg6Ttnx7OIdvlWApc3Fp/7Z2U8A5YO
	 9n5qtsyX+uPFDiqoa5cbjXCeTsnvw63kYu4YeK0Kyi7K9VAj8dsjUZfCr2cA+r5kpIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=grapheneos.org;
	spf=pass smtp.mailfrom=grapheneos.org;
	dkim=pass header.d=grapheneos.org header.i=@grapheneos.org header.a=rsa-sha256 header.s=default header.b=FrWjs+J5;
	arc=none smtp.remote-ip=206.220.120.4
Received: from mail.grapheneos.org (mail.grapheneos.org [206.220.120.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA63606A331;
	Tue, 10 Nov 2026 06:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FA63606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grapheneos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grapheneos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grapheneos.org header.i=@grapheneos.org header.a=rsa-sha256 header.s=default header.b=FrWjs+J5
Received: by mail.grapheneos.org (Postfix) id 4F2373C08EF80;
	Tue, 10 Nov 2026 06:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grapheneos.org;
	s=default; t=1794291368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrDzxLEbeU4uco9ipa6fnS9nVVE6+Zz5bW9TygcDdP8=;
	b=FrWjs+J5ueCOJCIkICiVuyqpFABQ8WPKZIfSyrrKh4eNLotdKUoaF18Dg3x3ex56P8KGoo
	SFkLoFqDgz0QCWE9exFeK0HvCFbvNaoyte2CIN80/0gyrt6CEgwFv4VjY9RezMnbrphZ+i
	oEJslQmciikQeBgJXTe1LF0xnKNY2bHV84dmxNeea7DDfYrOj0KyRSxxgocXEW1SOQRzis
	ubn0riWWpH75duHAl7nDa3QJdvZ8TJZvU6WoNHSOVw0ElmtRGlSyBeO4S3hGagk7UPH/c0
	NTbWy0VphK0G8QjPyieVwzuaai3zOi+ILGRHxXimnI8bO9dumtp+sQiReB9jew==
From: liamsmith827 <liamsmith827@grapheneos.org>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liamsmith827 <liamsmith827@proton.me>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/4] ipv4: add FIB_LOOKUP_REPORT_MISS
Date: Tue, 10 Nov 2026 06:15:33 +0000
Message-ID: <20261110061536.10811-2-liamsmith827@grapheneos.org>
In-Reply-To: <20261110061536.10811-1-liamsmith827@grapheneos.org>
References: <20261110061536.10811-1-liamsmith827@grapheneos.org>
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

From: liamsmith827 <liamsmith827@proton.me>

IPv4 FIB lookup maps a routing miss to -ENETUNREACH, which is also
returned when an unreachable rule is encountered. This flag prevents the
mapping, returning -ESRCH instead.

Cc: stable@vger.kernel.org
Signed-off-by: liamsmith827 <liamsmith827@proton.me>
---
 include/net/fib_rules.h | 5 +++++
 include/net/ip_fib.h    | 6 +++---
 net/ipv4/fib_rules.c    | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index c6b94790fa81..bcb6809dbd10 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -59,6 +59,11 @@ struct fib_lookup_arg {
 	int			flags;
 #define FIB_LOOKUP_NOREF		1
 #define FIB_LOOKUP_IGNORE_LINKSTATE	2
+/* Return -ESRCH instead of mapping it to -ENETUNREACH. Only applies to IPv4
+ * lookups. When used with FIB_LOOKUP_NOREF, -ESRCH indicates the lookup
+ * exhausted all rules and tables without finding a usable route.
+ */
+#define FIB_LOOKUP_REPORT_MISS		4
 };
 
 struct fib_rules_ops {
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 92f4eb8b86d7..d0b4f261585a 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -318,7 +318,7 @@ static inline int fib_lookup(struct net *net, const struct flowi4 *flp,
 			     struct fib_result *res, unsigned int flags)
 {
 	struct fib_table *tb;
-	int err = -ENETUNREACH;
+	int err = -EAGAIN;
 
 	rcu_read_lock();
 
@@ -327,7 +327,7 @@ static inline int fib_lookup(struct net *net, const struct flowi4 *flp,
 		err = fib_table_lookup(tb, flp, res, flags | FIB_LOOKUP_NOREF);
 
 	if (err == -EAGAIN)
-		err = -ENETUNREACH;
+		err = (flags & FIB_LOOKUP_REPORT_MISS) ? -ESRCH : -ENETUNREACH;
 
 	rcu_read_unlock();
 
@@ -398,7 +398,7 @@ static inline int fib_lookup(struct net *net, struct flowi4 *flp,
 		err = fib_table_lookup(tb, flp, res, flags);
 
 	if (err == -EAGAIN)
-		err = -ENETUNREACH;
+		err = (flags & FIB_LOOKUP_REPORT_MISS) ? -ESRCH : -ENETUNREACH;
 out:
 	rcu_read_unlock();
 
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 060501b376a8..3d7dcb8d0865 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -101,7 +101,7 @@ int __fib_lookup(struct net *net, struct flowi4 *flp,
 		res->tclassid = 0;
 #endif
 
-	if (err == -ESRCH)
+	if (err == -ESRCH && !(flags & FIB_LOOKUP_REPORT_MISS))
 		err = -ENETUNREACH;
 
 	return err;
-- 
2.47.3

