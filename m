Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFD2D9EE7;
	Mon, 12 Oct 2026 01:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791768890; cv=none; b=sc+WluCBq4I36fKRpD2BxZ277HItt9ZFIWaycXHkUKPQpiAvjJGbHwFP650EZZcaiDt/qjidWJA7ReKqJO6XFVnTMc1Xxck6n3JhhA26lm0S2E+500Lb0qrHG0agaKE3pGEJF+JrJ3NFqlqrNowWtxE7Qtapr0ll3mlb3n53MmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791768890; c=relaxed/simple;
	bh=wNA424F7S0gOOptV66coIV8Jv8ytswfDkInTaJkdOsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7VA1RucEQ8SjmXFVaAbgldDp/KhKQY5W9tgm7kUCJDZBD3FoK867N5ETlhX7HY4USFbHoVdscpHRIFcjO0XYSNanFzPdA0YhxEkywn98VcP6MiFltG+ZebUZf/E3wRjgjB/fEbFeyNozFSTj/giHRkh5LXYpMNk6REwgsb1wYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kK8mknIn; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kK8mknIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xP
	RGA++adt8KvzFvkqr/qweA1l/L7d43TDcIHAz7WLY=; b=kK8mknIn5a6PfUCxsP
	nb1Hs3okwbnCWjo3aPRtuoUOm7KGBG0CZjWpT3jtu2ho82MoI6RZ+JfzcADTDJFk
	R6d0nPAElpLK2wyZZv1u1rgcCl0pLnjb2ml+ktouMGrItoMlTvL6xLS3CiBUVSRz
	Y66xNLJqeu03QaRu7H+JkRZ4M=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3H80eOcxqGT5OEA--.60145S4;
	Mon, 12 Oct 2026 09:34:31 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: westeri@kernel.org,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()
Date: Mon, 12 Oct 2026 09:34:21 +0800
Message-ID: <20261012013421.3597430-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H80eOcxqGT5OEA--.60145S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4kXw17XFy7JF45Kw1kAFb_yoW5Jr1xpr
	W5KFyDAryqgF129w4UXFy3Aa4fur4Iy39akF4UJ3y2kFsYgryrtFyayryjga43ArZaqa1D
	Ar42qaykArWqyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_uc_rUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9QclMGrMOSdZIAAA3m

i2c_acpi_new_device_by_fwnode() obtains an i2c_adapter through
i2c_acpi_find_adapter_by_handle(). That helper uses bus_find_device()
internally, so it returns the adapter with a reference held:

        adapter = i2c_verify_adapter(dev);
        if (!adapter)
                put_device(dev);

        return adapter;

The reference is only put on the failure path inside that helper. The
caller owns it otherwise. i2c_acpi_new_device_by_fwnode() never drops
it, neither on the -EPROBE_DEFER path nor after
i2c_new_client_device(), so every call leaks one reference on the
adapter and the adapter can never be released.

i2c_new_client_device() does not consume that reference. It registers
the new client with the adapter as its parent, and device_add() takes
its own reference on the parent, which device_del() releases when the
client goes away.  The reference obtained by the lookup is a separate
one and has to be dropped here.

i2c_acpi_notify() in the same file already does exactly this. It takes
the adapter from the same helper, registers the client through
i2c_acpi_register_device(), which calls i2c_new_client_device(), and
then puts the reference.

i2c_new_client_device() gives the client its own reference on the
adapter, so ours can be dropped unconditionally.

Found by code review.

Fixes: 605f8fc22442 ("i2c: core: Add new i2c_acpi_new_device helper function")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/i2c/i2c-core-acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 8f3bdd50186e..37d1309e93b5 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -547,6 +547,7 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
 {
 	struct i2c_acpi_lookup lookup;
 	struct i2c_adapter *adapter;
+	struct i2c_client *client;
 	struct acpi_device *adev;
 	LIST_HEAD(resource_list);
 	int ret;
@@ -574,7 +575,10 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
 	if (!adapter)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return i2c_new_client_device(adapter, info);
+	client = i2c_new_client_device(adapter, info);
+	put_device(&adapter->dev);
+
+	return client;
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_new_device_by_fwnode);
 
-- 
2.43.0

