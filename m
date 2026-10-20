Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504441;
	b=cTPyJ9qpAp0zTvK/Ko499h/sCHOmIfsEpTUk4l2Wyn3qCC5bdikr6aoIqIiN3vmWzwGv
	 s8dbwbfkNUUA6BHyVPOm+88K36DH+lcJlB7lJUCEpvYk9XQw2m5fh+ypfYZq0xixSJ5Xn
	 pwe/tuuXBh+/TAUGxq35PgSD2Ot0EqLpAU53PkIHfhS04KxpyDI8J/XTAW7vzRWHies0j
	 T2Ti3H5bH3bi1VCyn3Gn6umOHvl6+YfH7ogGH8VrjhKy9kiihv6KVaisb8Cz9F6OVYJEq
	 TfoJrhYTnBnwKQG/wrEWvPG7pEvdpY8BpKpYanpttY/fQwzCLEKwx2QXNYefMJurE0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eR7IAX7DYO3kX2lnFG0GVUYwCYi3YyU/eHHmvSkslxA=;
	b=qRgE66e5LftYuOIikfGKThxjUF3u/eJ5IMHNmdZSMnydZyc4quDBEwoNWYCGXxI79lqO
	 HtGRYboqwRkc4ZlovSZvFsi7OHc0Mkc2Rp2kKkNQf1NOIJbddUoi2/UMUfvxEwFQSy375
	 1zAEaaY+jZ3HDFPLMj41oBoV5jdkRiV0AcuiD+2l1I0t6HDoKRfTPpxsIR5HxGltaS7+M
	 fId5aiL4tkIdUW3TuL4/DaOyD8XpofUhq4U4kti3xEWkUA/MIrJf30LPJ59tGWsIM4goa
	 sYp1L2eGag2HRg5Q4gi5dFhVJIp3Y4Ew+sPLmpc4a9NeujdF82NFaxQw5YEE4wz3qQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nWbANXlW;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52551606A32E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52551606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nWbANXlW
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ad6499e88fso103430a91.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504441; x=1793109241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eR7IAX7DYO3kX2lnFG0GVUYwCYi3YyU/eHHmvSkslxA=;
        b=nWbANXlWQV6gBS3I36OZtuQ3J7ShKPu0A3xfLkoy1HQ7XVHK4ie0qF3nnGlRmoNfmo
         f3tah0nHkKMQ9nV5vXrqWNqnuPpYW0tQy9G3qXgPtSGKI6YRss8KscXw5p37heaWVf+w
         Fc1fLzttSoGGPm+hm98N5DJWUt+tSVoCQDtt2gfZ/zVFdRQLBdbUtymthfVJZbf+cDYH
         RFHjXfKekZpEngZfHMKLGjRhIhCQsDLUyrtRLht21dkuH2j62ZOuw374o2hK0IoZ8GkO
         HhVnSRWjwd/yFc8ytzv5aJXXy4n0JgnDIMTcSgFL6RFYo4226vBsijX4J0qSjVPfC+Qc
         Q2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504441; x=1793109241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eR7IAX7DYO3kX2lnFG0GVUYwCYi3YyU/eHHmvSkslxA=;
        b=JeaAFY17AuqLFQHncRXBkswPNbiCnWM7ZAqflacQU8IR4bjvNwif+asV2U9S9pkzTm
         rQwmmAAvDdqMLKX9kEJT3kwHjx0wzAKowENEHWwwiMEq06DHbo699qwFjD/Oc7UY31eO
         rzL3Pc71FB/0QpUtTcVaP/6dXv9t7+lIm8Nk+34fHpq21VAb3QMM2mH8hpmveIDvGzfe
         6pI3cs8KQiXfyH8UmUQzC2B3OqKSz1bNjBY3qH2aCpQsh8eYCNtXGPWKB0VxI3Rhc5Dw
         G9FqX+5LAkizJt+uFM50sAabgX4rbJaekHFCxgbT4KT3PkJ+9PN0VF5TzHsKGeDCtPoB
         BdKw==
X-Forwarded-Encrypted: i=1; AKwUvBzHeRHBP5Zkda8XK1PDuYqXJgmEYHJDogu3QpAIdPD5A4UrojJWE4RxLNBQURHdX+vSIfE0Guw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJI4fyeB8dM0YJLZML0AcFZT9Q1Y1YPdX34GunIbeUivyhN2QZP
	wUVTZbOQGX7IU1vTTsdZDc9GrVvRZgC5/q4vGUstwu4Oq58adPYHswIJ
X-Gm-Gg: AYBFou0Yj180RiokbVQCbKDmqbKscYZidLI4ewqw8ZGzZ4pQMADIDidZ5N3mw7ZeVKG
	deSTKha8pOpAAZfyjzRSqF0VXpz+JDQwriqBz2zhAGaaoXhga0DZ/81/I+8mRRoJl/nIY8Z6tCg
	Q64fDHMCVRMVlLnWLfecmW2lcFHDHg2PMSqMolZkCybjprzVX0PbA1vOzWcgPJPPRPDPW5eg4bd
	FyQb7vTy5BQhyAD2wU6hbPStXIYBm5TqyOnDe89brKSWkDYHiw6rHypV5Tk/GCqXNVFvlmsLZ7N
	+xlmlAj9FmgiZ1AUFD+0LILJy5ADG0TniDrDrKtig844+/DxFqxfySB+hOqO0hZbsQkvr2trfrF
	fqINesGJ1xh5hPm7G8rEwzXOOfIM4Rs3ZmkJ7Snn9iNoLj9E7Hf7bk0/e0Xngcw1nA4Gj8qp/s9
	YwcbAzFarhyq4wXIjsADcsy9YXdV9EO6vvx3aKBvBKcdeNSWuSc3hH/mXMkyds0wreRzAhSxBrH
	maELPdKmhvfm+PU21A2UJH8t3zPnpztVzSEHcQOhLMZ0pJa3b6eR9fXunC3PgR1T6+8ThnXkJ3J
X-Received: by 2002:a17:90b:1f8f:b0:3ac:a11a:7c88 with SMTP id 98e67ed59e1d1-3aceec4ba18mr14269919a91.3.1792504440611;
        Tue, 20 Oct 2026 06:54:00 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([188.253.120.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d6df894sm3604548a91.10.2026.10.20.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:54:00 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH] fuse: virtio-fs: don't process completions of aborted requests
Date: Tue, 20 Oct 2026 21:53:50 +0800
Message-ID: <20261020135350.7751-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
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

fuse_chan_abort() ends every request on the processing lists with
-ECONNABORTED, but virtio-fs keeps the request itself as the
used-buffer token of the virtqueue.  When the host stalls a request
until the request timeout aborts the connection and then completes the
descriptor, virtio_fs_requests_done_work() gets the already freed
request from virtqueue_get_buf() and moves its list node
(list_move_tail()) and reads its arguments (copy_args_from_argbuf()),
a use-after-free in the guest kernel.

Let the transport know about the abort and skip completions of requests
that the abort has already ended.  This is safe because any request
still represented by a virtqueue token when the abort starts must have
been queued before virtio_fs_abort() set aborted:
virtio_fs_enqueue_req() checks connected, adds the request to the
virtqueue, and puts it on the processing list while holding fsvq->lock.
virtio_fs_abort() takes the same lock before setting connected = false
and aborted = true, and fuse_chan_abort() only splices and ends the
processing lists after the transport callback returned.  A racing
enqueue therefore either completes before the abort and is subsequently
ended by it, or observes connected == false and returns -ENOTCONN
without creating a token.

in_flight is transport-owned accounting: it is incremented when a
token is queued and must still be dropped when the virtqueue completion
is consumed, even though the FUSE request itself has already been ended
by the abort.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 fs/fuse/dev.c        |  4 ++++
 fs/fuse/fuse_dev_i.h |  5 +++++
 fs/fuse/virtio_fs.c  | 26 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4fec31fc0b84..90b30c5034c4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2178,6 +2178,10 @@ void fuse_chan_abort(struct fuse_chan *fch, bool abort_with_err)
 		spin_unlock(&fch->bg_lock);
 
 		fuse_chan_set_initialized(fch, NULL);
+
+		if (fiq->ops->abort)
+			fiq->ops->abort(fiq);
+
 		list_for_each_entry(fud, &fch->devices, entry) {
 			struct fuse_pqueue *fpq = &fud->pq;
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 4b412a76225f..47697adf0eb6 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -148,6 +148,11 @@ struct fuse_iqueue_ops {
 	 */
 	void (*send_req)(struct fuse_iqueue *fiq, struct fuse_req *req);
 
+	/**
+	 * @abort: Abort transport-specific state
+	 */
+	void (*abort)(struct fuse_iqueue *fiq);
+
 	/**
 	 * @release: Clean up when fuse_iqueue is destroyed
 	 */
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f15e516ebcb5..2db5faf5d865 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -55,6 +55,7 @@ struct virtio_fs_vq {
 	struct work_struct dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
+	bool aborted;
 	long in_flight;
 	struct completion in_flight_zero; /* No inflight requests */
 	struct kobject *kobj;
@@ -842,6 +843,15 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		virtqueue_disable_cb(vq);
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
+			if (fsvq->aborted) {
+				/*
+				 * fuse_chan_abort() ended every request this
+				 * queue still owns; the token may already be
+				 * freed, do not touch it.
+				 */
+				dec_in_flight_req(fsvq);
+				continue;
+			}
 			if (!virtio_fs_verify_response(req, len)) {
 				req->out.h.error = -EIO;
 				req->out.h.len = sizeof(struct fuse_out_header);
@@ -1541,10 +1551,26 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	}
 }
 
+static void virtio_fs_abort(struct fuse_iqueue *fiq)
+{
+	struct virtio_fs *fs = fiq->priv;
+	int i;
+
+	for (i = 0; i < fs->nvqs; i++) {
+		struct virtio_fs_vq *fsvq = &fs->vqs[i];
+
+		spin_lock(&fsvq->lock);
+		fsvq->connected = false;
+		fsvq->aborted = true;
+		spin_unlock(&fsvq->lock);
+	}
+}
+
 static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 	.send_forget	= virtio_fs_send_forget,
 	.send_interrupt	= virtio_fs_send_interrupt,
 	.send_req	= virtio_fs_send_req,
+	.abort		= virtio_fs_abort,
 	.release	= virtio_fs_fiq_release,
 };
 

base-commit: ac86e1112a6a
-- 
2.51.0

