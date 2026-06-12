Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E122288CB;
	Fri, 12 Jun 2026 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231470; cv=none; b=R8VfHs1Fpu343X/cGx212cKuO7IQhIh+Ox4WrLPRpgsNFhWW4bPvCOAskvt6BOHflvAv5IxLvcrXuX9/Gt4KQzJ7t8Bj/SWgu+oC5BQC+ZfpM/d8VG8ObhbIQCnRLt5S93pOXMfjjzYpXn7WundeKs2qrp1PbogDZ5471xzmp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231470; c=relaxed/simple;
	bh=LgpaQTC6fblmH++gFq6iq2Qe28tgjw3krqLdbax2OlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZAtux6BoQrgA8wMyiIj4sFTJol5R4wx9Nl5pZfwtgCQb4q21JKGPw14/vQgk/S/cdLBXVe45pj2LT16kHWTr6GnwhTGFX2C6fMs9UWlIyAAHFRiJ4dMxAQ5jHs7/8aB6pBGLjkh9AWY4hPs0634z/YYWyoa7+vA298owRsjnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowACHKNFkbytqfxBcAQ--.209S2;
	Fri, 12 Jun 2026 10:31:01 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: vulab@iscas.ac.cn,
	cezary.rojewski@intel.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] sound: fix refcount leak in snd_ctl_elem_write_user()
Date: Fri, 12 Jun 2026 10:30:59 +0800
Message-ID: <20260612023059.16005-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHKNFkbytqfxBcAQ--.209S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw15tr4rJr1DGF4ktrW8JFb_yoW8JFy8pr
	s5K3srGa95JFWFyanFqF409r1ruw13AF1DAw48Gw1ftr1furnIvayvy345ZF45CF97G3yU
	Xr4UG348AFy3CwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhtx
	DUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkQA2orL1Cx1wAAsF

snd_ctl_elem_write_user() calls snd_power_ref_and_wait(), which
unconditionally acquires a power reference via snd_power_ref().
If the call returns a negative error code (e.g. when the card is
powering down and wait_event_cmd triggers -ENODEV), the reference
is held but never released. The function then returns the error
without calling snd_power_unref(card), leaking the power reference
count.

Add the missing snd_power_unref(card) on the error path to restore
the reference count balance.

Cc: stable@vger.kernel.org
Fixes: fcc62b19104a ("ALSA: control: Take power_ref lock primarily")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/core/control.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index e3bb26206c39..7b714b5f8d54 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1408,8 +1408,10 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 
 	card = file->card;
 	result = snd_power_ref_and_wait(card);
-	if (result < 0)
+	if (result < 0) {
+		snd_power_unref(card);
 		return result;
+	}
 	result = snd_ctl_elem_write(card, file, control);
 	snd_power_unref(card);
 	if (result < 0)
-- 
2.50.1 (Apple Git-155)

