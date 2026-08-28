Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F284315F
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901500; cv=none; b=tDmCmyb63+2/cMZvGUIwtZjAINgfDVJuIJyFeKbr+8I6vhS8USmIbkdbEPZCFkRFfn+mm8iAOFJZK2ZFhM0jdwLsAKdLHi+wdCd6jUHQCTL7srYRtH5E+Ys1+E40OUNqQ70tmhyHx59UJDFcZ9YsXXuReP/cJrdBVBgBAE9HJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901500; c=relaxed/simple;
	bh=EyM07Uw8LqZupBVNP8WyHv4g2L5HNpw85p6dXlSM9xk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ngOzIXH7sMHeeKVtpq8fOEYBTq2K3U8xNembPFYwwbl+zTi7FMyrZzcZgWpwgaZyqLLG8vdfWM5MfdNkjDNYul/72Q1aQNf6Xbc1InDZlPFR08WHWKU9PfBvAfv7pq6wON3fiGE5RnJNyVuQV4ho2B2uVNbINXLE/oZpo824Lvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oQlfsA5p; arc=none smtp.client-ip=95.215.58.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oQlfsA5p"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EyM07Uw8LqZupBVNP8WyHv4g2L5HNpw85p6dXlSM9xk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787901496; v=1; x=1788506296;
 b=oQlfsA5pxQGE3mPi4IotNWFQ5I6u0fdbMQp2I1gmK/M49YUqXkjHqoF90gHEwTKgNAXB13hR
 y6PzJZEwyeuKoNuywOsWJ4LayKA96IqwInLoKWvOKOxlHvDfx5U3ky31uIPecqQct0nW16IW8v1
 VsTITPA+a2lYJLDczH2xNPqo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e9c5d0fed02762d4;
	Fri, 28 Aug 2026 07:18:06 +0000
X-Mizu-Trace-ID: e9c5d0fed02762d4
X-Migadu-Flow: FLOW_OUT
Message-ID: <7a6ba0f3-efc0-45f1-a372-ced250733b62@linux.dev>
Date: Fri, 28 Aug 2026 15:17:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: Re: [PATCH net v3] mac802154: fix data race and NULL deref on
 local->assoc_dev
To: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 linux-wpan@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260827221339.885245-1-skwkevin@mail.ustc.edu.cn>
In-Reply-To: <20260827221339.885245-1-skwkevin@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/28 06:13, Kaiwen Shi 写道:
> @@ -599,25 +603,38 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
>   		goto clear_assoc;
>   	}
>   
> -	if (local->assoc_status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
> -		if (local->assoc_status == IEEE802154_PAN_AT_CAPACITY)
> +	/* The association is complete: clear the associating bit and snapshot
> +	 * the result under the same lock, so a second (e.g. malicious) ASSOC
> +	 * RESP can no longer pass the recheck below and overwrite
> +	 * assoc_status/assoc_addr before they are consumed.
> +	 */
> +	spin_lock(&local->assoc_lock);
> +	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);

I think this clear_bit() should be moved to
mac802154_process_association_resp(), after saving the first valid
response and before calling complete().

Clearing it only after wait_for_completion() returns may still leave a
window, since the woken waiter may not acquire assoc_lock before the
next work item runs. Clearing it earlier in the response handler ensures
that subsequent responses fail the in-lock
IEEE802154_IS_ASSOCIATING check and cannot overwrite the saved result.

> +	resp_status = local->assoc_status;
> +	resp_short_addr = local->assoc_addr;
> +	spin_unlock(&local->assoc_lock);
> +
> +	if (resp_status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
> +		if (resp_status == IEEE802154_PAN_AT_CAPACITY)
>   			ret = -ERANGE;
>   		else
>   			ret = -EPERM;
>   
>   		dev_warn(&sdata->dev->dev,
>   			 "Negative ASSOC RESP received from %8phC: %s\n", &ceaddr,
> -			 local->assoc_status == IEEE802154_PAN_AT_CAPACITY ?
> +			 resp_status == IEEE802154_PAN_AT_CAPACITY ?
>   			 "PAN at capacity" : "access denied");
> -		goto clear_assoc;
> +		return ret;
>   	}
>   
> -	ret = 0;
> -	*short_addr = local->assoc_addr;
> +	*short_addr = resp_short_addr;
> +
> +	return 0;
>   
>   clear_assoc:
> +	spin_lock(&local->assoc_lock);
>   	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
> -	local->assoc_dev = NULL;
> +	spin_unlock(&local->assoc_lock);
>   
>   	return ret;
>   }
> @@ -639,19 +656,23 @@ int mac802154_process_association_resp(struct ieee802154_sub_if_data *sdata,
>   		     dest->mode != IEEE802154_EXTENDED_ADDRESSING))
>   		return -EINVAL;
>   
> -	if (unlikely(dest->extended_addr != wpan_dev->extended_addr ||
> -		     src->extended_addr != local->assoc_dev->extended_addr))
> +	spin_lock(&local->assoc_lock);
> +	if (unlikely(!test_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing) ||
> +		     dest->extended_addr != wpan_dev->extended_addr ||
> +		     src->extended_addr != local->assoc_dev_extended_addr)) {
> +		spin_unlock(&local->assoc_lock);
>   		return -ENODEV;
> +	}
>   
>   	memcpy(&resp_pl, skb->data, sizeof(resp_pl));
>   	local->assoc_addr = resp_pl.short_addr;
>   	local->assoc_status = resp_pl.status;

here

> +	complete(&local->assoc_done);
> +	spin_unlock(&local->assoc_lock);
>   
>   	dev_dbg(&skb->dev->dev,
>   		"ASSOC RESP 0x%x received from %8phC, getting short address %04x\n",
> -		local->assoc_status, &deaddr, local->assoc_addr);
> -
> -	complete(&local->assoc_done);
> +		resp_pl.status, &deaddr, resp_pl.short_addr);
>   
>   	return 0;
>   }
>
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f

Thanks,
Xuanqiang

