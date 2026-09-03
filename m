Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED54BAA13
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446469; cv=none; b=ADQhM64evO5z1kYnFA36bU2XOs/cEgQqBPYCrj+57ReiBNZdKWro3KPje7ibTFVhzelY5JMQpOZYZURkZX1WE19TDux5Tc+9rbfK4H8CHk87mB+tG5VrOo0GuSJqZ1tZfUKNE5D27YMrs+Kn8fYiT8WY37PyTmekZ3h+BeE2oJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446469; c=relaxed/simple;
	bh=Zz259RrvhWqDnENe+hYVd0S4kq9/vBQjcD9KwHO+mnc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ny1Pr6t0HdW38l4VnVU7T708oh+D17GEWQVn3HIPAT2cb9b7dVC5rAdCH+XgzIwPvTNxeAhE/lXxzyAXgYsZC2LU2CD+fYK57a2p5He4n/d+EbaVPzIOFt/XKKhmp3Am7jK6J6o8KWaSyAPjYQhc8GYcbcOoSSMYu6Hc2Uh/aOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fnIbj8si; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fnIbj8si"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96651F000E9;
	Thu,  3 Sep 2026 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446459;
	bh=Klkxjfml+ThlhZo/KRRk/O6hZXUlpXlHDeJtvpLS4co=;
	h=Subject:To:Cc:From:Date;
	b=fnIbj8sidrWAUq2rucH3HmLIueEQ01YkWnmJvhbN3/j37JK2wQP7yImTeYx2NfQKm
	 1e3/DUA6vLXxP6AVjjDG9Er/CuPxEkzhNzYTDnnUC44+Pu2oAzSOMPsOBsGKUHFDy7
	 0Y5zkhCpBI950b/SG5ocnochp4AIhTu5bdtiuzDA=
Subject: FAILED: patch "[PATCH] remoteproc: qcom: pas: Guard dtb metadata release with" failed to apply to 7.2-stable tree
To: mukesh.ojha@oss.qualcomm.com,andersson@kernel.org,dmitry.baryshkov@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:20:35 +0200
Message-ID: <2026090335-olympics-autopilot-18b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x c06c5ab4945392d2c2aded6d832ab6b58cabe351
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090335-olympics-autopilot-18b7@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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

