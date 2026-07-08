Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD83DFC7E
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540793; cv=none; b=fcW8MHCT/LdlWbrfKKrMG9BImsJN2jOc8xxHhYUUlgECRK1D6wWP8o+abi/ZJkxFHRrLR8xPBVvjm0VhdwOV/Yjb6rgkWlOHLXofcvGv/zIIBZF3R0nMDag836vrLFDU3S5IvDfuw1H0/4uzIsduFznTJ5z6nivX/LhhKu/wE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540793; c=relaxed/simple;
	bh=Uf9pnj9cZCbPf/zyBG62pNQsDuDlVajrDgR/OyoOBs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IODs+QVdmx2F189DWlEExvzLhusastvN+E9BkkP47VIofD580939fLgFLkFx4jbXYhTKdd9s9mgsIn8eA2xNHodlKvcHdmnBGHb68anxCMP3a/3G36KjflXVps1lDdi28QIEn3ArR16Augka+8tWtHhXlWxm7BjBineFV5Bv3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhD5CZN+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhD5CZN+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8478fe07f65so1124978b3a.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540791; x=1784145591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/ey8QeZ6+UPoe0vo9GrwAwJd/n64hr2yFgoo4y/5Ps=;
        b=DhD5CZN+HdXAlvLwuovbzDczT9+hGf17YgFmLd+4IIPVRtT7q2/GkuhhPGfuI8A0co
         wsdWa+/0qEn20Exe0DYu5/9zVrRrrJJAGvHhQo9a+/8Q1KxhpEuRzh2Kr+hTL5TC5EAU
         MwcK2nOrGEYMp+n8zzdUBQqUHJdheqx9jLlLdLgWZ7Hyzq4tWP0d1FYBAVMebXXFy83W
         wGFbJ5RHCeZhzqkyabpesk2CP/iygMAISOrdAdSJ+ywoZjMvYvwyYMF2kx1L6emZ9xhC
         xM0ymJ2tp4EVSbXscI3+rWG9CnUiKrhLGC5KkXFfIaUFnfJG+l/EJBvhSk5k7Sd5ctfy
         PHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540791; x=1784145591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/ey8QeZ6+UPoe0vo9GrwAwJd/n64hr2yFgoo4y/5Ps=;
        b=TFd2BQlLZK3MUU5StIXhiZTPMA7fh5j3YXvWRMsaiPFhWT8Zq1wFkkSrmUHcknzdFe
         uFwqHsFs/1sjuXruNRsS6aiIvCZK4WFVmk67uf7p6mGmZMzZ1cyn1E52eGKjH2Fd3ckL
         OsMoO0kRxtt87uh8QmXN61PraSssi6kEnl+eOzlXsrqymICdABeJdat0Pt98KgPhAxJl
         7B7RuoKEYSOQpR5DwOrbA9QTGgE6PsK6Bd2BBhlj+6EfIY4ja32voM3xLI7UyUvPJDOG
         CtP92Gimw82s9Iqiaz9HI61afDX0SvufpHx7dlhjqZsthoovn2hiS4jYEku8CrXf35NI
         M05A==
X-Forwarded-Encrypted: i=1; AHgh+Ro/LVKq8rjkIVwXfaul65/XFQ5aIjh01jwEVvhYDpQrlzA23MJy8ctyqgRjQ3P1L9T365WNaUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyohYxFsyAAUsmSRjVVSPWmKO77ezqaIMYJ64dmhpdxuG2i+nW
	x4LdKfhJqPwS7VTQysFwLXJDi2LU2ppHdxY8R6tp7eCPIvhArSNtV4si
X-Gm-Gg: AfdE7clzxGvHEzzOvYlDs9xXEGzQtWPxe+R0XgW8uvwqs0qKnyI+uF+aLiR+ashYF5x
	GibTAca9zpP1f5VNmEHkQPok3l1JnM5hnqdW6zch5PaPjnLn0na6PRXePwsDrkGWPHa34sopUyW
	YdP8g7czd2nq1HSe1WqKEW1qGxmXnO5bMDJIPAaH48lxXlE3JxDmLzgOwNEQ2Rrt3GVFKqos/9Z
	B0vp2538y25qoqSPy3MYDYxWQnRPwpU+fryFyhhaijx2G7aDTK8P/Jy1itozRsyaaMqPT2ivjU5
	DrrArUU07VEZVilaS41qZ69K+orp6WLk2cd4vlBJ6wMowwfv4jIlYwLoTF9fnH4//SXdWiJxwI1
	ovgChH/6V2hB8AJUc0tZT74e0u2anobTs/nZ4ihIbKKcVTsdn780YQ3K4QJwpZzItx5eE6W1xeb
	M3tiR/36uMldaHITZla63D47GRc0LltVYbeWb3/YB7D7HmlEsghWOL
X-Received: by 2002:a05:6a21:e8a:b0:3bf:bfd0:2a11 with SMTP id adf61e73a8af0-3c0bcbc03c5mr4785352637.43.1783540791051;
        Wed, 08 Jul 2026 12:59:51 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.12.59.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 12:59:50 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaewan Kim <jaewan@google.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	John Crispin <john@phrozen.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/8] wifi: iwlwifi: mld: abort active PMSR requests
Date: Thu,  9 Jul 2026 03:59:06 +0800
Message-ID: <20260708195911.84365-4-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708195911.84365-1-enderaoelyther@gmail.com>
References: <20260708195911.84365-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iwlwifi MLD driver registers .start_pmsr (iwl_mld_start_pmsr ->
iwl_mld_ftm_start) but not .abort_pmsr. iwl_mld_ftm_start() stores the
cfg80211 peer-measurement request in mld->ftm_initiator.req and the
owning wdev in mld->ftm_initiator.req_wdev, and keeps both until a TOF
range response completes the measurement.

When the user space that started the FTM session closes its netlink
socket (or the wdev goes down) while the measurement is still in
flight, cfg80211_release_pmsr()/cfg80211_pmsr_wdev_down() schedule the
abort work and cfg80211_pmsr_process_abort() runs:

	rdev_abort_pmsr(rdev, wdev, req);
	kfree(req);

rdev_abort_pmsr() only calls the driver op when ops->abort_pmsr is
set, so for MLD it is a no-op. The request is freed while
mld->ftm_initiator.req still points at it; nothing clears the
pointer.

A subsequent TOF range response from the firmware reaches
iwl_mld_handle_ftm_resp_notif(). The !mld->ftm_initiator.req guard
does not catch this because the pointer is dangling, not NULL, so the
handler dereferences the freed request (req->cookie, req->n_peers,
req->peers[]) and passes it with req_wdev to
cfg80211_pmsr_report()/cfg80211_pmsr_complete(); a use-after-free of
the already freed request.

Implement .abort_pmsr. iwl_mld_ftm_abort() checks that the aborted
request is the active one, cancels the pending FTM notifications,
resets the ftm_initiator state (clearing req and req_wdev), and sends
TOF_RANGE_ABORT_CMD to the firmware so no further range responses are
generated for the aborted request.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 .../intel/iwlwifi/mld/ftm-initiator.c         | 22 +++++++++++++++++++
 .../intel/iwlwifi/mld/ftm-initiator.h         |  2 ++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 10 +++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
index 81df3fdfcbf56..b18e4fa9dedf1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
@@ -13,6 +13,7 @@
 #include "constants.h"
 #include "fw/api/location.h"
 #include "ftm-initiator.h"
+#include "hcmd.h"
 
 static void iwl_mld_ftm_cmd_common(struct iwl_mld *mld,
 				   struct ieee80211_vif *vif,
@@ -282,6 +283,27 @@ static void iwl_mld_ftm_reset(struct iwl_mld *mld)
 	       sizeof(mld->ftm_initiator.responses));
 }
 
+void iwl_mld_ftm_abort(struct iwl_mld *mld,
+		       struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_abort_cmd cmd = {
+		.request_id = req->cookie,
+	};
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (req != mld->ftm_initiator.req)
+		return;
+
+	iwl_mld_cancel_notifications_of_object(mld, IWL_MLD_OBJECT_TYPE_FTM_REQ,
+					       (u8)req->cookie);
+	iwl_mld_ftm_reset(mld);
+
+	if (iwl_mld_send_cmd_pdu(mld, WIDE_ID(LOCATION_GROUP, TOF_RANGE_ABORT_CMD),
+				 &cmd))
+		IWL_ERR(mld, "failed to abort FTM process\n");
+}
+
 static int iwl_mld_ftm_range_resp_valid(struct iwl_mld *mld, u8 request_id,
 					u8 num_of_aps)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
index 3fab25a52508a..7b807605af503 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
@@ -21,6 +21,8 @@ struct ftm_initiator_data {
 
 int iwl_mld_ftm_start(struct iwl_mld *mld, struct ieee80211_vif *vif,
 		      struct cfg80211_pmsr_request *req);
+void iwl_mld_ftm_abort(struct iwl_mld *mld,
+		       struct cfg80211_pmsr_request *req);
 
 void iwl_mld_handle_ftm_resp_notif(struct iwl_mld *mld,
 				   struct iwl_rx_packet *pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 17286b3341c02..614c55967fcca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2853,6 +2853,15 @@ static int iwl_mld_start_pmsr(struct ieee80211_hw *hw,
 	return iwl_mld_ftm_start(mld, vif, request);
 }
 
+static void iwl_mld_abort_pmsr(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct cfg80211_pmsr_request *request)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+
+	iwl_mld_ftm_abort(mld, request);
+}
+
 static enum ieee80211_neg_ttlm_res
 iwl_mld_can_neg_ttlm(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     struct ieee80211_neg_ttlm *neg_ttlm)
@@ -2974,6 +2983,7 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.prep_add_interface = iwl_mld_prep_add_interface,
 	.set_hw_timestamp = iwl_mld_set_hw_timestamp,
 	.start_pmsr = iwl_mld_start_pmsr,
+	.abort_pmsr = iwl_mld_abort_pmsr,
 	.can_neg_ttlm = iwl_mld_can_neg_ttlm,
 	.start_nan = iwl_mld_start_nan,
 	.stop_nan = iwl_mld_stop_nan,
-- 
2.50.1 (Apple Git-155)
