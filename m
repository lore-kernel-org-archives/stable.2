Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B544BB806
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446474; cv=none; b=t4dU85kPZHS5lANzC71WN7hTQcwz7bVeNifGRwjd6OYaOF4cvY8w081cN4X1LMV1WPXD+5sic2rr/Z/XrMgi4hsmMpWlUc4FtR9gft0tf1HYRTx583ZTRlTNeumxho7TRHxC3lWpcd4xQe2J8Rp7Q0++M/nessTy9sMtg9aZREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446474; c=relaxed/simple;
	bh=BHh9kznJQ6d8QoL+k+x745K7QXZkH8eHJrf8CbE78y8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SUqZdlHzXInZ2wQMrayMs6CmG6raYF++RV59/+ZZ3foDste5gqWMjv5k+b+gtsIYbDDOcaov4aB4o31HP0a6Lb+3n2wqpHaLYEo9PDR/Bej2sBAfJMe/5RYSp+s2kNerXZK+Q8UZynAFLjw+WMsaaTFKahj6pF6zXXKIpoZ73CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqQZ61sP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqQZ61sP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4E81F00A3A;
	Thu,  3 Sep 2026 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446467;
	bh=HTCruQFdydyB0zWMvss8Vz+MmYxxGVRwIOGs+O92pqI=;
	h=Subject:To:Cc:From:Date;
	b=qqQZ61sPFJb9WqgtDZdGwKtKTGp2kiDvT6YPndosfSTbJl4gFrX2/bHdkR986grJA
	 CMBdLY4vAUyKDRkAhagD2Y4xhor84NCZx37ukjiJ+7I7lXSiP7f75qs5y5XJwpTh8g
	 vEPnyVRttKPSb1GsnKxykfqckzsomeZTRga05jK8=
Subject: FAILED: patch "[PATCH] remoteproc: qcom: pas: Guard dtb metadata release with" failed to apply to 6.18-stable tree
To: mukesh.ojha@oss.qualcomm.com,andersson@kernel.org,dmitry.baryshkov@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:20:36 +0200
Message-ID: <2026090336-enticing-sandstone-d55c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c06c5ab4945392d2c2aded6d832ab6b58cabe351
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090336-enticing-sandstone-d55c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c06c5ab4945392d2c2aded6d832ab6b58cabe351 Mon Sep 17 00:00:00 2001
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 23:58:54 +0530
Subject: [PATCH] remoteproc: qcom: pas: Guard dtb metadata release with
 dtb_pas_id check

All other call sites of qcom_scm_pas_metadata_release() for the DTB
context are guarded by a check on pas->dtb_pas_id, but the call inside
qcom_pas_load() was not. Fix this by moving the call to the guarded
block.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 29814986b82e ("remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260724182858.1868271-3-mukesh.ojha@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index fb633c2b823d..507c7008663f 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -245,17 +245,14 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 		ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
 					pas->dtb_firmware_name, (__force void *)pas->dtb_mem_region,
 					&pas->dtb_mem_reloc);
-		if (ret)
-			goto release_dtb_metadata;
+		if (ret) {
+			qcom_pas_metadata_release(pas->dtb_pas_ctx);
+			release_firmware(pas->dtb_firmware);
+			return ret;
+		}
 	}
 
 	return 0;
-
-release_dtb_metadata:
-	qcom_pas_metadata_release(pas->dtb_pas_ctx);
-	release_firmware(pas->dtb_firmware);
-
-	return ret;
 }
 
 static void qcom_pas_unmap_carveout(struct rproc *rproc, phys_addr_t mem_phys, size_t size)

