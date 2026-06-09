Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FDA3876D7;
	Tue,  9 Jun 2026 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998923; cv=none; b=gTKvo2Fdc5jrNC1mAH/tVsE67WaVuoT3ZwoVmhWt6+vWWkzTSC2g9m+GmA4ya0GmWrn0vnrwS+Nv5m6U1CKysNY6MGT8egq0eDZl1trC2LxboCj8WXZV2himGI9Ve+D5WoKTY1ytJnQ+x0ClzVVApe9plElRp0Uj0LmJYkx8J9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998923; c=relaxed/simple;
	bh=5FWQZumbg/wDOHEVLVkFkwq3i8H1Vb/GPllnjSEy8G4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LGoCKGUkEOaPPgjK4ulpHzRm4YY5jKbFWSDYLlVrV8zlrN5uzsczDs2F4OiysL7VCjOTgHiU4egLNyNNOOmn75VmhIn5WZeIDE7psEthKRG3h7phAjHC6n831txZumt7wjcUmYs9x088JPyqbV07RdBYaO+VwrUnHk7ILzBO5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3Ov4A4ydqy9DQEg--.477S2;
	Tue, 09 Jun 2026 17:55:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet: fix refcount leak in nvmet_sq_create()
Date: Tue,  9 Jun 2026 09:55:05 +0000
Message-Id: <20260609095505.227496-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Ov4A4ydqy9DQEg--.477S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF15Gr4UWrW5WryDWF4rXwb_yoWkAFbE9w
	1UJrn7GFyruw4DKa47Wr43ZryxKr95Xw1Iyws8trW3tr90gFy3G3sYvr93Gr1fur48Xr15
	C3W7Jrn5C3yS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JURyIUUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcNA2onpvzyXAAAs8

In nvmet_sq_create(), a reference on the ctrl is taken
via kref_get_unless_zero() before calling nvmet_check_sqid().
If nvmet_check_sqid() fails, the function returns the error
directly without releasing the reference, leading to a leak.

Fix this by jumping to the "ctrl_put" label, which already
performs the necessary nvmet_ctrl_put(ctrl). This ensures the
reference is properly released on this error path.

Cc: stable@vger.kernel.org
Fixes: 1eb380caf527 ("nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 62dd59b9aa4f..4477c4d6b1ee 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -944,7 +944,7 @@ u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 
 	status = nvmet_check_sqid(ctrl, sqid, true);
 	if (status != NVME_SC_SUCCESS)
-		return status;
+		goto ctrl_put;
 
 	ret = nvmet_sq_init(sq, cq);
 	if (ret) {
-- 
2.34.1

