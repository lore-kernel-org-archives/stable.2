Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF90D27E056
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539217; cv=none; b=bpxHoSAFQDNKzi61iLn04uc40eK4fIPieYVaq1WG1bR42c+N2uJ+dYEtZL9cxCzEygJAczziSVYOXE07YFOp/+Jg22WFz51TtFIy6tHhadlar/9GPzKJwEe95i68F4O0xo8Utc5VDAxRub935l4m4E0pM2X6BSRoIb5AOSH9w6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539217; c=relaxed/simple;
	bh=ou6Ewuod0UNxk8m1HnVzWleIpMI7jNEHyw95DAEvIw0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sGYyEM/4qXQsKEjxSF4r9NcIlV4T7qg0Ez/zsxOieUzzrDz39LZkZHdw8IV/ny+rYae3SmXDNlINfDcOycnJHkdQMlg8c2KTUbp5YVKQfHKok5Mnkjbml587FKBzaQEUWPoxYTHxOeiHaWd9ugzCiYMhJPFkW5F9jdbbDkl6nAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LZmU9fwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LZmU9fwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE9F1F000E9;
	Mon, 15 Jun 2026 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781539216;
	bh=dSxiH+vvUzcjZ2MF6hi8seFRDqw4EYfgYVB20vuNzA0=;
	h=Subject:To:Cc:From:Date;
	b=LZmU9fwCovdiSRtlaWP3w1qGDXozyErwg2+Lk0/IHZWVeGBIk+PVw2fv0Lm/SMjlF
	 hJDbC3aPr531Mlj3xMi729ocncEGhs34E5YOJC0RSPg/ZoEwzg5mMZCmCaNLPv+Snt
	 er/ZMFcUXUJQVeSIn9C5pchnPSK41A3Em8tROyPk=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD" failed to apply to 6.6-stable tree
To: bjorn.andersson@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:48:25 +0200
Message-ID: <2026061525-skillet-catfight-64c5@gregkh>
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
git cherry-pick -x 6a003446b725c44b9e3ffa111b0effbaa2d43085
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061525-skillet-catfight-64c5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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

