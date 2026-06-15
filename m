Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197E4071D0
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539210; cv=none; b=RXoC3lx/r0Dyh/oQGa8ehc3gn8K21mYkP3CsDoxreONgm68GYPx4TlXzeVriddlCRhZQowBqnllIpOkS70tZM90CWg/b296YvvitCaHl9/jL/vPRxb1k8rkhWcYbUrXiaYF3iGKm2XFI44iqXNrgKSR8IfWA4JU81F1wXfetuaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539210; c=relaxed/simple;
	bh=vBJHLJ1tUVC9u9A6avejpz17HnaKHConIEBhHfmfz+U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D4s5xeOnaThZomkDfWBc90o4Y5bxYlEWUvyOIYUFt3FWIpcOZf/YYljV8AMLlg1BLRme2UFOXymSNS2TgQL3ADldaz/UZGkOr8G0gdiR8J3xNIhR3UkGBFgKg5o0g9WDiHXuz5B/Dp82KWQZ7iNdGyXRHzVVSUWRGYy39xI8zp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cztFNPB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cztFNPB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E732B1F000E9;
	Mon, 15 Jun 2026 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781539208;
	bh=b4yfFQnAqHNnYXLF64Gz73KA3qAmdFdKhyCEwmf7hRI=;
	h=Subject:To:Cc:From:Date;
	b=cztFNPB7u5ywN32a+vkpoYtmQscjsvvSvJ4yr/gW1KtDn2yvUkB05XClZ1FyWOSEn
	 p/taK0vBw4SSyFW8XwTberrppAg3wIs9po7vYQopaVZ5IrD2XRGX2+AeEZ9cfiivP/
	 0lZ6MsvMMRF2HnFJGO4JpYpmUeAYjLcYDi9KyzxU=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership" failed to apply to 5.10-stable tree
To: bjorn.andersson@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,mukesh.ojha@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:48:05 +0200
Message-ID: <2026061505-suspense-skilled-bd7a@gregkh>
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
git cherry-pick -x 960b53a3f76fa214c2fc493734ae7b3c5e713bbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061505-suspense-skilled-bd7a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 960b53a3f76fa214c2fc493734ae7b3c5e713bbf Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:44:17 +0100
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership

PDR and SSR callbacks are registred from the controller probe function,
but currently released from the child device's remove function.

The remove() function should only be unwinding what was done in the
same device's probe() function.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-5-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 6b91a6f11cb6..e9238927cd2a 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1683,6 +1683,9 @@ static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pdr_handle_release(ctrl->pdr);
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
+
 	qcom_slim_ngd_unregister(ctrl);
 }
 
@@ -1691,8 +1694,6 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	pdr_handle_release(ctrl->pdr);
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);

