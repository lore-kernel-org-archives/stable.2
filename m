Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E142339376
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716232; cv=none; b=UWXCwbKZ9a5KBWACN4Zmc0uM4+umADfP4tYN4teHXtkVk6mLSFU5ag/uqQyG2heY5hP72qszQ00+7ZUS1kxTqdFI3DomnW9Eg4Mv9XvmN1LcWZBAz6O/nCxVIQAVudSlhkpOSBIz2Se9GbCImVcgY+yrl8EF8uwjk3fmQoDuNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716232; c=relaxed/simple;
	bh=wv+lB/ozzFCNDFyDauJ0G5zbNgqx3hM88vBA86S2I44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAjBctGCS7Y7HOInClPYMMWiXhuDTxB0QM43UWlDccZ9il8ZMX64V3CRflb53YFjg3GCrSd7IwkTcoVA3LCXdi8jDMTfmQY51d/WwV+yXN6+AKRgb6R8aJcJjL/JBa7TNpKKQXc7T9nGHut/tEpPA1h/af01YJQRvWLfz04S4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8IYDK/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8IYDK/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DA51F000E9;
	Wed, 22 Jul 2026 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716231;
	bh=4jmRT1onoYk+SBGhf00KpP6mORZqzi9U+kqZ2B6rXhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R8IYDK/bI05JJY3ZQ59jpJHI/omzKIIeN3qGZDxHCplmbVnkoIva56/W5lTQ1x5pe
	 OqgQGkIHVkO4Rzy8jsqxvMPqdQNDBru9+Kt8rVJ5qpDb7t8r2n3iPFm+6jiB+EVlmL
	 SybjJbQnRlUgcTfOjn2jpRBPjTFt2s+q26+YAPNveA3A2CfRXSp0tCOqOT/T68DyQm
	 f8ZmgbZgKtjJqQTDk+R9bM6KQcsZBstj+miezn1SR5htE5rJSi1b+Gd8lSobGCjPlA
	 U5oqD7K1Ub5c62Pi6pK3ZjRLKrGaordSs9wEtAqnSNleYQ2sIwqnJ3YJLe3dhOeO8j
	 TPORopxgAsUwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Akhil R <akhilrajeev@nvidia.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/7] device property: Add fwnode_irq_get_byname
Date: Wed, 22 Jul 2026 06:30:22 -0400
Message-ID: <20260722103029.890864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071657-book-manhandle-a0e6@gregkh>
References: <2026071657-book-manhandle-a0e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akhil R <akhilrajeev@nvidia.com>

[ Upstream commit ca0acb511c21738b32386ce0f85c284b351d919e ]

Add fwnode_irq_get_byname() to get an interrupt by name from either
ACPI table or Device Tree, whichever is used for enumeration.

In the ACPI case, this allow us to use 'interrupt-names' in
_DSD which can be mapped to Interrupt() resource by index.
The implementation is similar to 'interrupt-names' in the
Device Tree.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 158efa411c57 ("i2c: core: fix adapter probe deferral loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c26ce7fd6832fc..2c0778089ae76f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1042,6 +1042,35 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
+/**
+ * fwnode_irq_get_byname - Get IRQ from a fwnode using its name
+ * @fwnode:	Pointer to the firmware node
+ * @name:	IRQ name
+ *
+ * Description:
+ * Find a match to the string @name in the 'interrupt-names' string array
+ * in _DSD for ACPI, or of_node for Device Tree. Then get the Linux IRQ
+ * number of the IRQ resource corresponding to the index of the matched
+ * string.
+ *
+ * Return:
+ * Linux IRQ number on success, or negative errno otherwise.
+ */
+int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
+{
+	int index;
+
+	if (!name)
+		return -EINVAL;
+
+	index = fwnode_property_match_string(fwnode, "interrupt-names",  name);
+	if (index < 0)
+		return index;
+
+	return fwnode_irq_get(fwnode, index);
+}
+EXPORT_SYMBOL(fwnode_irq_get_byname);
+
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 0604bb73e62827..98227dbac95383 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -120,6 +120,7 @@ struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
+int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
 unsigned int device_get_child_node_count(struct device *dev);
 
-- 
2.53.0

