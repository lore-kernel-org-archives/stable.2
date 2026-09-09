Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85165387347
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947257; cv=none; b=bM2MHGSNLPok08BLQP7A6Owh4kJ4/UCCnYyVB2oGFofO3JnKIUnvoL3vF4gEKbdLxr1BFzyC3yCl+5plIyzVFSpyLAGOGds4JXrA0ItEnNb7/iBlVBu8G2CusKTB95zA4tCQEnDIK37WfzmVFbYPKx8gIOleiCSyQ5wl8n86NpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947257; c=relaxed/simple;
	bh=0e4PA7UIyxpNq2/IUKS0+E3vgEK4VfTIMg11lHsmv9Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T5+6h8y7SSoWZFfDftclqbHTPZxwlTxiW9vJ4uunlLUFni/ZhOdkdEN1Z+Y4uu4PSfNnHg7gz0AWOWcvN0XuSKyPK6kHEswAdUjwnUNdxdMu83MHrv7ChcBqzcXRtbzmWyTwOHjzjLRcZNqqHz03+aEaLt+z21ZkcdarQ96EHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0NL0yqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0NL0yqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D711D1F00A3A;
	Wed,  9 Sep 2026 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947256;
	bh=eyd1NgWVmRSp1MEjoPLMh5xgPYyr6MDJKzeoiXz1WTY=;
	h=Subject:To:Cc:From:Date;
	b=G0NL0yqGA9KKY6SRmoX7o6nFQnVeaVEyN/uACOPkAB0TpKfB8fNc1vvN8z4IHpGmZ
	 pf95HWRSD9TUg96wCVKOEuU9Vw6cptDTaQ7t7vv3Q9eU5lHw1tsXwVTrQxeXAesH3H
	 QNGigSqFsOFOO/STFoDXlSFC79xXe7aOlYcEPW7w=
Subject: FAILED: patch "[PATCH] nvmet-auth: Synchronize timeout work during SQ teardown" failed to apply to 6.1-stable tree
To: hnkz.64@gmail.com,hch@lst.de,kbusch@kernel.org,sagi@grimberg.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:44:05 +0200
Message-ID: <2026090905-brunch-expulsion-4905@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x eaa948c0e19b1bb2d93262207bca0c3d19cc3406
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090905-brunch-expulsion-4905@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eaa948c0e19b1bb2d93262207bca0c3d19cc3406 Mon Sep 17 00:00:00 2001
From: Kazuki Hanai <hnkz.64@gmail.com>
Date: Sun, 30 Aug 2026 22:11:05 +0900
Subject: [PATCH] nvmet-auth: Synchronize timeout work during SQ teardown

nvmet_auth_sq_free() cancels auth_expired_work with
cancel_delayed_work(). If the work has already started, cancellation does
not wait for the callback. Transport teardown can consequently free or
reuse the queue containing struct nvmet_sq while
nvmet_auth_expired_work() still accesses that SQ.

Add a teardown-specific helper that synchronously drains the delayed work
before freeing authentication state, and use it from nvmet_sq_destroy().
Keep the non-synchronous helper for in-band authentication state cleanup,
where the SQ owner remains alive.

Fixes: 1a70200f404a ("nvmet-auth: expire authentication sessions")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index edb9627d97b0..a55319bcdbd1 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -238,6 +238,12 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
 	sq->dhchap_skey = NULL;
 }
 
+void nvmet_auth_sq_destroy(struct nvmet_sq *sq)
+{
+	cancel_delayed_work_sync(&sq->auth_expired_work);
+	nvmet_auth_sq_free(sq);
+}
+
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 {
 	ctrl->shash_id = 0;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ad60b91ced6c..1663ab7ac607 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -980,7 +980,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
-	nvmet_auth_sq_free(sq);
+	nvmet_auth_sq_destroy(sq);
 	nvmet_cq_put(sq->cq);
 
 	/*
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e362d7913a38..dbda55895f4f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -924,6 +924,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
+void nvmet_auth_sq_destroy(struct nvmet_sq *sq);
 int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
@@ -950,6 +951,7 @@ static inline void nvmet_auth_sq_init(struct nvmet_sq *sq)
 }
 static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
 static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
+static inline void nvmet_auth_sq_destroy(struct nvmet_sq *sq) {};
 static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;

