Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156490;
	b=aGuiHQ41Ckv6+b4iNWxTmZTiwYoMByJAjOgOkuFifqs0W1aj/K/UIZCFeeyAUTwHp6nk
	 smGoIdSCDCew4Q7c1SgjLJTky2NYh0httCLOHNx8H2m4+rRBAipjxLM8gdhC9aK/3Jl4J
	 eNhKsmH1NMsm70G45vV2GzkDIRTRwQKlvai4CQzpXsmiNjj7ySc9Nr9V7FedtJ2R7pdaZ
	 H1K3KdxtFUQyTSD1JCIOqaYgXvbTEJgKCyEMeSMRNS42RM18v7ryIkhoJNCo4V1h4czr0
	 fo4+RKs7PvMlqDataYLbII3VPPdPZ/9DNO6orinP1fSwI6e7c0MbsrtRS6SMYxRYZ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nDbZsYirix3QMOEIn80f0c4VmQbp/ZwzvITGOaV2xMQ=;
	b=mZwCsbM+3079+8Nah7HnSTjnH0sZGVvAcpRPi2gVWtNcHdcpS81Va8SLicHjEYirg0t6
	 F0Mu47Rob7f+xgFIkwBnaEHacvu25P2VnYXlv1UdaTg2jI5W6V2Z8ay/1ENYnWkOibwWf
	 6AZZSYrqjbWqjp7NRm2TGgCy0Z76AINLBxMRR9jN9H/PT5e2qXqAvIltHQCtE9OZ6TjSJ
	 Pu9G0AM/F4++9+PvJLlpW+1PdLyrU1LDhZ1mZOL64PFm2eMeoGauPoDc3LgFCr3RCsq5A
	 nQ8AWIkKA/xltRoor1J6dRx7Xd6weNmTpk0Ud6/DE1umdjquRO2/ALxXwNfafRZY0VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OW8Xd9AF;
	arc=none smtp.remote-ip=74.125.231.134
Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD5606A326
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65FD5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OW8Xd9AF
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8629eb92bebso229656a34.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156489; x=1795761289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nDbZsYirix3QMOEIn80f0c4VmQbp/ZwzvITGOaV2xMQ=;
        b=OW8Xd9AF4ZQAZL2FZpwb9GVujvBFvwfFYenu9u5Uwj1tQydA1z3S812ZxpAM3P1Z2n
         so9rvSu4G6m0vvv0hzmqAJNJ9ho/yuZ/ZodO98R8ayt/L06b7IX4fHX/M5NwjazJE+MT
         DII1lMNq5bAnieNPMfqpOrSIvgpkRcO+u4sW1AE/W6ArJzirNxl/zjkTrCBgrS+NMSur
         Up4sJE9GJVnAxJDStlCL7KlRlGXCD8/ebD+01+m0GT288meCPX+t7lmPLAv0EiMELgwj
         r2s7pYqEO0v/liJk42pTG7QhaTEYj1D7qQoKOyamxP5/p1JcyUZuWOs03xuW52yBnQZI
         jwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156489; x=1795761289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDbZsYirix3QMOEIn80f0c4VmQbp/ZwzvITGOaV2xMQ=;
        b=v6C6h+Lgegl/V4bCwJmAQNzS9AIGRbV/WhNjxF9fdjkfr1b4CPSIFdxbmIwWFbZ8mR
         qYc5yrVl0aIn4ZJY/6KQSaHagt+WQRBtnWtkBb3q4DtUkCGX7FpeLovqrklPmfn/Fla4
         Dmkj3oOmpRqxoP/qPWasbdJjH3T+UIfSYNFH5Biwpe+E8gdPQACLINKeb4t9dl6lwb7i
         3iWaQF5kIkwT793JQEKqR/cxj59pozbLsFE+tGsRO+L2qvRiWRHJf2v+z62jfCskKqpL
         kSbtdI8t13uT41TuFY1XQtd9dVJa4FeoJsvTyI5OoqWoLNi7KA6Vycm1ewd44fJAbavh
         rfSA==
X-Forwarded-Encrypted: i=1; AL+hErFRJugk8SblCHCwe9lYvmNvwCcSJ2ndiSiZJzFJIIwwciOmtNiGPajIkwLmfOH1cnmfMToRIr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bANGXVESaWlkBxLJSFGXmR6RKZf8mYext8JAIqEi0ge/4yfdp
	GQ4IaA5aRMes9gYhfgdRxV5tuLXth7wErJqm2V8FTKmmaVN1/YYr6iwL
X-Gm-Gg: AYBFou2gqpGEMu3n9MXwVsiz1c+XWwdglpRUgvGEz+C3aF8wahjs72tQXjHWKKYMpUX
	gzt5NQREbqRM50IY5v1UKiDAPD8+hYskYw+H0lNuuioxvoytRzhIjKi4bcyQ/3nii8f3VInymjA
	jomw/tgWzxzoWCy04VfKB+yyZWSc+btnPU9lO0N3owiI/YUAiH1qfl7OnOwAbw62p8Tn/fy7+3E
	tQy+uSiRd9GqDRFmUN0XNiTzlg5H8duzV5D7+S6pvxQmr8MuRVL/6nn8m19Sj2wV6wHNdZKh8ht
	TagPsVHoUU2a1o0D7AFxwIKyqrECi1aFCIKiraBhN0x/zyaTqf96doJMmFTo8ncr6xHeBWdMWmK
	Amq3bfV62tGhhuSR3psfl3WPokgnPCUZ0JSLuSVIfuNzVn2fWVzHUb5D0okuk6RGJcgxFoI7WWs
	0AYNijz+C0wJzFFO/3A+lEgI17vJn7c+R2BxjYUpc1G8QtpAzSAf/MxXBIV2Wnf3iB2PYkUycy3
	GRFwWp0QupeAig4efX1QwU7sBwfs7c3FguHmPXQjf+6zYg2GfC3Qv8NLcsW+xacfwdU+/fZASzW
	N9hcG3b8K7jnB+MuStxJ4zAoVys89pe1xda6aEX96vZcz1DtBONyfRoVzBKEBWJNX6VEALdAjvD
	7F/M50cLQZkyMOA==
X-Received: by 2002:a05:6820:5201:b0:71a:e95a:34dd with SMTP id 006d021491bc7-71b39591d9amr1586691eaf.78.1795156489197;
        Thu, 19 Nov 2026 22:34:49 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b37ea818bsm1513192eaf.1.2026.11.19.22.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:34:47 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Juan Perdomo <jcperdomo100@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Zhang Cen <rollkingzzc@gmail.com>,
	Siwei Zhang <oss@fourdim.xyz>,
	Maxim Skokov <skokovmaksimevg@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	safa.karakus@secunnix.com,
	Hui Peng <benquike@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Tim Bird <tim.bird@sony.com>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	aliamemis@disroot.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: fix race on dlc->session in RFCOMM_CONNINFO getsockopt
Date: Fri, 20 Nov 2026 14:33:43 +0800
Message-ID: <20261120063343.3875317-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

The RFCOMM_CONNINFO getsockopt handler checks dlc->session under
lock_sock() and then follows it:

	l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;

Nothing serializes this against rfcomm_session_close(). The session
thread unlinks every dlc with __rfcomm_dlc_close() - which sets
d->session = NULL - and then frees the session in rfcomm_session_del(),
all under rfcomm_mutex and without ever touching lock_sock.

An ioctl(RFCOMMCREATEDEV) with REUSE_DLC replaces the dlc state_change
callback with rfcomm_dev_state_change(), which does not take
lock_sock(), and sets sk_state to BT_CLOSED only after rfcomm_dev_add()
returns. During that window every check in the CONNINFO branch passes
while a full-session shutdown from the peer unlinks and frees the
session. The check and the dereference then lose the race:

  KASAN: slab-use-after-free in rfcomm_sock_getsockopt
  Read of size 8 (session->sock, offset 0x10)
  Allocated by rfcomm_session_add, freed by rfcomm_session_close

or, if the session is freed between the check and the dereference, the
dereference observes a cleared session->sock->sk and faults on a NULL
l2cap socket:

  KASAN: null-ptr-deref in range [0x350-0x357]
  (l2cap_pi(NULL)->chan)

rfcomm_session_close() runs under rfcomm_mutex from the session
thread. Take rfcomm_mutex before lock_sock() in the CONNINFO path so
that the session cannot be unlinked or freed between the check and the
dereference. This is the order the rest of the driver uses:
rfcomm_connect_ind() takes lock_sock(parent) with rfcomm_mutex held,
rfcomm_sk_state_change() runs from __rfcomm_dlc_close() with it held,
and the connect and shutdown paths drop the socket lock before calling
into the core.

Copy the result to user space after dropping both locks, so that a
faulting user buffer cannot stall the session thread.

e.g. on a KASAN build, with a userspace RFCOMM peer sending DISC(0)
during the REUSE_DLC window:

  KASAN: slab-use-after-free in rfcomm_sock_getsockopt+0x714
  Read of size 8 at addr ffff88810dfce210 by task poc/1748
  Allocated by rfcomm_session_add:
   rfcomm_run (krfcommd)
  Freed by rfcomm_session_close:
   rfcomm_run (krfcommd)

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
No Fixes: tag: both the CONNINFO dereference and the REUSE_DLC wiring
predate git history (they are present in 1da177e4c3f4), so there is no
commit to point at.  Cc: stable is added because the race affects
every released kernel.

 include/net/bluetooth/rfcomm.h |  4 ++++
 net/bluetooth/rfcomm/core.c    |  5 ++---
 net/bluetooth/rfcomm/sock.c    | 23 +++++++++++++++++++++--
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 9dc5fd4cb8c8..251ae43b4400 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -148,6 +148,10 @@ struct rfcomm_msc {
 
 /* ---- Core structures, flags etc ---- */
 
+extern struct mutex rfcomm_mutex;
+#define rfcomm_lock()	mutex_lock(&rfcomm_mutex)
+#define rfcomm_unlock()	mutex_unlock(&rfcomm_mutex)
+
 struct rfcomm_session {
 	struct list_head list;
 	struct socket   *sock;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a4205347c4a..655c55e1f2ce 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -42,9 +42,8 @@ static int channel_mtu = -1;
 
 static struct task_struct *rfcomm_thread;
 
-static DEFINE_MUTEX(rfcomm_mutex);
-#define rfcomm_lock()	mutex_lock(&rfcomm_mutex)
-#define rfcomm_unlock()	mutex_unlock(&rfcomm_mutex)
+/* Serializes session_list walks and dlc/session teardown. */
+DEFINE_MUTEX(rfcomm_mutex);
 
 
 static LIST_HEAD(session_list);
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3fb8b5474948..23bafb42e685 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -747,11 +747,20 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 	int err = 0;
 	size_t len;
 	u32 opt;
+	bool copy_conninfo = false;
 
 	BT_DBG("sk %p", sk);
 
 	len = sopt->optlen;
 
+	/* The RFCOMM_CONNINFO branch follows dlc->session, which
+	 * rfcomm_session_close() unlinks and frees under rfcomm_mutex.
+	 * Take the mutex first, like every other path that walks
+	 * dlc->session: it must be held before lock_sock().
+	 */
+	if (optname == RFCOMM_CONNINFO)
+		rfcomm_lock();
+
 	lock_sock(sk);
 
 	switch (optname) {
@@ -802,8 +811,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
 		len = min(len, sizeof(cinfo));
-		if (copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
-			err = -EFAULT;
+		copy_conninfo = true;
 
 		break;
 
@@ -813,6 +821,17 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 	}
 
 	release_sock(sk);
+
+	if (optname == RFCOMM_CONNINFO)
+		rfcomm_unlock();
+
+	/* Copy out after dropping the locks: a faulting user buffer must
+	 * not stall the session thread.
+	 */
+	if (copy_conninfo &&
+	    copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
+		err = -EFAULT;
+
 	return err;
 }
 
-- 
2.43.7

