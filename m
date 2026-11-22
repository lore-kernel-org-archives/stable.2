Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795332581;
	b=VSgaTViULS3uJiv7t4XR9C4LmRYwGc3JJ+a71+EuZnXf6YfRysaNvreG0FdsiHmVpLgS
	 LJPeyXnw0QUF6xhG+pyJQcL2ih4flB/NZiZkXI4ICSYr2we11anTTY7DfA74KyjoSrVeU
	 GRP3bF+ndYle9uCHfh2IuvKgI22UbiNlDzWB5HMr1/JYILDbEZ5bQN6lSnSW8bxxpj9Yq
	 ZTRitVLB7477EFrOxPpXgKG96uIfxcqFBMWnkzLGa7pM7vdwE0Z5oXxMVFc00zzxlRiUn
	 7a1E3YKlPWlB+fHL9dRQGIEZH4e/Ig10Ia8c1DVrdyukY7WI49U5ZngczVKQ+BgOKyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795332581;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CcKL6w1akIoGVfJ2Pkwj4LentV4cSBE6WTjo9Oi52Hg=;
	b=W4en4DY1AO9g3JmqsHUvvZ/SvcA/uHnb8bSYwKdtDU6xwTKXztH6FaCcOWGjzee1az4O
	 GK+qo+vwkpkTLZaQ/7wiFRkv+DdaOJ6pi0+J0OCudmnUSSkcLLtGmClv7SyZH917UVNZu
	 1TD7B2rRqLRnlTZYojXMlIOOe77TsRIVMrXXwfFARRfNY2a9/kR1bipPF5cqiM0NLfsvU
	 yAXK/Mh3/elG6pu/iTrhDwODyi/3YjJUvNPWO7UYWMPdd0hP+tjO1t3u7NeJFzJwhBpXz
	 ny2vfpInASn6jd/ubCnhFo90gKpbiqm9Tz2k+HCOeZ8Z9+/u+/375v3BIA+Sku9C1Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZUQLA/ez";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5EE606A320;
	Sun, 22 Nov 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUQLA/ez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E2D1F000C0;
	Sun, 22 Nov 2026 07:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795332581;
	bh=CcKL6w1akIoGVfJ2Pkwj4LentV4cSBE6WTjo9Oi52Hg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZUQLA/ez7P23QGL+lDEwTPkjcIe8MbbdjmDg83wk+tEZIssztZFE/YND/+ApOVZQ3
	 d1PraFL2DiRiAxnTudqhrSNvk/4x0fvYfATiCvf+dgvRJTHh/7xrsny91TVpNMU3g0
	 KfrGx3q6Rbz/x2O5fskjh6FJxuTlFoUla0O0gqvJv3qz054P/2jcTh6ik33VR4st4J
	 lhVo3pqnWvOcN/rLjGdPMfO/gju7rtvB8/cU+CULUjpgZroh7/fNl5JjU9Xaj3MUBw
	 f38QHpIvHQoEYyLw++bgwli1mCleL/XUyyE79vdRFBQ8kv+mhY+0fDWmL8hyqeI0r4
	 Nus6ZGwFaCLyg==
Subject: Re: [PATCH net v5 1/2] net: openvswitch: do not record user features
 when the change fails
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, matttbe@kernel.org
Date: Sun, 22 Nov 2026 07:29:40 +0000
Message-ID: <179533258016.3135.15287628134252460635@kernel.org>
In-Reply-To: <20261118065435.2367014-2-houminxi@gmail.com>
References: <20261118065435.2367014-2-houminxi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch also fixes a second, unrelated and older crash, and
  the subject, Fixes tag and impact description all leave it out.
- [Low] The `Fixes: 35d39fecbc24 (...)` and `Cc: stable@vger.kernel.org`
  lines sit in the middle of the commit message.
- [Low] The patch makes ovs_dp_set_user_features() the only writer and
  has it store with `WRITE_ONCE(dp->user_features, features)`.

Pre-existing issues:
- [Low] datapath_policy[] in net/openvswitch/datapath.c has entries for
  NAME, UPCALL_PID, USER_FEATURES, MASKS_CACHE_SIZE and IFINDEX, but…

--

net: openvswitch: do not record user features when the change fails

The patch moves the store of dp->user_features in ovs_dp_change() to after
the per-cpu upcall pid update. Every change now goes through a new
ovs_dp_set_user_features() helper, which keeps OVS_DP_F_TC_RECIRC_SHARING
and the tc skb extension reference in step. It also fixes reference leaks
in the ovs_dp_cmd_new() error path and in ovs_dp_reset_user_features(),
and has queue_userspace_packet() read the features once for both the
head room and the padding.

> Fixes: 35d39fecbc24 ("net/sched: Enable tc skb ext allocation on chain miss only when needed")
> Cc: stable@vger.kernel.org
> __dp_destroy() clears the bit before the ports are detached and before the
> datapath leaves the list, so an upcall can still be reading the other bits

[ ... ]

> uses that value for both.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>

[Severity: Low]
The Fixes: and Cc: stable lines sit in the middle of the commit message.
Four more paragraphs follow them, and only then comes the Signed-off-by:
line.

git interpret-trailers, b4 and patchwork only read trailers from the last
paragraph of the message, and here that paragraph holds only
Signed-off-by:. Won't those tools treat the Fixes: and Cc: stable tags as
ordinary body text?

Could the paragraphs after the tags move above the trailer block? If they
are revision notes, they could go below the --- line instead.

> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index b2a0b09fd4a56..7c1af21f74df4 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c

[ ... ]

> @@ -494,11 +495,16 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
>  	    (err = skb_csum_hwoffload_help(skb, 0)))
>  		goto out;
>  
> +	/* The features can be changed while this runs, so read them once and
> +	 * use that value for both the head room and the padding.
> +	 */
> +	features = READ_ONCE(dp->user_features);
> +

[Severity: Medium]
This single read also fixes a separate, older crash. The subject, the
Fixes: tag and the impact description don't mention it.

Before this patch, the hlen choice and pad_packet() each read
dp->user_features. If OVS_DP_F_UNALIGNED is set at the first read,
skb_zerocopy() can attach frags and leave user_skb nonlinear.

An OVS_DP_CMD_SET needs only CAP_NET_ADMIN, which a user namespace can
provide. If one cleared the bit before the second read, the path was:

queue_userspace_packet()
  pad_packet()
    skb_put_zero()
      skb_put()
        SKB_LINEAR_ASSERT(skb);  /* BUG() on a nonlinear skb */

The commit message only says a concurrent set "could make it pad a
nonlinear skb". It doesn't say the result is a BUG().

The double read is older than 35d39fecbc24. pad_packet() was split out in
7f8a436eaa2c ("openvswitch: Add conntrack action") in 2015, and the double
read dates from 2014/2015 code. Stable trees picked by the only Fixes: tag
would miss this fix. A backporter who drops or reworks this hunk would not
know it is a crash fix.

Would this work better as its own patch, with a Fixes: tag for the commit
that introduced the double read and a description of the BUG()?

>  	/* Older versions of OVS user space enforce alignment of the last
>  	 * Netlink attribute to NLA_ALIGNTO which would require extensive
>  	 * padding logic. Only perform zerocopy if padding is not required.
>  	 */
> -	if (dp->user_features & OVS_DP_F_UNALIGNED)
> +	if (features & OVS_DP_F_UNALIGNED)
>  		hlen = min(skb_zerocopy_headlen(skb), cutlen);
>  	else
>  		hlen = skb_len;

[ ... ]

> @@ -1704,6 +1710,24 @@ static struct datapath *lookup_datapath(struct net *net,
>  	return dp ? dp : ERR_PTR(-ENODEV);
>  }
>  
> +/* Called with ovs_mutex. The receive path reads the field without it, so
> + * the store is single and goes through WRITE_ONCE(). The store happens
> + * before the reference is taken or dropped, the order ovs_dp_change() used
> + * before this helper existed.
> + */
> +static void ovs_dp_set_user_features(struct datapath *dp, u32 features)
> +{
> +	bool was = dp->user_features & OVS_DP_F_TC_RECIRC_SHARING;
> +	bool now = features & OVS_DP_F_TC_RECIRC_SHARING;
> +
> +	WRITE_ONCE(dp->user_features, features);

[Severity: Low]
The comment says the receive path reads the field without ovs_mutex, but
only queue_userspace_packet() was switched to READ_ONCE(). Other readers
that run without ovs_mutex still use plain loads:

net/openvswitch/datapath.c:ovs_dp_process_packet() {
    ...
		else if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
    ...
}

net/openvswitch/actions.c:output_userspace() {
    ...
			else if (dp->user_features &
				 OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
    ...
}

net/openvswitch/vport.c:ovs_vport_get_upcall_portids() {
    ...
	if (vport->dp->user_features & OVS_DP_F_VPORT_PIDS)
    ...
}

ovs_dp_process_packet() runs under rcu_read_lock() only. The kernel-doc
for ovs_vport_get_upcall_portids() allows either ovs_mutex or
rcu_read_lock().

A plain load racing with a WRITE_ONCE() store is still a data race, and
KCSAN will report it. Each of these readers tests the field only once, so
there is no functional effect.

Should these readers also use READ_ONCE(), or should the comment be
limited to queue_userspace_packet()?

> +
> +	if (now && !was)
> +		tc_skb_ext_tc_enable();
> +	else if (!now && was)
> +		tc_skb_ext_tc_disable();
> +}

[ ... ]

> @@ -1801,9 +1825,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
>  			return err;
>  	}
>  
> -	dp->user_features = user_features;
> -
> -	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
> +	if (user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
>  	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
>  		/* Upcall Netlink Port IDs have been updated */
>  		err = ovs_dp_set_upcall_portids(dp,

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch.
datapath_policy[] has no entry for OVS_DP_ATTR_PER_CPU_PIDS:

static const struct nla_policy datapath_policy[OVS_DP_ATTR_MAX + 1] = {
	[OVS_DP_ATTR_NAME] = { .type = NLA_NUL_STRING, .len = IFNAMSIZ - 1 },
	[OVS_DP_ATTR_UPCALL_PID] = { .type = NLA_U32 },
	[OVS_DP_ATTR_USER_FEATURES] = { .type = NLA_U32 },
	[OVS_DP_ATTR_MASKS_CACHE_SIZE] =  NLA_POLICY_RANGE(NLA_U32, 0,
		PCPU_MIN_UNIT_SIZE / sizeof(struct mask_cache_entry)),
	[OVS_DP_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
};

Documentation/netlink/specs/ovs_datapath.yaml declares per-cpu-pids as
binary with sub-type u32. The ops use GENL_DONT_VALIDATE_STRICT, so the
only check that rejects an empty or misaligned attribute is the
open-coded one in ovs_dp_set_upcall_portids():

	if (!nla_len(ids) || nla_len(ids) % sizeof(u32))
		return -EINVAL;

By then, ovs_dp_change() may already have resized the masks cache.

The spec has a separate gap. Its new operation lists only name,
upcall-pid and user-features, and it defines no set operation. Both
ovs_dp_cmd_new() and ovs_dp_cmd_set() accept per-cpu-pids,
masks-cache-size and ifindex through ovs_dp_change().

With the reordering in this patch, a malformed attribute no longer
corrupts the features. Could a follow-up add a policy entry for the
attribute and bring the spec in line?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118065435.2367014-1-houminxi%40gmail.com
