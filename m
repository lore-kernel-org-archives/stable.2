Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5A3FA5F5;
	Fri, 26 Jun 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488666; cv=none; b=FHnlKlSUx0cHFCieBc+VFzUVoBkjn2qSioOl9UHCb+5D/3uH73O7IPAXLlz+hqgtAYBNNl89GQZyjBmFqjsW53/FjS+kcg5eIpVGn1RDYX+usX26c6mcBelHYR5COWmPucd79MfdDsO1Q3xEqk+I4C218AY3hsdhTNJCSM8+nB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488666; c=relaxed/simple;
	bh=UV7MRLRWeZQE3MXXFxC+v2LQa/PZ7VmWdA9Qq6aMQo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwuoZpqMbCC759Cv7u56oPMnd/AD5n4R3ZPT2OJvKWaFHZTTGhDcZgvXkisahAQ2xQSU2gr3eWddndiNPgBj8sB5gBSJ053hS1OtEwDQ/Ljz2kAJkySU+l0NW1U/D0DLBhhuj1jOx4KaQr6xQy/BI+A8mszNAvKm71gdsjr1IgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowACXMcpUnj5qysBsAw--.16911S2;
	Fri, 26 Jun 2026 23:44:21 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: of: overlay: init_overlay_changeset: fix fragment overlay/target   reference leak on error paths
Date: Fri, 26 Jun 2026 23:44:19 +0800
Message-Id: <20260626154419.53581-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXMcpUnj5qysBsAw--.16911S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWUGrW5tF15Gw45GFyDKFg_yoW8WF1kpr
	W5K3yqqr4rJrsrWa18t3ZrZF4Yv3W5tFWFkF1UZwnY9r9Y9r9xAryUKas8Gr15JFy5XFn0
	qayjyr95XF1UKrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUBT5
	dUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMKA2o+ikU1DAAAsv

In init_overlay_changeset(), when iteration fails (e.g., find_target
  returns NULL), previously stored fragment overlay and target references
  from successful iterations are leaked. The ovcs->count is never set
  before goto err_out, so free_overlay_changeset() cannot clean up.

Set ovcs->count = cnt before jumping to err_out and ensure
  of_overlay_apply() calls free_overlay_changeset() on failure to properly
  release the acquired fragment references.

Cc: stable@vger.kernel.org
Fixes: 24789c5ce5a3 ("of: overlay: detect cases where device tree may become corrupt")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/of/overlay.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c1c5686fc7b1..25521ff7c942 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -804,6 +804,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 			of_node_put(fragment->overlay);
 			ret = -EINVAL;
 			of_node_put(node);
+			ovcs->count = cnt;
 			goto err_out;
 		}
 
@@ -825,6 +826,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 			pr_err("symbols in overlay, but not in live tree\n");
 			ret = -EINVAL;
 			of_node_put(node);
+			ovcs->count = cnt;
 			goto err_out;
 		}
 
@@ -924,8 +926,10 @@ static int of_overlay_apply(struct overlay_changeset *ovcs,
 		goto out;
 
 	ret = init_overlay_changeset(ovcs, base);
-	if (ret)
+	if (ret) {
+		free_overlay_changeset(ovcs);
 		goto out;
+	}
 
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret)
-- 
2.39.5 (Apple Git-154)

