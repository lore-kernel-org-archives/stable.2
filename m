Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046498;
	b=xhV7elsO9f89TKDIOesaaT2GzqmOzMz1jCzGIE2wSVR8ML6MPjiPc67mrAGSAeKpbsA7
	 ENKF3DZZRyoV4M5MrSMPsd58FUVnk+FR/fyaZQGlDYcjXxMsvugh09NCnqWVnuv40WyNs
	 OAg4VfiyWLJex7HzQP8x4pNSBDoemnsfVF58Y3/X6Tl7ky6bxyJRD0IhTvE86VGOlPDV9
	 YoMQOm7Z8oj6QupycRs/s3HYtqPrwYpvT7E7XVjcIN2IKlHZV8aLOUNauXH9yRHos1ORN
	 60YmeTjDNQkmhJ9K1qUAo/QE/571GiTceFHXeDZ9B9otCV4UXRe1LnlErjhW6/UPjRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ilcrID1rOKaTnS9mHNV3EXyU3m6Fi6rJL2J9KgPInd4=;
	b=PkGQe7EmZuyWFoSsF68Sc2Fzpu64I2zz3KZFkQQz/b0NoweA8hoUSqKvlN4rwQi2457O
	 5/SgT0dzWQ5Ri9gD5VArNV9rGfH2YCaVkrZg6FNSSy/Oy1OhCj4jQPZWG3WIGC+0U6duC
	 XH5H0MKZItoFRXSKMGvfhtepNE9tBLHhsFIkBZ5MKOMR+2yKKI2rdJCmTJHQwFzMQ4ke9
	 heLq4RBa9FxbMmmBqAe1ijjeCXQXYIDL7gY9aOIPsWQ1Q883E8gguqrCfL7VEcU66ft/6
	 vaRkhQymTFhEdKOWqSFITFtiMIdoE7cMXVqu+rlW85UxYLoYvJqIGYMN15DyIyfEgOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLlsaoDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLlsaoDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E051F0089F;
	Sat,  7 Nov 2026 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046498;
	bh=ilcrID1rOKaTnS9mHNV3EXyU3m6Fi6rJL2J9KgPInd4=;
	h=From:To:Cc:Subject:Date;
	b=bLlsaoDlhEol7vfEIf4BNhXvvW7uDzfQwdDB1V8BwmzO2H1zR/ZibzpQbd3e17VHH
	 o6bK806nCl0kwLrE3UQn+hIL/pJ5LiXJ0tXQTZ59+bVV4dp4hBvMxQ20AWHgoiNBIC
	 HgnofOYIY1Y50cRgLOKuKmC5EmqUJAOtclNnapUlRjEbcjl7ASHlIxQSE1PAOCy67E
	 xtIdLgiGqzp1Acl9CXBrBGMRXu8TX4WaiZrsfoBL6YfXDer73FHUrTBJh8haJuZ/Cq
	 v0HlQ7ZKpmDceEPhpQueg00fBYxEDwiVBKo6s3UaUpE82C9HX2pFc3XCTsjxcL06z/
	 n7Nn9w9bvW4EQ==
From: Sasha Levin <sashal@kernel.org>
To: zzyy19904204639@163.com,
	vega@nebusec.ai,
	weir@nebusec.ai,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] libceph: initialize CRUSH choose argument weights" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:56 -0500
Message-ID: <20261107051456-failed-6.18-c3a995ff0782@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c3a995ff0782587789333c621e1f6bd5e574371e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051456-failed-6.18-c3a995ff0782@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




