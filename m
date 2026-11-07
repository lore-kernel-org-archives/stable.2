Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046437;
	b=wZ+5odmK8NqboQI24NwdyyajINCR/l+zGzdCtkuVHZgd8gDLfwbM2jznlyhKbTlyZwuP
	 Ny6oN8hqPIRpKaGyJ8u8V+PmSn8Jfa6cgRfFWOxyGEMS0w3pKrYrMeF18tOIgovtD5Ujj
	 S8IInXTOxieAA02v58xmmToY6qT3txGa8Cs5Sx5X1aKyKWzLKPOryxHMmS5LQhxk2qTxV
	 jShHgxpEz93qk2GdystJAm/EuDIdsye+1NvPu6JocMGz/io+D8fj3up35E4ImiApjghsk
	 2eJBamRituCG2/egVhmlVANoU0Ht1Wn2h5h7BJYFA9QiiXg+7f3dSUJfL+M461TWFow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KJSrvmTQ+rSLce6SnvqIN81cfjkZ5YIr1Huwpqmul9U=;
	b=BmOty23DUrFvH0U2KTDsYORYhlQYq43+dXa9COW6MDjMbcUw1q4jho1kK4zrk3sRyWmx
	 hwxyugZT0ErYBF1pYXzOkpYIKOdl09dJO5eogFnbun3jtDvUENjGGTW+PKW0p9JEcES1/
	 ks5ebA4pI+zpVR2ofQREY+GsBE6usW3SHVx/FHBIL8SV7mmrZJb4Rs/eWkRbpbhxHfZ0H
	 pNJOSayDj8KJqQchYNnocOPLBqJhAudjT71cytcFgC6QN5wfsoWl4HpJg7Httj1GKeRd9
	 xOUxe/YpGIz2yRgKTqBkE9ppQY4LVNVNBuhtXWEtVfXrTavX8F400WEtRIqdKjdGIyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fauIETvC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC57606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fauIETvC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EE71F008A4;
	Sat,  7 Nov 2026 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046436;
	bh=KJSrvmTQ+rSLce6SnvqIN81cfjkZ5YIr1Huwpqmul9U=;
	h=From:To:Cc:Subject:Date;
	b=fauIETvC1LIsN/CnxK+ND5R/ie+grj2pDO3oPzUjGXc1CFIBBhw16LjeJ/PQy1T1w
	 YSh5VgyDhMs/y2jqoHUGTPKIkoCTUSqraqgW57vvnNcD3wIAXXFv+ibXXye/weZ2vR
	 rD0JZDmqQ3JTfy/7l/BQ5pONX1VB0897g4SgrVgLC195/gxOGindS0b0wXL5KM6R1K
	 QPi6V9BipklaN0UsuBhd13FN5gQq1+a7S1IukSGJDLgwpoJ7tDo7YMBTkzcDoTgGTk
	 4OBb34k2LYwy7lM/oX0ifYn4cj1payZ8cTliwObsMk+cZbY5WM67/gUwFCHsrbuHfg
	 ERyon2/g5Q/xQ==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Validate request_len before accessing request" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:54 -0500
Message-ID: <20261107051354-failed-6.18-42aa44371810@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 42aa443718104d10dbdb6f258810b425eb2451f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051354-failed-6.18-42aa44371810@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




