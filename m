Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048782;
	b=A7+v8HiblFFxN9QTUoexjoi3+Gy8LR7UmjBQljpBUAm73/F6sQiBVV9WQrzElRrw48Nh
	 NqAYym7F9wateyXFvpj8wsLnMmPUtZ+kCxciP85PqazkDBoqFiZl8tme3Pt56qNhmsE+e
	 vZhsJXOCHV+Z9nA2WJJFwTZSectkA0N23riF7dU4/uzTwfiE9mNm1MV67aIjIakDAkwns
	 pwz4BzsVppc2Isju8Sty7WTKfMxeNA0qjVjOdrPX+EVDMoSvjrUssMb+W2J+d7kXEk/oG
	 J2pKGC3tqewVexXDyvAOcE1lf4aubeF7EmWcJhZ/SxG+gHcu8A+NzjG95T4NOg01o/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3G6sIRfvLrp7MUm7M9Xk2I3/fMdBvQ52m/yy/UjD1W8=;
	b=mYzKMjHJtW6JGjiYducHKvccywK3xOXogcbszXX1XnJ3r569IMAnwkQsMj8A1IcoT6rd
	 d/y9n5DU9gyyc7EuU3KWgDtuM2HyRHY2rj6NFUvI7IZUb2i7HL1ImUmmXJjJALrNlrARZ
	 RtzhTcxWZFTpjukuHLDNGGrXuyK0PERauS9kYbIJdqykT/lech2o1FWVGHBBMOgCqsfH+
	 meLI5H6kkhlGOwQK3YswccHAvOSi/89aBVk4m/bt2ioQMcwr5ZuBTgwKSrB0+JYilafLa
	 igg0kw+wIVakHY2VmmcYXrcBVGH5abka+LodWVyiieABFcyG8MAItM+c/rj6vEhqi1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPzQF6RP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPzQF6RP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8021F0089F;
	Sat,  7 Nov 2026 10:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048782;
	bh=3G6sIRfvLrp7MUm7M9Xk2I3/fMdBvQ52m/yy/UjD1W8=;
	h=From:To:Cc:Subject:Date;
	b=fPzQF6RP4iKmacSHNzv3w001JVSWPYS4PTCmRb860yDToyZ3WAMTkjUR7jV1Wnnzt
	 4mTeKUU2JyOs7evnUUHMqr7eQbpjibOOfkeRFuMPQ4LaQH+o3NbAo7EE5HBkF4T4Ww
	 GWttih6yBE6TUF7oZTnXSXLU622J89+FX7/NFfAOY0BIUfH9qCMLQmkblPFkxW/Xjs
	 mO+50M/YBcUVGbNWN1YYHP05TbwjRsFSpwlnK7zvm0iPi7BSlo1mKoEqr4b27u4UDv
	 Xe2e61ut8IiAKoMbvdYjtLg2aAT9i5vmvifbWDd7NFvuRjvLih4R31HZiwOR1jf+T6
	 I+DkjoIUxpZyA==
From: Sasha Levin <sashal@kernel.org>
To: mail@tk154.de,
	idosch@nvidia.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mlxsw: Initialize register query payloads" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:00 -0500
Message-ID: <20261107055300-failed-6.1-15b7a86a8888@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 15b7a86a8888dc6a8fd19e181757e32389de9064
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055300-failed-6.1-15b7a86a8888@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 15b7a86a8888dc6a8fd19e181757e32389de9064 Mon Sep 17 00:00:00 2001
From: Til Kaiser <mail@tk154.de>
Date: Wed, 14 Oct 2026 19:31:17 +0200
Subject: [PATCH] mlxsw: Initialize register query payloads

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
---
 drivers/net/ethernet/mellanox/mlxsw/core.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c    | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 308d8a94865f8..42e9689d7f357 100644
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
index 30f172ce822cf..a5e7aee730d6a 100644
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
index ae63d549b5429..d54fe5e612963 100644
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
2.53.0




