Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC173C2D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566713; cv=none; b=BVgc3ftCYAjHdoTnnJZevlMzeafXBrDW+k+VKIZBbU3WA+uWJ86TYyxSplgJOHf3Mc3niKufEv+5kpdO4dFMP+9zN6pNzo54vAdrawi8FH7KK2tk4jRUJp1MIMt9C3Su6kWKQU1gQOPnDUDwHbp36FFG33qn09KQnGxkcizD2qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566713; c=relaxed/simple;
	bh=yNaEkfaRMFwegfA8FZXpNkirxM7a7J/QMVy/e2bado4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhb0+LL05RDUU+4FWQV5z9DF+YNYtCxU4Dkw31io1hMaRj/3QM8zqCsqFi/bYy9koQ5KtrAEueoEUCiw2illVBZM8GF1AKp7YwE29f10nvLMg4dEaPF6+nnsJHDmAuo5UBN1etUOS3NdGOLqID/RSoZZwdoR/WGwYRUlBLKuTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk4xXo3a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk4xXo3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700041F00A3D;
	Sat,  5 Sep 2026 00:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566712;
	bh=hy/1L0AjfJ/BuPibeqTJ/xpsy44JMHH9ZOSWYw8uk5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dk4xXo3aHmxkbic802tfN/e52Ba/H2xjy4DzMs2lUUVksq8jOzZ1J8JPXqQzDBmJG
	 un0CwoaRhtYOkPlsBz6xtZID15x53fRqWSWVZrTyIrszDtEGTinK/U5H7fDbv6V1by
	 YG4N/PMKppLCv56+ZSXCr6hYs32ZW1UDvbgyy42+8XabGUx10uWaRIyujtGTASZdrX
	 sj52zv3cvukhb+CD2Jb7q/WobkKVTqqYrXrb7/YkubIe2nzq8RJZt/dg/Aw6rucT3u
	 axBNckrkxZk5blgjaBhgdsFTh66R9KJf5o4h968h5V9u0FG6kRwKShaOZofKZxAYSN
	 oZBqIE+GtUlQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
Date: Fri,  4 Sep 2026 20:05:08 -0400
Message-ID: <20260905000510.1659297-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090348-triceps-paramount-f040@gregkh>
References: <2026090348-triceps-paramount-f040@gregkh>
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
index 840f0545d4f9d..180d4a027ab38 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -11,6 +11,7 @@
 #define _LINUX_PROPERTY_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/fwnode.h>
 #include <linux/types.h>
 
@@ -124,6 +125,8 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
+DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))
+
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
 
-- 
2.53.0

