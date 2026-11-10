Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333692;
	b=S2uKaEhV+5Sqg3uYE2tGrEhVKf5WcNUBVZRKKjf+9OnPV3447FfZsZ5mmpbUcyN74LHP
	 izIHHzXRNdFcPKRaNmrh3UFu/V4AgxYi1j+VmN4oWx/vBwChQeu91JVaS1uaiIw9fFHSj
	 1ShCmJfjyMRQC0/cSydZxzcQdjpI5lZjJ3DCSHeZFdIurgWItpythGSHwYAl8LAWfJbdV
	 AD8BohB1IEKUSbNYTFp/DFJEK2C00SMpTHdi5nndlqx/lRFJLjbiY5XnYrSwGPWkSk6Fy
	 dszaz9gJu66pIidCtLFxsOcpq5uX+CLTP9bCcLgHzzB/b/oxp89g2pJnK1Bo3IU7HFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333692;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GvOGipL0xlRe2ETJg1SWxK2JFZGt1hnWNb9/VuexkBs=;
	b=jjGyBnDGOs1+D6TA7uNyYuriV2HkHqO0xILNQXzn2y4NiY3buA6J3vekewFzPGTsgN96
	 MuLHPZN9I4v+U+LW+2kOz+8WcmPFLyLwoNr89v4Iv62IIHm1qs1nOhdkHP0chBPa7jt19
	 dduMR/sDo0jCeHre97v8KL19dcecugVzX66E7DnMaeFakVsBaTVx/1zc07Z8OHo2vlPvH
	 hFHfLPeJ0cxZ7Y3jlAZFsLd1EzKqlQ5+Kkv3B4ddT4s374uNFqZ5z8v4rsHy8fiMJNgFy
	 HX6H4lvnJYY+4XTjziowszLFRva5S7j+TmjJ+aEimGaZM0tCrROa4DXfvNuLbTEnVEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpI4xm81;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB2606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpI4xm81
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC761F008A5;
	Tue, 10 Nov 2026 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333692;
	bh=GvOGipL0xlRe2ETJg1SWxK2JFZGt1hnWNb9/VuexkBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EpI4xm81IqzctIDz+0aa7ctiCvJHYEyRVz9pYdJl5JlnMDV8D1bKYpkD7MVnENloW
	 NNS9373aesk2ESf9qRaYFYqz03mkRSTLbZv058IjO/Se2/fTQC4WRqRcEnVAJagMIe
	 ezoe2OwSfb6oQ4yP3Oqt7+lYwbXwjYsINjraBsob/xFMWscGlwIwTABiLi1HVynbZo
	 M/E8tDPzkp52M5qxeotRKI6Nhri1FH59y8oZ1/ZeIrc7svQx25S3Z44x0O/Uo/Wb/R
	 9tQ1Y9nIZ5+k450re4jEA4+bVi3a8h/3eNCmeIPkkbHc6x3baOjdKZIINpNHel5ouo
	 jrTxAEj+/m0ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Belanger <martin.nvme.dev@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nvme: make the DH-HMAC-CHAP secret attributes readable by root only
Date: Tue, 10 Nov 2026 13:01:30 -0500
Message-ID: <20261110180056.3075618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053513-failed-6.6-bbca7c312ab2@kernel.org>
References: <20261107053513-failed-6.6-bbca7c312ab2@kernel.org>
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

From: Martin Belanger <martin.nvme.dev@gmail.com>

[ Upstream commit bbca7c312ab25efd0024eb87545c51a76ab2ea39 ]

The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
0644. Their show functions return the secret, so any local user can
read the DH-HMAC-CHAP secrets of a connected controller.

Define them with DEVICE_ATTR_ADMIN_RW(), which sets mode 0600. The
macro takes the show and store functions from the attribute name, so
rename them. Writing the attributes was already limited to root and is
not changed.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.nvme.dev@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: Adjusted patch context to preserve CONFIG_NVME_AUTH instead of CONFIG_NVME_HOST_AUTH. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/sysfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 212e1b05d2984..7bbfce086fb72 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -410,7 +410,7 @@ static ssize_t dctype_show(struct device *dev,
 static DEVICE_ATTR_RO(dctype);
 
 #ifdef CONFIG_NVME_AUTH
-static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
+static ssize_t dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -421,7 +421,7 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
+static ssize_t dhchap_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -465,10 +465,9 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
+static DEVICE_ATTR_ADMIN_RW(dhchap_secret);
 
-static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
+static ssize_t dhchap_ctrl_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -479,7 +478,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
+static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -523,8 +522,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
-- 
2.53.0

