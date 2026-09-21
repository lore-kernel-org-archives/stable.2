Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F35221F7;
	Mon, 21 Sep 2026 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029585; cv=none; b=DkiDx1lTPS7gKGjettt8HRTELWYCCWESucKnjqnm+48n6IgZglgtkJRRDyjmwvrTLhTjcmttcFTILB8BJ//GltPoEHQC+mqZ4vGktIDGGVV5OCIaCG/toiaboUQQ1PGfN06j4DKHzW/a4vsltzU0gvFmU3RcNvcWQigw082BKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029585; c=relaxed/simple;
	bh=mcsQBqglQe5LgMXPMa8svJPHiK1gzWkDxAl4HIIOb1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=arsizn1ITMw54L0G05j/z9VVRzuy/pgnp7PlPR6MXjMrEd0zYoFtA8y1l6LxoHHtHAHNqhGXXq2pPA5WVaALIcYqGd1Dgcn8tFE1gKaEsTE3w9bAL8sIRhrzdF+Ukn9+loQX/tRW+HgOvOPDkX1CGxiYgcoxJVbt16KkPY/fl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv/sdtK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv/sdtK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8EA1F00899;
	Mon, 21 Sep 2026 22:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029584;
	bh=5+Fyuc49s+vjU+93EZfc3k6Jk0Or86f0Xu+uLTgkMxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kv/sdtK1xOZbVDkDxR65wWiThmAez49E5+3MayGZd+SKeTAgMvIVdSlGFziP4iabZ
	 eX3Jlz+nzAm8iGjAO/sfXS9exVGxqt+QsGnx/qO1mHCUMaJXRxqvDqE65QoRIVDz6q
	 GqITDQcLLDqtX90qmx/34CBMf3hDw4zUDOvkhfkypG+gERSx/Oi+1SUqS+75QErbQO
	 h20GB34CR6Ay0hZMVGsfSbBmlhoVbbcKFz0PHwVXSPv5pmpvok6kM7XMT2P5bufx9T
	 7rL/OrGgXo0DZ0pTk7kFgN2M3INk+R8y8pSOrMfj97/mlOYxcIZ7dbGidAQC//h2kL
	 DrWEvXVTK0OVQ==
From: Michael Grzeschik <mgr@kernel.org>
Date: Tue, 22 Sep 2026 00:25:57 +0200
Subject: [PATCH 4/7] net/9p/usbg: call disable_usb9pfs() from
 usb9pfs_disable()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-usb9pfsfixes-v1-4-9d8dcc52904c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=mgr@kernel.org;
 h=from:subject:message-id; bh=mcsQBqglQe5LgMXPMa8svJPHiK1gzWkDxAl4HIIOb1M=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqsa8E1skDKacbduM2XkWqJ0dDcTWUAdVlD7JTx
 /MFxPxykJ+JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCarGvBAAKCRC/aVhE+XH0
 q2u4EACtNjIqfLQ3qTpKZax1FJSbF+Wrb6JndQ+Vzx535Kj0F82mh2lS7Xsgtpt6vrxmjjR6u/Y
 vnxS6GvPO2FwxQEbCXcG+OnPmqlMfHBW8Ap7NMDVp7XuhlinMBrWAbwOYRF45PsmOy6pUu4Se8Z
 vLJ5ZfLy8u1mmBcHr6oI3I/P8ylBKw/SXtNpgWFK9TSRSZvhg12FiBeEjC0BMc1TlGzXoiR5lUM
 jkXcMsWM+kY6WeJMVX0SchPbRmQC5SQDQXHBo0+saD4YQyzi6KOU+/UkoPU3YzbEwypmooTsDIg
 vbcmNm9DA6oKsQ6PAU0hBSa64usooHoHUvwHo2esNr7bzxBAIla8MD0JMT91+PxObAX+xTjzcAz
 5FH25TvDmMayy6oRT6hV6Vew0pBMDgQMeECHuVSirFhZY9X7CaxYJzOS5GV3JYtNO84TV8ObMZJ
 rlUsOHv+cw4fssZCXnaVBUbp4ndk6KH4kCeW09s6p2p7YnV/hxzPX+X4sDMLa6yoD7OG7WgHeMZ
 ikYdCO+KoY3wDK1j85LJ3EWr5zezXCyiXFEeb7C6/ZkZTPY/SBYAJK573qvXv68xoymjjdxhdJe
 ilb3amJPd4HxkCF3LSVmHcS5QMwFq1k+Y64497+hPhCjizooltuqNcuUheF0h5gkhdY1EXO6JeE
 oCyV38Cdpl5+i4A==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64

usb9pfs_disable() is the usb_function ->disable callback, invoked by
the composite gadget core whenever the host resets or unconfigures
the gadget. The gadget function API requires this callback to disable
its endpoints; every other in-tree function driver does so from its
->disable hook.

usb9pfs_disable() never called disable_usb9pfs(), so the IN/OUT
endpoints and their usb_request objects were left active and
allocated across a host-driven disable. When the host later
reconfigures the device, enable_usb9pfs() calls alloc_requests() again
and unconditionally overwrites usb9pfs->in_req/out_req, permanently
leaking the previous allocations, while the endpoints themselves are
left enabled underneath the function's own idea of being disabled.

Call disable_usb9pfs() before reinit_completion(&usb9pfs->send),
mirroring the same sequence already used in p9_usbg_close(). Placing
it before the reinit_completion() also ensures usb_ep_disable() has
synchronously flushed any requests still queued in hardware before the
completion is reset, closing the same race that motivated resetting
the completion here in the first place.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Assisted-by: Claude:claude-opus-4.8
Cc: stable@vger.kernel.org
Signed-off-by: Michael Grzeschik <mgr@kernel.org>
---
 net/9p/trans_usbg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index e3af8e1002d7..af113746d2fc 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -765,6 +765,10 @@ static void usb9pfs_disable(struct usb_function *f)
 		usb9pfs->client->status = Disconnected;
 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 	usb9pfs_clear_tx(usb9pfs);
+
+	if (usb9pfs->in_ep->enabled)
+		disable_usb9pfs(usb9pfs);
+
 	reinit_completion(&usb9pfs->send);
 }
 

-- 
2.53.0

