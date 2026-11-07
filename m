Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.220.129.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794069624;
	b=cpAgMpjsgIYJ54TMExR4leBCXfl6qK8ttST8o+Fw2Pxnf9+u15u1A+8VCY/CXPrZHy/p
	 Jp3qqGU7BsufKro5N/PQefn69qtXHI/jfp9Hh56X10Eb9wNCO+HTEJQHhYVKXYSfAmqig
	 etvR2agvFImBUkMAbq07kFrY/u29VqOoDtNIe1LLS32XL4nLNp/MTRKsgYZHwOeaRwTh/
	 ea83h98pVxKXwuzQDH9G+UfJo7ywO3/jpaQ1+3hBXXjGY9HOMxT6S152Xi9kmOGKDlJ8s
	 IxkJy/lGkNj0g6Lyp2iIY+4tUhRSs4syf5WH3uZNfNvA786X02diFjz6M/xloYDJSGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794069624;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-UID:X-Rspamd-UID;
	bh=+oevA0j5dfhAdyDQnvbfkB3xlGd4m1wn/Qihbtr5hMs=;
	b=DoT21go3mX1DP6eQ1ndgcefj4EyrsqhtGQvdxEXRzUAsmvxIUe9qkgNJc4Ws5AxOEX/m
	 n8dGF1Ce9yScVMX7mjwryFJaNrtrcHVa18ui8ZW2Ed1zvHeSxVvWbC8Jlr8g8Ba7tum6z
	 9SVsvNHHiRgKRxBDqHjEKW24x3jXT29jTuolksg5BPjocfB3wn0z7aAiGeJza8kSYpbWY
	 cBPXR69e6KN8FylAKN6hn2MzswAmYuXrcSsXusI0SwmPZCTL9/AStuh30tjqoE4laDUjE
	 M0K8dEAaFuTH330Ak1lsfFP06UVgRrAmAWtQJPmlAwyf+RUrjM2DoFJzol5/OAxyKlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tk154.de;
	spf=pass smtp.mailfrom=tk154.de;
	dkim=pass header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b=RWiVuV2e;
	arc=none smtp.remote-ip=85.220.129.31
Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C88606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8C88606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tk154.de header.i=@tk154.de header.a=rsa-sha256 header.s=DKIM001 header.b=RWiVuV2e
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp6.goneo.de (Postfix) with ESMTPS id 9D9602413B0;
	Sat, 07 Nov 2026 17:40:20 +0100 (CET)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id BD94B240093;
	Sat, 07 Nov 2026 17:40:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1794069618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oevA0j5dfhAdyDQnvbfkB3xlGd4m1wn/Qihbtr5hMs=;
	b=RWiVuV2eN5ulQ/lJZE/TQokqCuCvt1oFuZid1Zsw3ZoTWOp9cvW+4lr16Hgc1/sLhBl4+b
	JKFuXY/bvm59r9p8qyPPTfLrENYZokA6IzTi0ukp6+yiZBWFviod8dgEsWz1ftz2sKCVfT
	ElEuMeRyGXtEf+3serZESZ2uhynMhG2SH03eDqBpFWrLt1MKLeQi2pXcq6egkONPQ8IQzM
	0bPg2D8N2Y2Dj8ly8xTxBiH6E1vNS9hIs+cJrGcdWRU0UDr6ZC9fS7pd5Ns4eaABXTWMfp
	9O7tq1+5ydbH1vP5auw9u15IhnsmTcgEEZyYuqdnHCq5G3i49RTLzYfbYNucfA==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 702AC240097;
	Sat, 07 Nov 2026 17:40:18 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: stable@vger.kernel.org
Cc: Til Kaiser <mail@tk154.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mlxsw: Initialize register query payloads
Date: Sat,  7 Nov 2026 17:40:12 +0100
Message-ID: <20261107164012.964074-1-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107061009-failed-5.15-15b7a86a8888@kernel.org>
References: <20261107061009-failed-5.15-15b7a86a8888@kernel.org>
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
X-Rspamd-UID: 3fcbe6
X-Rspamd-UID: 90ea92

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
base query, which pass entirely uninitialized payloads.

This follows commit 5b0907407e7f ("mlxsw: core: Zero payload buffers for
couple of registers"), which initialized other query payloads after a
firmware field length bug caused firmware to consume uninitialized data.

Tested with firmware 2020.1148 and with 2016.3900 from linux-firmware.

Fixes: 7d83ee111008 ("mlxsw: core: Introduce fw_fatal health reporter")
Fixes: 2c6a33cd334b ("mlxsw: core: Extend hwmon interface with fan fault attribute")
Fixes: 4039504e6a0c ("mlxsw: spectrum_span: Allow setting policer on a SPAN agent")
Cc: stable@vger.kernel.org
Signed-off-by: Til Kaiser <mail@tk154.de>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20261014173117.26305-1-mail@tk154.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 15b7a86a8888dc6a8fd19e181757e32389de9064)
[ Dropped the mtmp_pl hunk: already zero-initialized in 5.15.y. ]
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c    | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index d1102d5613df..87b88d8ac17e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -1829,7 +1829,7 @@ mlxsw_core_health_fw_fatal_test(struct devlink_health_reporter *reporter,
 				struct netlink_ext_ack *extack)
 {
 	struct mlxsw_core *mlxsw_core = devlink_health_reporter_priv(reporter);
-	char mfgd_pl[MLXSW_REG_MFGD_LEN];
+	char mfgd_pl[MLXSW_REG_MFGD_LEN] = {0};
 	int err;
 
 	/* Read the register first to make sure no other bits are changed. */
@@ -1850,7 +1850,7 @@ mlxsw_core_health_fw_fatal_ops = {
 static int mlxsw_core_health_fw_fatal_config(struct mlxsw_core *mlxsw_core,
 					     bool enable)
 {
-	char mfgd_pl[MLXSW_REG_MFGD_LEN];
+	char mfgd_pl[MLXSW_REG_MFGD_LEN] = {0};
 	int err;
 
 	/* Read the register first to make sure no other bits are changed. */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
index d41afdfbd085..7f22174eeb98 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
@@ -160,7 +160,7 @@ static ssize_t mlxsw_hwmon_fan_fault_show(struct device *dev,
 	struct mlxsw_hwmon_attr *mlwsw_hwmon_attr =
 			container_of(attr, struct mlxsw_hwmon_attr, dev_attr);
 	struct mlxsw_hwmon *mlxsw_hwmon = mlwsw_hwmon_attr->hwmon;
-	char fore_pl[MLXSW_REG_FORE_LEN];
+	char fore_pl[MLXSW_REG_FORE_LEN] = {0};
 	bool fault;
 	int err;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index 96b098df144e..e0e85fb9ff77 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -1703,7 +1703,7 @@ static int mlxsw_sp2_span_init(struct mlxsw_sp *mlxsw_sp)
 static int mlxsw_sp2_span_policer_id_base_set(struct mlxsw_sp *mlxsw_sp,
 					      u16 policer_id_base)
 {
-	char mogcr_pl[MLXSW_REG_MOGCR_LEN];
+	char mogcr_pl[MLXSW_REG_MOGCR_LEN] = {0};
 	int err;
 
 	err = mlxsw_reg_query(mlxsw_sp->core, MLXSW_REG(mogcr), mogcr_pl);
-- 
2.56.0

