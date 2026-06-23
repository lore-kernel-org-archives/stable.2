Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C141C71;
	Tue, 23 Jun 2026 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207243; cv=none; b=IDPrzGcWo8deE9hD7FuwWqOgJK2NGCqRppIWHxH910mBSO4H3Ce/0DajHQVucZ9qUEpbFKHJ57Re5TnkeHXFJBm8zqcwd5wDbOkPgmSy1Go2CAVkoGFhh1iGwS3DRz2sFsCh6NUhycp78XXXNYmBF3XCHp+/OGQNPcbEKQ4/tPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207243; c=relaxed/simple;
	bh=0nSnklP0qJ5Ka2LStImpkmX3ESc42oa1HF9RN2zLUu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y6dY20dVxAY+zUBz7BSPze/wAt/pP8j3S47OWyaKxORH2d6aLpiHDsJ66C/VSQpekc0fl5vmJeUVjwWAnlCxoyHkIOcKx9Lzs2bFNQQUzernBu1Jvtyso0MHsRA204CQLIEjWSpryHFVOJk4XX2Q1IW0toIhH9QpWKRvmpvGvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dmlZEJKf; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dmlZEJKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=d5
	s92hGEq5208iujjhhC3arh0ICrujvsV1eSvCSTxrs=; b=dmlZEJKfe5gvScPzs5
	iozHUTq94La/sX4p7B/F5s1pcvrOtNwPrhVcLhZ/f62M0+7x/BIVU0Blb0naibk4
	bDHy8gm/+NWJgG8e+uqOdJECkGwHk3QiTo4rC3tDUj+x6V81kWlJuAoxOgIRDGH8
	TJb2U5QcbLFSRg/x3NlUO7HOc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnTyPlUjpq6xXLDg--.19652S2;
	Tue, 23 Jun 2026 17:33:27 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: chunfeng.yun@mediatek.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: mtu3: unmap request DMA on queue failure
Date: Tue, 23 Jun 2026 17:33:25 +0800
Message-Id: <20260623093325.2105323-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnTyPlUjpq6xXLDg--.19652S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWfZr1kXw1xJw1Dtw4rAFb_yoWkGwc_Kw
	nFgrn7GrW0y3sFkr4akr1v934xt3W7WFn5XFs8t3sxAa4YkF4Yywn7Zr95CF1UZF45GF1k
	A3W8G39Yqa1fXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRizuWDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Qf2ZWo6UufmuwAA3B

mtu3_gadget_queue() maps the request before checking whether
the QMU GPD ring can accept another transfer. the request is
returned with -EAGAIN before it is linked on the endpoint
request list if mtu3_prepare_transfer() fails.

Normal completion and dequeue paths unmap requests from
mtu3_req_complete(), but this error path never reaches that
helper, so the DMA mapping is left active. Unmap the request
before returning from the failed queue path.

Fixes: df2069acb005 ("usb: Add MediaTek USB3 DRD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/usb/mtu3/mtu3_gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index da29f467943f..f224f2ee379a 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -305,6 +305,7 @@ static int mtu3_gadget_queue(struct usb_ep *ep,
 
 	if (mtu3_prepare_transfer(mep)) {
 		ret = -EAGAIN;
+		usb_gadget_unmap_request(&mtu->g, req, mep->is_in);
 		goto error;
 	}
 
-- 
2.25.1

