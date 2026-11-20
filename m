Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159819;
	b=rEZ6QGiOH/h5iz0u86eR7gQdS7tJfXgisIrCZpQoh/Z/AE0IRvBn+dfFKzI+tkdVDQEC
	 OLINCWVIC2MR7WNw+Tm3iMerVHBDCJ2qXPFCT5UxtI/eH0xUUPiPIMiUlpHIkligabD0l
	 Jqjswo2CqbO4woxcoOGz7Nz68NprmuKYbpdnW/CsRjeTTkrxuUWJ3GQc0NZRNWPRBVwiq
	 oqBIJOmlcWgjuZFnjD73pYoSy5+rB32HB4dD5jllEyYdpFjhWPYNTdDqZykH6bc3hAX9J
	 dn1qUZxd8khLxpvbpHN9bYqEVioSRNyPbBjbLUqa0rslnZS77iX8sXAaJ+UtuXY8Kng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159819;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=sf/md8bvtm448mpFbyId9jbWIjg9Hk3iICDBHBuUOiQ=;
	b=4H5Y4DLHiXhMRVVtp4TTRz35PpIHFPK9psFXo3H3AfGqaeRtqJs03eBydyl5GULeSQsI
	 5h/DXhg2wE8VLAEEJ8bYodFPLW1fhtEpoVEhTp0k2M9e47oOLTgDOKswv5p72n9zZZPWf
	 +zSBB4s23YZfFfBDqFr2zQd5cgXXqty5o7BuikMVCMYTJwveYw88DcsPSKEGZ8sD9gIj0
	 n+ktz1l2d0oqSw8FjwBYjNzMhb0NnxduFQTxqUoKT1jRxkE6jGP2NdHW3ObSFxdY4whbM
	 5R+YmCN1RglBFR4VT7iQJ01QDOmN9glr2P/KxFBkX2PiWEVpJdAQ22Pxv3w1WcfZ3bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PYxAxU7z;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE8606A32A;
	Fri, 20 Nov 2026 07:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8EE8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PYxAxU7z
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sf/md8bvtm448mpFbyId9jbWIjg9Hk3iICDBHBuUOiQ=;
	b=PYxAxU7zA2Hdjh1LcCoTIgfpifY4IpdI+gOCW3MUG1QTYvjdBJCOV/N2/yAMPeazXrHKmMc7u
	BpgdLj9LM+tUFVPI0JW3lnqY4dkkFOIQBHcWL5nldVQpEWos4eRsozHhpW2IcADlB7wCks2/YuK
	P7WSVhXwC/QsmRRqkTuSZXM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jW6Rf6h9Lz1cyPV;
	Fri, 20 Nov 2026 15:29:50 +0800 (CST)
Received: from whupemo500017.china.huawei.com (unknown [7.152.184.243])
	by mail.maildlp.com (Postfix) with ESMTPS id F1ED540561;
	Fri, 20 Nov 2026 15:30:11 +0800 (CST)
Received: from huawei.com (10.67.174.49) by whupemo500017.china.huawei.com
 (7.152.184.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 15:30:10 +0800
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
Subject: [PATCH v2 1/3] ASoC: SOF: ipc4-control: Fix out-of-bounds backup restore in bytes ext put
Date: Fri, 20 Nov 2026 07:00:40 +0000
Message-ID: <20261120070042.279508-2-yeweihua4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120070042.279508-1-yeweihua4@huawei.com>
References: <20261120070042.279508-1-yeweihua4@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo500017.china.huawei.com (7.152.184.243)

sof_ipc4_bytes_ext_put() backs up ipc_control_data with
kmemdup(..., scontrol->size), but scontrol->size is the current payload
size, not the allocation size. Since the backup is kept after a
successful update, scontrol->size can grow beyond it. When a later update
is rejected, sof_ipc4_set_get_kcontrol_data() restores with
memcpy(..., scontrol->size), reading past the end of the backup.

Back up and restore the whole allocation (sizeof(*cdata) + max_size),
like IPC3. This also restores the ABI header and payload for controls
loaded without initial data. Recompute scontrol->size from the restored
payload on every restore, including the copy_from_user() failure path,
and only update it after the firmware accepts the new data.

Fixes: ebcfdbe4add9 ("ASoC: SOF: ipc4-control: Keep the payload size up to date")
Cc: stable@vger.kernel.org
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 sound/soc/sof/ipc4-control.c | 42 +++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index e29c8d89284a..ace3bf2f719d 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -56,18 +56,25 @@ static int sof_ipc4_set_get_kcontrol_data(struct snd_sof_control *scontrol,
 	if (!set)
 		goto unlock;
 
 	/* It is a set-data operation, and we have a valid backup that we can restore */
 	if (ret < 0) {
+		struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
+
 		if (!scontrol->old_ipc_control_data)
 			goto unlock;
 		/*
-		 * Current ipc_control_data is not valid, we use the last known good
-		 * configuration
+		 * Current ipc_control_data is not valid, we use the last known
+		 * good configuration. The backup covers the whole allocated
+		 * control data, so the ABI header and payload are restored even
+		 * when the control was loaded without initial data.
 		 */
 		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
-		       scontrol->size);
+		       sizeof(*cdata) + scontrol->max_size);
+		/* Keep the size consistent with the restored control data */
+		scontrol->size = sizeof(*cdata) + sizeof(*cdata->data) +
+				 cdata->data->size;
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
 		/* Send the last known good configuration to firmware */
 		ret = iops->set_get_data(sdev, msg, msg->data_size, set);
 		if (ret < 0)
@@ -628,10 +635,11 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
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
@@ -679,30 +687,44 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 				    abi_hdr.size, scontrol->max_size - sizeof(abi_hdr));
 		return -EINVAL;
 	}
 
 	if (!scontrol->old_ipc_control_data) {
-		/* Create a backup of the current, valid bytes control */
-		scontrol->old_ipc_control_data = kmemdup(scontrol->ipc_control_data,
-							 scontrol->size, GFP_KERNEL);
+		/*
+		 * Create a backup of the current, valid bytes control. Cover
+		 * the whole allocated control data, including the ABI header
+		 * and payload, so that the last known good configuration can
+		 * always be restored, even when the control has no initial
+		 * data (priv_size == 0).
+		 */
+		scontrol->old_ipc_control_data =
+			kmemdup(scontrol->ipc_control_data,
+				sizeof(*cdata) + scontrol->max_size, GFP_KERNEL);
 		if (!scontrol->old_ipc_control_data)
 			return -ENOMEM;
 	}
 
 	/* Copy the whole binary data which includes the ABI header and the payload */
 	if (copy_from_user(data, tlvd->tlv, header.length)) {
 		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
-		       scontrol->size);
+		       sizeof(*cdata) + scontrol->max_size);
+		scontrol->size = sizeof(*cdata) + sizeof(*data) + data->size;
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
 		return -EFAULT;
 	}
 
-	/* Update the cdata size */
-	scontrol->size = sizeof(*cdata) + header.length;
+	ret = sof_ipc4_set_get_bytes_data(sdev, scontrol, true, true);
+	if (!ret)
+		/*
+		 * Update the cdata size. Use the payload size from the control
+		 * data so that a restore of the last known good configuration
+		 * does not get overwritten with the size of rejected data.
+		 */
+		scontrol->size = sizeof(*cdata) + sizeof(*data) + data->size;
 
-	return sof_ipc4_set_get_bytes_data(sdev, scontrol, true, true);
+	return ret;
 }
 
 static int _sof_ipc4_bytes_ext_get(struct snd_sof_control *scontrol,
 				   const unsigned int __user *binary_data,
 				   unsigned int size, bool from_dsp)
-- 
2.34.1

