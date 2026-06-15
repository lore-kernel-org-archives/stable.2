Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A80E3C65FE
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538782; cv=none; b=C8boZY2FtX6TdTXkN3l5owBcFNWJyOwFsVNf/ROudlQ1Uc882jHTmro4uIG913aMgtk2DR+U45LA3RYlP9NuVF/UHYxJKInClL33IdiOUV2lNNUMlCZ/cNsxsEpTHvA9poRnayyz9wm8Hoq01fmO6D6qIXoHeQpbisszj+O2r/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538782; c=relaxed/simple;
	bh=WLog1RWFoTbcVQCiGkI1EpK/S7Jj1K5ucuTFoQkLBjE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WL0Gkky99G0scgtcPVdnhH+dihmKWz5BBgDXqiCZpGmb0lMmt7ENCAxNSAtsG34or05p7xwBIeQoyY7RYf9coI2SLF8afywsW9/TCVXIYlu7BVl5S4y9nM1H0xBxsXMm5FhA61tT18OUnEGHTmaXb4xs077rSs3Wt5ZBBQFp3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sbw2atpm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbw2atpm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386461F000E9;
	Mon, 15 Jun 2026 15:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538781;
	bh=703WJ/Rmh6fVxljlw/rvmu46KrwY3nmck4cY98c9OOY=;
	h=Subject:To:Cc:From:Date;
	b=sbw2atpmo7+8qPjND6dKrVIrK7Rb8KMM5iUOf2ZcMG6skEV6z5CbpkGn5hObkgmg4
	 1jpLZPSyp/TW3a6bneGnIsHvGGQhWj4Ge45H883owASnjx4jHxWWNRZqZ8SSJiXPNu
	 k+WsrvYH93B56pHFKpkMB6cbtCJ91SvspvA7nFCk=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: Fix probe error path ordering" failed to apply to 5.10-stable tree
To: bjorn.andersson@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,mukesh.ojha@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:46:49 +0200
Message-ID: <2026061548-carnation-ebook-f997@gregkh>
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
git cherry-pick -x 2c22ff152d380ec3d3af099fa05d0ac5ca9b4c1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061548-carnation-ebook-f997@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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

