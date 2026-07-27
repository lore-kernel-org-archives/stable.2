Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B63B4E98
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166881; cv=none; b=BbCrrouuc1BbTP4613YBVe5tmPJV+pl75y43AMU9rEfcmXL+SPCyrg1T1rrMw0yk4gwLQX145P8tlhgZqoocDvFiNS5x6zpDzP/PT8ablp/EjPQ4iGDZi5AGWZKyvza0O7h1akTH5YWAx5X7xUAvg39WVencvSu988QBgA85GxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166881; c=relaxed/simple;
	bh=mB9Cuy2v87mnec2B0ncIGX/OioY4Cj9UVIq9RInzi3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAlRSb5yZK+NczMjgTFBxH2w/o5yaaX88jyEuobIZ1V6uA66jyfKSeUrcFLsTlYF13Pl9DDK7RwUaz9q8d+OrwCoBE0CN6atfSuMJhEZdHr8gM6mFn5ivmoyNuM5mmMs5iAsJs1D8PjrnIxDG3pZhQNQKLvpcKPPhbWAZC9iTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPnnPkwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPnnPkwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E5E1F00A3F;
	Mon, 27 Jul 2026 15:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166879;
	bh=eaJhex4uFBLE6NwZJqP50t3GXHDUwT4W455sDtcdr1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iPnnPkwzZDxmVc+PZjD8BDcRRfUqrtFqqvoOwkq/WBOG0pHLpq5Oi+2vrECDWG6JD
	 I+hAFOjYwEbkaVzn5KViMSQ7YNXxTG5cG4EU8M5Iqu/O3tfQ8XXGvQgm+QhVstbdGZ
	 C1XLANAHTbJnaEszwpjrkMgVZEa+6vWD4jo/Quut41Hjy/FK0Xbt7DA3XvSahnooM5
	 xtoWfkzwXVrjtF20+7IxmyqEm8HwthjOmTKLPBgD5aWL5cqx6GezIDPA/QDSc6X1JV
	 HB3nEhPU7g8eK5wPBRzhDF2F7lcdSOv6HgD5gxMdbEGsqnZ+HIxFzgiOEm8nTrzm3A
	 eWT0IsAnW0/Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] thunderbolt: Remove service debugfs entries during unregister
Date: Mon, 27 Jul 2026 11:41:13 -0400
Message-ID: <20260727154115.1516559-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727154115.1516559-1-sashal@kernel.org>
References: <2026072001-numeric-suffice-a245@gregkh>
 <20260727154115.1516559-1-sashal@kernel.org>
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
index b137d69d00b010..78b01d3396a20f 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -807,7 +807,6 @@ static void tb_service_release(struct device *dev)
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 	struct tb_xdomain *xd = tb_service_parent(svc);
 
-	tb_service_debugfs_remove(svc);
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
@@ -822,6 +821,14 @@ struct device_type tb_service_type = {
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
@@ -833,7 +840,7 @@ static int remove_missing_service(struct device *dev, void *data)
 
 	if (!tb_property_find(xd->remote_properties, svc->key,
 			      TB_PROPERTY_TYPE_DIRECTORY))
-		device_unregister(dev);
+		__unregister_service(dev);
 
 	return 0;
 }
@@ -926,6 +933,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		tb_service_debugfs_init(svc);
 
 		if (device_register(&svc->dev)) {
+			tb_service_debugfs_remove(svc);
 			put_device(&svc->dev);
 			break;
 		}
@@ -1462,7 +1470,7 @@ void tb_xdomain_add(struct tb_xdomain *xd)
 
 static int unregister_service(struct device *dev, void *data)
 {
-	device_unregister(dev);
+	__unregister_service(dev);
 	return 0;
 }
 
-- 
2.53.0

