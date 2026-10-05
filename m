Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D037BE7F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187857; cv=none; b=SdkoHhy4oZcjTrDiyOAYrlzpwwDC68RQBH1VjqN2q4f8EV10ko/dRcXq1SwZLI0qYDYkx01H50lAlGPgphk7grTv7/7RvFlUeSYC4Bfud3ZUADaVtqNrzhnOJOA+Niy5G7YWf0NG7Q+aQHctjxQs7+TRNfarlS1F7xXxLJ017iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187857; c=relaxed/simple;
	bh=1fwMzgKS1yF3M8xow09J7i9kduspWFFlvSX+brSrv10=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tE6eUH45is5W2Zu0gMsyDSRGU7MLs8GzaIBt3wY6vu+jCuPX972vxyL4vhLUo9MpjiVpWCCEStS46dh0yRvrC3Vpny/eGZGKhcTB0FfUzv+j+3uAfkTSWFvi3p7MjGjzk8xdppkBt06WPaM82RFp4Hdv8na+0Bk3gcwUkYpHsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LV1cwjiT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LV1cwjiT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5AB1F000FF;
	Mon,  5 Oct 2026 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187856;
	bh=xD3RIQevL+YdVYZN0DPJHl4FJmKgkpy53DrqkaqeYrc=;
	h=Subject:To:Cc:From:Date;
	b=LV1cwjiTNh34ZMwrK9nSpq0T4hpmF+fFqnPcrmuWGYLKX0EvuZNHmY5SCm54vyd4a
	 HUXJ6EEYKBTLjP2V4c7U88qaKHB3qzWVPF4U4KzqImrIwaPDB25lZ9BCXGSs+Nbktm
	 UFB5nngRBDG1KCrN5d1DRN+rmShDfsK9fWwQ9Z1k=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix ACP MFD device leak on init failure" failed to apply to 5.15-stable tree
To: lgs201920130244@gmail.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:10:52 +0200
Message-ID: <2026100552-handbag-remission-3ce9@gregkh>
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
git cherry-pick -x f0013046151b7467e62c471c1c83d63ea255799c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100552-handbag-remission-3ce9@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f0013046151b7467e62c471c1c83d63ea255799c Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 18:33:18 +0800
Subject: [PATCH] drm/amdgpu: fix ACP MFD device leak on init failure

acp_hw_init() registers ACP child devices with mfd_add_devices() before
attaching them to the ACP power domain and initializing the hardware.

If attaching a child to the power domain fails, or if the ACP reset or
clock enable operation times out, the failure path frees only the
source cell, resource, and platform-data allocations. The child
platform devices already registered by mfd_add_devices() remain
registered and are never released.

Remove the children from the power domain and unregister the MFD
devices on failures that occur after mfd_add_devices() succeeds. Keep
mfd_add_devices() failures on the existing cleanup path since the MFD
core already rolls back partially registered children itself.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 25030321ba28 ("drm/amd: add pm domain for ACP IP sub blocks")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 63da68d6a2279ec945581c990c5a59a5ae8b5560)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 9014678d75ab..be4d00ac96b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -318,7 +318,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
 					  acp_genpd_add_device);
 		if (r)
-			goto failure;
+			goto failure_remove_mfd;
 		break;
 	}
 	default:
@@ -443,7 +443,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
 					  acp_genpd_add_device);
 		if (r)
-			goto failure;
+			goto failure_remove_mfd;
 	}
 
 	/* Assert Soft reset of ACP */
@@ -461,7 +461,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -479,7 +479,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -489,6 +489,11 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
 	return 0;
 
+failure_remove_mfd:
+	device_for_each_child(adev->acp.parent, NULL,
+			      acp_genpd_remove_device);
+	mfd_remove_devices(adev->acp.parent);
+
 failure:
 	kfree(adev->acp.i2s_pdata);
 	kfree(adev->acp.acp_res);

