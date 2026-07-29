Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A3488D9D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330128; cv=none; b=GLZWU9qUcxUZKQ4o4rKgdj8e2R7Op1T55l4qCdvGGMRbnRdm6zeU83MSblR/f81sOjWU1zxaZGsBIL6nIBHklTDPaERH77y/Hf+NsbHl7IeQXsUx01jx0aKoxpvm2gI5FYcq3fcrCsN7oyjTdkY99vViCWUaycP6sUropqr/avQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330128; c=relaxed/simple;
	bh=8c5cpVcMeBP0XwHZ+3W2FoIne7a0Jj8ozRJErioKpwY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W77y3JlMiW4NMhop4sDPxv80n3NRmpSU6t7hQ7TwcyTmkXQTggManW1/krlTOx4oW4LwYPzks5isIj30Nbf7He5bcPzCo3HyrZIl0QYSm4DLQBdY7xho2CMpcp1xYZcvTi6p1go3DKj/V9/Rr+8XNDEPOsUT2GjjvpzTCJH3PTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HF5cRipa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HF5cRipa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0560A1F00A3A;
	Wed, 29 Jul 2026 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330122;
	bh=m6AYeoisjy/3e7mzuCJhbBKOg28kpgmAzGRhDx6+TIQ=;
	h=Subject:To:Cc:From:Date;
	b=HF5cRipaoHiQ8gSblGhqsP15J+i9p2s+T/XUdFlNXdYWrTIYUUusA1nS9YMGCnbrE
	 DxA6C8LC0kes8ANdcSdP8lxyUPakx9aABGHygRq0rKeCDnHC4/7/ev9lVUuBh4YSni
	 2Se7tFqTsnrZLiO1kXbfjlLp7Sc5QJ+GAvadx9EQ=
Subject: FAILED: patch "[PATCH] media: qcom: camss: Fix csid IRQ offset for sa8775p" failed to apply to 7.1-stable tree
To: wenmeng.liu@oss.qualcomm.com,bod@kernel.org,bryan.odonoghue@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:59:56 +0200
Message-ID: <2026072956-prison-void-b736@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 817998f863981b8b3f9829798dc4ec9fa275bdaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072956-prison-void-b736@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 817998f863981b8b3f9829798dc4ec9fa275bdaf Mon Sep 17 00:00:00 2001
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 18:13:02 +0800
Subject: [PATCH] media: qcom: camss: Fix csid IRQ offset for sa8775p

Fix BUF_DONE_IRQ_STATUS_RDI_OFFSET calculation for csid lite on
sa8775p platform. The offset should be 0 for csid lite on sa8775p,

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Fixes: ed03e99de0fa ("media: qcom: camss: Add support for CSID 690")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen3.c b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
index 664245cf6eb0..bd059243790e 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen3.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
@@ -48,9 +48,9 @@
 #define IS_CSID_690(csid)	((csid->camss->res->version == CAMSS_8775P) \
 				 || (csid->camss->res->version == CAMSS_8300))
 #define CSID_BUF_DONE_IRQ_STATUS	0x8C
-#define BUF_DONE_IRQ_STATUS_RDI_OFFSET  (csid_is_lite(csid) ?\
-						1 : (IS_CSID_690(csid) ?\
-						13 : 14))
+#define BUF_DONE_IRQ_STATUS_RDI_OFFSET  (csid_is_lite(csid) ? \
+						((IS_CSID_690(csid) ? 0 : 1)) : \
+						((IS_CSID_690(csid) ? 13 : 14)))
 #define CSID_BUF_DONE_IRQ_MASK		0x90
 #define CSID_BUF_DONE_IRQ_CLEAR		0x94
 #define CSID_BUF_DONE_IRQ_SET		0x98

