Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E52D97B7;
	Wed, 16 Sep 2026 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581689; cv=none; b=KwxxvEZvGFRL5i/iqcO6TCSxx6d4Ol70/G7NZk4tGCVV+x8Y2v27pU8821+LecB1TcczMaYLlGSFXuMLnBtpVjkU35XO5de6iJGp9ptl5ADf84OcLdYfx0R2JjjGw8aIj/MQ/iV1a5ePuOhYNlWd8gtRt4hyMLp1QsAdrFFStds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581689; c=relaxed/simple;
	bh=ypjFRLD/zClnkBfZwNyL9zXM06+7o8xcU6SKH1UwlNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QG+NzL+RC2jzlP8Wb8KiBBn0rzgkpRTuTAexYnYYGRvDYDLRNQM35w6fCsINHPdjKjSDWzeOHELXwz7kdNUdejBPfRiACYgQq5C+NDoqhzlHWZDeEBPaZbOIFVn/DpzLaDGmBnjIanXQ0ZUxGoFF5YvAHgb79IPacmFClM2TttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADHMTxg2apqWRdvCA--.23293S2;
	Thu, 17 Sep 2026 02:01:04 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dakr@kernel.org,
	dri-devel@lists.freedesktop.org,
	helgaas@kernel.org,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	nouveau@lists.freedesktop.org,
	okaya@codeaurora.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
Date: Wed, 16 Sep 2026 18:00:36 +0000
Message-Id: <20260916180036.2090118-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHMTxg2apqWRdvCA--.23293S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry5CryDKrWkAr1DZrykuFg_yoWDXFX_C3
	W5ZFn3Gr10kr1DuFsFyrn3XrZ29wsrZFZ2qwnFq3s3G347Zrs3ur1avr1rXF98JF4FgF98
	Ja1kXr98WrnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
	W0obIYCTnIWIevJa73UjIFyTuYvjfUw5l8UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2qqpVhw0AAAsS

pci_get_domain_bus_and_slot() takes a reference to the PCI device,
which is never released once the memory size has been read from its
config space.  Drop the reference before returning.

Fixes: 2fa6d6cdaf283c05 ("drm/nouveau: deprecate pci_get_bus_and_slot()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
index 18241c6ba5fa..4d52a158f320 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
@@ -51,6 +51,8 @@ nv1a_ram_new(struct nvkm_fb *fb, struct nvkm_ram **pram)
 		mib = ((mem >> 4) & 127) + 1;
 	}
 
+	pci_dev_put(bridge);
+
 	return nvkm_ram_new_(&nv04_ram_func, fb, NVKM_RAM_TYPE_STOLEN,
 			     mib * 1024 * 1024, pram);
 }
-- 
2.34.1

