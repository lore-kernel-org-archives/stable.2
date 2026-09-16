Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75224A5C54;
	Wed, 16 Sep 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581877; cv=none; b=k+ihLuNsN/OcV5LxA9eWWPXWzzvBximkTjPIu+8JjQEUDczTjyhY1ThOKTb9t2zh7zG/TpOjCl+LMv9gKE/2EUAgd28bVHtevFTAwW05cJD4pnB+n39ba7e69IEfiKeV6hjI0nUG0elBXU21WYDysZ8KroQM3kLousgUTXii5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581877; c=relaxed/simple;
	bh=UYVatwPhaaZzmJ0gN+14a8hCOhGpAl47qbblEekEsuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JRvLxFi49nbrBU+NLIKlRNzpAbvkw1fqKXF7DL/EXY0oFJhSkKDNzlFFvQ0R1pU6N7eqD7KYWKS/IT7CgaxtmFWz5flAAaVGAB6go+6BWjDjC6FoxLxE8XfPjz2hnCsrK6OHS+TVjYaveb5eJUzH1eG29HlCN1l6Ye9i8Y0x7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3pkAa2qpqgSRvCA--.23709S2;
	Thu, 17 Sep 2026 02:04:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: bskeggs@redhat.com,
	dakr@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	nouveau@lists.freedesktop.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix runtime PM leak in nouveau_connector_detect()
Date: Wed, 16 Sep 2026 18:03:42 +0000
Message-Id: <20260916180342.2090360-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3pkAa2qpqgSRvCA--.23709S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trykXr1UGw4kGF1DurW3Jrb_yoW8Jw1kpF
	ZrKFWSyrWkJw4rK3WvyF18JFy3A3ykJFW5Gasaq34Uuw1rAr1Uuw48Aw1qqFyjyr95G3yY
	y3ZFq39Iqa15C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr
	0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1VHq7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2qqozV6OgAAsF

If nvif_outp_edid_get() fails, nouveau_connector_detect() returns
early without dropping the runtime PM reference taken at the start
of the function, keeping the device powered on until the next
successful detect.

Balance the reference on the error path like the other exit paths
do.

Fixes: 0cd7e0718139 ("drm/nouveau/disp: add output method to fetch edid")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cc239492c7f0..4a750d4bf1f4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -600,8 +600,11 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 				new_edid = drm_get_edid(connector, nv_encoder->i2c);
 		} else {
 			ret = nvif_outp_edid_get(&nv_encoder->outp, (u8 **)&new_edid);
-			if (ret < 0)
+			if (ret < 0) {
+				pm_runtime_mark_last_busy(dev->dev);
+				pm_runtime_put_autosuspend(dev->dev);
 				return connector_status_disconnected;
+			}
 		}
 
 		nouveau_connector_set_edid(nv_connector, new_edid);
-- 
2.34.1

