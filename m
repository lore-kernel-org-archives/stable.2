Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634551;
	b=wY7UGhLyotHQPLoWfe+PVjsenmMcfuxO9qddaL03GwDPM1WEvsP1JwAyRYw1x+UiQGOD
	 IKMdfWuTl24urBeuHkluR+6zvgxwIqIH8+f73W/dAPkKIXI5usD6/mscVMcoSh0z8Jr8y
	 4UcN8v9KuvsZ+QbwDAema3deR1DaQO2pqffRCFsapvAVgW1upj3MRf1nmqjqdu8Xma9xa
	 ZgEnnh21qDISRNDs1zAku6HDa/Nav0MfQth7t5qOHssFY7dQooFQ/+1nasijX3dfox8Jo
	 Z9vkAj2peLc573YbhkCiih5bJmxycA9rn/cU6hFyAgi1NGLnDAhMioLd5F8exEz5xaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YMqcMpSooEblTqwbk/T9EsawfT5EJj7H64/K4VkZDRM=;
	b=L0+DiWe3yvepqoejyjCSmYXUOpLXHtqgu+RcOJzlXWuYg+fnACvWtM4L9Y28tn/2e/Rh
	 nCeJopoO0FZ0RdAIu7CJ0PidddD2JDBIeXnXHpJwUVYU22XjDF4ktlO4O8HreTvesr/t+
	 aLW8seGKlIG3KN5qtHzkZA2QxAa9Yt14QKFCFow2z/o5Im4YwfTWzc+OPdUdGr9D/1myr
	 dDpoTs1agpZqSSBuEJYx77uDgTqnnVV0odzkeJthwy0RToNFYdWuGm21aBXVuDzXljEUb
	 ecTvweScij4aSIWJ8Lcpwby0ddmrEbeEQjbAmWK1sa72mQNVFMtuPcznoWDu1X41Adg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=WXkoBN0B;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16FA606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16FA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=WXkoBN0B
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so2856037b3a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795634550; x=1796239350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YMqcMpSooEblTqwbk/T9EsawfT5EJj7H64/K4VkZDRM=;
        b=WXkoBN0BNbx7ps0ZWtUQ8EvTqrHUUttgshJxarEZBFGj0eCpVjy9LMcqp21FiHzw/I
         yJoT6RHv4UckGdIAn0af50KqMJZrY7em+SEVHSVgModGAs379+xFcvi60dLAoYlElPEc
         hzTw+T+KlkD4dFN391+szqWaw2CuDwZwhVvoBvTRUQTWz7ci+VKfeo5/mf/aa8ARyFj7
         wIG1cXQGHj49g/HQ0/pagHSmg2gTRRQfNa1xcnEqfGwqoygNq2aLBqz2BloGyt35/eYM
         WibUYrdh/Gvi4VXKjPKMJDfuu/1ppXxRRAea9FYrOt/zZac6VMPUMDm2LunF6PpyCseI
         djtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634550; x=1796239350;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMqcMpSooEblTqwbk/T9EsawfT5EJj7H64/K4VkZDRM=;
        b=Dy0/fMiPCXd0GQ4e/fsSUlW4a3HgmQBZ3prpu5LpNB+5LLomUA6x2XKdLxVJVsKIX9
         r05P8chJaPokq4tkyJ0hIm8hXk3qhIZJrvpvX3vTjpv5/9t7+Mo9Hx4MnKT1VIJuVKLU
         7QZ478oWhcgoPUzu6HWtLssoexSeZTTzfQSuZ54ne/0NatjXLyAEeFhB8XHqq1Kxj6WO
         Gsesop6WhPj+r+rXJuR69b8n6gDICygtZSlhyvgYo0QlCGbstTdvXLr6LzEjXHgoJCWE
         CXdqBR4tSEvCQ58zBsHTfVZOqmmadReQcCuKM/VLyMyun3lcsfkzyP/70i3M8CjTgYkF
         lxOA==
X-Gm-Message-State: APuU4Z/+X9qcpby2TNp+mMaAi8uPjK/SxWCDgCh20Wny5G+2djtqV7cR
	GWyEIzLovTGM9ehGr9Aw3ClN3iu19Lvy4wFgPYJSM3Gt20LUrih6JMraHPaGyWH9EvtoMc5yv2K
	j2/Hfu+s=
X-Gm-Gg: AZFdTZfK/U1jiaVDwCRaghbg3S4Us4/9SMRcwwyMPdOEszZEmv1WHNck0L6aQy6fiQp
	ksTcQD6mxKIl9Y2evJyPXSUdVWnZsGUZoWkYQHeK0Kf1JFjJYW+6x7cam2uWBhqHdkGDReEgdEW
	FEmMH3XTQ275ItkhK7LpyN5DbhVxLOFdY3HIGh/po2dY+y27VycJM19gJIfoEjdf9mstdYxB9ry
	DEtCmY/DFPSeerkhSxkZMvbt3pjIJdenJXS7SGXjy1rzmb6amFJ2XaVUaLBuMdEbm9HCfquhPXY
	B6iUd/JfLruGrROUgxz8S+HZ6QVhd46GPmwNK/tSKIm1KAbUjyN8cMtm7JnODm9DJokZzowAhiI
	k8Ey4bdwq8uQTZYQZnM/iyoTDgtsiwJcCtyPBLR1nySj6GFxzXdZhQMZJMjG9rNgR11K5dideqk
	BmseJfYMj4ioTljuqxNQdHzIbnpOB5FAfwAfC/g630Vft/P+wtCdiCNdq6wNCNbhSICcizjP4+r
	cXoFkdBRwf4Fnr1s/F1J1Mtii0osygH8QBCPN7xabEi/mQFmJRjQvkAOkrBsO/gSeY+3v/jcspv
	qQX3WuaQj+W56YQ4+wJpNP0dPyu9hZtSBUQXijfOkuGZTVIlA5g1ii0yvXm8rYbLs8GUmpsOfTd
	CBa4XSF0jXiRUEYoHOQW8ArcijrI=
X-Received: by 2002:a05:6a20:7489:b0:3f8:78ed:b4f9 with SMTP id adf61e73a8af0-4014d45580amr18005071637.51.1795634550179;
        Wed, 25 Nov 2026 11:22:30 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d002a77sm9221778a12.16.2026.11.25.11.22.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:22:29 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: bird@lzu.edu.cn,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	tanyuan98@outlook.com,
	tomapufckgml@gmail.com,
	yifanwucs@gmail.com
Subject: [PATCH 6.18.y] mpls: add seqcount to protect the platform_label{,s} pair
Date: Wed, 25 Nov 2026 14:22:25 -0500
Message-ID: <20261125192225.48048-1-artem@trailofbits.com>
In-Reply-To: <20260509143000.stable-reply-0001@kernel.org>
References: <20260509143000.stable-reply-0001@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Sabrina Dubroca <sd@queasysnail.net>
Date: Tue, 24 Mar 2026 00:25:57 +0100

[ Upstream commit 629ec78ef8608d955ce217880cdc3e1873af3a15 ]

The RCU-protected codepaths (mpls_forward, mpls_dump_routes) can have
an inconsistent view of platform_labels vs platform_label in case of a
concurrent resize (resize_platform_label_table, under
platform_mutex). This can lead to OOB accesses.

This patch adds a seqcount, so that we get a consistent snapshot.

Note that mpls_label_ok is also susceptible to this, so the check
against RTA_DST in rtm_to_route_config, done outside platform_mutex,
is not sufficient. This value gets passed to mpls_label_ok once more
in both mpls_route_add and mpls_route_del, so there is no issue, but
that additional check must not be removed.

Reported-by: Yuan Tan <tanyuan98@outlook.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Fixes: 7720c01f3f590 ("mpls: Add a sysctl to control the size of the mpls label table")
Fixes: dde1b38e873c ("mpls: Convert mpls_dump_routes() to RCU.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/cd8fca15e3eb7e212b094064cd83652e20fd9d31.1774284088.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Backport to 6.18.y: 6.18.y has neither the per-netns platform_mutex
  (upstream e833eb25161a) nor the RCU conversion of mpls_dump_routes()
  (upstream dde1b38e873c); resize_platform_label_table() is serialized
  by RTNL. Use a plain seqcount_t instead of seqcount_mutex_t and
  disable preemption explicitly around the write section, since
  local_bh_disable() does not do so on PREEMPT_RT. Keep
  rcu_dereference_rtnl() in the helper because mpls_getroute() reaches
  it under RTNL without rcu_read_lock(). mpls_dump_routes() still runs
  under RTNL, so it is left unchanged. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Yuan Tan offered resolved versions of upstream 629ec78ef860 in this
thread in May. I have not seen one posted for 6.18.y, so I am offering
this one.

The fix is in 6.1.191, 6.6.160, 6.12.114 and 6.19.12, and in mainline
since 7.0. The upstream commit does not apply to 6.18.y; the backport
note above lists the differences.

6.12.y took the upstream fix together with its prerequisites
dde1b38e873c ("mpls: Convert mpls_dump_routes() to RCU.") and
e833eb25161a ("mpls: Protect net->mpls.platform_label with a per-netns
mutex."). On 6.18.y, e833eb25161a does not apply either, so that route
would need at least one more adapted patch. This patch is the smaller
change: it follows the 6.6.160 backport and keeps RTNL as the writer
lock, adding only explicit preemption disabling for PREEMPT_RT.

Compiled net/mpls/af_mpls.o with CONFIG_WERROR=y on 6.18.65 from a
cumulative x86_64 tree, with and without the current queue-6.18 patches.
No kernel boot or runtime test was performed. PREEMPT_RT was not built.

An LLM was used to prepare this backport and to check applicability and
stable-queue history; I reviewed the result.

Thanks,
Artem Dinaburg

 include/net/netns/mpls.h |  2 ++
 net/mpls/af_mpls.c       | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/net/netns/mpls.h b/include/net/netns/mpls.h
index 19ad2574b267..9b83b7f43d83 100644
--- a/include/net/netns/mpls.h
+++ b/include/net/netns/mpls.h
@@ -7,6 +7,7 @@
 #define __NETNS_MPLS_H__
 
 #include <linux/types.h>
+#include <linux/seqlock.h>
 
 struct mpls_route;
 struct ctl_table_header;
@@ -16,6 +17,7 @@ struct netns_mpls {
 	int default_ttl;
 	size_t platform_labels;
 	struct mpls_route __rcu * __rcu *platform_label;
+	seqcount_t platform_label_seq;
 
 	struct ctl_table_header *ctl;
 };
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 608c43a4602d..9ed136931c4f 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -75,16 +75,31 @@ static void rtmsg_lfib(int event, u32 label, struct mpls_route *rt,
 		       struct nlmsghdr *nlh, struct net *net, u32 portid,
 		       unsigned int nlm_flags);
 
+static struct mpls_route __rcu **mpls_platform_label_rcu(struct net *net, size_t *platform_labels)
+{
+	struct mpls_route __rcu **platform_label;
+	unsigned int sequence;
+
+	do {
+		sequence = read_seqcount_begin(&net->mpls.platform_label_seq);
+		platform_label = rcu_dereference_rtnl(net->mpls.platform_label);
+		*platform_labels = net->mpls.platform_labels;
+	} while (read_seqcount_retry(&net->mpls.platform_label_seq, sequence));
+
+	return platform_label;
+}
+
 static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
 {
-	struct mpls_route *rt = NULL;
+	struct mpls_route __rcu **platform_label;
+	size_t platform_labels;
 
-	if (index < net->mpls.platform_labels) {
-		struct mpls_route __rcu **platform_label =
-			rcu_dereference_rtnl(net->mpls.platform_label);
-		rt = rcu_dereference_rtnl(platform_label[index]);
-	}
-	return rt;
+	platform_label = mpls_platform_label_rcu(net, &platform_labels);
+
+	if (index >= platform_labels)
+		return NULL;
+
+	return rcu_dereference_rtnl(platform_label[index]);
 }
 
 bool mpls_output_possible(const struct net_device *dev)
@@ -2582,8 +2597,14 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 	}
 
 	/* Update the global pointers */
+	local_bh_disable();
+	preempt_disable();
+	write_seqcount_begin(&net->mpls.platform_label_seq);
 	net->mpls.platform_labels = limit;
 	rcu_assign_pointer(net->mpls.platform_label, labels);
+	write_seqcount_end(&net->mpls.platform_label_seq);
+	preempt_enable();
+	local_bh_enable();
 
 	rtnl_unlock();
 
@@ -2664,6 +2685,8 @@ static int mpls_net_init(struct net *net)
 	struct ctl_table *table;
 	int i;
 
+	seqcount_init(&net->mpls.platform_label_seq);
+
 	net->mpls.platform_labels = 0;
 	net->mpls.platform_label = NULL;
 	net->mpls.ip_ttl_propagate = 1;
