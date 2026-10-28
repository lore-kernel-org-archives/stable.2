Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793147842;
	b=EzkJMmLKKgSac055MxH/gOmzIDxTpfY14lZ3a5p3nit6ZUxnCGZNAmMYaOmI7RdBbW+a
	 Q4rwYKPedRJTJfRJVZfsFc/z/ukRLH08A0u77FRJ76B4dUohBOeDH2bG9TIZavOdQWdTE
	 6qk/fnRU/kQ9qiRxJNpD54s7ARDp5N2EKxNfz25b/+Nt9+KpHtbd/2tRRwRVdfTkFGjho
	 eaTEOmihs2HmIu7vH2ILlocXYI0/PADerl+tgnZv+WeTkMgFhguW4K9uS53znLmpLeoR7
	 cjK/uCZZdjN/4Otn7rg7OXR6ufrx+bvOQ/gJD7Ax4r+Oao+IGh7l4qO3H9Rj6JbUBjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6z3QohFwrl9/yr27qFYsYBSnTw/3E1beDpN8A1lFb2w=;
	b=GWurA8l2zdTSqWA1Yng9BVfu0KcFQ+JDg2WzZY8TsAYXOIB50B/g5/cPb8EXxQDOS3zu
	 08pMQjgsDHADynG/BN9IcHYw0uy60XtdQKBjWw4+FuvlEnKvJTpl43AqTPG8nIQEW0g83
	 /btApfzTFsucaZOZcQUjEleyIR7agvIk+Zz85Buw0et9Awx35O5BtMK9YfX4snLIsqqup
	 u0Oh+GR7XpnsgFIdiQuwyhiLWYJw9eXGvWE0D+/yiCDAYq8GuWEKLljMuCTYDoeXA04lQ
	 fzbWiwhUxnURuuc9TsLYk0wBVE2XE6U9e6WRoeU2OF5euUnvxrcIFUTLAUkVRdF9frQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Us3BQ6Oe;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8D606A336
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 00:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AA8D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Us3BQ6Oe
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so2825175e9.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793147840; x=1793752640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6z3QohFwrl9/yr27qFYsYBSnTw/3E1beDpN8A1lFb2w=;
        b=Us3BQ6OeRGuRLKCh4A/xtwYUHovES9okx+gEuRziZgqPd+whmms6vJJv/aAT7oMEJ2
         3rCugxLgKUVvC706v+s9kTo6ahP81FDSnV1qrL9ABg7JTwdbjmUglOFXrlP0E64jrRfo
         nMxpepUMNBqgrb253CsbpMePH9H8wEJTZgaVb503dpyFixRl6qhgpQ1iFaJQeWTKChxW
         P1BYLKCna4TSyR3tdO6hLCwBPqrW4H44+KlDyU1joaYrtoOLQWw8T2t5psyRfsKl3w25
         R6/A7nd0IPcIKGML4ixFDkBiYai4YeJpvW7E5kTa5klSmbCNsipZkgWAAqUjgS+6AFmm
         +hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147840; x=1793752640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6z3QohFwrl9/yr27qFYsYBSnTw/3E1beDpN8A1lFb2w=;
        b=1PMa48hQRkN8rm/oNGsSH5MYR1VAHd2/2xioe57Dmqqm/OHlHI/dvZnpHj9CIaBg/s
         PxN7DGflYZuaMxLp5htdv1nNXQvCBFuGtjJl2JDlVu7nZ7xp1C008q2t8XI3isN1Dfrm
         0Vxvo9DdzcqXfyHx3U6Jj/caC5GEqjLzZ4h1fsT86BYee9Vhd+S+W1taa/1fwhjAg47P
         gEsi3YS1sPePDRCPi1nLjtYELLQtWND4rHH73OETfN3y3+AkICW6po0IB+ibjT8Zn4Zu
         pDU+1GwWCgimScDq3pvACxKNF4C8AVEuol6tiAmYp5Ue34aVRoonj5gXVzkxpZu4wm5n
         3WSg==
X-Forwarded-Encrypted: i=1; AKwUvByk+veOy6N9qS/Ecs8wOwWnwsFjW3JdV8sfUH5PehXKtAUJ5Rj3W1HLyjHvmb2E12VQjgEeCT4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWlQJpjFMnnrmXeSwfNJI411t9lD3MvfMWtdRfkBI+0+5V13S2
	Vfeu7hhUTzZWuQmPQcaVs2o54yNO/Lg/Me0lVbKti7bP8qlyHPfO2iuQGT1h0t9OFt8=
X-Gm-Gg: AYBFou3ZhYrZHMhNoUCoY9o0JTRcB/y1Qf4vB/377FqXbeQYZYWnk0ANwk2xwjMEWol
	GMSahyrbnqT4kh0VwQezltiQfYIT06SCKQ3/thGW+kKOnSX6MAD1raOomcFrzcy1DCK04vYw/3w
	smXGlS3ex3FpVLy/3QDn81ZLFDCrVkpXOxoC0/06+SI0dm11i0rxjjOb9svB4MAf6OR96tBikWn
	bRU40b9UszggTkgtvSMFNi6P04xKifpuo2CW4uTUI6m6Z4rN9Z+DYwdVkrO/+U3EK0GaENq5BeB
	ty3jdp3o32gp66SdmUOAbS0NC66+CSTVH4qATR15qz3zYQbg3GESZRjMapLR12eGBrfXw9FgkSx
	rt5pqm5DeX6m4kmmoeHRInKObiaKiFwwM3NS70NcFy8dP2fsy/uZ79vYDdQYHwwssFM5pkLrmuF
	R3w5PIXoaACM7q7wkIQFksZcx1nQ3xCc+ACaUdoycGNUdhvXfQKxhonIhwTndd0oG6+O6qK/p+5
	u2CSiPJ+4nkLH802pxtLN8BxQYqRTb51IqTG7dWP/0qsIN6IGojyrGuz0nYBGZKKytd+6jh2yhF
	8sWOxlRVEFt+qmQKuzbSHnDe1bQmkp1KzLXOD48W7WKaBzD3sVFWLPn8MlkEtHuO6C5rXF4Atzw
	l01gYHCWXT0g=
X-Received: by 2002:a05:600c:3e15:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4a9961f3d36mr3510115e9.6.1793147840030;
        Tue, 27 Oct 2026 17:37:20 -0700 (PDT)
Received: from irdv-jinli.dev.purestorage.com ([208.88.158.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a976010d2csm8395245e9.2.2026.10.27.17.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:37:18 -0700 (PDT)
From: Jingyi Li <jinli@purestorage.com>
To: vkoul@kernel.org,
	vinicius.gomes@intel.com
Cc: dave.jiang@intel.com,
	xueshuai@linux.alibaba.com,
	fenghuay@nvidia.com,
	Frank.Li@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jingyi Li <jinli@purestorage.com>
Subject: [PATCH 2/2] dmaengine: idxd: fix destroy of NULL or already destroyed workqueue
Date: Wed, 28 Oct 2026 00:37:07 +0000
Message-ID: <20261028003708.834341-3-jinli@purestorage.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028003708.834341-1-jinli@purestorage.com>
References: <20261028003708.834341-1-jinli@purestorage.com>
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

idxd_conf_device_release() unconditionally calls
destroy_workqueue(idxd->wq). This is wrong in two cases:

 - If idxd_probe() fails before idxd_setup_internals() has created the
   workqueue, for example when the device reports HALTED after reset,
   idxd->wq is still NULL and the final put_device() in the probe error
   path oopses:

   BUG: kernel NULL pointer dereference, address: 00000000000000d0
   RIP: 0010:destroy_workqueue+0xe/0x300
   Call Trace:
    <TASK>
    idxd_conf_device_release+0x15/0x90 [idxd]
    device_release+0x3c/0x90
    kobject_put+0x7e/0x1e0
    idxd_pci_probe_alloc+0x300/0x15e0 [idxd]
    local_pci_probe+0x22/0x60
    pci_device_probe+0xd4/0x260

 - idxd_cleanup_internals() and the err_evl path of
   idxd_setup_internals() destroy the workqueue but leave idxd->wq
   pointing to it, so the release callback destroys it a second time.

Clear idxd->wq after the early destroys and skip the destroy in the
release callback when there is no workqueue.

We hit the NULL case in a kdump crash kernel, where the DSA device
fails to reset and the oops kills the crash kernel before the dump is
saved.

Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")
Cc: stable@vger.kernel.org
Signed-off-by: Jingyi Li <jinli@purestorage.com>
---
 drivers/dma/idxd/init.c  | 2 ++
 drivers/dma/idxd/sysfs.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 1577d22b299c..5962cacef060 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -389,6 +389,7 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
 	idxd_clean_engines(idxd);
 	idxd_clean_wqs(idxd);
 	destroy_workqueue(idxd->wq);
+	idxd->wq = NULL;
 }
 
 static int idxd_init_evl(struct idxd_device *idxd)
@@ -460,6 +461,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 
  err_evl:
 	destroy_workqueue(idxd->wq);
+	idxd->wq = NULL;
  err_wkq_create:
 	idxd_clean_groups(idxd);
  err_group:
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6d251095c350..d5ffc641c856 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
-	destroy_workqueue(idxd->wq);
+	if (idxd->wq)
+		destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);
-- 
2.43.0

