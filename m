Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF5348C61
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645889; cv=none; b=bmtfoyPbx09b9Q8yQDufqRhIXODcm5ze0t6JLOK6SevGwgzgcHpNzcp87jztTCa9mB2uajSLiI27Z8dWqt5S/l9Aw1nZWOiAySQvBBZilKDXwmqbyQm+S7QJyjUwMaFHHEcF8AvCAk/Y5YdPF9xXwytWA6UheNeNIKULn5b+Who=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645889; c=relaxed/simple;
	bh=2wca9jiUZpoFjMcimeII6bdLA+Yz8eGkHT39Out8KPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgg2uCJOihVoJozpCUyAT66x+Q1meH2Gq2w6hm83C9AMxWRdkcCvwL37da1mCiyJ77v8QbMPdcU85Y2XyaqGpi346BeR5wx+0ntWFRvBDqB8i8CvHXs8mv8zejPlbdIhR7i98eRrrXvPPVSAnxJlDoU0meXAjHTiBC0qO4At42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Miket/0A; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Miket/0A"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2a76536bso48284651cf.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787645887; x=1788250687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3MGsld5jCXIuE1ZQHccQwWJT/ZObyzhHpKhPa7xQCWQ=;
        b=Miket/0APIFZdfNFWHsh0rNXUo8BCoY0H6mkS1BmUMOrL6Ong77iziG4Cm6ZBd2IpL
         7ZMU6Pm4T5WeD6+EENp7+0QD8awVY7szIEejlwX7UgtHaZcpYZ8J6kzUaGwHpr9Ra/N8
         Tu0fEcj01vV8HrE/n6y0T1qRHPKdvwa20+2SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645887; x=1788250687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MGsld5jCXIuE1ZQHccQwWJT/ZObyzhHpKhPa7xQCWQ=;
        b=bbT4m6RGpRQolK4/J/K2tZimFGAKeWzBOXbDXlsmjQ1xFSqspYptbOcm8ltzknR4ss
         Qh9bOj3So0aOlkm+FUTHlyxOwwLf6qTueXnAw6dCdUe6WB627UHusuxDQAlctD0Zgu39
         Zv3wYE5wnXh3F5tYKHDOrAtoXjy966U5a2v8JiuN7YqORiQfaanCgnyZYk36M7XEIdEe
         D04WmyLWMH5C4iYtUYVlgGbeLMSoq7mpM5YqqdFsC+8ISp4+XpT20IU/O4JqKL8C+0oo
         ttkrGx0/udF156KmUMzRI7S43qgVEpWVfNSCULPk9HSswrOemKrv+84NasC8GzqkGWnh
         bWVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMeoAOljkbS74Aia0vnvgoRAzpIJCBcC0C2a4tPAGmGelmQiSbM8EkgknBrJXaUuplVYA4bHw=@vger.kernel.org
X-Gm-Message-State: AFuF++lG/vi3hjXKQLGOreeIi0c15MNmm8Q/S3AOuRlzIsvf+kKKQJRr
	H+CR+z0jaXW6xTM8Yg5x7M/LJ7mRftaU7EpDXlJiOo+aUsId1d0dhor4IigAHEahQg==
X-Gm-Gg: AR+sD117HyL5kkPTMratKQIMDG9639L2OZj+W5D3pjfgovs0uHkwG3ROwNFNOQ6vUYl
	d61X76m+byZtn7DaEmErh+rBlHNEB1DIPbPg4vRLkDcg6TvY7Nt1XMadccWR6z1mdVZoT5LFjcK
	Kb251ffYYtfnWFEFK4A0Cv9/f/iansIAAVKpR7y+4SzBCzAErcLRwU4IzHgpl/hDiPiuliz82us
	kBoXh6o+4bqELX9opDDwQ6l21b0fmfWiq/cTQTcz2fMgO33gTUgo9tSVVQcm8ie5Z9pLFsMO1QF
	KkxC9J+PczBp6vgPt2nfKre0a5I3ca5E1tPhebv05QbZ3cddlHktvo7DcHwZZeoHbvef/5mndey
	Fn7yUQk0UqBxJM2+fki8CTo37WoBMWJE+zikhlnJFFMBXrMk+e3C4dJw/IuHTpO/nPQeOZe0Nc8
	6Hy3UU9epgG3aP/i7PQ+D14LHFmM2+gkq8bGaZMJ0ucgeJHU3g43nu
X-Received: by 2002:ac8:5f52:0:b0:517:875a:d634 with SMTP id d75a77b69052e-52e09bad973mr258346751cf.2.1787645887168;
        Tue, 25 Aug 2026 01:18:07 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09975f5asm65387341cf.2.2026.08.25.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:18:06 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 1/2] net/sched: pfifo_fast: reject oversized ring and account to memcg
Date: Tue, 25 Aug 2026 04:17:50 -0400
Message-Id: <20260825081751.134086-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
bound. An unprivileged user (via unshare -Urn) can set a huge
tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
memory, causing a system-wide OOM.

Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
via extack whereas for the resize path, the error propagates to
netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
are charged to the allocating process's memory cgroup.

S16_MAX is the virtio virtqueue size limit: the virtio specification
stores the queue size as a u16 with a maximum of 32768, so 32767 is
the largest tx_queue_len any in-tree driver can meaningfully use.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
- Unprivileged user in a fresh user+net namespace (unshare -Urn).
- Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
  while the devices are down.
- Attach mq at root, then replace each child queue with pfifo_fast:
    tc qdisc replace dev veth0 root handle 1: mq
    tc qdisc replace dev veth0 parent 1:1 pfifo_fast
    tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
- Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_array
  rings of tx_queue_len entries (~12MB per qdisc at QLEN=500000).
- On the unfixed kernel this exhausts global memory in ~28 iterations
  on a 2GB guest -> OOM panic. On the fixed kernel the oversized
  tx_queue_len is rejected with -ERANGE.

Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE) (Jakub)
- Changed cap from 65535 to S16_MAX (32767), matching virtio's
  virtio16 ring size limit.
- Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_MOD
  already prepends KBUILD_MODNAME).
- Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
- Fixed tdc teardown to use JSON list form for acceptable exit codes.
---
 net/sched/sch_generic.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf51564..eb5c0d3f67c2 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdisc, struct nlattr *opt,
 	if (!qlen)
 		return -EINVAL;
 
+	if (qlen > S16_MAX) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "ring size %u too large (max %d)",
+				       qlen, S16_MAX);
+		return -ERANGE;
+	}
+
 	for (prio = 0; prio < PFIFO_FAST_BANDS; prio++) {
 		struct skb_array *q = band2list(priv, prio);
 		int err;
 
-		err = skb_array_init(q, qlen, GFP_KERNEL);
+		err = skb_array_init(q, qlen, GFP_KERNEL_ACCOUNT);
 		if (err)
 			return -ENOMEM;
 	}
@@ -957,8 +964,11 @@ static int pfifo_fast_change_tx_queue_len(struct Qdisc *sch,
 		bands[prio] = q;
 	}
 
+	if (new_len > S16_MAX)
+		return -ERANGE;
+
 	return skb_array_resize_multiple_bh(bands, PFIFO_FAST_BANDS, new_len,
-					    GFP_KERNEL);
+					    GFP_KERNEL_ACCOUNT);
 }
 
 struct Qdisc_ops pfifo_fast_ops __read_mostly = {
-- 
2.43.0

