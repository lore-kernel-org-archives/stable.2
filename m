Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F229430;
	Sat, 27 Jun 2026 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782532028; cv=none; b=m/a7GBWpZP/2GWDm6LF4Qb/pNbwXT6bDwWRXQgemceO28HyY54tcuioXxol+WOna8z2vQ8YVXwN5Bh4n9BipMsRdD5rmqwZRJ8jOGNe2rVnAznEaC3XoRByk5aFo7LLQY8VhO2kGsxhO6VMkPW1gUZ8eCPkeXJHLYQcgw+a1q5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782532028; c=relaxed/simple;
	bh=gQ0RbR3FGcTCoRtoAbCoSzf2mGy8bhuwekFxLlzuB+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okdImaMGSz9m6+v0C0V9XNn4vmyqpEK73rLMRIIAzUsP01h6nTfQidqyOcnrebwZkGzUhU8KwKuFuPJsLhOmuVRkRQ2rJ4erLXgVjFHN2XDY4R7sLn33pPTKZa7GLMEOFSH56oC2wehtybVFdfRgGIzFwXi+afx5OKye4vK40cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAD3mtOeRz9qhH+BAw--.22948S2;
	Sat, 27 Jun 2026 11:46:39 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: net/batman-adv: batadv_interface_kill_vid: extra batadv_meshif_vlan_put after destroy
Date: Sat, 27 Jun 2026 11:46:36 +0800
Message-Id: <20260627034636.59693-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3mtOeRz9qhH+BAw--.22948S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1rGr4xXw4fGrW3uryfJFb_yoWkKrc_Wr
	n7ua4kGa4I9F4v93W8ZrW3Arn7KFs7Xwn7Z397Kry7t3WjvFZ5ZrZ7X3Z8C3yxur4kAw1U
	Gr12vF1Fyw1rWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5dgADUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgILA2o-DDp59AAAsi

In batadv_interface_kill_vid(), batadv_meshif_vlan_get() acquires a
reference on the vlan object. batadv_meshif_destroy_vlan() internally
calls batadv_meshif_vlan_put() which balances that reference. However, an
additional batadv_meshif_vlan_put(vlan) is called after
batadv_meshif_destroy_vlan(), causing a refcount underflow and potential
use-after-free of the vlan object.

Remove the extra batadv_meshif_vlan_put(vlan) call.

Cc: stable@vger.kernel.org
Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute framework")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/batman-adv/mesh-interface.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e7aa45bc6b7a..cc974f243200 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -691,9 +691,6 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 
 	batadv_meshif_destroy_vlan(bat_priv, vlan);
 
-	/* finally free the vlan object */
-	batadv_meshif_vlan_put(vlan);
-
 	return 0;
 }
 
-- 
2.39.5 (Apple Git-154)

