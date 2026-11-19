Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092265;
	b=J5sBLDb302/rIUJII+sMO3hF5E8bKe8KB7l85TGB43lYJuoOj3/S8T9tXvXCZ4z5Hwub
	 DMZGoGgXFL5XxoBtVoCDTZmbbN6NvT7SJ5beAJZ4us8IevWHWSlD9P8djI67fdg2GVYy4
	 sTjA4XDiDgL/HGLRny6PvKYmU7v9gCruOhNBAng3mFMeJn/zOqP2auOk7mZO6DJt+2R3p
	 rjMIormxJqnTDeia7uiIip8SMQu189ikew/9Hw6+1bygjJhWynGBd/CY5DypEwQHgdu8q
	 VR5RMy7ew/PrCqxmkTMOQHmm8VqgOcucROJczzHIztUt/3dms/ecW+FtqDNMTYNKw4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092265;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=gEUF5j3SdmghZnwmnMhcNly6K4nfdpDAoolOXRPv4r4=;
	b=aLcNonFggjpude7o62vRSW+A3asB0D1380P12Jb/p9MR58OYwaLH3SU6L6dqkFdi5F9l
	 jApD/tsU5DwzxJgPjSlReaiaPaSVcGhiGdqYfuFtusTYjg550B3S13s2fVa9XaY/ZipzJ
	 XVCk3GnZ+l8NYOfH0Poo/aAyVQFiUG4DnYO4i99qN8cs3quJxolNplNUZZ0KM0A+da+R/
	 qy95I36Q3PrNVL3KJgd7iEYrK8bc+zIDMrkYBoa78YYDVIWZBs1tIu/co5ma7tEkhYESp
	 N1lbZtnR7bjlTWIIGFa5yt1G/pkra7LcWk0J1/j9pW0k1hcVtDFASzBpX/V+L5NbiVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UoPrbboG;
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDB60A3812;
	Thu, 19 Nov 2026 12:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DFDB60A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UoPrbboG
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gEUF5j3SdmghZnwmnMhcNly6K4nfdpDAoolOXRPv4r4=;
	b=UoPrbboGhx2qW0Kg7zd2CG0dtQDrGZGHFOQp1Bqe9Ybfnd/6d+43Y4GKoWw53lyDM6gHWgE34
	TKlckZ7drSVXqmHCbWS+2BFCytHUrbx6yNwS+7CyoYkpf1SJo2Vz64cIkPIoRm0cXDPeiUrACN4
	43BlHpWvUdCe+vDBJ1KBkz0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jVdSb3wySzRhQS;
	Thu, 19 Nov 2026 20:43:59 +0800 (CST)
Received: from whupemo500017.china.huawei.com (unknown [7.152.184.243])
	by mail.maildlp.com (Postfix) with ESMTPS id BF9E14057D;
	Thu, 19 Nov 2026 20:44:14 +0800 (CST)
Received: from huawei.com (10.67.174.49) by whupemo500017.china.huawei.com
 (7.152.184.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 19 Nov
 2026 20:44:13 +0800
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
Subject: [PATCH -next 2/2] ASoC: SOF: topology: Free bytes control backup on unload
Date: Thu, 19 Nov 2026 12:14:46 +0000
Message-ID: <20261119121446.124833-2-yeweihua4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119121446.124833-1-yeweihua4@huawei.com>
References: <20261119121446.124833-1-yeweihua4@huawei.com>
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

sof_ipc4_bytes_ext_put() and sof_ipc3_bytes_ext_put() keep a backup of the
last known good bytes control data in scontrol->old_ipc_control_data.
This backup is only released when it is restored, so it is leaked when
the control is freed while the backup is still present.

Free old_ipc_control_data in sof_control_unload() and
sof_widget_unload(), which are the two paths that release the control
data, along with the rest of the control data.

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

