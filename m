Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A5566C6B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093019; cv=none; b=OOmdFhYxBcU+gnJa1JgoTuVla7+NoZNoPUOxwemzCDSs/9xTMbW0g/R+Guat4YM0UqsbdQSzZzIaE6YJ+Afykqc3GNbKqoyNtcOzp+ML0ZdCxPsu1YOCyIDCxrqyjIKN/3vR8+pTxgF7CqP5Tc47ysMV6EKOBMpoSNqC1l3DE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093019; c=relaxed/simple;
	bh=moYSu1PpvLl6WdV0qdoioc1BuocVqXQ3K4SifZhU4Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqlrqbQFZavLtzkmoSyQohlutZQ+0DUF8y2LEzeSYUOO7RK0H2KVTbdCIMyzTyvvmWT7zcTB2vVQGcYqhqjO44bJl4qDQA/timRUxQXWOoiEO61m+Awuq3E2tkQ+yI3Bv8R0ylD37afxWfpc34dT2qevlqBBCF0nk1zKia/wPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5WolLVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5WolLVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ECF1F00893;
	Tue, 22 Sep 2026 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093011;
	bh=KoI4T//uqvUtoimQfyBKUFmBLCS6EfVCH5W2mgX5Sio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j5WolLVljdHweR0YEOxf71XnATKh2Sd4LFhXLZ0h32OMB9E041y9KM495NmYZEsOA
	 cP7zENDEv6VemDn+Ulq5tGtINowHKO+DK28jYqrHdvMFGUJFrv82GbOTl5rY6Ad5Aj
	 dXC0AbgtDreRkF4X5ZKeScXjgZk2v1IAsPVVSIiErwrvRXnSq57yoMTvBpqwsPOQ5T
	 pZbd+39LID6/ANbdW6pU60VpIMrEuBXVEBm++2il+S7KoYDZoyflfq6yBu/Fzyup3S
	 1pA2sO4fM0xBEqHKF1hEngW3k6pvyTJC1epsMO2OVABpa+jq+3YIgQ3U7XoV5Yi3RW
	 tTChaAciaWrrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karan Tilak Kumar <kartilak@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Arulprabhu Ponnusamy <arulponn@cisco.com>,
	Gian Carlo Boffa <gcboffa@cisco.com>,
	Arun Easi <aeasi@cisco.com>,
	Hannes Reinecke <hare@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] scsi: fnic: Rename fnic_scsi_fcpio_reset()
Date: Tue, 22 Sep 2026 12:03:25 -0400
Message-ID: <20260922160329.2942693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092249-remedial-elsewhere-96be@gregkh>
References: <2026092249-remedial-elsewhere-96be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karan Tilak Kumar <kartilak@cisco.com>

[ Upstream commit 31eda39bfd468a0fbabc0179e913c0755377e3b5 ]

The function has no dependency on SCSI/FCP, so rename it to
fnic_fcpio_reset() and move it to fnic_fcs.c

Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Reviewed-by: Arun Easi <aeasi@cisco.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
Co-developed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260217223943.7938-3-kartilak@cisco.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 0cb1fd924126 ("scsi: fnic: Fix missed link-up when critical IRQ targets offline CPU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fnic/fdls_disc.c |  4 +--
 drivers/scsi/fnic/fip.c       |  2 +-
 drivers/scsi/fnic/fnic.h      |  1 -
 drivers/scsi/fnic/fnic_fcs.c  | 50 ++++++++++++++++++++++++++++++++
 drivers/scsi/fnic/fnic_fdls.h |  2 +-
 drivers/scsi/fnic/fnic_scsi.c | 54 +----------------------------------
 6 files changed, 55 insertions(+), 58 deletions(-)

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index ae37f85f618b5..d276f1d696f80 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -4613,7 +4613,7 @@ void fnic_fdls_disc_start(struct fnic_iport_s *iport)
 	if (!iport->usefip) {
 		if (iport->flags & FNIC_FIRST_LINK_UP) {
 			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-			fnic_scsi_fcpio_reset(iport->fnic);
+			fnic_fcpio_reset(iport->fnic);
 			spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 
 			iport->flags &= ~FNIC_FIRST_LINK_UP;
@@ -5072,7 +5072,7 @@ void fnic_fdls_link_down(struct fnic_iport_s *iport)
 	iport->fabric.flags = 0;
 
 	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-	fnic_scsi_fcpio_reset(iport->fnic);
+	fnic_fcpio_reset(iport->fnic);
 	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 	list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
 		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
diff --git a/drivers/scsi/fnic/fip.c b/drivers/scsi/fnic/fip.c
index e08a4f5ac2176..60b2dde038dbd 100644
--- a/drivers/scsi/fnic/fip.c
+++ b/drivers/scsi/fnic/fip.c
@@ -737,7 +737,7 @@ void fnic_work_on_fip_timer(struct work_struct *work)
 		if (memcmp(iport->selected_fcf.fcf_mac, zmac, ETH_ALEN) != 0) {
 
 			if (iport->flags & FNIC_FIRST_LINK_UP) {
-				fnic_scsi_fcpio_reset(iport->fnic);
+				fnic_fcpio_reset(iport->fnic);
 				iport->flags &= ~FNIC_FIRST_LINK_UP;
 			}
 
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 1199d701c3f59..f47e363cc3d88 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -511,7 +511,6 @@ int fnic_host_reset(struct Scsi_Host *shost);
 void fnic_reset(struct Scsi_Host *shost);
 int fnic_issue_fc_host_lip(struct Scsi_Host *shost);
 void fnic_get_host_port_state(struct Scsi_Host *shost);
-void fnic_scsi_fcpio_reset(struct fnic *fnic);
 int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do, unsigned int cq_index);
 int fnic_wq_cmpl_handler(struct fnic *fnic, int);
 int fnic_flogi_reg_handler(struct fnic *fnic, u32);
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 103ab6f1f7cd1..eee8cc81f430d 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -1108,3 +1108,53 @@ void fnic_reset_work_handler(struct work_struct *work)
 	spin_unlock_irqrestore(&reset_fnic_list_lock,
 						   reset_fnic_list_lock_flags);
 }
+
+void fnic_fcpio_reset(struct fnic *fnic)
+{
+	unsigned long flags;
+	enum fnic_state old_state;
+	struct fnic_iport_s *iport = &fnic->iport;
+	DECLARE_COMPLETION_ONSTACK(fw_reset_done);
+	int time_remain;
+
+	/* issue fw reset */
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	if (unlikely(fnic->state == FNIC_IN_FC_TRANS_ETH_MODE)) {
+		/* fw reset is in progress, poll for its completion */
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+			  "fnic is in unexpected state: %d for fw_reset\n",
+			  fnic->state);
+		return;
+	}
+
+	old_state = fnic->state;
+	fnic->state = FNIC_IN_FC_TRANS_ETH_MODE;
+
+	fnic_update_mac_locked(fnic, iport->hwmac);
+	fnic->fw_reset_done = &fw_reset_done;
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+				"Issuing fw reset\n");
+	if (fnic_fw_reset_handler(fnic)) {
+		spin_lock_irqsave(&fnic->fnic_lock, flags);
+		if (fnic->state == FNIC_IN_FC_TRANS_ETH_MODE)
+			fnic->state = old_state;
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+	} else {
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+					  "Waiting for fw completion\n");
+		time_remain = wait_for_completion_timeout(&fw_reset_done,
+						  msecs_to_jiffies(FNIC_FW_RESET_TIMEOUT));
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+					  "Woken up after fw completion timeout\n");
+		if (time_remain == 0) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+				  "FW reset completion timed out after %d ms\n",
+				  FNIC_FW_RESET_TIMEOUT);
+		}
+		atomic64_inc(&fnic->fnic_stats.reset_stats.fw_reset_timeouts);
+	}
+	fnic->fw_reset_done = NULL;
+}
diff --git a/drivers/scsi/fnic/fnic_fdls.h b/drivers/scsi/fnic/fnic_fdls.h
index 531d0b37e450f..e2959120c4f9f 100644
--- a/drivers/scsi/fnic/fnic_fdls.h
+++ b/drivers/scsi/fnic/fnic_fdls.h
@@ -410,6 +410,7 @@ void fnic_fdls_add_tport(struct fnic_iport_s *iport,
 void fnic_fdls_remove_tport(struct fnic_iport_s *iport,
 			    struct fnic_tport_s *tport,
 			    unsigned long flags);
+void fnic_fcpio_reset(struct fnic *fnic);
 
 /* fip.c */
 void fnic_fcoe_send_vlan_req(struct fnic *fnic);
@@ -422,7 +423,6 @@ void fnic_handle_fip_timer(struct timer_list *t);
 extern void fdls_fabric_timer_callback(struct timer_list *t);
 
 /* fnic_scsi.c */
-void fnic_scsi_fcpio_reset(struct fnic *fnic);
 extern void fdls_fabric_timer_callback(struct timer_list *t);
 void fnic_rport_exch_reset(struct fnic *fnic, u32 fcid);
 int fnic_fdls_register_portid(struct fnic_iport_s *iport, u32 port_id,
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 75b29a018d1f3..336ed944a26ea 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1974,8 +1974,7 @@ void fnic_scsi_unload(struct fnic *fnic)
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
 	if (fdls_get_state(&fnic->iport.fabric) != FDLS_STATE_INIT)
-		fnic_scsi_fcpio_reset(fnic);
-
+		fnic_fcpio_reset(fnic);
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	fnic->in_remove = 1;
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
@@ -3039,54 +3038,3 @@ int fnic_eh_host_reset_handler(struct scsi_cmnd *sc)
 	ret = fnic_host_reset(shost);
 	return ret;
 }
-
-
-void fnic_scsi_fcpio_reset(struct fnic *fnic)
-{
-	unsigned long flags;
-	enum fnic_state old_state;
-	struct fnic_iport_s *iport = &fnic->iport;
-	DECLARE_COMPLETION_ONSTACK(fw_reset_done);
-	int time_remain;
-
-	/* issue fw reset */
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	if (unlikely(fnic->state == FNIC_IN_FC_TRANS_ETH_MODE)) {
-		/* fw reset is in progress, poll for its completion */
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
-			  "fnic is in unexpected state: %d for fw_reset\n",
-			  fnic->state);
-		return;
-	}
-
-	old_state = fnic->state;
-	fnic->state = FNIC_IN_FC_TRANS_ETH_MODE;
-
-	fnic_update_mac_locked(fnic, iport->hwmac);
-	fnic->fw_reset_done = &fw_reset_done;
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-
-	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
-				  "Issuing fw reset\n");
-	if (fnic_fw_reset_handler(fnic)) {
-		spin_lock_irqsave(&fnic->fnic_lock, flags);
-		if (fnic->state == FNIC_IN_FC_TRANS_ETH_MODE)
-			fnic->state = old_state;
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-	} else {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
-					  "Waiting for fw completion\n");
-		time_remain = wait_for_completion_timeout(&fw_reset_done,
-						  msecs_to_jiffies(FNIC_FW_RESET_TIMEOUT));
-		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
-					  "Woken up after fw completion timeout\n");
-		if (time_remain == 0) {
-			FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
-				  "FW reset completion timed out after %d ms)\n",
-				  FNIC_FW_RESET_TIMEOUT);
-		}
-		atomic64_inc(&fnic->fnic_stats.reset_stats.fw_reset_timeouts);
-	}
-	fnic->fw_reset_done = NULL;
-}
-- 
2.53.0

