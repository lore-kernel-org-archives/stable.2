Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1644238A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252336; cv=none; b=boSUQxvRZf03PlOJMHMVa61BhELdgs0XrP18NwKdn/27D4PlFBQ2mppqP2eX3+cYvKyIlxrqdMCLGys25hVxdqcKTpSWb7v9Mfi7MLq3Q/vpjUO43KSaEa5pksN4phGMhy9H0wTz37+dG7YZJCiMivOazEOb90tCP2d6uTo2h4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252336; c=relaxed/simple;
	bh=r6xTkVcBtG2GbnncVAFpPrHQ35sSsx6sGtwnGz+Iz+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hppbh9wKcz36Y2ncx00RN64HaciBDmgKz3DE+aogSPpis4Cuiv69XgBWcjGfm/a/Pu4EpK+Jh1viSksDAjiyaxIIpIoGFcZ/LPNvziNvDb88YoFEyfHYz2JqYgfv4nXMdrbQumdDEKwpSGzwvyZL4FM6A9ehZ7X2uBJhhOQ7hJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Ns1NFVpf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Ns1NFVpf"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90cd4631090so7838116d6.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790252334; x=1790857134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gmaeWywR1Hqkr2skYxuhciXOKcGLeDQxbIygjuGwII0=;
        b=Ns1NFVpfyd7n1KdYeOeh7plXI8koMoK8853qbCtzQ8DDNuKIhEP2bGlZeU9BF8zpRb
         wFvbDiTE89WFSJpSpmD8FePIoJEjmZPcBt9RjAL3yMFYKu8EEwM4Tah3VeX2hnKvb/Rk
         ZtXCcLjBLj70HZYhKSPzMMb6lICU0sa0lCIt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252334; x=1790857134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmaeWywR1Hqkr2skYxuhciXOKcGLeDQxbIygjuGwII0=;
        b=evek2kCEcjoIcTzMfz3uJfriDRqZhyBQXpSYArwp4eqhF08lNhAc47YAy8YK0BhKvA
         Z6EFSTFMrxhedwND0OPS7ma9Mo+nW+l5I9gFRjGAV+bL08hmjnqlWxth732WpReFqRTF
         6yk9MBfjEKrz9xKq34hDa9I245g3fCzxcNXGJISAN16WslM7d5l1XReVbNCbU3epz8g+
         8HNGT0bK9il6j9u2DAbbFZGJSkHgW/C1GvUiYUKh7YpAfVfYNBoZLaxB5HXXlkMOdD8y
         ghZ827/zTGtcEAZHUr3Cdi9nxKTUVptvOgiOe/2dRjDcO5Rths2rIzFg4coAzt77gvWg
         5qwg==
X-Forwarded-Encrypted: i=1; AKwUvBzTxkyqsueKcVzbREIT1k9qNBYFnbqv0JpH/yToU5wtn2BgZFB2P+qkJZ4oGXA3oVT/nMK26u0=@vger.kernel.org
X-Gm-Message-State: AFuF++mBZoJFKByFjRGrMuGju3KWNJzHYY7EgwaHtyENizdCN7WAJZ3V
	gtdqDs4xLEHgZ71dGsqwbxWfaUEZPZSFkEvykX0MYd2/Y83U7QMXzNESnEGRylPYCA==
X-Gm-Gg: AYBFou138LRyxYNeZ4jjN2VRuHYne//gvFmJ8eT1cbQrTsSoPcncIncbDokHPfCFs5f
	OXwj6Q+vMmvuNRIEXpxi3v800/hkEOl8kh1xJB+PUuKwiFwX1lHGzVcm123Pkxzr2J+cAp2u8fH
	jv+zwWrUW1C0j+CtBPrQ5yRavbjC0OxChzsjPvIc6q9rKWa+D/oHjX2x7aCcCbbAO54KQT2Dnfi
	oLDV9mkUfzVrKm8z+y3Yy9Z6WLCR02QjCIR3Kfn6MzIKCx1dRPudEIYI8NUe0wEJTGb86hqbfm8
	kAL/USvaG7NiUvLaMA1RfnYNqhnddsNKc7Sh8BEidpvIbDnJt/KPNuj4n45+s/Moji+wLvfenIw
	yLUjjWuUo/emA1JcqTAXu6a4T/cjDyyBjsy8ilpcT2+6u/jtHNQTUdISximvNg2O4vGnAsOI9yS
	DkK9JNXogz90dFD5vfIZUdenymwvK3T93loEQFI+KtTp3c0CIoJEZ56QBbb6sjsxZXUgwbsfCqa
	DwzCkUMNJf6a3rML5rNFR2WLX/MisspH1UNaSEE3GH+qiU8Hg==
X-Received: by 2002:a05:6214:1bc6:b0:912:35b7:8a9a with SMTP id 6a1803df08f44-91421f03ed7mr18489976d6.20.1790252333506;
        Thu, 24 Sep 2026 05:18:53 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e2c6c90sm15211926d6.45.2026.09.24.05.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:18:53 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	hybris <hybris@mojatatu.ai>
Subject: [PATCH net v2] net/sched: cls_flower: exact-match ERSPAN key when no mask supplied
Date: Thu, 24 Sep 2026 08:18:41 -0400
Message-Id: <QDISC-4CSL.v2.20260924114800@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
removed the unconditional memset of the erspan_metadata mask in
fl_set_erspan_opt(). On the mask-parse pass, when userspace supplies the
encap option key but no mask (TCA_FLOWER_KEY_ENC_OPTS without
TCA_FLOWER_KEY_ENC_OPTS_MASK), the !depth early return leaves the mask
zeroed -- a wildcard. A filter keyed on an ERSPAN index (v1), or dir/hwid
(v2), then matches every ERSPAN packet's values instead of exact-matching.

Default the match fields on the no-mask path the same way the with-mask
branches default them: v1 index to 0xff, v2 dir and hwid to their
exact-match masks. The union cannot just be memset to 0xff -- that would
re-mask the overlapping timestamp/sgt bytes of the v2 header that the
commit deliberately left to 0.

A mask and a key that declare different ERSPAN versions describe different
union layouts, so the mask would silently wildcard the key's matched
fields. Reject that combination. Have fl_set_erspan_opt() report the
parsed key's version back through a u8 pointer so the mask pass uses it
without re-reading the union.

This is a follow-up to commit fee10655709c ("net/sched: cls_flower:
validate mask pointer after nla_next()").

Conditions to recreate the bug: add an ERSPAN encap-opts flower filter
with a key but no mask (raw netlink, TCA_FLOWER_KEY_ENC_OPTS present,
TCA_FLOWER_KEY_ENC_OPTS_MASK absent); dump the filter and observe the
match mask is zero (wildcard) instead of exact for the supplied fields.
For the mismatch case, pair a v1 key with a v2 mask (or vice versa) and
observe the request is accepted with a mask of the other version.

Fixes: 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826025123.62758-1-ljp1205831794@gmail.com
Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp1205831794@gmail.com/
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/netdev/179003833955.2160803.1077681716391858800@kernel.org/
Suggested-by: Xin Long <lucien.xin@gmail.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Scope the key's version default to the no-mask path only. v1 assigned
  the key's version to the mask unconditionally, which changed the
  with-mask parse path for a mask nest that declared no version (nipa M1).
- Reject a mask whose declared version differs from the key's; the two
  versions index different union layouts, so the mismatch silently
  wildcarded the key's matched fields (nipa M2).
- Set the key's parsed version through a u8 pointer argument rather than
  re-reading it from the union at the call site (Xin Long).

 net/sched/cls_flower.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 1cefea571efd..0c4beff18d68 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1358,17 +1358,29 @@ static int fl_set_vxlan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 
 static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 			     int depth, int option_len,
-			     struct netlink_ext_ack *extack)
+			     struct netlink_ext_ack *extack, u8 *key_ver)
 {
 	struct nlattr *tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX + 1];
 	struct erspan_metadata *md;
 	int err;
 
 	md = (struct erspan_metadata *)&key->enc_opts.data[key->enc_opts.len];
-	md->version = 1;
 
-	if (!depth)
+	if (!depth) {
+		/* No mask attribute supplied: exact-match every field the
+		 * key set, keyed off the key's own version so the v2 dir/hwid
+		 * bytes are masked without touching the overlapping
+		 * timestamp/sgt bytes of the union (see 292207809486).
+		 */
+		md->version = *key_ver;
+		if (md->version == 1) {
+			memset(&md->u.index, 0xff, sizeof(md->u.index));
+		} else if (md->version == 2) {
+			md->u.md2.dir = 1;
+			set_hwid(&md->u.md2, 0xff);
+		}
 		return sizeof(*md);
+	}
 
 	if (nla_type(nla) != TCA_FLOWER_KEY_ENC_OPTS_ERSPAN) {
 		NL_SET_ERR_MSG(extack, "Non-erspan option type for mask");
@@ -1387,6 +1399,22 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 
 	if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER])
 		md->version = nla_get_u8(tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER]);
+	else
+		md->version = 1;
+
+	/* The key and mask must describe the same union layout: the
+	 * per-version default below only exact-matches the fields of its own
+	 * version, so a mask version that differs from the key's would
+	 * silently wildcard the key's matched fields.  A mask without a
+	 * version keeps the historical v1 default.
+	 */
+	if (option_len && md->version != *key_ver) {
+		NL_SET_ERR_MSG(extack, "Tunnel key erspan option ver mismatch");
+		return -EINVAL;
+	}
+
+	if (!option_len)
+		*key_ver = md->version;
 
 	if (md->version == 1) {
 		if (!option_len && !tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX]) {
@@ -1509,6 +1537,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 {
 	const struct nlattr *nla_enc_key, *nla_opt_key, *nla_opt_msk = NULL;
 	int err, option_len, key_depth, msk_depth = 0;
+	u8 key_ver = 1;
 
 	err = nla_validate_nested_deprecated(tb[TCA_FLOWER_KEY_ENC_OPTS],
 					     TCA_FLOWER_KEY_ENC_OPTS_MAX,
@@ -1607,7 +1636,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			key->enc_opts.dst_opt_type = IP_TUNNEL_ERSPAN_OPT_BIT;
 			option_len = fl_set_erspan_opt(nla_opt_key, key,
 						       key_depth, option_len,
-						       extack);
+						       extack, &key_ver);
 			if (option_len < 0)
 				return option_len;
 
@@ -1618,7 +1647,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			mask->enc_opts.dst_opt_type = IP_TUNNEL_ERSPAN_OPT_BIT;
 			option_len = fl_set_erspan_opt(nla_opt_msk, mask,
 						       msk_depth, option_len,
-						       extack);
+						       extack, &key_ver);
 			if (option_len < 0)
 				return option_len;
 
-- 
2.43.0

