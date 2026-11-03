Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694207;
	b=CZPBc5aQl39w8QhGU63FGuwSczbUWQ8OR245CC2VCUMUrOYb/2VnQV7y8JVLbM7ZANN5
	 PozRK8BqZkCC35ipWoNoUUGQlMc2JWmoa9ugMBeOiSD9Qv3Jz1ee/s0pLSheHweCLinJU
	 sha3wZ6RCoGpwlj5aSgnKqXKpYUSWE5aET+XAenycu8zb51ZgArlQ17J1Q16L5R1S/LV4
	 vVxffuFx4Nu7UA+QnVJCstYJTg6FZ9RWD7n6vT17fKA3GK/6A+7K074sXteg2hfmrp+X4
	 ioU7tdJIfj95Pc2w3OSTayVvyRN0u+TU/IYwSnf1U/Qep55J9DlCxgpKqXNZWUXGBEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694207;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=uu2p/imvpYYwGCawb+da14uOdwKVbFCIiMNwg0pW/BU=;
	b=FMfBnhd5huAxJ5RVFTNV2TNFpH5CoDVvR7qwBhXMryVlaiJAItiaLtIWAuINsNsI8Zyf
	 X/Khj6ZihoIRo8Xj89rpbCfuoJhU68w+gStZnwYhmfQA3XoRi11+VaSqAH/Y3Te2cWBU8
	 IO6mUpVCazG4y2XoBF+RMZZ3Y52IYUXyVve6O0L2y54bHujKW+gDyEDCScI6HE0MIXulT
	 G3/Eh9cv2zBuVpxOirRwmO728EhpGVSoNAHJxSXG+6bS2/hoWLxxexbMIpI+SAPnlvxiP
	 NTCYR5zCktPtf6HR1N2k//9IW+zHa4QEWvDJXEnA7U234u5x+e10lFXOlNGoHMp3CeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B97606A324;
	Tue,  3 Nov 2026 08:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03B97606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHFpf4melqOmQ6AA--.1296S2;
	Tue, 03 Nov 2026 16:23:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: bmarzins@redhat.com,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dm: release the sysfs kobject when its initialization fails
Date: Tue,  3 Nov 2026 08:23:29 +0000
Message-Id: <20261103082329.1159472-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAHFpf4melqOmQ6AA--.1296S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr43KryUJry7Ww4rGw1UGFg_yoW8Jw13pr
	srXrWavrykJw4xtw1DZ3W09F9Yqw4Sk3y7GFWS9ayF934rZr17XF1rtFW7AF4DJF4kGF4r
	tF9Yyr98Ga4vkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUMGQ
	DUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkAA2rpWmXzjwAAsM

dm_sysfs_init() uses kobject_init_and_add(), which requires a matching
put even when adding the object fails. dm_setup_md_queue() currently
unwinds the disk and holder links without releasing this object. Since
md->type is still DM_TYPE_NONE, cleanup_mapped_device() also skips the
sysfs cleanup, leaving the initialized kobject behind.

Call dm_sysfs_exit() before unwinding a failed sysfs initialization. This
both puts the kobject and waits for its release callback, including when
CONFIG_DEBUG_KOBJECT_RELEASE delays that callback, before the mapped
device can be freed or its queue setup retried.

Fixes: 784aae735d9b ("dm: add name and uuid to sysfs")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/md/dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1881d86111fb..08b87fd6f955 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2647,8 +2647,10 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 	mutex_unlock(&md->table_devices_lock);
 
 	r = dm_sysfs_init(md);
-	if (r)
+	if (r) {
+		dm_sysfs_exit(md);
 		goto lock_out_undo_holders;
+	}
 
 	md->type = type;
 
-- 
2.34.1

