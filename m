Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813496;
	b=UKBOAY5S5no4Bsmu2HUWpl9VuFsjfQ9+eHgB677J3PD0zzm3SA52G1xX6gASQtp8Co71
	 oaBGauWJKeYot7xm5MsE1/AmV0A1CUfHzNHJCTKIjSBEdVu64nP/eWaLhy/OiKE+W9JkE
	 khRMgbFgvxQAdruevzMMka9j7ewXPupMa//sAGPxeOrhiAlxwxVe9njA3D+iRZqk7KTQz
	 gEYECiQ5gWsqUZjcXdbnt3RRh72YuAHB49KXBDub/G9fHjlWtBw9rHDRBNS2vYEc/xFuf
	 eWEOcLRcxclpYQ11D4pDi8w+1uAKg7yGvWmE+cQpZqXyGZGGja7xfatyBVt6HJefLtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813496;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=mWZ4esQCKXalQsWejOgP2p8iUAQorUuImT7qu6nH1pI=;
	b=JE1zcxeENb6EYVq1EGAsIQEJBs4HA2Or++YX+dQTiQzFwDcMs8gN4CAo+RDtbzC6Kv9t
	 o26FEuS6LXkHPSdtq1rl7VifwGBTQ9DSTRdgKfIOtohMi6iUzyVLmzCGtO4IRfTWljyPy
	 yEf+NnejF2D5kh6aa+tV+xpf5UOXPQBFN6JZUyx4BOIxFtu8ehpyjOAPNZaSPjRFFsFh1
	 G0Z+ESjPj2teynVJTNHJJZYPMl3lQqTbThEwiz94nFR4UcrkC4KyX7cpnidozefKAXGUD
	 gWhDlpU62/kfGuPv4Y3dF+oBKv9Vew3sKk/PbJ8Ti69szkeNlMa7IF04M2ovONpMEdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=d5etZ1R2;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDE606A31C;
	Mon, 16 Nov 2026 07:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACFDE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=d5etZ1R2
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mWZ4esQCKXalQsWejOgP2p8iUAQorUuImT7qu6nH1pI=;
	b=d5etZ1R26aCRqsdUd8gw1ErIM9OHIJJ7ZPmWkx0HGnBneL9deNs6dMPvtkIyWZhVKgtMmhmHA
	O8+XMOREJHhhmJhspFmWpMmYJBUka/mzTwCrjisG1BdW+zmRSRU9YpzqL5Wj+XWYiuF3DGeNguY
	mmFGhyDgJtzC8ADY0EyJH+Y=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jSfNC1Rvkz12LKP;
	Mon, 16 Nov 2026 15:18:19 +0800 (CST)
Received: from whupemo500017.china.huawei.com (unknown [7.152.184.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 7063E2011D;
	Mon, 16 Nov 2026 15:18:11 +0800 (CST)
Received: from huawei.com (10.67.174.49) by whupemo500017.china.huawei.com
 (7.152.184.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 15:18:10 +0800
From: Ye Weihua <yeweihua4@huawei.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC: <linux-sound@vger.kernel.org>, <stable@vger.kernel.org>, Ye Weihua
	<yeweihua4@huawei.com>
Subject: [PATCH -next 1/2] ALSA: pcm: oss: Restore params flag after failed reconfiguration
Date: Mon, 16 Nov 2026 06:48:49 +0000
Message-ID: <20261116064850.3540576-1-yeweihua4@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo500017.china.huawei.com (7.152.184.243)

snd_pcm_runtime_buffer_set_silence() may fail with -EBUSY when a
concurrent PCM transfer is accessing the buffer.  The error path
releases runtime->oss.buffer and clears the plugins, but leaves
runtime->oss.params cleared as well.  A subsequent small read/write
then skips the reconfiguration and dereferences the released buffer:

  Unable to handle kernel NULL pointer dereference at virtual address
  0000000000000000
  pc : __arch_copy_from_user+0x78/0x23c
  lr : snd_pcm_oss_write+0x10c/0x340 [snd_pcm_oss]

Restore runtime->oss.params on the error path so that the next OSS
operation reconfigures and reallocates the buffer.

Fixes: 47c27c9c9c72 ("ALSA: pcm: Improve the fix for race of buffer access at PCM OSS layer")
Cc: stable@vger.kernel.org
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 sound/core/oss/pcm_oss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 2d99df900f76..29812b0d1318 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1082,12 +1082,14 @@ static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 
 	runtime->oss.period_frames = snd_pcm_alsa_frames(substream, oss_period_size);
 
 	err = 0;
 failure:
-	if (err)
+	if (err) {
+		runtime->oss.params = 1;
 		snd_pcm_oss_release_buffers(substream);
+	}
 	kfree(sw_params);
 	kfree(params);
 	kfree(sparams);
 	return err;
 }
-- 
2.34.1

