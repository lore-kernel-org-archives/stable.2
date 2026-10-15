Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF043CA4A0
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066031; cv=none; b=ljMlzju6Qa+W/WmUhs6+1gjwQ8uUNu2pjNOMQC57X5kWPTb3HuzR7fJRPf7O3dw/H6kBlk2lzv3E9uRPOL5t35c8I70gfBREwKU7YlkfFllHZKplSBq7d9XYpSMgOnlVlSmBsZ/9JzsS12swa8xvwGcpiq/isjavtxUlgUKpTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066031; c=relaxed/simple;
	bh=tFirq9WK8z4MHqUYry8B+dBatiOov7iRGGmpOlMjYDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=noIDxfEz9lQnpRZghkeRcRqCW+/guOD89RCCqFuEK5HTWoDaknOl6hawEa3O41Ssb06z8ITpD1TX+xUOan5HXBYBqHeRrWd2YC99vyeEFqw7u5r+H+6gTDhAEXPH1NNTXxuG1LqijzoY1axKqb5A4dT6lJ0qMio6MreQYPu6u8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=piI71mZr; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piI71mZr"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd3310348d2so3409203a12.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792066028; x=1792670828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKMqH5LXFbN7kyYU7PnKFmn1gNr+IrqxQUbfeXE0apY=;
        b=piI71mZr/EC1EnT15UjAompgtYIQHB1dUfxdcJzIPNsxLEwjptdnhbw3xdtCGTfh3p
         wgf+QZiWBYa42b2gcXDQi6M1hn/v2aBJ0fNtsuR9hgrzr4JD2IedioJHvBfrKf2lYoWy
         p6yj23BZUfc13+gwJyLlmVree5TYWFy4iZqHBuwv519Vcw5kdrsoNGZXtXj1KYIHkmEK
         xru0wyzBLqhDKM9Isp+uO/TGIJ0oaTfjs/Jjm91wgak2BuvE+eH9bHOBPHevlUL1WoaV
         Qfw5CQk3hATTnxipz7O08Ptd8OBEiLC5zwon66Y94HCQ9AW1g8UIXfQIWVOm9zOzoWMP
         mPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066028; x=1792670828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKMqH5LXFbN7kyYU7PnKFmn1gNr+IrqxQUbfeXE0apY=;
        b=hbaK4ev0csCaNy1RP7kgLv8ECv/NWqqt6rxlGCH45FufN7n5yj6cVFvg0NPsyjRCPj
         tGhaudBdwLFUxaS6Pwd5zlZ05ttwY/FAnFlZef7RhLqObnYfPVN7XQHyNN6wLPu9CmhO
         rOD0boAmQWA7ohcSulQMjRbJZQz5dD/4qrST2Ze7IGFM2noIxDaSOYIFushn/ooPkqkn
         U972QkoaEBcjgKi7O6qtdk7/tffRlbVzJ66xhCBZg0AD+AZTRBfriSJ8BZ8ZbD6XDYwI
         STV9yX7JGfp0t1yLL5l1il6mQ0h4tXHzPlbKln1fg7ocTniqpBzJT7Ry0FfLgzOZ2Apo
         ukJA==
X-Forwarded-Encrypted: i=1; AKwUvBzfpXZhYQNwk/kYPBg8oIQg+wFbp5KohVAzgwJlTASwachJY7w6mJRVGT9gexVB8Qu+zKtZZ4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcwvk61uB6Jgm1/FXEx/hPI/WZ1K0Vr9OTKlQd+dvk5bvCIF1G
	ONJquxtZocaIrmyUBhAUivNf9prA9F187DE/skSJ/yMZ9dsVQ+ccB0jC
X-Gm-Gg: AYBFou26FgTEpr73xrs7IT4gOg4++S2lSGe/wXWZEr5WXLS01LQhKMyieYmNjDyIcpp
	SyJjNaNJ2WVB4HFxGJWZlj39PN/UElsP73mmF7C5syINjcG57mJmhAcVSy4KwYnhGLED2dgRdws
	5RWlUdSbylT7kX/LB9MCIUzR91wb+uOJ67HMHm6KOhizyeAguSZ77KjRTibrtflH0qj5BLLIzDa
	y14Rfg93NyNiNbL8zLFY7ObwkVP4+d6MWeu0YpPRBQFksO3yY58UB3H+SPoWfqw/cBgGWEwVUb3
	R2iztKlA3mD7l5M2p9GwPU1ddYhJqjBSLlMJMcdX+4FrBPsCcfiymUhJZTX/PnlDbsDIFEaJpgw
	3/HNmHA/5miNUESzrKhbPlk2wu2P1OLG6le+YNXsRy5dc5KYS3VoRU5DdwvoTLlPt6V/uASmdwr
	DDQb4OXTUw0SJ2M3OslKxBd0sj/AfWQgAyGEr50EjTceCVZM0wA/JUNnkmZ/J8Jzc2V+XRkTNbx
	JO+KmIE
X-Received: by 2002:a17:90b:1a82:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3ab3ab209f3mr9754562a91.25.1792066027993;
        Thu, 15 Oct 2026 05:07:07 -0700 (PDT)
Received: from localhost.localdomain ([106.101.11.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac944b0bfasm4399621a91.16.2026.10.15.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:07:07 -0700 (PDT)
From: sonotri <sono7ri@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sonotri <sono7ri@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ublk: pin module while release work is pending
Date: Thu, 15 Oct 2026 21:06:54 +0900
Message-Id: <20261015120654.241354-1-sono7ri@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ch_release() takes a device reference and queues exit_work.  The VFS
module reference held through the file operations is dropped after
->release() returns.  A queued work item does not acquire its own module
reference for the callback.

Consequently, normal module removal can start while exit_work is pending or
executing.  In addition to the worker callback itself, the final device put
can invoke ublk_cdev_rel(), which is also module code.

Take a module reference while ->release() is still covered by the file
operations reference and drop it only after the worker has completed its
final device put.  A rearming worker retains the same reference.

Merely canceling exit_work during module exit is insufficient.  The worker
is the terminal path for the device reference taken by ublk_ch_release(),
so its cancellation would strand that reference and skip the associated
cleanup.

Fixes: c5c5eb24ed61 ("ublk: avoid ublk_io_release() called after ublk char dev is closed")
Cc: stable@vger.kernel.org
Signed-off-by: sonotri <sono7ri@gmail.com>
---
 drivers/block/ublk_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e71..71556c34a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2613,6 +2613,7 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 
 	/* put the reference grabbed in ublk_ch_release() */
 	ublk_put_device(ub);
+	module_put(THIS_MODULE);
 }
 
 static int ublk_ch_release(struct inode *inode, struct file *filp)
@@ -2625,6 +2626,8 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	 */
 	ublk_get_device(ub);
 
+	/* Keep the worker's callback and final device release code resident. */
+	__module_get(THIS_MODULE);
 	INIT_DELAYED_WORK(&ub->exit_work, ublk_ch_release_work_fn);
 	schedule_delayed_work(&ub->exit_work, 0);
 	return 0;
-- 
2.34.1

