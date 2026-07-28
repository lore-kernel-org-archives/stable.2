Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA674477EF
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247220; cv=none; b=Feozl8o9i2EugcJZ342plq0Xs3keLy8H3o+Yf/J0sFHuoEjclDiT62ro0CB0azEWd5OrHW7WQOVL5M14hYczNLNjNGUIzcR0J+nVvTpkyOK8dFLSE9Dkl/nmAkQZrOZx4LZfwmzpSDZG/noomDUKrkoPk4tcTIG1g6ibQJ4xLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247220; c=relaxed/simple;
	bh=MCaU380UPE7nQtq09uXRpZ0GQ9Q6ljKGhpe97Uor4Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujylh+ehswsObf+C6UwQHsSeSvPMti0zXg5A6LSeI6ZyQCkb3tiEiTmZPsoReOxCS6vjg0d+laYL4J9LDgixoVxsylr8IR7CJclRTIK7blUux3lBKTOlIvHfHMZPiXvZuECjUkb7ELAMo6oBAd7aApTdLrFZ5fIxJv/ooXnakJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so1967561f8f.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 07:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247217; x=1785852017;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HD3DupRm0WkCzpl7UkTaAYfO5WC3MKQSDvdPYI0GL7s=;
        b=My0iQGVnwHSIjm3zJarCiMZYcx1ylWeVEVlhnIIAAghYW//LVHPEJL/HOZJyDxgjd9
         rAKEQpAAw8aVqfxEBXMYFJ2ZItvbrpnv8CalAxbv6qp+DldF22pCHUiCFOxeZ9fxRMTG
         Y6m7APX7Mg2+3pgBl0521tldw/LTqH4RwkuwD/Ezn4TIzeXygZ0htEEBzoVf0RPZj8Vr
         AfgoVhz3VbhdU35DB05/PvqwKaFMpiIK/L2rZibC3+7iXg70PJRJcYbQfO6lVM+uqg+Z
         oFN69IpmsHW+4zibjpUSh/0vIZn7Rl3Hdy+muISr8UIBlBL1eWeElK2SLw5rG3SSpQ4a
         DfZw==
X-Forwarded-Encrypted: i=1; AHgh+RpEGZsV/f211vkN1p4mqqFy7LiFUbsGjA0OQdWmLFflmzLvcNKU6O1Za+iwmAKuPqWStgskTYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQfFUokIQrxQofyheDuXjlFm/HjfSqWugGpgZ+dfwrBMvyhmT
	0hSWfcZLYw/w6gGi2YblUCXgqx3D+aRzbJ1YiFT8HWcfQWbwVvH3gnr4
X-Gm-Gg: AR+sD11TVe4mULvJHybKwCzq4/Wx+g0rD7w2vxRYJa5t0CAEg76BUsLXoOSKDu0cL1v
	Humx7uZL1KfAFL3zaABNDvXgcd0VtoG02HEqYOGvpgqgiGRY+H5lE0JAWgv9qXNmKApJ3Jnr0C6
	zVOuBUiPq6qNq0S1K0iDb9SZVILVX7fVruHvDNPeZ9qLXXPyBxOMNVz/u15nWV1IhjsuAtMnhkY
	x7EAt26XTnMOv2Up1soXnBYgYF6zOXMKKk31gR0DsxZHo/64aepj7zfUoVgOYtJVs60lbuUK5gp
	Sk7kldGyF9RPt0OKt8kyvxJiSTzxLxxnEu405r1oFDyq7GcbaxaBBv5tlpuGle9R0XRLID5/OqA
	a1ljEVI+76Z1xLTvPGGhTVb6f/kjlMfvQdy28X7wTEAp6H5R8mnb+0Er0SVFOroJnx5Vs//xvEj
	N9zv3e3UwYAf0aZKfJgUaSQGgnLeu85guaSK7LfJFGAndjOqYkXA==
X-Received: by 2002:a05:6000:5c2:b0:47f:9760:4d2e with SMTP id ffacd0b85a97d-47fb1edfdf1mr3152644f8f.24.1785247216503;
        Tue, 28 Jul 2026 07:00:16 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5d9sm56682015f8f.5.2026.07.28.07.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 07:00:15 -0700 (PDT)
Message-ID: <fe4ea840-d140-45c9-85c6-eb23e04c6a7e@ovn.org>
Date: Tue, 28 Jul 2026 16:00:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: openvswitch: fix potential UAF on meter attach
 failure
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Tonghao Zhang <xiangxia.m.yue@gmail.com>,
 Ilya Maximets <i.maximets@ovn.org>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260727121022.198461-1-i.maximets@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260727121022.198461-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 2:10 PM, Ilya Maximets wrote:
> While attaching a newly created meter attach_meter() function makes
> the new meter visible to other CPUs but can still fail afterwards.
> On failure, it detaches the meter back and returns an error.
> 
> However, this is an unexpected behavior for the ovs_meter_cmd_set()
> that uses a plain kfree(meter) on attach failure without waiting for
> RCU readers to stop using it, assuming it was never visible.
> 
> This is never a problem for ovs-vswitchd as it always creates meters
> before creating any flows that use them.  But the UAF can be triggered
> with a custom application using uAPI:
> 
>  BUG: KASAN: slab-use-after-free in ovs_meter_execute (net/openvswitch/meter.c:653)
>  Read of size 8 at addr ffff88810d152650 by task meter/2508
> 
>  Call Trace:
>   ovs_meter_execute (net/openvswitch/meter.c:653)
>   do_execute_actions (net/openvswitch/actions.c:1407)
>   ovs_execute_actions (net/openvswitch/actions.c:1584)
>   ovs_packet_cmd_execute (net/openvswitch/datapath.c:703)
>   ...
>   netlink_sendmsg (af_netlink.c:1900)
> 
>  Allocated by task 2519:
>   __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
>   ovs_meter_cmd_set (net/openvswitch/meter.c:422)
>   ...
>   netlink_sendmsg (af_netlink.c:1900)
> 
>  Freed by task 2519:
>   kfree (mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
>   ovs_meter_cmd_set (net/openvswitch/meter.c:479)
>   ...
>   netlink_sendmsg (af_netlink.c:1900)
> 
> Fix that by making sure attach_meter() doesn't make the meter visible
> until all the checks are done and the function can't fail anymore.
> 
> This also makes sure the "hash" value is calculated after the potential
> re-sizing of the table.
> 
> Reported by Trend Micro's Zero Day Initiative as ZDI-CAN-31642.
> 
> Fixes: c7c4c44c9a95 ("net: openvswitch: expand the meters supported number")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Just addressing some sashiko comments below.  They are either insignificant
or for other pre-existing issues:

>  net/openvswitch/meter.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
> index a02c47277337..4aaeeae3af5b 100644
> --- a/net/openvswitch/meter.c
> +++ b/net/openvswitch/meter.c
> @@ -133,18 +133,10 @@ static void dp_meter_instance_remove(struct dp_meter_instance *ti,
>  
>  static int attach_meter(struct dp_meter_table *tbl, struct dp_meter *meter)
>  {
> -	struct dp_meter_instance *ti = rcu_dereference_ovsl(tbl->ti);
> -	u32 hash = meter_hash(ti, meter->id);
> +	struct dp_meter_instance *ti;
> +	u32 hash;
>  	int err;
>  
> -	/* In generally, slots selected should be empty, because
> -	 * OvS uses id-pool to fetch a available id.
> -	 */
> -	if (unlikely(rcu_dereference_ovsl(ti->dp_meters[hash])))
> -		return -EBUSY;
> -
> -	dp_meter_instance_insert(ti, meter);
> -
>  	/* That function is thread-safe. */
>  	tbl->count++;

Sashiko complains about the comment, but it is fine.  It is pointing out
that it's safe to increment the count, which is still the case.

>  	if (tbl->count >= tbl->max_meters_allowed) {
> @@ -152,16 +144,29 @@ static int attach_meter(struct dp_meter_table *tbl, struct dp_meter *meter)
>  		goto attach_err;
>  	}
>  
> -	if (tbl->count >= ti->n_meters &&
> -	    dp_meter_instance_realloc(tbl, ti->n_meters * 2)) {
> -		err = -ENOMEM;
> +	ti = rcu_dereference_ovsl(tbl->ti);
> +	if (tbl->count >= ti->n_meters) {
> +		err = dp_meter_instance_realloc(tbl, ti->n_meters * 2);

Both sashiko instances point out that realloc doesn't reshash the entries,
which is a known behavior of the meter table.  It expects meters to be added
sequentially and not with the random ids, as that is how ovs-vswitchd
operates.  This is not a good assumption to have and the table should be
replaced by a real hash table, but it is a separate work item.

> +		if (err)
> +			goto attach_err;
> +
> +		ti = rcu_dereference_ovsl(tbl->ti);
> +	}
> +
> +	hash = meter_hash(ti, meter->id);
> +
> +	/* In general, selected slots should be empty, because
> +	 * OvS uses id-pool to fetch available ids.
> +	 */
> +	if (unlikely(rcu_dereference_ovsl(ti->dp_meters[hash]))) {
> +		err = -EBUSY;
>  		goto attach_err;
>  	}
>  
> +	dp_meter_instance_insert(ti, meter);

It also complains that the caller relies on the fact that attach_meter()
doesn't make the pointer visible.  However, IMO, this is the expected
behavior from this function and doesn't require extra comments.  The
opposite behavior would warrant a comment.

>  	return 0;
>  
>  attach_err:
> -	dp_meter_instance_remove(ti, meter);
>  	tbl->count--;
>  	return err;
>  }

