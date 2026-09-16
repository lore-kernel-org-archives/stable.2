Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69C4B04AA;
	Wed, 16 Sep 2026 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552799; cv=none; b=rPGfHgcccwxcomz5HBk8ompq/Y7x2QlMz1jZ/O1IJTMkomXMx4A/NWgGW1YalfdqzBskRRkXRNTUG+1gi0/M4mwktX32zAIeEWa4JrSHNljFigeagPjLN27bptj+LD1s/ShEXtcIfgOvR2n0ED1nc+s88Lbrd6TlEspZsL60jEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552799; c=relaxed/simple;
	bh=bCUZmckMRC+IbOpQKapLnYiW09D2StQOYExTx7h2Cws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CbZ1Tif6lTSdTv7k45Ri36wQTknVJeq93x+lmGWyS1MeobXt3Bmx2b7/Kv1B1RNtYDYezu+8ZYKZrhyUuG68RhRxTl1a8NsmfAVCvOUKF7kJd1ajOtoq+nusBhOC18VngITp14CQbGUzqFs+pZrmC4c09ddjWZaDuN3FiX/7Mxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3eTeKaKpqk8jgBw--.43202S2;
	Wed, 16 Sep 2026 17:59:38 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jun.Ma2@amd.com
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	simona@ffwll.ch,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix runtime PM leak in amdgpu_securedisplay_debugfs_write()
Date: Wed, 16 Sep 2026 09:59:10 +0000
Message-Id: <20260916095910.2011628-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3eTeKaKpqk8jgBw--.43202S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UXrWrKF15Cr43Xw15twb_yoW8GF18p3
	yrWF1YyryUZF47t3s8A3W8WF90k3yUXFWfCrZ3Cw1I93W5J3s5JF15Cr4Yqr1xWrW8Ca1x
	tr90v3yxXF1vvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9S14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0JULo7NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2qqQJWgEgAAsq

amdgpu_securedisplay_debugfs_write() resumes the device with
pm_runtime_get_sync() before parsing the debugfs input.  In the
SECUREDISPLAY send ROI CRC case, an invalid user input, i.e. a missing
or out of range phy_id, makes the function return -EINVAL without
calling pm_runtime_put_autosuspend(), leaking the runtime PM reference
and keeping the GPU awake.

Drop the runtime PM reference on the invalid input error path before
returning.

Fixes: 7e39d7ec3588 ("drm/amdgpu: Fix the uninitialized variable warning")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 3739be1b71e0..fdb05f5857d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -137,6 +137,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 	case 2:
 		if (size < 3 || phy_id >= TA_SECUREDISPLAY_MAX_PHY) {
 			dev_err(adev->dev, "Invalid input: %s\n", str);
+			pm_runtime_put_autosuspend(dev->dev);
 			return -EINVAL;
 		}
 		mutex_lock(&psp->securedisplay_context.mutex);
-- 
2.34.1

