Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0649C4D4;
	Tue,  6 Oct 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300361; cv=none; b=FgLYftIUIdK2zTl81BU+w8rehlP/kTPqLqmpqgmskWij6QMcM/8pxUbZXf9qLyzNUasFxDqkPMWdg8SAZdoSiF5JW4Xs9iGRIMJ5AWIibmeKMIdSaJ7cC5XLJ+5V5LtE+AAYVlOKmhwiDQCx9/IhEDbxeFGoiNA99dLAvxCmjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300361; c=relaxed/simple;
	bh=IbpgRPvv51E1rfrtzZ2C+kaBclf2ARl+M1JlVjT8Lbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E3fFsHD1tettmYbcpOiq4/kVPGX9XWpaS9tz3h77o7XtytK++IuNLkAKuufX+gHueFh911KIN3MaI+yempPfV52N0TR7yGGL8prUMamzSmvkB+MzxK7x1zChynUyuTTtWL4t/h2PuJ7eSlzYHHFarUvOWCTWOPFyuXl7l3AP9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=fcETVPgK; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="fcETVPgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1791300030;
	bh=IbpgRPvv51E1rfrtzZ2C+kaBclf2ARl+M1JlVjT8Lbo=;
	h=From:To:Cc:Subject:Date:From;
	b=fcETVPgKasvErzYJN4kyfvx7cShhUyAnPwMPACjsINHZU3OtoP4Mqp6Anvo4qsu/Y
	 V4eFSN6R3eLQNcQB5fOirgCIH64345eMiaVrbvjXV1YfOy+ouGFpCIK/pazLF642dt
	 rdPLKyRAHm/oZBTQoHk7YGUZUe4R0yvfyEt/u+F+u7GRpAXZTEtzEpqpKdxqlBB2Hd
	 QEfjSzBzpe7UuAPZPKerjvUZ+PaVDMEvkDGNimRBZyLjsrk1aOj4tbQxHABL2+bY8K
	 x7RdTTSAL39vlDXb3yiy1YoW/tt6OOfqrfCUYHtk5jJHSpUYDSKZqKVF27JbTtQ5w5
	 AOKrteywirysQ==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 476BB2585E;
	Tue,  6 Oct 2026 18:20:30 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 18:20:18 +0300 (MSK)
Received: from rbta-msk-lt-169874.astralinux.ru (unknown [10.198.62.171])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4hzg1G0sWTzD0g;
	Tue, 06 Oct 2026 18:20:18 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] powercap: dtpm: Fix power limit distribution below the minimum power
Date: Tue,  6 Oct 2026 18:15:18 +0300
Message-Id: <20261006151519.126065-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/06 14:52:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {date_rfc_vio_soft_silent}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206476 [Oct 06 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/06 12:04:00 #28658396
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/06 14:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

DTPM represents the devices supporting the power limitation as a tree
of nodes: the leaves are the devices themselves, like CPU performance
domains or devfreq devices, and the intermediate nodes group their
children.

When a power limit is set on an intermediate node, __set_power_limit_uw()
distributes it among the children proportionally to their weights,
which __dtpm_rebalance_weight() computes from the maximum power of the
nodes only. So when the limit is close to the minimum power of the
node, the share of a child having a high minimum power compared to its
maximum power can be lower than its own minimum power.

For example, with a parent having two children, the first one with a
power range of 80-1200 and the second one with a range of 400-3000, the
parent's range is 480-4200. A limit of 500 gives a share of about 143
to the first child and 357 to the second one, below its minimum power
of 400. As the second child can't go below its lowest performance
state, the actual power of the children exceeds the parent's limit,
while it could have been met by giving 400 to the second child and 100
to the first one.

Moreover, such a share is lower than the power of the lowest
performance state of the child, so set_pd_power_limit() in the CPU and
devfreq backends reads out of the bounds of the energy model table.
This out-of-bounds access is addressed in the backends by [1], which
is still needed, as the share can also be too low when the minimum
power of a child is stale, e.g. right after a CPU of its performance
domain is brought online.

The power limit of a node is never lower than the sum of the minimum
power of its children, so a distribution where every child gets at
least its minimum power always exists. When the share of a child is
below its minimum power, give it its minimum power and take the
difference from the siblings, proportionally to their headroom above
their own minimum power. The distribution is unchanged when every
share is at least the child's minimum power.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Link: https://lore.kernel.org/linux-pm/20260612062536.9147-1-elazarl@gmail.com/ [1]
Fixes: a20d0ef97abf ("powercap/drivers/dtpm: Add API for dynamic thermal power management")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
 Documentation/power/powercap/dtpm.rst |  5 ++
 drivers/powercap/dtpm.c               | 68 +++++++++++++++++++++------
 2 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/Documentation/power/powercap/dtpm.rst b/Documentation/power/powercap/dtpm.rst
index a38dee3d815b..997664da7ac7 100644
--- a/Documentation/power/powercap/dtpm.rst
+++ b/Documentation/power/powercap/dtpm.rst
@@ -99,6 +99,11 @@ When a power limitation is applied to a node, then it is distributed along the c
    |
    `-- pd2 (w=486) --> power_limit = 1519mW
 
+As the weights are based on the maximum power only, the share of a node
+can be lower than its minimum power. In this case, the node gets its
+minimum power and the difference is taken from its siblings,
+proportionally to their headroom above their own minimum power.
+
 
 Flat description
 ----------------
diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index b7a65e543f19..402b18005a33 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -195,6 +195,28 @@ static int get_power_limit_uw(struct powercap_zone *pcz,
 	return 0;
 }
 
+/*
+ * Compute the share of the power limit of a node given to one of its
+ * children, based on the weight of the child.
+ */
+static u64 __dtpm_child_share(struct dtpm *dtpm, struct dtpm *child,
+			      u64 power_limit)
+{
+	/*
+	 * Integer division rounding will inevitably lead to a different
+	 * min or max value when set several times. In order to restore
+	 * the initial value, we force the child's min or max power every
+	 * time if the constraint is at the boundaries.
+	 */
+	if (power_limit == dtpm->power_max)
+		return child->power_max;
+
+	if (power_limit == dtpm->power_min)
+		return child->power_min;
+
+	return DIV_ROUND_CLOSEST_ULL(power_limit * child->weight, 1024);
+}
+
 /*
  * Set the power limit on the nodes, the power limit is distributed
  * given the weight of the children.
@@ -226,26 +248,42 @@ static int __set_power_limit_uw(struct dtpm *dtpm, int cid, u64 power_limit)
 	if (dtpm->ops) {
 		dtpm->power_limit = dtpm->ops->set_power_uw(dtpm, power_limit);
 	} else {
+		u64 deficit = 0, headroom = 0;
+
+		/*
+		 * The weights are based on the maximum power only, so the
+		 * share of a child can be lower than its minimum power. In
+		 * this case, the child gets its minimum power and the
+		 * difference is taken from the siblings, proportionally to
+		 * their headroom above their own minimum power.
+		 */
+		list_for_each_entry(child, &dtpm->children, sibling) {
+			power = __dtpm_child_share(dtpm, child, power_limit);
+			if (power < child->power_min)
+				deficit += child->power_min - power;
+			else
+				headroom += power - child->power_min;
+		}
+
+		/*
+		 * The power limit of a node is never lower than the sum of
+		 * the minimum power of its children, so the headroom covers
+		 * the deficit except for rounding errors.
+		 */
+		deficit = min(deficit, headroom);
+
 		dtpm->power_limit = 0;
 
 		list_for_each_entry(child, &dtpm->children, sibling) {
 
-			/*
-			 * Integer division rounding will inevitably
-			 * lead to a different min or max value when
-			 * set several times. In order to restore the
-			 * initial value, we force the child's min or
-			 * max power every time if the constraint is
-			 * at the boundaries.
-			 */
-			if (power_limit == dtpm->power_max) {
-				power = child->power_max;
-			} else if (power_limit == dtpm->power_min) {
+			power = __dtpm_child_share(dtpm, child, power_limit);
+
+			if (power < child->power_min)
 				power = child->power_min;
-			} else {
-				power = DIV_ROUND_CLOSEST_ULL(
-					power_limit * child->weight, 1024);
-			}
+			else if (deficit)
+				power -= DIV64_U64_ROUND_UP(deficit *
+						(power - child->power_min),
+						headroom);
 
 			pr_debug("Setting power limit for '%s': %llu uW\n",
 				 child->zone.name, power);
-- 
2.43.0

