Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CFE3002A9
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988746; cv=none; b=oc6s6mNKdLh4LCgfcBl7208Z9huAt1FGHmdYGdE3XVHIeC94sWoxwH5WxnQstGVJP1hMriCF8dne4FeojFgAEIUAEbSvzHNN9XWGq0EN3mADL4SQp6wb2d95gKGz/qCESnf8alopleLCFHBh28oQuB1luKEbavxqduza/U0L4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988746; c=relaxed/simple;
	bh=yW7afsh+djjFij+pngRaIfLzXpsiTWNCmjDukybf3NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/QlGGPd30HDF3/bJjm/+MTmUpIoAeY8uT1UVkIw0Tsn3wl/gklI4CvHi/W0GUzmWeuuIZSQBMuhqJZkRsFOJcWxf2Zy/j/M3CGNj0Mf8AVuJd48up3Vy7aFESu6uyjaCBp6RcculjuaA1Pdq03+Zz330BXmM/PXmdReYliSjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqhBUBZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqhBUBZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070541F00A3A;
	Sat, 25 Jul 2026 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784988745;
	bh=xBdDyW+hkolvusxDoVH9pqGYrhp3WkXD4cTF8tG9xVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqhBUBZthFZJ7dU3bKBPIAFPVOqTuNsfFnZC1WXmuFSCGmnjuGwMvD3d4EBLEH7G6
	 u1m6+M4VyPdwj5ahulDejAbQwMq1OCJHU67zlOXB6ltJsmBjYDbWXUUaRuqhqGslsc
	 IkJc8ugULIF/rzYJpuQHV9YSU9MNkJLRj+k/mYgYcc9niYED9D4IWAFc+Gx2rhFxRh
	 /7MgtlNW0zF3/e+CcUkrv2ih8jpeTmhV9sE3uEUjfP8zU2eAaqotL/qVts3MNUIf8h
	 V7RL1RsP88aDF08vRMOm5MsabFKlx79Tks5+7HVtwB9/zmEZ+D73Xa83V9wfJW4KGE
	 q01rCc2zq6AAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/4] thunderbolt: Remove service debugfs entries during unregister
Date: Sat, 25 Jul 2026 10:12:20 -0400
Message-ID: <20260725141222.3814514-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725141222.3814514-1-sashal@kernel.org>
References: <2026072059-tumbling-reflux-fc14@gregkh>
 <20260725141222.3814514-1-sashal@kernel.org>
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
index 1276581ef02938..477db46dd88720 100644
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

