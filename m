Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6903D25CC;
	Thu, 17 Sep 2026 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663528; cv=none; b=OPJ/pOspQkLMSdp2OAS9+w0DzvxangXMCYFZ7jcA1XDOrETYu9cM6M6pHC/Ms3SGdjN16LnovLyN6OgtAmX6nX3mjI0uRspc5dj5XJQVogZwGy3WUuUH2bEpoVavTZPWp5mD5f0evcVtqYTuY11JyHB/s1gVdr/NzDMjLq+3zm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663528; c=relaxed/simple;
	bh=AFseobe/On7PEOH87B7g1yNk8F7L0I6E2Np587p6ZdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J8mTFwKzALD3FsGfgMjT77es5jtgXGCC8sJy9RH0JG2DIw0gFC3nBY9PJSpbs5g19GTAznRIN7fj0qAV7TlQ0wQslic/Q1qszc1OcFDefWbbc8pJzRrUGbcwrjlngHOuTf463SMOVPXEOCupI8HndOPfpg8uzWTsQfESAyobCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3J0IgGaxqwbyECA--.47882S2;
	Fri, 18 Sep 2026 00:45:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: baojun.xu@ti.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/tas2781: Fix ACPI device double put in tas2781_read_acpi()
Date: Thu, 17 Sep 2026 16:45:20 +0000
Message-Id: <20260917164520.2163024-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3J0IgGaxqwbyECA--.47882S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1DJF13WF4DGw1kJFyrZwb_yoWkZFg_KF
	45urWUXa48XFZrAw4rXF1v9FWrurs7AryrGrn5try29rWrWr4UXr98Jr1rAryDua10va4r
	X3WYk3W8Gry2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
	87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IY
	c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjd-PUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQNA2qr9nBRuwACsp

The reference returned by acpi_dev_get_first_match_dev() is already
released right after the physical node is looked up. The adev variable
is not reassigned afterwards, so the acpi_dev_put() on the err path is a
second, spurious put of the same device, which unbalances the reference
count, or frees the device while physdev may still be in use.

Drop the redundant acpi_dev_put() from the error path.

Fixes: bb5f86ea50ff ("ALSA: hda/tas2781: Add tas2781 hda SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index 0e4f3553f273..63f8b15c2d8c 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -386,7 +386,6 @@ static int tas2781_read_acpi(struct tas2781_hda *tas_hda,
 err:
 	dev_err(p->dev, "read acpi error, ret: %d\n", ret);
 	put_device(physdev);
-	acpi_dev_put(adev);
 
 	return ret;
 }
-- 
2.34.1

