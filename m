Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3943B4B9
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110345; cv=none; b=gAwjIatIugygCLh4i5D+Owrz6LjVAmLcQs1xwDBa3WLnRGKy1LWenrAW28biZbE9ZhMkfBGcHZxgJDXFVm0RP0+hxTH+45nDHSIeR1Pl2glWA/TeDkLeRa/eLvUwllVj3dplxU2Am5rAU8LbJBsTh5/9E85GF+Q6Lk3NuXnABc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110345; c=relaxed/simple;
	bh=MFS1j7p8U7tTHpf8TI1wTUsrrMOJaRTpkGKMp9y6KbI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=epJSkzac5amGNirSnh0qR7VMeNAU6PJ95I32sg0eGpM3lr5rfMy57stT0rb0Sc3M+gdYbqf0zTOkH2KspEcNb8yvgB48DwNqmWECSupsr1Z08j27p2+fqBsE34YDfN0bC0m2tFZV1h+yYHh9CeL6yTiMrrnPKxEge6eGCdLQAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFKfWHl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFKfWHl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1E31F000E9;
	Wed, 15 Jul 2026 10:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110343;
	bh=bx5GLTj1VqeP/F3RJxv1hvH7eJKAF/sGusPS0sEvXtQ=;
	h=Subject:To:Cc:From:Date;
	b=SFKfWHl+juXUZMDvYBmx5GXHJpmEwjYanYMTVo4fPbDucCzvh3+Orh/kXeZweOB8k
	 Cyg3ubH4D2zrLUHGeZRANT8LbXicC3SJ8Us2AZ1KE3yJYdQ2EPn14sKPkyXhaywMWT
	 xHk/xDXSNtRw3Es++BkBzyQ5MHKcZy5iHXpF4Xdk=
Subject: FAILED: patch "[PATCH] nvmet-auth: validate reply message payload bounds against" failed to apply to 6.6-stable tree
To: flynnnchen@tencent.com,hare@kernel.org,kbusch@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:12:06 +0200
Message-ID: <2026071506-ankle-quartered-9eb2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3a413ece2504c70aa34a20be4dafec04e8c741f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071506-ankle-quartered-9eb2@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a413ece2504c70aa34a20be4dafec04e8c741f9 Mon Sep 17 00:00:00 2001
From: Tianchu Chen <flynnnchen@tencent.com>
Date: Fri, 29 May 2026 14:18:39 +0000
Subject: [PATCH] nvmet-auth: validate reply message payload bounds against
 transfer length

nvmet_auth_reply() accesses the variable-length rval[] array using
attacker-controlled hl (hash length) and dhvlen (DH value length) fields
without verifying they fit within the allocated buffer of tl bytes.

A malicious NVMe-oF initiator can craft a DHCHAP_REPLY message with a
small transfer length but large hl/dhvlen values, causing out-of-bounds
heap reads when the target processes the DH public key (rval + 2*hl) or
performs the host response memcmp.

With DH authentication configured, the OOB pointer is passed directly to
sg_init_one() and read by crypto_kpp_compute_shared_secret(), reaching
up to 526 bytes past the buffer. This is exploitable pre-authentication.

Add bounds validation ensuring sizeof(*data) + 2*hl + dhvlen <= tl before
any access to the variable-length fields.

Discovered by Atuin - Automated Vulnerability Discovery Engine.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index f1e613e7c63e..0a85acf1e5c7 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -132,13 +132,22 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	return 0;
 }
 
-static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_reply(struct nvmet_req *req, void *d, u32 tl)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_reply_data *data = d;
-	u16 dhvlen = le16_to_cpu(data->dhvlen);
+	u16 dhvlen;
 	u8 *response;
 
+	if (tl < sizeof(*data))
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
+	dhvlen = le16_to_cpu(data->dhvlen);
+
+	/* Validate that hl and dhvlen fit within the transfer length */
+	if (sizeof(*data) + 2 * (size_t)data->hl + dhvlen > tl)
+		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+
 	pr_debug("%s: ctrl %d qid %d: data hl %d cvalid %d dhvlen %u\n",
 		 __func__, ctrl->cntlid, req->sq->qid,
 		 data->hl, data->cvalid, dhvlen);
@@ -338,7 +347,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 
 	switch (data->auth_id) {
 	case NVME_AUTH_DHCHAP_MESSAGE_REPLY:
-		dhchap_status = nvmet_auth_reply(req, d);
+		dhchap_status = nvmet_auth_reply(req, d, tl);
 		if (dhchap_status == 0)
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1;

