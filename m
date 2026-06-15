Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F4407CF5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538765; cv=none; b=YEoRRvG3+0ncKLbPRkM/0q6DOsZWa5ZUdGANvm52164J1G31CPxJBorg4Nfhz+cVGZFNMMMfYXDm4Z/IejhwLA9ThDBGcgN4JfctSOaW4HeXnhkeFWO/hTDAV7DiCnZAXTHyyE5tcLF8jCsH1bdXGdYQLcHEy+ew68irrEJbQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538765; c=relaxed/simple;
	bh=JzYExVcubdZM6fTQatyOw17QOW9iax2cuIr+1TVXOuA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZyTm0HqwS6nT8fsJcYPNLnaa4Mob81zemaamOuMEOk9UThwyC4ELYQYMOlJXLXjMSV3eDhh3zvqvEokB/JHplP+Zl0RB4sMzp0mYUlXKUj1XcRzEBJ6mHL2BZF2hZF+0tfO62GMEJXSY7CFbLkbil6ScGSb0w0qD6jiNQvm/gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zPo8jIkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zPo8jIkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4811F000E9;
	Mon, 15 Jun 2026 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538764;
	bh=DU//LQDj9ED7TbY4/JlaWc4SYw4lquOst9/XxRRrLnY=;
	h=Subject:To:Cc:From:Date;
	b=zPo8jIklzs3QHin+MLbAc4FxG2WQPz0r58GymJxjVZCkhdf+nTW+gqEV3vUtLpgr+
	 pj/wEk3O29IBPb3Y00o87UaV/ACr8V1lU1F1BQXXFmHeI+TQGDEde6xfCE9AIQxGM0
	 IPB41AQg5paXagKaNkBi59LwuqAaRUkqAg1FTb7g=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: Fix probe error path ordering" failed to apply to 6.1-stable tree
To: bjorn.andersson@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,mukesh.ojha@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:46:44 +0200
Message-ID: <2026061544-gecko-venus-a2f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2c22ff152d380ec3d3af099fa05d0ac5ca9b4c1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061544-gecko-venus-a2f4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c22ff152d380ec3d3af099fa05d0ac5ca9b4c1e Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:44:16 +0100
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Fix probe error path ordering

qcom_slim_ngd_ctrl_probe() first registers the SSR callback then
allocates the PDR context, as such the error path needs to come in
opposite order to allow us to unroll each step.

Fixes: 16f14551d0df ("slimbus: qcom-ngd: cleanup in probe error path")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-4-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 47ba9fb34d25..6b91a6f11cb6 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1660,22 +1660,21 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->pdr)) {
 		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
 				    "Failed to init PDR handle\n");
-		goto err_pdr_alloc;
+		goto err_unregister_ssr;
 	}
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
 		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
-		goto err_pdr_lookup;
+		goto err_pdr_release;
 	}
 
 	return of_qcom_slim_ngd_register(dev, ctrl);
 
-err_pdr_alloc:
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
-
-err_pdr_lookup:
+err_pdr_release:
 	pdr_handle_release(ctrl->pdr);
+err_unregister_ssr:
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 
 	return ret;
 }

