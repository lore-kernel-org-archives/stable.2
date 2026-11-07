Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048491;
	b=SORv7c9SLGyOjTZpsJ4GvCrhe/qRUZRNGA+9Uz2ZJIUzI64uvA5MWzBq94yHJifaTqQ7
	 9SfOi3/01wI2Efu4/iZscGyyniZEyDacm0a68JBbDiy0UjQYgUrHzqqWpctsIw/h2VrOC
	 GCqiCL8yw4vp3TeyA0QT6kCMqiygNfC9VvsIcPMZaIXB17PRk0Tmr+KUOfg3KAE/zS4iO
	 2Wt6e+1icKju8cjzQtWZDcIKKblbqpDW1g+b64yMHcv1QNxufOFQCJyT2EhJ2d0qX34wm
	 s8sOMy4un8t/FxDgLrjUMHKl/f2mXqUwR0P+wfev5iR8cnJZjCjFGpYqXTx7yfCfYpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SaqiVMGZH5+myugWt3206MKDJA6BbLWH//+WHLGgb+Q=;
	b=J9QWy6I14au45WGV7UVgCadYS7ua0qKaNg7ZCiz8QmMPLj3k9VT66dgMSUyondw3sgU/
	 Hyk0Ekr52RkFV2TeUYcL7SGWBnIuYz5w2iSWyxRcaP7cE8LzqhdOdE2tizDx/xglCwJNQ
	 +Dm+tNvRB2XcXLi8ytK5Qr53rIc+Guqr4EggPyledo/2nAkz/LvljwWjBPN0HeBQ077Um
	 BFGBJKRZrKPmWoje2NAweIyqhdCkl0UloxN2zMYsV6E45KLIMWRD9vSh7lKAp8xX9tQiN
	 m7+O5H1qCW50WKwohhpyhuZH7fqSHi4pkA17ZEZnm/RcjhGVZ3P14kpskDLheM+hXuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPPrcrCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B3606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPPrcrCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312AE1F0089F;
	Sat,  7 Nov 2026 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048490;
	bh=SaqiVMGZH5+myugWt3206MKDJA6BbLWH//+WHLGgb+Q=;
	h=From:To:Cc:Subject:Date;
	b=mPPrcrCzxPw768au2RGwZIAhVvm56dpJWglEa5k0opsP1j1oUP9HLonbu3HEpBtEK
	 2sZ5hljkl3vm6H7zvbxTFRnZ9i7vDRyFkfU0+UaQSv93+jAx0sLE6OSCSVnjKjD4Ia
	 3gHzPF0me7q9nEgtHLnbfSx9fThem7U8b/d/3v3fB2aZb8t7e5Xr1COGoeO5qdMfrE
	 LKG9xq1/qbEaqiW15+ZKcQElcVpYJNyRw8O7LegnhwlsMNXppMJVSWnLAXv73vYdM5
	 hM4ZBryf6ySzgLYOUR9mr21n6kGHYUOHsk62I/O9ryfuhi7U1ePt9uJBqYTlN2bgA2
	 OThS4TmP+KZ+Q==
From: Sasha Levin <sashal@kernel.org>
To: yhlee@isslab.korea.ac.kr,
	hare@kernel.org,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme-auth: fail when the controller does not authenticate itself" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:08 -0500
Message-ID: <20261107054808-failed-6.1-f9e43d924bc7@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f9e43d924bc74feeb56197de82b2845de2a4b85a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054808-failed-6.1-f9e43d924bc7@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f9e43d924bc74feeb56197de82b2845de2a4b85a Mon Sep 17 00:00:00 2001
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Date: Tue, 6 Oct 2026 22:48:05 +0900
Subject: [PATCH] nvme-auth: fail when the controller does not authenticate
 itself

nvme_auth_process_dhchap_success1() returns success as soon as the
controller clears the rvalid flag in its DH-HMAC-CHAP success1 message,
without looking at whether the host had asked the controller to
authenticate.  A host configured with a controller secret sends a
challenge in its reply, computes the expected controller response, and
sets chap->bi_directional; if the controller then answers with
rvalid = 0 the response is never compared, the host still sends
success2, and the queue is marked as authenticated.

A malicious or man-in-the-middle controller therefore only has to clear
one flag to turn the configured bidirectional authentication into a
one-way one, without holding any secret of its own.  The target side
already treats the mirror image of this as fatal: when the host supplied
a challenge but no controller key is configured, nvmet_auth_success1()
fails the authentication rather than answering with rvalid = 0.

Refuse the connection if the controller returns no response although
bidirectional authentication was requested.  chap->bi_directional is the
right condition rather than ctrl->ctrl_key, because secure concatenation
sends a challenge only to derive the PSK and deliberately clears
bi_directional; a one-way setup without a controller secret keeps
returning success as before.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/auth.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e55920642f2c1..cbb38935fa227 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -358,8 +358,21 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 			 nvme_auth_hmac_name(chap->hash_id),
 			 nvme_auth_dhgroup_name(chap->dhgroup_id));
 
-	if (!data->rvalid)
+	if (!data->rvalid) {
+		/*
+		 * The controller did not return a response.  If we asked it to
+		 * authenticate itself the session must not be used, otherwise
+		 * mutual authentication would silently degrade to one-way.
+		 */
+		if (chap->bi_directional) {
+			dev_warn(ctrl->device,
+				 "qid %d: controller did not authenticate\n",
+				 chap->qid);
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+			return -ECONNREFUSED;
+		}
 		return 0;
+	}
 
 	/* Validate controller response */
 	if (crypto_memneq(chap->response, data->rval, data->hl)) {
-- 
2.53.0




