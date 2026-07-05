Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0835378D71
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259286; cv=none; b=tUoRKSzePpD05wvoVp9eD/HEt3YbylcxtBWyTPKWzbwQl4lx1iIHI3r7XpzPdGUHzY1wiF2PolbmbPIety+Uo36E78rzoqlpoZwc4ov7Xpui/XdxHAmA8Effd5ckHt1TV5Byj9iV25DRoAESC7KPqy8bYT/2ZjfikDWwTnUuAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259286; c=relaxed/simple;
	bh=5ai+DfVrbqAqxpz0gQGzvv8H6p1jIxC3KkOcmrIlzfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+m3xKrjwqkiIThUWxCf0geQ9i0ypSxxHqilwC818qd8ofzssX8kxkQYPjKHBWRvDzp3CuLXI0ukG7XVbO9z9RKadTTk5SEVMg+TOVXgzE60W/surz8t5PTmRZ9Jjqdiw+Q1f1F8y7IEt5kpnqH+CPUJU11pgXT8mkFJygWSqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix1v/qlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix1v/qlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5306B1F00A3E;
	Sun,  5 Jul 2026 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783259284;
	bh=p4UweEvifxUG+Q60x/pR6AwBOGm2O5R5/le0y1mNd4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ix1v/qlSdAWwtH8v5rFvoLh/h007E96NgnKQanoNjPf+mHhpKkOYzBnrwXxmRYZZ4
	 yV07QHi46vgCT1tOYbm1ChT8JzU3jyrGvYlWRDW1XguDuQBunSrD8bxM4FkSN90TmJ
	 5CGK32SLhV6x3tlErLUnNtgup8JSF/uac5prvd4Su4vvdZ5ftXcXWd01kMkpAjyT5T
	 fvUjs1hL6WDJxrXLLIEbC/iFiseZFGFV+S2wtixFcnKIQIwck29JqMaz3O9hy6sWUF
	 o5Mn75uWZzGFzo5eP20F5yW3xsHX48yGfdc5gRjQvPFYoFGAnPOCFGpURx88NwZ3c4
	 m8vuM6BJ7UxFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] i2c: core: fix adapter registration race
Date: Sun,  5 Jul 2026 09:47:59 -0400
Message-ID: <20260705134759.1722831-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705134759.1722831-1-sashal@kernel.org>
References: <2026070232-jet-sheep-e8a6@gregkh>
 <20260705134759.1722831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ba14d7cf2fe7284610a29854bdff22b2537d3ce6 ]

Adapters can be looked up based on their id using i2c_get_adapter()
which takes a reference to the embedded struct device.

Make sure that the adapter (including its struct device) has been
initialised before adding it to the IDR to avoid accessing uninitialised
data which could, for example, lead to NULL-pointer dereferences or
use-after-free.

Note that the i2c-dev chardev, which is registered from a bus notifier,
currently uses i2c_get_adapter() so the adapter needs to be added to the
IDR before registration.

Fixes: 6e13e6418418 ("i2c: Add i2c_add_numbered_adapter()")
Cc: stable@vger.kernel.org	# 2.6.22
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 2c54799670182f..b215f4a6a6ee59 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1561,6 +1561,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
 
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, adap, adap->nr);
+	mutex_unlock(&core_lock);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
@@ -1634,7 +1638,7 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
+	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -1670,7 +1674,7 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
+	id = idr_alloc(&i2c_adapter_idr, NULL,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
-- 
2.53.0

