Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39811E5018;
	Tue, 22 Sep 2026 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038342; cv=none; b=UaBKkUwRIj1UyaHOxetnM1+T4FlMNNbGacHz/QJTqSkCwXElnte4kB/peRxYmZT27oJl5v2h9CCLTdDMdQaKWYMN1xpdVZjl4RvVly+ijTihHLHzuDcq0d/i26Koxilg+1ZvUI5BDtZKxeYv4w8GMZvEhpGiVGaLjpFkqySdD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038342; c=relaxed/simple;
	bh=jgBsX7FAV5oDd2oOXMvH1Jh5Z5pxqXPnJ8e03LRnEzo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQCLRSQjFGgyV+YTVWU1P70UMEIpOHemmYmbLC0PXcCleq1yAzRfLn+2lf1dotmT9MIkLsdZ40AzL4mCmmM9O4IOIxMZe8i5QecUDZIV+kjQ18c/ie3TEIaWEi2pMUi/w9WSz/EXzqOz+Q41ji9duLjvLZH5+r3he0pcgnvXzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o22NdFXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o22NdFXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3BF1F000FF;
	Tue, 22 Sep 2026 00:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038340;
	bh=MzlgyGwni36NksVGKgpjqa97YisqARKiIv8Qy0mTJZI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=o22NdFXR+/gxOkR3ka0J77dccwO6NDujmg7o2HExgz7+v+viqUmLO0lwadR/FS2fz
	 JlKTYWVSJbhE/2PRhTPQGYuOFJrkycvWJUcIJfB3KAnvHjq36dILENPffoWR3PsNpu
	 0MNR/fpdP8ZhXkC+zu4T5Ht+gCn7cW9a8RuKpAsdAuJtTdQu8xj/cRVKXEhZrQUL+X
	 OTUlc3IJSD+/rC7PeeAe5vizYQpgshnYJp1gAaQaypvIdZvD1UBEsD1O6km2u70lkc
	 BlgSHRoJVF5p+16xI2DGpNTl5IDNAY8vQxWqgUaj0GMUsC50kEmt/bRWmnmgZXNqRi
	 AqoVZioNMrchQ==
Subject: Re: [PATCH net] net/sched: cls_flower: exact-match ERSPAN key when no
 mask supplied
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 lucien.xin@gmail.com, stable@vger.kernel.org, sashiko-bot@kernel.org,
 victor@mojatatu.com, hybris@mojatatu.ai
Date: Tue, 22 Sep 2026 00:52:19 +0000
Message-ID: <179003833955.2160803.1077681716391858800@kernel.org>
In-Reply-To: <QDISC-4CSL.v1.20260917072652@mojatatu.com>
References: <QDISC-4CSL.v1.20260917072652@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Undisclosed behaviour change on the *with-mask* ERSPAN parse
  path.
- [Medium] The patch threads the key's ERSPAN version into the mask parse
  as a *default* only and never validates it, so a mask nest may still…

Pre-existing issues:
- [Low] The selftest match_erspan_opts_test() in
  tools/testing/selftests/net/forwarding/tc_flower.sh (lines 679-726)…
- [Low] The flower ERSPAN index attribute is consumed as big-endian but
  declared as a host-endian u32 in both of its declarations.

--

net/sched: cls_flower: exact-match ERSPAN key when no mask supplied

This patch makes fl_set_erspan_opt() fill in per-version exact-match mask
defaults when userspace supplies TCA_FLOWER_KEY_ENC_OPTS without
TCA_FLOWER_KEY_ENC_OPTS_MASK, instead of leaving the mask blob zeroed.
To do so it threads the key blob's ERSPAN version into the mask parse pass
via a new key_ver argument.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826025123.62758-1-ljp1205831794@gmail.com
Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp1205831794@gmail.com/

A few questions below.

> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 1cefea571efd..f5acdeb0e2a6 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -1358,17 +1358,29 @@ static int fl_set_vxlan_opt(const struct nlattr *nla, struct fl_flow_key *key,
>  
>  static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
>  			     int depth, int option_len,
> -			     struct netlink_ext_ack *extack)
> +			     struct netlink_ext_ack *extack, u8 key_ver)
>  {
>  	struct nlattr *tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX + 1];
>  	struct erspan_metadata *md;
>  	int err;
>  
>  	md = (struct erspan_metadata *)&key->enc_opts.data[key->enc_opts.len];
> -	md->version = 1;
> +	md->version = key_ver;

[Severity: Medium]
Is the with-mask path also meant to change here?  The assignment sits
above the if (!depth) block, so it runs on the mask pass too, not only
on the no-mask path the changelog and the new comment describe.

On the mask pass option_len is the non-zero value returned by the key
pass (sizeof(struct erspan_metadata)), so in fl_set_erspan_opt() this
guard never fires:

	if (!option_len && !tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER]) {
		NL_SET_ERR_MSG(extack, "Missing tunnel key erspan option ver");
		return -EINVAL;
	}

A mask nest that omits TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER is therefore
accepted.  Before this patch such a mask always defaulted to version 1
and took the v1 branch (index bytes memset to 0xff, dir/hwid left
wildcarded, mask blob version 1).  With a v2 key it now defaults to 2
and takes the v2 branch instead (md2.dir = 1, set_hwid(0xff), index
bytes left at 0).

That changes which packets match, what fl_dump_key_erspan_opt() emits
for TCA_FLOWER_KEY_ENC_OPTS_MASK (it selects the union member from the
mask blob's own md->version), and the mask handed to hardware offload,
for requests that installed fine before.

Would it make sense to restrict the new default to the !depth path, or
alternatively to describe this second affected path in the changelog and
move the comment so its scope matches the code?

> -	if (!depth)
> +	if (!depth) {
> +		/* No mask attribute supplied: exact-match every field the
> +		 * key set, keyed off the key's own version so the v2 dir/hwid
> +		 * bytes are masked without touching the overlapping
> +		 * timestamp/sgt bytes of the union (see 292207809486).
> +		 */
> +		if (md->version == 1) {
> +			memset(&md->u.index, 0xff, sizeof(md->u.index));
> +		} else if (md->version == 2) {
> +			md->u.md2.dir = 1;
> +			set_hwid(&md->u.md2, 0xff);
> +		}
>  		return sizeof(*md);
> +	}
>  
>  	if (nla_type(nla) != TCA_FLOWER_KEY_ENC_OPTS_ERSPAN) {
>  		NL_SET_ERR_MSG(extack, "Non-erspan option type for mask");

[ ... ]

> @@ -1607,9 +1620,11 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
>  			key->enc_opts.dst_opt_type = IP_TUNNEL_ERSPAN_OPT_BIT;
>  			option_len = fl_set_erspan_opt(nla_opt_key, key,
>  						       key_depth, option_len,
> -						       extack);
> +						       extack, 1);
>  			if (option_len < 0)
>  				return option_len;
> +			key_ver = ((struct erspan_metadata *)
> +				  &key->enc_opts.data[key->enc_opts.len])->version;
>  
>  			key->enc_opts.len += option_len;
>  			/* At the same time we need to parse through the mask
> @@ -1618,7 +1633,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
>  			mask->enc_opts.dst_opt_type = IP_TUNNEL_ERSPAN_OPT_BIT;
>  			option_len = fl_set_erspan_opt(nla_opt_msk, mask,
>  						       msk_depth, option_len,
> -						       extack);
> +						       extack, key_ver);
>  			if (option_len < 0)
>  				return option_len;

[Severity: Medium]
Now that key_ver is available at the call site, should a mask nest that
declares a different version than the key be rejected?

key_ver only supplies the default; a few lines further down in
fl_set_erspan_opt() it is overwritten with no comparison against the
key's version:

	if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER])
		md->version = nla_get_u8(tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER]);

The only cross-check in fl_set_enc_opt() is the length one, and both
version branches return sizeof(*md):

	mask->enc_opts.len += option_len;
	if (key->enc_opts.len != mask->enc_opts.len) {

So key nest {VER=1, INDEX=0x64} with mask nest {VER=2} is accepted.  On
the mask pass option_len is non-zero, so the "Missing tunnel key erspan
option dir or hwid" guard is skipped, and the v2 branch writes only
md2.dir and the hwid bitfields, leaving the union bytes holding the
key's index at 0.  cls_flower compares (packet_key & mask) against
(filter_key & mask), so doesn't that filter then match every ERSPAN
packet regardless of index, which is the wildcard behaviour this patch
sets out to remove?

The mirror case, key VER=2 with dir/hwid plus mask VER=1, memsets the
union bytes that alias md2.timestamp to 0xff while dir/hwid stay
wildcarded, so the filter would never match packets carrying a non-zero
ERSPAN timestamp.

The pair is also not round-trippable, since fl_dump_key_erspan_opt()
picks the union member from each blob's own md->version: the key dumps
as VER=1 plus INDEX while the mask dumps as VER=2 plus DIR/HWID.

Two remaining observations that are not about this diff:

[Severity: Low]
This isn't a bug introduced by this patch, but match_erspan_opts_test()
in tools/testing/selftests/net/forwarding/tc_flower.sh does not appear
to verify that the ERSPAN option values take part in matching, so it
passes with or without the wildcard mask this patch fixes.

The Type II filter (handle 101) is installed with enc_key_id 1001 plus
erspan_opts 1:6789:0:0, and the Type III filter (handle 102) with
enc_key_id 1002 plus erspan_opts 2:0:1:63.  The distinct tunnel key IDs
already select the respective filter, and only one matching packet is
sent through each tunnel:

	$MZ erspan1 -c 1 -p 64 -a $ep1mac -b $h2mac -t ip -q
	tc_check_packets "dev ep-ex ingress" 101 1
	check_err $? "ERSPAN Type II"

Both assertions still hold when the ERSPAN index/dir/hwid mask bytes are
zero.  Could a negative packet with the same enc_key_id but different
ERSPAN metadata be added, so the new no-mask defaults in
fl_set_erspan_opt() are covered?

[Severity: Low]
This is a pre-existing issue, but the ERSPAN index attribute is
consumed as big-endian while both of its declarations call it a
host-endian u32.

include/uapi/linux/pkt_cls.h documents
TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX as be32,
fl_set_erspan_opt() reads it with nla_get_be32() into the __be32 union
member and fl_dump_key_erspan_opt() emits it with nla_put_be32().  But
erspan_opt_policy has:

	[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX]      = { .type = NLA_U32 },

and the flower-key-enc-opt-erspan-attrs entry in
Documentation/netlink/specs/tc.yaml has:

      -
        name: index
        type: u32

with no byte-order: big-endian.  Should the policy use NLA_BE32 and the
spec entry declare big-endian byte order so both match the ABI?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-4CSL.v1.20260917072652%40mojatatu.com
