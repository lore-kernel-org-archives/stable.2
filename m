Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047914;
	b=2kpB1kQc33ejBZKLkiHrCd7OOCHI4WlDmJ0rxD9xpOXpBKVqBOoO/nlws+uNYneyJTuF
	 73BUAjlFtbO5tMEwZNTrqSUiY6SY10wk4Cp2DMOxXn0ETUOdlsvSxIHVaXYbF8YDE51HK
	 H53z5tWAM7FQtybYpDsJjK883uvq75F2LBzv41ROOBEzCXr+3E+dC1TH7yorrt7jFOwaH
	 1iID7nCZ9KysMw81US0ELmBmga8vTZ8yR3cHdEmehHU+PJf0uM3CeryD8YQJ/onh10efM
	 iEoaoL0JUo8tjLfbrRy3wsvRtZSPkcSV3SZhFuXBzg4+vr9OFINwQOz5OT/IYgOZuVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nC7qB9ULqkPkTZayjWDfVQlZEuwFDcaGE/T31TGgEGE=;
	b=SSCjrjd+WjSn13SsYetArkkCURtCkgGsSpxQ82dejwscFi3igke6NVz9uWwfEiZzBeyF
	 tiZTmXILiLpVn3NqIYk7DLInOTJUM+33YQhw1wfLeYidDRf9uJ1bEeBMzL8JafAoL33tA
	 pszzTYkaKJlUVY4L7jlRo9WuxsJSB/yQ/LXdrrJpY5E7pqziCJQsiW4cfPvoNIwkq/6K4
	 W0dtqBBBYDBVnmyDm9m+9JSusoznzoBNgaByPM1Dly/FuQAzh5eN3xG/zj2EjJCdwd6rv
	 mZHQwxI+8TKED94rX6hrp35dULuC8+vNJCpdl8+BCcq1FHT0ZoHw4dRw26aMnfY9vwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlZCkrar;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlZCkrar
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661551F008A6;
	Sat,  7 Nov 2026 10:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047914;
	bh=nC7qB9ULqkPkTZayjWDfVQlZEuwFDcaGE/T31TGgEGE=;
	h=From:To:Cc:Subject:Date;
	b=ZlZCkrarlOz/6ohgv93c5Az3dFCN000KrkjwyjelP5kb3z38ObZ58mGQGBmGV6zKp
	 q3ZHxTSz/RfKaSvWDbXZR1k8vKyrlNLekmG9nQ8CWB3ve50FSO5Gf1K7Ln09qiqhr9
	 wMj/jiSLg9OOlZCmpcGcZPCL8vBdXZ7IhyRmukaMIIxvHQifT6LB6SBSuBKK0pjW6T
	 y3XVsInLt3Y+mQt/lp58G1zPC2TB+/Ju1ECR5Fli5Prdy78LgrrpAy7eKUm9qYQBNM
	 kMODt1/EkDhe3PXjbtSKr173p6C2FnTOK+alaZU+f5hfkYupP2oId6sfMHSaG2yrC5
	 rDh374t/bCiig==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result byte" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:32 -0500
Message-ID: <20261107053832-failed-6.6-1ae42513205a@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1ae42513205a38b811afedb6797f9f9c4de37b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053832-failed-6.6-1ae42513205a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1ae42513205a38b811afedb6797f9f9c4de37b90 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Thu, 15 Oct 2026 08:18:54 +0800
Subject: [PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result
 byte

ufs_bsg_request() passes the user-supplied UIC argument2 unchanged,
including the result byte (bits 7:0) that only the host controller
writes. A non-zero value triggers the WARN_ON_ONCE() in
ufshcd_dispatch_uic_cmd() and corrupts the reported result. Found by
syzkaller.

Reject UIC commands that have the result byte set with -EINVAL.

Fixes: e77044c5a842 ("scsi: ufs-bsg: Add support for uic commands in ufs_bsg_request()")
Fixes: 9fb4c793223b ("scsi: ufs: core: Complain if UIC argument 2 is invalid")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-5-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/ufs/core/ufs_bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 0db830e54ef0f..cadde515f040b 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -179,6 +179,10 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	case UPIU_TRANSACTION_UIC_CMD:
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
+		if (uc.argument2 & MASK_UIC_COMMAND_RESULT) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = ufshcd_send_bsg_uic_cmd(hba, &uc);
 		if (ret)
 			dev_err(hba->dev, "send uic cmd: error code %d\n", ret);
-- 
2.53.0




