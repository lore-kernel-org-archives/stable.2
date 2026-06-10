Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C192DE6E3;
	Wed, 10 Jun 2026 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074061; cv=none; b=jrZ4d9IRnmepCLhGBnBPXNwYcHyKL0NYBAsGbUC6nmHXfLpchy0El7FDUB75Ilphsy/9eNodKzibQ66tGgiD22dzSU8omhxwanhlPce2nmCHWKs6apm4u9rD8wgz1gc7h62BWxheGSRrGjEGgEmzBoB2Jc6qKYF+mktFFnjqpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074061; c=relaxed/simple;
	bh=N4GrsXdwP2cIyGFN4HAZ3r9kiiiDRu/1rqdSh1SFEdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l6NW5PiMK726M5lbYloH+VETRkCjOIfCOJ0N3xckvfS2aGbt9l9LiUN0vY5SsrOBecGv8EekPcIRiuRRWw9GwWyvGnFkD+bqfovqG3JUGhp/9Uv96tU1wGHmATJDYFQ1qzydwqun3NKw6fni8E9RtcXNgFnKuZEyqUzQpZvZjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Iu6HMbDo; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Iu6HMbDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=k3
	rd9dBlWcHktU8MCBGhx9fS5lnuIgHP6AoLpSyV1xY=; b=Iu6HMbDoYO80Fccyki
	VTo5Z39Qz+quqA45Isxsar3RcZQTfd/4wfl0gwkWOMf1zFlks+OXSy/80s8PQyUy
	hTsAiAvzvHBIDFIUC2Y6R6pRhF4PGuqA6VwlqUbbewYpvJDoy4JsUyh7U658KgML
	I6wuCdOokJUkx2+54y3sqvabE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3v_5LCClqoxPwCQ--.9734S2;
	Wed, 10 Jun 2026 14:46:37 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: dmitry.torokhov@gmail.com,
	git@apitzsch.eu,
	Marge.Yang@tw.synaptics.com,
	kees@kernel.org,
	jiapeng.chong@linux.alibaba.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4 - unregister function handlers on physical driver registration failure
Date: Wed, 10 Jun 2026 14:46:33 +0800
Message-Id: <20260610064633.2837084-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v_5LCClqoxPwCQ--.9734S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryrZFWUAw4DAr1rXrWUurg_yoWktrbEgr
	W0q34xJws0krnxKwnrursIvw1v93WUGrWfur1Fqa98KryrZwsYgw1DZrn8Cw1vqrWSyrnF
	ka45ur93u3y7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMJ5rUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7g35aGopCE0ICwAA33

If rmi_register_physical_driver() fails, the current error path
unregisters only the RMI bus. The function handlers registered
earlier remain registered with the driver core.

Add a separate error path to unregister the function handlers
before unregistering the bus in this failure case.

Fixes: d6e680837ec5 ("Input: synaptics-rmi4 - fix function name in kerneldoc")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/input/rmi4/rmi_bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 687cb987bc13..ade57e2a7201 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -455,11 +455,13 @@ static int __init rmi_bus_init(void)
 	if (error) {
 		pr_err("%s: error registering the RMI physical driver: %d\n",
 			__func__, error);
-		goto err_unregister_bus;
+		goto err_unregister_function_handlers;
 	}
 
 	return 0;
 
+err_unregister_function_handlers:
+	rmi_unregister_function_handlers();
 err_unregister_bus:
 	bus_unregister(&rmi_bus_type);
 	return error;
-- 
2.25.1

