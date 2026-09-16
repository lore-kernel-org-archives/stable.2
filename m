Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB04457DF;
	Wed, 16 Sep 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544586; cv=none; b=Wmd4o45jn+KASopYvXQOpETMRKde8I8xJcIgzsNiwBWmmHIo9M5zCqaX24gElgO/9JG68xQZEoAFYwB7GeM5XmTXJe2OCQgLQl+fH//F0Fis6is9Hl9Z5QaZq9ihH1ea+Jj70Y3QQIhbew3dy8FHY1VguiHcG/0rqWfF8z28/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544586; c=relaxed/simple;
	bh=q+eCkQXgLVxQ/U+wIVeeF1Wbo055P4AxAd9+1jYkPqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xef05K6npyRmNygb+jtFrehIkqcYKQh0NjITSqFAhNSo3VgqHt40XtFGlIJ3ovEhVlVjfm/7GTbrFOzLUsSO2nPYt1Sd2M/ClMs7ssEgRcCK4Kak1XDMPUPnLqtJlZB/Z1YPLqEa1LCyWYyIkzcjNbRBkMTnF3f1w622/BPgEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnqjh0SKpqqELfBw--.41180S2;
	Wed, 16 Sep 2026 15:42:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Felix.Kuehling@amd.com
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	david.yatsin@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rajneesh.bhardwaj@amd.com,
	simona@ffwll.ch,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Fix file reference leak in criu_restore_devices()
Date: Wed, 16 Sep 2026 07:42:16 +0000
Message-Id: <20260916074216.1973191-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnqjh0SKpqqELfBw--.41180S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW8tw1UAF4xZr45tryrJFb_yoWDJwb_G3
	yUXr9xXry2kF4vqr1F9r4FvrWIyw4UurWkXw48ta1FyFyUZF9rW34Ygr95XF1UJanruFn8
	X3s5ur1rAwnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUogAwDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2qqP4cnwQAAsK

In criu_restore_devices(), drm_file is obtained using fget(drm_fd). If
pdd->drm_file is already set, the function returns -EINVAL without
releasing the acquired reference via fput(drm_file), leading to a file
reference count leak.

Fix this by adding fput(drm_file) before returning -EINVAL.

Fixes: bef153b70c6e ("drm/amdkfd: CRIU implement gpu_id remapping")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 03b266b26738..5453fa4ce4fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2311,6 +2311,7 @@ static int criu_restore_devices(struct kfd_process *p,
 		}
 
 		if (pdd->drm_file) {
+			fput(drm_file);
 			ret = -EINVAL;
 			goto exit;
 		}
-- 
2.34.1

