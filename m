Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450729;
	b=3i2QnSZ6mfGFA8TLU3LtweP5LVC0WOBZkY0EKB+XLfyebBriSxv0xtKTzCprif2QjrJT
	 cV0oMBm8UmTke5wCb1XhGwQMfv+OGWy9cBWNxvUERQ6I1p8oK2cT6y1CfB4zZ4Ly7y7JL
	 7P+0qfpzmC6KS8/E3kwpvGcu5oTzhVSITO3sJqH3yd3H/POuwFgvhYFOsWJBo5OWaGOcp
	 orYWENoUxVCKMo6BWKw6fxnYyH2jV2YLSAY+4aZvYreH0pgYbM2Rx7HbQTj+hrnw5etzx
	 FbRHyf91/Y0t4j4a/+kULJd/3p//yunpETXUOAc4Zj2quieEXOvwH+yxKFKDpMx3kbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450729;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i/f1+warxd7XIjjAXYyltlpTjpNK2mQUr+Pi9PIa3ZM=;
	b=cwJfzp7vFN+A30tHyz7AETw+93mKEoSShOLmZxEi9WOmjK1Jhg+eEMlQclitB1a8dWRp
	 mDGWKgFDuFYx0KJX5c87cxX7jkT3z6AcU5AgBcpYgsyWFPUQ3iBgM5sN84IVq0rJER5iK
	 jsd48H1g5I9J4nqbUe6+L+q8Hu23sCNQmAnDNE6fBtg84y0yPMxYgXATDllnz7/x6mneh
	 uHC/73uqXt8vn0iKB2FAhx31zgpuZXk+szXrSGDyqsEVC4mG7k1e68SRq2kLBxI+ErA7l
	 vOqKYjoEly7bl9+7oC0ZE1/8HQuTU00fjl4Peae2rtMm3261QUWSONaXkdG9C+7O/Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=am3cCBvM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78526606A334
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=am3cCBvM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932AD1F00A06;
	Thu, 12 Nov 2026 02:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450729;
	bh=i/f1+warxd7XIjjAXYyltlpTjpNK2mQUr+Pi9PIa3ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=am3cCBvMNrvvEQpZMJPdC/celAw/12w9mtB0Yxghm4SVp40ch7+ju3Irpkez0ckhN
	 dskJRQlBznzhPP6HJqOCBJw1ZWOpSQ0dw+Ovrp3UAUYOziDl+qIwq18/Jis7bZfBey
	 O1hmsIQcbZYcXJVjXcSZURiuyB2tblq/g47wN0upZdplP6oXGfrPNC01I/3AXYHyVZ
	 GXNR1IIErvw0rTWNQXuRAkQZM2troCvpBfOxUKtFLxEY3za3fv5rOynCnSjfHLQv0U
	 eVHESWqa6UuM4R2zAupmqm+g7UJ3lG6Nf5tduUc1L2JUnatWhPYc2nUTnE1aRgjKZw
	 QbiQGsoalQHbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Darong Lu <zzyy19904204639@163.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] libceph: initialize CRUSH choose argument weights
Date: Wed, 11 Nov 2026 21:32:07 -0500
Message-ID: <20261112023143.1393659-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062915-failed-5.10-c3a995ff0782@kernel.org>
References: <20261107062915-failed-5.10-c3a995ff0782@kernel.org>
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

From: Darong Lu <zzyy19904204639@163.com>

[ Upstream commit c3a995ff0782587789333c621e1f6bd5e574371e ]

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
[ sashal: used kcalloc() with an explicit element size instead of kzalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 2a3ab4ef39c28..d180863865166 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -304,7 +304,7 @@ static int decode_choose_arg(void **p, void *end, struct crush_choose_arg *arg)
 	if (arg->weight_set_size) {
 		u32 i;
 
-		arg->weight_set = kmalloc_array(arg->weight_set_size,
+		arg->weight_set = kcalloc(arg->weight_set_size,
 						sizeof(*arg->weight_set),
 						GFP_NOIO);
 		if (!arg->weight_set)
-- 
2.53.0

