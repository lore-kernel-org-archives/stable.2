Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4942DA74C;
	Sun, 27 Sep 2026 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790508824; cv=none; b=Z0C6tdweoM60Vfo3uyxzJDbM/X944mmHrzOxv3kqEVJn8Iyqths9uWk15nVJI+FMo6BWlKHPEXeEJYAXkVZv5JHXQvldpTnBdavibh+DhHWhV5NNuUaB4/SYk4TUmLerK1RjXxnfu8E+M1gWUdzZJJTI4tUmQwj1HtKN8Eeef7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790508824; c=relaxed/simple;
	bh=hiiDBhkZhr1vSFbZt52zy9SiU6MTUsM6ifedJ9XXUAY=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P4H9yw7JMREBmuLWb5ULdFyFdYCo4NPpEgfNojkAISwR/F7tH7HfEfpD8zsSPdDah2mrRDXdNGTqhouACffxrlXTaVypwNg/VqDY1WUJSgbP8REJeXL/zh+yuLcOArwYK55GNi/uiLpNZ0mXg3ti9osDkfMgszkxAtae7A5gFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gE6kiv4H; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gE6kiv4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1790508810; x=1790768010;
	bh=upvI30Az1p8dx9dZwcQTxsd7N9NRhj5gu1HTDv1Ukdk=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gE6kiv4HtMNiUitiXGODPpPLOHgtetSkmMzlXgx2J8xIC5C8ANewc/eqrQTAWsKGs
	 Yh97okgH9kWL6nINxMEJ/LELdgj/IJKFUDmCP7q5eYHLT8ydFWF0htWrXUyy/T5lwk
	 ZfHdj7FVAth2vKSJlTUVg4sANpLH5nuaO4O3H0cKRMw7u4StQmLheXEFv+7Pnq8ESl
	 Wiqm+w/N5iVY71U8PLiv6RSmJpJU2TnlzBwHxRPxc+DYniLU7r63CrERRMgz5AWrEK
	 cK7W41tRr1RHf7wEd881uUlGDKXDB+rNFBOoowFRFWO/QBx2e0sQDmoOp1CHe6fGBD
	 2HFRLblZ6OMHg==
Date: Sun, 27 Sep 2026 11:33:27 +0000
From: Adis Veletanlic <adisveletanlic@proton.me>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Adis Veletanlic <adisveletanlic@proton.me>
Subject: [PATCH wireless] wifi: iwlwifi: mvm: fix self-deadlock in WoWLAN key programming
Message-ID: <20260927-main-v1-1-0d59a25f0373@proton.me>
Feedback-ID: 138116827:user:proton
X-Pm-Message-ID: c5758af94b8fe9ec5c548a93742f87b047ace254
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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

 ieee80211 phy0: PM: **** DPM device timeout after 30 seconds; 30 seconds u=
ntil panic ****
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
iwl_mvm_wowlan_config_key_params() but left the locking inside the iterator=
.

This was tested on the 3168 with WoWLAN enabled: pm_test=3Ddevices and a
real S3 suspend/resume cycle both complete, and the connection comes
back after resume.

Fixes: 6ba40cd3a99b ("wifi: iwlwifi: mvm: d3: avoid intermediate/early mute=
x unlock")
Cc: stable@vger.kernel.org
Signed-off-by: Adis Veletanlic <adisveletanlic@proton.me>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wire=
less/intel/iwlwifi/mvm/d3.c
index 6b11fa32ea5c..02b3abb47253 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -117,6 +117,8 @@ static void iwl_mvm_wowlan_program_keys(struct ieee8021=
1_hw *hw,
 =09struct wowlan_key_reprogram_data *data =3D _data;
 =09int ret;
=20
+=09lockdep_assert_held(&mvm->mutex);
+
 =09switch (key->cipher) {
 =09case WLAN_CIPHER_SUITE_WEP40:
 =09case WLAN_CIPHER_SUITE_WEP104: { /* hack it for now */
@@ -150,7 +152,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee8021=
1_hw *hw,
 =09=09=09wep_key->key_offset =3D data->wep_key_idx;
 =09=09}
=20
-=09=09mutex_lock(&mvm->mutex);
 =09=09ret =3D iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0,
 =09=09=09=09=09   __struct_size(wkc), wkc);
 =09=09data->error =3D ret !=3D 0;
@@ -159,7 +160,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee8021=
1_hw *hw,
 =09=09mvm->ptk_icvlen =3D key->icv_len;
 =09=09mvm->gtk_ivlen =3D key->iv_len;
 =09=09mvm->gtk_icvlen =3D key->icv_len;
-=09=09mutex_unlock(&mvm->mutex);
=20
 =09=09/* don't upload key again */
 =09=09return;
@@ -186,7 +186,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee8021=
1_hw *hw,
 =09=09break;
 =09}
=20
-=09mutex_lock(&mvm->mutex);
 =09/*
 =09 * The D3 firmware hardcodes the key offset 0 as the key it
 =09 * uses to transmit packets to the AP, i.e. the PTK.
@@ -206,7 +205,6 @@ static void iwl_mvm_wowlan_program_keys(struct ieee8021=
1_hw *hw,
 =09=09mvm->gtk_icvlen =3D key->icv_len;
 =09=09ret =3D iwl_mvm_set_sta_key(mvm, vif, sta, key, 1);
 =09}
-=09mutex_unlock(&mvm->mutex);
 =09data->error =3D ret !=3D 0;
 }
=20
@@ -1012,8 +1010,8 @@ static int iwl_mvm_wowlan_config_key_params(struct iw=
l_mvm *mvm,
 =09=09/*
 =09=09 * Note that currently we don't use CMD_ASYNC in the iterator.
 =09=09 * In case of key_data.configure_keys, all the configured
-=09=09 * commands are SYNC, and iwl_mvm_wowlan_program_keys() will
-=09=09 * take care of locking/unlocking mvm->mutex.
+=09=09 * commands are SYNC and run under mvm->mutex, which the
+=09=09 * caller holds.
 =09=09 */
 =09=09ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_program_keys,
 =09=09=09=09    &key_data);

---
base-commit: 2445e83a434a1964e574f792bd4b8e921cb9d54d
change-id: 20260927-main-b6a53ed439c1

Best regards,
-- =20
Adis Veletanlic <adisveletanlic@proton.me>


