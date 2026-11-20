Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159818;
	b=3/wPmB/NWlVm6MnIN42cEEYdlbctTkaVQVJeJx5xzMF5OYyQa/o4JjAltHi7RebiMw7F
	 AgO2fI/blC07sQXd6EDYeUx+usGKR5xy6Sfw0NKXr7oFkzuRRpKoeC2CquBG27KyWlmvh
	 iQf1vKJpUIM8l8SplmfUODltWYAjWlqcgN/E/Gd9VjM9Hn7pNKznm4VGm5RuS3oMdq0Wt
	 +kJaGNyNpE3Z9dLP80uHQAv2AGTR0samtqR4MCFtwhrl3LlE4S7zEyddMBDAW5437aX8z
	 /3z1lgWDptAT2YBZ9mh09zTe1NzivQxZtNP0z4/0gTVB1wAzonp3YFj8G998cMKtGDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159818;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=BsISWkOXmbIAnvPLWbPfN/HcUT7N2zYzFqqNnKeORDY=;
	b=tRbVdb1i066MbWca2Ks9oF7gUNPS9synbQ/ul2Z7QBGNZQAYRG81ndznTUTA93R1gbxw
	 +7AbEm6As4RL0arqn/Ye8pN0RaAgjs6vAKx3duodhRg8o9weVMoua++ddW2V/fiuuxjuz
	 p0UcCBMKojF9m6FQUYxHYAEEL3FdKKaz+74+Xg9HJLRrspYW5Srx8rjnUCRwSN4rTdWxH
	 5GCznwh2RsmfUuxYl+fOyDs/ZZlXFk03NVXfqEYXf6PNw+SiSavfifh46qZV5lxctGwFo
	 vuK7B0qPqJHi9tgE3A2KIQeyMLNy/rZnjDa8ITck6HVo/+d7lZdTyz8TQOTtexxVNBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Zd6nHMnh;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB436606A326;
	Fri, 20 Nov 2026 07:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB436606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Zd6nHMnh
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BsISWkOXmbIAnvPLWbPfN/HcUT7N2zYzFqqNnKeORDY=;
	b=Zd6nHMnhIDn1sQx+VDPw+BZdCKUruo3Fe8FGmeB3kMl+SeBszKv7Fn0IdJjth5nx2Lf4ZkyF0
	b71Cjap40nZAjglYlqfyFfvxgwf4cjXQd2y+rmUDJ4RB3GMo9mZwCygpaJIwLsDV99DCgeQY1Cz
	r9qoCzvER5Hhor7tOZKuHMM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jW6RH6GD6z1T4Fj;
	Fri, 20 Nov 2026 15:29:31 +0800 (CST)
Received: from whupemo500017.china.huawei.com (unknown [7.152.184.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 51FCD40685;
	Fri, 20 Nov 2026 15:30:14 +0800 (CST)
Received: from huawei.com (10.67.174.49) by whupemo500017.china.huawei.com
 (7.152.184.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 15:30:12 +0800
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
Subject: [PATCH v2 3/3] ASoC: SOF: ipc4-control: Rebuild replay message after restoring data
Date: Fri, 20 Nov 2026 07:00:42 +0000
Message-ID: <20261120070042.279508-4-yeweihua4@huawei.com>
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

When a set-data request is rejected, sof_ipc4_set_get_kcontrol_data()
restores the last known good data but replays the message built from the
rejected data. For regular bytes controls the extension may come from the
rejected data; for SOF_IPC4_BYTES_CONTROL_PARAM_ID controls the payload
lives in a separate buffer that still holds the rejected data. The
firmware therefore does not receive the restored configuration.

Let the caller rebuild the message from the restored data and replay it.
Move the param-id message setup into a helper so the payload can be
reallocated with the restored size.

Fixes: db38d86d0c54 ("ASoC: sof: Improve sof_ipc4_bytes_ext_put function")
Cc: stable@vger.kernel.org
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 sound/soc/sof/ipc4-control.c | 53 ++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index ace3bf2f719d..8ed006efe17f 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -73,14 +73,14 @@ static int sof_ipc4_set_get_kcontrol_data(struct snd_sof_control *scontrol,
 		/* Keep the size consistent with the restored control data */
 		scontrol->size = sizeof(*cdata) + sizeof(*cdata->data) +
 				 cdata->data->size;
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
-		/* Send the last known good configuration to firmware */
-		ret = iops->set_get_data(sdev, msg, msg->data_size, set);
-		if (ret < 0)
-			goto unlock;
+		/*
+		 * The caller is responsible for rebuilding the message from
+		 * the restored control data and replaying it.
+		 */
 	}
 
 unlock:
 	if (lock)
 		mutex_unlock(&swidget->setup_mutex);
@@ -287,14 +287,13 @@ static void sof_ipc4_refresh_generic_control(struct snd_sof_control *scontrol)
 
 	kfree(data);
 }
 
 static int
-sof_ipc4_set_bytes_control_data(struct snd_sof_control *scontrol, bool lock)
+sof_ipc4_send_bytes_control_data(struct snd_sof_control *scontrol, bool lock)
 {
 	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
-	struct snd_soc_component *scomp = scontrol->scomp;
 	struct sof_ipc4_control_msg_payload *msg_data;
 	struct sof_abi_hdr *data = cdata->data;
 	struct sof_ipc4_msg msg;
 	size_t data_size;
 	int ret;
@@ -313,16 +312,39 @@ sof_ipc4_set_bytes_control_data(struct snd_sof_control *scontrol, bool lock)
 
 	msg.data_ptr = msg_data;
 	msg.data_size = data_size;
 
 	ret = sof_ipc4_set_get_kcontrol_data(scontrol, &msg, true, lock);
+
+	kfree(msg_data);
+
+	return ret;
+}
+
+static int
+sof_ipc4_set_bytes_control_data(struct snd_sof_control *scontrol, bool lock)
+{
+	struct snd_soc_component *scomp = scontrol->scomp;
+	void *old_ipc_control_data;
+	int ret;
+
+	old_ipc_control_data = scontrol->old_ipc_control_data;
+	ret = sof_ipc4_send_bytes_control_data(scontrol, lock);
+	if (ret < 0 && old_ipc_control_data &&
+	    !scontrol->old_ipc_control_data) {
+		/*
+		 * The new data was rejected and the last known good
+		 * configuration was restored. Rebuild the message from the
+		 * restored control data and replay it.
+		 */
+		ret = sof_ipc4_send_bytes_control_data(scontrol, lock);
+	}
+
 	if (ret < 0)
 		dev_err(scomp->dev, "%s: Failed to set control update for %s\n",
 			__func__, scontrol->name);
 
-	kfree(msg_data);
-
 	return ret;
 }
 
 static int
 sof_ipc4_refresh_bytes_control(struct snd_sof_control *scontrol, bool lock)
@@ -508,10 +530,11 @@ static int sof_ipc4_set_get_bytes_data(struct snd_sof_dev *sdev,
 				       bool set, bool lock)
 {
 	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
 	struct sof_abi_hdr *data = cdata->data;
 	struct sof_ipc4_msg msg;
+	void *old_ipc_control_data;
 	int ret = 0;
 
 	/* Send the new data to the firmware only if it is powered up */
 	if (set) {
 		if (!pm_runtime_active(sdev->dev))
@@ -538,11 +561,25 @@ static int sof_ipc4_set_get_bytes_data(struct snd_sof_dev *sdev,
 	if (set)
 		msg.data_size = data->size;
 	else
 		msg.data_size = scontrol->max_size - sizeof(*data);
 
+	old_ipc_control_data = scontrol->old_ipc_control_data;
 	ret = sof_ipc4_set_get_kcontrol_data(scontrol, &msg, set, lock);
+	if (ret < 0 && set && old_ipc_control_data &&
+	    !scontrol->old_ipc_control_data) {
+		/*
+		 * The new data was rejected and the last known good
+		 * configuration was restored. Rebuild the message from the
+		 * restored control data and replay it.
+		 */
+		msg.extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(data->type);
+		msg.data_ptr = data->data;
+		msg.data_size = data->size;
+		ret = sof_ipc4_set_get_kcontrol_data(scontrol, &msg, set, lock);
+	}
+
 	if (ret < 0) {
 		dev_err(sdev->dev, "Failed to %s for %s\n",
 			set ? "set bytes update" : "get bytes",
 			scontrol->name);
 	} else if (!set) {
-- 
2.34.1

