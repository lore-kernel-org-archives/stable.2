Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329431;
	b=fduLJ7+3a0zQelUTdtQveasUpjbsybV5zYrX+TUMToo4mPoNXv7XMmNZyOb4e+py3PaF
	 K68L4+f4pmPTjpAchObtQj9q6D8FOI11Nr+bl7Xgados0ihb2MRSer9OaLIdgBCeEF7A5
	 JKKdVlfiqO3WeTR/d8RnX8sNIQc+IkwaK2MEhth14MyKF1BFcMYprs0heQ+U7K6/UFSL0
	 JF299mcAu0I7S/EHt31C26jy7aKhRZSWrujLP41Pyl8plzGdIwBIDTqEkkmZHHy9QK7Or
	 dQLEhZDESvORZbUT33j8OxAXsZiSMoCfHogQ21XwdSrWpvVpSz0QKhUueM8qaB2r3fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZJ5009Vdtk7S+9GVqjTbOjW/Hsz++xdHroYIfVKtg8c=;
	b=r7hnpwmZzkkj1RqrVQTchg56BSkxSufXbuE/Lg3CK1nJPCEO0+Ctm9wwB8XnSowdcZq1
	 pGPf/6BesaSd3NjxCMeTk6sP8NeVKWPVfZWKLGzr3PjxP+llX/XK93P+gjZWAazGqvMfW
	 QlRpXr74B3vw70CQeN85GJSj8A8MSj6uC5HjSxF9GlP65c0W6b1aIw7UYDlRSd17EStII
	 Pt5XBVDV3j5DwyoRwclVWwN7yiJ26nWsR8sFcGJ+KuMhs22RjWjMIrpIzkJU9VYnlnwzr
	 +yEdHBcZ6TLU/aXfPsDySdmJv7tl3WKQvzE4IgVTWruRUEbLrZLGSuf/wZTPhhrQttg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLlP3Sjy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA75606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLlP3Sjy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0FE1F0089F;
	Tue, 10 Nov 2026 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329431;
	bh=ZJ5009Vdtk7S+9GVqjTbOjW/Hsz++xdHroYIfVKtg8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QLlP3SjyT6//N6jv1oTQRnTbQbMv4ZOK7ZslgSjRUIZ7K0+i1hk1ZBSxGv3FG5lj6
	 1qG8Y6NhaZbeyuHLk+of01GWCdbip7dofa+DtYH8p2r2rGzMinx+2GQ+unnk99pJtN
	 A45hkZzM2WuZUhvCYwfzmw+jjZov37jmMNe7Zg/PA/M6hbD8ieSLkiQzTLs2Woe5EX
	 JUCJdgAki3T5K+YRh3CBB2t4hJLVV5nzW2cjyLY7CyOJVLZDLjrQnnNRNiXbKOBwgd
	 sk1LZp0S+lteiG/uch/ZONS5E393BpzoVDB+3rCWBsPPp4DTvpHotdbKrKm2cAaXxI
	 uENnHtsb8toIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] power: supply: core: introduce power_supply_for_each_psy()
Date: Tue, 10 Nov 2026 11:50:26 -0500
Message-ID: <20261110164953.2511682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051904-failed-6.12-6bd80f22c764@kernel.org>
References: <20261107051904-failed-6.12-6bd80f22c764@kernel.org>
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

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 9029409d1a250da19f1086ab1113752411c5163d ]

All existing callers of power_supply_for_each_device() want to iterate
over 'struct power_supply', not 'struct device'.
The power_supply_for_each_device() forces each caller to duplicate the
logic to go from one to the other.
Introduce power_supply_for_each_psy() to simplify the callers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20241210-power-supply-dev_to_psy-v2-2-9d8c9d24cfe4@weissschuh.net
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 6bd80f22c764 ("power: supply: core: Honor supplied-from with CONFIG_OF=y")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 24 ++++++++++++++++++++++++
 include/linux/power_supply.h             |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index edc7b3bd9b5c8..34aca2c76cc5d 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -122,6 +122,30 @@ int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void
 }
 EXPORT_SYMBOL_GPL(power_supply_for_each_device);
 
+struct psy_for_each_psy_cb_data {
+	int (*fn)(struct power_supply *psy, void *data);
+	void *data;
+};
+
+static int psy_for_each_psy_cb(struct device *dev, void *data)
+{
+	struct psy_for_each_psy_cb_data *cb_data = data;
+	struct power_supply *psy = dev_get_drvdata(dev);
+
+	return cb_data->fn(psy, cb_data->data);
+}
+
+int power_supply_for_each_psy(void *data, int (*fn)(struct power_supply *psy, void *data))
+{
+	struct psy_for_each_psy_cb_data cb_data = {
+		.fn = fn,
+		.data = data,
+	};
+
+	return power_supply_for_each_device(&cb_data, psy_for_each_psy_cb);
+}
+EXPORT_SYMBOL_GPL(power_supply_for_each_psy);
+
 void power_supply_changed(struct power_supply *psy)
 {
 	unsigned long flags;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b03991a29a65e..565a40172cc30 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -890,6 +890,7 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);
 extern int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void *data));
+extern int power_supply_for_each_psy(void *data, int (*fn)(struct power_supply *psy, void *data));
 
 static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 {
-- 
2.53.0

