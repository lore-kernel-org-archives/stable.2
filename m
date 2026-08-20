Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51741A79A;
	Thu, 20 Aug 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230305; cv=none; b=jjtoD9dUEu5YGp3XLEkHYolAc6NqR0/t01RR36uhTvgfuFfRLqf90KooZX+lwIVvcSb7h3u/+sBdVd2PV09YlwQeG05mgTNF+efilG45EuvuLN5VTgQ3NTI8o4IKWErSKfcn+5vDMWErkMqmj34B0oYQPtbNul0BVADTIkPAD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230305; c=relaxed/simple;
	bh=5j2gBzM/H51adle+m2A7Vx/G3Gd64QINsSelGsYbVQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ndgj9Xffq8vmm+rtL2H+y2DB8NoxEJRJVArNsBAWtLwlGIaWsEimYSWt0DdyzbQz5As+1HZRlBXhhXIbmW/cHS6qDaAdZVaqpSIr0avYJ14HMkyXnJIsRpEKzF36LlLv5zDiaKnXWc/Ud9jV02CCZ5ZL6xycRwTPcz8JEivc1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=CKBSeoN+; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="CKBSeoN+"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ab7bc55b;
	Thu, 20 Aug 2026 20:51:34 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] wifi: wlcore: release runtime PM ref on regdomain config failure
Date: Thu, 20 Aug 2026 20:51:26 +0800
Message-Id: <20260820125126.12757-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01f3a12f803a1kunm33934bed16d31e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTExCVh8ZHUhKGBlKTR0aTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CKBSeoN+ycjwyEqANooCMPxqZvqlo2BcPWxisbqjoKSPQ5QHJ5WELJCLX4CYARWSAip3iSV3WlVM4EtWI3L80KtWG6fdQZXN3PY/0S5TFdXd98P/YV5YXQKmeMU81SM6fDGacsikzP9/4hPLav6MDfK/6FJawcPp8fiGX0nTAZg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=CrclmvZKx98A+mwNnAfiYQzNP8CQ75RCU53MeFgKZpk=;
	h=date:mime-version:subject:message-id:from;

wlcore_regdomain_config() gets a runtime PM reference before sending
the regulatory-domain command. When
wlcore_cmd_regdomain_config_locked() fails, the function queues recovery
and returns without dropping that reference.

Release the reference after handling the command result so both success
and failure paths balance the preceding
pm_runtime_resume_and_get(). The recovery worker takes a separate
runtime PM reference and cannot release the reference held here.

Fixes: fa2648a34e73 ("wlcore: Add support for runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/wireless/ti/wlcore/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index be583ae331c0..ecf55e34caae 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3726,10 +3726,8 @@ void wlcore_regdomain_config(struct wl1271 *wl)
 	ret = wlcore_cmd_regdomain_config_locked(wl);
-	if (ret < 0) {
-		wl12xx_queue_recovery_work(wl);
-		goto out;
-	}
+	if (ret < 0)
+		wl12xx_queue_recovery_work(wl);
 
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
-- 
2.34.1
