Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D071E9B3D;
	Thu, 27 Aug 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850384; cv=none; b=QQ6L+3WJxu1p7Na6hzvRi0XsSBm4WxZpAlEbVVVBb/FAMJwmtSTd5fTYlgG+3910J2GzefwfXDlI74IXrI56yVkDTCeHSs5tfh86yhf+U3QYqMx/Z/AavsqiMDZLg5H99VLsXdk8rtJUfe44p/x4rHgNz3L1EzCGmVNrxp5lqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850384; c=relaxed/simple;
	bh=p6sto07lzQQq/WJCX4rsuB9Yq6Scdhq71+xKiMyl5Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qs4Jsn7dJjVw1qi/Fo6LXvqFhc5Mxvd5Yxp/QsbcfU0EAJp0j7CEviHORWEZ8wfMERG0RN6bFzkyjzeEVlTVEe9I5ZhPkNvEZlVPP6UXBd2CEm5KqIqKxql7AkCUkWit6w433HLInnadbFcU09FQtppIosZEAzVedompxtrTxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b9692dcf;
	Fri, 28 Aug 2026 01:06:17 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] accel/rocket: Validate BO handle counts on job submission
Date: Fri, 28 Aug 2026 01:06:06 +0800
Message-ID: <20260827170608.39511-2-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0442fc77503a1kunmddadd30e6f5a7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGk5KVkgeSBhOQk5JGkxLHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

The input and output BO handle counts are __u32, while GEM lookup and
reservation helpers take int counts. A count above INT_MAX, or a combined
count above INT_MAX, cannot be represented safely at those call sites.

Reject such counts before looking up the BOs.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
---
 drivers/accel/rocket/rocket_job.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index bb77b6bf0f231..7e3d123afc5ad 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -556,6 +556,12 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	if (job->task_count == 0)
 		return -EINVAL;
 
+	/* GEM lookup and reservation helpers take signed object counts. */
+	if (job->in_bo_handle_count > INT_MAX ||
+	    job->out_bo_handle_count > INT_MAX ||
+	    job->in_bo_handle_count > INT_MAX - job->out_bo_handle_count)
+		return -EINVAL;
+
 	rjob = kzalloc_obj(*rjob);
 	if (!rjob)
 		return -ENOMEM;
-- 
2.43.0

