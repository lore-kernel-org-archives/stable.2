Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159820;
	b=xQt3bgrdXtjWnqwTvzBPgQOtbcjfMQuTIiNSR0uWVxIIni6iYL1tSyOpJ442WlvKofCO
	 SzRkz4dEngSg3ekOWVq961MkXCmcNVBzag233UfYcdCpQQuDFF+vZDkjg275CMl35EMf1
	 csskMuveeDI5A9ezJIApshraUtPkvWGClBjT8LweuD5Lfj+8xM+iyc8XqIt2Ttj8T6ZJT
	 L+5+Cn1wkBtt1hzuryoo543eHnLnJJMupHz89M77PbWYRXkLyrTFSH47Q0V32sK3tTckt
	 egf890VDG72u7f8j+EKJM8LUVoilljXn1gbaAeLqVlhnfmm0WoQU2o8j0y41dfIG9Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159820;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=DMtNkNDdwGiJjFpU64GvFMVMpYmZr/dP4xn6Uq//Axo=;
	b=zd90aFHOUkhbTHr9mJn2ig0mPkEcfqs5wwe/gUo2y/71r1KE9jQuW9pLouPDd/piN0h4
	 P+zrwGa1D+vYPu6pC4noRaAPm2y5HLsEj5R3IEjuB41kKpftM/MCSTaOIxoA4lYapVlVC
	 ybxpGDqyU4XA2WoBVqJuQjSnpzs7IWCQNpG/vqTeDnP4D5bxuBabj8CPeJFSJN/t/sZtZ
	 PXzgZ52TKtVR5M4E8/Kl9rYn8DMk0oi5/Ln1fmbfb4W+C7OPtzRI/ORX88HeUoPgvEYb+
	 ndtx6ALAm25zwht3TlafXXoLVl7Ck77wjU3IOgM2iuCeuQC3ku6Mcs0KN7VuGq7CDZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=QWuHufGV;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC78606A326;
	Fri, 20 Nov 2026 07:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DC78606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=QWuHufGV
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DMtNkNDdwGiJjFpU64GvFMVMpYmZr/dP4xn6Uq//Axo=;
	b=QWuHufGVRII0kXJw71yNiPaKiScGSxnTYT/KgFh1qFUEf7qnAVIwASqIDkYQLnqJkttf6PfXK
	K2UmT0hHGxuMvueZQIimHF5H/LLZaHyddy68pr56Jr+yKWAI6yUcz1OiPEJGB0V4MN+hhfdpwUh
	FqbhRQVF0mVM7fG/8ZQz49Q=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jW6R35Qkdz12LJn;
	Fri, 20 Nov 2026 15:29:19 +0800 (CST)
Received: from whupemo500017.china.huawei.com (unknown [7.152.184.243])
	by mail.maildlp.com (Postfix) with ESMTPS id D816C40561;
	Fri, 20 Nov 2026 15:30:10 +0800 (CST)
Received: from huawei.com (10.67.174.49) by whupemo500017.china.huawei.com
 (7.152.184.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 15:30:09 +0800
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
Subject: [PATCH v2 0/3] ASoC: SOF: ipc4-control: fix bytes control restore and replay
Date: Fri, 20 Nov 2026 07:00:39 +0000
Message-ID: <20261120070042.279508-1-yeweihua4@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo500017.china.huawei.com (7.152.184.243)

sof_ipc4_bytes_ext_put() backed up the last known good bytes control data
with the current payload size (scontrol->size), which can be smaller than
the allocation and can grow beyond the backup after a later successful
update. Restoring that backup therefore read past the end of the
kmemdup() buffer. The backup also did not cover the ABI header and
payload for controls loaded without initial data, and scontrol->size was
not rolled back when copy_from_user() failed.

Patch 1 backs up and restores the whole allocated control data
(sizeof(*cdata) + scontrol->max_size), matching the IPC3 implementation,
and recomputes scontrol->size from the restored ABI header and payload.
It also updates scontrol->size only after the firmware accepted the
update, so a successful restore replay cannot overwrite the restored
length with the rejected one.

The backup is also leaked when a control is released while the backup is
still present, so patch 2 frees it in both control release paths. The
replay after a rejected update used the message built from the rejected
data; patch 3 rebuilds that message from the restored data before
replaying it, for both regular bytes controls and
SOF_IPC4_BYTES_CONTROL_PARAM_ID controls, whose payload lives in a
separate buffer that also has to be rebuilt.

Changes in v2:
- Back up and restore the whole allocation instead of adding an
  old_ipc_control_data_size field, so sof-audio.h is no longer touched
  and the u32/size_t mismatch is gone.
- Recompute scontrol->size from the restored ABI header and payload on
  every restore, including the copy_from_user() failure path.
- Move the replay fix into its own patch and rebuild the message from the
  restored data, including the SOF_IPC4_BYTES_CONTROL_PARAM_ID path that
  was previously left as a follow-up.
- Free the backup in both sof_control_unload() and sof_widget_unload().

Link: https://lore.kernel.org/all/20261119121446.124833-1-yeweihua4@huawei.com/

Ye Weihua (3):
  ASoC: SOF: ipc4-control: Fix out-of-bounds backup restore in bytes ext
    put
  ASoC: SOF: topology: Free bytes control backup on unload
  ASoC: SOF: ipc4-control: Rebuild replay message after restoring data

 sound/soc/sof/ipc4-control.c | 95 +++++++++++++++++++++++++++++-------
 sound/soc/sof/topology.c     |  2 +
 2 files changed, 79 insertions(+), 18 deletions(-)


base-commit: 7cfbf79c66c63e807ea452abf0546e6f6d6833a6
-- 
2.34.1

