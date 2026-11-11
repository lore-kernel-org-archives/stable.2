Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366861;
	b=0Y7VlbCaIrJV+qdqLEPPPV2xeEfBf1kkpajhZEgNff3HeM3OCdrdXYxyPEzfV2pX+g+I
	 3tDNtRFtHzB9tTDdpAA3BPZQRUjAay9nU9sfCUtasc5H427OcAeR/AemNM2gZ1dF92rX4
	 Y22+9xWnSwpsckDiRjrUUVYbFKPvEmbpIOBxzfxamUNe1FgochNM56JqweVl2QMNmUBRm
	 z0g3dfB6pFyXBHGhIEy0o8kwIRdsoPZwSSSN4+PT0CFOFUZmEIUbZv71hOnKOratKPFsX
	 vGkPteUu+4CMTXAvRR+0Ja2PwknG7Nl5z7Rc5TUDlK9lLVUxCWyg+12+GiK/ykf7I0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366861;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4S8kp052NU2idIqwVbGtRKiQzjtW9dSCL4glWW6nukA=;
	b=gKvBXAIBwCmQifljJezIJbz0daAyHInDm24kSb3cN+/HtSkJhBQx4ohziXnMVpx6JD9L
	 3kFTFrNfOoJ7Ng1HFMDdu/ZQUWewzbdWYdD8bmcgWKVISH6p+QURLpsBn37ByLH1ACd2W
	 01znyOjnhFC7RWYia/sEG4sHVORL68EQrOkql0vNXbe8eV9SIY/c6zAXvu9hETjatLWaN
	 SoGzJ4l9s1GKk+X7YB6h3MpWyBVuYEuFsozxjHKSA89h2yZHCyfyfIzRuR4RxC3Pednd1
	 5Pk6JGAkhpx/qyCanT7CkZ0Rlqi1C5z5AgNOXi7I/dn0cTxSghRUS0Y28IbzhnpjGWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crBKvHM3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58D606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crBKvHM3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0731F00A00;
	Wed, 11 Nov 2026 03:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366861;
	bh=4S8kp052NU2idIqwVbGtRKiQzjtW9dSCL4glWW6nukA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=crBKvHM3JdlIpaG9qKSmX/MFbS5/yMz0/G+xsKFC8sAEMHVgkT7xbm/ffuferkAq8
	 yK8NDnmg74PAFfqfwIO4kLGGavo+itVCLQ65rVrQWtQY+Bh/MplYnpgWH7GMt2617v
	 Jh23XSwH7HIWY/EmBMBTvixva+pacCZWLkmEfX4ilwIwAZl9v+QlJUGsxTJNoANYZg
	 0ClsHgW3J54xXU1J3pEdX0A81mYXYZnEaaWePUtFCNEdAldtdCrJ47Dm/1K0E1BbiS
	 fsOH8gJla+iH/ZGNnbLvgnH5EJTVD/VkXbs41OfZOfAM9J/pLZ4tR9q8tAQhmT7o5s
	 m+ZSG4XVjRGYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make_ruc2021@163.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] i2c: acpi: Fix adapter reference leak in i2c_acpi_new_device_by_fwnode()
Date: Tue, 10 Nov 2026 22:14:18 -0500
Message-ID: <20261111031403.856886-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111031403.856886-1-sashal@kernel.org>
References: <20261107062755-failed-5.10-a65917d0a22f@kernel.org>
 <20261111031403.856886-1-sashal@kernel.org>
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
index 6f8532ccea850..b9b4b7a98a39d 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -496,6 +496,7 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
 {
 	struct i2c_acpi_lookup lookup;
 	struct i2c_adapter *adapter;
+	struct i2c_client *client;
 	struct acpi_device *adev;
 	LIST_HEAD(resource_list);
 	int ret;
@@ -523,7 +524,10 @@ struct i2c_client *i2c_acpi_new_device_by_fwnode(struct fwnode_handle *fwnode,
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

