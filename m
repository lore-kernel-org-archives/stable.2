Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E233812EF
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069377; cv=none; b=M5yNsaAfpFupFdgG9LG+jxxepHsWCrKdtedtYlHPPTMmQSMmeUXa7IzRY5sJ8Op34YBrKb4OWFRjjwejxBHn2MjfxzaUdz+P3/UDK7ATGh+5xx2VTVTrRlahXIlxWt/DTz5Oguash6LxpU6QtSRT4AalNTBr39ZUaW/QQWTOc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069377; c=relaxed/simple;
	bh=1yUIdw2H8Ca2VQT3tvLn2u6m9/cNqEmK2zceT7x0AmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1jvxaQmTyT7VcSb5dcrncnuQMgvxLVshi1i6G5J7YwgYKWxgvHymVqL9yUKeZahpywD7NPcrkM9eSMThmgA3oMGFcl8epG6iid7F4dCyld2LhJ9LG5/Vsr6rbdAySXiZSYDAjWdrMt8rwxi/IpRMqRJBdm5k//QiPqmDvbyOU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVGfHt8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVGfHt8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F761F00A3D;
	Sun, 26 Jul 2026 12:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069376;
	bh=XbqvUKu3jbb/joH9T0qIV+l53CMNXSpdeQT2dVbCVYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVGfHt8TSezu9nGyDL0XfRPVspEjXOZjkitdYYUalSl3jM/+GTA9ddpFArjou2y4k
	 QhPOD0Qntgf2AdYxvlrpXOOR2N7KsUZoGAkzHoqFT0UmnsFsYlfXMzb1QgPxXO72eD
	 R0rUiU9bFGvLLQeQek3j9UuqcpUc0f2NMOQY9nl/9AGDx96Tr2zzGxkNTIg9r25ciM
	 aSu85z37cn+b1BIht0zoznVZaH8wo6SRHGhilU2yFFz28EgraolNnVQ5RcqO/9dGSi
	 Kn2/JUvCVYvh3czak2P4wfxOAtqATuyNlnpTo8RA46+IXvns/ctw8Tl8oRVyVQwwfg
	 iY7++268e/BPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] thunderbolt: Remove service debugfs entries during unregister
Date: Sun, 26 Jul 2026 08:36:11 -0400
Message-ID: <20260726123613.37376-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726123613.37376-1-sashal@kernel.org>
References: <2026072000-monoxide-trickster-c965@gregkh>
 <20260726123613.37376-1-sashal@kernel.org>
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
index fa26d750dfe5dd..2877bb7502462c 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1004,7 +1004,6 @@ static void tb_service_release(struct device *dev)
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 	struct tb_xdomain *xd = tb_service_parent(svc);
 
-	tb_service_debugfs_remove(svc);
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
@@ -1019,6 +1018,14 @@ const struct device_type tb_service_type = {
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
@@ -2053,7 +2061,7 @@ void tb_xdomain_add(struct tb_xdomain *xd)
 
 static int unregister_service(struct device *dev, void *data)
 {
-	device_unregister(dev);
+	__unregister_service(dev);
 	return 0;
 }
 
-- 
2.53.0

