Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4763C871D;
	Mon, 21 Sep 2026 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029590; cv=none; b=FNKG31Vtcast4DVuFiEUFerLamFJClK/+0IPtWAmidq+UNBMdIcjhIJnYIZiUpxyvoJfC/JE24zideap2O2uNEaKYViYCo1rZDalXZQaKaob0BsS9INO7W1iab+WtHkpbef18ioLcbzS+3aLdp4vzHcf8qL8fIui9Br6xnxfldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029590; c=relaxed/simple;
	bh=OKulNGQNsdM6XuPCN4GDKW/MJrI43JdXh3oXwy/0qlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D15UomghfIPhL4bFFbV5msVjra9UVYqWHgy/60hsdArcleAgVhH9mBWchoGPOeOTgugqMsKsu98kSmIc7A/YfUwa441vK6mKllVsRUKTd+bJvCJG1AcCmlbuP08BPz3dfCIddVwfzBZ1LTA26jPUlD1Jz10RlsxMN6weY4WDilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8p0fGNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8p0fGNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6DF1F00893;
	Mon, 21 Sep 2026 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029589;
	bh=UI47TIVtLzbGIeud91lzb20fyAckColjg1IGadw2GWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S8p0fGNllgPGkr/lH4wI5/4w8B/D3Gu2IvWSW97Ox5sfTEedVD5ALQ3R+IP6ecsF7
	 BvWzU5yCrNbxH6uA4rIr6JQ6OPVfL8aKwCGfaFX6+33bAftmeoIaa+d8m4zMRYH7/U
	 wNS59JKK4jVZoAqSVI1Bm0Y5Ay054sYm0q33YkLCd8ZxLAaM9uNtQUoTvf4yObDQzo
	 ypKaNMCFRtBnzVJCsYebQwBLqe1xIlnomVEHx5FX+0ulOPbJtSEihPuNVQtmVY6t48
	 DWqbC8AmpXarLUf7zUOHHH60KKMYGiqOCdMifEXviXxDqgrl0yTBzAyg/OzSWIL9nH
	 IuK4h7crk4FdA==
From: Michael Grzeschik <mgr@kernel.org>
Date: Tue, 22 Sep 2026 00:25:59 +0200
Subject: [PATCH 6/7] net/9p/usbg: remove bogus context initialization in
 alloc_requests
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-usb9pfsfixes-v1-6-9d8dcc52904c@kernel.org>
References: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
In-Reply-To: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <mgr@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355; i=mgr@kernel.org;
 h=from:subject:message-id; bh=OKulNGQNsdM6XuPCN4GDKW/MJrI43JdXh3oXwy/0qlg=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqsa8EQBCQFOf8wPlyWWuIaje4iGl5+s/R9W6zk
 j7QyI5ytM2JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCarGvBAAKCRC/aVhE+XH0
 q66gD/9ynAweytCdzGfhMvdscDChL2YS8Wq0B8rt241+8wXkTYv0pnvMLlsNNtfNSDq0XL/1A9K
 YC3NKQfCYK09U/DPAnuwZ3HNTqvSkWAKiWPvE/jHoTpx/R+yw2Kn0veGFZq+dYY/OjKERTvQW5u
 TN1lJPo3Glra1p9lMFijE/475zM1NRzIeBNqLWL2WXmPmLS5T23j9bUoB23BbJHuB0GNOa+Nq+j
 DK2ssv9CAQ2BaoT6kuSQb61LkS4EzkTJ2q+VtqKTR3MYyTfgDQ5948rW9Sdc4CPFEo2dRShHrlv
 hEokLbkBkkNLD68q8r3unF71jee2L9K1kt9Smi7NmAQ+LVZdafdcsP6fKPD0O0ML0SBR1UHz0C5
 iBe1P0utqfTxxu+NK1ex/JPZvdMA3+i2wV6WXKUfUZq2eXvO/NXHnIC5Kn21mhs2wt/qIq/tAK7
 zIfOTjArzTSWfYwgdgtskURmIuKfpmYQRRrQYhzKC/9bAuDLQL+p88U/vk1mXZsS2vE04aRevx+
 Cva5kfdsTKKKuMVxD2Rjg7BtMxDr0aGdRD61U6GldJj3jgk0BTft5PJsvWdkaDqcH+egN0Sqpti
 KI9GYJ0gptScT1EcFwSdRmPM9CzICgtV95H73SqNlvFJQ1LB3N7UglJg0uA7ohAcUWIMW/1tcbC
 nuLFiztIiej0O8A==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64

alloc_requests() initializes usb9pfs->in_req->context to point at the
struct f_usb9pfs instance itself. usb9pfs_queue_tx() later overwrites
this with the real struct p9_req_t pointer before every transmit, and
usb9pfs_tx_complete() clears it back to NULL after each completion, so
in_req->context only ever holds a valid p9_req_t once a request has
actually been queued.

usb9pfs_clear_tx(), however, can run at any time (mount close, gadget
disable) independent of whether a request was ever queued. If it runs
before the first usb9pfs_transmit(), it reads the leftover sentinel
value, type-confuses the struct f_usb9pfs pointer as a struct
p9_req_t, and both writes through it (req->t_err = -ECONNRESET) and
hands it to p9_client_cb(), which manipulates req->wq and req->refcount
at bogus offsets inside f_usb9pfs. This reliably corrupts memory or
panics whenever the transport is torn down before any 9p request has
been transmitted, e.g. mounting and immediately unmounting, or a cable
disconnect racing the very first request.

usb9pfs->out_req->context is set the same way but is never read by
this transport (usb9pfs_rx_complete() identifies the instance via
ep->driver_data instead), so it serves no purpose either.

Both endpoints' ->driver_data are already set to usb9pfs in
enable_endpoint(), which is what the completion handlers actually use
to recover the f_usb9pfs instance. Just drop the leftover
->context assignments; usb_ep_alloc_request()/alloc_ep_req() already
return zeroed requests, so in_req->context correctly starts out NULL.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Michael Grzeschik <mgr@kernel.org>
---
 net/9p/trans_usbg.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 9bcad638d827..544690a5c717 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -314,10 +314,6 @@ static int alloc_requests(struct usb_composite_dev *cdev,
 	usb9pfs->in_req->complete = usb9pfs_tx_complete;
 	usb9pfs->out_req->complete = usb9pfs_rx_complete;
 
-	/* length will be set in complete routine */
-	usb9pfs->in_req->context = usb9pfs;
-	usb9pfs->out_req->context = usb9pfs;
-
 	return 0;
 
 fail_in:

-- 
2.53.0

