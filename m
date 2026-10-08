Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4835F619
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 05:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791436295; cv=none; b=kGchNRJ1PgVWxTggyOc3pysraH6s14lhjAP0TVnkH1BQ1tOeMoJBNLCba6KfmJRRbzBWVM92ceXTLZ1mD8cjg8YJ77Bja2IdyRS03UWZ9DnhPMIZA02XprnjwjJpln72WQlNFLfMCJ8sHkMDalxpu/bIJogIRrp+d5JnSyxgux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791436295; c=relaxed/simple;
	bh=gEkHXfRr76P2h8G3BI1+VQ6pxmufVkopuDC5xCXBgyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cc2dPPhe5hXaDmVJmar2i4anKTbCYJq8pXUrvtQAI56SWrFQFEWG3GK3M+flKPiYjdAnRz7KgFDEDtbMstj0mr7scQ+LbsO9Z6DHaV32LLEXuLJWE7XJYswSLFUHzJ6r3tAPqO4H4lQ69VIqwkWXfi+Cr5q32uI+qJBC8Ey1/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClCuu4kQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClCuu4kQ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ccca948203aso1492038a12.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 22:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791436294; x=1792041094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=elAPkWnEdIb/cze47rnLz0VBXJ5OrbhEX1cUa7QEjhQ=;
        b=ClCuu4kQv+qI5GVHbQrRH4g7swgmlUDruAlo+YrCgLxccAwBi7noFH4hwMQ0d8vyI7
         0B7vhOcLZhs84ovBaB3UDAxqrnzCxB39/BPG8mT9KNsSMVnwqe9U8gi5eGEVvGefH358
         TeeV4sNZkOP+8qP/m2M9blBVtYjET5eiyFHwAEryy/tAvsEKdaZ3Fg2opar7d0dDy1JM
         ls4wr4oh5GdJJQPVEaync+6noFTXerCBFGDDORmamruzbSUtqGpvi2/NLBPY5bMXjVTl
         7R5CxGBxPDbVHkNCv6ftCF77ARAS2Hwi2k+1KBy5oIduWBjINXm5auVDlMuGZq5TBTMw
         3S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791436294; x=1792041094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elAPkWnEdIb/cze47rnLz0VBXJ5OrbhEX1cUa7QEjhQ=;
        b=d5lYKNLC4s9fxvKod4Cy4Sg/iTOqmL6KSl3pSv0zlRv5rusTDeiiYFDFSVM08gPEAR
         /araIWptuDyfgzDdPJGl0sB5Mtaa6z+zY2IHOJRDKV09esXkSI7O5KmEQky6ZyjqLgpf
         MdDQl8MN/ywHBBqZHUpikVPEl5W9CBxLBaLe4vKxC9lxNTRYswlOHUzqp1XGd9jesQ5T
         zHJ4zdi5/xLkFmat3hCviCdvsxNoNjNAW/sQvkXdMafOhpbrWbmV2RHU8EFzL/DYBosY
         zKPUlIakwUfsiiDHbyRtOa7RRYnKl50PXIKz3eqC9yAWOg+lJyTnSZzRjzfypDqjVLkD
         1XhA==
X-Forwarded-Encrypted: i=1; AKwUvBxkITKuoE6q6tV3YjP7rWEDkv/erMXQGnbJ/HD9F6UqMJn7R+ZULA8p5lHmA4WWnJJutRNWrDE=@vger.kernel.org
X-Gm-Message-State: AFuF++ny5psOKyXjM8CV0HIsG9sMC1kdTvVF25OEv1x1uf6jiO07HTth
	Qu1vDab1sVzRA/mHlGUE3rPmu4e5vQrnRdAXZLm8kCr7nCuOJxy28ntwY07XhA==
X-Gm-Gg: AYBFou2D/YeIeB3BYg5zBlfbTu5IxS9CGRsJfGhNrNdf/KA9CymtTk+fWoGPNHkkc6C
	FDqgFpM/HO//sCn5rBGwO3piYNo950LRX65TUGwjOLZOiOurPkrcLFrmVMFHNeBcEXXcl52gYZw
	TB7tcqWWyTkEZcXlakAHYMf+GNzyqlQF2uhV1PIezAZ8eBYD7rcdKaLa56/XUhT0JwCl/sQ6C86
	XNs6eT8rjRf0pwl9/dUkSI1k6aCO1PPD4+Ppmnao13eWr64+pIkvyQufF2GBZszZkaArCglbCpG
	LCXYoueLRcT2bRu+24mleRnpV1ZiPAOQSbq2XXUW2mg9w+w31T3oghvPkMWEl0sY1MpkxdCWIl/
	dHIUrbbXOl1Hb3FHhsFZdQGUIdqM5j1kQUYnAe+lj6eEXbSZgwKe8cgsstxqdxJftDCynAGI5Yg
	1LxSqGPqSzPj5AEzE6TRzCR4R/xOYbOWvtjgKZnhGQ8L66KgV+p5AntREp5JmVMOERty4=
X-Received: by 2002:a05:6a21:9190:b0:3e0:d33a:fd75 with SMTP id adf61e73a8af0-3e1340db79emr4497431637.53.1791436293946;
        Wed, 07 Oct 2026 22:11:33 -0700 (PDT)
Received: from dungbv.. ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0aa370364sm2399656a12.31.2026.10.07.22.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:11:33 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH] Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
Date: Thu,  8 Oct 2026 12:11:29 +0700
Message-ID: <20261008051129.508322-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open debugfs file retains lowpan_control_fops in the debugfs proxy
state. However, lowpan_control_fops has no .owner set to THIS_MODULE.
As a result, full_proxy_open_regular() calls fops_get() which succeeds
without taking a reference to the bluetooth_6lowpan module.

With CONFIG_BT_6LOWPAN=m, a userspace process can keep the debugfs file
descriptor for 6lowpan_control open across module unload
(delete_module / rmmod bluetooth_6lowpan). When the process subsequently
closes the file descriptor, full_proxy_release() accesses the already
freed and unmapped lowpan_control_fops table, causing a kernel page fault
or oops.

The issue was discovered via manual code audit of
net/bluetooth/6lowpan.c.

Set .owner = THIS_MODULE on lowpan_control_fops so that debugfs pins
the module until all open file descriptors have finished.

Fixes: 6b8d4a6a0314 ("Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 net/bluetooth/6lowpan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 30f4afa18bc8..20fb20eea8e7 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1209,6 +1209,7 @@ static int lowpan_control_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations lowpan_control_fops = {
+	.owner		= THIS_MODULE,
 	.open		= lowpan_control_open,
 	.read		= seq_read,
 	.write		= lowpan_control_write,
-- 
2.43.0

