Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.220.129.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067421;
	b=gP5OsehSO5Rqe3BbbaZhgIuLQnY8L0owRMJMCM+oIv7XVc0Oifm3VLTtSvAblctjbDVn
	 h72wd6Hg0o6rgrefpkaEEmyvzL4OQL4gji4pdMd3xwDcS94DVrtLErrJhbnokVNGXK0A7
	 5UAY2u2ZMUAzqCHbXob2ChUt+zT2NJ4pFFMwqVpwu/yC70cns4iMnKqzEv5coY9vm0LkH
	 gC6KxarG4EmafxamIAXl2vXeqdZnPaSpP1z6epfG/n3FmlDu639YRyirFDXci8G978iAk
	 BVVV+M7IhINxo4mX2gXyDr+vQHLm0tIA+uYLwqYe0u7bECfEeKs3yL7B9UC20iRMtdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067421;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-UID:X-Rspamd-UID;
	bh=7h4zIezgo0x/FEDA21SWRZr45qeNHaEHdjYzAJRfN9Y=;
	b=Fp7/csebWzUxU8MghL5PAI/kslLSdCm9XhvI/Pb7ZFR0zdwbID6PHXi2bYrW0FSzuo4e
	 5Ixb6xX5mkAUfF88IM5T6IMP70+Hr/UAvFtWW03Q83QaqK5kdHZHi1fIWuYRFm22xOIE1
	 Kx8FvfL6AGd2SL8FWYhOdLh7XDtWmyJQQC260UM1fGO2TZF2kmU7bqA40AaUcJOho1M3w
	 goZ8k3nAEaTUCykEH4gxBECg/86JwUQjrK5pJbAAZjKQfSRMyEusA5VNVaicyo58ssnQ2
	 Ujb+LJ1nMvDvC3pe5uu7zLeSdMmnbfkx4jrDM0p2wfqfPG/GXgIYX4eHagnqZCuMQVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tk154.de;
	spf=pass smtp.mailfrom=tk154.de;
	dkim=pass header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b="c/YAE/1L";
	arc=none smtp.remote-ip=85.220.129.60
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28ED606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D28ED606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b=c/YAE/1L
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id CD155240E73;
	Sat, 07 Nov 2026 17:03:37 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id E7D1E24013D;
	Sat, 07 Nov 2026 17:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1794067416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7h4zIezgo0x/FEDA21SWRZr45qeNHaEHdjYzAJRfN9Y=;
	b=c/YAE/1L49zVYbU4ldhb7PMyPMZvcP0YnpPULQOH8hLounhHA9j0M5+QkkKHPPkF0+Vj44
	gIf7XdxEpH68mWYsffSxJlf2xDCL+Iw4txHpRLAGrTc/8j0bpfnWLwKqVa+XccMOpVn7WP
	ip1zDJuhBDU0m0kACndPBjxtfbWUrp7zDHHY2Vto25v6fPmYagF/pcr/0FUyMPYOIDWNLg
	PeF5WsPLAiv3m0k9ApjKcpLOqb4JBcjPWGrhu4aISstMRsJScvIEcpOj5BooDJHdFIpbge
	4IvGl+GFtheKyyXOmjEREx+rVjTsWDvLm5lNrsmffqEfNWXsWrGYdBtV3p1DYA==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id A046D240092;
	Sat, 07 Nov 2026 17:03:35 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: stable@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] mlxsw: Initialize register query payloads
Date: Sat,  7 Nov 2026 17:03:28 +0100
Message-ID: <20261107160328.659462-1-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107052507-failed-6.12-15b7a86a8888@kernel.org>
References: <20261107052507-failed-6.12-15b7a86a8888@kernel.org>
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
X-Rspamd-UID: 147860
X-Rspamd-UID: 694245

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
index 4a79c0d7e7ad..feaeb4118f0b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2002,7 +2002,7 @@ mlxsw_core_health_fw_fatal_test(struct devlink_health_reporter *reporter,
 				struct netlink_ext_ack *extack)
 {
 	struct mlxsw_core *mlxsw_core = devlink_health_reporter_priv(reporter);
-	char mfgd_pl[MLXSW_REG_MFGD_LEN];
+	char mfgd_pl[MLXSW_REG_MFGD_LEN] = {0};
 	int err;
 
 	/* Read the register first to make sure no other bits are changed. */
@@ -2023,7 +2023,7 @@ mlxsw_core_health_fw_fatal_ops = {
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

