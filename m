Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.220.129.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067299;
	b=KmparplkM9yNGsbRj3iRic0Di4oNbenjSN1MCQHKD9GYJTrqYMVJc4GRkxbGxUiQAhpT
	 CKU+budkqZTbHANoUyF/LaU3IQ/GW6qkIwaUMeLB86RNwrsEv45tApCBcECCWF0+hNktd
	 Uyvw1F/S0R8yhXfdpBepB1z4MdhAx73pPacKicxAENArnEpKC3Sn+tmVz/2nKfd2C4dXM
	 glyIVLYA0onvIzrGKAScTHloNgT1NYEeSQ8DW6HMae4sDHQEEGcTnVNvHZNEyA3WOU+yq
	 Ta+b8wtEmD6dVP7VkVa564F300yoTsRboSm26Y4FVIWvY0tNL+/+cGaB4Yehjx1VitQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067299;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-UID:X-Rspamd-UID;
	bh=mJcP3MfaUVYMj08Ag/fEkZVmBUxz9OICpvZ8TEQouEk=;
	b=KexLAS7MZ//7xOAkiRONvB++1wo8e3iNHp++EQASm+sktAhavIcUp3nrLHHP7RHGkd4n
	 GPtkcPLTc4CNPPpREu091aqX0Gwsx6JdkwlHLmXpYFCP5rlxy2/u77GQNoRttFOMyNaxU
	 sjxfm4Wl+z9AuDYbDSNJFH5Vve7eu8N1LeH37zQsduCO/sKn0fjtUH0z/o0lBOVh5jYxQ
	 eKNcZkqDXsVCtkSCsoxfAEG6jkFBoVf7BbSV3ZFc+dlf0mXBjb7Fng+qlBw9Hw36OBmRQ
	 XYB5El1WMC1iIuVhuHe3diPmz86WZJ00Z6WQghP8L28qvAk87kRRaHihnoAO7laSRrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tk154.de;
	spf=pass smtp.mailfrom=tk154.de;
	dkim=pass header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b=Li35leK2;
	arc=none smtp.remote-ip=85.220.129.60
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05AC9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b=Li35leK2
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id A1F6B240E73;
	Sat, 07 Nov 2026 17:01:29 +0100 (CET)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id BF9582402A1;
	Sat, 07 Nov 2026 17:01:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1794067287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJcP3MfaUVYMj08Ag/fEkZVmBUxz9OICpvZ8TEQouEk=;
	b=Li35leK2aJxz5Z7LC6DByecUNLVSwWuMq+WyTsuvWClh0n1aJrtxftrWtC5NGmGV7SZWJU
	VD2PGjHKRkpdtt0s7mD8Us4bxKvO3y+hf+H3+AQ0HWOL3UqVNmnVJo6wHW85e+cFcQ3wTg
	dCjcDaQ7PtP/a4l9FlTVr55lcfOg6LCphw8+D2Rks/P58aVUfJVknyk/9khHEThslo6Zin
	CcVgznn2j2E+5nZMa7jPd0Ufn2/uLm72qAWWGN4/d84cGtGBvS1JWDIDfJW6O57hK1C3Yg
	SRfmXRy2b+Tp35IqMDa5gqwHBbMkT0MEZlOrYeuEpag5bYwSU2pBKjGGaQnYxg==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 739BD24027A;
	Sat, 07 Nov 2026 17:01:27 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: stable@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18.y] mlxsw: Initialize register query payloads
Date: Sat,  7 Nov 2026 17:01:02 +0100
Message-ID: <20261107160102.634237-1-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107051323-failed-6.18-15b7a86a8888@kernel.org>
References: <20261107051323-failed-6.18-15b7a86a8888@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 538840
X-Rspamd-UID: 2adcc1

MFGD register queries can exhaust EMAD retries and leave Mellanox
Spectrum switches stuck during boot or shutdown when running OpenWrt
built with GCC 15.

An example failure is shown below with the second line wrapped:

  EMAD retries (5/5) (tid=9b544fc100001f35)
  EMAD reg access failed (tid=9b544fc100001f35,reg_id=90f0(mfgd),
                          type=query,status=0(operation performed))

On an SN2100, the failure occurs during driver teardown on reboot.
On an SN3420, it occurs while probing mlxsw_spectrum during boot.

The register query API transmits the supplied payload to the device
before replacing it with the response. Both MFGD callers pass an
uninitialized stack buffer, so the request contains arbitrary register
field values and reserved bits. This makes the request depend on stack
contents and compiler code generation.

Initialize both MFGD query buffers in the firmware fatal event
configuration and reporter test paths. The initialization has been
confirmed to eliminate the boot and shutdown hangs on both switches.
The subsequent read-modify-write still preserves the other fields
returned by the device.

Also initialize the FORE fan fault query and the MOGCR mirroring policer
base query, which pass entirely uninitialized payloads. Restore the MTMP
query initialization in the temperature history reset path, where only
the slot and sensor index fields are set before querying the register.

This follows commit 5b0907407e7f ("mlxsw: core: Zero payload buffers for
couple of registers"), which initialized other query payloads after a
firmware field length bug caused firmware to consume uninitialized data.

Tested with firmware 2020.1148 and with 2016.3900 from linux-firmware.

Fixes: 7d83ee111008 ("mlxsw: core: Introduce fw_fatal health reporter")
Fixes: 2c6a33cd334b ("mlxsw: core: Extend hwmon interface with fan fault attribute")
Fixes: 4039504e6a0c ("mlxsw: spectrum_span: Allow setting policer on a SPAN agent")
Fixes: b890ad418e1f ("mlxsw: core_hwmon: Extend internal structures to support multi hwmon objects")
Cc: stable@vger.kernel.org
Signed-off-by: Til Kaiser <mail@tk154.de>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261014173117.26305-1-mail@tk154.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 15b7a86a8888dc6a8fd19e181757e32389de9064)
---
 drivers/net/ethernet/mellanox/mlxsw/core.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c    | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 83c7cf3bbea3..bd15c14bf5c8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2001,7 +2001,7 @@ mlxsw_core_health_fw_fatal_test(struct devlink_health_reporter *reporter,
 				struct netlink_ext_ack *extack)
 {
 	struct mlxsw_core *mlxsw_core = devlink_health_reporter_priv(reporter);
-	char mfgd_pl[MLXSW_REG_MFGD_LEN];
+	char mfgd_pl[MLXSW_REG_MFGD_LEN] = {0};
 	int err;
 
 	/* Read the register first to make sure no other bits are changed. */
@@ -2022,7 +2022,7 @@ mlxsw_core_health_fw_fatal_ops = {
 static int mlxsw_core_health_fw_fatal_config(struct mlxsw_core *mlxsw_core,
 					     bool enable)
 {
-	char mfgd_pl[MLXSW_REG_MFGD_LEN];
+	char mfgd_pl[MLXSW_REG_MFGD_LEN] = {0};
 	int err;
 
 	/* Read the register first to make sure no other bits are changed. */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
index 9c12e1feb643..e39a8b0a5709 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
@@ -120,7 +120,7 @@ static ssize_t mlxsw_hwmon_temp_rst_store(struct device *dev,
 			container_of(attr, struct mlxsw_hwmon_attr, dev_attr);
 	struct mlxsw_hwmon_dev *mlxsw_hwmon_dev = mlxsw_hwmon_attr->mlxsw_hwmon_dev;
 	struct mlxsw_hwmon *mlxsw_hwmon = mlxsw_hwmon_dev->hwmon;
-	char mtmp_pl[MLXSW_REG_MTMP_LEN];
+	char mtmp_pl[MLXSW_REG_MTMP_LEN] = {0};
 	unsigned long val;
 	int index;
 	int err;
@@ -177,7 +177,7 @@ static ssize_t mlxsw_hwmon_fan_fault_show(struct device *dev,
 			container_of(attr, struct mlxsw_hwmon_attr, dev_attr);
 	struct mlxsw_hwmon_dev *mlxsw_hwmon_dev = mlxsw_hwmon_attr->mlxsw_hwmon_dev;
 	struct mlxsw_hwmon *mlxsw_hwmon = mlxsw_hwmon_dev->hwmon;
-	char fore_pl[MLXSW_REG_FORE_LEN];
+	char fore_pl[MLXSW_REG_FORE_LEN] = {0};
 	bool fault;
 	int err;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index 32d2e61f2b82..91fb77c8e20d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -1720,7 +1720,7 @@ static int mlxsw_sp2_span_init(struct mlxsw_sp *mlxsw_sp)
 static int mlxsw_sp2_span_policer_id_base_set(struct mlxsw_sp *mlxsw_sp,
 					      u16 policer_id_base)
 {
-	char mogcr_pl[MLXSW_REG_MOGCR_LEN];
+	char mogcr_pl[MLXSW_REG_MOGCR_LEN] = {0};
 	int err;
 
 	err = mlxsw_reg_query(mlxsw_sp->core, MLXSW_REG(mogcr), mogcr_pl);
-- 
2.56.0

