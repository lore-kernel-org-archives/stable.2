Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159818;
	b=BJW3tpMPXSXz1JM6Wn0JH540dXVuu8tseSaQZVZ4lQgcS3oi8nchDI82shw8cb6AUfWd
	 N+CVNJofb3gTc8H6DH0czGX9zcwOte337+hcv++1fr7rQgAJ+392p1svhS0N9pLUgpwlk
	 1zLhjL0CnKiihBFbjCnKes04QOGcHYb6sHflSOfpCB7DW/spoDN/2yDRY3GIY1aQuE+78
	 CKHOedOMMnbSuVNp2zdBqZXrpP3j2Az5T0Grg+hAP8GFwpyujA6xtYHyrWlmVqu2FBmIn
	 Bb1bcfLJRDdTfI/iI/5jvGGPJMrKcTmhWFswAQzUna9SzXDD0rw07IjqZJH0wisXDug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159818;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=WgD3o5YqqFp5tl7g/gaLxS1DvznIweW9VYIoB5RoKIs=;
	b=5jFOXe+12Gh3z2JS9YvR0OxAHKiSQeYuPjStgA9uIn+4pYlpXANGwcUmte1jKIJUqomG
	 vl6P2hMLuINlUVkhXKIizkNaREJDoTrbbjboenFhIMebC54t9kozOWe2iX3hzrnX4UXXX
	 HDX+153QppwJS4RBZPFy1ImisKbICJBiBkS5BtX8L0145OnuJuBs+5G3C1DkS9hjOuevb
	 bevA1HzwENfdw6+K5/TqBqi8YQj7vrMo/bcNMbxVaMrjJqeFPdHjXjsYDIRqX/azrb0KK
	 Rg2CHtsJ5ZJtBzd57kIumwUn9rmVyFjOM3yQMy4uRQh6p+f2zb8PtSGYNKp9XACf62w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="jETopX/V";
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7894606A325;
	Fri, 20 Nov 2026 07:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7894606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jETopX/V
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WgD3o5YqqFp5tl7g/gaLxS1DvznIweW9VYIoB5RoKIs=;
	b=jETopX/Vv/H0WpCb8Ut4+3CN+Ode1JmosSdBB35hZPN3OTXePTr8UB9I34Beha+IXZ0LqRABP
	K8jYht2cvkVzNL8JZyetq/1E+XsfX2VbOwqxMCVN3YLTKQ4lXojLXWSHJBRuEnoQ2ziStZkpt3C
	H/je1Zg9svUf4eU9xyShsqA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jW6R10Gm5zcbWy;
	Fri, 20 Nov 2026 15:29:17 +0800 (CST)
Received: from whupemo500017.china.huawei.com (unknown [7.152.184.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 2661240685;
	Fri, 20 Nov 2026 15:30:13 +0800 (CST)
Received: from huawei.com (10.67.174.49) by whupemo500017.china.huawei.com
 (7.152.184.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 15:30:11 +0800
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
Subject: [PATCH v2 2/3] ASoC: SOF: topology: Free bytes control backup on unload
Date: Fri, 20 Nov 2026 07:00:41 +0000
Message-ID: <20261120070042.279508-3-yeweihua4@huawei.com>
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

scontrol->old_ipc_control_data is only freed when it is restored, so it
leaks if the control is released while the backup is present. Free it in
sof_control_unload() and sof_widget_unload() along with the rest of the
control data.

Fixes: 299f6c752f8f ("ASoC: sof: Improve sof_ipc3_bytes_ext_put function")
Cc: stable@vger.kernel.org
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 sound/soc/sof/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 4dcacafb9cdb..c21a0199db9c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1069,10 +1069,11 @@ static int sof_control_unload(struct snd_soc_component *scomp,
 			dev_err(scomp->dev, "failed to free control: %s\n", scontrol->name);
 	}
 
 	/* free all data before returning in case of error too */
 	kfree(scontrol->ipc_control_data);
+	kfree(scontrol->old_ipc_control_data);
 	kfree(scontrol->priv);
 	kfree(scontrol->name);
 	list_del(&scontrol->list);
 	kfree(scontrol);
 
@@ -1717,10 +1718,11 @@ static int sof_widget_unload(struct snd_soc_component *scomp,
 		default:
 			dev_warn(scomp->dev, "unsupported kcontrol_type\n");
 			goto out;
 		}
 		kfree(scontrol->ipc_control_data);
+		kfree(scontrol->old_ipc_control_data);
 		list_del(&scontrol->list);
 		kfree(scontrol->name);
 		kfree(scontrol);
 	}
 
-- 
2.34.1

