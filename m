Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE13E4C6B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099470; cv=none; b=HDpnKPE4n9yrfMZaeZZlWTEawuIv7QjphILR1NP30Rr9maO/NwogGMNpxVvdsi0xFJTDzjM1+HPFJIjV4uV2wYPm/cEWxiEyZJ08pfpE2XfExQCXpxWSOIV+ENThJD+hPqq4uJcSvEiXrBhkTyEzLebDcqaZttOuWOL6+Ztjxlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099470; c=relaxed/simple;
	bh=TojcQQD7rcJaXqBEP6/EqfwihK5s9PQjWIo3Bhs06Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Acem0HWSXoxKg8zC6aoa0sjZTVdSiGqe1nxqnGyocHr1Hvm9FcHx5HAsgyPfrLhh+/WgxXg71F+Gs6aneg65SLgxBTS2FAux6tbeyQ8VAamyp3w5mSVi3qXXJOraJMi87M7umhPBruh/Kvj4iPI9pzz7gku/1NkQYDP63exFCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jol8x+yV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jol8x+yV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC2A1F00893;
	Tue, 22 Sep 2026 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099468;
	bh=zgZ6TG5dP/ij+Zkw/WdTyIHWYmPNpG5l5AUtQ7wLR1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jol8x+yVoxEzNs88XAG286Eu4RGu9RazY2ne0tPCqqDnE7HFgpksWYTptHahHt4Pg
	 0KPB2vbX9mpt6Jf5JsN2126FcOpTL+aFjyScZIG0ITXzdPhkvONSR84j1E/8kF0F9Z
	 AUH2Lr8+0Zvfv3ae6yyU0f+i0TzLN55YhCfX9yl+1gyLuikZUyYe1GQsyGWMIzJyAT
	 +TiXdqcXC6VLQqz8tDf1M6xWGjgkkqZPnnamH63FHghfe/Pbx/1oVYIXpNTwbMJqWg
	 VrqIKbMy55QPZgO0Mk4Epse8/hinDenK5ea7ZqcnSB2H7EHWO54lf6iglOBfBlnkBG
	 4MX4khEGrK57Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] of: Introduce for_each_*_child_of_node_scoped() to automate of_node_put() handling
Date: Tue, 22 Sep 2026 13:51:03 -0400
Message-ID: <20260922175106.3308111-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092212-fruit-deploy-01d6@gregkh>
References: <2026092212-fruit-deploy-01d6@gregkh>
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
Stable-dep-of: 7362a1553eb0 ("i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()")
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

