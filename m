Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806359;
	b=WDkJ9XI2ScYi+NUDKpR5BY6iOQc3RG2UH4tdxqvGsfTZg7O21GikzCPA+xAlOukEMTR1
	 uH+d/eB3kzgxk43w13UFXzFjYMIW61wUxwRkCy6y4FF04tcx7keP6t+bX4B4ISEHzRYkO
	 m2VQ6m9EEl8lygf5wr7VLyN4Rf0OyrhWv/GygLTLFcQVQjV8xmaTP/Q0DHgCyw8XFjByW
	 XVKSahdLdTg4rRF4JU55uQgbGRUPBNSVn/NkeTuXvyPYwVwVgtq9y6jV5ImjonQIMi76O
	 9aPGBE9xF148p0sKu8DKAVuap77uP1gcw/p7qX87WgObnHs6IeEhOr2yj6GWCFf7cHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806359;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lJoXz0o2P2PJ0kigWrWKsw431whzKnBOASh94NEKZq0=;
	b=ykGsKGHynrHZ07LeTYAluRSzn0l60tLTTp6ehcJH80sgCcLUpsIEsHD5XA/tEmw2HLDN
	 ZSokNLJz8wQlpe3fbpurolwkGG6yC8Z3T2pR0E/6cEfYnbWc6GS62I4EluMdZGkCZpPi3
	 azU9AaF9ObqOTkXlL0qPg71bFeELbjCCe4Iw3vNDULd5bAzH7HJh6KZcioNxDbnj/pONu
	 otGqST58tF+ufVak5a09SS98Cd5zTmXAkl3+cUOoLMimUf7vyaX1LcsvjH0Utltjvv16f
	 t7m81sqIXDXhc6TmFe7iIMvLpV3FVd1pgvsl5z19jlrdfDa5woOJ1spvZR/8ROj+EbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=I8qrBM8Z;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6E606A32F;
	Fri, 27 Nov 2026 19:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89F6E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=I8qrBM8Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1795806358;
	bh=RpwVXva1P+YBTg0GoMe69hnr0JfoIWjFwqXz7oRI7EQ=;
	h=From:Date:Subject:To:Cc:From;
	b=I8qrBM8Zvczj2qeh0ZwsjZ8CNugcM3yT2yKgX8WgPAJg9aq1Hm0eiaRInr4xRRnrg
	 3NHmhNkipFIvu5+6zKePIbZvUXniFSpudV33SGtFswlZaBkQGMMnqfotz4os+OmPof
	 jSYxZtnhYiryxErJGw0WUCew0IrUg3eplGJBGB1Y=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 2ABE9401F8;
	Fri, 27 Nov 2026 11:05:58 -0800 (PST)
From: Shubhang Kaushik <sh@gentwo.org>
Date: Fri, 27 Nov 2026 11:05:58 -0800
Subject: [PATCH v3] PM: EM: Fix netlink performance-domain dump pagination
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
Message-Id: <20261127-pm-em-dump-v3-1-c554e4376c98@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAJXUCWsC/23MQQ6CMBCF4auQWVvTThEqK+9hXACdQhdQ0mLVE
 O5uYSWJy/eS718gkLcUoMoW8BRtsG5MQ54yaPt67IhZnTYgx0IIzNk0MBqYfg4T49xIbJQyumg
 hgcmTse89dn+k3dswO//Z21Fs799MFEwwZa6iKHUuy6a9dTTOL3d2voOtE/HXXg4Wk61RkZBoV
 MOPdl3XL7ZszMHhAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795806358; l=3598;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=RpwVXva1P+YBTg0GoMe69hnr0JfoIWjFwqXz7oRI7EQ=;
 b=rE5i0HTLDaFK+aRsQrqHPFvenF0o+5R2GVvqhnjr/F17TDI//VSueztFL7k1evknSIr8+NL1m
 K4dg+2RFSE9CGQ2ZW7JlRQQjQKuv95IxsflrCFIXfbtJY3vk8BO8YFD
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
cb->args[0]. Return the iterator status directly: netlink_dump() already
continues a dump when -EMSGSIZE is returned with a nonempty skb, while a
successful final traversal returns zero and completes the dump.

Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL spec")
Cc: stable@vger.kernel.org
Signed-off-by: Shubhang Kaushik <sh@gentwo.org>
---
Testing:
- Validated dev-energymodel YNL spec and exercised GET_PERF_DOMAINS
  dumps via tools/net/ynl/pyynl/cli.py on an 80-core Ampere Altra,
  including registering 4 test performance domains and forcing
  per-domain -EMSGSIZE splits across multiple netlink_dump() chunks.

Changes in v3:
- Return the iterator status directly after saving the cursor, avoiding
  an extra final dump callback after a successful traversal.

Link to v2: https://lore.kernel.org/r/20261125-pm-em-dump-v2-1-a28e132f8b0c@gentwo.org
---
 kernel/power/em_netlink.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 1f68d456a713c08d7a4f690e88c03182f6ee3ef1..077844d3a68220d68d98bd4d27fabf4c5d8aa690 100644
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
@@ -159,6 +165,7 @@ int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
 int dev_energymodel_nl_get_perf_domains_dumpit(struct sk_buff *skb,
 						struct netlink_callback *cb)
 {
+	int ret;
 	struct dump_ctx ctx = {
 		.idx = 0,
 		.start = cb->args[0],
@@ -166,7 +173,10 @@ int dev_energymodel_nl_get_perf_domains_dumpit(struct sk_buff *skb,
 		.cb = cb,
 	};
 
-	return for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
+	ret = for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
+	cb->args[0] = ctx.idx;
+
+	return ret;
 }
 
 static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)

---
base-commit: 822ba3a89c7896b26e4beb70e2ebffb881924dfe
change-id: 20261124-pm-em-dump-00f32b88fd6c

Best regards,
-- 
Shubhang Kaushik <sh@gentwo.org>

