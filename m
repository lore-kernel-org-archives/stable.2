Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737374B1B5E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070213; cv=none; b=Px1WX9IjMVg/qCoUe2n2MLK6l5XeEYD2HBKIMI3tn4Y7L5BzeWqG4Y1MqlzUskx/Ar8ylGV4zmWggYd0qWdEmJxZk+csdno6v9MFC+4QYPlCqbqBmsVoQr6OoIr3rb3ntIKvpJCNgXCCnvsmHmgdqD+icblbLOf2MZrXd6XGY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070213; c=relaxed/simple;
	bh=vaaZDvG5MhYwzTroQVwIO7jIr9aAcw+qAkRfUnQo7K4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V7WaxV8TmkaIzYt0ocLaN6ZrUNDJyKXpmMRrb190BHb/cYFbcRq4nWjXzlXuTsDV+jVyB5AUaN/IAMhiT2AooBME2hjVGpKAtmd5RCTs31k0o+PXV94iJQI6vot3tApHDld6g7SraNxIl+pQBxEArLrulX6uEvtbkLeerwGhLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l9wchAGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l9wchAGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CEF1F000FF;
	Tue, 22 Sep 2026 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070212;
	bh=eeZBUfNFl7L31Pc/LFilpakQGAqYqPKrK6v76+HmUo8=;
	h=Subject:To:Cc:From:Date;
	b=l9wchAGXchrGAeIRyYy1A6PPrDiCMV1FhMsMAueEL9YW22bsgaXAwdIHy9sW3lLj6
	 Sg72DY4aXxukmx7IPVnGhDpVr2UN7kNsYDlo29UDrQzTnqga3ibyTHZZkWr3j8otma
	 9t0J1ujBUKVoEztgYChppAzKB/0bc+lkI8zhuOwg=
Subject: FAILED: patch "[PATCH] i2c: qcom-cci: fix device_node refcount leak in" failed to apply to 6.6-stable tree
To: dragonliu2018@gmail.com,andi.shyti@kernel.org,konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org,vladimir.zapolskiy@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:39:10 +0200
Message-ID: <2026092210-vacation-hangnail-e82f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7362a1553eb09a8cdf8be7e509bd5309a8342486
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092210-vacation-hangnail-e82f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

