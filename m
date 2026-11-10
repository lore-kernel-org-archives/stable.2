Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331280;
	b=XBn67SORu4IiR4NHlR7s5WoAm7O/8z68cA/tqoKRq6lhgjl41qKEsmpYEdsxoM5BhmXx
	 Hyroonr5mV7oooKSmXjE06kf/iIys6dtUtoxMmvqaZNiunC8ChivGrzuSDA9iR2GnCMLQ
	 G0++iru/RoZUpIagdCilAuPmJMy7+3NmTWg3dPtrtcHgsm9rLIr54cis7RDU3xf5SoGtH
	 p8Rmy2SckDFfUhDEMlk8DJkgT6Lkf00dNBAy8xVFtUYlg1Enowb7nOYbEQWbgfueOpMZZ
	 QjZFPYp7C68uW2aCtIDLROpYfwTtg1U4EOrMl2+1OTqa4gJtAWsdeTsTkHe2ctVEJVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331280;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ssH6HwwW/22s3HaTOrh7P5UltrF+vNwFkXnSewS1vN8=;
	b=veSoDOZLngmwFyQO3R7qgA840ds4w411pA8NzNUuGjquXaqas8YpeqfqVPIIhWarnKRh
	 fVCJwQn0hNCeRy7J2vXl3cqj9SAfm7YBh7FCE1BLT1v87iqMif/LD8soUAsmRxC/84nLh
	 yd1Fkx9naXgm7/HdnswZ1S7dgR+Kcct0N1ojVXdW5Iasw5qWUd0bftkWhcN7PcjpnwtjJ
	 GuzT5XBZRLhENymd1qoVVYnPvXET1+vAjxomXPMZ6SXOINbRm237pATJO3M+n2WghNIK5
	 UWL8xl3Z9vQwru7tzuSScaX0tYxg3y5FHxEatdYoNwfu185KB8gppLyXikUH5z1GzKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVBYGgJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F1606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVBYGgJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699601F008A5;
	Tue, 10 Nov 2026 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331279;
	bh=ssH6HwwW/22s3HaTOrh7P5UltrF+vNwFkXnSewS1vN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AVBYGgJCj32u9oWmy31qsAJEV9QURx2w7XQgfHib67xtx0nfCjk5UPUA3Orfs1Ucg
	 PTS447yOJHjq0kVrTQew+xCLlOVI6OXMAxtzBZunNdfA5Ho5Ty95W9CfL2m0AK56d7
	 0JciRsaJEGCg5Vl8Eeju2Nq7d0aEbUZ5ct+fXPlB9XQqAZExYNb2qpYZDmGvfIiNv9
	 Rz6FpZ+9deFx3FN09HVRyrEyIkXCkh6R3vfca4vDe9Hz8xMTAAXcr3agxccyKgdfbo
	 t6Aa+v32oAMDXb9CvGLJ/7clWJgLSMVtx8QZ/LAMn9RMG3b1ORZ6JGSewQihCagTIP
	 wOpq6NRKPQlIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/7] power: supply: core: introduce power_supply_for_each_psy()
Date: Tue, 10 Nov 2026 12:21:10 -0500
Message-ID: <20261110172014.2622013-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110172014.2622013-1-sashal@kernel.org>
References: <20261107053127-failed-6.6-6bd80f22c764@kernel.org>
 <20261110172014.2622013-1-sashal@kernel.org>
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
index df5e21ec01638..260de00996bc1 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -119,6 +119,30 @@ int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void
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
index b08e00368f9de..4b231468c3f1d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -896,6 +896,7 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);
 extern int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void *data));
+extern int power_supply_for_each_psy(void *data, int (*fn)(struct power_supply *psy, void *data));
 
 static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 {
-- 
2.53.0

