Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B90401A26
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538859; cv=none; b=Bswx19bl9290CU4nR/Kb8r4qi/EhGUUNxJ3bG2zknSNt+tWYKo91NyNh0K1rt5SQavA2VEjVXJE1gLr8/KdiFWr9E29uiafPuV3idkYCc8Uge8iUT1MapYIzugnH7WeK3iOROntP6NOC8YfzAVLk5+M7sTaURsAaf4p0K8ehSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538859; c=relaxed/simple;
	bh=VMPebKy9LpXggdZu/pk88CHvtXc5UuWH7CEjqGho9+U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SFag5AZooeg/Vq1jw5/YuNG3d5zLPIX1JjHNailsfs5JyMN9ofIv4Xdep5egKFqLD7iEDkqQeJwOhd6m9ApdaSKwFVs7uM+xYERln/j5vsYZtVFIqhvWBSyA/yIfcF1VVgtp+8obj1pXK0+dpQmvLZXCF6QZfcIY931QqS5te5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VUm+8pQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VUm+8pQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48A91F000E9;
	Mon, 15 Jun 2026 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538858;
	bh=kch5YvWIlPzoUx1g+jbVRDR2F9DbJjdIMmNNdnJNv5I=;
	h=Subject:To:Cc:From:Date;
	b=VUm+8pQ3B3/JMJvKtlNwKPUF7d6XQL140t2GA0Cg2FD8pzK4ZgqlRyoWodGXuT8Q4
	 bTJGYG1amxVUFaWsseL4W5vtxZzEhNoDS3+VlfPNgLDPuYpTnpXk8WvPRP0Ggj2u0Z
	 mp0IPvxIFMQ+/Gfrgr2ICQ7nenE9U4FxTLrEELBk=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership" failed to apply to 6.6-stable tree
To: bjorn.andersson@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,mukesh.ojha@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:47:59 +0200
Message-ID: <2026061559-egotistic-safeguard-3f23@gregkh>
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
git cherry-pick -x 960b53a3f76fa214c2fc493734ae7b3c5e713bbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061559-egotistic-safeguard-3f23@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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

