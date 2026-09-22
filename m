Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698A550DB9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083124; cv=none; b=uPtxWr1serSpvPxN/YhcNrO9xc8Q5boBkWgi+tCdtrUN6mBoSPVkZ5bW6T80/1fjltItJX7+lIxY2aYsTos7hbakICfoIvY6xeJt5Mwy00bmqcOeifsi9cYPGC0bJi7w4uy/Vaj6FRsEtHFzslzjN/G1TEw14RKWipGgX6Gc2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083124; c=relaxed/simple;
	bh=Yqr0Kew2QL4W9hQyxVxIzeIxLdzAfdfCM9tYNpXSm/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkGFOE4mqTcgiQUODgXJMmt7s5oTUDDDrOGAYIB5exCVpqh4M+KDkLnLz7txajuKLb/0du0EOF6NTcA5tLl7FGBmBaybzbqF2YMQ8V6jDtlECp4JbDifYzhfJoqhC9+Di2oze0IGV5MQvkHtTS/9G/78x8AvzyFwPSNbiYcIFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZHOIK7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZHOIK7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE011F000FF;
	Tue, 22 Sep 2026 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083122;
	bh=+F/w8xwovGdnbQRpNCMAtC464P6wGR9nbgvPTlW2VzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aZHOIK7i2ea+wnpo4qdbHVk1mhaHJaZWxXC37R7eVjbMfVT3GsTeb2Dd1hLS6Lh+c
	 2lgZsD9DtlmrsPcyRw93OGR1EHyLrSv3SH6j1/76Ywb2qPUtlVkYy24lhqUnqqW5kC
	 4zbHpZkWBCgNsI34OkCvBf5COM6B9/1aZa/FpS91UTogypkyK+RSSrZgD/4ldHbnRE
	 Ah1l0bdBIroKrGmefm+QO3AKMWzsg+yvJJ4DDegvqdFJtiAsyPIdJgSh5LMlh6DMr6
	 WQd6eo8NHTgD+iEm4HNsMU79ozKfcRteoSbsIRdkFO1/zKFDlTOPRuMa3g16sL3b5U
	 IjQ6hMQ2Qf/YA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] of: Introduce for_each_*_child_of_node_scoped() to automate of_node_put() handling
Date: Tue, 22 Sep 2026 09:18:38 -0400
Message-ID: <20260922131840.2444454-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092256-flyer-contusion-4709@gregkh>
References: <2026092256-flyer-contusion-4709@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 34af4554fb0ce164e2c4876683619eb1e23848d4 ]

To avoid issues with out of order cleanup, or ambiguity about when the
auto freed data is first instantiated, do it within the for loop definition.

The disadvantage is that the struct device_node *child variable creation
is not immediately obvious where this is used.
However, in many cases, if there is another definition of
struct device_node *child; the compiler / static analysers will notify us
that it is unused, or uninitialized.

Note that, in the vast majority of cases, the _available_ form should be
used and as code is converted to these scoped handers, we should confirm
that any cases that do not check for available have a good reason not
to.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20240225142714.286440-3-jic23@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Stable-dep-of: 0d1cb83337f1 ("ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/of.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 3c840c4879956..97352f3afed50 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1291,10 +1291,23 @@ static inline int of_property_read_s32(const struct device_node *np,
 #define for_each_child_of_node(parent, child) \
 	for (child = of_get_next_child(parent, NULL); child != NULL; \
 	     child = of_get_next_child(parent, child))
+
+#define for_each_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_child(parent, NULL);				\
+	     child != NULL;						\
+	     child = of_get_next_child(parent, child))
+
 #define for_each_available_child_of_node(parent, child) \
 	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
 	     child = of_get_next_available_child(parent, child))
 
+#define for_each_available_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_available_child(parent, NULL);			\
+	     child != NULL;						\
+	     child = of_get_next_available_child(parent, child))
+
 #define for_each_of_cpu_node(cpu) \
 	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
 	     cpu = of_get_next_cpu_node(cpu))
-- 
2.53.0

