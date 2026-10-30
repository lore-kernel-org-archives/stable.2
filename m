Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403784;
	b=CcaOfqPnogEQ+3d3928JGgBcXmwWwG3g7/m11Nk6ACYxguH7LKcPmLxWcYPuuPNilt7o
	 USLb8hNK1HL29G3WXKc8ep6PF+mAm7X/iSkwPilGNKtDSteTHG6zUvOiN1jcR0x3FS/A8
	 CtxZnial+87ItaKNaF8dTYx3joDI4pZkDOWRxUWRP913pt5GO/EY+ZpzUfZP1Qx4sPQje
	 ENTwN8oEk4pxaZTukLuV+rY2tKWQOMua7l9sc9BhECNUdnmiOtr1L3zbziKmE+QpmvW9k
	 rkaF4MRY0mZlwioUzsISgLxM7qXnO0k0wjtP4bo9KSQ0N46wbh8elw56mZ8kVLwiyLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403784;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vTsgS75SWh6JODmQ/6GBwZ7Q/loys1DrlZ7GGQLEh8k=;
	b=o3ZTalNMbJNA0c3owIWLoEsCPxjc0R0vyjCKrnIhxbitsASjz+zxreaKrlHWO08w9yH4
	 Mm88VYooxs9S11yG9ZXpnm6OS82ZSqwA9XGEdkQFP3DI/HZ6YXh9F3UHTQzbYH8g6I1Ks
	 huDBrpgjjWaECkm/DXDrUMcvUy0s73/A58IoRAC5UDmIx/HgTIjj6zuqN8xpWrQIB/bw4
	 Yel/9q1UcfBYTV8cO8B7Oed2UEHCu/q+sut/I1mutIWmYqDq9sY1E9HN7OMG2oORFgyHs
	 r8HuWAXKeMuWPUXUAp9XGMUT9Uqx+0IEJm7xEZ5ZiTrUcieJZbxasgYIdYXW2qK6XWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=fH5pBpFR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C1606A31A;
	Fri, 30 Oct 2026 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=fH5pBpFR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFB41F000C1;
	Fri, 30 Oct 2026 23:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793403784;
	bh=vTsgS75SWh6JODmQ/6GBwZ7Q/loys1DrlZ7GGQLEh8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fH5pBpFR9FV15LjnYPsaAdIoki8/201ThpJ6320tgeW+DueHIqcMhV621GaCmirKg
	 tgpsNTuELBVfcDeZisphTB9hGKlh+PDNQKvyoQKsBxh/yN6UuXNy6K5obUFGBpR6Vo
	 2cfr1QgTiDc2lqLlFyBLxNqZbdO58TpYo6AJiJ1c=
Date: Fri, 30 Oct 2026 16:43:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, david@kernel.org,
 ziy@nvidia.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com,
 harry@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/mempolicy: recompute automatic interleave weights
 on memory hotplug
Message-Id: <20261030164303.02c5cce0521c3d6fd4ddf015@linux-foundation.org>
In-Reply-To: <CAN+CAwN+OPMPpVdBA+XtQvFpDy+EOY2TAiusxMjYR+r0F+MPhw@mail.gmail.com>
References: <20261030161234.1505367-1-gourry@gourry.net>
	<CAN+CAwN+OPMPpVdBA+XtQvFpDy+EOY2TAiusxMjYR+r0F+MPhw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 30 Oct 2026 12:35:38 -0400 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Fri, Oct 30, 2026 at 12:12 PM Gregory Price (Meta) <gourry@gourry.net> wrote:
> >
> > In auto mode, weighted interleave derives each node's weight from its
> > bandwidth, reduced over the nodes in N_MEMORY. HMAT and CXL report a
> > node's bandwidth once, when the node first gains memory, and nothing
> > else on the hotplug path recomputes the weights.
> >
> > This can result in a major skew in distribution and overload tiers
> > with more data than their respective bandwidth can support, resulting
> > in a performance regression.
> 
> ...
>
> I think you may have dropped my review tag from the previous
> version!!! I believe the only thing that changes is the warn, so
> please feel free to add:
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Actually, quite a lot changed, so dropping the v1 tags seems
appropriate.

v1->v2:

 mm/mempolicy.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

--- a/mm/mempolicy.c~mm-mempolicy-recompute-automatic-interleave-weights-on-memory-hotplug-v2
+++ a/mm/mempolicy.c
@@ -261,7 +261,11 @@ static int wi_state_refresh(void)
 	mutex_lock(&wi_state_lock);
 	old_wi_state = rcu_dereference_protected(wi_state,
 					lockdep_is_held(&wi_state_lock));
-	/* NULL wi_state assumes auto=true */
+	/*
+	 * Hotplug events can arrive before any node reported its bandwidth,
+	 * leaving nothing to compute weights from. NULL wi_state assumes
+	 * auto=true.
+	 */
 	if (!node_bw_table || (old_wi_state && !old_wi_state->mode_auto)) {
 		mutex_unlock(&wi_state_lock);
 		kfree(new_wi_state);
@@ -302,6 +306,28 @@ int mempolicy_set_node_perf(unsigned int
 	return wi_state_refresh();
 }
 
+/*
+ * HMAT and CXL report a node's bandwidth only when it first gains memory, so
+ * recompute the weights whenever N_MEMORY changes.
+ */
+static int wi_state_node_notifier(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct node_notify *nn = data;
+	int err;
+
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
+}
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -3424,6 +3450,7 @@ void __init numa_policy_init(void)
 	if (do_set_mempolicy(MPOL_INTERLEAVE, 0, &interleave_nodes))
 		pr_err("%s: interleaving failed\n", __func__);
 
+	hotplug_node_notifier(wi_state_node_notifier, DEFAULT_CALLBACK_PRI);
 	check_numabalancing_enable();
 }
 
@@ -3910,15 +3937,8 @@ static int wi_node_notifier(struct notif
 	case NODE_REMOVED_LAST_MEMORY:
 		sysfs_wi_node_delete(nid);
 		break;
-	default:
-		return NOTIFY_OK;
 	}
 
-	/*
-	 * HMAT and CXL report a node's bandwidth only when it first gains
-	 * memory, so recompute the weights whenever N_MEMORY changes.
-	 */
-	wi_state_refresh();
 	return NOTIFY_OK;
 }
 
_

