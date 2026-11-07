Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050329;
	b=MCVQ30RNij8jaPsl8Gj3sZDQJ8PDjsg/H2hd+C/UJtmHED23EvIR4jeez0+XI5Yod2OD
	 J1s03W/tWIX50UYAX6bemwWtZ/Jn7zxVPDft8ZRWqdgwAMdwoRWukVZ5waZ/lbspY0or5
	 vlB2sigwxnsoNz0TtRgOVyqdFQSjomujjFAn8SxXARsJoS6cSNWClTkgi5+zKyA67tAxR
	 gmI0Cr4yXs7sohnY9NpwL0xKJxF4eZRVyM4fT9D8GgpBUxEOcukmAuyADri4S/V51EuNU
	 OCXhBA1hVq4+iTFgLVnq3i3ZR2uRYUQURwA5Vdq+nBrg3lKfx3K6GBJJ2blA8Xud6qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050329;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EuD7mUUEadSeGs6JWkMadGjLE6eJqdaTpauJBa/2pVk=;
	b=veiqnVBSPle4L5VeCnZPoQqGqYwsg1JNa8CjPHLJTQdD8IcTkhAIw1C+NTi9MoP4g8MO
	 6pxoZ2++XYe70949cNld7l53FmeicHRRU7YNJ4zhSma95PprXTSOPPZwgqy8dCfQ6KGvk
	 nxI9L+L7XAN3AhMykNZjlPC+pPVoJC1n1MfDKHtNHFrNAjFUnxNEztUvQal6g42JEHem0
	 6XN+RW2xVyA+A+BGkOTaZde+aATBK2N2lRakqdsZf55LFSgcMBDYQ4MAZh3U9OlCLjhoL
	 gA16/IlXubDyR2Hk+IP7SOnjLoBYt9XkG88hWbD6WbOj3lLh7JvQdIlGtViPDjdn2og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDHlmIao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FD606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDHlmIao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2AA1F0089F;
	Sat,  7 Nov 2026 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050328;
	bh=EuD7mUUEadSeGs6JWkMadGjLE6eJqdaTpauJBa/2pVk=;
	h=From:To:Cc:Subject:Date;
	b=VDHlmIaoGG9btoS/C56T6VpXwouaZT7Gi6PLXqnGuxKlLad8yoNIya1fohP/nCS+s
	 SWvuuHLFT8XgikGXOTl9o6u0v8Rl8spMI2Mk/Iuva2VdoimLGL7px++psF5wmvXw0l
	 lXtoIWUlNV5I3TrbdX9N1tIzPOS0zvHTKAYEj6aShLKezhvCc0Y3Po+Y3VPwrXB5da
	 6CbN94RIofxPBulgxs5egP/414KxW+vajtGS8Joua0pWbJRcWT7SuefPTXCFRmesC/
	 su38Tf0QVKK7dIj2HolamxWTONMTtJ679U0fDrNhp3vl38cx3/L93KHpHVlpOaxLSw
	 6tFEBMEzeSi+w==
From: Sasha Levin <sashal@kernel.org>
To: mauriziocasciano7@gmail.com,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: core: Honor supplied-from with CONFIG_OF=y" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:47 -0500
Message-ID: <20261107061846-failed-5.10-6bd80f22c764@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6bd80f22c764fe8c56c62c118387f86a3ca98cff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061846-failed-5.10-6bd80f22c764@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6bd80f22c764fe8c56c62c118387f86a3ca98cff Mon Sep 17 00:00:00 2001
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
Date: Fri, 25 Sep 2026 00:51:52 +0200
Subject: [PATCH] power: supply: core: Honor supplied-from with CONFIG_OF=y

The supplied-from device property is the name-based counterpart to
firmware-node power-supplies references. It was added for non-DT platforms,
but its parser is compiled only when CONFIG_OF is disabled. CONFIG_OF is
a global kernel option, so x86 systems commonly enable it even when
individual power supplies are described by software nodes.

Consequently, these consumers never populate supplied_from and supplier
notifications do not reach their external_power_changed() callbacks. On a
Lenovo Yoga Book YB1-X91L, ftrace showed the Whiskey Cove supplier
notification running without invoking the BQ25892 callback, leaving the
input current limit at its boot-time value.

Use a single power_supply_check_supplies() implementation for all
configurations. Preserve firmware-node power-supplies references as the
preferred firmware description and use the name-based supplied-from
property only when no references are specified. Continue to honor an
explicitly provided supplied_from list first and propagate errors from
specified firmware references.

With the fix, ftrace shows the BQ25892 callback on hotplug. A boot-offline
test changes its input current limit from 500 mA to 2 A.

Fixes: 58a36bb06891 ("power: supply: core: Add support for supplied-from device-property")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
Link: https://patch.msgid.link/20260924225152.985489-1-mauriziocasciano7@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 84 ++++++++++++------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 00d8bc98d5887..c097601ac5491 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -190,7 +190,35 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 		device_unlock(psy->dev.parent);
 }
 
-#ifdef CONFIG_OF
+static int power_supply_check_supplies_by_name(struct power_supply *psy)
+{
+	struct device *parent = psy->dev.parent;
+	int nval, ret;
+
+	if (!parent)
+		return 0;
+
+	nval = device_property_string_array_count(parent, "supplied-from");
+	if (nval <= 0)
+		return 0;
+
+	psy->supplied_from = devm_kmalloc_array(&psy->dev, nval,
+						sizeof(*psy->supplied_from),
+						GFP_KERNEL);
+	if (!psy->supplied_from)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(parent, "supplied-from",
+						(const char **)psy->supplied_from,
+						nval);
+	if (ret < 0)
+		return ret;
+
+	psy->num_supplies = nval;
+
+	return 0;
+}
+
 static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 						 void *data)
 {
@@ -262,22 +290,21 @@ static int power_supply_find_supply_from_fwnode(struct fwnode_handle *supply_nod
 static int power_supply_check_supplies(struct power_supply *psy)
 {
 	struct fwnode_handle *np;
-	int cnt = 0;
+	int cnt, ret;
 
 	/* If there is already a list honor it */
 	if (psy->supplied_from && psy->num_supplies > 0)
 		return 0;
 
-	/* No device node found, nothing to do */
-	if (!psy->dev.fwnode)
-		return 0;
-
-	do {
-		int ret;
+	for (cnt = 0; psy->dev.fwnode; cnt++) {
+		np = fwnode_find_reference(psy->dev.fwnode, "power-supplies", cnt);
+		if (IS_ERR(np)) {
+			ret = PTR_ERR(np);
+			if (ret != -ENOENT)
+				return ret;
 
-		np = fwnode_find_reference(psy->dev.fwnode, "power-supplies", cnt++);
-		if (IS_ERR(np))
 			break;
+		}
 
 		ret = power_supply_find_supply_from_fwnode(np);
 		fwnode_handle_put(np);
@@ -286,48 +313,21 @@ static int power_supply_check_supplies(struct power_supply *psy)
 			dev_dbg(&psy->dev, "Failed to find supply!\n");
 			return ret;
 		}
-	} while (!IS_ERR(np));
+	}
 
-	/* Missing valid "power-supplies" entries */
-	if (cnt == 1)
-		return 0;
+	/* Fall back to the name-based property if no references were specified. */
+	if (!cnt)
+		return power_supply_check_supplies_by_name(psy);
 
 	/* All supplies found, allocate char * array for filling */
 	psy->supplied_from = devm_kcalloc(&psy->dev,
-					  cnt - 1, sizeof(*psy->supplied_from),
+					  cnt, sizeof(*psy->supplied_from),
 					  GFP_KERNEL);
 	if (!psy->supplied_from)
 		return -ENOMEM;
 
 	return power_supply_populate_supplied_from(psy);
 }
-#else
-static int power_supply_check_supplies(struct power_supply *psy)
-{
-	int nval, ret;
-
-	if (!psy->dev.parent)
-		return 0;
-
-	nval = device_property_string_array_count(psy->dev.parent, "supplied-from");
-	if (nval <= 0)
-		return 0;
-
-	psy->supplied_from = devm_kmalloc_array(&psy->dev, nval,
-						sizeof(char *), GFP_KERNEL);
-	if (!psy->supplied_from)
-		return -ENOMEM;
-
-	ret = device_property_read_string_array(psy->dev.parent,
-		"supplied-from", (const char **)psy->supplied_from, nval);
-	if (ret < 0)
-		return ret;
-
-	psy->num_supplies = nval;
-
-	return 0;
-}
-#endif
 
 struct psy_am_i_supplied_data {
 	struct power_supply *psy;
-- 
2.53.0




