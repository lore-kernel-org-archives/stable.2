Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771928;
	b=gCH40kCjgDTGalo44eyIn1Bz32WBe7HPV3cN4WPAVnxb7wo949DJxtNkEwXxBhjWcmEM
	 lUt/05v+6fIi4Prc6iDECSYHKhUOwxvm4ZTMwfiQ8ntUL7ENnPbRIqrj319qgvnNkUTYH
	 /SDnLXWbdF2EJXCDnYOpNBhL0fdcq6DHOi7Zvv9EoyZJSfeCMuKEq+WPOJK176cmc7qsl
	 tgSp2KfvZaYTKSgAIA/3uK1Y54h9RTC/0ZLPKk2O86o2AnC7Kgs03dBs3237nAOLPZhOx
	 aWkjqB6X52okfwg/mA0MK7ZacqwCsHvQIERMIoq6ztWIJ2bhmXBR81jJSsHzQEQuGFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771928;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=P5H1UtdNG0IVlBl4B099ATxaMAxcjN+PgajoMRiqNyM=;
	b=sFMj7ysa/JpQgXtCm8swzT/eirlj/eBD+NaHtW4zziFf1LZnUO8lmjDZfA26wDL+ZZYF
	 lDpPl5lEEnIvdcjvrUNFdaLky88aDNdkbEr9GHpeA+0xonlzS5fi0ISXFw28m/9/+ZAKY
	 FooLTpaUB0D2SS4/ucu/b3wMpVBUBudBdO0KtDVw1mrCtO5iSaA8SDQZphqLitzajI515
	 883qkU0n1AFyFyHffjWooJ141VVTNPPi4YJc2zWj3HN+bikevytjlheD+I+rmH6fJipHd
	 E+ZHJo2KCfxYxeUuAFTZAReySGm7NLp4JGt68KMM9nbA2FScQA5h4eJbv+/7FBoUR+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UNGqzMrg;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743D606A31C;
	Fri, 27 Nov 2026 09:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B743D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UNGqzMrg
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7E291758;
	Fri, 27 Nov 2026 01:32:03 -0800 (PST)
Received: from [10.57.17.186] (unknown [10.57.17.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B75CF3F632;
	Fri, 27 Nov 2026 01:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795771926; bh=FC8taQlW07RfSKNprMnHpaLhzfqRtyfk+PClB7jjKJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UNGqzMrg4c0bYO9yrju2/NL6yF656Swbzz8OdGZGNW2NWVxfirdkg8P8addv5rx48
	 sXJnYhwJGYH7EvzOydvWedLM4XuvaFD2NPqqX0gxaFRx3PwOeS5GS1stAVEfoDWQ3o
	 4bwO1Wmw2lgHCCE+6nHIAHW2WzgQ+XbcBnnS3YYM=
Message-ID: <8908fb90-ebf0-4652-b44b-657bcf796f80@arm.com>
Date: Fri, 27 Nov 2026 09:32:38 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Fix netlink performance-domain dump pagination
To: Shubhang Kaushik <sh@gentwo.org>, Shubhang Kaushik <shubhangpk@gmail.com>
Cc: Christoph Lameter <cl@gentwo.org>, Changwoo Min <changwoo@igalia.com>,
 Donald Hunter <donald.hunter@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org, stable@vger.kernel.org
References: <20261125-pm-em-dump-v2-1-a28e132f8b0c@gentwo.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20261125-pm-em-dump-v2-1-a28e132f8b0c@gentwo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/26 18:10, Shubhang Kaushik wrote:
> GET_PERF_DOMAINS dumps performance domains through:
> 
>    netlink_dump()
>      -> dev_energymodel_nl_get_perf_domains_dumpit()
>        -> for_each_em_perf_domain()
>          -> __em_nl_get_pd_for_dump()
> 
> The dump handler rebuilds its local cursor from cb->args[0] on each
> callback. When the response skb fills, it returns -EMSGSIZE and the
> netlink core sends the nonempty skb before retrying the dump. However,
> the updated cursor is not saved in cb->args[0], so the retry restarts at
> domain zero.
> 
> For example, if domains 0 and 1 fit in the first skb but domain 2 does
> not, every subsequent callback emits domains 0 and 1 again and never
> progresses beyond domain 2. The handler also advances the cursor before
> encoding the domain and finalizes its partially encoded message on
> failure.
> 
> Advance the cursor only after a domain has been encoded successfully,
> cancel incomplete messages, and store the next domain index in
> cb->args[0]. Return skb->len whenever data was written so netlink_dump()
> sends the current chunk and continues the dump, propagating errors only
> when skb->len is zero.
> 
> Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL spec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shubhang Kaushik <sh@gentwo.org>
> ---
> Changes in v2:
> - Return skb->len whenever data has been written to the skb, propagating
>    negative error codes only when skb->len == 0.
> 
> Testing:
> - Validated dev-energymodel YNL spec and exercised GET_PERF_DOMAINS
>    dumps via tools/net/ynl/pyynl/cli.py on an 80-core Ampere Altra,
>    including registering 4 test performance domains and forcing
>    per-domain -EMSGSIZE splits across multiple netlink_dump() chunks.
> 
> Link to v1: https://lore.kernel.org/r/20261124-pm-em-dump-v1-1-8f9167d437bc@gentwo.org
> ---
>   kernel/power/em_netlink.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 1f68d456a713c08d7a4f690e88c03182f6ee3ef1..4e85439ed76d240e013cf372dcbc77b3af28d598 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -80,19 +80,25 @@ static int __em_nl_get_pd_for_dump(struct em_perf_domain *pd, void *data)
>   	void *hdr;
>   	int ret;
>   
> -	if (ctx->idx++ < ctx->start)
> +	if (ctx->idx < ctx->start) {
> +		ctx->idx++;
>   		return 0;
> +	}
>   
>   	info = genl_info_dump(ctx->cb);
>   	hdr = genlmsg_iput(ctx->skb, info);
> -	if (!hdr) {
> -		genlmsg_cancel(ctx->skb, hdr);
> +	if (!hdr)
>   		return -EMSGSIZE;
> -	}
>   
>   	ret = __em_nl_get_pd(pd, ctx->skb);
> +	if (ret) {
> +		genlmsg_cancel(ctx->skb, hdr);
> +		return ret;
> +	}
> +
>   	genlmsg_end(ctx->skb, hdr);
> -	return ret;
> +	ctx->idx++;
> +	return 0;
>   }
>   
>   struct em_nl_doit_ctx {
> @@ -166,7 +172,15 @@ int dev_energymodel_nl_get_perf_domains_dumpit(struct sk_buff *skb,
>   		.cb = cb,
>   	};
>   
> -	return for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
> +	int ret;
> +
> +	ret = for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
> +	cb->args[0] = ctx.idx;
> +
> +	if (ret && !skb->len)
> +		return ret;
> +
> +	return skb->len;
>   }
>   
>   static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)
> 
> ---
> base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
> change-id: 20261124-pm-em-dump-00f32b88fd6c
> 
> Best regards,


That looks good, it should fix the skipping entry issues.
Thanks for the fix.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>




