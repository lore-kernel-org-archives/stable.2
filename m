Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788402;
	b=dL23vLTnd0qQd8DFnaHrBSiR8X4LigPeZHx5Dt+2ImZC1Xtpatn74p6vBh49kPeVWn7+
	 HSiJOVCq51+NPbKVfkCFj2IBLrbRcjqXreLQErKL5cCVzuPcZWZ/XZEiyNRpYh9ciFuwW
	 sm9PRZX82OkoM21tZ+zG/yhEnzcJZ0sARAB2/Yfw9eqN+L5ZomrEv24etDUtrwlz/qq6r
	 OV6dr3Ya+lE0z6X66ALFG09rWMbu8UiBzKdGaNkgU2TIhK6nrLzKDF3RD8BXP9O1kIa+c
	 RP5D1UE6vnqaKi0mfCDFGWMyxqjQFkHZUQF2F+kx0LKFBMLkGeBSWotHzqSbNtw4AQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lEUdpCgYKRIjX6P3P4jjDUzJHQiGUBHPh97SAeo4M7M=;
	b=x9lV7RYzNVmYbAv2qN3LmAvIAG68ikkToqjuy70MMS1dAuEkY3WwEjJVx/xvQdUfLxLL
	 uXHVfG0oZ4bYfbPDZ/iLiw97+IZFI+DP5khXdZRpl1NrMnkLvIsNbzCTI6Tbh5ZBP0scW
	 DZgeDrf72exdt5gvG+/YMZ9gy8LFxpi02eiW3w/S8nA2cXuRXVhO/7QMdeA43kUVtiJbW
	 f/Ea/9lck5+B6xP+qn1CkytOQ3+eKqOvMQmtyGPCAfgHFtcbOXsJvkDMWd0d0YQ/T66mM
	 7R2ccq7Ba95HzPSlSMN3uGNumyxoWMSNQRIUjhnmWmqXEvWl85xQCdNp4/a1gM4DcwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhJANjTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21232606A32D;
	Fri, 27 Nov 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhJANjTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A5B1F00899;
	Fri, 27 Nov 2026 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788401;
	bh=lEUdpCgYKRIjX6P3P4jjDUzJHQiGUBHPh97SAeo4M7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fhJANjTSb+fu3Z73pMqr1nzD7u3HmmWTI40B3AJC4pgJzDBVgAG1jp6z3gtMEQOAg
	 cIoFn9weke4AuFiY8RxTnf+lJS3+Z7c4rvOGVU/S/6uQ6wgV0AlsbJRYeKMjckw01i
	 5ureQdnfD+HzaXfUiYIBDanGpKtH/H9E4WBqkmNKiHI94ruQboNS25WRLbEffH3GAB
	 RBBu1lqEBLsd/1MQqtn70gxMxsTx8VJkaS02/A7ahbz4LIpig+E9HBeM76dE0zQAXa
	 0CteMqdug0w5/VhNt+dlJQ+V6ZCiAe4WloYsD8HFFh96W6sNTgywWYbRR57e3UGHaf
	 Z/MtuFUfnLOug==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 05/12] pinctrl: nuvoton: ma35: Avoid leaking map when parent node is missing
Date: Fri, 27 Nov 2026 14:04:53 +0000
Message-ID: <20261127140602.2790001-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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

Commit 3fd976afe974 ("pinctrl: nuvoton: fix a double free in
ma35_pinctrl_dt_node_to_map_func()") switched new_map from
devm_kcalloc() to unmanaged kcalloc() without freeing new_map on the
!parent error path.  Because pinctrl_dt_to_map() does not invoke
dt_free_map() when dt_node_to_map() returns an error, new_map is leaked
if of_get_parent() returns NULL.

Look up the parent node before allocating new_map, and release the
parent node reference if the allocation fails.

Fixes: 3fd976afe974 ("pinctrl: nuvoton: fix a double free in ma35_pinctrl_dt_node_to_map_func()")
Closes: https://sashiko.dev/#/bug/linux-ae0c2737-0408-4808-9bae-f7389beb51d0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index b6411fc4d98b..c20350bc1cdb 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -202,17 +202,19 @@ static int ma35_pinctrl_dt_node_to_map_func(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 	}
 
+	parent = of_get_parent(np);
+	if (!parent)
+		return -EINVAL;
+
 	map_num += grp->grp.npins;
 	new_map = kzalloc_objs(*new_map, map_num);
-	if (!new_map)
+	if (!new_map) {
+		of_node_put(parent);
 		return -ENOMEM;
+	}
 
 	*map = new_map;
 	*num_maps = map_num;
-	/* create mux map */
-	parent = of_get_parent(np);
-	if (!parent)
-		return -EINVAL;
 
 	setting = grp->data;
 
-- 
2.56.1.839.g22a8290db9-goog

