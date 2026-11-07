Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051110;
	b=cqyatIxnzxhGLcGTqN5arIqPxOM7GqBd5MQXsjQGEqY1o9c/l1DxRd3RNkrSxUqes9WL
	 mnIQAdP1dK2SV0M/O9IFd8ySIhX8PUM8YRgjYfUuJwDxTz61hrm40YRPavrXN3l0YPNle
	 gzb9l3+QTX9POLX31Lmd1K8FkiwCoIOayUontRhYr55K/Wc9ygcU25vsiTSxZNGnJDukj
	 SlPGnShisDYydgV8qSWbJDDpXUKn065bTENlY5VnLW2wUFlOTwtIWOgNnLvn5ouVvvo9m
	 mBWOpH5mncQIcQA+UtVTNnluYOyMPIREJ9xIiKxr5Sd0G1kHQt37RNpCTHN8ZwlAjOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051110;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9thr76seF/S4HTgAitnmH/j/7lgpAL+uj2aAp2+0Yho=;
	b=aGUD5iA3Y0UrmTB8isade+fn/1lgM2MScJfY68W23BU0ZiJbaNFbLuGFqwxyHLajdWHC
	 aZyGKfHGBgNbO5j+iC/1zX3FLUGu6w6uCIqBOFOwqxmds4e9QISKTY91TvQ5RNMLJVM5e
	 i6HUO/ypEfaF8ehPyqE8BwgL/eEJHCcVt65uK5/xmmYAJJ2COMszZKdaU6zRiPNjYmgrS
	 /0lS7hJkABhGAqA8IRMAXw/kr+/aMb1gx5JSV2Qu4bsK64oI5TJpx7nxvNjMBu68S1Agk
	 5TuCqMStzVvcsZkRXGueCIyvXtX4C9Z8nLOoEvTE0SzfMRF7Zy/cpFKYJHOjOUp3Fdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K/0oNUXG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CB606A32C;
	Sat,  7 Nov 2026 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/0oNUXG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AA61F0089F;
	Sat,  7 Nov 2026 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051109;
	bh=9thr76seF/S4HTgAitnmH/j/7lgpAL+uj2aAp2+0Yho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K/0oNUXG9dFjLTWur+SN10mHBXgS78yRktVzKJ2Qp0AAac+2auwSHjo/6vD4Zom6y
	 HCKGCFYUX01OdSCajsc1+Qdddlcc7jRa9QoK6JS7DaRkrLeTe6N3VAsu0Q1FMztho6
	 VGSDAnEmXlQk4OSUoEolMOnckU5IL/8VUSHj/Mnbnj7d1Z/2pRkTuZ+DOvoyWd/A75
	 TRmX0UU96NqUIHJEVreJO2TCJ3eqYrWYLUyfIlUhoAzSeoHZplgLuxxOYcvZYTaS3F
	 pj9bV5+yWiVc3scNvD1eGuetR+lXRc7e5tCob6KDbs5rUNk36A1ynpnS1Qe46Qucw7
	 rr5IgHtZt1FgA==
Subject: Re: [PATCH] net: octeontx2-pf: drop the TC mark reference when adding
 a flow fails
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 11:31:48 +0000
Message-ID: <179405110835.994134.149418482897287841@kernel.org>
In-Reply-To: <20261103100536.1310108-1-vulab@iscas.ac.cn>
References: <20261103100536.1310108-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new helper otx2_tc_put_mark_flow() (otx2_tc.c:1240-1245)
  uses `req->match_id != 0` to decide whether a mark_flows reference was…
- [Medium] net: octeontx2-pf: otx2_tc_put_mark_flow() leaves TC mark flag
  enabled

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it makes the
  counter the patch balances meaningless.
- [Medium] This problem wasn't introduced by this patch, but the error
  paths of otx2_tc_add_flow() that the patch edits fail to undo other…

--

net: octeontx2-pf: drop the TC mark reference when adding a flow fails

This patch adds otx2_tc_put_mark_flow() and calls it on the error paths
of otx2_tc_add_flow(). When installing a flow fails, it drops the
flow_cfg->mark_flows reference that otx2_tc_parse_actions() took for a
FLOW_ACTION_MARK action. The match_id of the parsed request is used to
decide whether a reference was taken.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index dee38d5c7f65b..c3726d9f455a2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -1237,6 +1237,13 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  	return 0;
>  }
>  
> +static void otx2_tc_put_mark_flow(struct otx2_nic *nic,
> +				  struct npc_install_flow_req *req)
> +{
> +	if (req->match_id)
> +		refcount_dec(&nic->flow_cfg->mark_flows);

[Severity: Medium]
The helper puts back the mark_flows reference, but it leaves the other
half of what otx2_tc_parse_actions() did in place. The FLOW_ACTION_MARK
case does both of these before the flow has been installed:

	nic->flags |= OTX2_FLAG_TC_MARK_ENABLED;
	refcount_inc(&nic->flow_cfg->mark_flows);

Suppose the first rule with an skbedit mark action fails to install.
A later action in otx2_tc_parse_actions() could be rejected, or one of
cn20k_tc_alloc_entry(), otx2_tc_update_mcam_table(),
otx2_mbox_alloc_msg_npc_install_flow() or otx2_sync_mbox_msg() could
fail. In each case mark_flows returns to its initial value of 1, but
OTX2_FLAG_TC_MARK_ENABLED stays set in nic->flags.

With no mark rule installed, otx2_rcv_pkt_handler() still does this for
every received packet:

	if (pfvf->flags & OTX2_FLAG_TC_MARK_ENABLED)
		skb->mark = parse->match_id;

So a failed add still changes the RX datapath. The flag is only cleared
again if a marked flow is later deleted through otx2_tc_del_flow().

If the intent of this patch is to undo the side effects of a failed
add, should the flag also be cleared here once no mark rules remain?
Clearing it unconditionally would be wrong when another mark rule is
already installed, so it would need the same "last reference" test that
otx2_tc_del_flow() is meant to use. Alternatively, would it be simpler
to set the flag only after the flow has been installed successfully?
Then the error paths would have nothing to undo.

[Severity: High]
Does a non-zero match_id reliably show that the reference was taken? The
code in otx2_tc_parse_actions() that takes the reference doesn't follow
the same rule:

	case FLOW_ACTION_MARK:
		if (act->mark & ~OTX2_RX_MATCH_ID_MASK) {
			...
			return -EOPNOTSUPP;
		}
		mark = act->mark;
		req->match_id = mark & OTX2_RX_MATCH_ID_MASK;
		req->op = NIX_RX_ACTION_DEFAULT;
		nic->flags |= OTX2_FLAG_TC_MARK_ENABLED;
		refcount_inc(&nic->flow_cfg->mark_flows);
		break;

This check accepts a mark of 0, so "action skbedit mark 0" takes a
reference and leaves match_id at 0. act_skbedit sets SKBEDIT_F_MARK
whenever TCA_SKBEDIT_MARK is present. tcf_skbedit_offload_act_setup()
then passes the value through unchanged as FLOW_ACTION_MARK, so mark 0
does reach the driver.

Nothing stops a rule from having several MARK actions either. Each one
increments mark_flows and overwrites match_id. The helper drops at most
one reference, or none if the last mark is 0.

Take a rule like this one:

  flower skip_sw ... action skbedit mark 0 action skbedit ptype host

It fails in otx2_tc_prepare_flow() on the second action, and the
reference taken for the first action still leaks. The
cn20k_tc_alloc_entry() failure path and the free_leaf path behave the
same way.

The commit message says:

  Release the reference on the error paths of otx2_tc_add_flow(), using
  the match id of the parsed request to tell whether it was taken.

Doesn't this leave the leak reachable in these cases?

otx2_tc_del_flow() uses the same match_id test. A mark 0 rule that
installs successfully would also leak its reference when it is deleted.

Would it be more robust to record the acquisition per node, for example
with a bool or a count set next to refcount_inc()? Another option is to
reject duplicate MARK actions. Either way, the decision would no longer
depend on match_id.

> +}
> +

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. It
does affect what the counter balanced here actually does.
otx2_mcam_flow_init() starts the counter at 1:

	refcount_set(&flow_cfg->mark_flows, 1);

otx2_tc_del_flow() is the only code that reads it:

	/* Disable TC MARK flag if they are no rules with skbedit mark action */
	if (flow_node->req.match_id)
		if (!refcount_dec_and_test(&flow_cfg->mark_flows))
			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;

Starting from 1, refcount_dec_and_test() never reaches 0 when references
are balanced, so the negated test is always true. Doesn't that clear
OTX2_FLAG_TC_MARK_ENABLED every time a marked flow is deleted, even while
other mark rules are still installed?

otx2_rcv_pkt_handler() only copies the hardware match_id into skb->mark
while the flag is set:

	if (pfvf->flags & OTX2_FLAG_TC_MARK_ENABLED)
		skb->mark = parse->match_id;

Suppose two skip_sw flower rules are installed with "skbedit mark 5" and
"skbedit mark 6", and the second one is deleted. Packets matching the
first rule would then stop getting skb->mark, even though the hardware
still writes match_id 5 into the CQE.

The same-cookie replace path in otx2_tc_add_flow() can hit this with a
single rule. otx2_tc_prepare_flow() sets the flag for the new rule, and
then otx2_tc_del_flow() on the old node clears it.

Since this test is the only reader of mark_flows, does the reference
balancing in this patch change any driver behaviour while this problem
remains?

[ ... ]

> @@ -1287,6 +1295,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  		if (rc) {
>  			NL_SET_ERR_MSG_MOD(extack,
>  					   "MCAM rule allocation failed");
> +			otx2_tc_put_mark_flow(nic, &dummy);
>  			kfree_rcu(new_node, rcu);
>  			return rc;
>  		}

[Severity: Medium]
This isn't a bug introduced by this patch, but does this path leak other
resources that otx2_tc_prepare_flow() acquired?

cn20k allows police actions. otx2_tc_act_set_police() allocates a leaf
profile, maps the RQ policer and sets a bit in nic->rq_bmap:

	rc = otx2_tc_act_set_hw_police(nic, node);
	if (!rc)
		set_bit(rq_idx, &nic->rq_bmap);

If cn20k_tc_alloc_entry() then fails, new_node is freed directly here and
the police cleanup in free_leaf is skipped. The leaf profile, the RQ
policer mapping and the rq_bmap bit all look like they leak.

The multicast group that otx2_tc_update_mcast() creates and stores in
new_node->mcast_grp_idx is also never destroyed, either here or in the
free_leaf path. otx2_tc_del_flow() sends NIX_MCAST_GRP_DESTROY for it, but
the error paths in otx2_tc_add_flow() don't.

In otx2_tc_parse_actions(), the multicast group is also created before
the nr_police check and before otx2_tc_act_set_police() runs:

	if (mcast) {
		err = otx2_tc_update_mcast(nic, req, extack, node,
					   &dummy_grp_update_req,
					   num_intf);
		if (err)
			return err;
	}

	if (nr_police > 1) {
		NL_SET_ERR_MSG_MOD(extack,
				   "rate limit police offload requires a single action");
		return -EOPNOTSUPP;
	}

If either of those fails, the otx2_tc_prepare_flow() error path frees
new_node and the AF multicast group leaks.

Repeated failures could use up rq_bmap ("Police action rules exceeded"),
as well as AF multicast groups and leaf profiles.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103100536.1310108-1-vulab%40iscas.ac.cn
