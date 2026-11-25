Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650570;
	b=WMP2TphafuYV9NNbjL5wqvb52vSZSAzfRRTB6akkAseP4tRTqTyuAwo2dinRdVQfwK3D
	 b7+U5ZU+JCnGaURlEnewYy/CCOwwLnD9JEcwcf8Xm57UyLScF2oAtkIhVK11UIph+supK
	 2Wcb8zubRpxOQ+dgaNJOUcuVdNLtKtLWQvmNNCi9sC1uuXHqY4yUBajhwRNEdIsihIzbA
	 7BJJ754iwpFTKXlCTuUc3gyy28u1qPJUy0kMO3ShbRAH5kWDIEYfE5epUNr/OrWv/vHz1
	 x6/3PE1gesvSiZ8h3x90PgtOi1x0gctprCr3nvpKWpMuje1OsDTkt+Br/qWAbUKlSlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650570;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=gfPcNX4bbTKVnXvCTMztOnEr2/tp7JmTvodvT0fKx0g=;
	b=y0uqF78ezwZE+u6ZtEPKLcvD3kZCaQJxk22gkhXp9l5fAPYcSQLtahxBXilwXyzw7nfh
	 Vhzk4mDdd+0E3Sq3uYwYsVqdImcK1NGKhaDIIgYcAkz+kGSNMg2/KjuzyWBj/ErhIfzh9
	 q4p2ExBS4oLTQeAJ+St30Cl/vYK5imO8CdmrGknX4nq2L1+1oTnZc1tbKLjO7ynOzRRb0
	 Fl39o0rb+uLjF7WQBGPRA77JVDNR8UpW95cauwszsNABXLWvovxZFKXgAr2Hcyxqi83+y
	 wfsqA8oqqZJdxnRbbaZjvxeca7ZnPs/H1Lkqahw7uLXYlGSNBL/DZLJOVrGd/6jkr2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=chjAtC8P;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED4606A331;
	Wed, 25 Nov 2026 23:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43ED4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=chjAtC8P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795650570; x=1827186570;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=u9B0sxZHefYVQgS0QTVDcDKp8P+kuKNGjuiMaWOmfzQ=;
  b=chjAtC8PpB+L9sWd7SZJrr/qPEISihr23GZQ/i0U2FEVGecAytH8aEuZ
   HOWheAc58pzpk1EuAkWoVIh87EtRMMjkTio/oDRKLu7pKZ/M3Mxcadb6F
   t3uiR/wZN9vRsZ9RwcOp8eyUyeOLUnrg8d4MOhrKNRz/8flMczUlIFGnP
   yMt5TfxCoc3f8hVJLmqceVWq89JJhw8SgcPa7EV7Hfug6ch4SilBlst32
   ddec2AWwWITkx22WIwO4uZYt+Q17pn+A4ooLt2RtezB4KgbLNiKDXfpVF
   eTTo0DKB6piIm53ieS5BMAL11g+Iwedx58V3qQzPenpsCMPnP3H9xJTzL
   g==;
X-CSE-ConnectionGUID: 6veroFftRc6QeklUVtBMbA==
X-CSE-MsgGUID: gKa1rmBaRkipsOC+Qx4NhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4597280"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4597280"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:28 -0800
X-CSE-ConnectionGUID: AHBmS1oAR8ur12Mgxq9d8w==
X-CSE-MsgGUID: 0qj+fRvySHCKVqSxMiIqaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11873831"
Received: from vcostago-desk.jf.intel.com (HELO [10.241.240.61]) ([10.241.240.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:28 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 25 Nov 2026 15:49:01 -0800
Subject: [PATCH v2 3/8] dmaengine: idxd: fix duplicate memory frees on
 initialization error path
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-wt-idxd-fixes-v2-3-25a4691dfb9e@intel.com>
References: <20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com>
In-Reply-To: <20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>, 
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org, 
 Bogdan Codres <bogdan.codres@windriver.com>, 
 Jingyi Li <jinli@purestorage.com>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795650562; l=3036;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=NzSRWzJZSCmKtxBoVqjiPB0MqoXOr18RfiTudfP54ko=;
 b=tnFhh69M9WEYzBkJVhBpffsJ4vXCXKDgC1toTTVs2k7HXANo4XloT939IB73MutvQ6EGHC6LO
 hgm15mL1BzyCjp1qp/bi5AtL+ShhfvDe8owlaPEqTKayJe3GIIQRaMB
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

From: Steve Wahl <steve.wahl@hpe.com>

Error paths within idxd_pci_probe_alloc() and related functions end up
attempting to free memory already freed from idxd_conf_device_release()
via put_device().

This was encountered running in a kexec'd kdump kernel with reduced
resources, causing the "Device is HALTED!" branch in
idxd_device_init_reset() to be taken.

[   18.628791] idxd 0000:00:01.0: Device is HALTED!
[   18.631447] idxd 0000:00:01.0: Intel(R) IDXD DMA Engine init failed
[   18.631450] ------------[ cut here ]------------
[   18.631451] ida_free called for id=0 which is not allocated.
[   18.631462] WARNING: CPU: 0 PID: 11 at lib/idr.c:525 ida_free+0xd3/0x130
[   18.631474] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.12.0-1-rt-amd64 #1
[   18.631477] Hardware name: Dell Inc. PowerEdge XR8720t/0J91KV, BIOS 1.1.3 02/03/2026
[   18.631478] Workqueue: events work_for_cpu_fn
[   18.631480] RIP: 0010:ida_free+0xd3/0x130
[   18.631492] Call Trace:
[   18.631494]  <TASK>
[   18.631495]  idxd_pci_probe+0x1b0/0x1860 [idxd]
[   18.631506]  local_pci_probe+0x43/0xa0
[   18.631508]  work_for_cpu_fn+0x13/0x20
[   18.631510]  process_one_work+0x179/0x390
[   18.631512]  worker_thread+0x237/0x340
[   18.631517]  kthread+0xc6/0x100
[   18.631520]  ret_from_fork+0x2d/0x50
[   18.631524]  ret_from_fork_asm+0x1a/0x30
[   18.631526]  </TASK>

In idxd_free() and idxd_alloc(), do not attempt to free allocations that
will already have been freed.

Fixes: 90022b3a6981 ("dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe")
Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
Cc: stable@vger.kernel.org
Reported-by: Bogdan Codres <bogdan.codres@windriver.com>
Link: https://lore.kernel.org/all/akLBL7b2h73pK0AC@ilogsc-qemu.local/
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Jingyi Li <jinli@purestorage.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/init.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 9aab57a4b13e..9cfb165a1569 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -572,9 +572,6 @@ static void idxd_free(struct idxd_device *idxd)
 		return;
 
 	put_device(idxd_confdev(idxd));
-	bitmap_free(idxd->opcap_bmap);
-	ida_free(&idxd_ida, idxd->id);
-	kfree(idxd);
 }
 
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
@@ -614,8 +611,13 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	return idxd;
 
 err_name:
+	/*
+	 * once device_initialize(conf_dev) is called,
+	 * put_device(conf_dev) will end up calling
+	 * idxd_conf_device_release() which will free the rest.
+	 */
 	put_device(conf_dev);
-	bitmap_free(idxd->opcap_bmap);
+	return NULL;
 err_opcap:
 	ida_free(&idxd_ida, idxd->id);
 err_ida:

-- 
2.56.1

