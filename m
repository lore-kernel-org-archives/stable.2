Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749A48E0C6
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818828; cv=none; b=Qppoe6qwGoHJKSpTvQEl6KXTKs0VrhzeTRoHIoTg6xsbQEgA1dRi8ZEbf2HoEjFSkPK8O716d8FMeIC32TGNd6tLSSKd538jV2rdRQFEhmMkYb9eLhh9B07OJHDxag+PRg15t3Pa0k8llTbAGqMGCFjjPpojXk1py376ew1dmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818828; c=relaxed/simple;
	bh=R/nJ/5DFxBmchVNerkDorXToaVnZHjMCWESLRLH/wKk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UXTPR5RnhJTEwcvfq62wXUO/oTYO80Ty/lhARLwZLTGJO2nCgpZ4Bpz5fPP/Yoo5XI7H5PvoBjzx6SFJYbPRsjPLDOCXSLMkoU1J+9JMtz1fQVet1d7iaBRpDdd6z9RJ5N/biGm1VS3K8/KFyf/D2K3enUjTeOyG36SEVgnRtwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zFIAqZjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zFIAqZjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B5F1F0089B;
	Mon, 12 Oct 2026 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791818826;
	bh=WL4sP4zeAhw2NGhdkzcPBYICoWwVvOOtZdg8HadWCkw=;
	h=Subject:To:Cc:From:Date;
	b=zFIAqZjHuQB51BrtZJgVKqowSByBIHBB4LVc5RnJWwZGb/3IokxGygAyEq48ZXa58
	 dwecocYWYy5ik1ALhfvDQ3VZQ867f9IQt4BPZW3YkPqieg2l/vvcGy2nRgD4qd5NH4
	 ezag2mZd7TqiXMJWnfu7NdIQiFIsxf7TNFL7v7wo=
Subject: FAILED: patch "[PATCH] Bluetooth: RFCOMM: connect the session socket without" failed to apply to 6.12-stable tree
To: mikhail.v.gavrilov@gmail.com,luiz.von.dentz@intel.com,pav@iki.fi,r772577952@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:27:08 +0200
Message-ID: <2026101208-jailbreak-cuddly-877a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ac022970e9fb0a5f7e7d1f6c8e104c1ed924dd1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101208-jailbreak-cuddly-877a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ac022970e9fb0a5f7e7d1f6c8e104c1ed924dd1c Mon Sep 17 00:00:00 2001
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 29 Sep 2026 17:22:26 +0500
Subject: [PATCH] Bluetooth: RFCOMM: connect the session socket without
 rfcomm_mutex

An RFCOMM connect() issued while a BR/EDR link is being authenticated
makes lockdep report a circular dependency, and the reported cycle is a
real AB/BA between rfcomm_mutex and hdev->lock.

rfcomm_security_cfm() is called from the HCI event path, which already
holds hdev->lock:

  hci_rx_work()
    hci_event_packet()
      hci_cc_read_enc_key_size()   [hdev->lock]
        hci_encrypt_cfm()          [hci_cb_list_lock]
          rfcomm_security_cfm()    [rfcomm_mutex]

while an RFCOMM connect() from userspace takes the same two locks the
other way round:

  rfcomm_sock_connect()
    rfcomm_dlc_open()              [rfcomm_mutex]
      __rfcomm_dlc_open()
        rfcomm_session_create()
          kernel_connect()
            l2cap_sock_connect()
              l2cap_chan_connect() [hdev->lock]

  WARNING: possible circular locking dependency detected
  kworker/u131:1/1128 is trying to acquire lock:
  rfcomm_mutex, at: rfcomm_security_cfm+0x31/0x3e0 [rfcomm]
  but task is already holding lock:
  hci_cb_list_lock, at: hci_cc_read_enc_key_size+0x1d2/0xcc0
  Chain exists of:
    rfcomm_mutex --> &hdev->lock --> hci_cb_list_lock

hci_auth_complete_evt() and hci_encrypt_change_evt() reach the callback
the same way.

Both orders have to be seen in the same boot, which is why a BR/EDR
connection alone is not enough to show it: a session set up by the
remote side is created by rfcomm_accept_connection() in krfcommd, which
calls kernel_accept() and never takes hdev->lock under rfcomm_mutex.
Connecting a device that authenticates and encrypts the link and then
calling connect() on an RFCOMM socket towards any address - the connect
does not have to succeed, the order is recorded before the page timeout
- reports it every time.

Only the session socket has to be connected with the lock held, and it
does not: nothing else can see the socket before it is put on the
session list.  So connect it first and take rfcomm_mutex afterwards,
which removes the rfcomm_mutex -> hdev->lock order for good, rather
than keeping the HCI event path out of rfcomm_mutex.

rfcomm_session_create() becomes rfcomm_session_connect(), which returns
the connected socket without touching the session list, and
rfcomm_dlc_open() adds the session once it holds the lock again.  If
another opener added a session for the same pair while this socket was
connecting, that session is used and this socket is dropped.
__rfcomm_dlc_open() now takes the session it should use, and its state
check runs after the lock is re-acquired, so a DLC that was opened or
closed in the meantime is still handled.

Over an existing ACL link the connection can complete before the
session reaches the list, and the wakeup from the socket callback is
then lost, so krfcommd is woken once the session is visible.

Connecting without the lock opens a window in which the socket can be
closed.  The DLC is not on a session yet, so rfcomm_dlc_close() finds
nothing to do and returns without touching it, and rfcomm_dlc_open()
would then attach a DLC whose owner is gone.  rfcomm_dlc_close() now
marks such a DLC with RFCOMM_CLOSED, and rfcomm_dlc_open() checks the
mark once it holds rfcomm_mutex again and drops the socket instead of
attaching the DLC.  The mark is cleared when an open starts, so a DLC
that is reused is not affected.  This covers both callers of
rfcomm_dlc_open(), the socket and the tty layer.

Fixes: 759c185d0bbd ("Bluetooth: RFCOMM: serialize security confirmation handling")
Suggested-by: Pauli Virtanen <pav@iki.fi>
Reported-by: Pauli Virtanen <pav@iki.fi>
Closes: https://lore.kernel.org/linux-bluetooth/5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi/
Reported-by: syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/6a92fadc.08e933ee.dbf97.008f.GAE@google.com/
Reported-by: Jiaming Zhang <r772577952@gmail.com>
Closes: https://lore.kernel.org/all/CANypQFabseTuRiyz2pGkc_Qj0moGDnY7KEp1qdTOqkw6gAL3hw@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 102c278e3584..9dc5fd4cb8c8 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -207,6 +207,7 @@ struct rfcomm_dlc {
 #define RFCOMM_AUTH_REJECT  7
 #define RFCOMM_DEFER_SETUP  8
 #define RFCOMM_ENC_DROP     9
+#define RFCOMM_CLOSED       10
 
 /* Scheduling flags and events */
 #define RFCOMM_SCHED_WAKEUP 31
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d91e2a6ee26c..54ec1136f87e 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -62,10 +62,9 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 addr);
 
 static void rfcomm_process_connect(struct rfcomm_session *s);
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
-							bdaddr_t *dst,
-							u8 sec_level,
-							int *err);
+static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *dst,
+					     u8 sec_level, int *err);
+static struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state);
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
 static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);
 
@@ -365,28 +364,17 @@ static int rfcomm_check_channel(u8 channel)
 	return channel < 1 || channel > 30;
 }
 
-static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel)
+static int __rfcomm_dlc_open(struct rfcomm_dlc *d, struct rfcomm_session *s,
+			     u8 channel)
 {
-	struct rfcomm_session *s;
-	int err = 0;
 	u8 dlci;
 
-	BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
-	       d, d->state, src, dst, channel);
-
-	if (rfcomm_check_channel(channel))
-		return -EINVAL;
+	BT_DBG("dlc %p state %ld session %p channel %d",
+	       d, d->state, s, channel);
 
 	if (d->state != BT_OPEN && d->state != BT_CLOSED)
 		return 0;
 
-	s = rfcomm_session_get(src, dst);
-	if (!s) {
-		s = rfcomm_session_create(src, dst, d->sec_level, &err);
-		if (!s)
-			return err;
-	}
-
 	dlci = __dlci(__session_dir(s), channel);
 
 	/* Check if DLCI already exists */
@@ -421,14 +409,84 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 
 int rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel)
 {
-	int r;
+	struct rfcomm_session *s;
+	struct socket *sock;
+	int err;
+
+	BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
+	       d, d->state, src, dst, channel);
+
+	if (rfcomm_check_channel(channel))
+		return -EINVAL;
 
 	rfcomm_lock();
 
-	r = __rfcomm_dlc_open(d, src, dst, channel);
+	clear_bit(RFCOMM_CLOSED, &d->flags);
+
+	/* Do not page the remote device for a DLC that cannot be opened
+	 * anyway.  __rfcomm_dlc_open() looks at the state again once the
+	 * lock has been re-acquired below.
+	 */
+	if (d->state != BT_OPEN && d->state != BT_CLOSED) {
+		rfcomm_unlock();
+		return 0;
+	}
+
+	s = rfcomm_session_get(src, dst);
+	if (s) {
+		err = __rfcomm_dlc_open(d, s, channel);
+		rfcomm_unlock();
+		return err;
+	}
+	rfcomm_unlock();
+
+	/* There is no session for this pair yet.  kernel_connect() ends up in
+	 * l2cap_chan_connect(), which takes hdev->lock, and the HCI event
+	 * path takes rfcomm_mutex while holding hdev->lock, so the socket has
+	 * to be connected with rfcomm_mutex released.
+	 */
+	sock = rfcomm_session_connect(src, dst, d->sec_level, &err);
+	if (!sock)
+		return err;
+
+	rfcomm_lock();
+
+	/* The DLC may have been closed while the socket was connecting.  It
+	 * was not on a session, so rfcomm_dlc_close() could only mark it;
+	 * attaching it now would leave it with no owner.
+	 */
+	if (test_bit(RFCOMM_CLOSED, &d->flags)) {
+		rfcomm_unlock();
+		sock_release(sock);
+		return -ECONNRESET;
+	}
+
+	/* Another opener may have added a session for the same pair in the
+	 * meantime; that one is used and this socket is dropped.
+	 */
+	s = rfcomm_session_get(src, dst);
+	if (!s) {
+		s = rfcomm_session_add(sock, BT_BOUND);
+		if (s) {
+			s->initiator = 1;
+			sock = NULL;
+		}
+	}
+
+	err = s ? __rfcomm_dlc_open(d, s, channel) : -ENOMEM;
 
 	rfcomm_unlock();
-	return r;
+
+	if (sock)
+		sock_release(sock);
+
+	/* Over an existing ACL link the connection can complete before the
+	 * session reaches the list, and that wakeup is then lost, so let
+	 * krfcommd look at the socket state now.
+	 */
+	rfcomm_schedule();
+
+	return err;
 }
 
 static void __rfcomm_dlc_disconn(struct rfcomm_dlc *d)
@@ -508,8 +566,14 @@ int rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 	rfcomm_lock();
 
 	s = d->session;
-	if (!s)
+	if (!s) {
+		/* Not on a session yet: rfcomm_dlc_open() may be connecting a
+		 * socket for it with rfcomm_mutex released.  Leave a mark so
+		 * that it does not attach the DLC once it holds the lock again.
+		 */
+		set_bit(RFCOMM_CLOSED, &d->flags);
 		goto no_session;
+	}
 
 	/* after waiting on the mutex check the session still exists
 	 * then check the dlc still exists
@@ -757,12 +821,12 @@ static struct rfcomm_session *rfcomm_session_close(struct rfcomm_session *s,
 	return rfcomm_session_del(s);
 }
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
-							bdaddr_t *dst,
-							u8 sec_level,
-							int *err)
+/* Creates the L2CAP socket a new session will run on and starts connecting
+ * it.  Must be called with rfcomm_mutex released.
+ */
+static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *dst,
+					     u8 sec_level, int *err)
 {
-	struct rfcomm_session *s = NULL;
 	struct sockaddr_l2 addr;
 	struct socket *sock;
 	struct sock *sk;
@@ -792,24 +856,16 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 		l2cap_pi(sk)->chan->mode = L2CAP_MODE_ERTM;
 	release_sock(sk);
 
-	s = rfcomm_session_add(sock, BT_BOUND);
-	if (!s) {
-		*err = -ENOMEM;
-		goto failed;
-	}
-
-	s->initiator = 1;
-
 	bacpy(&addr.l2_bdaddr, dst);
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_psm    = cpu_to_le16(L2CAP_PSM_RFCOMM);
 	addr.l2_cid    = 0;
 	addr.l2_bdaddr_type = BDADDR_BREDR;
 	*err = kernel_connect(sock, (struct sockaddr_unsized *)&addr, sizeof(addr), O_NONBLOCK);
-	if (*err == 0 || *err == -EINPROGRESS)
-		return s;
+	if (*err && *err != -EINPROGRESS)
+		goto failed;
 
-	return rfcomm_session_del(s);
+	return sock;
 
 failed:
 	sock_release(sock);

