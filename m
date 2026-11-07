Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.220.129.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067524;
	b=zWiwebXQe1NanpB3Yl+fhRRZd2SOGhQ1xE8vThwzdE+a7p7fm4L91cDcQeuczSt8eBBc
	 XOp0E8weQ5nJtJNvzRdJ2G4WdeBlWP1oBzwTUtxvesKF6ZCdrwIiZcT7/gM0jBp71m7Qa
	 rM2ZVuihAGJn/Z8mCQx4sbfxuKkO7V61NdrAu9DR2kUuZ/aAo/DLBQbSQqS3WnER69vDc
	 iZZVP3SCtMZzN/voiyn9edDnZvC4yMw+aL+GgCrJ66RSDXRCHeT3inO+p6yJLNu4cUle+
	 dVheTp2LzRzvEznGSBv2btdixUf4UuSCiLhvFr6jcqBuaXxFPHLwcJ8cijHXwbr0dFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067524;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-UID:X-Rspamd-UID;
	bh=FL+cY77yqiBb4Jfyi25p4DMX+Ki7C0GbdZcyWTGQu48=;
	b=0aQTcDLguJXcwBnn9ySqgsTET3oSGjaqXhCUHce8eOeUP3UyFdRn0zMOHLSjwNLBvglG
	 L+mltpkU0vflB18hbwI4R8Rm7Y9Adq33stVDNULOAe1ACc9SvkNxTiuD0I3ELJmzGBVum
	 7ZRkcELAPt2xfe9z+FMEn8OeI2ioM6HVRSE/Xo31ClwwHi31dPr/HSrUgD0abN4kclryg
	 nd8Y8809NvP+evyEZewKC1+tqS6foWmWn5C/dIkFXVX2f8mgEY42xVKypMnn6slhHzLgh
	 hRM6N9copOMj/WsiZK8bbMcvrqcF3zYeMuNh7woXqpcPJ9hm2Ma+Iwb8CaSv4Rt3sGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tk154.de;
	spf=pass smtp.mailfrom=tk154.de;
	dkim=pass header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b=s0mD3KWu;
	arc=none smtp.remote-ip=85.220.129.31
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF75D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b=s0mD3KWu
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp6.goneo.de (Postfix) with ESMTPS id 62F232413AC;
	Sat, 07 Nov 2026 17:05:16 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 3F571240091;
	Sat, 07 Nov 2026 17:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1794067513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FL+cY77yqiBb4Jfyi25p4DMX+Ki7C0GbdZcyWTGQu48=;
	b=s0mD3KWucl/gMEWlLetJ3KTxkfiLmj1MYVO4QVaj1l4BDv+IyKJ/RnMy47QtzjXdHYXvqN
	1aeZXbJiyYaiacCFSROfMJi/gyUZZA2h+CkHwIVwvhpZwoR8gHq6wINGLn2PTwqGs8bZDo
	faXDkWJACCK0KUNpnZZhMHXtZcSgIddDoGT9RMx4uzNcOSnn0CQ7cA0H9AlQhXIELmu1Ez
	0MDtAzDx0Ob3nvIprdSrh4pNDhSRup1CgwPTlWbFxuD0j6zBqM2drEkj+yZHiWimFu84i/
	b/aLugeVlIfQm1gMLd/COmMG9RBFap1iq8sGXg8UyPyDOfbT/kXQcbFBTx3/8Q==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 0D518240092;
	Sat, 07 Nov 2026 17:05:13 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: stable@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mlxsw: Initialize register query payloads
Date: Sat,  7 Nov 2026 17:05:07 +0100
Message-ID: <20261107160507.676124-1-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107055300-failed-6.1-15b7a86a8888@kernel.org>
References: <20261107055300-failed-6.1-15b7a86a8888@kernel.org>
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
X-Rspamd-UID: 3e8e4c
X-Rspamd-UID: 3e7110

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
index f36a416ffcfe..4aafcbe9d90a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2015,7 +2015,7 @@ mlxsw_core_health_fw_fatal_test(struct devlink_health_reporter *reporter,
 				struct netlink_ext_ack *extack)
 {
 	struct mlxsw_core *mlxsw_core = devlink_health_reporter_priv(reporter);
-	char mfgd_pl[MLXSW_REG_MFGD_LEN];
+	char mfgd_pl[MLXSW_REG_MFGD_LEN] = {0};
 	int err;
 
 	/* Read the register first to make sure no other bits are changed. */
@@ -2036,7 +2036,7 @@ mlxsw_core_health_fw_fatal_ops = {
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

