Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA73BB12C;
	Tue, 28 Jul 2026 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225305; cv=none; b=C9g1lFPjPaHhXWZgyFEDKpDCaFZFOru7WmCqdP6/8HoJ/s2RYSw06ciqgPNSZfkKBYxKuIO7D2CJkS44CmAGvYVHUezaODaEvh8+auFTkiAPYOQCJc8GVmzuRlfx+q40k6GBuCfMihrc1Y3GD8YL43hsTgCAax5BGQR0Wb/aUCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225305; c=relaxed/simple;
	bh=Y484+uxY5rWIWEhHq0r1QQR6om64ZafQaS1E8+IvRpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2X66D2hEeZIJatIU9TD6POh1npl2zMQJZb57+5HKeAjbJV/K3Jx0hmQlrbHXOE8P1fd4h2mFBp97Scag6H5RtL4aDENhNwAMZQB9bFl9IrQX3XeYLfMFR35LOSh+q5RCwvaJOFIeLEhDvxkc7ENklCngTS/9vHshCc2acLbvzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Gj21uGr8; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Gj21uGr8"
Received: from LAPTOP-99KJFSET (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47d71b6f6;
	Tue, 28 Jul 2026 15:54:58 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com
Cc: jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] extcon: max8997: cancel cable detection work on detach
Date: Tue, 28 Jul 2026 15:54:58 +0800
Message-ID: <20260728075458.1291-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa7b83f9d03a1kunmc38f3170e6277
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEoYVkNPT0hNHk9OH0xOQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=Gj21uGr8QaF0aQPdpPxx8hmGCpfqsQh0TAVAmT3DGAbH2xldxcGL3mvOKogqrwWNEl8Dmv+vAiETfr79fyLzW2I+9wf4CivOvxCpEPqza3VMSBryV4KZ+oh4PfAiM1V2tgj1xwVavKSCOqwwLAASxOLeC8kkrNmTVtrZWlR4Zok=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=zDaCSv72C7C6v9bCKzvXfoe+b3BQRytu8UWRK8QCg8M=;
	h=date:mime-version:subject:message-id:from;

max8997_muic_probe() queues wq_detcable after the MUIC has been
initialized. The delayed work uses the driver private data and device
resources, but the driver has no remove callback to cancel it. If the
device is detached before the delayed detection runs, the work can run
after the devm-managed data has started going away.

Initialize the delayed work with devm_delayed_work_autocancel() so the
work is synchronously cancelled during device teardown.

This issue was found by a static analysis tool.

Fixes: b76668ba8a77 ("Extcon: add MAX8997 extcon driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/extcon/extcon-max8997.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 9cddf08e069..631da543dee 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -754,7 +754,11 @@ static int max8997_muic_probe(struct platform_device *pdev)
 	 * After completing the booting of platform, the extcon provider
 	 * driver should notify cable state to upper layer.
 	 */
-	INIT_DELAYED_WORK(&info->wq_detcable, max8997_muic_detect_cable_wq);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &info->wq_detcable,
+					   max8997_muic_detect_cable_wq);
+	if (ret)
+		return ret;
+
 	queue_delayed_work(system_power_efficient_wq, &info->wq_detcable,
 			delay_jiffies);
 
-- 
2.50.1.windows.1
