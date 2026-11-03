Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690122;
	b=yu0Z1E5EGrha7MFV/b5F4mFiANJtnbmYVif6ly+S2MSLzJ3Tb42gHnV84YnnwNb7bEJD
	 je4s21uhjuRUxOJViz0s75KwHB9bZp+ar7J/13JbDIPgk92QMZArGwmy5JKcTaZkRF55e
	 pSqM645bQ+HBqYGLgUNF9S+YgfP6vN30BQg2ng0NE6j7I7+MsrvsvOz8p0dLxMJ9H060I
	 amdRU9UCsvT+JQ36hKK6s2wggnWmU9Aupk1IpnNoKvDtDvzTxzcHWJxLu9bd3s30x1gFX
	 UAzVWmkClz24ixufw4Tn0m6cjgLsnAFV2YJ0OOOTHYqG2mSgFPjfYATK7ZGprNIwpcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690122;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Bk1RUJAtP4qz45c9JiEK0hXPPCkDS2F1urtosivp4xY=;
	b=gd4sN25sC3c08moOF/KcTaA8LE5D9M0tT4dn+nfrVV2Gg3S2IXGBM6FZIE+1tqxQ1cDZ
	 mDIfGVtj8tVNFCIM36P+16vaZ1QvMvcyHR4Zo2RgxVSV97gFp/Ds7sd4X1HTA9UYll+yj
	 GujcXN49DhdkflndkLuokRnkL5QcS1p/lfOYWOOwpzQZyPTXOkKQoQD43J4c4eVIVNnWy
	 EZ/nJB4vpvC6Xyc5x962gLC4z9gWUGRCyqR4XXWeBnxE7uApPkTjxPVFuyc5UZFTclu9G
	 yByFv6p6d5rzoMpYhqaHznll7Jt+xKKgO+HWiRqM0vBb3nDDINStDjH9II4/BHLQwoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1348606A331;
	Tue,  3 Nov 2026 07:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1348606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHkpMGiulq7sE5AA--.932S2;
	Tue, 03 Nov 2026 15:15:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Put the buffer object when handle creation fails
Date: Tue,  3 Nov 2026 07:15:27 +0000
Message-Id: <20261103071527.1091375-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHkpMGiulq7sE5AA--.932S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyfWrWUZr45tF1Utw1UZFb_yoW8XFyDpr
	ZxGryjkry3JrW2gFZru3WDAa45CwsrKFW8Ka4kuw47ZrnIy3W3tas8G3yqvr4UCrZ7AF4j
	v340yFZ7Zr1jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXID
	7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEAA2rpWtmkfQAAsc

vmw_gem_object_create_with_handle() leaves the allocation reference with
its caller, including when drm_gem_handle_create() fails. The allocation
ioctl currently skips dropping that reference on this error path, leaking
the buffer object and its backing storage.

Drop the allocation reference at the common exit when an object was
allocated. Keep the helper ownership rules unchanged, as its other callers
already release the returned object on failure.

Fixes: 9ef8d83e8e25 ("drm/vmwgfx: Do not drop the reference to the handle too soon")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index 39f8c46550c2..fd5b84744f88 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -233,9 +233,10 @@ int vmw_gem_object_create_ioctl(struct drm_device *dev, void *data,
 	rep->map_handle = drm_vma_node_offset_addr(&vbo->tbo.base.vma_node);
 	rep->cur_gmr_id = handle;
 	rep->cur_gmr_offset = 0;
-	/* drop reference from allocate - handle holds it now */
-	drm_gem_object_put(&vbo->tbo.base);
 out_no_bo:
+	/* Drop the allocation reference even if handle creation failed. */
+	if (vbo)
+		drm_gem_object_put(&vbo->tbo.base);
 	return ret;
 }
 
-- 
2.34.1

