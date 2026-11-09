Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221594;
	b=u1exj0Btz1RNwBAjrNZPtpCO2pLeQgUjPVaE3Nryxbwg7EXGkEhi+o2N4wYvcVLFxaWm
	 JU/ttuaZp3TQbxkEeaj3wTUv26YyWP8XwTC/CVtJDX6TAO9i64eftQuitVSV35ObfXD7+
	 d2zJRyxmhXSzLTxC9KqZQcmnKXu1V+HfpgdUSQkxLoklqF8yU+9D3r7Drm3CGQbN0+J9b
	 V0qOW83iQQ0woKoN2P/YRP095scj+lwQzdNe/k5S1E4FIpRYjGSIA+kMh5pQYSdz9td3h
	 ya78E7ChKazRMpuaMO7PcOLphBKUQnvtUTBhVL8ydyQQtrBmFjAwPn5KRjWYWvf1CEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DvUQ95Qmafx/GUKCgwM1Wq8Fj7AkLqXVLQmPGo9tiOM=;
	b=5kO60A6fWN09vk9r2ujqT4BkQ0R9aslEUbm7jGuxrCz3JCjwVZjsZaM39U7WRUXzFOMu
	 RTcYFuCtiQS14Kx+Zj7+0R/Daswd8LFFLQoA1wHbob1Taoqitx9iBxk0ubzOnLuScD5OI
	 pel/pLi92XBO9ey+9CEv4MUmmoC1Xa5ZpAJNgoICUyqKYc3O0+ZVotGETa10EnLV+c/QN
	 S8xHSo71gS85xipv/QXucFCYZrPsAbkNOSbBq7N2HSFlkUJo/9bj9h5Y8n80iMb3C44zI
	 yF5KnDrTACc8jxvohMsQTq7DfmNmIraLCQkuWWSKuHGrjPJuWEHJBljC1Kwy+G6aZ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=JbOG2UYu;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46B606A330
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A46B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=JbOG2UYu
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b1ce85287aso654917c88.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221593; x=1794826393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DvUQ95Qmafx/GUKCgwM1Wq8Fj7AkLqXVLQmPGo9tiOM=;
        b=JbOG2UYu1aPGgNyb7/u4cOaEroeWMgwhVhqZQJKSvCrjB5akVUv1Y3+owXoNoX6qas
         Mx8TlG5OoeLOGPgXCli/gibKdC6truSuK87hssu8eqIVhr8kwJnqjxtStphxQKpZXcQn
         HK7TsEd2gGEJ5bOLVq2FS0/mSZSCqwulxKGSuKQUAgMw9fiGEnuq2aaDOofubA0VyD23
         vcAcH5904tJKM9acyAn/af/IxmDvcKeWkalXMjbUF589IFrpNxZ8sJUDHFG53eZCb671
         e8jCjfc8IYKqnY8AYUUEcBeQ1gUlIJXw9y8LjgmmFC6MJZJLSCS1zJCamLDtIUXKBwbV
         qbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221593; x=1794826393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DvUQ95Qmafx/GUKCgwM1Wq8Fj7AkLqXVLQmPGo9tiOM=;
        b=iPydIV1nf06YynnrFIsqLEj2ab4Ftte466cujW1y50Vjr9VsYZ1BTJ0UZI5rKtoaSb
         0oqBUceGTVoaCZHAu5x479wFpWxMezThpOl7Xo5DRGe+nH7rESl8dKfBoR7cZjGQJtgv
         acxY4camQupNVOaxuocX23Utt5cq8Zvh5sKSj61TSs/+0Dz4qZSo/NZJDiLXLJaGx8/e
         Pk69DBGlaEFF0r7ol4fOXgBYZjkw/Ct6/giTNE+6C0IelU/Z61hRUIGtpdUbhOdZPseI
         K7MDxeleDa73nVUIS6ZutDdtSwdRijNNGXVbRQKfSjXabQIQVN/z9B9qvtq/bsrSG51h
         KJ6w==
X-Forwarded-Encrypted: i=1; AL+hErG0am0B1LXUqSjp8Lw5ZAr1HfWHmIxQDk5r2dwdwM4m2I9bUYl1ATaCQFEQ4dgjuB6X3bLmsyo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BQcIDOAWrliVHHTx5AX+VOdNj39/Pm4gYxGohb1kg4F4SEn5W
	MHyuT8P+n3pEbkEMIvoF465uR8Bp/oJv85jHvSg3DWHv4aCJd0ZA1NGXzY1J6wum7A==
X-Gm-Gg: AYBFou13WIwDWme0t1ICvFNt2LX9r2Ly44MY+E8zvDRTXfSZIm8U5rs7KcoMEPiFdYl
	1262aZBmtb2+xyAdMN66WTmbauZZWr+cFYRHpeXerCeqh7NhQv14YU14NHmQsvBGOwwVrU+MdJw
	n6d/HdO7/2Sy9tSmzljdemw8z33ujvHvDG938/06mgMXyHoLC0QndNa3b5MJNw1yvdEN0rl0DiD
	k2M9W7+K6H+iT2SRqmpc4muf10axM2XBK2OtRPNKTkl0GBrsyIim5N8GwDa76pP2US5ofE9UfLL
	U13bQQNsCEBvurh21+BeTnSYRK9OIwX/OI1palYn5Z5u0aleSoRMoisob2d7x02AM67zJ6k1G4b
	bx2V4o7TfxhCmp14FJVnNkVWnbP9Nl6JTlxRS/yEPDLBx0hjLKK7DTS8M0BRsc/rqbFOTSNeWM1
	zX+qB63/ycvO1E8f1VAmR6psgsV/tCYLoii35km2PtG+7nzfRN8Z50mk0c3kiI65uqSTiu2Z4RX
	SZyRPmcDf6+1NyP/lfxzzMKndN8PMtvLB/JzpOvqVKtTU8tJcjlh8LBZ0VFFPBuAuRM6y1SaS9E
	HAkn8w5mJKqDbimSJhKPxvgHLlfZm5kWd1NWMKo=
X-Received: by 2002:a05:7022:ec02:b0:16a:f5cd:365 with SMTP id a92af1059eb24-1b39fe307d9mr6849877c88.5.1794221592339;
        Mon, 09 Nov 2026 02:53:12 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:12 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] 9p/virtio: keep zero-copy buffers until the device returns them
Date: Mon,  9 Nov 2026 19:52:51 +0900
Message-ID: <20261109105251.2545764-6-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
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

When a fatal signal ends the wait of p9_virtio_zc_request() while the
device still holds the request, the payload pages are released, and
p9_client_zc_rpc() returns to its caller once the RFLUSH arrives. Since
the caller may free the buffers, a misbehaving device can answer the
request after the RFLUSH and write the reply into freed memory. With the
payload bounced through swiotlb, the guest itself copies the reply into
the freed memory when req_done() unmaps the returned buffers:

  BUG: KASAN: use-after-free in swiotlb_bounce+0x236/0x270
  Write of size 4080 at addr ffff888004800010 by task swapper/1/0
  Call Trace:
   swiotlb_bounce+0x236/0x270
   req_done+0xb2/0x280

Fix this by releasing the pages in req_done() once the device returns
the request, when the wait ends without a reply. req_done() can find the
pages only through the request, so the page arrays, their page counts
and need_drop are gathered into struct p9_zc_pages allocated for each
zero-copy request. p9_client_zc_rpc() now waits until the device returns
the request, since the caller may reuse or free the buffers after
p9_client_zc_rpc() returns.

This patch is assisted by Claude Opus 5.5.

Fixes: abfa034e4b8e ("fs/9p: Update zero-copy implementation in 9p")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 include/net/9p/client.h |   6 +++
 net/9p/client.c         |   3 ++
 net/9p/trans_virtio.c   | 109 +++++++++++++++++++++++++++++-----------
 3 files changed, 90 insertions(+), 28 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index e4e5cb102fb18..8f9074e69c54a 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -71,6 +71,8 @@ enum p9_req_status_t {
 	REQ_STATUS_ERROR,
 };
 
+struct p9_zc_pages;
+
 /**
  * struct p9_req_t - request slots
  * @status: status of this request slot
@@ -79,6 +81,9 @@ enum p9_req_status_t {
  * @tc: the request fcall structure
  * @rc: the response fcall structure
  * @req_list: link for higher level objects to chain requests
+ * @zc_pages: the zero-copy payload pages, set by the transport while the
+ *            device may access them and cleared with a wakeup on @wq when
+ *            the device returns them
  */
 struct p9_req_t {
 	int status;
@@ -88,6 +93,7 @@ struct p9_req_t {
 	struct p9_fcall tc;
 	struct p9_fcall rc;
 	struct list_head req_list;
+	struct p9_zc_pages *zc_pages;
 };
 
 /**
diff --git a/net/9p/client.c b/net/9p/client.c
index 15bb939087165..34be0d2652d4e 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -188,6 +188,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint t_size, uint r_size,
 	refcount_set(&req->refcount, 0);
 	init_waitqueue_head(&req->wq);
 	INIT_LIST_HEAD(&req->req_list);
+	req->zc_pages = NULL;
 
 	idr_preload(GFP_NOFS);
 	spin_lock_irq(&c->lock);
@@ -707,6 +708,8 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		 * into rc only while it waits.
 		 */
 	}
+	/* The caller may reuse the payload once the transport releases it */
+	wait_event_idle(req->wq, !smp_load_acquire(&req->zc_pages));
 recalc_sigpending:
 	if (sigpending) {
 		spin_lock_irqsave(&current->sighand->siglock, flags);
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 68c3457bec401..d6914e5b36972 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -42,6 +42,43 @@ static DEFINE_MUTEX(virtio_9p_lock);
 static DECLARE_WAIT_QUEUE_HEAD(vp_wq);
 static atomic_t vp_pinned = ATOMIC_INIT(0);
 
+/**
+ * struct p9_zc_pages - the pages mapped for the device by a zero-copy request
+ * @in_pages: the pages of the reply payload
+ * @out_pages: the pages of the request payload
+ * @in_nr_pages: the number of reply pages
+ * @out_nr_pages: the number of request pages
+ * @need_drop: whether p9_zc_release() drops a reference to each page
+ * @held: whether req_done() releases this structure
+ */
+struct p9_zc_pages {
+	struct page **in_pages;
+	struct page **out_pages;
+	int in_nr_pages;
+	int out_nr_pages;
+	int need_drop;
+	bool held;
+};
+
+static void p9_zc_release(struct p9_zc_pages *zc)
+{
+	if (zc->need_drop) {
+		if (zc->in_pages) {
+			p9_release_pages(zc->in_pages, zc->in_nr_pages);
+			atomic_sub(zc->in_nr_pages, &vp_pinned);
+		}
+		if (zc->out_pages) {
+			p9_release_pages(zc->out_pages, zc->out_nr_pages);
+			atomic_sub(zc->out_nr_pages, &vp_pinned);
+		}
+		/* wakeup anybody waiting for slots to pin pages */
+		wake_up(&vp_wq);
+	}
+	kvfree(zc->in_pages);
+	kvfree(zc->out_pages);
+	kfree(zc);
+}
+
 /**
  * struct virtio_chan - per-instance transport information
  * @inuse: whether the channel is in use
@@ -142,6 +179,15 @@ static void req_done(struct virtqueue *vq)
 			need_wakeup = true;
 		}
 
+		/* The device has returned the buffers of a zero-copy request */
+		if (req->zc_pages) {
+			if (req->zc_pages->held)
+				p9_zc_release(req->zc_pages);
+			/* pairs with smp_load_acquire() in p9_client_zc_rpc() */
+			smp_store_release(&req->zc_pages, NULL);
+			wake_up(&req->wq);
+		}
+
 		if (len) {
 			req->rc.size = len;
 			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
@@ -419,25 +465,30 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 {
 	int in, out, err, out_sgs, in_sgs;
 	unsigned long flags;
-	int in_nr_pages = 0, out_nr_pages = 0;
-	struct page **in_pages = NULL, **out_pages = NULL;
+	struct p9_zc_pages *zc;
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
 	size_t offs = 0;
-	int need_drop = 0;
 	int kicked = 0;
+	bool held;
 
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
 
+	zc = kzalloc_obj(*zc, GFP_NOFS);
+	if (!zc) {
+		err = -ENOMEM;
+		goto out;
+	}
+
 	if (uodata) {
 		__le32 sz;
-		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
-					    outlen, &offs, &need_drop);
+		int n = p9_get_mapped_pages(chan, &zc->out_pages, uodata,
+					    outlen, &offs, &zc->need_drop);
 		if (n < 0) {
 			err = n;
 			goto err_out;
 		}
-		out_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
+		zc->out_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
 		if (n != outlen) {
 			__le32 v = cpu_to_le32(n);
 			memcpy(&req->tc.sdata[req->tc.size - 4], &v, 4);
@@ -450,13 +501,13 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		sz = cpu_to_le32(req->tc.size + outlen);
 		memcpy(&req->tc.sdata[0], &sz, sizeof(sz));
 	} else if (uidata) {
-		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
-					    inlen, &offs, &need_drop);
+		int n = p9_get_mapped_pages(chan, &zc->in_pages, uidata,
+					    inlen, &offs, &zc->need_drop);
 		if (n < 0) {
 			err = n;
 			goto err_out;
 		}
-		in_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
+		zc->in_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
 		if (n != inlen) {
 			__le32 v = cpu_to_le32(n);
 			memcpy(&req->tc.sdata[req->tc.size - 4], &v, 4);
@@ -476,10 +527,10 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	if (out)
 		sgs[out_sgs++] = chan->sg;
 
-	if (out_pages) {
+	if (zc->out_pages) {
 		sgs[out_sgs++] = chan->sg + out;
 		out += pack_sg_list_p(chan->sg, out, VIRTQUEUE_NUM,
-				      out_pages, out_nr_pages, offs, outlen);
+				      zc->out_pages, zc->out_nr_pages, offs, outlen);
 	}
 
 	/*
@@ -494,10 +545,10 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	if (in)
 		sgs[out_sgs + in_sgs++] = chan->sg + out;
 
-	if (in_pages) {
+	if (zc->in_pages) {
 		sgs[out_sgs + in_sgs++] = chan->sg + out + in;
 		pack_sg_list_p(chan->sg, out + in, VIRTQUEUE_NUM,
-			       in_pages, in_nr_pages, offs, inlen);
+			       zc->in_pages, zc->in_nr_pages, offs, inlen);
 	}
 
 	BUG_ON(out_sgs + in_sgs > ARRAY_SIZE(sgs));
@@ -522,6 +573,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 			goto err_out;
 		}
 	}
+	req->zc_pages = zc;
 	virtqueue_kick(chan->vq);
 	spin_unlock_irqrestore(&chan->lock, flags);
 	kicked = 1;
@@ -539,27 +591,28 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 
 		// RERROR needs reply (== error string) in static data
 		if (unlikely(req->rc.sdata[4] == P9_RERROR))
-			handle_rerror(req, in_hdr_len, offs, in_pages);
+			handle_rerror(req, in_hdr_len, offs, zc->in_pages);
+	} else {
+		/*
+		 * A fatal signal ended the wait, and the device may still hold
+		 * the request, so let req_done() release the pages unless the
+		 * device has already returned the request.
+		 */
+		spin_lock_irqsave(&chan->lock, flags);
+		held = req->zc_pages;
+		if (held)
+			zc->held = true;
+		spin_unlock_irqrestore(&chan->lock, flags);
+		if (held)
+			return err;
 	}
 
 	/*
 	 * Non kernel buffers are pinned, unpin them
 	 */
 err_out:
-	if (need_drop) {
-		if (in_pages) {
-			p9_release_pages(in_pages, in_nr_pages);
-			atomic_sub(in_nr_pages, &vp_pinned);
-		}
-		if (out_pages) {
-			p9_release_pages(out_pages, out_nr_pages);
-			atomic_sub(out_nr_pages, &vp_pinned);
-		}
-		/* wakeup anybody waiting for slots to pin pages */
-		wake_up(&vp_wq);
-	}
-	kvfree(in_pages);
-	kvfree(out_pages);
+	p9_zc_release(zc);
+out:
 	if (!kicked) {
 		/* reply won't come */
 		p9_req_put(client, req);
-- 
2.56.0

