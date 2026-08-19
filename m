Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3693C109A;
	Wed, 19 Aug 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121770; cv=none; b=jQWt2WVZo4DwmolrtJ5QDPa0/V9D10UKWyDuIbWPgDWuf1zifgxs7bjJ4b77v4xiAfzWqkravAPG61HTCqqnTUTldZq30OQKNgTpGDV6WnKXuJb7trXJKueLN/HEXCix+P+hnQtdxCe+ILlEmqBLxlBwdSN8WxcXjgkm59DtKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121770; c=relaxed/simple;
	bh=lZIDQoOOoz3iM0k+k7zjbJaDlAAGeBZJIqClYMnS1Gk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FWjvTCbQg7204F9/uscmJ/pXTuReFT0HzoLbq2tLXGB0WNZfyhyuCALiq6tXOuIG4Dvu7VL/d/DIyuk4cqhOJuc1QJvDKrRubpcYRm1/E+uRcgTPdCWW3ydIpKzUsMwrvFrMCBU1WwsKQyjhHE2pl8duB6WludzQVKpCMg/2DDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBnQX5dUIVq9qGnAA--.35636S3;
	Wed, 19 Aug 2026 14:42:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn1cpbUIVqpb79Aw--.36573S2;
	Wed, 19 Aug 2026 14:42:36 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org
Cc: johannes.berg@intel.com,
	ilan.peer@intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] wifi: iwlwifi: mvm: fix use-after-free in MEI scan work
Date: Wed, 19 Aug 2026 06:41:39 +0000
Message-Id: <20260819064139.15270-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn1cpbUIVqpb79Aw--.36573S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?//IYCwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2JmA4ZISfe0HWiyBsO4pnbmA3jX6LpOmW94e5KT8E8D512
	8+L0YQ9+13Yd+lPi3aep9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7uF4UZF4UuF18uFW5Kr4Dtrc_yoW8CFWDpF
	ZxC34UAr4j9FWIy3y5Ka1fuF95Jw4Yg393CFW5K3s8Jrn0qF1Yyr109ay7ZryFyFWkA3ya
	vF4DtFW5WFn5X3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

While a MEI limited scan is in progress, iwl_mvm_mei_filter_scan()
queues beacon and probe-response frames and schedules
iwl_mvm_mei_scan_work() to re-inject matching frames into mac80211.

Nothing cancels this work.  When the driver is unloaded,
iwl_op_mode_mvm_stop() eventually frees mvm as part of
ieee80211_free_hw().  A queued or running work item could then
dereference the freed mvm: its handler obtains mvm with
container_of(), takes mvm->mutex, and accesses csme_conn_info, which
the stop path frees before ieee80211_free_hw().

Cancel and drain the work in iwl_mvm_mac_stop(), after RX has been
stopped and after releasing mvm->mutex, which the work handler takes.
Also purge queued scan results.

This issue was found by an in-house static analysis tool.

Fixes: 0d2558838ee8 ("wifi: iwlwifi: modify scan request and results when in link protection")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 74bd4038f..8b123f6df 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1423,6 +1423,10 @@ void iwl_mvm_mac_stop(struct ieee80211_hw *hw, bool suspend)
 	 */
 	cancel_work_sync(&mvm->async_handlers_wk);
 	wiphy_work_cancel(hw->wiphy, &mvm->async_handlers_wiphy_wk);
+
+	/* The work takes mvm->mutex, so cancel it after releasing the mutex. */
+	cancel_work_sync(&mvm->mei_scan_filter.scan_work);
+	skb_queue_purge(&mvm->mei_scan_filter.scan_res);
 }

 struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm)

