Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792861464;
	b=F7cp6OI/hzEFhSJeqmsP7Xa7EKQT5HO6oQ+BQ5mWu8xSMIHrZ4z7NGrWs7PA7Jv5nHWk
	 QtQHnFW5hZXEeu2grZStP3itwY6zWkQsrhv7wzcpCNAPNv+ljftNjGCorOXm9FAFHwfjE
	 dI0yOWvN3BYhiui6cSrcmjNPDsvcz5lWJGXi31BmXFSfkQg+jzb0QUQGHcRY6IZht5+HC
	 C+Kfz75LPRv2xQrUiGEp1y9IOE6gWM6jWWM2QwuOerersDi4LiGQiMm5YVJU1qECAB2W9
	 wsIzddeXZZagbrwzamOJHyuMckqSFX+PnYDRvyrd9bm2Zl4A3jZ4DitNAH7ovJBCspQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792861464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=liL9s3OOZysVhjqCpf+L1Cp9m5KqZk+Ut2WGL7E2egU=;
	b=28ZkI+XDURVyaAUgAfd3wZydMN1ye4aAQgDOhvBdwHK7E/CtktOGlShmLDj/4y0IiYRh
	 1Xq1x6iaokZQU73oFdgWlxT4h3Dvi3SrXZYLp/4MTvqNmel4Qb0lwICoYad1Qx3mueCtQ
	 DJZPzpISLj2z3PLqOz2LDdLS7W8lQhZtsBrpeSj3gq5lEMOosirYENfq3l5FycsMilcyz
	 ZFE0h1e8NhnQtO3ApsoUnzT/InWZXbzXW1pbjA+MqXZG5TvEioERGmCmmGzI7TtyE7Gg+
	 WJjOhjj8dD5D4MynUsCSCyYSDa7AbrASW5FELvIDK6Vi3kKzR7/3ZCoj37C1qapdr1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=hjlJwtbm;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F310606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 17:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F310606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=hjlJwtbm
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-537548b811aso8266041cf.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792861462; x=1793466262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=liL9s3OOZysVhjqCpf+L1Cp9m5KqZk+Ut2WGL7E2egU=;
        b=hjlJwtbmHchJtyzdan970kA17Un7oxYq8/9Noasmq9qAybX7aCdsF+FsDf1Vyn2kXY
         kYOEtsTrZYiO1npfi4vA9wMVYnb3LiFTvCt0jayupi1vdjSGU7pVFMm+Q2p5XXxqPkv0
         6I5p82Ly5zpcJKX4lqhrZ0APv64wiDrPF/OuiX5NaAou6NuArSAUfd96+/T8CW5GwGb1
         8oh17dK/3RE1hhLFwabbXNafAi53bs6ZFrN2rG98mtvPzevsmWzOySVRBcL6A3Ug9AT0
         sZK4p2skd7a0GQahbcCHxG+obdjFbWb28QXvhjS3Dc/hG3mZgp+hf3xIuS+NHrcDUrZu
         /LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792861462; x=1793466262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=liL9s3OOZysVhjqCpf+L1Cp9m5KqZk+Ut2WGL7E2egU=;
        b=SJhrywjk/0K6/bZu5GdPcJSvy8/S+wRarEZclVQ02z1PD2hFDn8rl72z/UuVo0YryO
         kgG3VAOiRkA+Q/TA7NT2cY7qLywleeAuRfZI7qlm3Q7MiiBpozJ87MhryfPgmDGSIVN6
         PTNAVdLnhe95a8Ga7Rl+zGb5rvXm1vnZ4THIKOqOufvQvQrVsbAS8yQQeHq+fJcnFINW
         fvcSwSvQc3ckyugVt7/MA9jwlImLbnYJZU+j2LXbT9DdYKsdxzMuaFh9zPVGX9JeiinX
         0/Hp76y9VgfqFfgPQrYUjfbTPyTwBgFozB0FVEPYmwMVbt4q09PVWGLVYXiZxnfjiglW
         Uhyw==
X-Forwarded-Encrypted: i=1; AKwUvBxSShERyoRJT5IOnrUtAr6fMv5BvlRzn1IApjG3DDyr4pFeHyADSIj1LpaoS6Z/AnZQiAgQJUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAneq6wzEJuICQBrpRrIRgKaTUayolnOx50k0SKspGidreKgC+
	MClRYMsVKCXx2dyH0xXgp0iF3aAAFJWmIY+g7I7C6ibrS+Caw9sJ/vAdTxvv8gtn5Ck=
X-Gm-Gg: AYBFou1EHaeuc4/9RaBuaOtRPXig9pi+kKtcqO9dx7wChYuANgf0aeovBIBCRUE9vop
	8dCsLW+0zZWXqhJ2L5woKAbPaHxyfOsla6YpuXBEP+XOEVY+RvVjwYGJArjwpr5E10JBOX36m1u
	oKN6D1SkKfVDJYDISa7CRgSgZ9BVHIONDPZVlmTGjpG/ElzNsDlnEclsJrZvzuDRJtyps83BMrY
	yjrF5xV76OHWG8d3BGlI3GFOAIFXcXqHoPihDyfGynZ3439q+zCc0HVfMjM4FG61laXBC3loxmv
	3ecO04NS8v8KZj/WwrksW15IsIaYToVsrB2X4Ml60jtSb9+PIroU7w1obr+KhPr8yCDVssOicTa
	vmisET9aqha9RvSysq918zUIuM3MvRtwplHPYF1+SW/MpTY4JdhLvV9qVivcnPkHZX2RaoyJ0nl
	9S1U8Yg/MXFdCuOSI5nKBuU9qukX8h3Qc19JU+68LVlDmpxzewFJ6XqJ0TtNZeRQ8kPhM+gkZMJ
	+PlIefbZKt3rc2bk0kafZuBeuEBPRvZ11BlDPl2ByAdtYw28vbzHlPCMjoX++Hux1ctNMKDqRCe
	nel3jfE4hq8nNrzEWDmIj6Moadi5a+03pPobuN8FLg==
X-Received: by 2002:a05:622a:5291:b0:536:119e:1767 with SMTP id d75a77b69052e-5383b605700mr29740511cf.65.1792861462021;
        Sat, 24 Oct 2026 10:04:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c5273sm19020701cf.9.2026.10.24.10.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 10:04:21 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	honggyu.kim@sk.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/mempolicy: recompute automatic interleave weights on memory hotplug
Date: Sat, 24 Oct 2026 13:04:15 -0400
Message-ID: <20261024170415.4121901-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
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

In auto mode, weighted interleave derives each node's weight from its
bandwidth, reduced over the nodes in N_MEMORY. HMAT and CXL report a
node's bandwidth once, when the node first gains memory, and nothing
else on the hotplug path recomputes the weights.

When a node loses its memory, the other nodes keep weights computed
with its bandwidth until another node reports. If one does while the
node is away, the reduction skips the node and resets its weight to 1,
which it keeps once its memory returns.

With HMAT bandwidths of 100G for nodes 0-3, and 50G and 25G for kmem
nodes 4 and 5, weighted_interleave/nodeN reads:

  event             node 0-3   node 4   node 5
  node 4 online         7         3        -
  node 4 removed        7         -        -
  node 5 online         7         -        1
  node 4 back           7         1        1

Toggling weighted_interleave/auto to 0 and back to 1 gives the correct
6, 3 and 1.

Recompute the weights from the recorded bandwidth whenever a node gains
its first memory or loses its last.

mempolicy_set_node_perf() now only records the bandwidth and calls the
same helper, so the bandwidth is kept even if allocating the new weights
fails. wi_state_lock is dropped between the two steps, which should be
safe because the helper reads node_bw_table and the mode under the lock,
so a racing writer only makes it work from newer state.

With this patch, weighted_interleave/nodeN reads 6, 3 and 1 as soon as
node 4 is back.

Fixes: e341f9c3c841 ("mm/mempolicy: Weighted Interleave Auto-tuning")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 66 +++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0884c629670d..ffb293a4cc56 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -238,27 +238,45 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 		new_iw[nid] /= iw_gcd;
 }
 
+/* Recompute the weights from node_bw_table, unless they were set manually */
+static int wi_state_refresh(void)
+{
+	struct weighted_interleave_state *new_wi_state, *old_wi_state;
+	int i;
+
+	new_wi_state = kmalloc_flex(*new_wi_state, iw_table, nr_node_ids);
+	if (!new_wi_state)
+		return -ENOMEM;
+	new_wi_state->mode_auto = true;
+	for (i = 0; i < nr_node_ids; i++)
+		new_wi_state->iw_table[i] = 1;
+
+	mutex_lock(&wi_state_lock);
+	old_wi_state = rcu_dereference_protected(wi_state,
+					lockdep_is_held(&wi_state_lock));
+	/* NULL wi_state assumes auto=true */
+	if (!node_bw_table || (old_wi_state && !old_wi_state->mode_auto)) {
+		mutex_unlock(&wi_state_lock);
+		kfree(new_wi_state);
+		return 0;
+	}
+	reduce_interleave_weights(node_bw_table, new_wi_state->iw_table);
+	rcu_assign_pointer(wi_state, new_wi_state);
+	mutex_unlock(&wi_state_lock);
+	wi_state_retire(old_wi_state);
+	return 0;
+}
+
 int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
 {
-	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
 	unsigned int *old_bw, *new_bw;
 	unsigned int bw_val;
-	int i;
 
 	bw_val = min(coords->read_bandwidth, coords->write_bandwidth);
 	new_bw = kcalloc(nr_node_ids, sizeof(unsigned int), GFP_KERNEL);
 	if (!new_bw)
 		return -ENOMEM;
 
-	new_wi_state = kmalloc_flex(*new_wi_state, iw_table, nr_node_ids);
-	if (!new_wi_state) {
-		kfree(new_bw);
-		return -ENOMEM;
-	}
-	new_wi_state->mode_auto = true;
-	for (i = 0; i < nr_node_ids; i++)
-		new_wi_state->iw_table[i] = 1;
-
 	/*
 	 * Update bandwidth info, even in manual mode. That way, when switching
 	 * to auto mode in the future, iw_table can be overwritten using
@@ -271,25 +289,10 @@ int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
 		memcpy(new_bw, old_bw, nr_node_ids * sizeof(*old_bw));
 	new_bw[node] = bw_val;
 	node_bw_table = new_bw;
-
-	old_wi_state = rcu_dereference_protected(wi_state,
-					lockdep_is_held(&wi_state_lock));
-	if (old_wi_state && !old_wi_state->mode_auto) {
-		/* Manual mode; skip reducing weights and updating wi_state */
-		mutex_unlock(&wi_state_lock);
-		kfree(new_wi_state);
-		goto out;
-	}
-
-	/* NULL wi_state assumes auto=true; reduce weights and update wi_state*/
-	reduce_interleave_weights(new_bw, new_wi_state->iw_table);
-	rcu_assign_pointer(wi_state, new_wi_state);
-
 	mutex_unlock(&wi_state_lock);
-	wi_state_retire(old_wi_state);
-out:
+
 	kfree(old_bw);
-	return 0;
+	return wi_state_refresh();
 }
 
 /**
@@ -3900,8 +3903,15 @@ static int wi_node_notifier(struct notifier_block *nb,
 	case NODE_REMOVED_LAST_MEMORY:
 		sysfs_wi_node_delete(nid);
 		break;
+	default:
+		return NOTIFY_OK;
 	}
 
+	/*
+	 * HMAT and CXL report a node's bandwidth only when it first gains
+	 * memory, so recompute the weights whenever N_MEMORY changes.
+	 */
+	wi_state_refresh();
 	return NOTIFY_OK;
 }
 
-- 
2.56.0

