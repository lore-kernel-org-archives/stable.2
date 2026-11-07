Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050215;
	b=AWEtQvvyRrOo8w3qKYV0MDTsZud9b4Q8RcZdQ/RVJvYSNi0AsmtrCeXFvxbOFPzTYgs5
	 ZDKDZ+RO9ZzCFRB8yve6kIwHxMTz4w2q7KMKPijGZVLpZ1Q7mzNekjUcHWYHa6nU5Ipw2
	 0L12syeqqLHcFTg3zQ6sv9EdTP2U/jQkO2t1dR9j1yTQBJn2xCHww/ug+9g4zMCCVHRY2
	 DadfZ3BZi3QUU7Z22zpm850xwTtI2sySwrt8clbPemGOYWvp7uaJ/KF44n3PDCI40kNTZ
	 ERsqMU7d6CvjAeBFTdOc9cHt/G97PP61//js3IpbAEgRrII0SzQBhAM0pPzH8I39scw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=x1Ma7KhAi4Y8FZpTULohN+sGMF3gufgiWdCAEWfzpME=;
	b=Inv5sp89igAcP7aoL/sb8Rdkyu30DWdEouH2rJYmdD4BdfEuMZzS3VVf2ojOwkDXL3Wx
	 +CLKKg3/PgSDqIod77/pj0xCnhyYM0JNAMEvQ4+TMD9NQo6K8SpcwFYg5ZdXQY73V5J2k
	 ueHGbsrPgQBy/dRrcxHHuhGf/1wrnWUvb0c4iUThN8k2uU/Bbwo74oN+I3UOZ4Br2zuHl
	 wlEfflEUDNgD6yXoW3R/EKoShTzQN1fV03amcQGUcujpJELfqeBCW3qgRk8R/umxJy/6U
	 kiLQ2407xspTyHdiYqUVs7TNj15bY/7sn+kd2Zm2b648ywkfB7q4n7t1jLiH+LESEPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MH5EYjOD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MH5EYjOD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECA21F0089F;
	Sat,  7 Nov 2026 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050215;
	bh=x1Ma7KhAi4Y8FZpTULohN+sGMF3gufgiWdCAEWfzpME=;
	h=From:To:Cc:Subject:Date;
	b=MH5EYjODh/kQmMnKffQUh34K80u2Dzj7CwgWvdG90UhfghWknZvga2QCGmZmoMVLy
	 ukSpuE46l/PgI3bdh6ENeLFu0LiA4iUmKaBuhnBJMW7bolFsuSK4s/zZUkF0gUE4Un
	 dA3R4CwpGJQ15atdhkKlWOzbNqXyFDQddlIhm1r3TniUzbHNVGk7u860b4tUPZxK7x
	 myYto10wZ5nAsBwIEYG45K2IwWGxyczhrQ/WsC2oK9Xxx0wJTh5kgLLhgKNXRWcqi4
	 fT4NaC6PhIWLW+QhrNlavQm6ahOf9Q6DrTbPs0WfBT49m19chlzyAzh+qS32d3w1m5
	 EWvT4u+ESjo4g==
From: Sasha Levin <sashal@kernel.org>
To: david@ixit.cz,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:53 -0500
Message-ID: <20261107061653-failed-5.10-b296be1dc008@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b296be1dc008fe3a536341afae01f66bb302e67f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061653-failed-5.10-b296be1dc008@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b296be1dc008fe3a536341afae01f66bb302e67f Mon Sep 17 00:00:00 2001
From: David Heidelberg <david@ixit.cz>
Date: Thu, 3 Sep 2026 16:42:05 +0200
Subject: [PATCH] mfd: wcd934x: set DMA mask on parent to silence "DMA mask not
 set"

The wcd934x MFD parent (a slim_device) never initializes its
dma_mask/coherent_dma_mask. When the DT-aware children pass through
of_dma_configure() this triggers the "DMA mask not set" warning for
each child.

Cc: stable@vger.kernel.org
Fixes: f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
Assisted-by: tencent:hy3
Signed-off-by: David Heidelberg <david@ixit.cz>
Link: https://patch.msgid.link/20260903-wcd-dma-v2-1-189cff560a28@ixit.cz
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/wcd934x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 3c3080e8c8cf7..7bea64fc09562 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2019, Linaro Limited
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -217,6 +218,11 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	struct gpio_desc *reset_gpio;
 	int ret;
 
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set DMA mask\n");
+
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return	-ENOMEM;
-- 
2.53.0




