Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861863B5DED
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557270; cv=none; b=a56/LgsjYcOWB7xL2shsJLQko1WwW+X6AmMAYwEk3DgJnbe4Z+ZURYb7P4B3KEttgJ6LebDNJdepFhkoW7j6ooGoQwybZq22uBMVz/IKmDgctQ5nKbA/MkS2LAGGkIA/512KwGSypSkZUAOGWNFVktrT7KPPQY2RJDAvHRzxeOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557270; c=relaxed/simple;
	bh=grE/3OHQo5ePCbEcnb/m+UwMbqN7sUASrRSUhE1diCc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Biv65RS/iydN+2pLCNwJKr7uTMBpF2e/E5tICwid6wvEDVRJOiIXmlFeVnD5yKthpQmc/jgNovKd9zJeYUElapolGncWVB2QHgWnZEAG0aG1GXd7gbTmPtn6lLQLIX1LQvNx/30akffwAATGE55wqK1m5J9GouaRWhrmmbkeW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iNOLLD1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iNOLLD1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A721F000E9;
	Mon, 20 Jul 2026 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557269;
	bh=L6UM3efkWyFRvGxHGCyKHLoq1bJyccoKpYsVOWPFN7U=;
	h=Subject:To:Cc:From:Date;
	b=iNOLLD1aZroqPqP87eaqHjkSGOtxRB0HVeWbNisKE/M1U5OBFVsG05p6NzU5nH5wN
	 9OEmPKLB/bAIVXtjSYWhHTBYQLD/7Fs7F/Fu7VPcWrsTRHvwzV9KO3msNcLfr47Qh3
	 KIarlHv8UljA23HS29XMKHhcqZVnoYIVuhyfvQAU=
Subject: FAILED: patch "[PATCH] remoteproc: qcom: Fix leak when custom dump_segments addition" failed to apply to 5.15-stable tree
To: wasim.nazir@oss.qualcomm.com,andersson@kernel.org,mukesh.ojha@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:20:52 +0200
Message-ID: <2026072052-islamic-scorecard-54c2@gregkh>
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
git cherry-pick -x ecf9fc18e62c58eae1ceb65dab2bccb8a724de2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072052-islamic-scorecard-54c2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

