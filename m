Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084238;
	b=S9BUUwEFEAJINzQcfpTAWA4DAiBw6lv4by6j1CiMS9tbAbEUsN/tsWZHCHFTsgKsVMls
	 quW/oj8RcZvYjqh+DomCp5IBsYswomA47urPZF77x94Pxr7DlAKMcrs1TAdsOd7KeQZek
	 rKWOCJEIY5S+EQ5ZwlAQD7GGRE0qJuYGlpTp7cuOJfc93b/dYV/VoBj5MLJ6AsYBJd1o1
	 +MlPeY2WpnLeGFNvpNtS4r+W4Ru867kBntayb7ilr2RLPUkS69g9S9q40oRDdmtcMJW1T
	 LcVSrChqUQDeBCwW938YARaYNHtfvxrd5mkrj410/p+zATJ7SdM0zYd3VrxvgvEV8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084238;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LA6/4oRw8oW3ydQUfPkALhXAmnLtjkboCEAbPO7HiuM=;
	b=lwUJv0UH3Nr1PH6Rt1QI3giR1CCj5QSnBPNP9oFfkobGxBJzVu90Mwr0grnHzMm5YAXf
	 bvqT2fYz+E36QQNYsyswJGXvqe5jNHEghUSoHPidid6+HMvCTRqzFqV8JAopEimqyS0s/
	 4HQWnuqwZw2VpE+fhl3uAzwVdiy/aikVtMIEX81YO9hIIhXY5zfZHN9LGrOmI2jfdY6B9
	 0Bv30yBBmJLy1LaS3CsNAwkspo36z5FHNyIVnhCpqgFcO30dVWzIP5jvUHI1J5kaCzFvZ
	 7691ruozeK1c6JZnhHyuUPDKQRFUg6NCktdc8tlgeISsjmxPm3fbopdGY9YfO0PzOtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaeyeong.cc;
	spf=pass smtp.mailfrom=jaeyeong.cc;
	dkim=pass header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=MJflDaJl;
	arc=none smtp.remote-ip=109.224.244.118
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C59606A322;
	Tue, 27 Oct 2026 06:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C59606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=MJflDaJl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
	s=protonmail2; t=1793084233; x=1793343433;
	bh=LA6/4oRw8oW3ydQUfPkALhXAmnLtjkboCEAbPO7HiuM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MJflDaJljxkWNzxZaN2k63BkUdYnF0HSlOVgzh77W51H1DV6kP7CcBKuEebHfznOR
	 4+1RVcsbSp6m5toOwKPLJh7HcSeNd569RDNZcGHXOpuekBRWkaQk7HptZRqW9DB0oQ
	 wcfbaS3EEIE2P1DN83qX6dVUxvAL2ZKqnj+eKrEaFpaC1ND2Ib+x7VKcNMRIFoxaDu
	 pZPOjC5mo4qZqy7iFx11aYUZWngkb+3cJ43S/T11gzKP/QPXjxy1vQlfa67Tvmr2Eu
	 h0lx+ByUXpBnW0lmr2x3apH6lLPPuz++WxCs/RDxmqnaMGUwM5qDf6dmtjcdHA69PT
	 I+Ww+sAZTam1Q==
Date: Tue, 27 Oct 2026 06:57:07 +0000
To: Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Jaeyeong Lee <lee@jaeyeong.cc>, stable@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: serialize synchronous command buffer access
Message-ID: <20261027065700.918360-1-lee@jaeyeong.cc>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 25e874ea2cb111f1d31322a2e1152856e3d2a4cd
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Commit ef06882c7d8a ("wifi: mwifiex: Detach sync cmd buffer on
interrupted wait") clears a synchronous command data_buf after an
interrupted or timed-out wait. The response side does not hold
mwifiex_cmd_lock while using that pointer, however. It can cache
data_buf before the clear, then write to the caller stack after the
waiter returns. If the clear wins, three response handlers instead
dereference NULL.

The normal cfg80211 path is affected. An unprivileged
NL80211_CMD_GET_INTERFACE request on a connected HT interface reaches
get_channel, which passes a stack channel_band to a synchronous
STA_CONFIGURE command. Its response writes through data_buf. Raw host
commands have the same check/use window.

Move the detach into mwifiex_cancel_all_pending_cmd() while
mwifiex_cmd_lock is held and before completing the command. Dispatch
only the short, non-sleeping response handlers that copy to data_buf
under the same lock through their final write. Protect the VERSION_EXT
copy separately because its other branch queues a command. Serialize
the raw host-command copy as well, and let the three unconditional
handlers discard a detached buffer.

If cancellation wins the lock, a later response observes NULL. If the
response wins it, cancellation cannot wake the buffer owner until
copyout has completed.

Compile-tested with LLVM 22.1.8 and W=3D1. Runtime testing was not possible
because no supported mwifiex hardware was available.

Fixes: 3d026d09b28d ("mwifiex: cancel pending commands for signal")
Cc: stable@vger.kernel.org
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |   8 ++
 .../wireless/marvell/mwifiex/sta_cmdresp.c    | 119 ++++++++++++------
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |  12 --
 3 files changed, 89 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wi=
reless/marvell/mwifiex/cmdevt.c
index 6e04d7da6217..bf462dd17c52 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -838,11 +838,14 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *a=
dapter)
 =09=09mwifiex_dbg(adapter, INFO,
 =09=09=09    "info: host cmd resp size =3D %d\n", size);
 =09=09size =3D min_t(u16, size, MWIFIEX_SIZE_OF_CMD_BUFFER);
+=09=09/* Serialize against cancellation of the caller-owned buffer. */
+=09=09spin_lock_bh(&adapter->mwifiex_cmd_lock);
 =09=09if (adapter->curr_cmd->data_buf) {
 =09=09=09hostcmd =3D adapter->curr_cmd->data_buf;
 =09=09=09hostcmd->len =3D size;
 =09=09=09memcpy(hostcmd->cmd, resp, size);
 =09=09}
+=09=09spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 =09}
=20
 =09/* Get BSS number and corresponding priv */
@@ -1050,6 +1053,8 @@ mwifiex_cancel_all_pending_cmd(struct mwifiex_adapter=
 *adapter)
 =09spin_lock_bh(&adapter->mwifiex_cmd_lock);
 =09/* Cancel current cmd */
 =09if ((adapter->curr_cmd) && (adapter->curr_cmd->wait_q_enabled)) {
+=09=09/* Do not wake the owner while a response can still use its data. */
+=09=09adapter->curr_cmd->data_buf =3D NULL;
 =09=09adapter->cmd_wait_q.status =3D -1;
 =09=09mwifiex_complete_cmd(adapter, adapter->curr_cmd);
 =09=09adapter->curr_cmd->wait_q_enabled =3D false;
@@ -1702,6 +1707,9 @@ int mwifiex_ret_wakeup_reason(struct mwifiex_private =
*priv,
 =09=09=09      struct host_cmd_ds_command *resp,
 =09=09=09      struct host_cmd_ds_wakeup_reason *wakeup_reason)
 {
+=09if (!wakeup_reason)
+=09=09return 0;
+
 =09wakeup_reason->wakeup_reason =3D
 =09=09resp->params.hs_wakeup_reason.wakeup_reason;
=20
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/n=
et/wireless/marvell/mwifiex/sta_cmdresp.c
index 85512f526c5f..e59f52e97d7c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -691,12 +691,14 @@ static int mwifiex_ret_802_11d_domain_info(struct mwi=
fiex_private *priv,
  * to application.
  */
 static int mwifiex_ret_ver_ext(struct mwifiex_private *priv,
-=09=09=09       struct host_cmd_ds_command *resp,
-=09=09=09       struct host_cmd_ds_version_ext *version_ext)
+=09=09=09       struct host_cmd_ds_command *resp)
 {
+=09struct mwifiex_adapter *adapter =3D priv->adapter;
 =09struct host_cmd_ds_version_ext *ver_ext =3D &resp->params.verext;
+=09struct host_cmd_ds_version_ext *version_ext =3D NULL;
=20
-=09if (test_and_clear_bit(MWIFIEX_IS_REQUESTING_FW_VEREXT, &priv->adapter-=
>work_flags)) {
+=09if (test_and_clear_bit(MWIFIEX_IS_REQUESTING_FW_VEREXT,
+=09=09=09       &adapter->work_flags)) {
 =09=09if (strncmp(ver_ext->version_str, "ChipRev:20, BB:9b(10.00), RF:40(2=
1)",
 =09=09=09    MWIFIEX_VERSION_STR_LENGTH) =3D=3D 0) {
 =09=09=09struct mwifiex_ds_auto_ds auto_ds =3D {
@@ -716,6 +718,9 @@ static int mwifiex_ret_ver_ext(struct mwifiex_private *=
priv,
 =09=09return 0;
 =09}
=20
+=09spin_lock_bh(&adapter->mwifiex_cmd_lock);
+=09if (adapter->curr_cmd)
+=09=09version_ext =3D adapter->curr_cmd->data_buf;
 =09if (version_ext) {
 =09=09version_ext->version_str_sel =3D ver_ext->version_str_sel;
 =09=09memcpy(version_ext->version_str, ver_ext->version_str,
@@ -726,6 +731,8 @@ static int mwifiex_ret_ver_ext(struct mwifiex_private *=
priv,
 =09=09/* Ensure the version string from the firmware is 0-terminated */
 =09=09priv->version_str[MWIFIEX_VERSION_STR_LENGTH - 1] =3D '\0';
 =09}
+=09spin_unlock_bh(&adapter->mwifiex_cmd_lock);
+
 =09return 0;
 }
=20
@@ -1024,6 +1031,9 @@ static int mwifiex_ret_robust_coex(struct mwifiex_pri=
vate *priv,
 =09u16 action =3D le16_to_cpu(coex->action);
 =09u32 mode;
=20
+=09if (!is_timeshare)
+=09=09return 0;
+
 =09coex_tlv =3D (struct mwifiex_ie_types_robust_coex
 =09=09    *)((u8 *)coex + sizeof(struct host_cmd_ds_robust_coex));
 =09if (action =3D=3D HostCmd_ACT_GEN_GET) {
@@ -1194,6 +1204,9 @@ static int mwifiex_ret_get_chan_info(struct mwifiex_p=
rivate *priv,
 =09struct host_cmd_ds_sta_configure *sta_cfg_cmd =3D &resp->params.sta_cfg=
;
 =09struct host_cmd_tlv_channel_band *tlv_band_channel;
=20
+=09if (!channel_band)
+=09=09return 0;
+
 =09tlv_band_channel =3D
 =09(struct host_cmd_tlv_channel_band *)sta_cfg_cmd->tlv_buffer;
 =09memcpy(&channel_band->band_config, &tlv_band_channel->band_config,
@@ -1203,6 +1216,54 @@ static int mwifiex_ret_get_chan_info(struct mwifiex_=
private *priv,
 =09return 0;
 }
=20
+static bool
+mwifiex_process_sta_cmdresp_data_buf(struct mwifiex_private *priv,
+=09=09=09=09     u16 cmdresp_no,
+=09=09=09=09     struct host_cmd_ds_command *resp,
+=09=09=09=09     void *data_buf, int *ret)
+{
+=09lockdep_assert_held(&priv->adapter->mwifiex_cmd_lock);
+
+=09switch (cmdresp_no) {
+=09case HostCmd_CMD_802_11_PS_MODE_ENH:
+=09=09*ret =3D mwifiex_ret_enh_power_mode(priv, resp, data_buf);
+=09=09break;
+=09case HostCmd_CMD_802_11_GET_LOG:
+=09=09*ret =3D mwifiex_ret_get_log(priv, resp, data_buf);
+=09=09break;
+=09case HostCmd_CMD_802_11_SNMP_MIB:
+=09=09*ret =3D mwifiex_ret_802_11_snmp_mib(priv, resp, data_buf);
+=09=09break;
+=09case HostCmd_CMD_REMAIN_ON_CHAN:
+=09=09*ret =3D mwifiex_ret_remain_on_chan(priv, resp, data_buf);
+=09=09break;
+=09case HostCmd_CMD_P2P_MODE_CFG:
+=09=09*ret =3D mwifiex_ret_p2p_mode_cfg(priv, resp, data_buf);
+=09=09break;
+=09case HostCmd_CMD_MAC_REG_ACCESS:
+=09case HostCmd_CMD_BBP_REG_ACCESS:
+=09case HostCmd_CMD_RF_REG_ACCESS:
+=09case HostCmd_CMD_PMIC_REG_ACCESS:
+=09case HostCmd_CMD_CAU_REG_ACCESS:
+=09case HostCmd_CMD_802_11_EEPROM_ACCESS:
+=09=09*ret =3D mwifiex_ret_reg_access(cmdresp_no, resp, data_buf);
+=09=09break;
+=09case HostCmd_CMD_HS_WAKEUP_REASON:
+=09=09*ret =3D mwifiex_ret_wakeup_reason(priv, resp, data_buf);
+=09=09break;
+=09case HostCmd_CMD_ROBUST_COEX:
+=09=09*ret =3D mwifiex_ret_robust_coex(priv, resp, data_buf);
+=09=09break;
+=09case HostCmd_CMD_STA_CONFIGURE:
+=09=09*ret =3D mwifiex_ret_get_chan_info(priv, resp, data_buf);
+=09=09break;
+=09default:
+=09=09return false;
+=09}
+
+=09return true;
+}
+
 /*
  * This function handles the command responses.
  *
@@ -1214,13 +1275,27 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_priv=
ate *priv, u16 cmdresp_no,
 {
 =09int ret =3D 0;
 =09struct mwifiex_adapter *adapter =3D priv->adapter;
-=09void *data_buf =3D adapter->curr_cmd->data_buf;
+=09void *data_buf;
=20
 =09/* If the command is not successful, cleanup and return failure */
 =09if (resp->result !=3D HostCmd_RESULT_OK) {
 =09=09mwifiex_process_cmdresp_error(priv, resp);
 =09=09return -1;
 =09}
+
+=09/*
+=09 * Cancellation clears data_buf and wakes its owner under this lock.
+=09 * Keep it held through copyout so the owner cannot release the buffer.
+=09 */
+=09spin_lock_bh(&adapter->mwifiex_cmd_lock);
+=09data_buf =3D adapter->curr_cmd ? adapter->curr_cmd->data_buf : NULL;
+=09if (mwifiex_process_sta_cmdresp_data_buf(priv, cmdresp_no, resp,
+=09=09=09=09=09=09 data_buf, &ret)) {
+=09=09spin_unlock_bh(&adapter->mwifiex_cmd_lock);
+=09=09return ret;
+=09}
+=09spin_unlock_bh(&adapter->mwifiex_cmd_lock);
+
 =09/* Command successful, handle response */
 =09switch (cmdresp_no) {
 =09case HostCmd_CMD_GET_HW_SPEC:
@@ -1265,9 +1340,6 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_privat=
e *priv, u16 cmdresp_no,
 =09case HostCmd_CMD_RF_ANTENNA:
 =09=09ret =3D mwifiex_ret_rf_antenna(priv, resp);
 =09=09break;
-=09case HostCmd_CMD_802_11_PS_MODE_ENH:
-=09=09ret =3D mwifiex_ret_enh_power_mode(priv, resp, data_buf);
-=09=09break;
 =09case HostCmd_CMD_802_11_HS_CFG_ENH:
 =09=09ret =3D mwifiex_ret_802_11_hs_cfg(priv, resp);
 =09=09break;
@@ -1284,32 +1356,20 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_priv=
ate *priv, u16 cmdresp_no,
 =09case HostCmd_CMD_802_11_AD_HOC_STOP:
 =09=09ret =3D mwifiex_ret_802_11_ad_hoc_stop(priv, resp);
 =09=09break;
-=09case HostCmd_CMD_802_11_GET_LOG:
-=09=09ret =3D mwifiex_ret_get_log(priv, resp, data_buf);
-=09=09break;
 =09case HostCmd_CMD_RSSI_INFO:
 =09=09ret =3D mwifiex_ret_802_11_rssi_info(priv, resp);
 =09=09break;
-=09case HostCmd_CMD_802_11_SNMP_MIB:
-=09=09ret =3D mwifiex_ret_802_11_snmp_mib(priv, resp, data_buf);
-=09=09break;
 =09case HostCmd_CMD_802_11_TX_RATE_QUERY:
 =09=09ret =3D mwifiex_ret_802_11_tx_rate_query(priv, resp);
 =09=09break;
 =09case HostCmd_CMD_VERSION_EXT:
-=09=09ret =3D mwifiex_ret_ver_ext(priv, resp, data_buf);
-=09=09break;
-=09case HostCmd_CMD_REMAIN_ON_CHAN:
-=09=09ret =3D mwifiex_ret_remain_on_chan(priv, resp, data_buf);
+=09=09ret =3D mwifiex_ret_ver_ext(priv, resp);
 =09=09break;
 =09case HostCmd_CMD_11AC_CFG:
 =09=09break;
 =09case HostCmd_CMD_PACKET_AGGR_CTRL:
 =09=09ret =3D mwifiex_ret_pkt_aggr_ctrl(priv, resp);
 =09=09break;
-=09case HostCmd_CMD_P2P_MODE_CFG:
-=09=09ret =3D mwifiex_ret_p2p_mode_cfg(priv, resp, data_buf);
-=09=09break;
 =09case HostCmd_CMD_MGMT_FRAME_REG:
 =09case HostCmd_CMD_FUNC_INIT:
 =09case HostCmd_CMD_FUNC_SHUTDOWN:
@@ -1363,15 +1423,7 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_priva=
te *priv, u16 cmdresp_no,
 =09=09ret =3D mwifiex_ret_ibss_coalescing_status(priv, resp);
 =09=09break;
 =09case HostCmd_CMD_MEM_ACCESS:
-=09=09ret =3D mwifiex_ret_mem_access(priv, resp, data_buf);
-=09=09break;
-=09case HostCmd_CMD_MAC_REG_ACCESS:
-=09case HostCmd_CMD_BBP_REG_ACCESS:
-=09case HostCmd_CMD_RF_REG_ACCESS:
-=09case HostCmd_CMD_PMIC_REG_ACCESS:
-=09case HostCmd_CMD_CAU_REG_ACCESS:
-=09case HostCmd_CMD_802_11_EEPROM_ACCESS:
-=09=09ret =3D mwifiex_ret_reg_access(cmdresp_no, resp, data_buf);
+=09=09ret =3D mwifiex_ret_mem_access(priv, resp, NULL);
 =09=09break;
 =09case HostCmd_CMD_SET_BSS_MODE:
 =09=09break;
@@ -1416,22 +1468,13 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_priv=
ate *priv, u16 cmdresp_no,
 =09case HostCmd_CMD_SDIO_SP_RX_AGGR_CFG:
 =09=09ret =3D mwifiex_ret_sdio_rx_aggr_cfg(priv, resp);
 =09=09break;
-=09case HostCmd_CMD_HS_WAKEUP_REASON:
-=09=09ret =3D mwifiex_ret_wakeup_reason(priv, resp, data_buf);
-=09=09break;
 =09case HostCmd_CMD_TDLS_CONFIG:
 =09=09break;
-=09case HostCmd_CMD_ROBUST_COEX:
-=09=09ret =3D mwifiex_ret_robust_coex(priv, resp, data_buf);
-=09=09break;
 =09case HostCmd_CMD_GTK_REKEY_OFFLOAD_CFG:
 =09=09break;
 =09case HostCmd_CMD_CHAN_REGION_CFG:
 =09=09ret =3D mwifiex_ret_chan_region_cfg(priv, resp);
 =09=09break;
-=09case HostCmd_CMD_STA_CONFIGURE:
-=09=09ret =3D mwifiex_ret_get_chan_info(priv, resp, data_buf);
-=09=09break;
 =09default:
 =09=09mwifiex_dbg(adapter, ERROR,
 =09=09=09    "CMD_RESP: unknown cmd response %#x\n",
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net=
/wireless/marvell/mwifiex/sta_ioctl.c
index 1d3874734851..51cdaecca2a2 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -57,18 +57,6 @@ int mwifiex_wait_queue_complete(struct mwifiex_adapter *=
adapter,
 =09=09mwifiex_dbg(adapter, ERROR, "cmd_wait_q terminated: %d\n",
 =09=09=09    status);
 =09=09mwifiex_cancel_all_pending_cmd(adapter);
-
-=09=09/* The command response path writes through cmd_node->data_buf.
-=09=09 * On an interrupted wait, the caller can return and release a
-=09=09 * stack-allocated data_buf before a late firmware response is
-=09=09 * processed. Detach the caller-owned buffer from the current
-=09=09 * command so a late response cannot corrupt freed stack memory.
-=09=09 */
-=09=09spin_lock_bh(&adapter->mwifiex_cmd_lock);
-=09=09if (adapter->curr_cmd =3D=3D cmd_queued)
-=09=09=09adapter->curr_cmd->data_buf =3D NULL;
-=09=09spin_unlock_bh(&adapter->mwifiex_cmd_lock);
-
 =09=09return status;
 =09}
=20
--=20
2.43.0


