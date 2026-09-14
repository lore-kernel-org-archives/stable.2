Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C436D446066
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388937; cv=none; b=n9WrIOiYdHuOm2kezb3TjK//BrgWRkiCECDtH+xoOWPV9G1x01T3GczfrJIIUpXUCPRmgSwgrVOap9BD/iUTpdtaVjUjpzoZrVdaqDuYFjFvl0p69jxJTYyjQlNMVK/JG5npLf1jopaIZOSERa/zNKD9A2wqbsunFj8wp9drIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388937; c=relaxed/simple;
	bh=kzA3pbMdUChPDPLqRGXEVGXUg+GUst1G2WkUNxAkz7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIXzp6WUZ6AtM6N0kKKwPxa30fNTToJ4oVACEOwUZ0N1KVHUQ78n+Ek2Qv2c+fjp+RlvIVp4ZKBAs0qVZoxDIXAipNup1CstD7y4GKaExxpBNOZnWXjV/crd5TZXZNu/iq9diIgDJe2ghLGWE0oy3AooHOSOim08cuUvyttQTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va3RcIFe; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va3RcIFe"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so1453529b3a.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789388935; x=1789993735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxdoFQzMWATTkINkxyDhaawW3qZZZKJ6A0rPl9EM/AE=;
        b=Va3RcIFemjJGGWuwCYuEVX8J4MWvEfwhzIpymnf6u9yxZYV5qH+PXIevZB3HqFfmHI
         N6TFRav+LzwzcyQXriVGEBWsWNWdA8bqPfupatnqnArjpz3rpREdKwGqZWnWBoOa5Yh9
         EdKWQ7/+3tGx7QjmfPqOtzsy8wLX+koCW9GApaZjKAPG7avjZ1ZlcVWqEeMaZ+n+NNyD
         bgSxHDQCqoE8cZEaPzEXepEc8Lecb4HZ+h1xlQ6wseQCM8VqRd2Fta8X5PfaNRmhfUJe
         vsozYYEoAcxOO+gOlmuTcsCfbqqmm2NeE2vlLCyuA2GFxK3q/eog2Ab02NVHpRCZ4+U0
         KKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789388935; x=1789993735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxdoFQzMWATTkINkxyDhaawW3qZZZKJ6A0rPl9EM/AE=;
        b=ifBxAJ1tqX2SdWF7hoSkTQIQ8iGgagPHJNbDX/XPR3MTHQyH9fty8R4w+OGWyPWVt7
         i2opJoXIV3eqw5up9jaE49Tvyu8Pa1jWLQhBRK6M6GKHmHJDxdRODmLRRJhigDwPth3U
         BInZlJ9pDVFhXh3VOv2UfvKCjOoilgRCiVP28GcURBwfK4ntMmXe/RbpX1F+IW9WjNZd
         XlfQbXPXDCKHlEmm3baZ2TQNT8xzAxEaqJRY5O4/xOKQKqs04s+jKtaMyWvEelxeZRtB
         5ySXxzPt0yJmQvr1RGexbntE+BtCy3PY+1xBDCcb7dRBigneuW4AOkYrnleeCnIsw8rY
         rjPA==
X-Forwarded-Encrypted: i=1; AKwUvByjQffhJvAgNKdXyh6h5ZtBSztabt+vZc3Hxjw2e4z60p5uH9IdToAMhzkonO0QeZiU6PklebU=@vger.kernel.org
X-Gm-Message-State: AFuF++nrYncNvItRVOsUqwIa0r79lCAR7F4dVtI9Bl7HQ2SphulaMFP3
	njTS0v09y3/Jheo2GdGJkfWy/kuaduSGD7vQPOQ/jBAHWjkYEJrQvghB
X-Gm-Gg: AYBFou0AsAIv3WhNqaLVs8mNcbPX8dkagTZd2r1phfTA6HYNhP5PlESV8Yg37LtUfHS
	BmXJdpeJHQUUL2AlaIy1FkfWjnDMv2ovO+eFZWB/zW4RSEVlvFwcRfvBLEuqSLaPny+6HYxJReL
	4YK1MzKIhJMgA6vP5s0gufJZ5nyvx16qFdw3MZILioRTYUXgcNZs+y0gUP9UCQw3QCFna3yTs38
	tvO6uOJEs51qjAj7k1/88ohnlKBx2OOXrrW/QJH6OClzwLZdr5fZ1rVKIsmxonHYIO+/6Vkd3mx
	MQ6aszSOJVmr6FOOiQlNWyeDlflCRr07Tq9/ry6PJ7U/fUTWT9AmnjY+V3elOGleqrNkbb5Z8ZI
	/N7HQUIxdDfBGaxgbWCn2l4yjge+QuYyAscsKVgdczxPhPD0dI5zXHLx2Pn54aPXU5EecVGPUkH
	ph3Zsnh9B/a7/Opho78vKvxYkEiy7ahxL1t3dZ+GT3tHhKX/QsV8gTKg==
X-Received: by 2002:a05:6a20:d70f:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3db404467f0mr6071048637.4.1789388935057;
        Mon, 14 Sep 2026 05:28:55 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6550bbasm4801375a12.17.2026.09.14.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:28:54 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/irdma: avoid use-after-free in icrdma_remove
Date: Mon, 14 Sep 2026 20:28:40 +0800
Message-ID: <20260914122840.1709743-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

icrdma_remove() dereferences iwdev after calling
irdma_ib_unregister_device():

  irdma_ib_unregister_device(iwdev)
    -> ib_unregister_device(&iwdev->ibdev)
      -> __ib_unregister_device()
        -> ib_dealloc_device()

irdma registers irdma_ib_dealloc_device() as the dealloc_driver
callback in its ib_device_ops. The RDMA core explicitly documents
ib_unregister_device() that when ops.dealloc_driver is used, ib_dev
will be freed upon return from the function.

The ib_device is embedded in struct irdma_device and iwdev itself was
allocated by ib_alloc_device(irdma_device, ibdev). Consequently, once
irdma_ib_unregister_device() returns, iwdev must no longer be
dereferenced.

However, icrdma_remove() currently accesses iwdev->rf afterwards when
deinitializing interrupts, destroying ah_tbl_lock, and freeing rf.
Although the final ib_device storage is released with kfree_rcu(), the
object lifetime has already ended and callers must not rely on the RCU
grace period to continue dereferencing iwdev.

Save iwdev->rf before unregistering the RDMA device and use the saved
pointer for the remaining cleanup.

This issue was found by manual code inspection.

Fixes: 8498a30e1b94 ("RDMA/irdma: Register auxiliary driver and implement private channel OPs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/infiniband/hw/irdma/icrdma_if.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
index 4b451d8482a4..f405ef761f84 100644
--- a/drivers/infiniband/hw/irdma/icrdma_if.c
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -318,14 +318,15 @@ static void icrdma_remove(struct auxiliary_device *aux_dev)
 		container_of(aux_dev, struct iidc_rdma_core_auxiliary_dev, adev);
 	struct iidc_rdma_core_dev_info *cdev_info = idc_adev->cdev_info;
 	struct irdma_device *iwdev = auxiliary_get_drvdata(aux_dev);
-	u8 rdma_ver = iwdev->rf->rdma_ver;
+	struct irdma_pci_f *rf = iwdev->rf;
+	u8 rdma_ver = rf->rdma_ver;
 
 	ice_rdma_update_vsi_filter(cdev_info, iwdev->vsi_num, false);
 	irdma_ib_unregister_device(iwdev);
-	icrdma_deinit_interrupts(iwdev->rf, cdev_info);
-	mutex_destroy(&iwdev->rf->ah_tbl_lock);
+	icrdma_deinit_interrupts(rf, cdev_info);
+	mutex_destroy(&rf->ah_tbl_lock);
 
-	kfree(iwdev->rf);
+	kfree(rf);
 
 	pr_debug("INIT: Gen[%d] func[%d] device remove success\n",
 		 rdma_ver, PCI_FUNC(cdev_info->pdev->devfn));
-- 
2.43.0

