Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825A4C6811
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070224; cv=none; b=Uz/GDWlQrWaL1Yu1+8z/Dau/lKbdlWQOtwvTAcA1CwiQTsMO+BgxjxEFedFtDCIk1iFkJujbfmudAV+KkFfLgvRz+sRlkEE75lIooIRWip/29/yZtUIH0UEHi3yiyN2bfKfdE63QhjgIYMT+PvFQd0WklhoN1aAFg6UuYL9rcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070224; c=relaxed/simple;
	bh=qcms+BeUwihqnDWy2qgytxTyUO0+G8vXXqa3ymcLMAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=auNUDbt/VVIxKpn2Ua6JJqUxfMtX3wfUz9o+4/NHd12zCw27iEuQkVREs+YNLtwRrkICkop7t+xbc6a/l43JU9iTzNUpU/QvGJHVQyqmxDEkARntCtOgIiabLkoDC0PQvMHRBmLdatFAouN/tbEOQJSW4lzvqeZivb3ZwJ9oRlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CIyWlw5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CIyWlw5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1520D1F00893;
	Tue, 22 Sep 2026 09:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070222;
	bh=Cyrqv5aWQf5hp/ONl/ZkPH9+XMWuAyr2eACKnXYDFAw=;
	h=Subject:To:Cc:From:Date;
	b=CIyWlw5WJFh4vX3EVSd6P0qt0EZDWgFJwuwlVR7+s6nDIfI30g0cRqIOKDCVSdL9M
	 atQuZzWQ8F2IgjW/xHCfI9cj4Xtdzlw6YtbpxryRecKLNVNub6ImA+fAbHrDuc6I0N
	 FylODUSQVZ3FYxeay/R33iDlvFrmCoZ1rc/f4Tho=
Subject: FAILED: patch "[PATCH] i2c: qcom-cci: fix device_node refcount leak in" failed to apply to 5.10-stable tree
To: dragonliu2018@gmail.com,andi.shyti@kernel.org,konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org,vladimir.zapolskiy@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:39:12 +0200
Message-ID: <2026092212-macarena-tidings-7d83@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7362a1553eb09a8cdf8be7e509bd5309a8342486
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092212-macarena-tidings-7d83@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7362a1553eb09a8cdf8be7e509bd5309a8342486 Mon Sep 17 00:00:00 2001
From: Liu Zhenlong <dragonliu2018@gmail.com>
Date: Wed, 19 Aug 2026 01:57:50 +0800
Subject: [PATCH] i2c: qcom-cci: fix device_node refcount leak in
 cci_probe()/cci_remove()

The of_node_put() matching of_node_get() runs after i2c_del_adapter(),
whose trailing memset() zeroes adap->dev and thus adap->dev.of_node,
making the put a no-op and leaking the node on every adapter removal
and error cleanup.

Use a devm action: the pointer is captured at registration, out of
reach of that memset(), and devres runs the put once on probe failure
and detach, replacing the three manual of_node_put() calls.  The
setup loop uses the scoped iterator form so the child node is released
automatically if devm_add_action_or_reset() fails mid-loop.

Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
Cc: <stable@vger.kernel.org> # v5.17+
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260818175750.4205-1-dragonliu2018@gmail.com

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 25b6e4e9e3fa..873e901a23d7 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -497,10 +497,14 @@ static const struct dev_pm_ops qcom_cci_pm = {
 	SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
 };
 
+static void cci_put_of_node(void *data)
+{
+	of_node_put(data);
+}
+
 static int cci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child;
 	struct resource *r;
 	struct cci *cci;
 	int ret, i;
@@ -516,7 +520,7 @@ static int cci_probe(struct platform_device *pdev)
 	if (!cci->data)
 		return -ENOENT;
 
-	for_each_available_child_of_node(dev->of_node, child) {
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		struct cci_master *master;
 		u32 idx;
 
@@ -537,6 +541,9 @@ static int cci_probe(struct platform_device *pdev)
 		master->adap.algo = &cci_algo;
 		master->adap.dev.parent = dev;
 		master->adap.dev.of_node = of_node_get(child);
+		ret = devm_add_action_or_reset(dev, cci_put_of_node, child);
+		if (ret)
+			return ret;
 		master->master = idx;
 		master->cci = cci;
 
@@ -606,10 +613,8 @@ static int cci_probe(struct platform_device *pdev)
 			continue;
 
 		ret = i2c_add_adapter(&cci->master[i].adap);
-		if (ret < 0) {
-			of_node_put(cci->master[i].adap.dev.of_node);
+		if (ret < 0)
 			goto error_i2c;
-		}
 	}
 
 	return 0;
@@ -617,10 +622,8 @@ static int cci_probe(struct platform_device *pdev)
 error_i2c:
 
 	for (--i ; i >= 0; i--) {
-		if (cci->master[i].cci) {
+		if (cci->master[i].cci)
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
-		}
 	}
 disable_clocks:
 	cci_disable_clocks(cci);
@@ -636,7 +639,6 @@ static void cci_remove(struct platform_device *pdev)
 	for (i = 0; i < cci->data->num_masters; i++) {
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
-			of_node_put(cci->master[i].adap.dev.of_node);
 			cci_halt(cci, i);
 		}
 	}

