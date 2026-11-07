Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047143;
	b=Bj+cYAkHV2SPBOkm4aqr7tLY73GuJ3C/TFcDiBo5DzGrfMK0bx6lnNbbz49iNOk110xD
	 NYnOb8xch2STR/doRt3FiYTnQic1VrW/m3CwMK5VlG45+4zOGSNHnnchN+tBlt9dQw3JV
	 naCTymlFhQx4oV/W5sNROWqRnBq9XELe7+uIqqrrljMCkGrbVHV3ArOxWV7AiJ3FJ7h+c
	 E8b8526UeWoHPY2YFNa0Oe+N4NZx31dMNQRCQg2xX4V8LOhut4pwTx7lJk9GZTPYUrDvA
	 JPh2aIS7nxlCej3TdJ4V4kbizpraAMAE5hw1EZnSCauYXkgpXpYYZOmq+fBQEABF99A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047143;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BL77ZL92g1EaS95ThTeZvktDJfinyngRvYl8GrHSII0=;
	b=dsu/PnieN/t3syD37CEuLZrOoznLwzhM5AZJdsq+QhlLtaJmOO6p3IS7p+mZ/rWmcmHX
	 KXStee2Jyz0ZlEQKyq4i7hvuwNAk0jou7ggT0y9j05gOsguANDGtPOSHO8+FQt9x4eaKI
	 5Yz2yf2d7IAmgv1aRTg3DvU5QoiYHrNp+x71/aqAHvBPdzzlRtHtvIqbRfbgvVj9CkokO
	 6Gpchd8hQm2Uhxfc/koPQ0hLgVv8RypshxVq1pUWyu7UE9Jpo7ckulmhFoKXv5aqb36jT
	 KqMA+JJ6v2kQYlbjHouMaNxCXTBJBCdO4HjaPGPXXBV9VoEcStB0UNiIAaOtMNioBhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PIci8AnF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0FD606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PIci8AnF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6A21F0089F;
	Sat,  7 Nov 2026 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047143;
	bh=BL77ZL92g1EaS95ThTeZvktDJfinyngRvYl8GrHSII0=;
	h=From:To:Cc:Subject:Date;
	b=PIci8AnFDiWtpeeK8L47Fro5lMszFRKGAF6yuJRqmIWo7j0wY19MJqxvV4q9y5vmf
	 7B1jul3YiBXYK3Dn/Eq2kBDcq3IcgtX/lEOZxOmEQ+m3x9ZwlxZYfRq1xzv0EY5rde
	 7tjHcP14UGPfoLmTGnF5opythMe/sIw8sCYlswxdbkc7ZFQNlqa8gUpAJYwpbEPuTJ
	 LkeNfVPiBZ7JG2W1OROEvH2IPKr+GDZwyPQm++ffKUoM3a8lAPuZcCyxa3xUXALS/2
	 Ky+huS1FHOoEEzsQ1SpkwHEMUayT2JXFIiADANQaC+wC0hMD0MmKVB5rJmxt3MAekF
	 xZsbBzMLNhTNA==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Validate request_len before accessing request" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:41 -0500
Message-ID: <20261107052541-failed-6.12-42aa44371810@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 42aa443718104d10dbdb6f258810b425eb2451f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052541-failed-6.12-42aa44371810@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 42aa443718104d10dbdb6f258810b425eb2451f8 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 15 Oct 2026 08:18:53 +0800
Subject: [PATCH] scsi: ufs: bsg: Validate request_len before accessing request

ufs_bsg_request() and ufs_bsg_exec_advanced_rpmb_req() read the request
buffer without checking job->request_len, which userspace controls. A short
request causes an out-of-bounds read. Found by syzkaller.

Reject requests shorter than the structure each path reads.

Fixes: 64d4864714c2 ("scsi: ufs: bsg: Remove unnecessary length checkup")
Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg")
Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-4-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufs_bsg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 545ef7b79ceb5..0db830e54ef0f 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -73,6 +73,9 @@ static int ufs_bsg_exec_advanced_rpmb_req(struct ufs_hba *hba, struct bsg_job *j
 	if (hba->ufs_version < ufshci_version(4, 0) || !hba->dev_info.b_advanced_rpmb_en)
 		return -EINVAL;
 
+	if (job->request_len < sizeof(*rpmb_request))
+		return -EINVAL;
+
 	if (rpmb_request->ehs_req.length != 2 || rpmb_request->ehs_req.ehs_type != 1)
 		return -EINVAL;
 
@@ -142,6 +145,11 @@ static int ufs_bsg_request(struct bsg_job *job)
 
 	memset(job->reply, 0, job->reply_len);
 
+	if (job->request_len < sizeof(*bsg_request)) {
+		ret = -EINVAL;
+		goto out_complete;
+	}
+
 	ufshcd_rpm_get_sync(hba);
 
 	msgcode = bsg_request->msgcode;
@@ -194,6 +202,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 out:
 	ufshcd_rpm_put_sync(hba);
 	kfree(buff);
+out_complete:
 	bsg_reply->result = ret;
 	if (ret == 0)
 		job->reply_len = rpmb ? sizeof(struct ufs_rpmb_reply) :
-- 
2.53.0




