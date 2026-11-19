Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092266;
	b=37YCIoZ4J26wYdZ6sUJlVLPkgVr+NZUdkAMxvDamyTmEOyDauBCWWKkWCDnHFFdZWBAB
	 bXtWfUgQaGDRVnUbjJe/L4vFEVNvr26QMQxagzSRwk5f2vwrLJ0mkXyYxJPv+31uE0Tao
	 LjtNBAHe0wnGA2lc8h8uMltkXmTBtjAmwjOZPt/SPEHXRqnkdFfeDg4MeggPlnwOUCGlT
	 I+3tO4nnAq15/gAQU0khilzYs3pY9cOQKeZzO7c0+Nre/ru42+8DImPQOyNqZUe9Y8grf
	 tkUFMRnJIMMNmwFR6E/hUetKcVI2wZwKDVDnJpBTdjTu07m/6HVCdp74w+3GCQKUpRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092266;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=u6QoNIwZiYEAmBg7S14Hn3OE8+2gWzQ54RqC/uNe17k=;
	b=HmIBtwnMYGo8H1G+H6mEWXuMUIoTEAHzqlw48kgl3Hys07yViO3lctjGm7ttKwL+ImtK
	 hx4lv7NVAObspsYY5qXxNsPF8mlYutcQgsji4GQmozmoAq5xIsCSEhho+ueyOr+GrzzRk
	 0wGgmku+DQGaaACtQK1rEaZgt/c5FbfMvm1cB44zZWDANFADZQ9shB0taIa5//Ne/XoHc
	 gtIPR9zSHYujYtlw2i4UlqcAcpMpfPe1EuhLxmFW3lLl3iARrAEOGPyd1auZCjQ4yLyvP
	 /5Svpcu9fLcmiqVTYM8uGtkn4cQbkyq+pIgElq8KUXdcn17Q3XZGoEUsab0hfFJhzBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JFqULr0s;
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C060A3810;
	Thu, 19 Nov 2026 12:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D92C060A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JFqULr0s
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=u6QoNIwZiYEAmBg7S14Hn3OE8+2gWzQ54RqC/uNe17k=;
	b=JFqULr0sqPApEAUTNZ34uyqF7bOaL6M6TNEs3M1KfgTNkfyzonfio74WC7FHlo8EuYu9pVfST
	9mdrBrI3+u4SfXuas+wDDU5m7KDVNYz4KrA5on5PBVE2d6yKIKOcvoT4kMMmBrr34M71sEeasIA
	fbXtusjC6v3U3qS9Y/FdcPs=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jVdSZ384ZzRhQS;
	Thu, 19 Nov 2026 20:43:58 +0800 (CST)
Received: from whupemo500017.china.huawei.com (unknown [7.152.184.243])
	by mail.maildlp.com (Postfix) with ESMTPS id A675840686;
	Thu, 19 Nov 2026 20:44:13 +0800 (CST)
Received: from huawei.com (10.67.174.49) by whupemo500017.china.huawei.com
 (7.152.184.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 19 Nov
 2026 20:44:12 +0800
From: Ye Weihua <yeweihua4@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, Kai
 Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <sound-open-firmware@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<stable@vger.kernel.org>, Ye Weihua <yeweihua4@huawei.com>
Subject: [PATCH -next 1/2] ASoC: SOF: ipc4-control: Fix out-of-bounds backup restore in bytes ext put
Date: Thu, 19 Nov 2026 12:14:45 +0000
Message-ID: <20261119121446.124833-1-yeweihua4@huawei.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemo500017.china.huawei.com (7.152.184.243)

sof_ipc4_bytes_ext_put() backs up the current control data with
kmemdup(..., scontrol->size) and updates scontrol->size to the size of
the new payload before sending it to the firmware. If the firmware
rejects the new payload, sof_ipc4_set_get_kcontrol_data() restores the
backup with memcpy(..., scontrol->size), reading past the end of the
backup buffer when the new payload is larger than the backed up one.

The mismatch is not limited to the current call: the backup is kept when
the update succeeds and is not refreshed by later updates, so
scontrol->size can grow beyond the size of the backup and a subsequent
failing update will trigger the same out-of-bounds read.

Store the size of the backup when it is created and use it to restore the
data and to update scontrol->size. Also only update scontrol->size after
the firmware update succeeded, as sof_ipc4_bytes_put() already does.

Restoring the local data is not enough to replay the last known good
configuration: the IPC message still carries the size of the rejected
payload. Reset the message size when its payload points into the restored
buffer, so the firmware receives the restored data with its own size.

Fixes: ebcfdbe4add9 ("ASoC: SOF: ipc4-control: Keep the payload size up to date")
Cc: stable@vger.kernel.org
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 sound/soc/sof/ipc4-control.c | 26 +++++++++++++++++++++-----
 sound/soc/sof/sof-audio.h    |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index e29c8d89284a..f8b4842f3936 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -56,20 +56,31 @@ static int sof_ipc4_set_get_kcontrol_data(struct snd_sof_control *scontrol,
 	if (!set)
 		goto unlock;
 
 	/* It is a set-data operation, and we have a valid backup that we can restore */
 	if (ret < 0) {
+		struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
+
 		if (!scontrol->old_ipc_control_data)
 			goto unlock;
 		/*
 		 * Current ipc_control_data is not valid, we use the last known good
 		 * configuration
 		 */
 		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
-		       scontrol->size);
+		       scontrol->old_ipc_control_data_size);
+		scontrol->size = scontrol->old_ipc_control_data_size;
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
+		scontrol->old_ipc_control_data_size = 0;
+		/*
+		 * If the message payload points into the restored buffer, its size
+		 * must be restored as well, otherwise the last known good
+		 * configuration would be sent with the size of the rejected data.
+		 */
+		if (msg->data_ptr == cdata->data->data)
+			msg->data_size = cdata->data->size;
 		/* Send the last known good configuration to firmware */
 		ret = iops->set_get_data(sdev, msg, msg->data_size, set);
 		if (ret < 0)
 			goto unlock;
 	}
@@ -628,10 +639,11 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 	struct snd_soc_component *scomp = scontrol->scomp;
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct sof_abi_hdr *data = cdata->data;
 	struct sof_abi_hdr abi_hdr;
 	struct snd_ctl_tlv header;
+	int ret;
 
 	/*
 	 * The beginning of bytes data contains a header from where
 	 * the length (as bytes) is needed to know the correct copy
 	 * length of data from tlvd->tlv.
@@ -684,25 +696,29 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 		/* Create a backup of the current, valid bytes control */
 		scontrol->old_ipc_control_data = kmemdup(scontrol->ipc_control_data,
 							 scontrol->size, GFP_KERNEL);
 		if (!scontrol->old_ipc_control_data)
 			return -ENOMEM;
+		scontrol->old_ipc_control_data_size = scontrol->size;
 	}
 
 	/* Copy the whole binary data which includes the ABI header and the payload */
 	if (copy_from_user(data, tlvd->tlv, header.length)) {
 		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
-		       scontrol->size);
+		       scontrol->old_ipc_control_data_size);
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
+		scontrol->old_ipc_control_data_size = 0;
 		return -EFAULT;
 	}
 
-	/* Update the cdata size */
-	scontrol->size = sizeof(*cdata) + header.length;
+	ret = sof_ipc4_set_get_bytes_data(sdev, scontrol, true, true);
+	if (!ret)
+		/* Update the cdata size */
+		scontrol->size = sizeof(*cdata) + header.length;
 
-	return sof_ipc4_set_get_bytes_data(sdev, scontrol, true, true);
+	return ret;
 }
 
 static int _sof_ipc4_bytes_ext_get(struct snd_sof_control *scontrol,
 				   const unsigned int __user *binary_data,
 				   unsigned int size, bool from_dsp)
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 672879371d14..c563e7b93f5a 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -391,10 +391,11 @@ struct snd_sof_control {
 	void *priv; /* private data copied from topology */
 	size_t priv_size; /* size of private data */
 	size_t max_size;
 	void *ipc_control_data;
 	void *old_ipc_control_data;
+	size_t old_ipc_control_data_size;
 	int max; /* applicable to volume controls */
 	u32 size;	/* cdata size */
 	u32 *volume_table; /* volume table computed from tlv data*/
 
 	struct list_head list;	/* list in sdev control list */
-- 
2.34.1

