Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921731A4F3C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557091; cv=none; b=oW6n+UF2jsEVHNH7xQYWX5JiAjJm2ZqNaNoj47BYNvBE11SfiqIqN+HLwYxSEj3/kFAHMI0P3OTvXnJ+IcCXu+n6OBC/4vFPWnKSbWdga9OnXsrFWftPjkQf+Jv2LabXezQ77zM11ZbzJO1rz8vCuiD5/nd91kptLPCxFDE2tA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557091; c=relaxed/simple;
	bh=LSfQtnReAloyAwCKcFawOSCM7UoxGbdAlCov3MjvHnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLd+Ow3MUda7C4pIlIqdYGqTA0/z4GWfr2ZW9kQBEARrqVfHLD327hVod/AwP1+HhVY9iOO1S+Krs/9spSN5M9xtppMGrT6iM1lyRNHNL6Rvg1KWZJF9fQiico8cV+j/zpWgU7pKaxZmjIO1OTA0JXDzwOC1kvFirrv5g1GuxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWSuumPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWSuumPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3821F00A3D;
	Mon, 20 Jul 2026 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557090;
	bh=cKU2bLGHdmBbNRzzocUIwVSpVSLaTAEaqgijoBc0HhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWSuumPxy1zsd46kzF9u2QOHT9sfyhr07mJ44lHbRNH9qFG0NuUHqxi4SImiMLrRm
	 396aqML6L0i5r1i+O1EijFGyHyPVRghi2jSOLUdbe1v7Nob4VO3BSBpQ3qWTxv2Ax9
	 EOZWLG+4EoABQ6QTQYa3qwr9pt+Sc1l38GYN4BU3oOoKEcW39RgnTebJ/QnJDP4YSJ
	 uZhhDoEK10NsRImNu5/7oKdaCEd0RRmQUGMM2LPTU2wgA9yA5QkVwquPN+0BVLd/d8
	 5E5f/gld1DDcrahYXWMPEyB/3xo09zxFK8Y947yIutUc2Ai1jiyj+EsDdgsU+0LEeT
	 twNU63E5HJCkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] nvmet: return DHCHAP status codes from nvmet_setup_auth()
Date: Mon, 20 Jul 2026 10:18:05 -0400
Message-ID: <20260720141806.1621638-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720141806.1621638-1-sashal@kernel.org>
References: <2026071506-uncounted-retaliate-5437@gregkh>
 <20260720141806.1621638-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 44e3c25efae8575e06f1c5d1dc40058a991e3cb2 ]

A failure in nvmet_setup_auth() does not mean that the NVMe
authentication command failed, so we should rather return a protocol
error with a 'failure1' response than an NVMe status.

Also update the type used for dhchap_step and dhchap_status to u8 to
avoid confusions with nvme status. Furthermore, split dhchap_status and
nvme status so we don't accidentally mix these return values.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
[dwagner: - use u8 as type for dhchap_{step|status}
          - separate nvme status from dhcap_status]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 3a413ece2504 ("nvmet-auth: validate reply message payload bounds against transfer length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/auth.c             | 20 +++++------
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++++-------------
 drivers/nvme/target/fabrics-cmd.c      | 11 +++---
 drivers/nvme/target/nvmet.h            |  8 ++---
 4 files changed, 43 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 74791078fdebc3..9fe6ad89bf83a5 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -125,12 +125,11 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 {
 	int ret = 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
-	const char *hash_name;
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -148,13 +147,16 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	}
 	if (!host) {
 		pr_debug("host %s not found\n", ctrl->hostnqn);
-		ret = -EPERM;
+		ret = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 		goto out_unlock;
 	}
 
 	ret = nvmet_setup_dhgroup(ctrl, host->dhchap_dhgroup_id);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_warn("Failed to setup DH group");
+		ret = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+		goto out_unlock;
+	}
 
 	if (!host->dhchap_secret) {
 		pr_debug("No authentication provided\n");
@@ -165,12 +167,6 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 		pr_debug("Re-use existing hash ID %d\n",
 			 ctrl->shash_id);
 	} else {
-		hash_name = nvme_auth_hmac_name(host->dhchap_hash_id);
-		if (!hash_name) {
-			pr_warn("Hash ID %d invalid\n", host->dhchap_hash_id);
-			ret = -EINVAL;
-			goto out_unlock;
-		}
 		ctrl->shash_id = host->dhchap_hash_id;
 	}
 
@@ -179,7 +175,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
 					       host->dhchap_key_hash);
 	if (IS_ERR(ctrl->host_key)) {
-		ret = PTR_ERR(ctrl->host_key);
+		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->host_key = NULL;
 		goto out_free_hash;
 	}
@@ -197,7 +193,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
 					       host->dhchap_ctrl_key_hash);
 	if (IS_ERR(ctrl->ctrl_key)) {
-		ret = PTR_ERR(ctrl->ctrl_key);
+		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->ctrl_key = NULL;
 		goto out_free_hash;
 	}
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index e0dc22fea086d4..a5da361547f02d 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -31,7 +31,7 @@ void nvmet_auth_sq_init(struct nvmet_sq *sq)
 	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 }
 
-static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_negotiate_data *data = d;
@@ -109,7 +109,7 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	return 0;
 }
 
-static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_reply_data *data = d;
@@ -172,7 +172,7 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 	return 0;
 }
 
-static u16 nvmet_auth_failure2(void *d)
+static u8 nvmet_auth_failure2(void *d)
 {
 	struct nvmf_auth_dhchap_failure_data *data = d;
 
@@ -186,6 +186,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	void *d;
 	u32 tl;
 	u16 status = 0;
+	u8 dhchap_status;
 
 	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
@@ -237,30 +238,32 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
 		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
 			/* Restart negotiation */
-			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
-				 ctrl->cntlid, req->sq->qid);
+			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
+				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				if (nvmet_setup_auth(ctrl) < 0) {
-					status = NVME_SC_INTERNAL;
-					pr_err("ctrl %d qid 0 failed to setup"
-					       "re-authentication",
+				dhchap_status = nvmet_setup_auth(ctrl);
+				if (dhchap_status) {
+					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
-					goto done_failure1;
+					req->sq->dhchap_status = dhchap_status;
+					req->sq->dhchap_step =
+						NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+					goto done_kfree;
 				}
 			}
-			req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
+			req->sq->dhchap_step =
+				NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 		} else if (data->auth_id != req->sq->dhchap_step)
 			goto done_failure1;
 		/* Validate negotiation parameters */
-		status = nvmet_auth_negotiate(req, d);
-		if (status == 0)
+		dhchap_status = nvmet_auth_negotiate(req, d);
+		if (dhchap_status == 0)
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE;
 		else {
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
-			req->sq->dhchap_status = status;
-			status = 0;
+			req->sq->dhchap_status = dhchap_status;
 		}
 		goto done_kfree;
 	}
@@ -284,15 +287,14 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 
 	switch (data->auth_id) {
 	case NVME_AUTH_DHCHAP_MESSAGE_REPLY:
-		status = nvmet_auth_reply(req, d);
-		if (status == 0)
+		dhchap_status = nvmet_auth_reply(req, d);
+		if (dhchap_status == 0)
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1;
 		else {
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
-			req->sq->dhchap_status = status;
-			status = 0;
+			req->sq->dhchap_status = dhchap_status;
 		}
 		goto done_kfree;
 		break;
@@ -303,13 +305,12 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		goto done_kfree;
 		break;
 	case NVME_AUTH_DHCHAP_MESSAGE_FAILURE2:
-		status = nvmet_auth_failure2(d);
-		if (status) {
+		dhchap_status = nvmet_auth_failure2(d);
+		if (dhchap_status) {
 			pr_warn("ctrl %d qid %d: authentication failed (%d)\n",
-				ctrl->cntlid, req->sq->qid, status);
-			req->sq->dhchap_status = status;
+				ctrl->cntlid, req->sq->qid, dhchap_status);
+			req->sq->dhchap_status = dhchap_status;
 			req->sq->authenticated = false;
-			status = 0;
 		}
 		goto done_kfree;
 		break;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 441a6b6170fda5..e8dd276dfc6223 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -210,7 +210,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl = NULL;
 	u16 status;
-	int ret;
+	u8 dhchap_status;
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
@@ -252,11 +252,12 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
-	ret = nvmet_setup_auth(ctrl);
-	if (ret < 0) {
-		pr_err("Failed to setup authentication, error %d\n", ret);
+	dhchap_status = nvmet_setup_auth(ctrl);
+	if (dhchap_status) {
+		pr_err("Failed to setup authentication, dhchap status %u\n",
+		       dhchap_status);
 		nvmet_ctrl_put(ctrl);
-		if (ret == -EPERM)
+		if (dhchap_status == NVME_AUTH_DHCHAP_FAILURE_FAILED)
 			status = (NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR);
 		else
 			status = NVME_SC_INTERNAL;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6aee0ce60a4bab..4007765fcff326 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -111,8 +111,8 @@ struct nvmet_sq {
 	struct delayed_work	auth_expired_work;
 	bool			authenticated;
 	u16			dhchap_tid;
-	u16			dhchap_status;
-	int			dhchap_step;
+	u8			dhchap_status;
+	u8			dhchap_step;
 	u8			*dhchap_c1;
 	u8			*dhchap_c2;
 	u32			dhchap_s1;
@@ -705,7 +705,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-int nvmet_setup_auth(struct nvmet_ctrl *ctrl);
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -724,7 +724,7 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 			    u8 *buf, int buf_size);
 #else
-static inline int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 {
 	return 0;
 }
-- 
2.53.0

