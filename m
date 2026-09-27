Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4873C09E2;
	Sun, 27 Sep 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509062; cv=none; b=TM7NAw3W74/5Slq0tKIB/IBRtz3JJOtFgwKZArrHYIcUC7Ll85iw3MHFHoS64TbRuUBBnQNLEvQtOkf7ckhx5R9Ymuq42v5w5mazN2i0GJlwY1nTzHIiqT6DQvVHK4qgAnnratyoYNtEz1VxTgaiQmImBVQoymAMoFbbYaArCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509062; c=relaxed/simple;
	bh=Qy5hnlHHGjyWV+i16keeg81dw0mpBzzn/D2iOIsWyKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FH1p5QPWvUUMGCaOnxykULPQcC8P+clJJrtzvb7TRljnaBjqWb6bsnKOuCFMdtoLTuoBVXvJ+BWKQFjzqgl2i53MtztSse4zpIxCiCEmP506J/9mQIoGhRTCMMTYUVI7p11WhQ8BP4B0u9RkIINeWtrbamW7kOXeE2PT2VEEAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDQjk2bO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDQjk2bO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B9FDC2BCB3;
	Sun, 27 Sep 2026 11:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790509062;
	bh=Qy5hnlHHGjyWV+i16keeg81dw0mpBzzn/D2iOIsWyKM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iDQjk2bO5vbJiUTQ9KOeu9uutl4fl8KZsgnlJFFMHgFwUzakW3We2s6iszLK3k0T9
	 3QDa3bxfMpfit4Aje6Ac5TGOlw/oLYcUEgpSTdsplhUBwiCJzB/j5Wy/Efq2MyAU3R
	 kHtXePmkWFm3BoV3rdQZHBwTyqkdZAE9BaVNOxxH0YP7GHZyKHBW/UfjjLoNYXkSVq
	 YbtUayd26NnQR6Yjq0ApXnA4XdAon1vlA9NsX72rSg154pGC+EtIAaOWdbeuRaZaTI
	 XHIHY94mfUn/i59+ELf7NI/eXQJj73gdMC1j9Be1NcSVlkY9ePlGl0Hm7Xq5Mz2xqq
	 G6Fq1TpzpreGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D5C98332;
	Sun, 27 Sep 2026 11:37:42 +0000 (UTC)
From: Adis Veletanlic via B4 Relay <devnull+adisveletanlic.proton.me@kernel.org>
Date: Sun, 27 Sep 2026 13:37:39 +0200
Subject: [PATCH wireless] wifi: iwlwifi: mvm: fix self-deadlock in WoWLAN
 key programming
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-main-v1-1-660ffbc9837c@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBQFr0Le2iZQBINXMSxKeeo3Wkg/Cgnh7
 hZdTmYyK5RRqDhnKyI/ojKEBMUhg7+7cKORPjFsbuu8sSfzchJMV7uqZH8sG18gpWPkVZbf5oJ
 ZIp9URfs3+u4e9NN+wbZ9ARgwkoVyAAAA
X-Change-ID: 20260927-main-b6a53ed439c1
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Adis Veletanlic <adisveletanlic@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4811;
 i=adisveletanlic@proton.me; h=from:subject:message-id;
 bh=Py9OOavcJWfI54ATz2gHGBtGP+FmEcLIVCbnQwjgG+Q=;
 b=owEBCQL2/ZANAwAIAWBVJ/vOa9TGAcsmYgBquQAFuN4tLOk/dAqHS73q3b/S6KKnGNfF6xdSo
 iUlBDQZt/+JAc8EAAEIADkWIQSbWhJPTsnk/hC9Y9tgVSf7zmvUxgUCarkABRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQYFUn+85r1MaDgwwAox5GpNoIuIA3e+XNv/RMB8O+NGX06Aq
 5yY4RQRvympDZCsQPUCGuw4WjubUuUGR1eAcit203du0A3NzDHHq/qSoZJ2ey9N+hIMeaxAa2eN
 OLmx+yQAZ4GeQhwPPTIZE7Uy8bAJjuNTs57E2nQhf2+qXwNhp22lFZ8ERKzWuV5DUYJ9NVUXSL1
 TfxAsI4su9qsfDyyQxBdmcJOkwPafy4Cl0R4g3C7y5+rK+dvWJXl6zD85zIYZMzb2GOCRiKRt7A
 XWXATTt695qzhzrx2Z1YhJ5sEtV7Q+LMdqLlZRSxOhPojHmwZ2KX7Ui8kooWpCPTMQP4q7AhTIc
 V3wBHtGihVjvbEmXpvzAglw2Qf4Ga57pdQeA8HvdMeHQdkujp0yaHgjltXmXHukcKw1nNlaKHqL
 GOaCPhYTOAWDr8s1vDxX8E4Ew4cX3rPICVmygP0fJUuBV110ACUDAxv+2GK1VVfg49WWc1hJsOY
 40sp3VAq0UIqBSEHAARUzIm0nVAPcF3
X-Developer-Key: i=adisveletanlic@proton.me; a=openpgp;
 fpr=9B5A124F4EC9E4FE10BD63DB605527FBCE6BD4C6
X-Endpoint-Received: by B4 Relay for adisveletanlic@proton.me/default with
 auth_id=1068
X-Original-From: Adis Veletanlic <adisveletanlic@proton.me>
Reply-To: adisveletanlic@proton.me

From: Adis Veletanlic <adisveletanlic@proton.me>

__iwl_mvm_suspend() takes mvm->mutex and holds it for the whole WoWLAN
configuration. But on devices with firmware that has no unified D3/D0
image iwl_mvm_wowlan_config_key_params() then calls
ieee80211_iter_keys() with iwl_mvm_wowlan_program_keys() as the
iterator, and that iterator then takes mvm->mutex again. This causes the
suspend thread to block on a mutex it is already holding and system
suspend never completes.

This was seen on an Intel Wireless-AC 3168 (firmware 29.0bd893f3.0)
while associated with WoWLAN enabled. With CONFIG_DPM_WATCHDOG the stuck
task is:

 ieee80211 phy0: PM: **** DPM device timeout after 30 seconds; 30 seconds until panic ****
 Call Trace:
  <TASK>
  __schedule+0x2cb/0x740
  schedule+0x27/0xa0
  schedule_preempt_disabled+0x15/0x30
  __mutex_lock.constprop.0+0x53a/0xa50
  iwl_mvm_wowlan_program_keys+0x1a1/0x220 [iwlmvm]
  ieee80211_iter_keys+0x77/0x160 [mac80211]
  iwl_mvm_wowlan_config_key_params+0x5f/0x390 [iwlmvm]
  iwl_mvm_wowlan_config.isra.0+0x9b/0x190 [iwlmvm]
  __iwl_mvm_suspend.isra.0+0x1c7/0x340 [iwlmvm]
  drv_suspend+0x25/0xc0 [mac80211]
  __ieee80211_suspend+0x1d2/0x300 [mac80211]
  rdev_suspend+0x25/0xe0 [cfg80211]
  wiphy_suspend+0x95/0x180 [cfg80211]
  dpm_run_callback+0x4a/0x140
  device_suspend+0x212/0x530
  async_suspend+0x21/0x30
  async_run_entry_fn+0x34/0x130
  process_one_work+0x192/0x350
  worker_thread+0x196/0x300
  kthread+0xfc/0x240
  ret_from_fork+0x153/0x170
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Any other devices taking rtnl_lock in their suspend callback block
behind it as well. The iterator is only called from this path, and the
mutex is always held there. Remove the inner lock/unlock pairs and
assert that the mutex is held instead. The other key iterators used for
D3 don't take the mutex, so resume is not affected.

Commit 6ba40cd3a99b ("wifi: iwlwifi: mvm: d3: avoid intermediate/early
mutex unlock") removed the unlock/relock around
iwl_mvm_wowlan_config_key_params() but left the locking inside the iterator.

This was tested on the 3168 with WoWLAN enabled: pm_test=devices and a
real S3 suspend/resume cycle both complete, and the connection comes
back after resume.

Fixes: 6ba40cd3a99b ("wifi: iwlwifi: mvm: d3: avoid intermediate/early mutex unlock")
Cc: stable@vger.kernel.org
Signed-off-by: Adis Veletanlic <adisveletanlic@proton.me>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6b11fa32ea5c..02b3abb47253 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -117,6 +117,8 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 	struct wowlan_key_reprogram_data *data = _data;
 	int ret;
 
+	lockdep_assert_held(&mvm->mutex);
+
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104: { /* hack it for now */
@@ -150,7 +152,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 			wep_key->key_offset = data->wep_key_idx;
 		}
 
-		mutex_lock(&mvm->mutex);
 		ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0,
 					   __struct_size(wkc), wkc);
 		data->error = ret != 0;
@@ -159,7 +160,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		mvm->ptk_icvlen = key->icv_len;
 		mvm->gtk_ivlen = key->iv_len;
 		mvm->gtk_icvlen = key->icv_len;
-		mutex_unlock(&mvm->mutex);
 
 		/* don't upload key again */
 		return;
@@ -186,7 +186,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		break;
 	}
 
-	mutex_lock(&mvm->mutex);
 	/*
 	 * The D3 firmware hardcodes the key offset 0 as the key it
 	 * uses to transmit packets to the AP, i.e. the PTK.
@@ -206,7 +205,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		mvm->gtk_icvlen = key->icv_len;
 		ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, 1);
 	}
-	mutex_unlock(&mvm->mutex);
 	data->error = ret != 0;
 }
 
@@ -1012,8 +1010,8 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		/*
 		 * Note that currently we don't use CMD_ASYNC in the iterator.
 		 * In case of key_data.configure_keys, all the configured
-		 * commands are SYNC, and iwl_mvm_wowlan_program_keys() will
-		 * take care of locking/unlocking mvm->mutex.
+		 * commands are SYNC and run under mvm->mutex, which the
+		 * caller holds.
 		 */
 		ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_program_keys,
 				    &key_data);

---
base-commit: 2445e83a434a1964e574f792bd4b8e921cb9d54d
change-id: 20260927-main-b6a53ed439c1

Best regards,
--  
Adis Veletanlic <adisveletanlic@proton.me>


