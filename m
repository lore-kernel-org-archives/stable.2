Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2739390221
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992691; cv=none; b=H8hj/DznE9YPT3UDaK+3/HOsDc2zU7NdEZP0SNpg9YbK9npS0SR+6WyWbWFSxBCYNRd8p+4G16GzmMPGPUnylMVa1V5dYnNVTzngP0Fpk4D15ycxqO2hC7/W/mgw7/CiuSWxFxEFru9FQxZSUZUsTIiyHNoKQ2iTU0QV+UIN9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992691; c=relaxed/simple;
	bh=Or/eZwuJXubeHuZKiFmrdoIm39OnQMsrUPi4U5ZKg2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8w8GJ+xFoPVOPKJVPCyWpVTpxBIXv4v0oK74dDzoxVssAt87wG9xfYcvo/Osw90VjhruMb2+f+tYGixoxDnxRd15lv5piwrYyPvD5hclXNRbivsgQ2MKjx7HG344G6o4DvsRXJ5jYMvA7SpBgDEjBs8SFX97Mm0VcL/Y/+p3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJrxlO90; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJrxlO90"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso15103095ad.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782992686; x=1783597486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldwgRZuG3Q0N3aWG5lNpZU/M0NB34Hnh4N7sY3vtI+E=;
        b=lJrxlO90a7BV5Sg/9cC9ourWNFAtji6FEN0Oahp1ryfLI7lthed/iqdlPe3tpWf3Lt
         yLI55vR87mgYHwrzxpdlcNVciBNzBaPNpGGaJn8d3AYKF5e1cUhkK65GfkkaklEI+VrO
         uCm58zXwjzg90lq+acSnk1ZrvMqOZbNzhiiS1IYT8ubqg2G3m2ySNj+PYAZObFD5u0td
         HfGXtDEKc13iiHz1pzGo6WFYYZCTauUdvnDuuVd6vVwDgMPberHoSduu5O4CaubTD0kK
         D7eptC5JZOa7LdV4lUKoaQX3oYhP2HLJZGt/scBxm+XgxfMVDe2boLRjYQUBAvCif3tu
         7vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992686; x=1783597486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldwgRZuG3Q0N3aWG5lNpZU/M0NB34Hnh4N7sY3vtI+E=;
        b=bTT35Y7CRXurRQhOWHNeT1YSfxdJgDQvisomR13Zr+CQIV8HjNPVOm0QaxsArp00W5
         cl+5eaikGg6RgKbRlbQMPZLYWopa0RKfYChij/CzgHf5RDB6qOEuOz6FSYvP+IzFgbKD
         JpCR2QqWNUK/qJThlr3nC/ZfSNQ+djia+ZDwYGFjkTCUCWJZ0irnw8ba/1hPlPW+EBeZ
         3fqnz2slIHFBnKTYe7/QVn50Q8PTQ7OfDdSeh9cE1oGqDfX3k4k2Nq2UGLM6ZnQ5X8Rc
         p2+PM4UXx2qrT2EOhG4VypIPIbNBMEK8mT+KlWRFw+IswtpLOzAlW28zK5d7s0LSetST
         +SBA==
X-Gm-Message-State: AOJu0YybkOpx+pJD93GlskeUeypbZlwoEWCzJ5zBHNEkqDgP6jgXLCxr
	nd+bCHZaidvWtKffa+K59we6a7+ZBIWxKMbqZ9v6V1kvp/44fpMhZb6pOVkBuw==
X-Gm-Gg: AfdE7cmdDUNFhO+uo7AqFRJr4UU/hPGTPgZNniUPEsElUy4SgsVKHIRwKfr3+0p0BBX
	hfhdjTRomKKu0Y71JV6UZIi7cnuO3tDSU2lX0O/xcX/+b19VwIwyMeFQytJMre1SJrdRFoJTAMY
	EFW1i9q4v1WpFu8+zIdqmTZFfPzuWWMZwyj/wy94WoAOiARJbdas+3alxikC4UWgj0o31FclncX
	iMyUzVdB4zo1mrZFA7ZLUQu5OoNNA3Ix28eu5K2WCUDnEQKyAKizRhO3SkAJkOAOUDOtzjAyFgs
	LSy82thfeTWcZ+1UKvXHw/j8BpaeoChJ5WLvG++xyW7TmDW3MkaekHHmXYRjwjMjOobOrcnJzTo
	tvNAq071Q3m0yPOBP7P0UIn7YtzzMiYSndZ0HuwCVnrBSGSWjLZvorq4+jTxsbb22213icIVAGX
	ZMjuHbzGwru6/pX3e+Z6SmlQIyB66VUCbv5y+DDA==
X-Received: by 2002:a17:902:e5c5:b0:2c7:9b17:6676 with SMTP id d9443c01a7336-2ca7e7549ccmr61349505ad.23.1782992685255;
        Thu, 02 Jul 2026 04:44:45 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dadc8sm12332265ad.16.2026.07.02.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:44:44 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH 7.0.y 2/2] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
Date: Thu,  2 Jul 2026 19:44:39 +0800
Message-Id: <20260702114439.1942588-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702114439.1942588-1-maoyixie.tju@gmail.com>
References: <2026051900-nanometer-dropkick-80d8@gregkh>
 <20260702114439.1942588-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are
file scope and shared across netns. mem_check() reads fl_size to
decide whether to deny non-CAP_NET_ADMIN callers. capable() runs
against init_user_ns, so an unprivileged user in any non-init
userns can push fl_size past FL_MAX_SIZE - FL_MAX_SIZE / 4 and
starve every other unprivileged userns on the host.

Add struct netns_ipv6::flowlabel_count, bumped and decremented
next to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new
field fills the existing 4-byte hole after ipmr_seq, so struct
netns_ipv6 stays the same size on 64-bit builds.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the
file was added. Machines and connection counts have grown.

mem_check() folds an extra per-netns ceiling into the existing
non-CAP_NET_ADMIN conditional. The ceiling is half of the total
budget that unprivileged callers have ever been able to use, i.e.
(FL_MAX_SIZE - FL_MAX_SIZE / 4) / 2 = 3072 entries. With
FL_MAX_SIZE doubled, this preserves the original per-user reach
of 3K (what an unprivileged caller could already obtain before
this change), while forcing an attacker to spread allocations
across at least two netns to exhaust the global non-CAP_NET_ADMIN
budget.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

The previous patch took ip6_fl_lock across mem_check and
fl_intern, so the new flowlabel_count read in mem_check and the
new flowlabel_count++ in fl_intern run under the same critical
section. flowlabel_count is therefore plain int, like fl_size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Link: https://patch.msgid.link/20260506082416.2259567-3-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit e68eadffb724b36ffd3d5619e0efcaf29ec2a175)
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 34bdb1308e8f..7c62f401c37a 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	unsigned int ipmr_seq; /* protected by rtnl_mutex */
+	int			flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index a8974643195a..b1ccdf0dc646 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -36,7 +36,7 @@
 /* FL hash table */
 
 #define FL_MAX_PER_SOCK	32
-#define FL_MAX_SIZE	4096
+#define FL_MAX_SIZE	8192
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
@@ -162,8 +162,9 @@ static void ip6_fl_gc(struct timer_list *unused)
 				ttd = fl->expires;
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
-					fl_free(fl);
 					fl_size--;
+					fl->fl_net->ipv6.flowlabel_count--;
+					fl_free(fl);
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -197,6 +198,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 				*flp = fl->next;
 				fl_free(fl);
 				fl_size--;
+				net->ipv6.flowlabel_count--;
 				continue;
 			}
 			flp = &fl->next;
@@ -243,6 +245,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	fl_size++;
+	net->ipv6.flowlabel_count++;
 	return NULL;
 }
 
@@ -460,6 +463,9 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
+	const int unpriv_user_limit = unpriv_total_limit / 2;
+	struct net *net = sock_net(sk);
 	int room;
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -478,7 +484,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE / 2) ||
+	      room < FL_MAX_SIZE / 4 ||
+	      net->ipv6.flowlabel_count >= unpriv_user_limit) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
-- 
2.34.1

