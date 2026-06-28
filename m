Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EFE244687;
	Sun, 28 Jun 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782657176; cv=none; b=MK3eEgrzXoe+EgP+pYlDW5nIlklzLwUF4olk9RLfZAB8WkBXW7PkHpknr5EoZ2Ah9NrREaX52GCZMMnw/kPkwgvxaY8R02N2gn7Cf+O8ABpmBqrDuZQ4PbGoUOHLk1CfWVnxORaE0Gciy8R6KEl2wfSMroBXfSrkycFzK5G+1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782657176; c=relaxed/simple;
	bh=ng0GOcLEnHFbDT3OfQk0+sAZd7OVa2Mz5SPJUFWo4ts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDz6C5DOHtWEvdyEYEoPRd86Kxl4RguHABl+ATb0uoKXjh7uM3RH3v3qXGYgSCmqy1llnOuZVtyOHE1CG5PF7d5slKNaO9p3pfbfR4ghEQeY9f8xYYTuFuF7KozE4e8qO6f7Xq8lfilwF2XorMGJoMfXZypE2HViWEAXXkenEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowABn8QSKMEFq8JXIFQ--.34453S2;
	Sun, 28 Jun 2026 22:32:45 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: lyude@redhat.com,
	dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/nouveau: fix GEM refcount leak in validate_init error paths
Date: Sun, 28 Jun 2026 22:28:21 +0800
Message-Id: <20260628142821.47290-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn8QSKMEFq8JXIFQ--.34453S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw43XFyUGF4kJw1UWrWfKrg_yoW8XrWrpF
	ZxKr1jvrWUta17Krs2yF1DA3WS9a1vgFWxGFySy34Sgr1rJFy7Xry5Gw15XrWSyF4xC3yY
	qwnrtas2qFyYy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ2fUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2pBLUUEtwAAs-

drm_gem_object_lookup acquires a GEM object reference at the start of
each loop iteration. Two break paths (ttm_bo_reserve failure non-EDEADLK
and "vma not found") exit the loop without adding the gem to any cleanup
list and without calling drm_gem_object_put, causing a GEM object
reference leak.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 9242829a87e9 ("drm/nouveau: Keep only a single list for validation.")
Fixes: 19ca10d82e33 ("drm/nouveau/gem: lookup VMAs for buffers referenced by pushbuf ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 20dba02d6175..c654256f4081 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -513,6 +513,7 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 			if (unlikely(ret)) {
 				if (ret != -ERESTARTSYS)
 					NV_PRINTK(err, cli, "fail reserve\n");
+				drm_gem_object_put(gem);
 				break;
 			}
 		}
@@ -523,6 +524,7 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 			if (!vma) {
 				NV_PRINTK(err, cli, "vma not found!\n");
 				ret = -EINVAL;
+				drm_gem_object_put(gem);
 				break;
 			}
 
-- 
2.39.5 (Apple Git-154)

