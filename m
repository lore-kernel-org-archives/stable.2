Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A33C1D4F;
	Fri,  7 Aug 2026 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068245; cv=pass; b=fG6S77Ty1pT73G1EfWFwXSMiqjESN2cDhY0lYNqh1LfPaYu8E2G/DyOP12cDMj38flEJSq5yLPXSYEbuKjY2dITgZ1tj2SD4OuaqmYxA29iTQh6eZ4Vp5yhZ5laPtNZfLFYIQaG8BjULFe1vSX7SjFv8Yf8nM8GxBZZss/1N9Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068245; c=relaxed/simple;
	bh=oZml56gj2jBKNO7ThWS41H4lB8QwbYwH0VSbflecyo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZj4pE3SYEVg66Z1JBfeQhnOAwuZBI4w50W4NsVsXvtq8ObSEb8NC+c4Sh1BMsaTHpUHz1f6ZiOpYDU63aR/lG/+pXLOzPW0bD0BOI/aQZDBFdS/M9PXY1oR3RzAG8zxajaB4wS+wIDuH5xSaLQnDnOxIe87dianNY6HrGm4+yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=gmIXf5w5; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="gmIXf5w5"
ARC-Seal: i=1; a=rsa-sha256; t=1786068238; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=JgPCqpBlVYERkKzB4la8o2lqFgwF25EFS6Ma5R7dGzuqNoZjOXOhp7XIKKcLLPUmOhMUGzwPzJYnpgbZz2kHcqJEaKKMyiKYu0Y7Pxj+ZPCCuf4qwBpyFSolYAvdOhWO73zIy9hHLYw9VjVG38FxbtXSPV44OcHl1lQ5wPMAaKk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786068238; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qqLOH80rK4BG2aPXV3oGpbTkAHPUIWxCtrZaZX63BUg=; 
	b=hgJ3hqbycK6VTvpz88oumBl76CGxBLQcG5CRyKYTsUNMHM9GqC9bHKgel7AkhQhbFuBV1yfJmde6BlQvJhnl5Yp9NdGw3I4VCUXbIaBfs9WIoT9wC7aHCA1d+iCDsgY920t8Axh6yclIS4CsZjfHRFE24hZbuhB2LIEOCTAcaQc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786068238;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qqLOH80rK4BG2aPXV3oGpbTkAHPUIWxCtrZaZX63BUg=;
	b=gmIXf5w5vZCZ6XDvg+SrKmeA2eP12JP8U9f09sXjsnZly21WCVRDf8rzQnSujHwf
	A3UI8exKlgz9tq+MRDOJwqBPMRWynRVzVDNgby3goVyy82nP+U64XDs8PTAPSkWuec8
	5o2Xx8IHpdLiIDeo0AouVPcquOal5haKZtO7V/7g=
Received: by mx.zoho.eu with SMTPS id 1786068236394936.9346439661545;
	Fri, 7 Aug 2026 04:03:56 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept
Date: Fri,  7 Aug 2026 02:03:44 +0000
Message-ID: <20260807020345.111346-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

rfcomm_sock_recvmsg() completes a deferred setup by calling
rfcomm_dlc_accept() without holding any RFCOMM lock:

	if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags)) {
		rfcomm_dlc_accept(d);
		return 0;
	}

and rfcomm_dlc_accept() dereferences the session on its first line:

	struct sock *sk = d->session->sock->sk;

Every other path that touches d->session runs under rfcomm_mutex:
rfcomm_dlc_open(), rfcomm_dlc_close(), rfcomm_dlc_exists(),
rfcomm_dlc_send_rpn(), and the RFCOMM thread through
rfcomm_process_sessions(). rfcomm_connect_ind() is even documented as
"called under rfcomm_lock()". This call site is the only one that skips
it.

The RFCOMM_DEFER_SETUP bit looks like it serialises the accept against
teardown, since __rfcomm_dlc_close() returns early when it wins the
test_and_clear. But rfcomm_recv_disc() forces the state first:

	d->state = BT_CLOSED;
	__rfcomm_dlc_close(d, err);

and the early return only covers BT_CONNECT, BT_CONFIG, BT_OPEN and
BT_CONNECT2. With the state already BT_CLOSED that switch does not
match, the bit is never consulted, and __rfcomm_dlc_close() falls
through to rfcomm_dlc_unlink(), which sets d->session = NULL.

So a remote DISC on a deferred dlc clears the session while leaving
RFCOMM_DEFER_SETUP set. The next recvmsg() then passes the
test_and_clear and dereferences a NULL session. No timing window is
needed: once the DISC has been processed, the dereference is
unconditional.

Give rfcomm_dlc_accept() the same shape as rfcomm_dlc_open() and
rfcomm_dlc_close(): an exported wrapper that takes rfcomm_mutex and
re-checks the session, around a __rfcomm_dlc_accept() that the two
in-core callers, which already hold the mutex, keep using.

Reproduced on a KASAN + PROVE_LOCKING kernel with a BR/EDR peer emulated
over /dev/vhci: the peer brings up an ACL link, opens L2CAP on the
RFCOMM PSM, starts a session, opens a dlc on a channel bound with
BT_DEFER_SETUP, and sends DISC after the socket is accepted. recv() on
the accepted socket then hits:

  Oops: general protection fault
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:rfcomm_dlc_accept+0x54/0x350
  Call Trace:
    rfcomm_sock_recvmsg+0x1cd/0x230
    sock_recvmsg+0x166/0x1c0
    __sys_recvfrom+0x20d/0x300

0x10 is the offset of sock in struct rfcomm_session. With this patch the
same run completes with recv() returning 0 and no report, and lockdep
stays quiet, confirming rfcomm_mutex is still taken before lock_sock on
this path as it is on the thread side.

Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM connection setup")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 net/bluetooth/rfcomm/core.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 2e8c080b4d9e..9cdfea666a2c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1331,7 +1331,10 @@ static struct rfcomm_session *rfcomm_recv_disc(struct rfcomm_session *s,
 	return s;
 }
 
-void rfcomm_dlc_accept(struct rfcomm_dlc *d)
+/* Must be called with rfcomm_mutex held, so that the session cannot be
+ * unlinked from under us.
+ */
+static void __rfcomm_dlc_accept(struct rfcomm_dlc *d)
 {
 	struct sock *sk = d->session->sock->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
@@ -1353,6 +1356,21 @@ void rfcomm_dlc_accept(struct rfcomm_dlc *d)
 	rfcomm_send_msc(d->session, 1, d->dlci, d->v24_sig);
 }
 
+void rfcomm_dlc_accept(struct rfcomm_dlc *d)
+{
+	rfcomm_lock();
+
+	/* rfcomm_recv_disc() sets the dlc state to BT_CLOSED before calling
+	 * __rfcomm_dlc_close(), so the RFCOMM_DEFER_SETUP handshake there is
+	 * skipped and the session can already be unlinked by the time the
+	 * deferred accept runs from rfcomm_sock_recvmsg().
+	 */
+	if (d->session)
+		__rfcomm_dlc_accept(d);
+
+	rfcomm_unlock();
+}
+
 static void rfcomm_check_accept(struct rfcomm_dlc *d)
 {
 	if (rfcomm_check_security(d)) {
@@ -1365,7 +1383,7 @@ static void rfcomm_check_accept(struct rfcomm_dlc *d)
 			d->state_change(d, 0);
 			rfcomm_dlc_unlock(d);
 		} else
-			rfcomm_dlc_accept(d);
+			__rfcomm_dlc_accept(d);
 	} else {
 		set_bit(RFCOMM_AUTH_PENDING, &d->flags);
 		rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
@@ -1958,7 +1976,7 @@ static void rfcomm_process_dlcs(struct rfcomm_session *s)
 					d->state_change(d, 0);
 					rfcomm_dlc_unlock(d);
 				} else
-					rfcomm_dlc_accept(d);
+					__rfcomm_dlc_accept(d);
 			}
 			continue;
 		} else if (test_and_clear_bit(RFCOMM_AUTH_REJECT, &d->flags)) {
-- 
2.55.0

