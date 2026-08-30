Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119682EDD40
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788120723; cv=none; b=gJ5CTlAtQGrWPpap+vMYzYLjzLC3OmFB/jABPzs37JpEfyCwvtm8if6zMV98es7BHcUhrGI7vCL57ETnaawln6F+c7VA61Et90NZLxwJacVXpKYRJcFf+EGOJVUFEqf9H7yjxMTixpziCrmyV/p40QBuLMr2s7OSRWJ0plELbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788120723; c=relaxed/simple;
	bh=nIStPbRYErk3ezy2r6EqYsFH7tLz3CfhbEVVfCXhKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZQL5X+LrXVpUxY/HFJqecUidwgdvaUdoJV9nIWFucXSdRBbTx2dARsm0BA3Um5Z5s/IPjGk4O48DKb92x5nV7EwaOWDtyfOjFPs62+FnqSQ+vIlJg4UiPDOy2dSzAM/7o9qIVeP9YdcS5165BKuu9q5dgGAqZZ+pGiJuSU7a+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pBNVQtIn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBNVQtIn"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482fc2b44a7so2207544f8f.2
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788120720; x=1788725520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RzV+FoV5oAHMZYUIhoSmYtLJ26tyrSqOJB//e+KmOgQ=;
        b=pBNVQtIngFcgbWzjLw0PaktPbjJ5rerVmstoiE8U9U7fwlYMCDRC9F/lxrrNtzKrQc
         iVhlJ+l85chUMyrI9sm8l2Xk4bfWxi0UHwirX9mlSXxua3mCBjgekrz7iduI6MEuX7V6
         UGTU1O6tcksMDppNxDFvVo4HoItFKI8J4RLjZQ6PhKGN4bIZEAAqmj1tJl64LyjJ/48s
         Pl1hzR5KygPYASkd3OdRa964DIdrP71xtGyyNodqCcBR9vwz04/C/px9BB2SZE/FuLDR
         3P963LCxoJUDxQR3xLRNQoQ76Yw3jwNG47kwbFNTZh1uvds6/mFKEmWNJaWw070r31/y
         siiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788120720; x=1788725520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RzV+FoV5oAHMZYUIhoSmYtLJ26tyrSqOJB//e+KmOgQ=;
        b=eMorCM+mNRugOJGfIWqWXgtspKgxbcn/+BVqkVEm9k1X8mClZk4SpF7XcEyMXh6AQ+
         Sg9ArNhhBGAJazbsX14WVuix4xqCWIV4jZkp1SXfKXbyQutLuWu4jTwZLZT8MM3gnQVp
         SvCQ7U18WZcxA42uklIZkkKfxHoDHy1Bde+LEsq8mdnpk3cMq7AQvzvI5WAQQ8d3T7Ro
         0WrKXNM4zYTahrjEIt/swcZZZK7BiSPhj9KbMpESbXevleqv4orlT3nyGIKgPpUCI0WC
         eB25ZRA+UYowY31Xi6sSxfaq0u9U+x7q5hvERaZBxy+CQ9mrvHm8nYTfyKFoDXRlvqRZ
         kq2g==
X-Forwarded-Encrypted: i=1; AKwUvByYUSBioVXhqdEXgpL+ZsfBGc1Xg2HKmjaz/ktYDnEcU1nOO04Wi3cEqCoeYs9M+bH+k3r7UQE=@vger.kernel.org
X-Gm-Message-State: AFuF++lbRgD618AhzG+GEqtVOKmw9DWiTg+k8RIf7NvE88rBEseYUN39
	zaBP68c3gS7c1QZKFFdTqfyT+AQWDkhBPZFIoSSYtzyEAsQQ+rESLu99OM32
X-Gm-Gg: AYBFou274VVeUsTwBwxLjv8PBpJQAPpyKXKrZYJl8OVvH+68aBJSkZJgz8nhnG+i0Id
	ogvC9MhDe8FXT4l0yb4ChLGA0z9CLZILjz8tZd432wxN4BSiyY0feiroHhLER+XwjjKkbj+Jv7a
	zW70E5PJP7LPrhi24YKV0hp2faF+qTUdMgTHOzr1Dsf4QMKCLbdb5dkpuocSur/1YjTHR8qZts1
	Z11d8rVCyB3Dirh5zArxbg1yWZpLRj6U0lGAgQByjPwXJzmq64aodb2U1UcAT2iOOq9W1UAdcXv
	gsU9/Fn57INz1hhU2GH9ZPF/NsauUZnF4mUf130j3/pevIoWmWz3NheabfeP7g/O9fwsi5q5+qr
	MmuBxsu0YSGqgDVdshaUUDMXU83Mzh4Zor5W7CLtqmchUZdv1hYALhGbMKjuI9bAgMLhSryxB7l
	IUZyvV2opbQDy1SXsVgTURYZgaP6AUlQ==
X-Received: by 2002:a05:6000:1864:b0:481:503b:b663 with SMTP id ffacd0b85a97d-482f79c8523mr40262796f8f.18.1788120720057;
        Sun, 30 Aug 2026 13:12:00 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20713sm17047817f8f.21.2026.08.30.13.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:11:58 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Richard Haines <richard_c_haines@btinternet.com>,
	selinux@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
Date: Sun, 30 Aug 2026 20:11:57 +0000
Message-ID: <20260830201157.2084730-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

__selinux_socket_bind() and selinux_socket_connect_helper() call
sock_has_perm() which uses current_sid() as the AVC subject.  When
selinux_sctp_bind_connect() is invoked from the ASCONF processing
path (sctp_process_asconf), current refers to whichever task was
interrupted, so the permission check evaluates an unrelated subject.

Fix by extracting the sock_has_perm() call out of
__selinux_socket_bind() and selinux_socket_connect_helper() into
their callers.  The process-context wrappers (selinux_socket_bind,
selinux_socket_connect) call sock_has_perm() directly.

For selinux_sctp_bind_connect(), determine the caller SID based on
the optname: SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF
chunk parameter types only passed from the softirq processing path,
so use the socket own SID (sksec->sid), consistent with other
softirq-context hooks such as selinux_socket_sock_rcv_skb() and
selinux_sctp_assoc_request().  All other optnames originate from
process-context syscalls and use current_sid().

Factor out __sock_has_perm() with an explicit subject SID parameter
so that sock_has_perm() remains unchanged for all other callers.

Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Cc: stable@vger.kernel.org
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
  - Do not use sksec->sid unconditionally; determine the caller SID
    based on the optname so that process-context callers (bind, connect,
    connectx, sendmsg) still use current_sid()  [Paul Moore, Sashiko]
  - Factor out __sock_has_perm() with an explicit SID parameter and keep
    sock_has_perm() as a thin wrapper for all other callers
  - Move the sock_has_perm() call out of __selinux_socket_bind() and
    selinux_socket_connect_helper() into their respective callers
    (selinux_socket_bind, selinux_socket_connect, selinux_sctp_bind_connect)
 security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 035aaf113d1da..ab9653ae06fc8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4918,7 +4918,7 @@ static bool sock_skip_has_perm(u32 sid)
 }
 
 
-static int sock_has_perm(struct sock *sk, u32 perms)
+static int __sock_has_perm(struct sock *sk, u32 sid, u32 perms)
 {
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
@@ -4929,10 +4929,15 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 
 	ad_net_init_from_sk(&ad, &net, sk);
 
-	return avc_has_perm(current_sid(), sksec->sid, sksec->sclass, perms,
+	return avc_has_perm(sid, sksec->sid, sksec->sclass, perms,
 			    &ad);
 }
 
+static int sock_has_perm(struct sock *sk, u32 perms)
+{
+	return __sock_has_perm(sk, current_sid(), perms);
+}
+
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
@@ -5006,11 +5011,7 @@ static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int
 {
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
-	int err;
-
-	err = sock_has_perm(sk, SOCKET__BIND);
-	if (err)
-		goto out;
+	int err = 0;
 
 	/* If PF_INET or PF_INET6, check name_bind permission for the port. */
 	family = sk->sk_family;
@@ -5135,6 +5136,11 @@ static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int
 
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
+	int err;
+
+	err = sock_has_perm(sock->sk, SOCKET__BIND);
+	if (err)
+		return err;
 	return __selinux_socket_bind(sock->sk, address, addrlen);
 }
 
@@ -5145,11 +5151,8 @@ static int selinux_socket_connect_helper(struct sock *sk,
 					 struct sockaddr *address, int addrlen)
 {
 	struct sk_security_struct *sksec = selinux_sock(sk);
-	int err;
+	int err = 0;
 
-	err = sock_has_perm(sk, SOCKET__CONNECT);
-	if (err)
-		return err;
 	if (addrlen < offsetofend(struct sockaddr, sa_family))
 		return -EINVAL;
 
@@ -5232,6 +5235,9 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
+	err = sock_has_perm(sk, SOCKET__CONNECT);
+	if (err)
+		return err;
 	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
@@ -5731,13 +5737,25 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 				     struct sockaddr *address,
 				     int addrlen)
 {
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int len, err = 0, walk_size = 0;
 	void *addr_buf;
 	struct sockaddr *addr;
+	u32 caller_sid;
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
 
+	/* SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF chunk
+	 * parameter types passed from sctp_process_asconf() in softirq
+	 * context where current is not meaningful. Use the socket own
+	 * SID for permission checks in that case; all other optnames
+	 * originate from process-context syscalls.
+	 */
+	caller_sid = (optname == SCTP_PARAM_SET_PRIMARY ||
+		      optname == SCTP_PARAM_ADD_IP) ?
+		     sksec->sid : current_sid();
+
 	/* Process one or more addresses that may be IPv4 or IPv6 */
 	addr_buf = address;
 
@@ -5767,13 +5785,18 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 		case SCTP_PRIMARY_ADDR:
 		case SCTP_SET_PEER_PRIMARY_ADDR:
 		case SCTP_SOCKOPT_BINDX_ADD:
-			err = __selinux_socket_bind(sk, addr, len);
+			err = __sock_has_perm(sk, caller_sid, SOCKET__BIND);
+			if (!err)
+				err = __selinux_socket_bind(sk, addr, len);
 			break;
 		/* Connect checks */
 		case SCTP_SOCKOPT_CONNECTX:
 		case SCTP_PARAM_SET_PRIMARY:
 		case SCTP_PARAM_ADD_IP:
 		case SCTP_SENDMSG_CONNECT:
+			err = __sock_has_perm(sk, caller_sid, SOCKET__CONNECT);
+			if (err)
+				return err;
 			err = selinux_socket_connect_helper(sk, addr, len);
 			if (err)
 				return err;
-- 
2.47.3

