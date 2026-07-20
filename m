Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FFD3DCDAB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557273; cv=none; b=dNd3pRILjiLccx++4tBT923vEfWqqw09Bqy4K8JX/ySWh0RHYRObeNcoqRaKQP+WGwfipuaKK2/66KCmbKoh/o8yUsFJoTfgC3vxLNM513iDTCXO1U7trCm3BwuNnPY7xsx4FYSmG9djyHHHgalZxD9YTztPeH1a95YfU71zvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557273; c=relaxed/simple;
	bh=1roogmUEiUgtXW81tT/5iczVf13awPbfV9uePsqcOgs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qzbyAs+grPUmrvElMVd8tYm0ZLGeigJFo6UC52QXSeyHQUu5CPCFa311V9/fFM1o6srY+S5wIbExC1G2Rh5CFOzD41aVPGUPc5U+wI591kwWjKaNvyUTbH3QlunZW7RSyOR4gzEWV/Oc8FRTiF2aUBTN8VQt57xmL6yv89/l2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zeKvGd0c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zeKvGd0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC771F000E9;
	Mon, 20 Jul 2026 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557272;
	bh=IpZ+c3IMYYqbB/DO8g42L9/ASqJhy/7JFWq3ep6/8Y4=;
	h=Subject:To:Cc:From:Date;
	b=zeKvGd0c1sSWX0d/9Eobq8tFvJbItORAxl+822lYEFCR4xznUz4sKPF4l8QuxLaFa
	 6LgKGh9/DbOb9ITSutPjKWvuZ1olKo+T7ssujKFBwF4xaWdNNaZIILchF2/R2oPh5X
	 01dDnb3M6lNBBCjfnYmDcJ3Od+Zrhax+zIIL3Kgk=
Subject: FAILED: patch "[PATCH] remoteproc: qcom: Fix leak when custom dump_segments addition" failed to apply to 5.10-stable tree
To: wasim.nazir@oss.qualcomm.com,andersson@kernel.org,mukesh.ojha@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:20:52 +0200
Message-ID: <2026072052-overarch-had-bd14@gregkh>
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
git cherry-pick -x ecf9fc18e62c58eae1ceb65dab2bccb8a724de2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072052-overarch-had-bd14@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ecf9fc18e62c58eae1ceb65dab2bccb8a724de2d Mon Sep 17 00:00:00 2001
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 17:19:16 +0530
Subject: [PATCH] remoteproc: qcom: Fix leak when custom dump_segments addition
 fails

Free allocated minidump_region 'name' in qcom_add_minidump_segments()
when failing before adding the region to 'dump_segments'. Otherwise,
the 'name' is not tracked and is never freed by qcom_minidump_cleanup().

Return error when adding to 'dump_segments' fails.

Cc: stable@vger.kernel.org # v5.11
Fixes: 8ed8485c4f05 ("remoteproc: qcom: Add capability to collect minidumps")
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260318-rproc-memleak-v2-1-ade70ab858f2@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index fd2b6824ad26..e1a955476c9b 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -109,6 +109,7 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 	struct minidump_region __iomem *ptr;
 	struct minidump_region region;
 	int seg_cnt, i;
+	int ret = 0;
 	dma_addr_t da;
 	size_t size;
 	char *name;
@@ -129,17 +130,22 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
 			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
 			if (!name) {
-				iounmap(ptr);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				break;
 			}
 			da = le64_to_cpu(region.address);
 			size = le64_to_cpu(region.size);
-			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
+			ret = rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t,
+								name);
+			if (ret) {
+				kfree(name);
+				break;
+			}
 		}
 	}
 
 	iounmap(ptr);
-	return 0;
+	return ret;
 }
 
 void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,

