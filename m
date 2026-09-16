Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C884D0CE5;
	Wed, 16 Sep 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579149; cv=none; b=E5rPpvKvUz3zZUd66+kwWu9aqbczMkrfDY1TG1iF1JjHL4vc8/kPOhwFWeUc93+w9gHTZmVWpcpL/G3CGt/Rj9/L0T5gAVWtIjdzU8RlPo44g/Q1I9U3q5BpYbx4SBsW+ep0rXj23UfBlBe3Wyaitk/F/7eYsHeZpbFhVxllHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579149; c=relaxed/simple;
	bh=Qi0oYy8bvpa0rF6ygy7u5OZ0sYRVEkQtDoDzr4sgZfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iIf+1YNQKN6JaWIKSvctuz4zVfnpsWm014XwPlklMP57eBSJmJOAMYHKOmwDiRa7ac/wT5+zO3m0z2dDD9wiB9PZyL17Xne2IIKAZkNw2LgFUVu1LFJY6Cq0O8ORpxMbraMFiKqYHlgXXvFTrr+J5fm/VNciHXabCpJmqxOIeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3J0KCz6pqDHtuCA--.23129S2;
	Thu, 17 Sep 2026 01:18:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: airlied@redhat.com,
	alan@linux.intel.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	patrik.r.jakobsson@gmail.com,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/gma500: Fix pdev reference leak in oaktrail_hdmi_setup()
Date: Wed, 16 Sep 2026 17:18:31 +0000
Message-Id: <20260916171831.2087204-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3J0KCz6pqDHtuCA--.23129S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1fCr4fCrWxKF4xGF43Awb_yoW3ZFc_Wa
	18Zrs7Xry7CF1qkr12yrsavr92kF98uFWkZan8ta4fG343Zryjq34YgFZ8XFy7Za4FvFWD
	J3ZIqF98Xrn7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbUPEDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAMA2qqpVhfkQAAs7

If kzalloc_obj() or pci_enable_device() or ioremap() fails, the PCI
device reference obtained by pci_get_device() is not released.
Drop the reference on the error paths.

Fixes: 1b082ccf5901 ("gma500: Add Oaktrail support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 403d21cbb3a2..09fc50fb6f7b 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -717,6 +717,7 @@ void oaktrail_hdmi_setup(struct drm_device *dev)
 free:
 	kfree(hdmi_dev);
 out:
+	pci_dev_put(pdev);
 	return;
 }
 
-- 
2.34.1

