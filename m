Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641589;
	b=mvCRvvluv2SQrhA+JGg0FwoKQnipieC3js/gTDqMU+YUR9Fwyec1xmKfa3ATYIiD4e1c
	 m1WLdIgcJetaquY3b71MbU/GWbiz6bKkFyzBz5w1+d4iovgDBG5X5m0xoLdmGk0ZhdfjK
	 S36E7o8gfgRZvmg17LYHCZSITwpFOlOlGNZ0AU2vdwf3fps9tp9t2BCYqrSSfUbAhJXbW
	 1MtEH0xHMLuljKpwcnp2A2PxJW8bxYaRkINQlWq+RAkgLSsJuJVGxHkfv1trVOUWrzm7l
	 BMxKKmD9bPUDb+WW4tsmCNr3QrwzXzjDlBq1joG7Sjn3UKt4CiKkZoEI5aUt1nTBIAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641589;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qYyD49aeXrQ/bZeNGHoSmAuESNs1lMdSf2HL87qSocs=;
	b=eiH7O6l8Xv9CLwdSeFepSNGHWtSNHbYl1NYWe7QVRUJadsoUPoL86oPqI+A1xpKJ/nSE
	 RKwiZCgbzFAoycdnwSv6BfMsCR9WSgIp00nmRVHSiMUhUNDIdu4lDHHCym2OtDGR5nnJr
	 76aFwd1TWXzjejCyUSHflVofD2klLuzaA15qM5g39cRNiOb3I/KMmaAxyl48yMaLA7A34
	 +ghu9HSQeuOOM8AYV2cihqmzomw7gg/XIHG7hypqeLeHgOv+aUSvD4D5uEna0xx0B4WL+
	 qonkw5j1WSlQddsxIYMF4YTx/fCY30osHoTK1GqNLHSMphEtk8rEbWAPcUPokcQfhBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNBwqO2p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E7606A5A2;
	Mon,  2 Nov 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNBwqO2p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F081F00A16;
	Mon,  2 Nov 2026 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793641588;
	bh=qYyD49aeXrQ/bZeNGHoSmAuESNs1lMdSf2HL87qSocs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GNBwqO2px9Jg9kN6VOJHtWHGihyWvqggdiUZXBvqVweYC0y/nkaK9EkT7mU1anu0n
	 oLDd9Uam8ypHVE5BGHwwJ79x0fReUU3gu6/nFgxBmVU1Au/5aKuh0PM7wU5O2/n5oX
	 UFlVE69evaUmCgFJL1UtnJuQXyl8AEgV13/OU664LvUIY6eYmF2B14uU/2u/Jgn2wM
	 x6qAMmAY2JMZPkMuxtVaG+3kGB7O6NaUspPhdMarYYXzYwFP5Gc6xgqWvhzTrcGkFD
	 sBzudMDSYdtfpufoZ7DP0AV5uxLkaOs4zzAN14ppBdqmXOpgJ2z5ID0oKnFumIVSKB
	 ivyFg76ze+9ZQ==
Subject:
 Re: [PATCH net] net/sched: em_ipt: reject hook values >= NF_INET_NUMHOOKS
From: netdev-bot+sashiko@kernel.org
To: hj351016@gmail.com
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 17:46:27 +0000
Message-ID: <179364158761.3131.14745083619044110931@kernel.org>
In-Reply-To: <20261029163516.2476127-1-hj351016@gmail.com>
References: <20261029163516.2476127-1-hj351016@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is redundant.

--

net/sched: em_ipt: reject hook values >= NF_INET_NUMHOOKS

This patch adds a range check on TCA_EM_IPT_HOOK in em_ipt_change(), so
hook values >= NF_INET_NUMHOOKS are rejected before check_match() uses
im->hook as a shift amount. According to the commit message, an "addrtype"
match can otherwise carry any hook value and trigger a UBSAN
shift-out-of-bounds.

> diff --git a/net/sched/em_ipt.c b/net/sched/em_ipt.c
> index 26f1c4269a487..53358886a88c5 100644
> --- a/net/sched/em_ipt.c
> +++ b/net/sched/em_ipt.c
> @@ -168,6 +168,11 @@ static int em_ipt_change(struct net *net, void *data, int data_len,
>  
>  	im->match = match;
>  	im->hook = nla_get_u32(tb[TCA_EM_IPT_HOOK]);
> +	if (im->hook >= NF_INET_NUMHOOKS) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +

[Severity: Medium]
Can this condition ever be true? The tree already contains commit
94cea342e891 ("net: sched: em_ipt: validate hook value from netlink").
That commit added the same check to em_ipt_change(), right after the
required-attribute check:

net/sched/em_ipt.c:em_ipt_change() {
    ...
	if (!tb[TCA_EM_IPT_HOOK] || !tb[TCA_EM_IPT_MATCH_NAME] ||
	    !tb[TCA_EM_IPT_MATCH_DATA] || !tb[TCA_EM_IPT_NFPROTO])
		return -EINVAL;

	if (nla_get_u32(tb[TCA_EM_IPT_HOOK]) >= NF_INET_NUMHOOKS)
		return -EINVAL;
    ...
}

That check runs before get_xt_match() and kzalloc(), for every match name,
"addrtype" included. A hook value of 32 is rejected with -EINVAL long
before check_match() gets to:

	mtpar.hook_mask	= 1 << im->hook;

So the new branch looks like dead code.

For the same reason, some statements in the commit message don't seem to
match the current tree:

  "em_ipt_change() reads the TCA_EM_IPT_HOOK netlink attribute into
  im->hook as an unbounded u32"

  "the only range check on the hook lives in
  policy_validate_match_data()"

  "A filter using match_name "addrtype" can therefore carry an arbitrary
  hook value."

Was the v7.3-rc3 reproduction done on a tree without 94cea342e891?

94cea342e891 has no Fixes: or Cc: stable tag. Would it be better to drop
this patch and ask for 94cea342e891 to be backported to stable instead?

If the range should also be enforced in the netlink policy, em_ipt_policy
still has a bare NLA_U32 entry:

	[TCA_EM_IPT_HOOK]		= { .type = NLA_U32 },

Could this become NLA_POLICY_MAX(NLA_U32, NF_INET_NUMHOOKS - 1) and replace
the open-coded check, instead of adding a second copy of it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029163516.2476127-1-hj351016%40gmail.com
