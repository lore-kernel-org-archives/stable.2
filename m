Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9E1E2834
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567410; cv=none; b=XfjcDu3ks/thRLAjcrM33RrGiV2ksvlJMD63ohcUIOMee3yZdZew/It/Xp9mv7wU40vc/zzsxKHYZ8Dw42Er/BZ+I1oXbQwl/7yZuAq+67hf4DoxodytipurFjRAaZ25tBqk2Tvr2hnePkwZoTD22xhcsk7JnOPB39fwX5eDd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567410; c=relaxed/simple;
	bh=yVhhlviApH4m80lQ0NJTdL/SmSzr1OhmHuRIAYNtz9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5UiaqBJ6cu0gYEc5fkkEy3DjiGVZ+iLgoJLQVdrh5Wiw833rlSfWpgIJcdErMI/bb2twnMSo47fKR9qwugauJk2Zk61HkJFNZEIangPIFsmz2dILNsYWw5ta4oFXFMOlX57KDKIrrtd/4dpuSqaOPioOUX5EocuwVZ7LAnkg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jASVqqoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jASVqqoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308751F00A3D;
	Sat,  5 Sep 2026 00:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788567408;
	bh=3kzV56U/Pheikcfhn59DRP+KOuJ34w5J9dVqUSwrLXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jASVqqoUdLep2nG9VBWkCqiCzuT5738kaKT/Jkco6CRuYSw1bD18yDIrwNpujj6qa
	 0phbxjWVlDTzF3B/+i9KTIrJswoqPTumJ22Cz2hq80FXywF9DywlOU2QLqu4VDuz2s
	 rRbjG3DsCR+tFUrp/ky4m/9iSLZduQLk25wV+lDyiAb4E6FpCxb9PceluUw4QNsQiv
	 UjYeYLsA4gGpAIwZ+SWo3VhII1pArrziZtiVTQjQ4JBiPl9Ats5hn6pT8pNlpes3LU
	 9ecGqgGUoWKZKnqzJuRkFcBlzsfYWBykpzoCep3mZgO7ddpyf90r9dBnCCYvgxfzeU
	 EwgNzoMo6sm6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
Date: Fri,  4 Sep 2026 20:16:45 -0400
Message-ID: <20260905001646.1679840-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090347-net-vagrancy-5d59@gregkh>
References: <2026090347-net-vagrancy-5d59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ]

Useful where the fwnode_handle was obtained from a call such as
fwnode_find_reference() as it will safely do nothing if IS_ERR() is true
and will automatically release the reference on the variable leaving
scope.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Link: https://lore.kernel.org/r/20240217164249.921878-3-jic23@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 190069255582 ("device property: fix infinite loop in fwnode_for_each_child_node()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/property.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 98227dbac9538..b6135176cfdc5 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -11,6 +11,7 @@
 #define _LINUX_PROPERTY_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/fwnode.h>
 #include <linux/types.h>
 
@@ -119,6 +120,8 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
+DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))
+
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
-- 
2.53.0

