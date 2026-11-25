Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630234;
	b=BMw2hXSRJbSS4JyazaxThzsW5b6O6HQiIExSIwh9cUeKFwoPdEmzU3Kb8Xf4We6qW8Tq
	 dpdXr83nP+wPg5+KhKe6d5REGArHw9pboHQ7IwYVNn0R7QYyO+e+beXe2qLbqVJTr/jY/
	 EB7PGNhZPoUX7sLT12TtWbjilfKNALN1he2GCQtpFoQnmpfvGYxirdBJzP23q0xBNWl3x
	 6/qNHwq8GUqlMRWzo3PpqFPbfFhIIada9aloHdUDvcGUDoxQXFzClx/6VP7jC79XJDSbU
	 dZGlArvMXIngP6idxflkM9tFR8lAQXEIRgUaR64eimiGTK6/H2F+aLxd1GiOUE9hmVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630234;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aazdsFJdydPkDwPUPcHqqU9AYDCucpKW1m1694cDDFQ=;
	b=2h1ptJDntnQu9rtTJOyksulg3qTy8OYPtm5Zvxkj0VvoM+62X55Uv3NXwSAQJr5ZFaRr
	 yn/k3fLxVTqLgm8t9mQ4THVEd/jIghGzlX0E2xm1SvbxHfIOlo6y73mILzqd94mknoCGF
	 0qoOA7/0d/+BMm3O0PyXhYCjn7fLEQ8t0KqtYqkHSpiT4NRriypObtEhtuoHALnH2vniO
	 +HkF3Ty+0rrX8voEAPjZr4zchh4GmFLbQqCNZYuGAAHjgncHvfnmsWKTKFMTbAy5NKXF5
	 2X+UUvXNPPjakvvvHGg/KSlLqHtpHnnjVvpesM2Cvba38MKEt72yDw8Rx4p32Xn0QWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=jBJvuCOw;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502EC606A337;
	Wed, 25 Nov 2026 18:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 502EC606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=jBJvuCOw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1795630233;
	bh=PW5cjO4zVuWmr+Vc4tjomkbgnxKceK86WHlBvpMe3N0=;
	h=From:Date:Subject:To:Cc:From;
	b=jBJvuCOwqycfhmWjkdSJF7ENLmj/xlACCo8dGrLuG3jhrQLM/g6glZYsl74IkD6ZA
	 bJiHW5hIIfqldjRdgvAVpap27HAZXejBhGzHPAP8drnmrhxFCjjsi51KSg6vUAWA/k
	 3TaZg0v7Mnal+OXstJ3nNrO2tTFY6TWwWUvLzdgs=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 290EC401B0;
	Wed, 25 Nov 2026 10:10:33 -0800 (PST)
From: Shubhang Kaushik <sh@gentwo.org>
Date: Wed, 25 Nov 2026 10:10:25 -0800
Subject: [PATCH v2] PM: EM: Fix netlink performance-domain dump pagination
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-pm-em-dump-v2-1-a28e132f8b0c@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAJAkB2sC/23MQQ6CMBCF4auQWTuGFlKqK+9hWAidlllASYtVQ
 3p3K2uX/0vet0OkwBThWu0QKHFkv5SQpwrG6bE4QjalQdZSCSFbXGekGc1zXrGubSMHra1RI5T
 DGsjy+8DufemJ4+bD57CT+K1/mSRQoLYXoTrTNt0w3hwt28uffXDQ55y/rJWqqaUAAAA=
X-Change-ID: 20261124-pm-em-dump-00f32b88fd6c
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Changwoo Min <changwoo@igalia.com>, Shubhang Kaushik <shubhangpk@gmail.com>, 
 Christoph Lameter <cl@gentwo.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, stable@vger.kernel.org, 
 Shubhang Kaushik <sh@gentwo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795630233; l=3335;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=PW5cjO4zVuWmr+Vc4tjomkbgnxKceK86WHlBvpMe3N0=;
 b=WOEqKRNwC7ibhIfs8oHOD0A5Ytc+Pz6GxJZG/2IilyUS30Iq8yLvUffNEWKeDa8YvMTF+Z9q6
 H1qRXjDGqyUCfK3HqdApbAHXvwbQgAz67KB+VemV5rPB+YPe0Wr48iX
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

GET_PERF_DOMAINS dumps performance domains through:

  netlink_dump()
    -> dev_energymodel_nl_get_perf_domains_dumpit()
      -> for_each_em_perf_domain()
        -> __em_nl_get_pd_for_dump()

The dump handler rebuilds its local cursor from cb->args[0] on each
callback. When the response skb fills, it returns -EMSGSIZE and the
netlink core sends the nonempty skb before retrying the dump. However,
the updated cursor is not saved in cb->args[0], so the retry restarts at
domain zero.

For example, if domains 0 and 1 fit in the first skb but domain 2 does
not, every subsequent callback emits domains 0 and 1 again and never
progresses beyond domain 2. The handler also advances the cursor before
encoding the domain and finalizes its partially encoded message on
failure.

Advance the cursor only after a domain has been encoded successfully,
cancel incomplete messages, and store the next domain index in
cb->args[0]. Return skb->len whenever data was written so netlink_dump()
sends the current chunk and continues the dump, propagating errors only
when skb->len is zero.

Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL spec")
Cc: stable@vger.kernel.org
Signed-off-by: Shubhang Kaushik <sh@gentwo.org>
---
Changes in v2:
- Return skb->len whenever data has been written to the skb, propagating
  negative error codes only when skb->len == 0.

Testing:
- Validated dev-energymodel YNL spec and exercised GET_PERF_DOMAINS
  dumps via tools/net/ynl/pyynl/cli.py on an 80-core Ampere Altra,
  including registering 4 test performance domains and forcing
  per-domain -EMSGSIZE splits across multiple netlink_dump() chunks.

Link to v1: https://lore.kernel.org/r/20261124-pm-em-dump-v1-1-8f9167d437bc@gentwo.org
---
 kernel/power/em_netlink.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 1f68d456a713c08d7a4f690e88c03182f6ee3ef1..4e85439ed76d240e013cf372dcbc77b3af28d598 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -80,19 +80,25 @@ static int __em_nl_get_pd_for_dump(struct em_perf_domain *pd, void *data)
 	void *hdr;
 	int ret;
 
-	if (ctx->idx++ < ctx->start)
+	if (ctx->idx < ctx->start) {
+		ctx->idx++;
 		return 0;
+	}
 
 	info = genl_info_dump(ctx->cb);
 	hdr = genlmsg_iput(ctx->skb, info);
-	if (!hdr) {
-		genlmsg_cancel(ctx->skb, hdr);
+	if (!hdr)
 		return -EMSGSIZE;
-	}
 
 	ret = __em_nl_get_pd(pd, ctx->skb);
+	if (ret) {
+		genlmsg_cancel(ctx->skb, hdr);
+		return ret;
+	}
+
 	genlmsg_end(ctx->skb, hdr);
-	return ret;
+	ctx->idx++;
+	return 0;
 }
 
 struct em_nl_doit_ctx {
@@ -166,7 +172,15 @@ int dev_energymodel_nl_get_perf_domains_dumpit(struct sk_buff *skb,
 		.cb = cb,
 	};
 
-	return for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
+	int ret;
+
+	ret = for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
+	cb->args[0] = ctx.idx;
+
+	if (ret && !skb->len)
+		return ret;
+
+	return skb->len;
 }
 
 static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)

---
base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
change-id: 20261124-pm-em-dump-00f32b88fd6c

Best regards,
-- 
Shubhang Kaushik <sh@gentwo.org>

