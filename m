Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813500;
	b=B2HjiDLnlrIC2+KVFG7NByDqq17YN+cWWsgCmM1DfhKCCAs9avlBzHFjZoLAtEUxVPfp
	 V/EpARV+X4KIgAbaudBc4yfEs/Yo64e30FtTRQQaHArlHQj4w7gpQQL4t3qwNIaE37VQW
	 HUF2W0whzwFblXbaGslB2jNR39pjHY+XDW3+obi+nZIAmTYL4YCZX8oMZ12r5rMufuwqm
	 ERu11cIn7QFXXHH1p5aMapyvhPNlnPwt2/s675rKvQ055TDJv/LYkYhYyiPg7nQaHwK5U
	 rY8yuHgFoOSC9dRpU0uEzhyOMxi10vYTPB+Tpm7Y2g3r69po+OOWL4bBFpFIWw/ZClg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813500;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=JFmvBZpwMqindYiNi7ogSyswfQwIz3IOi5bZUrK2eHs=;
	b=2wudOuCe7jlJaz6c80EfLDtkzz8yQtUJDMeUh+g4ugd58tXU6GL7SowCDjE5Pw1suswF
	 sUGjx/uBRYkrbZLnzMZiidoxWRzIO/ZrcsN0Ni+8qXBfbjTbYQTaltAXRlHyvjP+QetvL
	 BlHUS3Jl0wltvQkQ28er8/z3H96uvAQ5sI6FGJLzMQO2r7pBr+SJ/llO7iaftdAhv+2kU
	 fRsmJzkQuZ4OQojvFdiEo91vZl0E2Cxr0OBhzjn2+SqC3ZnTidlP8A5iD7Wz+2lAr3toZ
	 Pkg5sgtgEzSY/ayPV7vE03UZc22zXxa6KxxKfZTvscq4EKovY6PKa4kJ0JBJxJDiMMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fySSgXYU;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293E606A31C;
	Mon, 16 Nov 2026 07:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2293E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fySSgXYU
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JFmvBZpwMqindYiNi7ogSyswfQwIz3IOi5bZUrK2eHs=;
	b=fySSgXYUJsKs6wQ9ZInYWkiZYXtIL44oK+ZLlI2X9UdG5+9KRhM1Xm5O6ufFQFt86yKvMt7lH
	TJ16ss/1KR7gBTrdQpJb3REnew8XXMwlEJYoLXBrMRJscziuB5BVXrODOpqYUThJQ+jWdtXVa+N
	YsOJou3GG9bKApK1GTpz60Q=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jSfM96SGszpT06;
	Mon, 16 Nov 2026 15:17:25 +0800 (CST)
Received: from whupemo500017.china.huawei.com (unknown [7.152.184.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CBCB40538;
	Mon, 16 Nov 2026 15:18:12 +0800 (CST)
Received: from huawei.com (10.67.174.49) by whupemo500017.china.huawei.com
 (7.152.184.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 15:18:11 +0800
From: Ye Weihua <yeweihua4@huawei.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC: <linux-sound@vger.kernel.org>, <stable@vger.kernel.org>, Ye Weihua
	<yeweihua4@huawei.com>
Subject: [PATCH -next 2/2] ALSA: pcm: oss: Clear params flag only after successful setup
Date: Mon, 16 Nov 2026 06:48:50 +0000
Message-ID: <20261116064850.3540576-2-yeweihua4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116064850.3540576-1-yeweihua4@huawei.com>
References: <20261116064850.3540576-1-yeweihua4@huawei.com>
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

runtime->oss.params is cleared before the initial silence setup has
completed, so the flag claims a complete configuration while the
buffer setup is still in progress.  The error path now restores the
flag, so this is not fatal, but clear it only after the whole
reconfiguration has succeeded.

Move the assignment after snd_pcm_runtime_buffer_set_silence().

Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 sound/core/oss/pcm_oss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 29812b0d1318..2fc52fe2cb52 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1071,16 +1071,16 @@ static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 	if (!runtime->oss.buffer) {
 		err = -ENOMEM;
 		goto failure;
 	}
 
-	runtime->oss.params = 0;
 	runtime->oss.prepare = 1;
 	runtime->oss.buffer_used = 0;
 	err = snd_pcm_runtime_buffer_set_silence(runtime);
 	if (err < 0)
 		goto failure;
+	runtime->oss.params = 0;
 
 	runtime->oss.period_frames = snd_pcm_alsa_frames(substream, oss_period_size);
 
 	err = 0;
 failure:
-- 
2.34.1

