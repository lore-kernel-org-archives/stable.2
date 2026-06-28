Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98B137923;
	Sun, 28 Jun 2026 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646231; cv=none; b=kUb+aZi5k8O0rYiIiRgynnZ4ovK+GRMenagRrk+YkF3S+p4Hmks7Vq5vKbk1j+u8xjyebKc05uReSZ/b1y62HXl8YTJm1wASulzOaMS+AmjKAUBMsoCLxguUCtqvztNmTQ+Al7x49SuGk+9Mmg4taGOJow2fVVVtvXmBAWKOTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646231; c=relaxed/simple;
	bh=uHU7G93ZeTP463mDGKDJ0VK/1OIh5vowx2a03o6XNvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cc0rSJMu4fakMtb6bbuySPFsISypNC/iVkG/7o0BkOiBD2eogfbfcsodaHrCdAoXuAia6UbjVdpFZq8mKCRRUhe2RtOrn+TOt3NJ7T/a10W3voAWA9QFdlGivgyl7XSzR2/lUh+gdoVSaXEVOZODHOYfiAHosKD5g7K+YGwUfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowACX7hHNBUFqhG3CFQ--.47413S2;
	Sun, 28 Jun 2026 19:30:22 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: dri-devel@lists.freedesktop.org
Cc: ogabbay@kernel.org,
	koby.elbaz@intel.com,
	konstantin.sinyuk@intel.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v2] accel/habanalabs: fix kref underflow in hl_cs_signal_sob_wraparound_handler
Date: Sun, 28 Jun 2026 19:30:20 +0800
Message-Id: <20260628113020.43942-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX7hHNBUFqhG3CFQ--.47413S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr17Zr1DWw1fWF1UKFW3ZFb_yoW8Xw17pa
	s8GF4rJF9rXr9rAFnrCw4UZFyrGa9xKr9rKa1xG395urn8G34xJryYk3WF9rWj9rs3XF48
	XF9Fqr4UC3W8A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ2fUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAMA2pAiorLTQAAsv

When other_sob->need_reset is true and encaps_sig is false,
hw_sob_put(other_sob) decrements the kref to 0, but the matching
hw_sob_get(other_sob) is skipped because it is inside the encaps_sig
block. The function returns other_sob with kref=0, causing a subsequent
kref_put to underflow. Fix by adding hw_sob_get(other_sob) in the else
branch.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: dadf17abb724 ("habanalabs: add support for encapsulated signals reservation")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Correct Fixes hash based on reviewer feedback
---
---
 drivers/accel/habanalabs/common/command_submission.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index ba4257bda77b..675301dfc0ef 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -1860,11 +1860,10 @@ int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 		if (other_sob->need_reset)
 			hw_sob_put(other_sob);
 
-		if (encaps_sig) {
+		if (encaps_sig)
 			/* set reset indication for the sob */
 			sob->need_reset = true;
-			hw_sob_get(other_sob);
-		}
+		hw_sob_get(other_sob);
 
 		dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
 				prop->curr_sob_offset, q_idx);
-- 
2.39.5 (Apple Git-154)

