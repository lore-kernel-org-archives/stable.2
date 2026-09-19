Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0733C1D7D
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811504; cv=none; b=mMbs22VYVFpki3WWsPKt7h02DYoUdxL/LaSWPg9HL1X1+20G7xfuBYnM0Oz4Z46tuvP9p8hCE49DEm1+x3lqNqBzLlRkX0UsR1Db/5uWCmogX8GmfwVc9dVhNh5QiNLxkZaIHbKN5EFPiavF+mvOOaWVpMEPHqo52mrnQX5PNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811504; c=relaxed/simple;
	bh=AbBsRpv9UzXwVWK/zqyx+jwn9qkbp85YmQirOeM5e4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTdnDkxNqpjTTkAkLpHydcRntJYrPf6IcISbYFHFg2FYJS69fd+/jaPtUYABqZy4ovJGfCEgSSeU3y6/F/btuX/rwVKaaWmf1tpmZ4j/eSUd/Yt5t+isehMYWzO23NF74Sso7f8FGrNquxYeHkauoOzxjOQRMNTFCs8q/Rej6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WjL9ilHI; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WjL9ilHI"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76906adso20967371cf.0
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789811500; x=1790416300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN7kbYEmkQBis/ObAIpJGpKUuIJ4yTdvvj9OToUbhYQ=;
        b=WjL9ilHItDi1CpiP5jMQX9Md6LytFUDWTX1Qr7dnf/l8Gyy7aWH2WmfsFFJErBXw54
         CCO+PptFNk1OxVN82dLwx8DFpYGcxenRWmk+Q+u8ogKrMFmfe5+vu9dRyEJplgoGJMXy
         ClTiFmAL8GV75O9Hk3xIEA/JMPAO8NfhGXHUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789811500; x=1790416300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN7kbYEmkQBis/ObAIpJGpKUuIJ4yTdvvj9OToUbhYQ=;
        b=CepoCj+6arF7co2z05tAJp3o0S7rIAfDbD5+n9qM9NfOfvv1M13aFCbQI/Smyfn47D
         Qq7pYC6Q/y1UWtK64lQOPkyPubPouRac2VpsLZwSRpJvSPpdfFymkLg9Kf07AtQOq5Hd
         bmWOjpGYSVpT2XYgEx396CDRsRGACdaaEnnufEAUq1n14oD/XUaA68jnXGcetfp0++55
         M5Jz/o1MbWxx112kCNRWNB3Oi7jd8mIH91F90TYiz00IKsDOukzED1PDlZoDc0zvnCcl
         CuK6c6XGbyqKAJCKIX6Ek1VXIvw7Er+6IHOi4NGtXuAmYw3tsuU9hLoJzo+wED1riVtm
         2dZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVNEIec1lz4G2sZH6R/IkaSEdKG7KbJGi+LzYZ7rflawYQpq0bno2g2H/wQIBdPcjaxevoY/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nJf1nAzr3T5K2499aePuUbWc2ABKEuRdy/WgEYJcnxVQwpoFCl
	/xosg5gYmfnZDcBvOqfVrZPF9sOKvcnaZ4p4KsZv7WPa3roIc330r4CzDGtW9s7itg==
X-Gm-Gg: AYBFou3bIH6Ou6VKWRs0dVaJtZkqLCIufTRxzT+JQuSDx7fkgDTpSIHhA4F0ahCyvRg
	r1DqvrwhVPYgU3jxK5ueTGBPzP+QsDTrrwul0g3mRbHVEVymc+Q8NcNieEhdDdzkmmfbMKpVbUq
	SsRcvuN52KeANPp4e0moUweK7ZQjyZqDxYUQMjj5j8EnXq3o6ueAFCOuHPk2jizLCPz5QLz3bJ6
	L1MWemtEhBPWVbqd3CNCXJqV5XNTRtCyJIbggmV+I0lcl/GllonvOLJC2U+ekGZWsR6PvLoRDBg
	09r2NbjwVc/QdmrGzgdzOowxOfEn62gXj1yoZHm5NLgWRt8GlLOOxYyTEJK1wsjg3+AhNxC9nFA
	jGpgZ2TmEopj2AZ/0fIKL44AwNvxzcLThu4QV20Rdn+wrRKpNOrqBuywuhtxMUDidm9c+SN5sQ6
	kebu13drwJil5PF2fRBhK9Xho9PgyPiVgmbi3Jm0TbYa/L8ohblZLO72JowSjrvDG69SE3A3MUv
	FLNbEBvpgjW4rhziArdZiagKySvKr2j1j4L3cld9g5HI8A0NP4RH2SeUjBV069q6fAt8QuBAdhS
	lvTX0FV+FCTGrhC09mGGAmRjzVwMDZ/jag==
X-Received: by 2002:a05:6214:4108:b0:912:517b:40e4 with SMTP id 6a1803df08f44-912a8039725mr10025936d6.43.1789811500025;
        Sat, 19 Sep 2026 02:51:40 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260aa15cdsm17150986d6.41.2026.09.19.02.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 02:51:39 -0700 (PDT)
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
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>
Subject: [PATCH net] net/sched: cls_flower: exact-match ERSPAN key when no mask supplied
Date: Sat, 19 Sep 2026 05:51:35 -0400
Message-Id: <QDISC-4CSL.v1.20260917072652@mojatatu.com>
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

Mirror the with-mask per-version defaults on the no-mask path, keyed off
the key's own version: v1 index to 0xff, v2 dir and hwid to their
exact-match masks. The mask cannot just memset the whole union -- that
would re-mask the overlapping timestamp/sgt bytes of the v2 header that
the fix (292207809486) deliberately left to 0 in erspan_opt.

This is a follow-up to commit fee10655709c ("net/sched: cls_flower:
validate mask pointer after nla_next()").

Conditions to recreate the bug: add an ERSPAN encap-opts flower filter
with a key but no mask (raw netlink, TCA_FLOWER_KEY_ENC_OPTS present,
TCA_FLOWER_KEY_ENC_OPTS_MASK absent); dump the filter and observe the
match mask is zero (wildcard) instead of exact for the supplied fields.

Fixes: 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826025123.62758-1-ljp1205831794@gmail.com
Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp1205831794@gmail.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_flower.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 1cefea571efd..f5acdeb0e2a6 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1358,17 +1358,29 @@ static int fl_set_vxlan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 
 static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 			     int depth, int option_len,
-			     struct netlink_ext_ack *extack)
+			     struct netlink_ext_ack *extack, u8 key_ver)
 {
 	struct nlattr *tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX + 1];
 	struct erspan_metadata *md;
 	int err;
 
 	md = (struct erspan_metadata *)&key->enc_opts.data[key->enc_opts.len];
-	md->version = 1;
+	md->version = key_ver;
 
-	if (!depth)
+	if (!depth) {
+		/* No mask attribute supplied: exact-match every field the
+		 * key set, keyed off the key's own version so the v2 dir/hwid
+		 * bytes are masked without touching the overlapping
+		 * timestamp/sgt bytes of the union (see 292207809486).
+		 */
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
@@ -1509,6 +1521,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 {
 	const struct nlattr *nla_enc_key, *nla_opt_key, *nla_opt_msk = NULL;
 	int err, option_len, key_depth, msk_depth = 0;
+	u8 key_ver = 1;
 
 	err = nla_validate_nested_deprecated(tb[TCA_FLOWER_KEY_ENC_OPTS],
 					     TCA_FLOWER_KEY_ENC_OPTS_MAX,
@@ -1607,9 +1620,11 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			key->enc_opts.dst_opt_type = IP_TUNNEL_ERSPAN_OPT_BIT;
 			option_len = fl_set_erspan_opt(nla_opt_key, key,
 						       key_depth, option_len,
-						       extack);
+						       extack, 1);
 			if (option_len < 0)
 				return option_len;
+			key_ver = ((struct erspan_metadata *)
+				  &key->enc_opts.data[key->enc_opts.len])->version;
 
 			key->enc_opts.len += option_len;
 			/* At the same time we need to parse through the mask
@@ -1618,7 +1633,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			mask->enc_opts.dst_opt_type = IP_TUNNEL_ERSPAN_OPT_BIT;
 			option_len = fl_set_erspan_opt(nla_opt_msk, mask,
 						       msk_depth, option_len,
-						       extack);
+						       extack, key_ver);
 			if (option_len < 0)
 				return option_len;
 
-- 
2.43.0

