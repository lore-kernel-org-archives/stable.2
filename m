Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01322E7BD9;
	Fri, 12 Jun 2026 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231236; cv=none; b=FoBBfPEEdnYIxTJO+GbnRw2XXPpCMxAfHQnwcv5/2zhN9aibpwQ6NxJTnEtX4XTUtDcrm4P8y6rOIf05EuPFNW8QqLebrEivl31YF1VspcKlE9ajaREFCC1ZsdbKnj36N9NNoAirAWOKRcWx5uch9UBdHjjJZ8ee0JUqQ8C25r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231236; c=relaxed/simple;
	bh=4/9DIboo16CwMWTWGVTrdIxfi7nFUdiTLnCoCXD7wEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m12TZ0mqRAFIILLQtChCUyp2gBawtnyULBXqGPnHoTun4mbUn2QhVKJQz2RqIaClO9steg5H6mP+j8ddiI4mhIg/+byu3eWUjj8xsSrxhIw7uXJuvg2rrxSzwNJZh0AQcI0sb26hcS/C3tP8F4S8ynVGe/RvM6iyFPrRjzVa8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowACXPNV3bitqk_pbAQ--.10710S2;
	Fri, 12 Jun 2026 10:27:04 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: vulab@iscas.ac.cn,
	chenziqing@xiaomi.com,
	broonie@kernel.org,
	cezary.rojewski@intel.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: control: Fix power refcount leak in snd_ctl_elem_read_user
Date: Fri, 12 Jun 2026 10:27:02 +0800
Message-ID: <20260612022702.15371-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXPNV3bitqk_pbAQ--.10710S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWrWFyUurWrtFy7uF45ZFb_yoW8Gr17pr
	4vgrZrKFyrtF4Fyay2qa10gr1fua43AFy3J3y8Gw1fGr13Wwn5ZrykA34rCF4YkFykWr4Y
	qrsFkw1xJF9xCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQZ2fUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgQA2orLhmwpwAAs2

snd_power_ref_and_wait() increments the power refcount before waiting.
When it returns an error (e.g., -ENODEV due to card shutdown), the
refcount is still held, as documented in its comment:

  "The caller needs to pull down the refcount via snd_power_unref()
   later no matter whether the error is returned from this function
   or not."

snd_ctl_elem_read_user() fails to release this refcount on the error
path, leaking a reference. This can impede proper card resource
cleanup during shutdown sequences.

Fix by calling snd_power_unref() before returning the error.

Cc: stable@vger.kernel.org
Fixes: fcc62b19104a ("ALSA: control: Take power_ref lock primarily")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/core/control.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 135a994e2d9e..e3bb26206c39 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1261,8 +1261,10 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 		return PTR_ERR(control);
 
 	result = snd_power_ref_and_wait(card);
-	if (result)
+	if (result) {
+		snd_power_unref(card);
 		return result;
+	}
 	result = snd_ctl_elem_read(card, control);
 	snd_power_unref(card);
 	if (result < 0)
-- 
2.50.1 (Apple Git-155)

