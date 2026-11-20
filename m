Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215023;
	b=US/Tk7+MyXYDvGhdQbLTkx4MevZ+qv7YvrSBSOv4uUGFKAykWM1uk00rh7xGCs474Lr8
	 JgzL1WI2lO/Xs0ZLWOzgAn3ym86gRrh3VbK2ILQLrgZ77DL6rOUaL9SRqc6gTrD0XETqT
	 cB2oX1Skpdkf5AJg54IxlXZ181OcWLCjmuNiFvUeuBXLPxaq4qO8ZXQ3l1+iU25ra816i
	 thkWjocLWMKD6OYcNRE3ArbhWhOZz0GuhLRk+cR6b6QJbnYqAyo21ptspHfP05FUFQ8b/
	 D3r0Cddq8ukeqF7QiCbU0ZJXUYz3XKCD0GyApzkKw2koE7bnenCPLh9xap9UWAjZ88Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215023;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=teexMSd8PHdfaM03rUjjEKQ2tL2BcpPqCRX495L4lZM=;
	b=4qMl3hUBKU+1n0anp6YSYzrqOmEmWTFYJlO64xZyU+wihOjLqscwuIRI7Itdi0R+7KWz
	 eb6vEWLr67luHXcBrk+nl0HJje0DnXaFZ2OuQ9EOqqfWaIPHcEdKgnZtSnbnETTblECQd
	 AvgInM9yh4l+1jV8oGfkuIb6zCA41413SqPbwVl1A6GYj5I6/SldYpQI5CbEShW5wCYmm
	 3qAAG+rupfo4w79RlkEo5Fx791T8FVa1zOboW4UUXhGss7tr8mPMXyojgHnixEZ4nSb8D
	 XKfzTQQWvFpcQtRlk0lJWPEsAdqH17gpg5zwEO3G8fV96PFV41xoeXJTwXJXI9lwnbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EKrcD2EY;
	arc=none smtp.remote-ip=91.218.175.105
Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7B606A33E
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D7B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EKrcD2EY
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rYwH//s3ZpyAARSSd1MnfBFwVXfqUmxKvytgZIbg1u8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795215020; v=1; x=1795819820;
 b=EKrcD2EYwrim8wKNjZask/JMVfOilOIWboPZPxjVypk3fDw9G7bE5j12jZooP21W0W+zGV8/
 THKr/md0GWRkwVS65SatZiGhtA7PiJKtjvbZmdcbKw6i+jQD4501gVGDv5827tvtdddyHUYeI5+
 UQBlL6Hi/9QaN+uA7Hxst2MA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 15c7c981e0c8d853;
	Fri, 20 Nov 2026 22:50:19 +0000
X-Mizu-Trace-ID: 15c7c981e0c8d853
X-Migadu-Flow: FLOW_OUT
Message-ID: <bd1ed1fa-2ff2-435c-8e0c-372802eb7187@linux.dev>
Date: Sat, 21 Nov 2026 06:50:15 +0800
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
Subject: Re: [PATCH bpf v2] net: skmsg: fix copy cursor when coalescing clones
To: Kyle Zeng <kylebot@openai.com>, bpf@vger.kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, stable@vger.kernel.org
References: <20261120214511.25934-1-kylebot@openai.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261120214511.25934-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/26 5:45 AM, Kyle Zeng wrote:
> A splice or zero-copy append can leave the destination copy cursor at
> sg.end. If sk_msg_clone() subsequently coalesces with the last entry,
> sg.end does not advance and the cursor still points at an unused slot.
> sk_msg_memcopy_from_iter() can then walk around the ring and write into
> older entries, including file pages spliced from a read-only descriptor.
> 
> Software TLS can reach this with an ordinary MSG_MORE send after a file
> splice and a splice from another TCP socket. Both TCP and the TLS
> encrypted-message allocation can use the sending task's page fragment,
> so the TCP-sourced plaintext can be contiguous with the next cloned
> encrypted-message range.
> 
> When coalescing with an exhausted destination, move the copy cursor to
> the tail and set copybreak to its old length before extending it. Find
> the actual tail on each iteration using the ring iterator, including
> when end wraps to zero. Leave an existing copy cursor unchanged and
> preserve the normal coalescing, reference counting, and memory charging.
> 
> The issue was found by an LLM.
> 
> Fixes: fda497e5f5b8 ("Optimize sk_msg_clone() by data merge to end dst sg entry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Zeng <kylebot@openai.com>


Hi Kyle, I also received same issue from somewhere, but I think we should fix the root cause(TLS).
I have a fix patch and will send it shortly.
> ---
> v2:
> - Rebase onto the BPF fixes tree; no code changes.
> 
> v1: https://lore.kernel.org/bpf/20261030042138.73739-1-kylebot@openai.com/
> 
> I have a reproducer for this issue and can share via DM
> 
>  net/core/skmsg.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 8a3b8536c0c2..f47c59ba1ec6 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -103,16 +103,26 @@ int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
>  	}
>  
>  	while (len) {
> +		int last = dst->sg.end;
> +
>  		sge_len = sge->length - off;
>  		if (sge_len > len)
>  			sge_len = len;
>  
> -		if (dst->sg.end)
> -			sgd = sk_msg_elem(dst, dst->sg.end - 1);
> +		sgd = NULL;
> +		if (dst->sg.size) {
> +			sk_msg_iter_var_prev(last);
> +			sgd = sk_msg_elem(dst, last);
> +		}
>  
>  		if (sgd &&
>  		    (sg_page(sge) == sg_page(sgd)) &&
>  		    (sg_virt(sge) + off == sg_virt(sgd) + sgd->length)) {
> +			/* Start copying at the newly cloned suffix. */
> +			if (dst->sg.curr == dst->sg.end) {
> +				dst->sg.curr = last;
> +				dst->sg.copybreak = sgd->length;
> +			}
>  			sgd->length += sge_len;
>  			dst->sg.size += sge_len;
>  		} else if (!sk_msg_full(dst)) {
> 
> base-commit: d5ba86298b45e1a81c578c499e9a222a3b734d5d

