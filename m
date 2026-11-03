Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689410;
	b=ans9/mgR1f8KuVmO9YbWs7S06J/El5sxb1GYNr5JifkDSkpvX306f5Vhg2f9bIVfE5I2
	 ADVXuAbXAVnJiV/8dJEqu/w4VkjYxs8os9zfIv59+Un4ptzu6Udy+1OFksJCb3Ny0/RJt
	 e3k85+YLXz9GjMR9GlMRLVpuF8CYSb6C/yywc4UGNTBPsMMOmY8WcYz+6gWH2gkEzU3wO
	 yO687LVLH0+QtMa9ArFOGk2HrS8dkJtcp0RpWzmdfrM55aRRUzuCKWMhSYsUkAI5wSUm0
	 AyUGY6NOCQp/rsI3KgpyU3k3WHQ9Kb8TJDOSF994AS5FTOvP/1n6TjdF+9hV2g7hKhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689410;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=aQIzl+tuB5OFcAf0kolt2eswfBhJMyO4rrUmymjV7pY=;
	b=rVVbuyRbaoWcTzvDUN5Lnm3Gs4Ddk0qO+GpHur+ag4+Gu1Xt+ZZJo0Wu5jWEQLegUmg6
	 ofctkDgwoXydIpDvpxwmd49qoh8JQjdZoq9Sm1SBQNTx8BWea8NtK1pSPyCrz7ihgqWZN
	 aZ+LZkokGiQvNBOpd34kSD63SWvpLp9JgqlEY5keUJiRPDjQ8mq9fXlFAbeK0z99QmTjw
	 A8uIe/LYfNTnPMFQqfFaI/wrglsu4T4BbskI5kPCCRoluKARb30Nc1It1q15HDQtujj8S
	 EadL2et8tqMQ9YdRcgrWgj9rg9Gl6JEzLwU5YPH0Vfm/850a7WvTTleozjQ3l3XWNKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C57606A324;
	Tue,  3 Nov 2026 07:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C57606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADn9ZY6h+lqvKQ5AA--.377S2;
	Tue, 03 Nov 2026 15:03:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: Remove the audio device link on component unbind
Date: Tue,  3 Nov 2026 07:03:31 +0000
Message-Id: <20261103070331.1079868-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADn9ZY6h+lqvKQ5AA--.377S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryfCr15XFyDJry7tr43ZFb_yoW8GrykpF
	48XF9xArWUWa1agay0y3W0vF15CanYyFWxC3sFk3sIgws0yr97CryYqw48XrW5JFs3uFs0
	qrnxt34UXa18CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUO2
	NtDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQAA2rpWfWRkAACsy

nv50_audio_component_bind() creates a stateless device link from the HDA
device to the GPU. Component unbind clears the audio component pointers
but never removes that link. Stateless links are reference counted and
must be explicitly released by their caller, so repeated component binds
retain a link reference on every cycle.

Remove the link after disconnecting the audio component in unbind. This
also covers a later failure of the HDA component master's bind callback.

Fixes: 742db30c4ee6 ("drm/nouveau: Add HD-audio component notifier support")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93db6..bcfddb7008ac 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -672,6 +672,8 @@ nv50_audio_component_unbind(struct device *kdev, struct device *hda_kdev,
 	acomp->ops = NULL;
 	acomp->dev = NULL;
 	drm_modeset_unlock_all(drm->dev);
+
+	device_link_remove(hda_kdev, kdev);
 }
 
 static const struct component_ops nv50_audio_component_bind_ops = {
-- 
2.34.1

