Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23950414A3E;
	Fri, 31 Jul 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497849; cv=none; b=XkGL56v4n0XlPjCBDqJI+75oqVuk2prs+EjgmOKRcxwJm08/P4hInNiles7dchQ05m8HOYwawvom3vfQNGv3UaXua7OAxYH6uANRVH2SyUANizXSDKmQJc3zoJ9GMe3OHNZD3IvyyCfFqk9rSgOiVUTRUtK1a58EwtywUDnw4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497849; c=relaxed/simple;
	bh=7Sn48he+rdlQtYXAuY6cpbjpQDCNneUf09yYbkpyzUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDmGXYNrtj3LRfUjgbtMjr7pnDkQuK/4L+jKjOr7ygL6tVBqzickeMHCDtS2BbZ+7VNxNfI4k1ZuD2ZsIOs4yUXEooBbCxzBaA1jlkwGxVOrF6DqZ/St5nzvAVq6/uFfq5iYEKWcmv+Zk1jJWOxOuXwO8/P8tq3P/Mwnopld0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQbDxvm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQbDxvm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584901F000E9;
	Fri, 31 Jul 2026 11:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785497841;
	bh=F/MDOe9opDRyYbgsZs9sWlBc3DB1vw8Ig3W/GgXfiT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IQbDxvm4p1bfjj7yxPK0MTbzo5bUSNiYhepZeDPYk4/ujgdQ42pBcM636TkKWD5/J
	 Y1qncu38LzHm4v8vW3IK+jcQQ302aacOOsOc8e2tzqpjmPtve9QrCyJKeRsJX84DU6
	 MyQwI/IJCcKDc+LmN/nSF38NldxmajxCoIjZAibM88fXOyEOsYHFIXpTuwZqc1LXI1
	 qi4/eqPRIL4fqH8CkGGDoHj59bYzJwoMKcdiJqlaPAiKHvXVia/30oV+H3VbTD5XBQ
	 Ry50gBMOCMLrNElbRrFFveJTLxs+KHDMcP+0OPiM7U3e4SE6HQsnt71+2hWE05iX7h
	 IaqbJkEC78rtw==
Message-ID: <fff6ba5e-78f1-4b33-8184-5990d40020c2@kernel.org>
Date: Fri, 31 Jul 2026 13:37:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 1/5] mptcp: avoid combining some incoming suboptions
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Florian Westphal <fw@strlen.de>, Davide Caratti <dcaratti@redhat.com>,
 Christoph Paasch <cpaasch@openai.com>
References: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
 <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-1-f7e2d229159d@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-1-f7e2d229159d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

TL;DR: a v2 is expected

pw-bot: cr

I'm replying here to Clashiko's comments:

> mptcp: avoid combining some incoming suboptions
> 
> This adds combination checks to the incoming MPTCP suboption parser in
> mptcp_parse_option(), reusing the exclusivity table already applied on the
> transmit side, plus a new OPTIONS_MPTCP_DSS helper macro that folds the
> checksum bit into the DSS bit for those checks.
> 
> A few questions about the receive-side behaviour below.
> 
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index c664023d37ba..3b8539f1c224 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -50,6 +50,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  			}
>>  		}
>>  
>> +		/* Only the MPC + ACK can be used with a RM_ADDR */
>> +		if (subopt == OPTION_MPTCP_MPC_ACK) {
>> +			if ((mp_opt->suboptions & ~OPTION_MPTCP_RM_ADDR) != 0)
>> +				break;
> 
> Can this drop either the keys or the data mapping when a peer puts an
> MP_CAPABLE(ACK) and a separate DSS in the same third ACK?
> 
> mptcp_get_options() walks the TCP options in wire order and calls
> mptcp_parse_option() once per option, so each gate only sees the options
> that came earlier in the segment:
> 
>   [DSS, MP_CAPABLE ACK] -> this gate sees OPTION_MPTCP_DSS set and breaks,
>                            so sndr_key/rcvr_key are never stored
>   [MP_CAPABLE ACK, DSS] -> the DSS gate below does not allow
>                            OPTIONS_MPTCP_MPC, so the mapping is dropped
> 
> The comment a few lines further down in this same case quotes RFC 8684
> Section 3.1, "the data parameters in a MP_CAPABLE are semantically
> equivalent to those in a DSS option and can be used interchangeably", which
> does not seem to forbid a separate DSS in the same segment.
> 
> Losing the MP_CAPABLE here ends in a fallback to plain TCP; losing the DSS
> leaves the payload of that ACK without a mapping. Neither path bumps a MIB
> counter nor emits a pr_debug, so should there be some counter to make the
> drop visible?

An MPC ACK is not supposed to be used with a DSS: the MPC ACK can carry
a Data-Level Length, and optional Checksum, which are the same as the
ones we can find in a DSS, but they can be present in an MPC ACK because
a DSS is not supposed to be sent in combination to an MPC ACK.

Note that an MPC ACK without data takes 20B, 24B with data. A DSS with
data is taking 20 to 28B, not leaving much space out of the 40B. That's
one reason why they shouldn't be used together.

>> +		} else if (mp_opt->suboptions != 0) {
>> +			break;
>> +		}
> 
> Since the checks are evaluated against the suboptions accumulated so far,
> does the surviving suboption now depend on the order the peer chose, which
> RFC 8684 does not define?
> 
>   [RM_ADDR, MP_CAPABLE SYN] -> this else-if branch breaks, OPTION_MPTCP_MPC_SYN
>                                is never set, subflow_check_req() sees no MPC and
>                                the passive socket stays plain TCP
>   [MP_CAPABLE SYN, RM_ADDR] -> only the RM_ADDR is dropped, MPTCP still works
> 
>   [ADD_ADDR, MP_JOIN SYN]   -> the MP_JOIN gate below tolerates only
>                                RM_ADDR|PRIO, so the join is dropped
>   [MP_JOIN SYN, ADD_ADDR]   -> only the ADD_ADDR is dropped
> 
> Would it be preferable to decide on the full set of parsed suboptions once
> the whole option list has been walked, so that the outcome does not depend
> on sender-side ordering?

I don't think so: having such combinations either means the remote peer
is buggy, or is evil. I don't think the code should try to support these
bad cases, and it should do the simplest action when this is seen: stop
processing the current suboption.

> Do these two gates make the existing MP_CAPABLE + MP_JOIN handling in
> net/mptcp/subflow.c unreachable?
> 
> subflow_check_req() has:
> 
> 	if (opt_mp_capable) {
> 		...
> 		if (opt_mp_join)
> 			return 0;
> 	}
> 
> and mptcp_subflow_init_cookie_req() has:
> 
> 	if (opt_mp_capable && opt_mp_join)
> 		return -EINVAL;

Correct: but it sounds better to keep them here for the moment, just an
extra cheap check. They can be removed in -next in a follow-up patch.

> After this patch mp_opt->suboptions can no longer hold an MPC bit together
> with an MPJ bit, so both branches look dead, and a SYN carrying both
> suboptions is no longer treated as ambiguous but handled as whichever option
> appeared first. Should the commit message mention that semantic change,
> given the Fixes and Cc: stable tags?

Now, all inconsistent combinations are handled the same way. I don't
think we should add an exception to this MPC+MPJ case. A precision could
be added to the commit message for this unexpected error path.

>> +
>>  		/* Cfr RFC 8684 Section 3.3.0:
>>  		 * If a checksum is present but its use had
>>  		 * not been negotiated in the MP_CAPABLE handshake, the receiver MUST
>> @@ -122,6 +130,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  		break;
>>  
>>  	case MPTCPOPT_MP_JOIN:
>> +		/* Can be used with a restricted number of other options */
>> +		if ((mp_opt->suboptions & ~(OPTION_MPTCP_RM_ADDR |
>> +					    OPTION_MPTCP_PRIO)) != 0)
>> +			break;
>> +
> 
> Is an MP_JOIN(ACK) combined with a DSS still expected to work?
> 
> MPJ_ACK is 24 bytes and a DSS with a 32-bit mapping is 14 bytes, so 38 bytes
> fit in the TCP option space and both were parsed before this patch. With
> this mask, [DSS, MP_JOIN ACK] drops the MP_JOIN and [MP_JOIN ACK, DSS] drops
> the mapping in the DSS gate below, leaving the payload of the fourth ACK
> without a mapping.

14 bytes is without the "base": Kind + Length + Subtype + Flags. So 4
more bytes are required (+ 2 for the alignment). The total then exceeds 40.

>>  		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
>>  			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
>>  			mp_opt->backup = *ptr++ & MPTCPOPT_BACKUP;
>> @@ -153,6 +166,13 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  		break;
>>  
>>  	case MPTCPOPT_DSS:
>> +		/* Can be used with a restricted number of other options */
>> +		if ((mp_opt->suboptions & ~(OPTION_MPTCP_ADD_ADDR |
>> +					    OPTION_MPTCP_RM_ADDR |
>> +					    OPTION_MPTCP_PRIO |
>> +					    OPTION_MPTCP_FAIL)) != 0)
>> +			break;
>> +
> 
> This isn't a bug introduced by this patch, but it is the same class of
> malformed-combination state the patch is trying to constrain, and the new
> masks cannot see it because they only look at suboption bits.
> 
> In this case the DSS flags are committed to mp_opt before the length is
> validated:
> 
> net/mptcp/options.c:mptcp_parse_option() {
> 	...
> 	flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
> 	mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
> 	mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
> 	mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
> 	mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
> 	...
> 	if (opsize != expected_opsize &&
> 	    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
> 		break;
> 	...
> }
> 
> On that break path no suboption bit is set, so mp_opt->suboptions is still
> 0 and both this gate and the MP_CAPABLE gate above are passed by a second
> option in the same segment, while use_ack/ack64/use_map/data_fin keep the
> values from the rejected DSS.
> 
> mptcp_get_options() only clears the four-byte status group:
> 
> 	*(u32 *)&mp_opt->status = 0;
> 
> so data_ack, data_seq, subflow_seq, data_len and csum of the caller's
> on-stack struct mptcp_options_received are untouched unless the matching
> parse path writes them.
> 
> Two sequences that reach the consumer with those stale flags:
> 
>   [malformed DSS with HAS_ACK, MP_CAPABLE ACK+DATA]
>       MP_CAPABLE sets OPTION_MPTCP_DSS, use_ack is still 1, so
>       mptcp_incoming_options() runs
> 
> 	if (mp_opt.use_ack)
> 		ack_update_msk(msk, sk, &mp_opt);
> 
>       with an uninitialized mp_opt.data_ack feeding mptcp_expand_seq() and
>       the msk->snd_una / msk->wnd_end bookkeeping.
> 
>   [malformed DSS with HAS_MAP|DATA_FIN, valid ack-only DSS]
>       data_fin is only reassigned under if (mp_opt->use_map), so the stale
>       data_fin survives, and on a pure ACK mptcp_incoming_options() runs
> 
> 	if (mp_opt.data_fin && mp_opt.data_len == 1 &&
> 	    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
> 
>       with uninitialized data_len/data_seq; if the leftover data_len happens
>       to be 1, mptcp_update_rcv_data_fin() records a DATA_FIN at an
>       arbitrary sequence.
> 
> Would it make sense to move the DSS scratch-field assignments after the
> opsize validation, or to zero the whole mp_opt in mptcp_get_options(), so
> the new combination checks operate on a clean state?

Indeed, but that's an existing issue. This will be addressed in a
follow-up patch.

>>  		pr_debug("DSS\n");
>>  		ptr++;
>>  
> 
> [ ... ]
> 
>> @@ -316,6 +357,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  		break;
>>  
>>  	case MPTCPOPT_MP_FASTCLOSE:
>> +		/* Can be used only with RST */
>> +		if ((mp_opt->suboptions & ~OPTION_MPTCP_RST) != 0)
>> +			break;
>> +
> 
> Does this stop an MP_FASTCLOSE carried in a plain ACK from being honoured?
> 
> RFC 8684 Section 3.5 allows MP_FASTCLOSE in an ACK, and this parser
> deliberately does not require TCPHDR_RST for MP_FASTCLOSE, unlike the
> MPTCPOPT_RST case which does:
> 
> 	if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
> 		break;
> 
> An ACK on an established subflow normally also carries a DSS data-ACK, so
> either the FASTCLOSE is dropped here (DSS parsed first) or the DSS is
> dropped by the DSS gate above (FASTCLOSE parsed first, since that mask does
> not include OPTION_MPTCP_FASTCLOSE). When the FASTCLOSE is dropped,
> msk->rcv_fastclose is never set and the connection is not aborted.
> 
> The existing consumer looks like it was written for exactly that
> combination:
> 
> net/mptcp/options.c:mptcp_incoming_options() {
> 	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
> 		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
> 		    READ_ONCE(msk->local_key) == mp_opt.rcvr_key) {
> 			WRITE_ONCE(msk->rcv_fastclose, true);
> 	...
> 		if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
> 			return true;
> 	}
> 	...
> }
> 
> With this restriction the FASTCLOSE plus DSS fall-through into the DSS
> handling can no longer be reached. Was the intent to make that path dead, or
> should FASTCLOSE be allowed together with OPTIONS_MPTCP_DSS as well?
> 
>>  		if (opsize != TCPOLEN_MPTCP_FASTCLOSE)
>>  			break;
>>  
> 
> [ ... ]

Yes, indeed, in the rcv path, it is possible another networking stack
sends an MP_FASTCLOSE with a DSS, and that's valid.

This will be addressed in v2.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

