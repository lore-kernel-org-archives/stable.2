Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987104B5CD8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446470; cv=none; b=VAfF/2jdc2+XoIcfAY/GGkODu69l9MBdvba2Rd144UwV3W8QDshSrPfUm6+muRxn9Rh4aXVwV9XzFhtSZOy6Y2IGQMnz8YysQ4OmsI+hPWUfWBzZJGizR92k7sRQ6NngNVL9/vq5dyT71cZMczhEwYz3q/AwJHxS0vdSQ/Cljmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446470; c=relaxed/simple;
	bh=UUjWtgRNEPgnRzZTzN98sobIPwl9Gn/KZZpOAtUoRHY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PaIJhW4gr7Mz+qqrjOHcF90L7YaY4Z0DVk+EDYMmpl9HBmloZMnuTW3L5dyrz7jrtIZi8KUdxnRwOERGTLbEJ7hd1P/5xH1H8gOILhS5BIRBtsbdLF/+u9A0UTyQujaUY1zgra3P3tF9JQT6da36Q03JTPpy40BOobGBRB44e6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sENAReBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sENAReBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B486E1F00AC4;
	Thu,  3 Sep 2026 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446462;
	bh=DLVcEi9bK52Ip52VEl5LiYzB+cZWBm5UpEqsJ+HFhpI=;
	h=Subject:To:Cc:From:Date;
	b=sENAReBGOCGMHN6jPNbDdoiGLoRx70kb06QEOhpruJQPoE9tdildYPtFTZOCCCih8
	 j/8GTJDXJfwt0TLvwG5Cw2MghJfg1hTTzxwfE8qqV4W74+XnUbshprqLLNJf7SRT7F
	 NWX9OBiZc840WTouvEu1atGtXj8a1ll5pLgoZWNE=
Subject: FAILED: patch "[PATCH] remoteproc: qcom: pas: Guard dtb metadata release with" failed to apply to 6.12-stable tree
To: mukesh.ojha@oss.qualcomm.com,andersson@kernel.org,dmitry.baryshkov@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:20:36 +0200
Message-ID: <2026090336-snowiness-uncle-0a18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c06c5ab4945392d2c2aded6d832ab6b58cabe351
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090336-snowiness-uncle-0a18@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

