Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5235B632;
	Fri,  4 Sep 2026 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500965; cv=none; b=aiK1S3L0ZFLpAECO1/X6CLwWiODnPXijvgNAM0ZEtMk7X3VbZnZhfatGd7QrzfqW6RON4dpwgSJsKtzrUWWh+maeh/9g2cduMRf1d6GzgvxWbgRTYM9mQ5Ai7kfe0zLm8kqLnTdCHEE7EOk2uqK14WErZxAolmQm2o3xtjV46Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500965; c=relaxed/simple;
	bh=TuJKJ4Tc+45DBTyg/ZThJkLDHFvanAWq72oWJ2WVWq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IU72HG1mNJvZSr5LyfBsmzyB1jsCnqa+AmpTblZklI6eFkhNMIqogS/kMSc5JTi+q4ryXWJOgyjkXq4Q+EkDTj1VD8OAlEiYdB0+zpUJOg61luA3l5irNoW1gqnn1GQTgeU5Dznr+dK9oxr8nTXhlQD8nNXWSKhiC9JxZv9ekdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hu4RnFWK; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hu4RnFWK"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c83fb2e3;
	Fri, 4 Sep 2026 13:49:17 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] ipmi: si: shut down timer during interface removal
Date: Fri,  4 Sep 2026 13:49:11 +0800
Message-Id: <20260904054911.4028753-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06af6d83b03a1kunmcfb47f7f29bc3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHx9IVklJSkpJT0tCHh9MGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hu4RnFWKl+OV0eDf6+rW9AWTppDnTz3RmUFs5J3gnRcwUf3TAZpm+wORDvx3Se5Squ+Cvbw4TA/a2ZOCboGX9s0NIc0Y2ehv8cQwzT6i0yhGaNzIeEwdm448vtxTumyh8w/D1AIQDO3or1L5YWJwACasHQs4U2yh3uFWhnQytjY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Irbom3G+eWRrH6GTGI6Pfvw/8/hjNqkGLcoBbw/w5XA=;
	h=date:mime-version:subject:message-id:from;

stop_timer_and_thread() is called from shutdown_smi() before the SMI
interface state and its private data are released. It currently uses
timer_delete_sync(), which waits for a running callback but does not
prevent a concurrent smi_mod_timer() from rearming si_timer after the
delete.

Use timer_shutdown_sync() so the timer cannot be rearmed after final
teardown begins.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/char/ipmi/ipmi_si_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 9a9d12be9..6825cb02a 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1913,7 +1913,7 @@ static inline void stop_timer_and_thread(struct smi_info *smi_info)
 	}
 
 	smi_info->timer_can_start = false;
-	timer_delete_sync(&smi_info->si_timer);
+	timer_shutdown_sync(&smi_info->si_timer);
 }
 
 static struct smi_info *find_dup_si(struct smi_info *info)
-- 
2.34.1

