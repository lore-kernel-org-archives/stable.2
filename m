Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8C26FD9B;
	Sat, 27 Jun 2026 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782532382; cv=none; b=FmYoE2GWnFU2vb/oHBkqOl87s1iH9PckX5McofBD7zrEssv3jjfTje7HqGn2RaFfW3F1gUnwPjy9TULvZ1CJKcwMmXDprLcwh2VITAhyL5gX+4D1LhI3BPQeol0ZLh58Ys4YLGyF75rPq9ob4+SuCIzN3jPG6WOFlJtcFo+JgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782532382; c=relaxed/simple;
	bh=hQiWtljgC0LgnNQ1WNrb5iXXjYhkk0fgSeaBF3Z9AL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PCRipTC2JdAwiHq4WVanAZEHcsYBJBQ443uqOLto0C8v97ZXa9wQxQJsrEP41mJLaqN5m/FwoBnGQWxsMcH8pQmeDewG1dGRGpI7xFeQ9J9gGOJxqu95Joh25Ka/vVsCyVW43N2H/m0FeO3FNajJqEWY6AEHzpais7C3+ihFw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowACnQMkVST9qjK2BAw--.15669S2;
	Sat, 27 Jun 2026 11:52:54 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: s.nawrocki@samsung.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: sound/soc/samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get
Date: Sat, 27 Jun 2026 11:52:51 +0800
Message-Id: <20260627035251.60172-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnQMkVST9qjK2BAw--.15669S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4UWr17Ar4UJr1ktr15XFb_yoWktrb_K3
	s5WanxWryrJF4vqrs7XryUuan8trnrKFyUCF4jkFW3Kw13Ja13A34fZr18KasrurW8AryD
	ZFsrZaySk3yYkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbo5l5
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMLA2o-DxB2sQABse

In aries_audio_probe(), aries_dai[0].platforms->of_node is assigned the
same pointer as aries_dai[0].cpus->of_node (from of_parse_phandle)
without calling of_node_get(). When the sound card is deregistered, the
ASoC framework calls of_node_put() on both cpus->of_node and
platforms->of_node, causing a double put on the same node and a refcount
underflow.

Add of_node_get(aries_dai[0].cpus->of_node) before the assignment.

Cc: stable@vger.kernel.org
Fixes: 7a3a7671fa6c ("ASoC: samsung: Add driver for Aries boards")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/soc/samsung/aries_wm8994.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index 48ccc1d1854b..6db91b73f25c 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -658,6 +658,7 @@ static int aries_audio_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	of_node_get(aries_dai[0].cpus->of_node);
 	aries_dai[0].platforms->of_node = aries_dai[0].cpus->of_node;
 
 	/* Set CPU of_node for BT DAI */
-- 
2.39.5 (Apple Git-154)

