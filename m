Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045787;
	b=eZvE95mVc2JynwSDtGqnUHLaTkMLQtq8ltLAZmIfqgAZW5feL75iEVZ5Zz2eCGmemiOP
	 hudFFr1BJQVwungekpasyCvirgC/vHjf1d/AFJ4OnuiDBIYXMUkl1zBRpn5zfbPe9PSH5
	 sb5sdvRNVSwMwEc31aa3IkZf/CtLr7MA/r/L+ySTCaT1Ebt09SMr9bktV8iNOIZ7N/Xgx
	 6V4ZHKVquAJgqJGLZRa9LAo9h/zeCBQRd3Lz8ulPOUvAbNWsaRyHPkJgU4BgWm0D4FDzh
	 1wG9TbD3dP2e+lR1QzYTP/S9hMOhxuwwRsmvewwa1fp2RES4X1BMJI+wYJ21GlntKOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045787;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4+q7kprI3OqUpH3xhSiABpKNCA6VQjJDxhoeYmPfzg8=;
	b=ZX4QmVpREtifFySYn972FMpRGCOAdY2O0thCynFPOeU0ZoDxiRNOdw4KmHMe2l46l0Eh
	 4bawhgeYJIJiXoLHD8L89VyL3bNsld2egWke8NevvNMBm2RxZHHhRFs3JNJ26M3gJx2ie
	 2ci5XYGOIyPLmhOX1o6hLzAOJgSOKxdkkTEVGr2MmhcGNChDuoKCvQbHHkUcpV8OAKhsM
	 Yi/oJTPCQ6VFxKIudFP4smjMZ2EZoQrdcvUKiHnXk7W4ShNQ9VmOVYL/YCQsyFBP7Sqqv
	 bx1uPjcYtVu3ElcHcBhJz5H+E8Okep5EjPABoDlDGIRi9EmBe/6unbmLJPOTHxVKNFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMuId2m8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209F606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMuId2m8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441011F008A1;
	Sat,  7 Nov 2026 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045786;
	bh=4+q7kprI3OqUpH3xhSiABpKNCA6VQjJDxhoeYmPfzg8=;
	h=From:To:Cc:Subject:Date;
	b=GMuId2m8WCPpfO5Lvwl7iUtA/YzjiV2gRIuGUBrOtwykPwKEYabXLvE0kjWhNnqTL
	 sLUnXmd6gIKq2pPz/jj4G/ihZy9XbVgA44tfHttOBk9j3At+xoXrjM9bsfYNaakMTQ
	 LKYQny9IakwVH8WGe5AKPOtb9SYaRMMJM+PaSzyla0WGUzt5fAHu8YDo98p1Fm6BxD
	 rd4toIYtilbOVpR4PpaRPYs6Ez4+c6AJdSDKfnHf4qU32qR/Re3klpxgZAqMkJsOHA
	 d6aIqhXXnx9gf6gGcBreh4fAYuPAjVd4MWDJjKBJtwXlamtfVsQgVVKAa5yaK7wkUf
	 MCZh8E/GKXfRQ==
From: Sasha Levin <sashal@kernel.org>
To: blum@kernel.org,
	thorsten.blum@linux.dev,
	andi.shyti@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915: Fix memory leak in query_perf_config_list()" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:05 -0500
Message-ID: <20261107050305-failed-7.3-9977e9d84f46@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 9977e9d84f46d4f12ad35fbbc0ec4638554bce87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050305-failed-7.3-9977e9d84f46@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9977e9d84f46d4f12ad35fbbc0ec4638554bce87 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Sun, 23 Aug 2026 22:50:28 +0200
Subject: [PATCH] drm/i915: Fix memory leak in query_perf_config_list()

When krealloc() fails, free the original oa_config_ids before returning
to avoid a memory leak.

Fixes: 4f6ccc74a85c ("drm/i915: add support for perf configuration queries")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Cc: <stable@vger.kernel.org> # v5.5+
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patch.msgid.link/20260823205028.178597-2-thorsten.blum@linux.dev
---
 drivers/gpu/drm/i915/i915_query.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
index 0c55fb6e9727d..11157fb14db31 100644
--- a/drivers/gpu/drm/i915/i915_query.c
+++ b/drivers/gpu/drm/i915/i915_query.c
@@ -403,8 +403,10 @@ static int query_perf_config_list(struct drm_i915_private *i915,
 		ids = krealloc(oa_config_ids,
 			       n_configs * sizeof(*oa_config_ids),
 			       GFP_KERNEL);
-		if (!ids)
+		if (!ids) {
+			kfree(oa_config_ids);
 			return -ENOMEM;
+		}
 
 		alloc = fetch_and_zero(&n_configs);
 
-- 
2.53.0




