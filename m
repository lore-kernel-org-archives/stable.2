Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF02F9C37
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334341; cv=none; b=VrEVQYgCh+B2SKPd/cHNXTeE30/6r//CTx+b/tucwnRVLwV1EYh5CB/nsZT8E6TDLGLJMpkAHkcegs8NVrvJuPJOuPfVQfAnZK8Br0hM/Y5zNfUr5G39JxtDLxP2LmGwoqApZ5p3vnoTPLzH5s6BV7J7KEWpTEesYWRf5LBDW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334341; c=relaxed/simple;
	bh=YrVJFMdX8MrXFmMgpegL+4Roa/MAxP3vv2Uu0rJmzfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIauIG8XCOsY2MjQNj2I/5SPDO+jaQFk08wFcxITdk6u9shWlHli3/OnkXpSgK7sleNFYBwOXskMsODYvuzXMeDWi3yOGCjJv+6rVEbm37zRHnrxrc6fyrnnpuIHiFxnKVX3b+w2CAVrJcv6bXiNe0dawpdRfKHr9EmNhhk6iuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BejvRPqo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BejvRPqo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d01548ac96so1929455ad.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787334337; x=1787939137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=51LCH1dFImHI7IDGxG8+NIuNisCwMvociROcN35k4CE=;
        b=BejvRPqol8X5QIxgToKsLIX/Hruuf1h7ZCRh+orrZVhLv6SqKq2G4UDwk41camaw9M
         JZPbjhveSPRPJM3/Iapge+sv+bA5s9Zq7hhjIF/vdZZCW0xlnZ6KEd/6yPEhxw0OE/k9
         9A86e2xuKPO/xAEVYpWIV4EMs2CJkv2h4hamS2JfVjOBqtz8KS6p3yQgwYG5LXkvvl0v
         CBzVQp2Htht2roP87BIg2KqrccNN8WW+m6PlXL+4hpumlh+LFPkR3qlOCjYcLPLsB8Pf
         rtbTTVQaGtwtnCxWXmS+kl+XPRgVg8z8oUhkQCAekTcGU+QJLrH9Az5rBkptE5D7OJcb
         g/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787334337; x=1787939137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51LCH1dFImHI7IDGxG8+NIuNisCwMvociROcN35k4CE=;
        b=S12s/xSDww7klIggcWaX177PqiqWnCu0+rbVD231O7ulooRvEaMHgzO2A08bn2RFl7
         7G9BBwdqL2YjoRR6cYt45oT6JLbKKPJa818Z9f53a1eHnIYvNEfoVFGxe3MmgzIEVaj1
         os618PhUhBSfZTgSUGspfUve7/KikbQDh8EEN1VrYxmuHToIP5+XjLbi97K/Nyn/jaz0
         L6eDCiwGSgtxAprD5ytH7fRPZS1+DSTfADGjayDgY26IB6M+koATBDGK01FANlmvsiNu
         F+O1H5QCEGIlQMJN06+jp6JAAmuP2FdpyMd9hxe6xDIXrj9b7C8rhD2sj5wzvL7HOYBF
         Luag==
X-Forwarded-Encrypted: i=1; AHgh+RoPxmM/O8/puCxdAwq3/Npg9NOtD90Hv+o4bF/mXWrqCGOlb2R8jcVhOLN/uCFCCkZcWzV9F0U=@vger.kernel.org
X-Gm-Message-State: AFuF++nnwejwXI0bCWe9hNPjVDmKxevLG5XZByH2QXIb3uNztQz8GDKf
	7aFtFtjrcPD8GRV8x48zNN3ZHMKs/5BC12v9C0GNnEny676eHeZ5zQl7
X-Gm-Gg: AR+sD11Zs47Hzy08qh71j0HSiyTMcoo8Jc9Dkh0Ghan1k+SToBKZYMcygJAGHL3UMa0
	8O2PY7RcL8oeDSiLfMp5n2wqpL8GCtGd6Zgi6QRH3lRbhVbOZpeiCXjX1QFaut5U3KsXqF30XMY
	9evY3ACMqymqfsjQyShUbY7Kpm+GAsqeOdATtQojn6QHyXYBzzrmL59k8AVr4q7eNDv1ZypzAeG
	0lNKOrVIj9Q6tKQwAri7014fdQYKpht99JJAj1gkmTaW2FRVgLo0JfWTaONBHHHiG3/bRUrrCir
	zvraHTlBENkPntPKWKJORMDC0JOowuo1ihQJcGQACz5EbJCXpPnXEbVaqTwADSgBBT7T2i5oLZU
	dxfZozIMXxXlUu5OPbg8ixb4TDHK2UyBubChkvQw17HM+Mz6W7IUp8KFy8IqfozQL2in8aWl79R
	/QCeckbP0aXly7Hm8eAM6rXggAaa+jrMM3OP4NdPteZhkvjEcjgxb19RisLKABIKhIoQOHxE7oZ
	H5tjGPplOFohSWzSsroX8/6Xv+bM4oAQR9H1iyTAfwmxrYHtV3C9Kg=
X-Received: by 2002:a17:902:fc4e:b0:2d3:aecd:51f7 with SMTP id d9443c01a7336-2d64ae3a7c7mr74505665ad.1.1787334336545;
        Fri, 21 Aug 2026 10:45:36 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae89189sm27832330c88.14.2026.08.21.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:45:35 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jiale Yao <yaojiale02@163.com>,
	SeungJu Cheon <suunj1331@gmail.com>,
	Ali Ahmet Memis <ali@iusegentoo.com>,
	Tim Bird <tim.bird@sony.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: serialize session teardown
Date: Sat, 22 Aug 2026 01:45:14 +0800
Message-ID: <20260821174514.3034851-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_kill_listener() walks session_list and deletes every session
without holding rfcomm_mutex.  A connect task holds that mutex while
rfcomm_session_create() adds a session and while its error path deletes
the session, but the unlocked teardown can still observe the object
between those operations.

The race can proceed as follows:

  connect task                    krfcommd
  ------------                    --------
  rfcomm_lock()
  rfcomm_session_add()
                                  fetch session from session_list
  kernel_connect() fails
  rfcomm_session_del()
    remove and free session
                                  rfcomm_session_del(session)

The final call then reads the freed session and may corrupt the list.

KASAN reported:

  BUG: KASAN: slab-use-after-free in rfcomm_session_del+0x15f/0x170
  Read of size 8 at addr ffff8881019e9b40 by task krfcommd/87
  Call Trace:
   rfcomm_session_del+0x15f/0x170
   rfcomm_run+0x16d5/0x3de0
   kthread+0x2c6/0x3b0
   ret_from_fork+0x36e/0x5a0
  Allocated by task 96:
   rfcomm_session_add+0x9e/0x300
   rfcomm_dlc_open+0x8b1/0xdf0
   rfcomm_sock_connect+0x34c/0x530
  Freed by task 96:
   kfree+0x131/0x3c0
   rfcomm_session_del+0x109/0x170
   rfcomm_dlc_open+0x9eb/0xdf0
   rfcomm_sock_connect+0x34c/0x530

Hold rfcomm_mutex across the teardown traversal, matching the locking
used by normal session processing and connect error cleanup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 9cdfea666a2c..5fe2758e8c47 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2178,8 +2178,10 @@ static void rfcomm_kill_listener(void)
 
 	BT_DBG("");
 
+	rfcomm_lock();
 	list_for_each_entry_safe(s, n, &session_list, list)
 		rfcomm_session_del(s);
+	rfcomm_unlock();
 }
 
 static int rfcomm_run(void *unused)
-- 
2.43.0

