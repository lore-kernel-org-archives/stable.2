Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584980;
	b=5LkMcKsMCsLvh3GGlLBQ8ild8K4y8mbKjI1R4wZepgTmIlLFoUTD5vkE+HE/DkNc2Os7
	 HYgnRgMw8KWkAmk/CqS16mjgLt1X8Mrrq1jVwowuuOX17Eo8RPM76VlhD34JFoLdXum/Z
	 JNFxDARlo7AM9wM0US4hDwHruPPCGEFXbptTJmf808ZXMML0IJ2HwQJISExmesa0bhXvo
	 pKSLiReLnWcqsy4akRcnG4G9Mj1nug1YQCKYBbU6Uc7buTdfTpJ8S9AlYFH7LPbijQj0Y
	 jP9m3N42LpK6o+nXhiPWbaGDz39oJIVqzuy4m1ybalKnfqkoQntq8MeV9ioSqlUB3eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584980;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3sV2BVll+rmA+nzXI9MkZz3cUVSsRVhz3ZropH017dE=;
	b=cdrdy3yPv9mvbzUstP64gIQwuKj6JOnrwWUKT7qtR4PMdmjkB47vmwfMXVYb4BfegXfY
	 8kPXAD0CkzT33w49+a+W4GuIVH4oN+f9FGf7dNVWXam1W72JL4sfbAYXGZF8jFd6omieq
	 v76zukE6Cwh//w82iqJyO9GOq1JHUkDGZAly+I5HisoTqghVXsBoe4F7uxA7zEQNN+bDu
	 BhMZ186uEiK8gSS5Pdp7aT/ptqryhUAmCRdMGLTF+QcuT5Mf3NqLvcAk4fLhrlx0TZiif
	 FK4ZV3WgxgHusKsm4fPvmDRrDAfkopbxGnroYISWc69UdTtoc5qenR3R206TGzxGiYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XgQaPU/t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A1606A31B;
	Wed, 21 Oct 2026 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgQaPU/t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267711F000C4;
	Wed, 21 Oct 2026 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584979;
	bh=3sV2BVll+rmA+nzXI9MkZz3cUVSsRVhz3ZropH017dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XgQaPU/tHQ9qG5+iV9rAw//oA7KdsmgdtJivOyAzjRyPRZhJyaUG8Qmo7JlBY5qTu
	 nrTF6ZrnMzc5lpbtM2AwahvSfgGOFd/7DXE3cyMAJywI9mm5dfP9dJWWX8Nr9sl7iA
	 rDxHBhN1UJDOsEFqj8feYfo5Xs8GFo+yfoqTCDsPzLph07QM3Zp5JKv4mcKtFT4OIe
	 Nvxpvz3MrQVhSAjwNYErptApnZNz5Wj3egVYqWoTOsBicl06purDm7MYA2HL6BB1BU
	 aMfM/E2CHHg1ZjCX3ERNx7fMVSBk+eZrG+nT+iS7Sdki1LWfiuSZJhdJyILcnKpgBq
	 0aMsEnmmmHnqA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Mattias Wallin <mattias.wallin@stericsson.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 22/28] mfd: abx500-core: Unregister device ops on devm release
Date: Wed, 21 Oct 2026 12:09:44 +0000
Message-ID: <20261021121245.3111563-22-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

abx500_register_ops() allocates struct abx500_device_entry via
devm_kzalloc() and links it into the global abx500_list without
registering a devres cleanup action.  If a caller's probe function
subsequently fails, devres frees the entry while it remains linked in
abx500_list, causing use-after-free and list corruption on later
traversals.

Register a devm_add_action_or_reset() callback in abx500_register_ops()
to remove the entry from abx500_list before devres frees it.

Fixes: c211b6b9c014 ("mfd: abx500-core: Convert to managed resources for allocating memory")
Closes: https://sashiko.dev/#/bug/linux-6a9c6b8b-8f89-4af5-8cb1-102822e44e6e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/abx500-core.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index e896531d0354..5873e335c395 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -5,6 +5,7 @@
  * Author: Mattias Wallin <mattias.wallin@stericsson.com>
  */
 
+#include <linux/device.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -33,6 +34,21 @@ static void lookup_ops(struct device *dev, struct abx500_ops **ops)
 	}
 }
 
+void abx500_remove_ops(struct device *dev)
+{
+	struct abx500_device_entry *dev_entry, *tmp;
+
+	list_for_each_entry_safe(dev_entry, tmp, &abx500_list, list)
+		if (dev_entry->dev == dev)
+			list_del(&dev_entry->list);
+}
+EXPORT_SYMBOL(abx500_remove_ops);
+
+static void abx500_unregister_ops(void *data)
+{
+	abx500_remove_ops(data);
+}
+
 int abx500_register_ops(struct device *dev, struct abx500_ops *ops)
 {
 	struct abx500_device_entry *dev_entry;
@@ -45,20 +61,11 @@ int abx500_register_ops(struct device *dev, struct abx500_ops *ops)
 	memcpy(&dev_entry->ops, ops, sizeof(*ops));
 
 	list_add_tail(&dev_entry->list, &abx500_list);
-	return 0;
+
+	return devm_add_action_or_reset(dev, abx500_unregister_ops, dev);
 }
 EXPORT_SYMBOL(abx500_register_ops);
 
-void abx500_remove_ops(struct device *dev)
-{
-	struct abx500_device_entry *dev_entry, *tmp;
-
-	list_for_each_entry_safe(dev_entry, tmp, &abx500_list, list)
-		if (dev_entry->dev == dev)
-			list_del(&dev_entry->list);
-}
-EXPORT_SYMBOL(abx500_remove_ops);
-
 int abx500_set_register_interruptible(struct device *dev, u8 bank, u8 reg,
 	u8 value)
 {
-- 
2.56.0.218.g1ec904b173-goog

