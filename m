Received: from mta0.migadu.com (out-168.mta0.migadu.com [91.218.175.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8D2628D
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787892990; cv=none; b=nvhmxJFrDuZwTaFjO8BpGaaSMidRHAFzCigQ/Sl+JXCJybkGiEMyeFMVohCqM9oOgacuwKIhV/uuh7OeNvoAJ+HmoxxUmW23Pbx/PeUtFz2CpLB3ugQEqwGp67KhbeYmLyfQt0Vdl5dgHMA/RKUNS1oc66LFyo+F5z443WhrcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787892990; c=relaxed/simple;
	bh=fZhglLoWTNrH1aaF5Azu3NNgyHJwxU8ggLwqo+Wjufo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NHagikqMxxz2KQurbaqswSYHgOx/H2AYzyyzuIjHFAVXCcmOLH1A0FIXEohhl8zWDcoyaDV3x6CxF2IxACp4GnFnDzAwX085t3dxKZ7dLLDD1FcfVIIUJfKicslfywzrjxeB0yOJWpDBEvwsNi3QHfCgCdcvnAT1ajIgiOtu2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev; spf=pass smtp.mailfrom=cressey.dev; dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b=i7IZrIpO; arc=none smtp.client-ip=91.218.175.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b="i7IZrIpO"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fZhglLoWTNrH1aaF5Azu3NNgyHJwxU8ggLwqo+Wjufo=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787892986; v=1; x=1788497786;
 b=i7IZrIpObEhdv3R6sk09TucOUd6oOIFpJ/sO8PvysxUIZUjvQqO6QjDAwKQtF7hZWRScXVpx
 lS8I8Uttr1tQwOTdlTBYyEfus87O642WbH90YMLsuQXFURrUj+BcYsXbY0Cg5j9VKcArWd73eo4
 H07T1xRTDyuTTe6/Mm2LntZgCHh4N3c4LYyVQ5WAtmnJrOjj4YMWHOuL9KYffKjgYlHZxRuFK1C
 P/M4ODHWZShRWCleOQU4rtPulvA743VLjnuf3xagPWTYwZcWZndrgRWznJHqOgjbDK7ti7oaZhq
 4SU0CcUz+HDNC5XxL+gpCtlAu1CbSDyw7fWk9BSBXsLYQ==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef95467f80a113ed;
	Fri, 28 Aug 2026 04:56:15 +0000
X-Mizu-Trace-ID: ef95467f80a113ed
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Date: Fri, 28 Aug 2026 04:55:52 +0000
Subject: [PATCH net] Revert "net/mlx5: Add sensor name to temperature event
 message"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-b4-mlx5-temp-warn-revert-v1-1-4e2ae5a0351f@cressey.dev>
X-B4-Tracking: v=1; b=H4sIANcUkWoC/02NTQ6CMBCFr0Jm7QRshKBXMS6mZZAKlGZahYRwd
 wtuXL7v/a0QWCwHuGUrCH9ssJNL4nzKwHTknoy2SRpUoaqiVjXqC47DUmLk0eNM4jDVWCJeG1U
 3RMS6aiHVvXBrl2P6Do4jPH4wvPWLTdxH95imwKiFnOl2NPjcTPMkPUt+WH3wA0VUZfn3G9iFS
 WDbvsN3x6TAAAAA
X-Change-ID: 20260828-b4-mlx5-temp-warn-revert-9d28daaaeb6f
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shahar Shitrit <shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Will Mortensen <will@extrahop.com>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, 
 Ben Cressey <ben@cressey.dev>
X-Mailer: b4 0.15.2

This reverts commit 46fd50cfcc12368bed9ae5257cc3beaea5b3c193.

print_sensor_names_in_bit_set() passes the sensor index from the
temperature warning event to hwmon_get_sensor_name(), which uses it
as an index into temp_channel_desc[]. That array is indexed by hwmon
channel, not by sensor index: it has one entry per ASIC or platform
sensor the device reports, plus at most one module sensor
(module_scount is 0 or 1). Module sensors have index 64 and up, so a
module temperature warning reads far past the end of the allocation
and prints whatever memory follows it, up to the next NUL byte, into
the log.

The mapping from sensor index to hwmon channel cannot be made
reliable here: the driver registers at most one module channel, while
the event can carry bits for other ports' modules, and the bitmap in
the existing warning already distinguishes the ASIC sensor (bit 0)
from module sensors (bit 64 and up). Drop the name lookup rather than
fix the mapping, as suggested in review of an earlier fix [1].

Fixes: 46fd50cfcc12 ("net/mlx5: Add sensor name to temperature event message")
Cc: stable@vger.kernel.org
Suggested-by: Leon Romanovsky <leon@kernel.org>
Link: https://lore.kernel.org/netdev/20260518112555.GM33515@unreal/
Reported-by: Will Mortensen <will@extrahop.com>
Closes: https://lore.kernel.org/netdev/20260512-b4-mlx5-sensor-fix-v2-1-531fee4fd7fd@extrahop.com/
Link: https://lore.kernel.org/netdev/20260515-b4-mlx5-sensor-fix-v3-1-f537ce191d6c@extrahop.com/ [1]
Assisted-by: LLM
Reviewed-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Signed-off-by: Ben Cressey <ben@cressey.dev>
---
The restored warning string intentionally lacks the trailing period
and newline: this is a pure revert of 46fd50cfcc12, the commit that
added them.

Will - happy for you to carry this as v4 if you'd prefer.
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c | 31 +++---------------------
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c  |  5 ----
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h  |  1 -
 3 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 4d7f35b968761..a5d4586edf435 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -6,7 +6,6 @@
 #include "mlx5_core.h"
 #include "lib/eq.h"
 #include "lib/events.h"
-#include "hwmon.h"
 
 struct mlx5_event_nb {
 	struct mlx5_nb  nb;
@@ -154,28 +153,11 @@ static int any_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-#if IS_ENABLED(CONFIG_HWMON)
-static void print_sensor_names_in_bit_set(struct mlx5_core_dev *dev, struct mlx5_hwmon *hwmon,
-					  u64 bit_set, int bit_set_offset)
-{
-	unsigned long *bit_set_ptr = (unsigned long *)&bit_set;
-	int num_bits = sizeof(bit_set) * BITS_PER_BYTE;
-	int i;
-
-	for_each_set_bit(i, bit_set_ptr, num_bits) {
-		const char *sensor_name = hwmon_get_sensor_name(hwmon, i + bit_set_offset);
-
-		mlx5_core_warn(dev, "Sensor name[%d]: %s\n", i + bit_set_offset, sensor_name);
-	}
-}
-#endif /* CONFIG_HWMON */
-
 /* type == MLX5_EVENT_TYPE_TEMP_WARN_EVENT */
 static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 {
 	struct mlx5_event_nb *event_nb = mlx5_nb_cof(nb, struct mlx5_event_nb, nb);
 	struct mlx5_events   *events   = event_nb->ctx;
-	struct mlx5_core_dev *dev      = events->dev;
 	struct mlx5_eqe      *eqe      = data;
 	u64 value_lsb;
 	u64 value_msb;
@@ -187,17 +169,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	value_lsb &= 0x1;
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
-	if (net_ratelimit()) {
-		mlx5_core_warn(dev, "High temperature on sensors with bit set %#llx %#llx.\n",
+	if (net_ratelimit())
+		mlx5_core_warn(events->dev,
+			       "High temperature on sensors with bit set %#llx %#llx",
 			       value_msb, value_lsb);
-#if IS_ENABLED(CONFIG_HWMON)
-		if (dev->hwmon) {
-			print_sensor_names_in_bit_set(dev, dev->hwmon, value_lsb, 0);
-			print_sensor_names_in_bit_set(dev, dev->hwmon, value_msb,
-						      sizeof(value_lsb) * BITS_PER_BYTE);
-		}
-#endif
-	}
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
index afcdebac9c4fd..bf36c1c9bf781 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
@@ -416,8 +416,3 @@ void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev)
 	mlx5_hwmon_free(hwmon);
 	mdev->hwmon = NULL;
 }
-
-const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int channel)
-{
-	return hwmon->temp_channel_desc[channel].sensor_name;
-}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
index f38271c22c105..999654a9b9da5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
@@ -10,7 +10,6 @@
 
 int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev);
 void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev);
-const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int channel);
 
 #else
 static inline int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev)

---
base-commit: 4e15e89faac9f308baeb01f46c13a051814d2449
change-id: 20260828-b4-mlx5-temp-warn-revert-9d28daaaeb6f

