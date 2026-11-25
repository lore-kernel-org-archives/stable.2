Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650570;
	b=cRg1qvi3fiBKuT/YT7xF5h4G1jjiRI9eBY6dOyFUK1spBew1pRQwVnQvbo8pBtdVM52c
	 xnedfDTTpEeTN3kyfcFM8lmwnJzH9W0PoYdGdCEV9/3RNFT6x3A7P2vVJG+1+UlnPtUPD
	 gkY37KjTgmhEs/yY3KtnycLLYwBbWQrngdJOfad2tj1DJxrUHVgsTmbcrSslkyRNddpu5
	 bIiT4CyICT3/T95jiC3DXKI3kn2TbMHz33VLdbR5Xm8kJeqwNrQgkao8Q3z+FVxaw2GrN
	 Id9+lXbodlB35qFjzcEsBuMt64aNmPtMxAHd3a1BU29Tm3j8aJ3p0u59m26eHxNtKTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650570;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7HtGnJnZlXFdKtXwlC01u9cCWu6muls4sUIznBIvpoA=;
	b=L1fUXJGxiw9P0+uisP42WJiXfqvAyki/bCjNb43BPTyQC4YelFHXYiudMqeeM1Y5YgXn
	 lseOFZjE5dMHBd+2ePfZwPoXDW64MSAkcIZPba6XwzIZs0FIhWKGscwm1bkTcRCYfEZ3/
	 ThfikJiFKZMaj1CvOo65q+d5RPNaoEkjFfbDy6ON2VHYkqejYLBuy1KmyQXP5fi7wGV8w
	 O3a+XOa5epaCdMEpSeMwcGS45tKDMABcx1dKKOvIh66AADiRNrzyDmXspPGFiXEAivqYa
	 KHV5Gb3OgvmZMHanq8ryUL0zFt41D9aHTkmqx+8geBQf6Wtkqj5qyDXTcmK89wr+zNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NrIykf1l;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD79606A329;
	Wed, 25 Nov 2026 23:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD79606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NrIykf1l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795650569; x=1827186569;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=raTuH5c/whF6TaLa89zWVr31QUkpI8tWAtrqoUC5Rdw=;
  b=NrIykf1lilKsqpGYSFYzg7nPGV09R0A9IEsX4VImgNPxLewPuHt6zMBh
   6SEEWPli/sVraGQ7T0i5VyywfB8hDn8Ct06gRFHT3iywV60h75d8VnLY8
   aiFwSmmZRHuCVN+UV9hKgbIwv3n7f56yJZ7x2ELhzWlHvNpE/Q7hz8V2A
   iQ11nONXr8ZAE9/CW0Coa8qWhLZ1QarmfrRYKyzJPjHSUMldtxsTkRhBQ
   rOdHj6SCtoj1JxOKQE03Iz/mEcZZvXbJwJHwszXqDTkzHsj34p+vvHQxR
   ADGLx3CMggCL2CgFeRNjpuKYZrQ3IkDKLxpimrhTAXgkp9R0i4F/+ClPv
   g==;
X-CSE-ConnectionGUID: ESobvXdJR0OnkHJxJyHNQQ==
X-CSE-MsgGUID: WwbuG51ASg+nfxqPVm70RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4597267"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4597267"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:28 -0800
X-CSE-ConnectionGUID: GoY8uU8eTT6xpcDacC9uNA==
X-CSE-MsgGUID: 8q57URnUQyq7b47PZfaREg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11873823"
Received: from vcostago-desk.jf.intel.com (HELO [10.241.240.61]) ([10.241.240.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:27 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 25 Nov 2026 15:48:59 -0800
Subject: [PATCH v2 1/8] dmaengine: idxd: Do not call destroy_workqueue()
 with null idxd->wq
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
Message-Id: <20261125-wt-idxd-fixes-v2-1-25a4691dfb9e@intel.com>
References: <20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com>
In-Reply-To: <20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>, 
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org, 
 Jingyi Li <jinli@purestorage.com>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795650562; l=1414;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=6WOGHYo6AnLl1RLhrcIxZvPo1XTURxj0Ljrgy+kyONo=;
 b=bG/l5A8T5sMdFELYpiCzT3kc4xGrNH3q3ZKxpQERaaKpFQtJk3n22JH6ea9U1DmQmNQqeV0r5
 x+J/tUJ7UXeBlc7sBXpUt+TOHt8vn9WRUYmJee/HqjXzDsILjt6Iu+G
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

From: Steve Wahl <steve.wahl@hpe.com>

Error paths within idxd_pci_probe_alloc() and related functions end up
calling destroy_workqueue() with a null pointer, from
idxd_conf_device_release() via put_device(), because that allocation has
not yet occurred when the error is hit.

This was encountered running in a kexec'd kdump kernel with reduced
resources, causing the "Device is HALTED!" branch in
idxd_device_init_reset() to be taken.

In idxd_conf_device_release(), check that the workqueue has been
allocated before trying to destroy it.

Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")
Cc: stable@vger.kernel.org
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Jingyi Li <jinli@purestorage.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
2.56.1

