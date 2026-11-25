Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592463;
	b=2NbjnzQkJqCDSM1c0eZboN369oBzoYVzY8KctNyLK8K0l1RY6zUgTphlrTLn8TGBbX36
	 qYs8Pic4/X5h77kSGzeILyk/gz+fk/bxA7dlp0nntmU2/9x3NaZgMjABLyN8ZRvTXkHor
	 KpG1PS6WeLDoqhX7BrsrB/lIHrdzPpASBNPv5XTGXpF8NY59XK4DBKFqo/wdYxcrxQS6s
	 KRgBTYIBQdr1YSmpjdD6kyG6eXSkHVHKWSjsR03ES5mkv8wEG1x+qeCUi5mPYtqo2/2bo
	 f4k/cI316/Eks/IOm3hyJVJGDmQX1Cc3Z2uMRtPHq1m/LesKrbmz3DgOJd6fky+jVPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592463;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zwD2gFi9vh6ZW+eC4S+Y2bIYG8f/jFUwY08RLcEZxHw=;
	b=SBGh6RwuAQXHe3n87+BYamG+YawMZU/o9SLievoWAozVZM8EzLKyfOnvMNT/ojQoHVIc
	 kM6DLbTW+zk5lV6nKR/n8eyfZICDRxCNTkU20qHZD41FGq9f3hfB48GHGDL1/rglYTpzE
	 RB8IF3sE4kInIqi/2Mgr2aorFT1ph4/nxijPEDCdZQmUQ8i/PwcVl9U+kmrpMw+I1tqZv
	 /bMwT04moaN0R+xdhJoHLY4fAjn4EOyhHgrJABQocXu1YR9v/bXbjxKMB/AO1rsDPIAbf
	 H6on5S6P0c+IoU4LFFlP3N5guiHjqzI2BfgSO8GauPhYhqRZ0vMwbUl/gZqGMh9EKRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=M7PwE8vs;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A062F606A32A;
	Wed, 25 Nov 2026 07:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A062F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=M7PwE8vs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1795592454;
	bh=P7KTpYs1LMqVBjyKwBggacnaC887BopGh9iQeXdurEM=;
	h=From:Date:Subject:To:Cc:From;
	b=M7PwE8vs380dVRprGT3GoYw+XTaG9mslN5VkmSpqOEx4CgTgLWc1S+hX0bkHb1Vqq
	 mDbKHGMOMa90ppqi9mrPdk0XaXqG/cwkW7KnizCScXCStYIpfxoA1iwNSItE9kbWqv
	 SJDDA6TOcHNmznHUDr1as91IyCU3QVJ3hYGRDBAY=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 93F16401EC;
	Tue, 24 Nov 2026 23:40:54 -0800 (PST)
From: Shubhang Kaushik <sh@gentwo.org>
Date: Tue, 24 Nov 2026 23:40:54 -0800
Subject: [PATCH] PM: EM: Fix netlink performance-domain dump pagination
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
Message-Id: <20261124-pm-em-dump-v1-1-8f9167d437bc@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAAWRBmsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMT3YJc3dRc3ZTS3AJdA4M0Y6MkC4u0FLNkJaCGgqLUtMwKsGHRsbW
 1AB23sh5cAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795592454; l=2959;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=P7KTpYs1LMqVBjyKwBggacnaC887BopGh9iQeXdurEM=;
 b=d6M9+D1mnKX5PKqtKcoEoWeu8nkNSVPipNM5Sd3UrFm3i+kMWwbSXaPRex6mVOeekv6PWal79
 ZZCskFlrt6SDRPYUFcLQqwE+wWNXl0grDpGMjotiBLE4s6qaNI/677j
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

GET_PERF_DOMAINS dumps performance domains through:

  netlink_dump()
    -> dev_energymodel_nl_get_perf_domains_dumpit()
      -> for_each_em_perf_domain()
        -> __em_nl_get_pd_for_dump()

The dump handler rebuilds its local cursor from cb->args[0] on each
callback.  When the response skb fills, it returns -EMSGSIZE and the
netlink core sends the nonempty skb before retrying the dump.  However,
the updated cursor is not saved in cb->args[0], so the retry restarts at
domain zero.

For example, if domains 0 and 1 fit in the first skb but domain 2 does
not, every subsequent callback emits domains 0 and 1 again and never
progresses beyond domain 2.  The handler also advances the cursor before
encoding the domain and finalizes its partially encoded message on
failure.

Advance the cursor only after a domain has been encoded successfully,
cancel incomplete messages, and store the next domain index in
cb->args[0].  Return skb->len after a successful iteration so the
netlink core sends the current chunk and continues the dump.

Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL spec")
Cc: stable@vger.kernel.org
Signed-off-by: Shubhang Kaushik <sh@gentwo.org>
---
Validation on 80-core Ampere Altra system:
- Built kernel/power/em_netlink.o and completed a full kernel build.
- The dev-energymodel YNL spec validation passed.
- Exercised an empty GET_PERF_DOMAINS dump.
---
 kernel/power/em_netlink.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 1f68d456a713c08d7a4f690e88c03182f6ee3ef1..2d15556fc49f285cf2a99bac85c8da578eb22d4f 100644
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
@@ -166,7 +172,12 @@ int dev_energymodel_nl_get_perf_domains_dumpit(struct sk_buff *skb,
 		.cb = cb,
 	};
 
-	return for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
+	int ret;
+
+	ret = for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
+	cb->args[0] = ctx.idx;
+
+	return ret ? ret : skb->len;
 }
 
 static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)

---
base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
change-id: 20261124-pm-em-dump-00f32b88fd6c

Best regards,
-- 
Shubhang Kaushik <sh@gentwo.org>

