Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFF296BBA
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539243; cv=none; b=Nyx1cbptEv3x2+B334OYwwf8UqENy7dPy4I+m7GF8JDzPSukjipDKbLHWrFv+AG07zCtuWBEPx/9huaPKEoT7qgXY1CikWxyj4t+7gRzBLwLLpxGl6SiFA0UqxFdmbSfrrXI67WnTAHUECF9sl3oG9w/KZyPf6VqkCW6ZrRDeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539243; c=relaxed/simple;
	bh=NioMEZbLZzSruD8M0yKGga8aTsM2NPhyyoqquVZTZ48=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fcdUJ95qjQprzpmvgqdgZD+u5VIpFS/cWvi+1f8o2IJc9kU8Poxvhz9nlB86rPgddw8I/Pe6JEuwsuMiBFXoWorydlkZIJ6CDNFKpxChgtMirT7OqQ3yI0yverPw3oGUR+GworqXdICJoLgNkbyfuvIOScyWjeVV/NanRmRmGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDMhQ4Bx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDMhQ4Bx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246E91F000E9;
	Mon, 15 Jun 2026 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781539242;
	bh=XZ9uQjdI2Y65/etke9CV8R+egRCbh/pc3WLT0jMzG64=;
	h=Subject:To:Cc:From:Date;
	b=gDMhQ4Bxc7vQXSM6qpfnZRavLT3FZQjavLBcdP1ADoqHMRdd/m5e3RcyV8UkWzILm
	 hlZx581HXSJFdSGoPwpgVK5AXSl9b00TTvFxVA95oey+TfBPx4Z3yfUiNKbsW2V/tA
	 qsZrZZD9ABGE0GYlvy/hU6DDfFJiokLOrJ9Ci5Cs=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD" failed to apply to 5.10-stable tree
To: bjorn.andersson@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:48:31 +0200
Message-ID: <2026061531-grit-reps-1ea2@gregkh>
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
git cherry-pick -x 6a003446b725c44b9e3ffa111b0effbaa2d43085
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061531-grit-reps-1ea2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a003446b725c44b9e3ffa111b0effbaa2d43085 Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:44:20 +0100
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD

The pm_runtime_enable() and pm_runtime_use_autosuspend() calls are
supposed to be balanced on exit, add these calls.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-8-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 540a62999655..8b207efeadbc 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1582,8 +1582,11 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
+	}
 
 	return ret;
 }
@@ -1696,6 +1699,7 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);

