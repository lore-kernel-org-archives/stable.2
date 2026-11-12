Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.187.101.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520317;
	b=u78RXMtJ93oZoEkABE2A5axX/CsmIKQS45lTMnGRbfRGpIrXCNlD4kBnqAwTLlYDtTtp
	 d1zCSTQ+gh44AZb9Znf0mmiKun3nO0yhUO76gziHTPU2Bx1va3UxUaYvUrtLR6FkPv5xo
	 UkprSmAQ7WNgXOMTlZ7tLxxOVVGsyywhNrjjRtzH0TuR1Q4SoylnVk4kBqJYe37UiXEab
	 We7aDskjbFS9s3SWkuIf2++LR2lm20L/RyYOOYjNHpIez3rxGzGsovxdUzZfb0pu+cC5N
	 AAnutvSABkJbrOwjnchDtwHBcJHgUbgOhU2ymQfszECQIp7W7fY8ftp5UlgAi4L9jXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520317;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References;
	bh=4QYNhSNS3whlvOsW3WExAeH4aMLDsOrN44WezVVIlt0=;
	b=x+BhtO2w9dbMyGuCz1ymJSQevAWyNpJ+8j3ds8KSc4jsur0LqjpY8OXUo/R5kwm+FYv7
	 p7fjtLZHaemHM4sgmQRUxoxYpP8l9BUZIid878yIWPkh+z9U1a6v1iQ319cyD5y+IF5iO
	 uyJQlYLuhrJxA5glMmbaVjm5rwsJe0mjI8UU3O66yE5PQB08Xa7GnMqGq9mEKfXKDPdVL
	 MAOLm3bvZ+av/Axf+su1oeWGm2rhJk+5a1P21ZWbF3aOFG8C9v/HJ8CQXjeNK34yU9tkY
	 l20G6tnxNLSIS1zfNJhIadO9E5duwDTH4+IA7sQWtq/Cdog6YQF7ymc+DSl9M7RV/NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sven.de;
	spf=pass smtp.mailfrom=sven.de;
	dkim=pass header.d=sven.de header.i=@sven.de header.a=rsa-sha256 header.s=default header.b=gY50zXQr;
	arc=none smtp.remote-ip=37.187.101.158
Received: from mail.sven.de (mail.sven.de [37.187.101.158])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B0606A323;
	Thu, 12 Nov 2026 21:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C0B0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sven.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sven.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sven.de header.i=@sven.de header.a=rsa-sha256 header.s=default header.b=gY50zXQr
Received: by mail.sven.de (Postfix, from userid 1000)
	id CF30CC0173B; Thu, 12 Nov 2026 22:51:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sven.de; s=default;
	t=1794520306; bh=4QYNhSNS3whlvOsW3WExAeH4aMLDsOrN44WezVVIlt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gY50zXQrd8wAIwatcXUGAWVj8nbzEwd4EzLsKuRLC10Y2ytZxBLEOScjUbXKHwh8W
	 DRdVji2WtHDn4lsqge7EtRW3tsCeM/VaC3x3u6D+mS3G2er7ACh4lLz5b+ZlgRQtsh
	 SfIlxUYvySbLrsghDN25Lxk+S/H+7s5A0v8vvqKE=
From: Sven Neuhaus <sven-kernel@sven.de>
To: linux-usb@vger.kernel.org
Cc: westeri@kernel.org,
	andreas.noever@gmail.com,
	YehezkelShB@gmail.com,
	linux-kernel@vger.kernel.org,
	Sven Neuhaus <sven-kernel@sven.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] thunderbolt: Do not match XDomain responses to received packets
Date: Thu, 12 Nov 2026 22:51:42 +0100
Message-Id: <1794520303-5758-2-git-send-email-sven-kernel@sven.de>
In-Reply-To: <1794520303-5758-1-git-send-email-sven-kernel@sven.de>
References: <1794520303-5758-1-git-send-email-sven-kernel@sven.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

What happens is that __tb_xdomain_response() queues a request that has
no response buffer. tb_cfg_request() schedules its work right after
sending it, and the request stays on ctl->request_queue until that work
dequeues it.

Until then tb_xdomain_match() can match a received error packet, or an
XDomain response with the same route and UUID, to this request. The
packet may really belong to a tb_xdomain_request() queued behind it.
tb_ctl_rx_callback() then calls schedule_work() again. If the first run
has already started, the work runs a second time after the request has
been released:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
  Workqueue: events tb_cfg_request_work [thunderbolt]
  Call Trace:
   tb_cfg_request_put+0x5a/0x70 [thunderbolt]
   tb_cfg_request_work+0x2e/0x50 [thunderbolt]
   process_one_work+0x19d/0x380

The match also reads req->request, which points to the caller's buffer.
That is often on the stack and gone by the time the packet arrives.

Such a request does not wait for anything, so never match it.

I've seen this 7.2.15 between two hosts connected with USB4 cables,
where an out-of-tree service driver exchanges XDomain requests and
responses in both directions. tb_xdomain_match() and
tb_cfg_request_work() are the same in mainline.

To test it, I added counters to ctl.c and ran ib_write_bw over that
driver in both directions. In 60 seconds a received packet matched a
request without a response buffer 527 times, and 6 times the work of
such a request was queued again after its callback had run and then
ran a second time. The refcount warning above is printed only once per
boot, so the log shows just the first one. With this patch and the
same load for 120 seconds, none of the counters moved, even with a
2-3 ms sleep added before tb_cfg_request_dequeue() to widen the window.

The patch was tested on 7.2.15 and build-tested on 7.3.3.
tb_xdomain_match() is unchanged in the thunderbolt.git fixes branch,
where the patch applies as is. Not tested: peers other than Linux and
the XDomain discovery protocol responses.

The analysis, the fix and the tests were done with an AI coding assistant.

Fixes: d1ff70241a27 ("thunderbolt: Add support for XDomain discovery protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Neuhaus <sven-kernel@sven.de>
---
 drivers/thunderbolt/xdomain.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 563a8b65c854..64e2842b8b3f 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -90,6 +90,13 @@ bool tb_is_xdomain_enabled(void)
 static bool tb_xdomain_match(const struct tb_cfg_request *req,
 			     const struct ctl_pkg *pkg)
 {
+	/*
+	 * A request without a response buffer is complete once it has
+	 * been sent, and req->request may no longer be valid.
+	 */
+	if (!req->response)
+		return false;
+
 	switch (pkg->frame.eof) {
 	case TB_CFG_PKG_ERROR:
 		return true;
-- 
2.47.3

