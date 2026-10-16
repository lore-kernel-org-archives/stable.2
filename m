Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC91B87C0;
	Fri, 16 Oct 2026 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174939; cv=none; b=lwb2XoRnYBLY6dW7YgKztKCGYce8vMtlt2xDWdZPIrr8oBWroOXB15+mvlSSrvZkbp+kzi6D3+EreaZAVvfZ6L78N8JiD19vELTPeAGAfGChLdnYzCR2PJH5kluDQVEBGpuZxEQQgK5nzbuCly7YcSdnulHZ/F+NHbMQjWvAJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174939; c=relaxed/simple;
	bh=ltiN4aoq63BlO+UetJC7Bnj4Ur/NWWY4/sVQ1diNB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViQpa4gCgI0TzUn7qI/eO/DKpnzEMaxUUma7GL1fz8C1oTUHNRzyrgCH9opPvESPTEriBvwE1C3nzilbV9lojhMNSurXBtkfjUZEmEFDQwtKGhA7HYDbpXql5QNUSITW7HxBDpDde+zIa+L0VXEbNg92Ef5sznofstDZYCogwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAERuqgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAERuqgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705501F000C4;
	Fri, 16 Oct 2026 18:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174938;
	bh=jr2s9GlYBubKvrLscWdMnTIa4kixwWPVY/gQkgSyYxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dAERuqgWY11UMJILaiSf3Ta21nI04tIs2ssvCNB5E8rkbd/P7h4pWB8bcrhrf2rfm
	 z/vDC3MYRfh/d2Gs6A+FGCox2LUYX8udvgg7IkIWEQ19krDtrU/1QD5Zjiu9I8Sl8I
	 U3tdAECPmw6YJHxI3qDT1xWA9ttVb3N4Y4het0c+pN8k3j+jbb5WDN9s8kpVPHhX/6
	 XbhZZwtNy2q6eOIj8FG5A/tyFNWTtYaInWk3dlvterf0Pqo5SlmcwtpBKk2Cg4ElN5
	 0UGDqIo35AbNLa9FwRrL0ZR0U14YsoB6icj2zqsrb80XlNbjUfHhL/aPDyBK7fogRi
	 4PBv10K1vfjBA==
Date: Fri, 16 Oct 2026 19:22:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
	sdf@fomichev.me, martin.lau@kernel.org, daniel@iogearbox.net,
	qmo@kernel.org, bpf@vger.kernel.org, jiri@resnulli.us,
	stable@vger.kernel.org, sashiko-bot@kernel.org, victor@mojatatu.com
Subject: Re: [PATCH net v2 1/3] netdevsim: reject cls_bpf programs bound to
 another device
Message-ID: <20261016182212.GK363352@horms.kernel.org>
References: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
 <QDISC-PYC7.v2.20261010165947-2@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-PYC7.v2.20261010165947-2@mojatatu.com>

On Sat, Oct 10, 2026 at 05:02:48PM -0400, Jamal Hadi Salim wrote:
> The issue:
> nsim_bpf_setup_tc_block_cb() installs any device-bound SCHED_CLS program
> without checking that its offload device matches the target netdev.  The
> core cls_bpf attach path rejects a mismatching program, but a netdev that
> joins a shared block later is replayed the stored filter by
> cls_bpf_reoffload() before it is inserted into block->ports, so the
> attach-time check cannot see it.  The driver callback is the
> authoritative per-device acceptance boundary and must enforce the match
> itself, as nfp already does in nfp_net_bpf_offload().
> 
> Without the check, replaying a device-bound program onto a different
> bpf_offload_dev installs it into that device's netdevsim state, which
> trips the WARN in nsim_bpf_uninit() (ns->bpf_offloaded set on a foreign
> device) and can dereference a NULL prog->aux->offload in
> nsim_prog_set_loaded().
> 
> The Fix:
> Reject a device-bound program whose offload device does not match the
> target netdev, with -EINVAL and an extack so the rejected replay is not
> silent.  The check is intentionally narrower than nfp's: it fires only
> for a dev-bound program, so nsim's bpf_tc_non_bound_accept mode (which
> admits an unbound program onto the device) is unaffected.  Teardown is
> never blocked: the guard is on the program being installed and an unbind
> passes cls_bpf.prog = NULL.
> 
> Conditions to recreate the bug:
>   - CONFIG_NETDEVSIM=y, CONFIG_NET_CLS_BPF=y
>   - load and pin a dev-bound SCHED_CLS program for netdevsim device B
>   - install the program on a shared block owned by B
>   - add an independently backed netdevsim device C to that block; the
>     bind replays the filter to C's callback, and C's
>     ports/0/bpf_offloaded_id takes the B-bound program id.
> 
> The reported Sashiko review is at
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809094418.901607-1-jhs@mojatatu.com
> 
> Fixes: 31d3ad832948 ("netdevsim: add bpf offload support")
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.com/
> Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatatu.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

