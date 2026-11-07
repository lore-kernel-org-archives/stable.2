Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049877;
	b=OwcR62Ep1t/M9I3ItylEovCv790qvJkV39qzV33+yeHXW7aiNtSwt2i2HlL38TEv9bMU
	 BA/fc0FPD8aRvCSRUaNkxU23UzCvmxKNChTlKqbTTbnA61pyz9NkqALctrXKe4081w475
	 hnQIdvvuxRYPd2UTAU71Yno6EpW5nEgUn+DUOyeUk0Iz33Epl7l+fviUzLQ8YLaxY9VSE
	 JMcuo95L6Zb5JtdAkEnIIjg2WiEnXtFVhCJmDvNCeJX85VOF/vZ9pxISzXSMh2hW6Fvpj
	 +Y8h5LoL2YIWp/yOKxIHMA1iJDWU92UUCF0qpR81oUyqYlNyDk6Bm90FSE+cf2QeWVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UjaPHwNoCVjcgPhAymxtiDvBVtTz1EfY9qaAtFZXqH8=;
	b=hj9NN3D0QfUgrKOJSIxh7OUYFX9HWgiLCPEeauX6pCEL6sSQSt5XqUEDYrLaYO884VAe
	 ceNhK96EejseJuNFROeTTMcv5KiPcbTJJxO4xtdVbTSyv90i6lO+3CxX0DF9v2L9Fnj7E
	 MkZOVhjWS8L5fA/8jhRf0WsUJ6XM2uU8207QaGs2RlLRxBP4yLy0JiddlAcfY0fg7lY9G
	 1KzpCVRff3+hhq/HMRyrHqLAAAB5hFqXnC+tOUe8B4j6qgAMmOdBCMsmgR0ATAgH5aSaW
	 Se9XiRTggEcQhfX5hIyYQl2/Ocdx9Petpqts+qIZczmD8GfgQMlIhiHkTgb6sIILgXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX6ZahPU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05839606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX6ZahPU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8261F0089F;
	Sat,  7 Nov 2026 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049876;
	bh=UjaPHwNoCVjcgPhAymxtiDvBVtTz1EfY9qaAtFZXqH8=;
	h=From:To:Cc:Subject:Date;
	b=aX6ZahPUccT3yP46g8SriCyiKjUUzwna8Kqp1zUmRuhpAFfaUWhbcKGyuAuDnaspt
	 C2WNOcN4W5ObyEwV5DcqjdJUGCS+BtiitSf8PDFimUW8W5tnqEss0KOZ1pmSQyFIFr
	 20rjUMHZURblBdNoB6TUoxvesWM/uAcVg5Am6qq5V1v/T1iwc4ySzjAN33XPltbPoj
	 jID9qJE1EJCApUpSqRMgEENJCbXftdWYjIQMvUFAiqjVa2SQ3RPLGriWrbwVerj94s
	 QBdonRHxmA31jmfVlxL2p+Foggmcj1z/ebFRxq2+Zn3qP7+rDZREf6rDiMKPiPixLd
	 VSrEsmtP7GvCg==
From: Sasha Levin <sashal@kernel.org>
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	peter.wang@mediatek.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: ufs: bsg: Reject UIC commands with a non-zero result byte" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:11:14 -0500
Message-ID: <20261107061114-failed-5.15-1ae42513205a@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1ae42513205a38b811afedb6797f9f9c4de37b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061114-failed-5.15-1ae42513205a@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




