Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6139318146
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972247; cv=none; b=pYmAocuo5vP7C5WJsRutr86Bxle9m33DqWm3BSMP0BSjYtFhJ5smZ+uK4Q5uaIIbchHZhd8uQXonC4kgx+nr2g5rRn/VrS03JVwC+a3PQ25c2Fy2bPlvO5xoCE9NiD21X9ej/Twc01s+UGczXhRNExPWpDrZhReEJUBddhIe6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972247; c=relaxed/simple;
	bh=Pw43fiogz5vKadBewsuWAaZ3YGjE5iqf3I+grhtQezc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQmHddpU+Fgq1cCrzxj5oADNb1NpRK9N4iQ+PE1fv9CPpuCNWoOZECYjsSRtN0JzfLeVTTAMcAY4JqRohFAAGe6bnlYk3nqqkgfoqGaWYlCg+iswMKeB1EWG/rF8iNz9tQoENROASwQIxZ3eXaZqaCNl2tN5xNQv+gLxNRo61Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wybcGsJv; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wybcGsJv"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Pw43fiogz5vKadBewsuWAaZ3YGjE5iqf3I+grhtQezc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789972243; v=1; x=1790577043;
 b=wybcGsJvF+HCH2qTNMozklLEoixdJYHPpvX1lOcFN5MiSCkAE+vP88zxhPsrgzcoE/rQ9keQ
 znmDx4bFwhtz8j+AyNEn10z3dSWv/B2JeEyZ9WLpXYuyktLnvuvRxHzt4xxut0t5ne5kVt/J/Xq
 jThKOu6tEVkqOF4MChfnsBys=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id dbd121085093f2de;
	Mon, 21 Sep 2026 06:30:27 +0000
X-Mizu-Trace-ID: dbd121085093f2de
X-Migadu-Flow: FLOW_OUT
Date: Mon, 21 Sep 2026 14:30:17 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Hui Peng <benquike@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Tom Herbert <therbert@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] fou: reject omitted FOU_ATTR_IPPROTO on
 FOU_ENCAP_DIRECT
Message-ID: <arDOTqytCxWKOyxv@fedora>
References: <CAAVpQUDwLnRfv1PkkexsC04D8wLSeARekuUDSTOenyRctWG8MA@mail.gmail.com>
 <20260921045920.1613098-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921045920.1613098-1-benquike@gmail.com>

On Mon, Sep 21, 2026 at 04:59:20AM +0000, Hui Peng wrote:
> Commit 7a9bc9e3f423 ("fou: Don't allow 0 for FOU_ATTR_IPPROTO.") added
> NLA_POLICY_MIN(NLA_U8, 1) to fou_nl_policy[FOU_ATTR_IPPROTO], which
> rejects an explicitly supplied FOU_ATTR_IPPROTO == 0 attribute with
> -ERANGE.
> 
> However, FOU_ATTR_IPPROTO is an optional netlink attribute. When a user
> sends FOU_CMD_ADD with FOU_ATTR_TYPE set to FOU_ENCAP_DIRECT and omits
> FOU_ATTR_IPPROTO entirely, nla_policy validation succeeds and
> parse_nl_config() leaves cfg->protocol as 0 (from memset(cfg, 0,
> sizeof(*cfg))). fou_create() then creates a FOU_ENCAP_DIRECT socket with
> fou->protocol == 0.
> 
> In fou_udp_recv(), returning -fou->protocol to udp_queue_rcv_one_skb()
> triggers IP protocol resubmission when fou->protocol > 0, whereas
> returning 0 tells the UDP tunnel layer that the skb was consumed without
> freeing it. When fou->protocol == 0, every packet received on the socket
> returns 0 from fou_udp_recv() and leaks the sk_buff.
> 
> Reject FOU_ENCAP_DIRECT when !cfg->protocol in fou_create() so that
> creating a direct encapsulation port without FOU_ATTR_IPPROTO fails with
> -EINVAL while leaving FOU_CMD_DEL and FOU_CMD_GET (which share
> parse_nl_config()) unaffected.
> 
> Tested in QEMU against Linux 7.3.0-rc3 by sending a FOU_CMD_ADD Generic
> Netlink request with FOU_ATTR_PORT = 5555 and FOU_ATTR_TYPE =
> FOU_ENCAP_DIRECT while omitting FOU_ATTR_IPPROTO. On the unfixed kernel,
> FOU_CMD_ADD succeeds (err = 0), FOU_CMD_GET reports fou->type = 1 and
> fou->protocol = 0, and sending 4000 UDP packets to 127.0.0.1:5555 leaks
> all 4000 sk_buffs (SUnreclaim in /proc/meminfo grows from 41456 kB to
> 59008 kB, +17552 kB); with this patch applied, FOU_CMD_ADD is rejected
> with -EINVAL (-22).
> 
> Fixes: 23461551c006 ("fou: Support for foo-over-udp RX path")
> Fixes: 7a9bc9e3f423 ("fou: Don't allow 0 for FOU_ATTR_IPPROTO.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Clarify in the commit message that fou->protocol == 0 is reached on
>   current kernels by omitting the optional FOU_ATTR_IPPROTO attribute
>   when FOU_ATTR_TYPE is FOU_ENCAP_DIRECT (whereas an explicit 0
>   attribute is rejected by commit 7a9bc9e3f423), as noted by Kuniyuki
>   Iwashima and Sashiko.
> - Move the !cfg->protocol check from parse_nl_config() into the
>   FOU_ENCAP_DIRECT branch of fou_create() so FOU_CMD_DEL and FOU_CMD_GET
>   are not affected, and drop the redundant check in fou_udp_recv(), as
>   suggested by Sashiko.
> - Fix the Fixes: commit tags to 23461551c006 and 7a9bc9e3f423, as
>   pointed out by Hangbin Liu and Kuniyuki Iwashima.
> 
>  net/ipv4/fou_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 5e867f1b5c1d..f30f22389283 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -600,6 +600,10 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
>  	/* Initial for fou type */
>  	switch (cfg->type) {
>  	case FOU_ENCAP_DIRECT:
> +		if (!cfg->protocol) {
> +			err = -EINVAL;
> +			goto error;
> +		}
>  		tunnel_cfg.encap_rcv = fou_udp_recv;
>  		tunnel_cfg.gro_receive = fou_gro_receive;
>  		tunnel_cfg.gro_complete = fou_gro_complete;
> -- 
> 2.49.0

Looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
