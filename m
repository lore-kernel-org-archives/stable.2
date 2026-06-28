Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A6137923;
	Sun, 28 Jun 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652927; cv=none; b=d1SFuOT0a0jCZiluqD//PLGnypbX5KoIGKpqw5M0JjoIC3FxJDyFdVku/IoHIvrIsVnUOHp01VRZ7apRC7jOE67i1Z63sts+dTYKsD+DRFNpsY3pFs6oX9t18zRob2lgJWVA1Os2f0xnxUT8rwTM2Fym0JRh6voamCTAxnuAdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652927; c=relaxed/simple;
	bh=GK6dBLdqkp4UtAE0/0kPLzMbuAGB9mkwszBxXqnb9uE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ed2B/aTBG6gRLvUAHWzIBwYqYwz8y9RAdPMhET4X09tllcqGMEqUqONvUD9eR96LE58qZNZjCpvzcri1yza3sbj2fVXnkclmDWm7VR875m2bZ2sQwIiMWnzXtLS5FPtDV0CzJJUEvVGPyojKUgubxrbU2+S0ff6yNQLTa9prxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowAD3bfH1H0FqbSPGFQ--.45764S2;
	Sun, 28 Jun 2026 21:21:58 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] edac: fix kobject refcount leak in edac_device_create_instance
Date: Sun, 28 Jun 2026 21:21:55 +0800
Message-Id: <20260628132155.45969-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3bfH1H0FqbSPGFQ--.45764S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZFWrtw4xJFy8ZFy8Zw43Jrb_yoW8Jr1Dpr
	sxGFW7ZFWjgw4I9a1DAF1UGFyrK39Fk3y0kr10y392gr4UJFy7XryktFWUWF1rZ397Cay3
	Z3W7Xw1rJFW5CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvXd8UUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAMA2pAior3jwAAsR

kobject_get(&edac_dev->kobj) acquires a reference on main_kobj, but it is
only released when kobject_init_and_add fails. The success path and the
block-creation error path both return without calling
kobject_put(main_kobj), leaking the edac_dev kobject reference. The
main_kobj pointer is local and lost after function return.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
 drivers/edac/edac_device_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index b1c2717cd023..72b06d608b98 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -647,6 +647,7 @@ static int edac_device_create_instance(struct edac_device_ctl_info *edac_dev,
 
 	/* error unwind stack */
 err_release_instance_kobj:
+	kobject_put(main_kobj);
 	kobject_put(&instance->kobj);
 
 err_out:
-- 
2.39.5 (Apple Git-154)

