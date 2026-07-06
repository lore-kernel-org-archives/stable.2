Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212223395F
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326497; cv=none; b=MnWdkTE+tWCTcDErbm/Qb1waSlf58WAh4582+sUbrDUGVKeEGv4pS8uisQaEBGZxoTCuGZsmAX6Hn8VyLLqEmgLj4wJqm3Dg5pas77zqRJo1N5+/urPmXXkMDCZusRPS8yhGyosqSG3csS366NmKk9S2oA5mqBz+M/rHSiIEcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326497; c=relaxed/simple;
	bh=LyZ7USrGTzjrwZfR+WI6R8k9aQX/v7fy5DSBrfm3HSA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EWsTF9QyU31ZtmMoK5jYT+oF2WzQH1ExpkQs1vudPsbba+x0m30OcG+7dB4GrJSsObeRG1oIn/GeQiObDwWCJko2t6HMlQIpoRDjsf7ZE0teEXpUEHtZrmzgcQ++iV860oWHG4RLgMCEJYLq5dlwvkeKKwj1Stbzeui/Wqj9ovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=J7xK8E05; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="J7xK8E05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1783326486; x=1783585686;
	bh=qOP5ugd7F6WEKBkmHSFpTwvR8Q3X0jNzSw53nWX6T5Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=J7xK8E05G81C+Pdg4wdYFM+ZkLxvlqEXo7KKOXPVqFs0U7981cAGf97iIRaIsx8n3
	 5J1KhmurHbQTwKHyv0lysl9qk3lTiTYUSqC8Jo9VI25ymMZcB3C2Fw+LyxWmHBmsBA
	 7eWwdH45ly7n+qGC5Hr3yXwSOnR+9x6gCtCPeY5oV5ETr9+wQHa1YqmG9R7jdhjpVA
	 Ct7pYwPo7TOBULwlVEuOnZDxaSmY6NdPE+vWQrQv3YKJ0UUJy0xFVccC6jdW0mQl06
	 3sm2Quf0Zegikrw1rPI1kxwQ3rdDOwFpzkPPG0Vfk71UOBYAYtgYn3ZL02PYjttNtQ
	 wxhhRitg0ZP6g==
Date: Mon, 06 Jul 2026 08:28:01 +0000
To: zach.cox@pm.me
From: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: zach.cox83@gmail.com, Asim Viladi Oglu Manizada <manizada@pm.me>, stable@vger.kernel.org
Subject: [PATCH net v3] net: openvswitch: reject oversized nested action attrs
Message-ID: <20260706082754.31451-1-manizada@pm.me>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: 8c58cb5d8a1ff8161bc5b082684e9bbb4851693d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Open vSwitch stores generated flow actions as nlattrs, whose nla_len
field is u16. Commit a1e64addf3ff ("net: openvswitch: remove
misbehaving actions length check") allowed the total sw_flow_actions
stream to grow beyond 64 KiB, which is valid, but also removed the last
guard preventing a generated nested action attribute from exceeding
U16_MAX.

An oversized generated container can thus be closed with a truncated
nla_len. A later dump or teardown then walks a structurally different
stream than the one that was validated. In particular, an oversized
nested CLONE/CT action may cause subsequent bytes in the generated
stream to be interpreted as independent actions.

Keep the larger total-action-stream behavior, but make nested action
close reject generated containers that do not fit in nla_len, and return
the error through all callers. For recursive SAMPLE, CLONE, DEC_TTL, and
CHECK_PKT_LEN builders, trim resource-owning action-list tails in reverse
construction order before discarding failed wrappers, so resources copied
into the rejected tails are released before the wrappers are removed.

Most failed outer wrappers are discarded by truncating actions_len after
child resources have been released. CHECK_PKT_LEN also trims its parent
after branch resources are gone. SET/TUNNEL close failures unwind their
known tun_dst ownership directly, and SET_TO_MASKED has no external
ownership and truncates on close failure.

Fixes: a1e64addf3ff ("net: openvswitch: remove misbehaving actions length c=
heck")
Cc: stable@vger.kernel.org
Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
---
 net/openvswitch/flow_netlink.c | 201 +++++++++++++++++++++++++--------
 1 file changed, 157 insertions(+), 44 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.=
c
index 13052408a132..d8079dee700e 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2496,13 +2496,56 @@ static inline int add_nested_action_start(struct sw=
_flow_actions **sfa,
 =09return used;
 }
=20
-static inline void add_nested_action_end(struct sw_flow_actions *sfa,
-=09=09=09=09=09 int st_offset)
+static inline int add_nested_action_end(struct sw_flow_actions *sfa,
+=09=09=09=09=09int st_offset)
 {
-=09struct nlattr *a =3D (struct nlattr *) ((unsigned char *)sfa->actions +
-=09=09=09=09=09=09=09       st_offset);
+=09struct nlattr *a;
+=09u32 attr_len;
+
+=09if (WARN_ON_ONCE(st_offset < 0 ||
+=09=09=09 (u32)st_offset > sfa->actions_len))
+=09=09return -EINVAL;
+
+=09attr_len =3D sfa->actions_len - (u32)st_offset;
+=09if (WARN_ON_ONCE(attr_len < NLA_HDRLEN))
+=09=09return -EINVAL;
=20
-=09a->nla_len =3D sfa->actions_len - st_offset;
+=09if (attr_len > U16_MAX)
+=09=09return -EMSGSIZE;
+
+=09a =3D (struct nlattr *)((u8 *)sfa->actions + st_offset);
+=09a->nla_len =3D attr_len;
+=09return 0;
+}
+
+/* Free the generated action-list tail at @start and truncate it.
+ * If @nested, @start points to its containing nlattr header.
+ */
+static void ovs_nla_trim(struct sw_flow_actions *sfa, int start, bool nest=
ed)
+{
+=09const struct nlattr *actions;
+=09u32 len;
+
+=09if (start < 0)
+=09=09return;
+
+=09if (WARN_ON_ONCE((u32)start > sfa->actions_len))
+=09=09return;
+
+=09actions =3D (const struct nlattr *)((u8 *)sfa->actions + start);
+=09len =3D sfa->actions_len - (u32)start;
+
+=09if (nested) {
+=09=09if (len < NLA_HDRLEN)
+=09=09=09goto out;
+
+=09=09actions =3D (const struct nlattr *)((u8 *)actions + NLA_HDRLEN);
+=09=09len -=3D NLA_HDRLEN;
+=09}
+
+=09ovs_nla_free_nested_actions(actions, len);
+out:
+=09sfa->actions_len =3D start;
 }
=20
 static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *at=
tr,
@@ -2522,6 +2565,7 @@ static int validate_and_copy_sample(struct net *net, =
const struct nlattr *attr,
 =09const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
 =09const struct nlattr *probability, *actions;
 =09const struct nlattr *a;
+=09int actions_start;
 =09int rem, start, err;
 =09struct sample_arg arg;
=20
@@ -2565,18 +2609,27 @@ static int validate_and_copy_sample(struct net *net=
, const struct nlattr *attr,
 =09err =3D ovs_nla_add_action(sfa, OVS_SAMPLE_ATTR_ARG, &arg, sizeof(arg),
 =09=09=09=09 log);
 =09if (err)
-=09=09return err;
+=09=09goto err;
=20
+=09actions_start =3D (*sfa)->actions_len;
 =09err =3D __ovs_nla_copy_actions(net, actions, key, sfa,
 =09=09=09=09     eth_type, vlan_tci, mpls_label_count, log,
 =09=09=09=09     depth + 1);
=20
 =09if (err)
-=09=09return err;
+=09=09goto err_free;
=20
-=09add_nested_action_end(*sfa, start);
+=09err =3D add_nested_action_end(*sfa, start);
+=09if (err)
+=09=09goto err_free;
=20
 =09return 0;
+
+err_free:
+=09ovs_nla_trim(*sfa, actions_start, false);
+err:
+=09(*sfa)->actions_len =3D start;
+=09return err;
 }
=20
 static int validate_and_copy_dec_ttl(struct net *net,
@@ -2624,18 +2677,31 @@ static int validate_and_copy_dec_ttl(struct net *ne=
t,
 =09=09return start;
=20
 =09action_start =3D add_nested_action_start(sfa, OVS_DEC_TTL_ATTR_ACTION, =
log);
-=09if (action_start < 0)
-=09=09return action_start;
+=09if (action_start < 0) {
+=09=09err =3D action_start;
+=09=09goto err;
+=09}
=20
 =09err =3D __ovs_nla_copy_actions(net, actions, key, sfa, eth_type,
 =09=09=09=09     vlan_tci, mpls_label_count, log,
 =09=09=09=09     depth + 1);
 =09if (err)
-=09=09return err;
+=09=09goto err_free;
+
+=09err =3D add_nested_action_end(*sfa, action_start);
+=09if (err)
+=09=09goto err_free;
=20
-=09add_nested_action_end(*sfa, action_start);
-=09add_nested_action_end(*sfa, start);
+=09err =3D add_nested_action_end(*sfa, start);
+=09if (err)
+=09=09goto err_free;
 =09return 0;
+
+err_free:
+=09ovs_nla_trim(*sfa, action_start, true);
+err:
+=09(*sfa)->actions_len =3D start;
+=09return err;
 }
=20
 static int validate_and_copy_clone(struct net *net,
@@ -2646,6 +2712,7 @@ static int validate_and_copy_clone(struct net *net,
 =09=09=09=09   u32 mpls_label_count, bool log, bool last,
 =09=09=09=09   u32 depth)
 {
+=09int actions_start;
 =09int start, err;
 =09u32 exec;
=20
@@ -2661,17 +2728,26 @@ static int validate_and_copy_clone(struct net *net,
 =09err =3D ovs_nla_add_action(sfa, OVS_CLONE_ATTR_EXEC, &exec,
 =09=09=09=09 sizeof(exec), log);
 =09if (err)
-=09=09return err;
+=09=09goto err;
=20
+=09actions_start =3D (*sfa)->actions_len;
 =09err =3D __ovs_nla_copy_actions(net, attr, key, sfa,
 =09=09=09=09     eth_type, vlan_tci, mpls_label_count, log,
 =09=09=09=09     depth + 1);
 =09if (err)
-=09=09return err;
+=09=09goto err_free;
=20
-=09add_nested_action_end(*sfa, start);
+=09err =3D add_nested_action_end(*sfa, start);
+=09if (err)
+=09=09goto err_free;
=20
 =09return 0;
+
+err_free:
+=09ovs_nla_trim(*sfa, actions_start, false);
+err:
+=09(*sfa)->actions_len =3D start;
+=09return err;
 }
=20
 void ovs_match_init(struct sw_flow_match *match,
@@ -2763,20 +2839,20 @@ static int validate_and_copy_set_tun(const struct n=
lattr *attr,
 =09tun_dst =3D metadata_dst_alloc(key.tun_opts_len, METADATA_IP_TUNNEL,
 =09=09=09=09     GFP_KERNEL);
=20
-=09if (!tun_dst)
-=09=09return -ENOMEM;
+=09if (!tun_dst) {
+=09=09err =3D -ENOMEM;
+=09=09goto err;
+=09}
=20
 =09err =3D dst_cache_init(&tun_dst->u.tun_info.dst_cache, GFP_KERNEL);
-=09if (err) {
-=09=09dst_release((struct dst_entry *)tun_dst);
-=09=09return err;
-=09}
+=09if (err)
+=09=09goto err_free_tun_dst;
=20
 =09a =3D __add_action(sfa, OVS_KEY_ATTR_TUNNEL_INFO, NULL,
 =09=09=09 sizeof(*ovs_tun), log);
 =09if (IS_ERR(a)) {
-=09=09dst_release((struct dst_entry *)tun_dst);
-=09=09return PTR_ERR(a);
+=09=09err =3D PTR_ERR(a);
+=09=09goto err_free_tun_dst;
 =09}
=20
 =09ovs_tun =3D nla_data(a);
@@ -2797,8 +2873,16 @@ static int validate_and_copy_set_tun(const struct nl=
attr *attr,
 =09ip_tunnel_info_opts_set(tun_info,
 =09=09=09=09TUN_METADATA_OPTS(&key, key.tun_opts_len),
 =09=09=09=09key.tun_opts_len, dst_opt_type);
-=09add_nested_action_end(*sfa, start);
+=09err =3D add_nested_action_end(*sfa, start);
+=09if (WARN_ON_ONCE(err))
+=09=09goto err_free_tun_dst;
+
+=09return 0;
=20
+err_free_tun_dst:
+=09dst_release((struct dst_entry *)tun_dst);
+err:
+=09(*sfa)->actions_len =3D start;
 =09return err;
 }
=20
@@ -2971,7 +3055,7 @@ static int validate_set(const struct nlattr *a,
=20
 =09/* Convert non-masked non-tunnel set actions to masked set actions. */
 =09if (!masked && key_type !=3D OVS_KEY_ATTR_TUNNEL) {
-=09=09int start, len =3D key_len * 2;
+=09=09int err, start, len =3D key_len * 2;
 =09=09struct nlattr *at;
=20
 =09=09*skip_copy =3D true;
@@ -2983,8 +3067,11 @@ static int validate_set(const struct nlattr *a,
 =09=09=09return start;
=20
 =09=09at =3D __add_action(sfa, key_type, NULL, len, log);
-=09=09if (IS_ERR(at))
-=09=09=09return PTR_ERR(at);
+=09=09if (IS_ERR(at)) {
+=09=09=09err =3D PTR_ERR(at);
+=09=09=09(*sfa)->actions_len =3D start;
+=09=09=09return err;
+=09=09}
=20
 =09=09memcpy(nla_data(at), nla_data(ovs_key), key_len); /* Key. */
 =09=09memset(nla_data(at) + key_len, 0xff, key_len);    /* Mask. */
@@ -2994,7 +3081,11 @@ static int validate_set(const struct nlattr *a,
=20
 =09=09=09mask->ipv6_label &=3D htonl(0x000FFFFF);
 =09=09}
-=09=09add_nested_action_end(*sfa, start);
+=09=09err =3D add_nested_action_end(*sfa, start);
+=09=09if (WARN_ON_ONCE(err)) {
+=09=09=09(*sfa)->actions_len =3D start;
+=09=09=09return err;
+=09=09}
 =09}
=20
 =09return 0;
@@ -3040,7 +3131,8 @@ static int validate_and_copy_check_pkt_len(struct net=
 *net,
 =09const struct nlattr *acts_if_greater, *acts_if_lesser_eq;
 =09struct nlattr *a[OVS_CHECK_PKT_LEN_ATTR_MAX + 1];
 =09struct check_pkt_len_arg arg;
-=09int nested_acts_start;
+=09int greater_acts_start =3D -1;
+=09int lesser_acts_start =3D -1;
 =09int start, err;
=20
 =09err =3D nla_parse_deprecated_strict(a, OVS_CHECK_PKT_LEN_ATTR_MAX,
@@ -3075,37 +3167,58 @@ static int validate_and_copy_check_pkt_len(struct n=
et *net,
 =09err =3D ovs_nla_add_action(sfa, OVS_CHECK_PKT_LEN_ATTR_ARG, &arg,
 =09=09=09=09 sizeof(arg), log);
 =09if (err)
-=09=09return err;
+=09=09goto err_free;
=20
-=09nested_acts_start =3D add_nested_action_start(sfa,
-=09=09OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_LESS_EQUAL, log);
-=09if (nested_acts_start < 0)
-=09=09return nested_acts_start;
+=09lesser_acts_start =3D
+=09=09add_nested_action_start(sfa,
+=09=09=09=09=09OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_LESS_EQUAL,
+=09=09=09=09=09log);
+=09if (lesser_acts_start < 0) {
+=09=09err =3D lesser_acts_start;
+=09=09goto err_free;
+=09}
=20
 =09err =3D __ovs_nla_copy_actions(net, acts_if_lesser_eq, key, sfa,
 =09=09=09=09     eth_type, vlan_tci, mpls_label_count, log,
 =09=09=09=09     depth + 1);
=20
 =09if (err)
-=09=09return err;
+=09=09goto err_free;
=20
-=09add_nested_action_end(*sfa, nested_acts_start);
+=09err =3D add_nested_action_end(*sfa, lesser_acts_start);
+=09if (err)
+=09=09goto err_free;
=20
-=09nested_acts_start =3D add_nested_action_start(sfa,
-=09=09OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_GREATER, log);
-=09if (nested_acts_start < 0)
-=09=09return nested_acts_start;
+=09greater_acts_start =3D
+=09=09add_nested_action_start(sfa,
+=09=09=09=09=09OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_GREATER,
+=09=09=09=09=09log);
+=09if (greater_acts_start < 0) {
+=09=09err =3D greater_acts_start;
+=09=09goto err_free;
+=09}
=20
 =09err =3D __ovs_nla_copy_actions(net, acts_if_greater, key, sfa,
 =09=09=09=09     eth_type, vlan_tci, mpls_label_count, log,
 =09=09=09=09     depth + 1);
=20
 =09if (err)
-=09=09return err;
+=09=09goto err_free;
+
+=09err =3D add_nested_action_end(*sfa, greater_acts_start);
+=09if (err)
+=09=09goto err_free;
=20
-=09add_nested_action_end(*sfa, nested_acts_start);
-=09add_nested_action_end(*sfa, start);
+=09err =3D add_nested_action_end(*sfa, start);
+=09if (err)
+=09=09goto err_free;
 =09return 0;
+
+err_free:
+=09ovs_nla_trim(*sfa, greater_acts_start, true);
+=09ovs_nla_trim(*sfa, lesser_acts_start, true);
+=09ovs_nla_trim(*sfa, start, false);
+=09return err;
 }
=20
 static int validate_psample(const struct nlattr *attr)
--=20
2.53.0

