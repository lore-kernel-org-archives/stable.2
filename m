Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC10346774
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666186; cv=none; b=W+j0RVaBn7ST/HW54/x0QfAwZvTPolto/pwJk++bZoUcUz9y9X50dbXpbDA+qdxcEtHpXnknirIv4mbHB3fPFt5i3sLqB1REVIW/WhLqlQnGdeQ2iGgO1dwHCZsPL6bqtuK8LhSFuQUoPcwHyObPCTB64SKXSwzi8M2pD+j0Yu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666186; c=relaxed/simple;
	bh=nFM1yEWaP6vg23VPHbRfkQhYXP1jb3683txd71NEY5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUtEWvfiZPv6nxYxAFW2/nMuqInGNCqihgDoxtDT2+pdBbbcL2NMpaFF+Lw0El0EF0NtLpcnRjKypmfUfCznyYuPvhgLAz6tYatkRL5l67RNks0i98GaxRe0KRx34tAEvxzlB9AuJWOG4ckeC67RBCCJg0IX0+rQvmQOkkjhtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=yUn9ZO1d; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="yUn9ZO1d"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917a04338c1so10761646d6.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791666184; x=1792270984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtRkR4RkEnODcw9fcyE1cbkI9LnR6v3FBNCmsOCW3Ig=;
        b=yUn9ZO1dLEzAix/BD74ioOkhSPK4v9N67AYkm2PlbB3vlMVjtCp/YBBhlwzDQcHBgT
         PLf+8gYHuk8jPUph192jisY7eHtN4yFYw2dmv9/+3/vu/GeT2TsGmqfGuN9LtZMbRHfO
         W0ktGAE1GhG5F14vFzY8yLLooV398FOXdIObg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791666184; x=1792270984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtRkR4RkEnODcw9fcyE1cbkI9LnR6v3FBNCmsOCW3Ig=;
        b=ytmwsFn5LZOSGYWXBDayQNm+Qy8u4N0y3IqiRw4U4tHduCl9rQ+KKipmbpuotV1c84
         0Y06jeB3cH4qdpCgI3OkNbxJ/MxxQufVDt7E1HmBiApCFuzNiOdo/1nJiG4N2eQiytok
         yDfmkpu5Rk4w3DBwdh1dd6sUVlWhjvjRIbMgtzy0vv1uBItad83ZHdYm90GTUopVDGqy
         XDqCNrOytvkCXmGm8KSQ6RZaRLtVdd2Jh3boGxzdJUOS+0rqb0Zae+W49VzBVhz45S6p
         oVo0drZINlKseU1IjFcMLTcjX0ZT2mHzM/ntbNxPgOXyT9FSPwBx6ghbp8DPDB++kBg6
         vTAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbb/Lu9SrhBRwIVh2LC/yV5952Fo1AtJHFbLp1uZAvCochvwfuruf/vUl2/xbNPf9JTSjEgGw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEA88f3DzI2OPeFJ0+Zjk/wmyx1SsDsxY01w24G6DOoiAXQuXL
	I+T/3voC5sWakVShqrwfAsVZ/th4ToNzTGFYgMhMQoFkME0vspodYGQ5uwM824AgKw==
X-Gm-Gg: AYBFou1aZJlb08YuYSZzunT5TU3xUiXuQCIm8T8EGM2xRg6AQhoQ8LZHFiU0p5HuIj5
	uqqZJD9yjIlN7b/2qb87pare4kCjwiJhKAViQ+p61hq6LDnHw7XEDB+LZBhtNhUo6ON0nB9CKU3
	RTftkJZ3CwI5Fhtf9j+AXAK1Vcc5pTZpegI3TtHaGiCCY3NhEQ4jm16nsRfgin7USmzhrjSkvD2
	pYYh6U3JNh4dvlZxoZKL8trC514PQWm5uLcrJkfKOUuKKqKGQKN3HI6CGWZddPHNeDFxfOKNj29
	IVesy8e3LZVfguaApwaOx4YSKhcRml6MUwW8RcIy66LuLFkTtL1+NDWX/vYoit7vDjlfAKuVIxH
	DlIusWV5bsA71dL2h+hzO7XiQSjTsxYS5zw/1E4NP0F/r11bbfwzhLEdUnIcdKyek2yy3MYuzGH
	kjA/uYIClLdyIwjKM4v1s/cXuiTbvyIqalyfliwUaZt+PthUYhAeRR5W0kBjDau+qtMahLs1+Pk
	PieXocw+e8GFOO9Xq4We9SKQiPb5fsCNC00Aznha9MX
X-Received: by 2002:a05:620a:17a3:b0:93c:89a0:bf82 with SMTP id af79cd13be357-93ebd209171mr987739885a.43.1791666184083;
        Sat, 10 Oct 2026 14:03:04 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984845csm498538085a.14.2026.10.10.14.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:03:03 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	victor@mojatatu.com
Subject: [PATCH net v2 2/3] net/sched: cls_bpf: accept dev-bound programs on shared blocks
Date: Sat, 10 Oct 2026 17:02:49 -0400
Message-Id: <QDISC-PYC7.v2.20261010165947-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
References: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue:
Follow-up to commit 120977e2c096 ("net/sched: cls_bpf: reject dev-bound
programs bound to a different device"), which derived the target device
from block->q:

	dev = block->q ? qdisc_dev(block->q) : NULL;

tcf_block_create() leaves block->q NULL for shared blocks, so a
device-bound program attached through a shared block is rejected with
-EINVAL even when it is bound to a netdev that owns the block.  The
offload path (cls_bpf_offload_cmd()) never consults block->q and drives
the per-device callbacks for shared blocks as before.

The Fix:
Accept the attach on a shared block when bpf_offload_dev_match() matches
every netdev bound to the block, and reject an empty block.  Every member
must match because the offload path broadcasts the program to every
callback registered on the block, so an any-member check would re-admit
the wrong-device attach on a mixed block.  Every dev-bound SCHED_CLS
attach is skip_sw, which becomes err_stop and aborts the offload on the
first failing callback, so the all-members rule is the offload path's own
semantics.

Iterate the public block->ports xarray (913b47d3424e, v6.8-rc1) rather
than block->owner_list, which is private to cls_api.c.  The shared-block
rejection reports "Program is not bound to every device in the block",
distinct from the non-shared message, because a member can exist without
a registered callback (netdevsim registers its block callback
ingress-only).

Context note:
This patch is not an independent fix: it re-exposes the shared-block
replay path that commit 120977e2c096 ("net/sched: cls_bpf: reject
dev-bound programs bound to a different device") had closed, so patch 1
must be applied first, including in stable.  A stable tree taking this
patch alone would re-enable shared-block attaches on a kernel whose
netdevsim callback is still unchecked.

Conditions to recreate the bug:
  - CONFIG_NETDEVSIM=y, CONFIG_NET_CLS_BPF=y
  - load a dev-bound SCHED_CLS program for netdevsim device B
    (prog_ifindex=B), pin it in bpffs
  - tc qdisc add dev B ingress_block 22 clsact
  - tc filter add block 22 ingress bpf da object-pinned <pin> skip_sw
  Unfixed, the filter add fails with -EINVAL ("Program is bound to a
  different device"); fixed, it succeeds.  Adding a second, independently
  backed netdevsim device to the same block makes the attach fail again.

Fixes: 120977e2c096 ("net/sched: cls_bpf: reject dev-bound programs bound to a different device")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/
Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatatu.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2 (v2 of an on-list patch; v1 posted 2026-10-04):

- Finding (nipa Sashiko High, v1) -- FIXED: the
  every-member predicate is enforced only at add/replace, but a netdev
  joining a shared block later is replayed the stored filter by
  cls_bpf_reoffload() before it is inserted into block->ports
  (tcf_block_offload_bind precedes the xa_insert).  Neither
  cls_bpf_reoffload() nor nsim_bpf_setup_tc_block_cb() checked
  bpf_offload_dev_match(), so the B-bound program was installed on the
  joining device (re-opening the 120977e2c096 mixed-block defect).
  Fixed by enforcing the device match in nsim_bpf_setup_tc_block_cb()
  (drivers/net/netdevsim/bpf.c), mirroring nfp.
- Style (gemini + nipa Low) -- FIXED: the shared-block comment opens with
  /* on its own line.
- The companion selftest exercises shared-block and late-join coverage,
  pinning both the all-members predicate and this callback's replay gate.
- Split the single v2 draft into [PATCH net v2 1/3] netdevsim,
  2/3 cls_bpf and 3/3 selftests, each with its own Fixes: and stable
  metadata.
---
 net/sched/cls_bpf.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 188cf0f949dd..bbd2dc2f518f 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -392,11 +392,31 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 	if (bpf_prog_is_dev_bound(fp->aux)) {
 		struct tcf_block *block = tp->chain->block;
 		struct net_device *dev;
+		unsigned long ifindex;
+		bool match = false;
+
+		/* A shared block has no qdisc of its own, but it may bind
+		 * several netdevs and the program is offloaded to all of them;
+		 * require a match with every member.
+		 */
+		if (!tcf_block_shared(block)) {
+			dev = qdisc_dev(tcf_block_q(block));
+			match = bpf_offload_dev_match(fp, dev);
+			if (!match)
+				NL_SET_ERR_MSG(extack,
+					       "Program is bound to a different device");
+		} else {
+			xa_for_each(&block->ports, ifindex, dev) {
+				match = bpf_offload_dev_match(fp, dev);
+				if (!match)
+					break;
+			}
+			if (!match)
+				NL_SET_ERR_MSG(extack,
+					       "Program is not bound to every device in the block");
+		}
 
-		dev = block->q ? qdisc_dev(block->q) : NULL;
-		if (!dev || !bpf_offload_dev_match(fp, dev)) {
-			NL_SET_ERR_MSG(extack,
-				       "Program is bound to a different device");
+		if (!match) {
 			bpf_prog_put(fp);
 			return -EINVAL;
 		}
-- 
2.43.0

