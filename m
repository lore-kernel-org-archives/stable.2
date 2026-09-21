Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335A496D3B;
	Mon, 21 Sep 2026 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995127; cv=none; b=R0h2UH0+ZUmfoSPjvdbcLTiamMrLhZ7TdNQZz3sLpU7MlFAPCnB7DRo7z45j4slj6c6dCpeHHjalUfOAIY7vKTPXN3q/ri3mJB9xr/BVa79Xm+Kfu56wfmnAKhLQYoVuA1O/Z2IlHmCtAvWDhkQ60NgjZRQ+y+Kjii9NtTHhmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995127; c=relaxed/simple;
	bh=wk8WqgVggF8LJTmOp5H6FQx6D/MULWBtpqoasVAAaqM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AqP84pk79HyD9bF13tBvx7R6DXRbEHmVn4Y2hqt1PMZpEZatiU9OWQi3RZOMfYCBf+SD4p55mdcNcIkbtIi5xOoskD22/rYh9Q+qSkKX13W0aX6P8k9LGWGhU+NHMbwnqovvzermx9zOVq90tPHJETbKneZvvI7mc1SsjDKSoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEoXuMgk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEoXuMgk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81E81F000FF;
	Mon, 21 Sep 2026 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789995125;
	bh=gBrB4ZvsDxz9T+FKuvYovOtJhOMUC4zhQspG5dCkzqI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UEoXuMgk3tQR7VKss5G7TCH5r2PNVxKIgUqvy03V3f2uk/2Ph6lX19r0ed/+h2e4e
	 bDVJ8hMF7A6V8+AvzTV0lrEBHMw8lyCzO0N1Xud2ENdLe8BpvuiiBRZz2J/riVAs9r
	 iliuMt+mIA+BPEmVnZ5Cae07HGJfPl/vOW+t+HSil3Aj4EAQrQTMbVLuyfpp+5d+gX
	 OhBP10nnepB70F532dZSrX99wGzghWQb63X3l2HQ1Ppk5NFoDDMCGMDH8irTojud2I
	 qHlMVWV5j2Ty8l4FhvbQDGRFKr7w1lCUTKNByQC7w24IQDeWpshm9HlTaLjQPiUH1i
	 A5LSb3N8CAV8g==
Subject: Re: [PATCH] mlxsw: spectrum_flower: Fix port range register leak
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 idosch@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, petrm@nvidia.com,
 stable@vger.kernel.org
Date: Mon, 21 Sep 2026 12:52:04 +0000
Message-ID: <178999512438.2160803.8624213916637783363@kernel.org>
In-Reply-To: <20260917113236.2149095-1-vulab@iscas.ac.cn>
References: <20260917113236.2149095-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the port-range register leak the commit message
  claims to close remains fully reachable.

--

mlxsw: spectrum_flower: Fix port range register leak

Adds an unwind to mlxsw_sp_flower_parse_ports_range() so that the source
port range register is released when acquiring the destination port range
register fails.  The commit message motivates this by callers that pass a
stack allocated rule info and never release it.

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> index 353fd9ca89a68..4cad6c46b07e9 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> @@ -486,8 +486,14 @@ mlxsw_sp_flower_parse_ports_range(struct mlxsw_sp *mlxsw_sp,
>  
>  		err = mlxsw_sp_port_range_reg_get(mlxsw_sp, &range,
>  						  f->common.extack, &prr_index);
> -		if (err)
> +		if (err) {
> +			if (rulei->src_port_range_reg_valid) {
> +				mlxsw_sp_port_range_reg_put(mlxsw_sp,
> +							    rulei->src_port_range_reg_index);
> +				rulei->src_port_range_reg_valid = false;
> +			}
>  			return err;
> +		}
>  
>  		rulei->dst_port_range_reg_index = prr_index;
>  		rulei->dst_port_range_reg_valid = true;

[Severity: High]

Does this hunk actually close the leak the changelog describes?

mlxsw_sp_flower_parse() has two callers.  The first is
mlxsw_sp_flower_replace(), which uses the heap rulei owned by the rule and
routes every error through mlxsw_sp_acl_rule_destroy() ->
mlxsw_sp_acl_rulei_destroy(), which already drops both registers:

drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c:mlxsw_sp_acl_rulei_destroy() {
	if (rulei->src_port_range_reg_valid)
		mlxsw_sp_port_range_reg_put(mlxsw_sp,
					    rulei->src_port_range_reg_index);
	if (rulei->dst_port_range_reg_valid)
		mlxsw_sp_port_range_reg_put(mlxsw_sp,
					    rulei->dst_port_range_reg_index);
	kfree(rulei);
}

So on the replace path the new put looks redundant.

The second caller is the stack rulei one named in the changelog,
mlxsw_sp_flower_tmplt_create():

	struct mlxsw_sp_acl_rule_info rulei;
	...
	memset(&rulei, 0, sizeof(rulei));
	err = mlxsw_sp_flower_parse(mlxsw_sp, block, &rulei, f);
	if (err)
		return err;
	ruleset = mlxsw_sp_acl_ruleset_get(mlxsw_sp, block,
					   f->common.chain_index,
					   MLXSW_SP_ACL_PROFILE_FLOWER,
					   &rulei.values.elusage);

	/* keep the reference to the ruleset */
	return PTR_ERR_OR_ZERO(ruleset);

This never calls mlxsw_sp_acl_rulei_destroy() (it cannot, that function ends
in kfree(rulei)), and mlxsw_sp_flower_tmplt_destroy() only drops ruleset
references.  Isn't every port range register recorded in that stack rulei
still leaked?

The new unwind only covers the narrow window "source acquired, destination
acquisition failed".  For the template caller the reference is still dropped
on the floor in these cases:

  - the success path, where one or two registers stay pinned per template
    (this is the common case)
  - later failures inside mlxsw_sp_flower_parse() after
    mlxsw_sp_flower_parse_ports_range() already succeeded, namely
    mlxsw_sp_flower_parse_tcp() rejecting reserved flags,
    mlxsw_sp_flower_parse_ip() rejecting a non-IP n_proto, and
    mlxsw_sp_flower_parse_actions() failing:

	err = mlxsw_sp_flower_parse_ports_range(mlxsw_sp, rulei, f, ip_proto);
	if (err)
		return err;

	err = mlxsw_sp_flower_parse_tcp(mlxsw_sp, rulei, f, ip_proto);
	if (err)
		return err;

	err = mlxsw_sp_flower_parse_ip(mlxsw_sp, rulei, f, n_proto_key & n_proto_mask);
	if (err)
		return err;

	return mlxsw_sp_flower_parse_actions(mlxsw_sp, block, rulei,
					     &f->rule->action,
					     f->common.extack);

  - mlxsw_sp_acl_ruleset_get() returning an error in
    mlxsw_sp_flower_tmplt_create()

Is the template key really non-zero here?  fl_tmplt_create() in
net/sched/cls_flower.c fills tmplt->dummy_key and tmplt->mask from the user
attributes via fl_set_key(), fl_set_key_port_range() sets
mask->tp_range.tp_min.src/dst to all ones for TCP/UDP/SCTP, and
fl_hw_create_tmplt() hands that dissector, key and mask to the driver.
FLOW_DISSECTOR_KEY_PORTS_RANGE is in the accepted key mask in
mlxsw_sp_flower_parse(), so mlxsw_sp_port_range_reg_get() takes a real
reference for a template such as:

	tc chain add dev swp1 ingress protocol ip \
		flower ip_proto tcp src_port 100-200

The pool is small and fixed.  mlxsw_sp_port_range_init() sets
pr_core->prr_ids.max from MLXSW_CORE_RES_GET(core, ACL_MAX_L4_PORT_RANGE)
and warns above 16 entries:

	max = MLXSW_CORE_RES_GET(core, ACL_MAX_L4_PORT_RANGE);

	/* Each port range register is represented using a single bit in the
	 * two bytes "l4_port_range" ACL key element.
	 */
	WARN_ON(max > BITS_PER_BYTE * sizeof(u16));

Once it is exhausted, mlxsw_sp_port_range_reg_create() fails:

	err = xa_alloc(&pr_core->prr_xa, &prr->index, prr, pr_core->prr_ids,
		       GFP_KERNEL);
	if (err) {
		if (err == -EBUSY)
			NL_SET_ERR_MSG_MOD(extack, "Exceeded number of port range registers");

Can repeated template add/delete with distinct port ranges therefore pin all
registers for the lifetime of the device, keep devlink prr_count inflated,
and make mlxsw_sp_port_range_fini()'s WARN_ON(!xa_empty(&pr_core->prr_xa))
fire on teardown?

Would it be better to drop this hunk and instead release the rulei's port
range registers in mlxsw_sp_flower_tmplt_create(), for example through a
non-freeing rulei cleanup helper that mirrors mlxsw_sp_acl_rulei_destroy(),
or to skip register acquisition altogether when parsing a template?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917113236.2149095-1-vulab%40iscas.ac.cn
