Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81C390228;
	Fri, 12 Jun 2026 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781232081; cv=none; b=Bn6nUSTCdq7ISx8Dir280ZF0tK1zoa2bZBceKsfzq0fAUqew7iLlW6hK6e8iG4XBokg/JtpE8QNT2Hu+VnKWys87d0nqwxHBCma/uWKQVT4KYq+lIP8QopdwSby0kR2FMeCKPBe/C4VK5/xVU01xJGNP0n2Xvrhccplb+gmmh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781232081; c=relaxed/simple;
	bh=uG3pA2H1iNKzu1H1m7/sVgfeuG2+jM5MbQx8WqeqJV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2Ouq7eZU6laxhOCVkioK9etFLLwe17CXq5SK5AVIi4G1fpGRO3SHI3M6R3AmZ0munuDE8YxY+Rt27obfc59eYJ1gejgSAesWn5hebqOwxIqji412PJdrJ03dm3qflV1s3GUs6VfCfgFs5mRrE1IfsnXbgedwhH4P/fYbcGYsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowAB3HNXGcStqQUdcAQ--.9267S2;
	Fri, 12 Jun 2026 10:41:12 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: vulab@iscas.ac.cn,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: control: fix refcount leak in snd_ctl_elem_info_compat()
Date: Fri, 12 Jun 2026 10:41:09 +0800
Message-ID: <20260612024109.17767-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3HNXGcStqQUdcAQ--.9267S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyUtrW5KFWxJw4rWw48WFg_yoWkZrX_G3
	yfWa109ay5WFZFy3Wqyrs3ArWSyrZrCr1xKrWktF4UJFWYyanFqrsrZry3Crn7WrW0gr4D
	C3sxAF4jvFWxtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhtx
	DUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoQA2orL1C7ZQAAs+

The error path when snd_power_ref_and_wait() returns an error does
not drop the reference acquired by that function.  Since
snd_power_ref_and_wait() always takes a reference even on failure
(e.g., returning -ENODEV when the card is shutting down), the caller
must release it to avoid a refcount leak.

Add the missing snd_power_unref(card) call before returning the error.

Cc: stable@vger.kernel.org
Fixes: a1066453b5e4 ("ALSA: control: Fix power_ref lock order for compat code, too")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/core/control_compat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 16bc80555f26..af0bb694b463 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -97,8 +97,10 @@ static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
 		return -EFAULT;
 
 	err = snd_power_ref_and_wait(card);
-	if (err < 0)
+	if (err < 0) {
+		snd_power_unref(card);
 		return err;
+	}
 	err = snd_ctl_elem_info(ctl, data);
 	snd_power_unref(card);
 	if (err < 0)
-- 
2.50.1 (Apple Git-155)

