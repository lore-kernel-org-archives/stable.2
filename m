Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47CC30F92E;
	Sun, 11 Oct 2026 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791702216; cv=none; b=uCieIXVF34Op2ivjrQuH+c5Z0ApWvmzjRNy2z98CpnOSmyiEYe/w5No9AMRjH5cNKzwBCN25VOWSEf2ZHEBPeWweLZfDZVBxJx+q0bZsnbQs5BGHwQmhvYSie3b/jO23Z9TstzAh4ZtTUExNkADZuFwWRrqlzczwSEyUifG0sEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791702216; c=relaxed/simple;
	bh=4Ftfemtjb6xLoPE8Lirfyk8FuzXoN+pVExcr/CUwct0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OecLRYV9AZvjaqhZCCF6w0kO6vK9aS27Z0xxw21jyBLsVcEYwhXWoaOn9GMKhmRkvvkFUpiIHmKEVu69GlLAZofshPKedzZpQCCi2/afYfXKnfkHLxv4y78a3EhZx5RnKsPW6JukSlQtpfMspN+zc7m8xeD6zErFatoQgaUzwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdbPRSME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdbPRSME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FCF1F0089B;
	Sun, 11 Oct 2026 07:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791702215;
	bh=8OqT1qJsY3GVXrGF5l6DNP8Wtqtf3Z9gv+gvW6grqyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FdbPRSMEIacZgECIsPurGouc3DzkfbWeSWMtZ9lVCm1/eyirH8tpq5RokDhfWJeYQ
	 6JR4i6p3mXt/jIFPyTOgwBJBo7KjaZu4aITZe8e5wyy42ppKjO4rDAH85F1n1b8zqy
	 VBVWBpy1eGFSNPLGR5sZ62icMexe7r8jTDddPOCrrQC9jmywfDv99KX2vbnvr1PmAD
	 LT77GdP81y/m92V3Ph4n7EliDVX24djfJiz2Iq2HIMzUNLzN3gp5fJYGTpDrkjrIVI
	 GSGc64PTwOFpk41XRuYKv9x4Em82+APwBMvTWukqW9+6TUVnD6sNOary+rHFLLPk6F
	 7FhQvZyLc+T9A==
Subject:
 Re: [PATCH net] vxlan: reject appending a remote to a nexthop fdb entry
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, kuniyu@google.com,
 idosch@nvidia.com, razor@blackwall.org, fmancera@suse.de, atenart@kernel.org,
 i.maximets@ovn.org, qotmddnjs@ajou.ac.kr, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 11 Oct 2026 07:03:33 +0000
Message-ID: <179170221371.434549.11644886224016401666@kernel.org>
In-Reply-To: <20261010064802.2741221-1-bsdhenrymartin@gmail.com>
References: <20261010064802.2741221-1-bsdhenrymartin@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In vxlan_fdb_update_existing()
  (drivers/net/vxlan/vxlan_core.c), the new `if…
- [Low] The commit message presents the change only as rejecting a
  userspace `bridge fdb append` onto a nexthop entry.

--

vxlan: reject appending a remote to a nexthop fdb entry

This patch adds a check to vxlan_fdb_update_existing(). An NLM_F_APPEND
request on a multicast or zero MAC fdb entry now fails with -EOPNOTSUPP
when the entry is backed by a nexthop group. Before this,
vxlan_fdb_append() would link a remote onto such an entry, which breaks
the rule that nexthop entries have no remote list.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 278d41f58d895..e9c5ba7a74172 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1047,6 +1047,11 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
>  	if ((flags & NLM_F_APPEND) &&
>  	    (is_multicast_ether_addr(f->key.eth_addr) ||
>  	     is_zero_ether_addr(f->key.eth_addr))) {
> +		if (rcu_access_pointer(f->nh)) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Cannot append a remote to a nexthop fdb");
> +			return -EOPNOTSUPP;
> +		}

[Severity: Medium]
Can this early return leave the entry partly updated? When this check
runs, vxlan_fdb_update_existing() has already written the new state and
flags:

	if (!(fdb_flags & NTF_EXT_LEARNED) ||
	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
		if (f->state != state) {
			f->state = state;
			notify = 1;
		}
		if (f->flags != fdb_flags) {
			f->flags = fdb_flags;
			notify = 1;
		}
	}

Returning -EOPNOTSUPP here skips the if (notify) block, so no
RTM_NEWNEIGH or switchdev notification goes out. It also skips the
err_notify rollback.

For example, create a zero MAC nexthop entry with:

  bridge fdb add 00:00:00:00:00:00 dev vx0 nhid N self permanent

Then run:

  bridge fdb append 00:00:00:00:00:00 dev vx0 dst X self permanent router

The append passes the earlier nexthop checks, because nhid is 0 and the
state includes NUD_PERMANENT. It changes f->flags and then fails.
vxlan_fdb_add() returns the error and restores nothing.

The in-kernel callers vxlan_changelink() and
vxlan_update_default_fdb_entry() also reach this point. They pass
ndm_flags = NTF_SELF and state = NUD_REACHABLE | NUD_PERMANENT.

On a nexthop default entry created by the user, f->flags is overwritten
with NTF_SELF, which clears NTF_VXLAN_ADDED_BY_USER, and then the call
fails. vxlan_changelink() treats the failure as if nothing changed and
frees new_cfg.

The other three nexthop checks near the top of this function all return
before anything is changed. Could this check move up next to them, so
that the failed request has no side effects?

[Severity: Low]
The commit message presents this as rejecting a user's bridge fdb append
onto a nexthop entry. Two in-kernel paths also reach this check with
NLM_F_APPEND | NLM_F_CREATE on all_zeros_mac and nhid = 0:

  vxlan_changelink()
    vxlan_fdb_update()
      vxlan_fdb_update_existing()

  vxlan_update_default_fdb_entry()
    vxlan_fdb_update()
      vxlan_fdb_update_existing()

The first runs on "ip link set dev vx0 type vxlan remote <ip>". The
second runs on vnifilter group add or change, for example
"bridge vni add ... group ...".

On a non-metadata device, the zero MAC lookup is keyed on cfg->vni. A
nexthop entry created with "bridge fdb add 00:00:00:00:00:00 dev vx0
nhid N self permanent" is therefore the same entry these paths update.

Before this patch, these link and VNI changes succeeded, though they left
an unused remote on the entry. With this patch they fail with
-EOPNOTSUPP and the extack "Cannot append a remote to a nexthop fdb".
That message describes an fdb operation the user never issued.

Rejecting these requests is probably the right result. Since the patch
is tagged for stable, should the commit message mention this change in
rtnetlink link and vnifilter behavior? Could the error message also be
made accurate for these callers?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010064802.2741221-1-bsdhenrymartin%40gmail.com
