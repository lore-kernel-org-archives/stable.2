Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA8364926
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067254; cv=none; b=kblJVEv9FIC3HDMh0Rt1kDc27ph2+idQYvMpgVrpljvsFJ4LrMVeW0wGGVDfErmvEmJIYWuyz16YWlQdeCFqArLb8VXXQ0BTSj9GopW9UGaKWpxNk4JZY7JnGKzdNRgCZH/wmZYEngaVEs1ngUEUuILnfbrgFMV5+Es2ct+RLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067254; c=relaxed/simple;
	bh=jIltM7qfjEgEKLKAdEcyKnLdky49UmFziS3dYJDEdQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5+yue0Omhz1cp02QE5TBwJo6jclg+WmGvG77DBc2AZx8Q6s1/Qb7p2H/4gO9/S02mewnnI1WeA/yvAd0+rUjjqylis6f+V+5PNDMgupOlvzxqUaTV8LS0AmbY0YuLSfdCzbrdcnIgAfkA6AL4UD3LQIkjrluRjuZgxOKbskpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC81pXz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC81pXz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F4B1F00A3E;
	Sun, 26 Jul 2026 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067253;
	bh=sZ5i7oJo393Rm1kjdphYk9u5Uf+M2q+abqrIsxo9vpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IC81pXz8/5NSfoUgc2q9i/niccCBGYZC8avQ2/XBlEWWiZIkrBg2rYRo6OvI7SDRC
	 FX9puw/22/X1iqkyMwAROSCBFmlKbJdZ+GqptF1sT9zJqvr0nSKmMML2RvE5dzpPWF
	 aESZk8ZVFKTvUefsk1vzYRTBPsGhe6sKgmFUjkT/GOgi1WSZABbs/cPVlJwdk21OES
	 Q0CifVotr1mjKnoRg5U/RfnC/46rFN6u/xt1F5MgpRY3W41P5TkORpgDpT6nA7NRdo
	 Q33USmOc4jjs7uyX4hA4OhVq9DuFXLQzOYiPSi6cOYR4CaTPgr7AEAVVVPV1ms36pO
	 XZfSsbk7XaV7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] thunderbolt: Remove service debugfs entries during unregister
Date: Sun, 26 Jul 2026 08:00:48 -0400
Message-ID: <20260726120050.4138299-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726120050.4138299-1-sashal@kernel.org>
References: <2026072000-karma-payable-51b3@gregkh>
 <20260726120050.4138299-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 4d5fc3f4068568dfcb8cbe2852b4adc56394aa26 ]

We add them as part of the register path so to keep it symmetric remove
them as part of the unregister path. This also removes them even if the
service itself is not yet released (but is unregistered), thus allowing
new register with the same service name to happen.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Stable-dep-of: 2c5d2d3c3f70 ("thunderbolt: Prevent XDomain delayed work use-after-free on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/xdomain.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index fd2356db934fe3..56344260b4f2c6 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1008,7 +1008,6 @@ static void tb_service_release(struct device *dev)
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 	struct tb_xdomain *xd = tb_service_parent(svc);
 
-	tb_service_debugfs_remove(svc);
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
@@ -1023,6 +1022,14 @@ const struct device_type tb_service_type = {
 };
 EXPORT_SYMBOL_GPL(tb_service_type);
 
+static void __unregister_service(struct device *dev)
+{
+	struct tb_service *svc = tb_to_service(dev);
+
+	tb_service_debugfs_remove(svc);
+	device_unregister(&svc->dev);
+}
+
 static int remove_missing_service(struct device *dev, void *data)
 {
 	struct tb_xdomain *xd = data;
@@ -1034,7 +1041,7 @@ static int remove_missing_service(struct device *dev, void *data)
 
 	if (!tb_property_find(xd->remote_properties, svc->key,
 			      TB_PROPERTY_TYPE_DIRECTORY))
-		device_unregister(dev);
+		__unregister_service(dev);
 
 	return 0;
 }
@@ -1127,6 +1134,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		tb_service_debugfs_init(svc);
 
 		if (device_register(&svc->dev)) {
+			tb_service_debugfs_remove(svc);
 			put_device(&svc->dev);
 			break;
 		}
@@ -2059,7 +2067,7 @@ void tb_xdomain_add(struct tb_xdomain *xd)
 
 static int unregister_service(struct device *dev, void *data)
 {
-	device_unregister(dev);
+	__unregister_service(dev);
 	return 0;
 }
 
-- 
2.53.0

