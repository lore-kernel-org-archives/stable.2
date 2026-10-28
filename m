Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198242;
	b=BVMCON45xJvIjK5jPF/U5Yhq5b9tVVqq7NHBj8jXD554lob/Ai72IJ21kSiuGnoEJj0C
	 OhrHdj58IQuHlyf54iPX0RZqu5EL0Utqu7RXrEXbWk/4P2J2QCC1CkPCr75F2+BhVLsLp
	 /LbU0O0j+ML1QDVGpYd6NBBlO3J3dyaW+ihxGGEDYSxTQhrNFpCUXO1KIcIzPyQdQa3GF
	 6Yit+uqpNeAlraqyVX+mRc3IA3xhCiWQmB2VmWblk2IT1k02WqwQk8wdz3yawGaW942Zf
	 0YgE127jxRyEucVHEarBYK6NSQe8TkI5VdKwpJ8XTRKVV8h1PGr7omxozWgLNdEC5dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198242;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pPQxkHJYfqZk37WDAM2FHcljmku7bcSuOn2JFLL4Fyg=;
	b=1BUVzkzHrKcRpxpIj8qYB2XsVGkv6As7FpnVbnO/8r5P3cjMPyWwxsZ0tq7u8nrqx4Z2
	 Fk7x0j4AeW26R/JH9WI/12xLOEbG2/thYS8iTRZTQxDTerbKzFIK3hpJYDmq0lZ2tvWaR
	 Ky7s4IcWH9B/V1YVdqU/Kn7XAAq16HXtWw5qQ0t8wO0+/G3oXjIMGI4UEh6Vz02DU1QSy
	 rCbsYBnj40hfgjYwBvawPYNxFRooS0jPuQGxKeMJ+OlaVY1Ia8sUKgUZs0uMx3gdxJ1m5
	 Lh1XsFulZChwxGotmXztVN/G6tfLYYjpPdgHtI6yrL6SWdMhmy8FKMrLUyyADaorS0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcWp7mA5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC318606A31A;
	Wed, 28 Oct 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcWp7mA5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC401F01825;
	Wed, 28 Oct 2026 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793198241;
	bh=pPQxkHJYfqZk37WDAM2FHcljmku7bcSuOn2JFLL4Fyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lcWp7mA5XJFge5P7O7vqY2e/Ljb3SfS35Bzk61em8A05dZJFv76+x1DDJarDWRYZi
	 eTzpoMZBE6L6GJvGsuwkul42005ckd4ieU8kcgMIzgf6CUc6ZXIJLibLh6P0dhuXI2
	 QhGGUGM7eSjq/ucZPJfGZmwwT2TfyTQv1GTcQGoTm7Qh2zG7dUaFHCTknW/ISa896R
	 mzLka157H5tLaLS0/YPHKAUsXWGEAh6bRj6XC/jn23eDObvHgIG81zg2g7IwgCEh+v
	 Xfxjh0chl8Fhld0zY6BwgpwSmF3C92JNdGJ5/eeQf1lZUHPt6dPpGXzBKXV19+dYYC
	 9eI/IeMow8kGg==
Message-ID: <15556a7f-c9e4-4ada-9810-9bf64d67164a@kernel.org>
Date: Wed, 28 Oct 2026 08:37:20 -0600
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
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
Content-Language: en-US
To: Hangbin Liu <hangbin.liu@linux.dev>, Antoine Tenart <atenart@kernel.org>
Cc: Zhou Qiuyue <n0ps1edzz@gmail.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
 <at7uk8gXtzNufuQF@fedora> <at9sKRSEJLVGj9OK@kwain> <auAAmqXcxmC6BDrR@fedora>
 <auBs0Xn5yVJ1NtdK@kwain> <auFPlcB4VfQ76NYC@fedora>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <auFPlcB4VfQ76NYC@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 7:27 PM, Hangbin Liu wrote:
> On Tue, Oct 27, 2026 at 10:43:48AM +0100, Antoine Tenart wrote:
>> On Tue, Oct 27, 2026 at 09:38:34AM +0800, Hangbin Liu wrote:
>>> On Mon, Oct 26, 2026 at 04:07:40PM +0100, Antoine Tenart wrote:
>>>> On Mon, Oct 26, 2026 at 02:09:23PM +0800, Hangbin Liu wrote:
>>>>> On Mon, Oct 26, 2026 at 12:48:08PM +0800, Zhou Qiuyue wrote:
>>>>>> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
>>>>>> index b965258cf..bdea82543 100644
>>>>>> --- a/net/ipv6/raw.c
>>>>>> +++ b/net/ipv6/raw.c
>>>>>> @@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
>>>>>>  	if (unlikely(!skb))
>>>>>>  		return 0;
>>>>>>  
>>>>>> +	/* l3mdev_ip6_out() may have replaced the skb dst. */
>>>>>> +	rt = dst_rt6_info(skb_dst(skb));
>>>>>> +
>>>>>>  	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
>>>>>>  	 * in the error path. Since skb has been freed, the dst could
>>>>>>  	 * have been queued for deletion.
>>>>>
>>>>> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
>>>>
>>>> Doesn't this change the device seen by the nf hook / used for the stats?
>>>
>>> Should we still use the old/released rt->dst.dev after the VRF output
>>> path replace skb->dst? vrf_ip6_out_redirect() said it allows the nf hook
>>> use vrf device.
>>
>> Right, but then in the direct path the NF_INET_LOCAL_OUT hook would be
>> run twice with the same dev. Looking at other call sites for
>> l3mdev_ip6_out, it's not clear either,  __ip6_local_out reloads the dev
>> while ip6_xmit does not. I'm not sure what is the expected behavior.
> 
> Hmm, me neither. David might know.
> 

I do not recall the original behavior; that was many years ago.

