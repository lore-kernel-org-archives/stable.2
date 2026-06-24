Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5E2ED870;
	Wed, 24 Jun 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290664; cv=none; b=G+yL96o00aUUrTwhVMmceP6cN7ACIb3slqsd2evEWdQjkZGD8R2dIjYvF8CwdR7k2NceKs+4swdSHxVv3CT14HmkdrJd7GyxkIZiEYcwLtgcFABxW9tJCUszXLqWbDZFsN4zGArafovM/W4sQKtnnMKSuUgJRYrL1+rDNE9pMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290664; c=relaxed/simple;
	bh=GiLBcw8TCw+pVIQKZkGejqL1bTdwhOul8NVSKDP3Lx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rq83CeKe+ilo0DC9U4DIuFWZxrBFEe9/EsN6PdNkPFmInUEBgK/HEv0HZeFCEKycUxeiEPXCEJDvkWsHv8s8np3jo6dPY2tuy+6Q6ap9uTwJrqmm8k5KfvvJSzHmP5nO1+zr93V3E53qrcK+Hn6AD/CdOdBF3G5s8LschQatqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=kzQ+1fdn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="kzQ+1fdn"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43926e916;
	Wed, 24 Jun 2026 16:44:07 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: miriam.rachel.korenblit@intel.com
Cc: tglx@kernel.org,
	mingo@kernel.org,
	jiasheng@iscas.ac.cn,
	kees@kernel.org,
	johannes.berg@intel.com,
	error27@gmail.com,
	emmanuel.grumbach@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dvm_start()
Date: Wed, 24 Jun 2026 16:44:04 +0800
Message-Id: <20260624084404.570703-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ef8cd079903a2kunm5ff92ad636308
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSE8YVhhJQ0sfSkxLTE5CGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kzQ+1fdnsm3AFFJ6Gl8toa4l6PtX+AkmQQI6hqWRy24LXBPElgAMf81sZW1/B8kKd0eLAS99z/Xwh6bj6a2YM5/yRUfyZU4KCavFNaEyh0I1yx8/6t0ypKnC+VrM43lOtgH0kGdCHCVrf7tWVcodWnxmuIih4exPFKq0B5EyFjI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=YjFfP6DtapMx5m8xVLPsWef0pIE5jMQeuP0d1YNaFjE=;
	h=date:mime-version:subject:message-id:from;

In iwl_op_mode_dvm_start(), jumping to out_free_eeprom currently bypasses
the out_free_eeprom_blob label. Consequently, error paths triggered after
successfully parsing the EEPROM free priv->nvm_data but leak
priv->eeprom_blob.

Fix this memory leak by reordering the error handling labels so
that out_free_eeprom falls through to out_free_eeprom_blob.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc6.

An x86_64 allyesconfig build showed no new warnings. As we do not have
supported Intel DVM wireless hardware and firmware to test with, no
runtime testing was able to be performed.

Fixes: 26a7ca9a71a3 ("iwlwifi: refactor EEPROM reading/parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index ca5a8140908a..6bd5b6d84b2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1511,10 +1511,10 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	priv->workqueue = NULL;
 out_uninit_drv:
 	iwl_uninit_drv(priv);
-out_free_eeprom_blob:
-	kfree(priv->eeprom_blob);
 out_free_eeprom:
 	kfree(priv->nvm_data);
+out_free_eeprom_blob:
+	kfree(priv->eeprom_blob);
 out_leave_trans:
 	iwl_trans_op_mode_leave(priv->trans);
 out_free_hw:
-- 
2.34.1

