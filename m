Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DFB488D9C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330126; cv=none; b=XSxfILmhFN+pxlnbvrMUuhUVGXqSnoZfrlOnYZWN5TvNYk4K47cKyjUUIXhYAVUiiMGnK7v31955+Weax5AruE7Ce6vKLHcEv0PckxoAYjYpQiJR67m1bQnjGixv+qKmNx4Sw7syxL47MFSKiBjBm10/jph2udNnpntdKgajksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330126; c=relaxed/simple;
	bh=LJ6tcCwvl99KMgUGveVzxOHdjd6SBwy0vGMBd4rzJnU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lAvivpsqMlpnVUBLf2n+0Rr+eDFVqivlTpRI04E5Uf1Rn/OuIRX8ZFg6pDHJoD4RbMmcHB2gK2HBSDZYCAgjh3/iSo45K+HSAZD7udQ1stMXjek5/VvtV9t+t0EUVRvIEo/E1Rw+LGeVGkyLW6wRWr5wf8bRoR8ah3+a91gJ7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=niEg31RK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="niEg31RK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC3A1F00A3D;
	Wed, 29 Jul 2026 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330119;
	bh=J8UifHIWgoigJYRXqjxBfRP6bo0ncXKV9wXDOoZ4tZg=;
	h=Subject:To:Cc:From:Date;
	b=niEg31RKwAICSIitcmKzKU30bLJ/rrqO+vYfKFtfE9W1xD3NbXne0ZLy1w/N5OouZ
	 yAFoUSjwYuki5JtRDaggaFzZUniqG/x5gKhl+T8q0KAhiboLJx2DaXVxGgutLXHCnT
	 Ssw5WNmoYCL9LlUWeSkROBGLkEF1E/1YJKnvF3ps=
Subject: FAILED: patch "[PATCH] media: qcom: camss: Fix csid IRQ offset for sa8775p" failed to apply to 6.18-stable tree
To: wenmeng.liu@oss.qualcomm.com,bod@kernel.org,bryan.odonoghue@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:59:56 +0200
Message-ID: <2026072956-lively-sworn-1fab@gregkh>
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
git cherry-pick -x 817998f863981b8b3f9829798dc4ec9fa275bdaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072956-lively-sworn-1fab@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

