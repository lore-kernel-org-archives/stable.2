Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.220.129.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067473;
	b=LmgLG5QDRLYLdLVQiv2bfnSbv4FOuZNIE7jAz/LHGN032DVAgsv5dJAzYeEs0IbuuRLN
	 EprBYeiKZIjFDMV8u5wwml746x7mqDRjvp1Tj8+3dgGE16cWSGC/oGRKuA5YUIKOBV05w
	 Ay8Qbi9XXuwAsRz/0Og5jw5jFbR5QEBZQg/ufqXDynDhxW1LnRm/feeUWWE5YXuh1JxjP
	 QZ0ai8LNDX7mK50GODbgHeAB66q/npMXiNY/HIUo+GADNLM0yYcLY/luKMnHAu04S7ubV
	 sqxdSmDbcVbNKo/q6/WdIBoHImFM1YGjQ7M+asNptCAaNpbng0HRYyXHuBEoFoQT1/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067473;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-UID:X-Rspamd-UID;
	bh=LeDn0vdh7KWF5yjJU57P2hNoa81ahEwHQHJcnjpszzU=;
	b=4f/tIBdOzBD2RxEop+FfK+bftCydpi90KXGnJOkyLzitwn7aQz8mWN2o7ZC4+hp1G49q
	 /Qneg5v/iBFV21WEc3wy6w2Bjrbv1HhNXt9BGC9sTm8Sgy+AcIcije+CtcTHIpygzMDZH
	 r+qoBnfnTSfW5sJsWkAa6vNYl5vBpWOivlI9abYSr8IU5569OqE1hn7f7p45wg/uX9uiO
	 3Nz8bky7HOw+DmB0PH/cw3PcIdsAC/NLRsFpO7lVvyiuYFNNK5Uwrct4yRZPZ3wy9j1u4
	 CzBFIci7XsqLwOsq3dt0R40pIR40DQjTlRmbNGtBiWmUXh7a226R51ViG2LepqJyfZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tk154.de;
	spf=pass smtp.mailfrom=tk154.de;
	dkim=pass header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b=fECVpkYX;
	arc=none smtp.remote-ip=85.220.129.60
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A30606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A30606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b=fECVpkYX
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id 0FB43240A56;
	Sat, 07 Nov 2026 17:04:31 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 2FBA3240095;
	Sat, 07 Nov 2026 17:04:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1794067469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LeDn0vdh7KWF5yjJU57P2hNoa81ahEwHQHJcnjpszzU=;
	b=fECVpkYXCGottX0MJwSjkGbCqR148N64CUwJDNEwSzcZavXVSbn2eWIEd5GGJaH2uu6SM3
	QdbFpoS0Ar25NxNmJLSCuAQUzWc2EGjct74RzBhdbn+dYTDoFygQGADWlrLjhnuix08t6c
	7SDIxie549srpWBy7gKdtOB3wqof95bzF5y86sxuEe6nXRI6WxjEvZ3IxvmpTPQm2hcN5O
	vd/g/ljhi024bfkunKUOeBjyk1qrp31SFuldGD/MtAA3WDb/2iEmdvdd7KZHA4JtJDoluY
	CrbCLngcKOKBXs53HSlX0G4lBHzIjqlYqtuAiMr0iX8PtO9C13QG9sFYcfo9wQ==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 00B5A240093;
	Sat, 07 Nov 2026 17:04:28 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: stable@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] mlxsw: Initialize register query payloads
Date: Sat,  7 Nov 2026 17:04:23 +0100
Message-ID: <20261107160423.666028-1-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107053757-failed-6.6-15b7a86a8888@kernel.org>
References: <20261107053757-failed-6.6-15b7a86a8888@kernel.org>
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
X-Rspamd-UID: 0fb0e7
X-Rspamd-UID: 251a4d

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
index 85507d01fd45..68cc3278ef26 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2065,7 +2065,7 @@ mlxsw_core_health_fw_fatal_test(struct devlink_health_reporter *reporter,
 				struct netlink_ext_ack *extack)
 {
 	struct mlxsw_core *mlxsw_core = devlink_health_reporter_priv(reporter);
-	char mfgd_pl[MLXSW_REG_MFGD_LEN];
+	char mfgd_pl[MLXSW_REG_MFGD_LEN] = {0};
 	int err;
 
 	/* Read the register first to make sure no other bits are changed. */
@@ -2086,7 +2086,7 @@ mlxsw_core_health_fw_fatal_ops = {
 static int mlxsw_core_health_fw_fatal_config(struct mlxsw_core *mlxsw_core,
 					     bool enable)
 {
-	char mfgd_pl[MLXSW_REG_MFGD_LEN];
+	char mfgd_pl[MLXSW_REG_MFGD_LEN] = {0};
 	int err;
 
 	/* Read the register first to make sure no other bits are changed. */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
index 0fd290d776ff..2881271d529b 100644
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
index fa3fef2b74db..04aecdee69a3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -1718,7 +1718,7 @@ static int mlxsw_sp2_span_init(struct mlxsw_sp *mlxsw_sp)
 static int mlxsw_sp2_span_policer_id_base_set(struct mlxsw_sp *mlxsw_sp,
 					      u16 policer_id_base)
 {
-	char mogcr_pl[MLXSW_REG_MOGCR_LEN];
+	char mogcr_pl[MLXSW_REG_MOGCR_LEN] = {0};
 	int err;
 
 	err = mlxsw_reg_query(mlxsw_sp->core, MLXSW_REG(mogcr), mogcr_pl);
-- 
2.56.0

