Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5D522EF4;
	Mon, 21 Sep 2026 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029593; cv=none; b=H9Wli2cbj1ioBHhYnNopNx4lzneR9lrEm2DMpamEwdn+zzREURVMsGHjwSoEWDW6A4TKi9H2vVVSmuunGVXy/nQDBqfHcSSRbrmKbZiHsb2zgr/4bOGC9oJR0txiSycg4Fh6h/ZstlRY/nd53HhqWAg3VpsFTfeU/PPjWGqWbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029593; c=relaxed/simple;
	bh=g1hpG9X//J1B6B1nTr4FN0ADnVa+8yixPSkWZ3UiIwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1UhcC8dhWkNSOS1tgTSrZTntnmEeuRymkivko5o8y8ausauVyuiUzayrDpkHSm/z8d6mRHf9+M1bEy9fll1uLeEI2lO2Xl8SFVJalHqcehUAPA2hsMS8l1yAMJ9Tjp4LOODJ8LcT/WVYTK1O81kMnn77u6FTGrKJANBI9+hk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLo/+Yff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLo/+Yff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0081F000FF;
	Mon, 21 Sep 2026 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029591;
	bh=UlfYxFsZ+OYZEit5B/5bYhaHCFI3AdBcSjKvlFEhjOk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RLo/+Yff2I75BNQhmJGclMQ+ZHsjgQLL8lfMjNWgNveEVWlUbQ3/fBP+L/IcvDd6f
	 +I8ttwU26M6AuTo17vAYnaDOte+bIhDxoejs9ZFeS546DmbpBTjyMknJ+Z6VS8UhqK
	 uwGBu7yx1gdOk/NG7W/mqx7EBI5DaysU79/9TliK5+QdY8Hg6Cc9d0BuASgkWa5kQ4
	 7RBnE4/XQCmluN9l2CNmG6TOJPJj/BAZL5ONpcnY3OpY7a6JMOxk+DuFWDD7vZy1rQ
	 3tOWi6vBlRA+i3k8k2mdnQQWgQHFA+E7Nv8wJ8rx8Q6Eo+8RN+lTAB1ZDe87v947R9
	 CoByEUn8UFKoA==
From: Michael Grzeschik <mgr@kernel.org>
Date: Tue, 22 Sep 2026 00:26:00 +0200
Subject: [PATCH 7/7] net/9p/usbg: clear stale client pointer on close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-usb9pfsfixes-v1-7-9d8dcc52904c@kernel.org>
References: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
In-Reply-To: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <mgr@kernel.org>, Hyungjung Joo <jhj140711@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6091; i=mgr@kernel.org;
 h=from:subject:message-id; bh=tC038ezHdlUfFI/3EG7MxZmCGxI5Nw5bzI3ZV5Lf6+Q=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqsa8FLxLE6pEVIETB6e7CJeH3L9SkipP5VoNzo
 SNQOLrufeeJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCarGvBQAKCRC/aVhE+XH0
 qyPaEACDyC9s+vkbbAx1IalaiVxI8ZnVzGuhn9brUYjgs8n3BoMWc/LapekRt+nYoz99jCbJh4O
 piQ4iCLFIpRmc9czXR0AdijNoUA/+dSbFY6UOqZHNEbIkAsViH/V6VnCriHw/Ou0bNfmDH5igRg
 k0ObGtQSx1KMyfiq2MOoEO3z+KFlS7XGySFYh1b6ep5wHnAb3ryu9QDQQ03p7c+vRG5JfzrnkBB
 ASsfecWEeazJhRP1SYeBLxShsoSnshcVv63PTDSNDdNDS6DwGrev4MXenE+UnJO9w74uSLZLHyh
 9oX4xh7jZ+LyMMWjy3G8sgzKKlpC2568DJX8PRCXLNa+BBANOnKzyc+fnrkYSd6cBh8oHco8QMM
 k1cYOgMofLglHdqybaNsH3aD0a3joF2kcJMgAo9LN8gypWjLAV8uAwbXymV95Y67UKMLJPjHlsW
 G0rzzsAVCgQTorSRmemTu1rB09Kx0u+gZXyrIDDXoQF359/qQPz5W2vUxj7QmLHCSKBNIGsO+Y/
 RsPovqYCvDiTF8lLNrO1iSHPiK9tJl01RLaGGWpFw+PM7W9FekLPhb+zOEYtOiytaGjTV/bLAy1
 vQLNjWGbWwG5EV3/nOS1299z83mLadLIQ4bXp3oaY3gDEuu0JWxrLt7qblYDKeryX2kv/D+no7Y
 AizUOF1x+i6nbIQ==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64

From: Hyungjung Joo <jhj140711@gmail.com>

p9_usbg_close() tears down the client transport, but usb9pfs keeps
using usb9pfs->client from asynchronous TX and RX completion handlers.
A late completion can therefore dereference a client that has already
been freed during mount teardown.

Clear usb9pfs->client under usb9pfs->lock when closing the transport,
detach any pending TX request from in_req->context, and make the TX/RX
completion handlers bail out once the transport has been detached. This
keeps late completions from touching a freed or rebound p9_client.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>
Signed-off-by: Michael Grzeschik <mgr@kernel.org>
---
 net/9p/trans_usbg.c | 61 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 544690a5c717..c6306b073089 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -149,7 +149,8 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_usb9pfs *usb9pfs = ep->driver_data;
 	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
-	struct p9_req_t *p9_tx_req = req->context;
+	struct p9_client *client;
+	struct p9_req_t *p9_tx_req;
 	unsigned long flags;
 
 	/* reset zero packages */
@@ -165,18 +166,25 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
 		ep->name, req->status, req->actual, req->length);
 
 	spin_lock_irqsave(&usb9pfs->lock, flags);
-	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
+	client = usb9pfs->client;
+	p9_tx_req = req->context;
+	req->context = NULL;
 
-	p9_req_put(usb9pfs->client, p9_tx_req);
+	if (!client || !p9_tx_req)
+		goto unlock_complete;
 
-	req->context = NULL;
+	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
 
+	p9_req_put(client, p9_tx_req);
+
+unlock_complete:
 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
 	complete(&usb9pfs->send);
 }
 
-static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
+static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs,
+					  struct p9_client *client, void *buf)
 {
 	struct p9_req_t *p9_rx_req;
 	struct p9_fcall	rc;
@@ -202,7 +210,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		 "mux %p pkt: size: %d bytes tag: %d\n",
 		 usb9pfs, rc.size, rc.tag);
 
-	p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
+	p9_rx_req = p9_tag_lookup(client, rc.tag);
 	if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
 		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
 		return NULL;
@@ -212,7 +220,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		p9_debug(P9_DEBUG_ERROR,
 			 "requested packet size too big: %d for tag %d with capacity %zd\n",
 			 rc.size, rc.tag, p9_rx_req->rc.capacity);
-		p9_req_put(usb9pfs->client, p9_rx_req);
+		p9_req_put(client, p9_rx_req);
 		return NULL;
 	}
 
@@ -220,7 +228,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		p9_debug(P9_DEBUG_ERROR,
 			 "No recv fcall for tag %d (req %p), disconnecting!\n",
 			 rc.tag, p9_rx_req);
-		p9_req_put(usb9pfs->client, p9_rx_req);
+		p9_req_put(client, p9_rx_req);
 		return NULL;
 	}
 
@@ -231,8 +239,10 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_usb9pfs *usb9pfs = ep->driver_data;
 	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	struct p9_client *client;
 	struct p9_req_t *p9_rx_req;
 	unsigned int req_size = req->actual;
+	unsigned long flags;
 	int status = REQ_STATUS_RCVD;
 
 	if (req->status) {
@@ -241,9 +251,16 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
-	p9_rx_req = usb9pfs_rx_header(usb9pfs, req->buf);
-	if (!p9_rx_req)
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+	client = usb9pfs->client;
+	if (!client) {
+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
 		return;
+	}
+
+	p9_rx_req = usb9pfs_rx_header(usb9pfs, client, req->buf);
+	if (!p9_rx_req)
+		goto out_unlock;
 
 	if (req_size > p9_rx_req->rc.capacity) {
 		dev_err(&cdev->gadget->dev,
@@ -257,8 +274,11 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 
 	p9_rx_req->rc.size = req_size;
 
-	p9_client_cb(usb9pfs->client, p9_rx_req, status);
-	p9_req_put(usb9pfs->client, p9_rx_req);
+	p9_client_cb(client, p9_rx_req, status);
+	p9_req_put(client, p9_rx_req);
+
+out_unlock:
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
 	complete(&usb9pfs->received);
 }
@@ -412,7 +432,9 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 		client->status = Disconnected;
 	else
 		client->status = Connected;
+	spin_lock_irq(&usb9pfs->lock);
 	usb9pfs->client = client;
+	spin_unlock_irq(&usb9pfs->lock);
 
 	client->trans_mod->maxsize = usb9pfs->buflen;
 
@@ -423,12 +445,19 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 
 static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
 {
+	struct p9_client *client;
 	struct p9_req_t *req;
+	unsigned long flags;
 
-	guard(spinlock_irqsave)(&usb9pfs->lock);
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+	client = usb9pfs->client;
+	usb9pfs->client = NULL;
+	req = usb9pfs->in_req ? usb9pfs->in_req->context : NULL;
+	if (usb9pfs->in_req)
+		usb9pfs->in_req->context = NULL;
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
-	req = usb9pfs->in_req->context;
-	if (!req)
+	if (!req || !client)
 		return;
 
 	usb9pfs->in_req->context = NULL;
@@ -439,7 +468,7 @@ static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
 	if (!req->t_err)
 		req->t_err = -ECONNRESET;
 
-	p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
+	p9_client_cb(client, req, REQ_STATUS_ERROR);
 	usb9pfs->in_req->context = NULL;
 }
 

-- 
2.53.0

