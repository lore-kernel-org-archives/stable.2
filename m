Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0D374E57
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431624; cv=none; b=TjloiCbOob0Sr8AxadtvSNfseaoS4zuOx0OQxcvs8Vbi8ab44mOMTMY4c4Z7ljF7exnOEVG7QYtPq22tkUWh8eXJ4xwYYTDw2gnjzYnD9oHvbaWyX6uvcBMqFG5YYmb52QZAgnlpi/OdLXIIdeAzHJZyuy1+z30eI31XBnkfr3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431624; c=relaxed/simple;
	bh=SZxuankCvUX6ApChHtho3Rt2t5QOrvDbrJtuqI4WIho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=driIl8mehpGKgMhjge/n6ItxcGcBgD2/31KlvDWw9BlRHeUStQtALLAGM85fIWvGdONFzB2LECno1tokh5hAjveRhzf7JaNKIC0P85Ny8BunMgliF6Ttke9r5+6osGabFv2oQ5myfow2h3jKUwSTX0ae7WmUpiyqLaMtBzT8Unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3CmUnRq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3CmUnRq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4923139e940so2345425e9.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782431620; x=1783036420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCBP2ycGuS7vhe9+Yccf8aICwkrlxSyd4hD3m1eGqSo=;
        b=k3CmUnRq5EPbTlePoForv5ISjmqe4GFdHdu7LiVNvnPe2GiMtclqQZc+guqUOH1/HY
         llpefpu8NXidsPrY+8Xu8mp0KmIL5ykNozJlrz+iE6H9Jox+fODR1PuvMgDzX5+whUvG
         me4uDtz9PUYpVwbBqoUVq3FMDhOq1B7HPy32lqxZwa4q+SD2ZB1qz+dlXk4a/ukvjJp1
         xiTWqzbCF+cLqBck6v/1OQF/80x4ml7iGNhSRyDqJ6do1goAUsTi9glW3auaQZqXGfVL
         SATwjloPt37S30amez+luikjiOjzMov9rftS7EE3yj0VGJbh6P5v/vu86ojDwEzzU3zP
         CJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782431620; x=1783036420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCBP2ycGuS7vhe9+Yccf8aICwkrlxSyd4hD3m1eGqSo=;
        b=j2+2WSsaiX01dZtKd3k290kjKiMLPMIrOgOfBWQGTP5mhUGKt+Hizx8hPRRRiGpsjb
         5T1KR9XLbnKsJ9SIhC1Nyqkt1t04JJSJAum9LJE1n3/fsK0VGDItRb46hYyRI0n2/sW3
         au5Zy/9DfMoJHaHKagvV480nkWH4Di5biha6Ppa/NvHo7flYpC7u/mM3so8gHk/9F15m
         QFqRVCWUwST4nIiiC2QSbDlNNSLQ4LaPYKjoJe7Jpg/MbsyMzF/8yOw3BMUPYLWE8k+e
         qFIRm+hyB0cYz+DVcEfUfS+zA33hqnfzHE3di1lsvztLgFXTlqPqhhsOTUcoSoSHm2TB
         zgDg==
X-Forwarded-Encrypted: i=1; AFNElJ+DmkAf6666uncz5OBjrfqDLh0bjNShSADCdpQwDlerLZ8spp5puHZFpyXWvX82IjFv6uqgjHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMpIw/ZGw/4QZg9CZzW9UMAiIe9drpnV7sdf6ibKWECRAI/Rh
	EHSuc1e2Hh/9Vshzdk9VRhsFZqW3mjsCpWmeVvIR8srLjbq3iBs89zM=
X-Gm-Gg: AfdE7ckly0h5F+5jJouO2gLIlE/PjkSTMJNcMAKrRLCOrUpiLPgXsyBvisWfYoZE9gp
	fwLMsKxdrB8klAp/H7aF5wqCBTQBR2CCNce2CAW5ieK30WiOvkMiiS5iQxe5S0FWa9Hsmxv0Jra
	GiU9vuT8cQpRutn2ZqcpfpLwJZGrlW3ltI3/z/L8+rwrg6mbOM6x4w092dBqYo7O50KNMYLAbvC
	xeot7WNOyYdDew5JetoVt5G1weIcWkokIi8AhUDfpcmwGOFsKfuSzGUmQzzWTr+TU29roeO4JrC
	An6sRTegsr+kWslVJDeS/IcQF3VgXwRw9ta5Hr8Zm8aj46fKtZW03O0evMGYT6O7pgD2PohDRvv
	FoZkNRJTErbMkcpws7nJgvmGZ1jMcMsyfUWz6SQLEKBdZy6xjEXIO3kiKaA==
X-Received: by 2002:a05:600c:c04b:10b0:492:418b:b5e1 with SMTP id 5b1f17b1804b1-492668b02damr50677105e9.37.1782431620004;
        Thu, 25 Jun 2026 16:53:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279bc77sm18979840f8f.32.2026.06.25.16.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 16:53:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Richard Haines <richard_c_haines@btinternet.com>,
	selinux@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH v3] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
Date: Thu, 25 Jun 2026 23:53:36 +0000
Message-ID: <20260625235336.3641828-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
Changes in v3:
  - Keep comment describing IPv4/IPv6 address processing loop
    (Stephen Smalley).

Changes in v2:
  - Refactor selinux_socket_bind() and selinux_socket_connect_helper()
    into sk-based inner helpers instead of adding a NULL check on
    sk->sk_socket (Stephen Smalley).

 security/selinux/hooks.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc926d3..1f202f6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4689,9 +4689,8 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
@@ -4825,13 +4824,17 @@ err_af:
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
 
@@ -4924,7 +4927,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
 
@@ -5409,13 +5412,11 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 	int len, err = 0, walk_size = 0;
 	void *addr_buf;
 	struct sockaddr *addr;
-	struct socket *sock;
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
 
 	/* Process one or more addresses that may be IPv4 or IPv6 */
-	sock = sk->sk_socket;
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
@@ -5444,14 +5445,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
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

