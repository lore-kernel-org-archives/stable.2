Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184F4071C0
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538876; cv=none; b=StVgoDpcUmsT3E8dam9dV8zktMukn7Gq1oy8BT+ejfp7/Xg+ksXoKiKOgcsvySJO3/dzPK3hZOcl42ZiH2CE9GnlXaxOCODmZR8drUBxDlw8nTb8iKNceSQ0zfK5wIDXOu8RZPQrRoDSPDU5xXoa9Nh1GGmiZV7DyH4NS7wmD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538876; c=relaxed/simple;
	bh=V/oM1Z315MXC6z/cUbwSRS5U4xKytXdIiBefvracecg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VRTwD8GQ/hqscyOK254OTryai2aMfDMIGBIAJHiQPGWMzA6yYbKp7YenY7KW6FDXF4D4qxHAhYIwgrEOVpVH2kdIKc86BwGGf6vW003vzUhU54zbOGbOIVwHNtf9jy97XUUd4+TGlnHu76iTxihrp8Z6dgzkv/dHnzl3T45T/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g/onQULG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g/onQULG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5E71F000E9;
	Mon, 15 Jun 2026 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538874;
	bh=YYnZNIc44qv+rG0ZiG/nolQjG3z6LVR8oOwrhpeg3/c=;
	h=Subject:To:Cc:From:Date;
	b=g/onQULGcfQ9i/IgTcRcH38QYKXB9mVdnj4uVYJbKiL5A3f/8f9MF5Dpba/a9Ne9o
	 k/1boUCl+bufoikjsSbiAbMwI2gt7DPe9lInBureF11keywZ40lIZo4qOuEiYtaxev
	 6GkghgCeO3iLgeaB9RxgQuV2FN5m6r7Phw5YGEaE=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership" failed to apply to 5.15-stable tree
To: bjorn.andersson@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,mukesh.ojha@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:48:03 +0200
Message-ID: <2026061503-giving-duke-14ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 960b53a3f76fa214c2fc493734ae7b3c5e713bbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061503-giving-duke-14ef@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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

