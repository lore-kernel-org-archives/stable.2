Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049936;
	b=kx2xorBvhmqj202bCdVsc6cV3Zz43S+FXrypqkH/IrNhQ0xpS+1YTqEa05Q8e5K7+bLs
	 FSaN7ZIZf6q4+jWd5yWmeEf7MJrMWCQXUW4+YcKX6OZJdQMGo86P9JUhhlO+HqSMRQyyS
	 tgSr7REYuP+MsXcZQaIgw6HcS4Rguy95FbCr1mZLttrDIbslizooOxHB18TaaZZHh14JN
	 y+ZbgWvmAP591zP3iy9QROp6dUahlFiJ0eauQ19oLEHHWjdnPs6duTW31Rw0T7fj1ozNU
	 SoBvZHBmbxQr62QR5NCXxg4lXJPIP0tHdjUBNo271NF4zzoPqMBcjPQjqdt3VzWyVVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049936;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NpAAzNpKNGTqQpbPvAhhAPnQYUGZDsq6C1y4wulU/ow=;
	b=tPGb7LBP/xU+YaSvTRcd7O/+gi3WPVsmsBfuJGghrwPIlI2+ta6mXww8+Nt+1AdUqgJH
	 LMgc/cLowSr0UDuy3PXWAk7WWzT8imiIMN8KA/6GMw7odVt4VOYFpxT7nTwdX59zW1Yl9
	 p0k25QtphQx6TAHQFib9vUiqyI3f9OVVsJhP9oRA5WVooD1OZuhvwhjpXbNnmga2YId4p
	 3Iq7fJDLiPo4BCMGSopEyqNKTP8/WRDrcleqE+uXdVTeu0CiJbCYp4IqB1Z0hNtt7NyHY
	 PKrFJiVtSipUyAIlhLpJA5aPlN69x8ZD970b05OoQPH//8j8FNAsV+oQgMJntZ53BVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IC5CYQw8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8454606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IC5CYQw8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055C11F0089F;
	Sat,  7 Nov 2026 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049935;
	bh=NpAAzNpKNGTqQpbPvAhhAPnQYUGZDsq6C1y4wulU/ow=;
	h=From:To:Cc:Subject:Date;
	b=IC5CYQw81kj1wIQjMY7WI1JWObTECbahwtPSYY4zXU1OIMSgOwl/6p6ECJ0eLjIcQ
	 BIyXgapM4CF3DfPTaHsZekQSu4GsFFkafgWt0H1bnHAnKPQrxB35FZ9QDDUJDt7A+V
	 Gp5svSZ0m7IGR8WW88PH16+ugsqbbwDwFc/OForXvZpYn7jjGh2VEPDGASnkOGLtyE
	 C70O9DjfAzm2Vqf9NeLYNfjE/gcxKr+jszvm3HY+msoXW769j4dsTAcXgwSfztvOhJ
	 O6kZbSKCB2AlaWCDmnp5pz9BIiPvwUMItwzGltfq5Op6LUKKU42osi4uqnM1QA30Z7
	 0c9Xj6+Eg9aRA==
From: Sasha Levin <sashal@kernel.org>
To: zzyy19904204639@163.com,
	vega@nebusec.ai,
	weir@nebusec.ai,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] libceph: initialize CRUSH choose argument weights" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:13 -0500
Message-ID: <20261107061213-failed-5.15-c3a995ff0782@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c3a995ff0782587789333c621e1f6bd5e574371e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061213-failed-5.15-c3a995ff0782@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




