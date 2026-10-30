Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376761;
	b=U8d0zDigqGtii29vZ7H5T84Q4kxouh4jX0ZucM+GsEC1IhXWUfoIqgnGyouAz2Nr1L+u
	 ThPdgRiMFSm8Cjy6O7aQAlH/YZqheP3w7+QJeNN3XIcA8eyyme9gV0nLgk1j8vVJNV1Ih
	 g4WZGEsAsGUAe1GN5+40LCvsD7biczdDuLZLk1qOl5j9odE1UXUxiT32SQktUrJkFTqyU
	 A9kUUYOe/wqfPdO7WFVrEIN8l3ET02LOCnPIJW8vfNjMVk3J0QjS+dKCiopcJyh8HDRlc
	 /47ncSJNtTBMGGy/MuX3qTKB8YbPToQKgT9/2em3zoCLrw8gNCVS8JrJNYayFDD883Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uBqGgi319yANUlDreD4lJdCrP+kc/0b2EBnj4SdcGgA=;
	b=OrkPwSkmvdc1ej4eVHH8CjoqncooKeCIp5xvX4k1C9425oDG2OI8mpxDAF11cxjj9kWZ
	 eCihVaU98zyEyETqUzFTRVSTdwxmVE+W3W8mslW9fw3Qu/iM5H8565CuHW75Ux8iA//GL
	 zuMXY7JJJho1+Bs3fiIeJ7GjNUKY0EGHLNqg92ormO87x61r/eNmZJGHKY4m2ONmkVtqp
	 gIDqZm0YFQIPBm+nT6NIfDzQeLmf16fD9cdOixNBqSaPS/INGaHmfmaz2CZVhQuzAxmqt
	 8gf6lzsByIDkI8ecJtlHS/YxO3jF1HjM8NmPQBgXid+/1TWH4b1TtZlHscyXQT0qlrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=V3xkXO1W;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B9606A32C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD6B9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=V3xkXO1W
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c19fc50abso11422886d6.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793376760; x=1793981560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBqGgi319yANUlDreD4lJdCrP+kc/0b2EBnj4SdcGgA=;
        b=V3xkXO1WAgdSrYUFOVJTKrzWiLG4R1wqbNfA0fWyXKxFaf61Z19cujhlimdELtIVPJ
         3rajACVq3Wa5syfFQCy9irgP3Qw74UEPlEssHw8GUVD+AbcNIAy9uzlstrfUkPoxJmO5
         YAmFDMnk0UZEMg0Du1vvTV77nfLKXGNbWo0db9bRTK2yF/GoXXA81EdPqblVRTB2c1oy
         T1RN8KQOT9wXYgY8d3R3wwiVWfGHPNewklslCSEKT079M3fAagQOS0mqcE9Zt2WlGMX4
         gZb70TkpRYZxfG2g5pdGxznqZYZvZLhi9N+uW7veQfJi+tRO2J8XLIL2E3uswr7krSot
         xXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793376760; x=1793981560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBqGgi319yANUlDreD4lJdCrP+kc/0b2EBnj4SdcGgA=;
        b=VZrGZxh72ALEFgmdI3OiOSZtMQvGdYliPZTLRWUys5aSLkiGTVFKYGVU7fZ5D7T4cw
         r59aW6DrtXe7tmqLRhGlitj3sE10BOtRGuMhzFR2QYMdfnbSAKdjiVtLUr/uALOBPrP9
         MZg6GRqKcUJbPPBZ4e3Da0nrgyW0jEouvhmC4PcPyN1H7mbpDNKdqnVUadXhoJcipL1o
         OeCs7OxZI0MB8tWr+lgPwsMjWl5CYC7CoU6dTxon6ZunQRudFsLq81D0TjE5T3EtJ+Pf
         52zNhZFnUFEV74oOHc2nmh7nLLeRaTCwBMvayw+AC4xr6zg4Gj17Vw5cYEt4zPgqcu47
         FUwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzehhSU/bvjWZmX6QM7xblLIHBkUzS+hbzI3/aOLt0DK9jl781HHXPOYU/pc5G3JiMIEozyBVI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgIEIA9GdtmDT/TCOQOkw2z9dHJJ0s9dJ9CB1zpJ23vIjVQDvT
	cnH8rix/448RXcX1LEaWx8xn8qaLkzINwJCFqVAJCvhaz26kHnR2q0DwP7fBP1yVMIS00tudrZl
	khO2n
X-Gm-Gg: AYBFou3KhYkbGK8uk56GwLfS07RFRjZKoi2K7FOIPM19qFUNAHxzc1UBQC5gx8MFh3F
	nIZPZcIXdZ+Jyj7wh6RB7bCVIF/MpQ9Sbi1nr8yhPri73JnQ/DfUdMHGvKYbXEmYLl5MVBf8hig
	EVzWxhD8DI8lD5F3E+wxPqLIfYFstW0bX4kVUr0+re/6oXU+BI06whFDl1qTNyKGWCdzzBB2Y8m
	0eIOVqmxIRsAJXkJp7MblF6ydaBpGsztx9mvndEPMPJhXKx1F5S82LFF0iV48UOPPpycO9icr9S
	HW2bXOdwnm/tEzkmTDhF6E5YNaqHyF5E5oG9fTenyFZzcfTTO77EGiYMCBermZAC1nkZ6rXImn4
	oh34OYPZlcYdnyIaqW6UnRftn9jaFMBiT9ce1a4u3G+jnha4hXnZu+i3xPwkkObF+Xw/4629HUQ
	TI/BUhjOh2LpX7ufk8i9VJDrK6yzsKStv9y1AFyzqpHQR+k758dJ11o4XMdMI6waqt28x1T21xA
	MEk/TIm7WlWcjXG7FEHmVuz7Z8vLQuBgIx0We445+QX9eVNvqT4iYM6R/05pGwyQaDozsdg+xf2
	vW1FGiY7KefFaFHQ5A+8kOCWKnYhKZrNpC1TGixeZq9L9IF8XawWRxSmR4webyQd4WZMHGMn9ZW
	5Xqa7aEclIkSxbHw=
X-Received: by 2002:a05:6214:248f:b0:91c:7460:6eb5 with SMTP id 6a1803df08f44-91ca4ad4cc9mr40967836d6.15.1793376759518;
        Fri, 30 Oct 2026 09:12:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca8082914sm18501396d6.42.2026.10.30.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:12:39 -0700 (PDT)
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
	harry@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/mempolicy: recompute automatic interleave weights on memory hotplug
Date: Fri, 30 Oct 2026 12:12:34 -0400
Message-ID: <20261030161234.1505367-1-gourry@gourry.net>
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

This can result in a major skew in distribution and overload tiers
with more data than their respective bandwidth can support, resulting
in a performance regression.

With HMAT bandwidths of 100G for nodes 0-3, and 50G and 25G for kmem
nodes 4 and 5, weighted_interleave/nodeN reads:

  event             node 0-3   node 4   node 5
  node 4 online         7         3        -
  node 4 removed        7         -        -
  node 5 online         7         -        1
  node 4 back           7         1        1
  Expected:             6         3        1

Toggling auto off and on generates the correct result, but we should
detect this and fix it during hotplug. Recompute the weights from the
recorded bandwidth whenever a node gains/loses its first/last memory.

The notifier cannot fail the hotplug, which has already happened, so
warn once if the new weights cannot be allocated. The next recompute
starts from the full bandwidth table and corrects them.

mempolicy_set_node_perf() now only records the bandwidth and calls the
same helper, so the bandwidth is kept even if allocating the new weights
fails. wi_state_lock is dropped between the two steps, which should be
safe because racing writer simply causes it to run with newer state.

Fixes: e341f9c3c841 ("mm/mempolicy: Weighted Interleave Auto-tuning")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 84 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0884c629670d..6f92621e9135 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -238,27 +238,49 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
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
+	/*
+	 * Hotplug events can arrive before any node reported its bandwidth,
+	 * leaving nothing to compute weights from. NULL wi_state assumes
+	 * auto=true.
+	 */
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
@@ -271,25 +293,32 @@ int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
 		memcpy(new_bw, old_bw, nr_node_ids * sizeof(*old_bw));
 	new_bw[node] = bw_val;
 	node_bw_table = new_bw;
+	mutex_unlock(&wi_state_lock);
 
-	old_wi_state = rcu_dereference_protected(wi_state,
-					lockdep_is_held(&wi_state_lock));
-	if (old_wi_state && !old_wi_state->mode_auto) {
-		/* Manual mode; skip reducing weights and updating wi_state */
-		mutex_unlock(&wi_state_lock);
-		kfree(new_wi_state);
-		goto out;
-	}
+	kfree(old_bw);
+	return wi_state_refresh();
+}
 
-	/* NULL wi_state assumes auto=true; reduce weights and update wi_state*/
-	reduce_interleave_weights(new_bw, new_wi_state->iw_table);
-	rcu_assign_pointer(wi_state, new_wi_state);
+/*
+ * HMAT and CXL report a node's bandwidth only when it first gains memory, so
+ * recompute the weights whenever N_MEMORY changes.
+ */
+static int wi_state_node_notifier(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct node_notify *nn = data;
+	int err;
 
-	mutex_unlock(&wi_state_lock);
-	wi_state_retire(old_wi_state);
-out:
-	kfree(old_bw);
-	return 0;
+	if (action != NODE_ADDED_FIRST_MEMORY &&
+	    action != NODE_REMOVED_LAST_MEMORY)
+		return NOTIFY_OK;
+
+	/* The hotplug is done, failing the notification would not undo it */
+	err = wi_state_refresh();
+	if (err)
+		pr_warn_once("failed to recompute weighted interleave weights for node%d: %d\n",
+			     nn->nid, err);
+	return NOTIFY_OK;
 }
 
 /**
@@ -3414,6 +3443,7 @@ void __init numa_policy_init(void)
 	if (do_set_mempolicy(MPOL_INTERLEAVE, 0, &interleave_nodes))
 		pr_err("%s: interleaving failed\n", __func__);
 
+	hotplug_node_notifier(wi_state_node_notifier, DEFAULT_CALLBACK_PRI);
 	check_numabalancing_enable();
 }
 
-- 
2.56.0

