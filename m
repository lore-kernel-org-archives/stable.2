Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8514F796E;
	Thu, 17 Sep 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648620; cv=none; b=XH82mnZ1vApU9qLSOwo5u9nfR3yqYmogU4OqBC3U/88EcY6XE9zKnoi9z2gwdzivii/67Orxg51414jH5F9Zc/NQeGpuA1HA5V5bszWh9vjU5squCwJxVcZvBqqmUEAgYfWl4kYI7wVTPCK2y/iuaGrRcEKKpENK1H6AZd+sOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648620; c=relaxed/simple;
	bh=iJbWXjGa09K85l+Faf54/Co/f4hPkBE63xcz9emaIYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gtax+NjPhgo7FONtxB+3J4qvTJg7551BGX7q0hzT9PNkhqQWGGqHoidzmd13n48UG2qBgjX5edeyExhD5BnwXC9bsWbN9Ze43UvPsvFZ6BXqyQ+UhDOzmvJwlJzjM5dfvHh6IaQFE7lcU/gGfM85BgYpECQNwrIZGcpsAv4uVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=HrmjLp8v; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="HrmjLp8v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789648595; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=c3MkuaBbDHUpaO4lzVpAovoUtzejyJ13kjQbhZJvXYQ=;
	b=HrmjLp8v8Imfx6Q4/REYFWyDrjTTtumYeo135RA/BS8m564/CkXyWYM5fw49HlCv5010NC9Qd12VrP63uDz47yzoUxi6r8pAd1BQdKXdV+2zKKhz3nEAFysT7z9MOxT64cNrZ7InXY3xqwp0v6clnLcwhtKmZz6SYTTuPzW35nQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08340329|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0165461-0.00308746-0.980366;FP=12533628751979366192|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jFtbaHJ_1789648273;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFtbaHJ_1789648273 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 20:31:14 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: michal.simek@amd.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: udc-xilinx: clamp bytes_to_rx in xudc_ep0_out()
Date: Thu, 17 Sep 2026 20:31:11 +0800
Message-ID: <20260917123111.3757737-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xudc_ep0_out() reads the received byte count from a hardware register
and adds it to req->usb_req.actual without checking whether it exceeds
the remaining buffer space (req->usb_req.length - req->usb_req.actual).
The same unclamped count is then passed to memcpy_toio(), which can
write past the end of the request buffer.

A malicious USB host can send more data than the gadget function
expects on a control OUT transfer, triggering a heap buffer overflow.

Note that Haofeng Li's recent patch for the non-EP0 path
(xudc_read_fifo) explicitly excludes EP0, so this code path was not
covered by that fix.

Clamp bytes_to_rx to the remaining buffer space before accumulating it.

Fixes: 1f7b0c6d8e34 ("usb: gadget: udc-xilinx: Add Software data structures and APIs for xilinx udc")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index bef06fe75..77f06076e 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1842,6 +1842,8 @@ static void xudc_ep0_out(struct xusb_udc *udc)
 		ep0rambase = (u8 __force *) (udc->addr +
 			     (ep0->rambase << 2));
 		buffer = req->usb_req.buf + req->usb_req.actual;
+		if (bytes_to_rx > req->usb_req.length - req->usb_req.actual)
+			bytes_to_rx = req->usb_req.length - req->usb_req.actual;
 		req->usb_req.actual = req->usb_req.actual + bytes_to_rx;
 		memcpy_toio((void __iomem *)buffer, ep0rambase, bytes_to_rx);
 
-- 
2.50.1

