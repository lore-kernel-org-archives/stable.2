Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61F37B036
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785074403; cv=none; b=fOXIgf+vG7CpS9iEMH58Jr4skl4gh0nKZ2Ge6zFlypZoso/lZtLbyKZOROVsnCVrFi9MVS4vzyeK/37evVcAW0I8JzasO2u3+kwxlYYS5AfLEVJpX/KCQLtkm4cDZewrgvWirJeQhINctTOyuXOezM9w7n64OjeICTQco3KvJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785074403; c=relaxed/simple;
	bh=qIJL6BPcWffScLs9heeq3hiqw0kCqagM/EnWiO9dxoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIgyRY+1MCoa/9ErK3wSqvlnxsvPYcsnM0evl8M358JnsUWeteS2/h26f/2DL5wxZoDKV+fWvx2su1XBm2UhX35+Mdm1hMIv/YWZvFT9+WN8iHj+/TyS5r4vYKNzWgKDk1fOWCkCU8UK80gU46rSZs6wOqtV8FcPKXYZk6R2fxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxIUtBvR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxIUtBvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D895A1F00A3D;
	Sun, 26 Jul 2026 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785074401;
	bh=m/n9T6jqC2B8E74biJNGdDeKQ7kdYIbZl7WdM4JZnVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GxIUtBvRoRRDAqN7E7PYomfWMkXtzK8wEIGY34GWOalLR7zLDJ1yOXZy7pOI9KSPS
	 vEMlJDNbCjjR0YYgFbMhORAlvV/zsBMCU3An+Maa/IuqAPB0WJ54EGQkx+r+zBhN0q
	 kyo96zt+RRgMuShXb3ES1fjBqak0JziK5m1wvsAZhy1t3R/Rh27d3TEGObGuES+2Nf
	 xVeTAGyh+nFuVjmTVp8EyUU9EtijF2sW7dbC+dVj0VxFdguP/ZhPrgt55hhfTF43rm
	 6ZPNNxZsUur+wdzLjjXA/ZnEY5YD1U1nTUAwNuSKCoO6ULhl92k7kDHItxXI4DAc/C
	 mNZSyRVfV3yLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] thunderbolt: Remove service debugfs entries during unregister
Date: Sun, 26 Jul 2026 09:59:53 -0400
Message-ID: <20260726135955.668115-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726135955.668115-1-sashal@kernel.org>
References: <2026072000-womb-upturned-7ecf@gregkh>
 <20260726135955.668115-1-sashal@kernel.org>
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
index 1dc202bff07c09..f4f4c8d34ad5eb 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1004,7 +1004,6 @@ static void tb_service_release(struct device *dev)
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 	struct tb_xdomain *xd = tb_service_parent(svc);
 
-	tb_service_debugfs_remove(svc);
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
@@ -1019,6 +1018,14 @@ struct device_type tb_service_type = {
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
@@ -1030,7 +1037,7 @@ static int remove_missing_service(struct device *dev, void *data)
 
 	if (!tb_property_find(xd->remote_properties, svc->key,
 			      TB_PROPERTY_TYPE_DIRECTORY))
-		device_unregister(dev);
+		__unregister_service(dev);
 
 	return 0;
 }
@@ -1123,6 +1130,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		tb_service_debugfs_init(svc);
 
 		if (device_register(&svc->dev)) {
+			tb_service_debugfs_remove(svc);
 			put_device(&svc->dev);
 			break;
 		}
@@ -2048,7 +2056,7 @@ void tb_xdomain_add(struct tb_xdomain *xd)
 
 static int unregister_service(struct device *dev, void *data)
 {
-	device_unregister(dev);
+	__unregister_service(dev);
 	return 0;
 }
 
-- 
2.53.0

