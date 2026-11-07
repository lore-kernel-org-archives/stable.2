Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048919;
	b=I9HK7UzULl/b9uokNInNcUIee1VfpyJUg4bMGqn+7K4ADkWwD/XeB/H4g8Az+Kcm6RYO
	 LXeTR/+HlVlAYhJSQzYkpBFUvbJ5BMZRxfdf0LlZM4W6bzashzxjQRM7jYLY/9S02k+GT
	 rQSUZB7NMN39vlSWxVSVtusrINfybV8m/nJFtgsVni1EKsFyxzcycrC6XEhGcFTuihnfr
	 kud/UDmEQ6RpifuBlLxP6OibHYaVRY+XzccbDXfd8wVj5yxC+GO/NUozcxdZ/IbMzvkO/
	 gtivSYaGdP7a4ZHa4bcyHm5Q68ClykKfuHxPghqe4XpPWOVjsudZ16dDsZtRtebeyvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JTbT1HADuppVPmZAc2jQh3Bv/WtRtzHWpYqvQCFlaPE=;
	b=kGjiW4oc5pKUlk90aZxUjMY0WnuTQPu5iN1WzPQVuGfA1LZmFxOHYaDRuyPY65bLDKHw
	 eFQsUAXiCx6bSa1u70RmV9U9c8cHBlI5lnHNLcekHWBsiDmm4XxFtyhuPqUBlsv0keIZj
	 4z/z9DP/RBGQ6j08P8bhiSkctyv3YcrQtP9QEndveipgwLj16V4vZkMEEWovI/179+Kq+
	 tTaVQEvzOozHUxkEvaUiT1GVy41lAkEAsIbUTNIMFiJKTOxxhmyPHChIt7Xw0xUTH5G/n
	 jEVuJsu3YFelLIe+UR5T+dS10nQSWuH65xRF8rmGmEk6QinA1HCzGdgs4C3lG87x+7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzsemrxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F2606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzsemrxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C471F0089F;
	Sat,  7 Nov 2026 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048918;
	bh=JTbT1HADuppVPmZAc2jQh3Bv/WtRtzHWpYqvQCFlaPE=;
	h=From:To:Cc:Subject:Date;
	b=dzsemrxH0W3iYceXgn+5kYTnb9QKvdT9OnLvKac7Lt06R1McEwjuWuFHzL9EBsNTq
	 ICk5nogSw0Atmnel3CUv6KsmoQ3icoOzs3Yo7LiSTv7yacumhF3ZpPN/cof/5gv5oC
	 0SIEXhV8aqIq4PaHt9K67xQjUCSH1boXpJiKSHveuIGdwIPjWDhJ/xWX13cGR+ZpYU
	 M51XSQlJHZJDQycIfMzqeKcARbNmtTdkxNnLukv+wxt3OiiV6QG47cx1Ag5/36X9zR
	 b+dFM2+u2leDR8W7QDW3sT6z6x4aSix1BuMJCZ4eGCX1yEgQtG5ErHrWB/dI23AZ1F
	 aPdGqCtn1D0RQ==
From: Sasha Levin <sashal@kernel.org>
To: zzyy19904204639@163.com,
	vega@nebusec.ai,
	weir@nebusec.ai,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] libceph: initialize CRUSH choose argument weights" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:16 -0500
Message-ID: <20261107055516-failed-6.1-c3a995ff0782@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c3a995ff0782587789333c621e1f6bd5e574371e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055516-failed-6.1-c3a995ff0782@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c3a995ff0782587789333c621e1f6bd5e574371e Mon Sep 17 00:00:00 2001
From: Darong Lu <zzyy19904204639@163.com>
Date: Mon, 28 Sep 2026 01:44:22 +0800
Subject: [PATCH] libceph: initialize CRUSH choose argument weights

Initialize the CRUSH choose argument weight-set array before decoding so
entries start in a defined state while the decoder fills them.

Cc: stable@vger.kernel.org
Fixes: 5cf9c4a9959b ("libceph, crush: per-pool crush_choose_arg_map for crush_do_rule()")
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Darong Lu <zzyy19904204639@163.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 7d65a81148166..e69a2249ddfbf 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -319,7 +319,7 @@ static int decode_choose_arg(void **p, void *end, struct crush_choose_arg *arg)
 	if (arg->weight_set_size) {
 		u32 i;
 
-		arg->weight_set = kmalloc_objs(*arg->weight_set,
+		arg->weight_set = kzalloc_objs(*arg->weight_set,
 					       arg->weight_set_size, GFP_NOIO);
 		if (!arg->weight_set)
 			return -ENOMEM;
-- 
2.53.0




