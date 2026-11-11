Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366300;
	b=4ypUvIKLcmQgw1vVNn3FAkr9qRXlyOt5mvQSW8ZNn1zujXJEeeetVknuYzcLyogkvFp5
	 +K29cm4dswefPYRcx4hZ0n0fqOOxN/qGDEgMt1juokLvtuchOX/yefquxcXQ1d0ZpUJ8R
	 5BURTxvJncQggdToAy4YVYGE+vrjQyBOIpHMj+ydXgEx5CuZH6zPVMz4R4wAMr2KSZBGr
	 EVtsrQc1n2le3alqqWXJ6SiiAMDyG5tF2/C7g/uupHcjwhDl93EeyNl7iPaE/Ma8uWpRM
	 BWbIg97ACKiHgxSBh3KSZL9o0Pmaru4Nxbr1dQnsX+OtFE+6792T5EFA1yR6Wy65cOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366300;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hvMwGCTiycv3b2xZIz4hnlauA99zcBAxvPm05s+6X2M=;
	b=n3DvdKlCbeTOnlUsQ/98ku8oFAu9VYYb3aMF/sRMWeFoY1AvEF9Dbi7E1tbzwP7+WdFZ
	 1GacN6jIHKsx5S+lhCP1yE2FoVHw4EHAnjwK3lxk571dbWyJVNrdojURS0XmqSdawP6/1
	 TVzzZ9glKVzxOnePuabq5SdTxlpsOD3esY1tKo30JHehvcd8toPLVjUzCvcVEA7+WH0/P
	 lFXnYO8O/R936P3jsRTyOwkG7viBXODdipDAHzXRSkUsfkvi6bY6D/cOFusoozbdhJ+i5
	 7yOzWyQ52otVKNcEmnFYVu7pT7HJZliNxkBF7KcN0XsxLAW17LX/L8Xn83Vu6Lf8lUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ek/p51N8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ek/p51N8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D187E1F00A00;
	Wed, 11 Nov 2026 03:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366300;
	bh=hvMwGCTiycv3b2xZIz4hnlauA99zcBAxvPm05s+6X2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ek/p51N8hP9O4Ux/7JPBkrk2ZufXAU1gM7S354bCvn0WuJBotIwTIjakLc4S1zXZn
	 gScAOl+gj+SO2gwv8msd6J8s3EUs6JzRkkBnoiPK5AW2W/Jz/xKWl13GZ+qc8pnGmj
	 GW/qDhyBjk2+QPs5W5XRaFmwRDBTprtN7FOthPP2DbDkZ4qWNuLT2DP36Z56WB1Luc
	 xXEGdFNNqibMZGOWtWj+A9TzDAYKWcUJ3LMpG1NFZiI/iRLxahZdsdklQqKun6SEOM
	 2l/+8rXdNR6f9jzKuxxphq1yiHB4d9irZFS8tYiTSo3Na8RYvUedqNDQyEAzWqlD/u
	 FMe4gOTyKaZEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make_ruc2021@163.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()
Date: Tue, 10 Nov 2026 22:04:57 -0500
Message-ID: <20261111030452.828799-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111030452.828799-1-sashal@kernel.org>
References: <20261107061046-failed-5.15-a65917d0a22f@kernel.org>
 <20261111030452.828799-1-sashal@kernel.org>
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

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit a65917d0a22f9b10694853b725f9cd399fc3ef4d ]

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
Signed-off-by: Ma Ke <make_ruc2021@163.com>
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20261012013421.3597430-1-make_ruc2021@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 1ee80ada212c3..9081ee60bd702 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -524,6 +524,7 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
 {
 	struct i2c_acpi_lookup lookup;
 	struct i2c_adapter *adapter;
+	struct i2c_client *client;
 	struct acpi_device *adev;
 	LIST_HEAD(resource_list);
 	int ret;
@@ -551,7 +552,10 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
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
2.53.0

