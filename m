Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A23546CF
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162216; cv=none; b=b91pMA0sFeAO3ufNQJRbs4UFkMoJLyDJgWgVLb6NgSr5vkriwUdS6S2SaMZW7L0OowJ4v2sS2jS1ECb+wMHqnMa8PHIvreifFMVZ4CRl8KKod3fXAeveH5ryphLuLDLGdlzWWFL8OWZJS0E8ShtEDfz5Gi7rInju0fZQ6k01aCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162216; c=relaxed/simple;
	bh=JqC3pq7NIWbTtr2/fYT4t/8plFRvdglrTV+xjsQtjcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyKJ/BUnEuf0wvNyImkEUu6n20ZFmaLh1m9O5N6K3vbLqoHYbAnOJQdP7Jr6WiNX98ujnRF5DnyGAahoabDInU/6AD8szZE7GnbVjMNIvGNvVuTspZxrErG3Gk8ZaUwl4+LBO1BvzvVcUl47Q6BxGvZS3xpIT/X5DkK4446Eupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYZmUNfW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYZmUNfW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso30279635e9.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782162213; x=1782767013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+hBnMxhJkO6FDQAL0eqBCFsfSLziGXalyqU7rpqVDw=;
        b=iYZmUNfWGkDg81+a6uErbhY/9LOBD1YpkxGR/QJTIPUghu8pBwdDDyYu3M6p+sJTe3
         rM437Vl30ieukUqUF5kC7XD3oj9Ic2GXwUeSO9eCBy2HdPjmj2d6W8IRil49BufCYslJ
         Yu09PfEW4gXCd5wy68DCOoO998vcybgRJoud56vf5DNTLnZwWPH6bpmKbeE0dq3LlATS
         kRQERQ4LLi85sWi9OZ1I+kZZl96WMyiZzqWGEbMctpWTeW5cI+IMJCWCb6kgsiGIQxas
         cmIfXBXkYxptO2PHPo95jAjN0ZmQFZY5wfFt5VNOs5aTYUQZeVB2el42d6HLGK/Ls47K
         a3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162213; x=1782767013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+hBnMxhJkO6FDQAL0eqBCFsfSLziGXalyqU7rpqVDw=;
        b=N+M+2IYuR2LvN7e3Ly8bnx35TGzLGi9i+XaordFqOyaDu+FCgXyeAhu+PoBzZaBjlX
         58GAMF5qGeZDiGqUpUnqTPxY33Ylu+oU3BO/AQNwFjB80S+7r86wj9DKYpx6+V7XYThX
         RvTeMl7kk6SmXiNKdspTVvmWXpgoBDaGoeFGxWsSa9L7LxjWJaQjy+lZ63rUOjtk7GH/
         cSpnpvUAgfy+e0mqcUkkB5Fo1YcEKcK3tHP++fLmdM7g71Qa7m8zoP7MaRZpjLycyAIE
         eUiXM5wcvyAsETRQfbuRhbebHKfgduWyNpKjeQm5VlgIQNTpo+KZ40lD7cW+GnGM7dD1
         XQYw==
X-Forwarded-Encrypted: i=1; AFNElJ9DYtGY0tTjvnWicTbFtF1PCn4fP18gooALcFfQuEi95gKdK7YTMrdGw/YMpnMPL2DvBcng4IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzILLL+uibrcPAqxwCPXx85b9a7bej7TlOI+xxAWtCvJ4f0BpFS
	j4Lit2MBkJvDV/3DHC2JCtvT0ZGBSJ75ZRXyQG/AU63yQY7ogTVjGOy4mf9K
X-Gm-Gg: AfdE7ckYpQPiZMjYYxqmwceobI8vg/JAswqlQ+jcAvri1Qj4/Ns7/doS+LB3BiT2ofL
	ze8Q+KPxxaoio+PXZn2WR+r/fGvAnU8IPxWfoqARlfBxVTfsVu9mJEQ4neMATtPTI5ZNw/XtyBi
	q8YciST+QXYU9cYNCCOTTfH88fKzOkY0WXmqpiYqaTpQALnoaeuX2ILQ2i2T434zaJTm/Bt/BFC
	yGGPbYcPgC2kSGa8Ngr/4pYRFHe4XIxlcVlX0a+oISVoQFK29QbYcIxF2eDNhmADq35jZg2JdbS
	poZSAD9RaelGnIihokzv2eQx6f41WPimGHwsp/89VZ5922p9cMg+LWRth9tLe0osvDMfVn+McZo
	BMgF6zPibkhXV1IxxoqAyD/UmN6bdBj3m55fsCUnMgwrcrsmUeahtDYZ3Zg==
X-Received: by 2002:a05:600c:e548:20b0:492:3e69:a86f with SMTP id 5b1f17b1804b1-49240df7dafmr179983725e9.1.1782162213270;
        Mon, 22 Jun 2026 14:03:33 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49245bba787sm198208495e9.1.2026.06.22.14.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:03:31 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Richard Haines <richard_c_haines@btinternet.com>,
	selinux@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v2] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
Date: Mon, 22 Jun 2026 21:03:30 +0000
Message-ID: <20260622210330.3187099-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618232149.1780219-1-tristmd@gmail.com>
References: <20260618232149.1780219-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

selinux_sctp_bind_connect() dereferences sk->sk_socket to pass a
struct socket * to selinux_socket_bind() and
selinux_socket_connect_helper().  However, when the hook is invoked
from the ASCONF softirq path (sctp_process_asconf), there is no file
reference guaranteeing that sk->sk_socket is non-NULL.  The setsockopt
callers (bindx, connectx, set_primary, sendmsg connect) hold a file
reference and are not affected.

Both selinux_socket_bind() and selinux_socket_connect_helper()
immediately resolve sock->sk, never using the struct socket * for
anything else.  Refactor the inner logic into helpers that take a
struct sock * directly so that selinux_sctp_bind_connect() never needs
to touch sk->sk_socket at all.

Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Refactor selinux_socket_bind() and selinux_socket_connect_helper()
  into sk-based inner helpers instead of adding a NULL check on
  sk->sk_socket (Stephen Smalley)

 security/selinux/hooks.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..aa58a17da219 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4994,9 +4994,8 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
@@ -5126,13 +5125,17 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	return -EAFNOSUPPORT;
 }
 
+static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+{
+	return __selinux_socket_bind(sock->sk, address, addrlen);
+}
+
 /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
  * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
  */
-static int selinux_socket_connect_helper(struct socket *sock,
+static int selinux_socket_connect_helper(struct sock *sk,
 					 struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
@@ -5221,7 +5224,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
 
@@ -5706,13 +5709,10 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 	int len, err = 0, walk_size = 0;
 	void *addr_buf;
 	struct sockaddr *addr;
-	struct socket *sock;
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
 
-	/* Process one or more addresses that may be IPv4 or IPv6 */
-	sock = sk->sk_socket;
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
@@ -5741,14 +5741,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 		case SCTP_PRIMARY_ADDR:
 		case SCTP_SET_PEER_PRIMARY_ADDR:
 		case SCTP_SOCKOPT_BINDX_ADD:
-			err = selinux_socket_bind(sock, addr, len);
+			err = __selinux_socket_bind(sk, addr, len);
 			break;
 		/* Connect checks */
 		case SCTP_SOCKOPT_CONNECTX:
 		case SCTP_PARAM_SET_PRIMARY:
 		case SCTP_PARAM_ADD_IP:
 		case SCTP_SENDMSG_CONNECT:
-			err = selinux_socket_connect_helper(sock, addr, len);
+			err = selinux_socket_connect_helper(sk, addr, len);
 			if (err)
 				return err;
 
-- 
2.47.3

