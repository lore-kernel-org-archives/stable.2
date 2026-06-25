Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8D30C15C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396533; cv=none; b=eQFifV6xGxDIftShK5dd6PTno5TT3e8mYwFG2XVGZA6901arFGzlBnSwgaiNgjTYCKDWbDTlp967xRHJl4PuVR/qWL5pt7IBdSNWdoeo72OGAhzYNIm18nNHd20Ysz4n1Fo2oaW4oz0Ltg7vASYEw9tbzG5BLl9IKtEKDnbz7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396533; c=relaxed/simple;
	bh=AaexebTLYu2MoTJ4sRbBRZ3BY3fqZe04TDm4hz0rIjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqeF4S2N/bMQ9Q9EjrDeNbiD3jY68cRCgSPgY2eiDFdahj2LfTXCueEqE+z2VHSnU4H3e613f/RvQlBt9woOmvpd6mLI8bNmXQHZBpxzNDLoHaL5cwJQ9zkiM7ZykXCut5uj4c8hWWw0qw8MqAXlFT8ROBg9sZoeYKYXVzP4pv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHz6OcRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHz6OcRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F8A1F00A3A;
	Thu, 25 Jun 2026 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396531;
	bh=t1j7apxSbXRCwCXQDc73WsyqWUhY+s7+RvRBydPqPc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VHz6OcRs2jpzeMwpELe57istWXvMEsXJFnOMhOf5tJ1m5lDP8kSfVuuxY/xvXDiUn
	 g4JFZAWqdjZJPQqNF9kDPT3f6r1XbD0//U43CIccVRH3US/8yecgm2o3CgI6pm39w3
	 S+WX147CbUr4TnZESAMbqegR0e+Cnpu9DeKX/ZnCknGIFtiVYV6u9gIIDJpvKVwE97
	 B+kgfxudke/0m0dHxOvFTBE5/Um+lmW+zuN3X787VtJb5cRLgh4M6CTa7xiG2R4iu3
	 n8z6q9PO6kzzv287Q8HPycvaTcZRuei4zNvQD6p+fZym1HPT9uoyqNyQBfhk8rwV34
	 oBIgTtbAvPKOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] crypto: qat - Return pointer directly in adf_ctl_alloc_resources
Date: Thu, 25 Jun 2026 10:08:45 -0400
Message-ID: <20260625140846.2431963-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625140846.2431963-1-sashal@kernel.org>
References: <2026062532-unpaved-jujitsu-26c1@gregkh>
 <20260625140846.2431963-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 5ce9891ea928208a915411ce8227f8c3e37e5ad9 ]

Returning values through arguments is confusing and that has
upset the compiler with the recent change to memdup_user:

../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c: In function ‘adf_ctl_ioctl’:
../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c:308:26: warning: ‘ctl_data’ may be used uninitialized [-Wmaybe-uninitialized]
  308 |                  ctl_data->device_id);
      |                          ^~
../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c:294:39: note: ‘ctl_data’ was declared here
  294 |         struct adf_user_cfg_ctl_data *ctl_data;
      |                                       ^~~~~~~~
In function ‘adf_ctl_ioctl_dev_stop’,
    inlined from ‘adf_ctl_ioctl’ at ../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c:386:9:
../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c:273:48: warning: ‘ctl_data’ may be used uninitialized [-Wmaybe-uninitialized]
  273 |         ret = adf_ctl_is_device_in_use(ctl_data->device_id);
      |                                        ~~~~~~~~^~~~~~~~~~~
../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c: In function ‘adf_ctl_ioctl’:
../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c:261:39: note: ‘ctl_data’ was declared here
  261 |         struct adf_user_cfg_ctl_data *ctl_data;
      |                                       ^~~~~~~~
In function ‘adf_ctl_ioctl_dev_config’,
    inlined from ‘adf_ctl_ioctl’ at ../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c:382:9:
../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c:192:54: warning: ‘ctl_data’ may be used uninitialized [-Wmaybe-uninitialized]
  192 |         accel_dev = adf_devmgr_get_dev_by_id(ctl_data->device_id);
      |                                              ~~~~~~~~^~~~~~~~~~~
../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c: In function ‘adf_ctl_ioctl’:
../drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c:185:39: note: ‘ctl_data’ was declared here
  185 |         struct adf_user_cfg_ctl_data *ctl_data;
      |                                       ^~~~~~~~

Fix this by returning the pointer directly.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: d237230728c5 ("crypto: qat - remove unused character device and IOCTLs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/intel/qat/qat_common/adf_ctl_drv.c | 31 ++++++++-----------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
index b029420f9a310c..36bbf808db3ed9 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
@@ -89,19 +89,14 @@ static int adf_chr_drv_create(void)
 	return -EFAULT;
 }
 
-static int adf_ctl_alloc_resources(struct adf_user_cfg_ctl_data **ctl_data,
-				   unsigned long arg)
+static struct adf_user_cfg_ctl_data *adf_ctl_alloc_resources(unsigned long arg)
 {
 	struct adf_user_cfg_ctl_data *cfg_data;
 
 	cfg_data = memdup_user((void __user *)arg, sizeof(*cfg_data));
-	if (IS_ERR(cfg_data)) {
+	if (IS_ERR(cfg_data))
 		pr_err("QAT: failed to copy from user cfg_data.\n");
-		return PTR_ERR(cfg_data);
-	}
-
-	*ctl_data = cfg_data;
-	return 0;
+	return cfg_data;
 }
 
 static int adf_add_key_value_data(struct adf_accel_dev *accel_dev,
@@ -181,13 +176,13 @@ static int adf_copy_key_value_data(struct adf_accel_dev *accel_dev,
 static int adf_ctl_ioctl_dev_config(struct file *fp, unsigned int cmd,
 				    unsigned long arg)
 {
-	int ret;
 	struct adf_user_cfg_ctl_data *ctl_data;
 	struct adf_accel_dev *accel_dev;
+	int ret = 0;
 
-	ret = adf_ctl_alloc_resources(&ctl_data, arg);
-	if (ret)
-		return ret;
+	ctl_data = adf_ctl_alloc_resources(arg);
+	if (IS_ERR(ctl_data))
+		return PTR_ERR(ctl_data);
 
 	accel_dev = adf_devmgr_get_dev_by_id(ctl_data->device_id);
 	if (!accel_dev) {
@@ -260,9 +255,9 @@ static int adf_ctl_ioctl_dev_stop(struct file *fp, unsigned int cmd,
 	int ret;
 	struct adf_user_cfg_ctl_data *ctl_data;
 
-	ret = adf_ctl_alloc_resources(&ctl_data, arg);
-	if (ret)
-		return ret;
+	ctl_data = adf_ctl_alloc_resources(arg);
+	if (IS_ERR(ctl_data))
+		return PTR_ERR(ctl_data);
 
 	if (adf_devmgr_verify_id(ctl_data->device_id)) {
 		pr_err("QAT: Device %d not found\n", ctl_data->device_id);
@@ -294,9 +289,9 @@ static int adf_ctl_ioctl_dev_start(struct file *fp, unsigned int cmd,
 	struct adf_user_cfg_ctl_data *ctl_data;
 	struct adf_accel_dev *accel_dev;
 
-	ret = adf_ctl_alloc_resources(&ctl_data, arg);
-	if (ret)
-		return ret;
+	ctl_data = adf_ctl_alloc_resources(arg);
+	if (IS_ERR(ctl_data))
+		return PTR_ERR(ctl_data);
 
 	ret = -ENODEV;
 	accel_dev = adf_devmgr_get_dev_by_id(ctl_data->device_id);
-- 
2.53.0

