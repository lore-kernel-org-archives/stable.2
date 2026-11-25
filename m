Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650570;
	b=uJwHcAcnZzB0VtkFifSjwLyvIMMGlPr8SbIhvKI/vMZ8lRlXAxshRlPxKoygSEp/mCM1
	 XjyCPbeje9SzIujKkoS5FD8dvi6Q/F/KQ7CkYFgVLUeNfQQ80Dsvyg2DHXsSUY+hXJKLM
	 +rvMYEfCuPj5zVarxa/EfoSHSF/gbIh+ZinombkYo6RPAZ5GLpiHQY44/aRMNxJFIZ9lm
	 hWrbVh291PN7W+Zj86VwaZtvKUzsPpUXbmF7IeB6/XbM0/+6h8hypAUXnALEdldepGOwL
	 m+WylV5lYvAcVmOR6OUr4Vg8ltgKfj1oyLGjA2Zdb3OgKiz588/YZEaAMJoa0QG1VJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650570;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=//jSv38in97jXiZhb7nD4WEwTRtFGT+yyMUQcoXMpi0=;
	b=xp8cbY08cAr4SOZzAANJvToixL+JJ3OhhxQ8IxFZnvvjqXw5ossSrLAXUm3jjuFtidoG
	 4Z81RlYAsOeDgL1WcoRVosWkp/M4AVcSx2WDBQC+E6ISdUtwUz5z8HKBchc0+kVk+IsHJ
	 tKsB1L8xjmvpXN0Mv5U+kHx6qhGfS8HejhLmIZzAnVpX0RdOiJxGSoxso2SR7gYalGWgB
	 G8Uku/Qif57tBPb5zUW7QgJ4LkX4+Jzd/nroCo90RD35D/mvX1IM47A985gev4fCPkJM4
	 Gufub/0nimZd767vuPFkEz0flWJtC76uK8YAN0DAgDc/VkcBpE9w6DGyuzBGLQCIRow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L220ukWZ;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC98606A32A;
	Wed, 25 Nov 2026 23:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC98606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L220ukWZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795650569; x=1827186569;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=k1LkwI/j9KiaGc78Nbo0zSK7quEc1h77slSkpIBuguE=;
  b=L220ukWZ0wCaPrA5tP1oMhKwJOOABHJeMNu6NWGlOCta2b4zVOQttPxI
   PMdG8VHaEv/Dh4D2M6+QPP1FnsGBn9y/iXRzHKYusrF87GDYt8VjPo+ze
   XnbbKqXIl4AurYjJs9gGNLM9SGjVElV3yUJi/lObn9o9Sf/Sja9xzlUzf
   tJHePL+3ax3P4DJXr0pZf+cUzULo23pc26/Qm0TBdewEi0jo7RxjS0v6J
   jykZvUEhDR/Z4fxerz2zQAFlnfIn2h9B4dxSDC1+cJh/ZjsXcIt0cPfGk
   /vPwsfDXn8O7xv4T/edI180O6qpjv44W1ZtR4wiRDI0Hglu87iCxlGX36
   A==;
X-CSE-ConnectionGUID: Qn8sNu8UTFm0fo4xBNbq5Q==
X-CSE-MsgGUID: jdXJ+PyVSy2bA3CV9GoTrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4597275"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4597275"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:28 -0800
X-CSE-ConnectionGUID: W0QflOi0QHGY3vghU9PCNw==
X-CSE-MsgGUID: PxKeuMFjT52MsdGoFTcwHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11873827"
Received: from vcostago-desk.jf.intel.com (HELO [10.241.240.61]) ([10.241.240.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:49:28 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 25 Nov 2026 15:49:00 -0800
Subject: [PATCH v2 2/8] dmaengine: idxd: Fix potential double free on probe
 error path
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
Message-Id: <20261125-wt-idxd-fixes-v2-2-25a4691dfb9e@intel.com>
References: <20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com>
In-Reply-To: <20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>, 
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, stable@vger.kernel.org, 
 Jingyi Li <jinli@purestorage.com>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795650562; l=3356;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=k1LkwI/j9KiaGc78Nbo0zSK7quEc1h77slSkpIBuguE=;
 b=9DckCD/vL3Acnn7We8N3sI73XtGdwW0/Q7MesMAHRuc6o0qDxNLM6ff1nkFc/GRzGI8BX2Dcf
 IiBvtXNmqHOCsowfdfO7yXK5uCFO/apy0JaTSZg2XjMTY+t/RujbMQp
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

On the probe error path, put_device() calls idxd_conf_device_release().
It frees idxd->wq and the wqs, engines, groups and wq_enable_map arrays.
idxd_cleanup_internals(), the idxd_clean_*() helpers and the
idxd_setup_*() error paths free the same objects again.

Commit ec2d428b2e32 ("dmaengine: idxd: fix double free of wq, engine,
and group structs") removed the duplicate frees of the wq, engine and
group structs, but left these. Remove them.

Keep flushing the workqueue in idxd_cleanup_internals(). Work queued by
the misc interrupt uses the registers, which are unmapped before the
release callback runs.

Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")
Cc: stable@vger.kernel.org # 6.6.x: ec2d428b2e32: dmaengine: idxd: fix double free of wq, engine, and group structs
Cc: stable@vger.kernel.org # 6.6.x
Link: https://lore.kernel.org/all/20260615103932.61828-1-bogdan.codres@windriver.com/
Tested-by: Jingyi Li <jinli@purestorage.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/init.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 4b827a329756..9aab57a4b13e 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -166,8 +166,6 @@ static void idxd_clean_wqs(struct idxd_device *idxd)
 		conf_dev = wq_confdev(idxd->wqs[i]);
 		put_device(conf_dev);
 	}
-	bitmap_free(idxd->wq_enable_map);
-	kfree(idxd->wqs);
 }
 
 static int idxd_setup_wqs(struct idxd_device *idxd)
@@ -245,11 +243,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		conf_dev = wq_confdev(idxd->wqs[i]);
 		put_device(conf_dev);
 	}
-	bitmap_free(idxd->wq_enable_map);
 
 err_free_wqs:
-	kfree(idxd->wqs);
-
 	return rc;
 }
 
@@ -262,7 +257,6 @@ static void idxd_clean_engines(struct idxd_device *idxd)
 		conf_dev = engine_confdev(idxd->engines[i]);
 		put_device(conf_dev);
 	}
-	kfree(idxd->engines);
 }
 
 static int idxd_setup_engines(struct idxd_device *idxd)
@@ -308,7 +302,6 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		conf_dev = engine_confdev(idxd->engines[i]);
 		put_device(conf_dev);
 	}
-	kfree(idxd->engines);
 
 	return rc;
 }
@@ -320,7 +313,6 @@ static void idxd_clean_groups(struct idxd_device *idxd)
 	for (i = 0; i < idxd->max_groups; i++) {
 		put_device(group_confdev(idxd->groups[i]));
 	}
-	kfree(idxd->groups);
 }
 
 static int idxd_setup_groups(struct idxd_device *idxd)
@@ -378,17 +370,17 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
 	}
-	kfree(idxd->groups);
 
 	return rc;
 }
 
 static void idxd_cleanup_internals(struct idxd_device *idxd)
 {
+	/* Queued work uses the groups, engines, WQs and the registers */
+	flush_workqueue(idxd->wq);
 	idxd_clean_groups(idxd);
 	idxd_clean_engines(idxd);
 	idxd_clean_wqs(idxd);
-	destroy_workqueue(idxd->wq);
 }
 
 static int idxd_init_evl(struct idxd_device *idxd)
@@ -459,7 +451,6 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 	return 0;
 
  err_evl:
-	destroy_workqueue(idxd->wq);
  err_wkq_create:
 	idxd_clean_groups(idxd);
  err_group:

-- 
2.56.1

