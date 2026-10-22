Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672929;
	b=ZdWSLSSvz9mZWcs0fNyL14nGEswfuGuDtjTOYEfbPqXb31Dzu3YUihd6RvzLYMvfSGGE
	 41mZ0z0bcD5hivLBm6Tfsg+JcOWq4Df0AuVn3XLyBK4wXLr1ZPgZSPi0TmtAQn0mtsI7T
	 /XaWCvuBeGJ0gDvzg4+NvfFex1LKuk9P6/s7ZTDCpaYtB6c7Z9K6onGq5bHO4goCvSLSL
	 tZ6oohSTJusjBHnaUU5mbPdtX32L5r6CtTXLZc9fYTJNhBumkt2LEfmFu8q2i25IXQcOQ
	 5kvTird3KjXV45c8HLIzVXCXmvvrwBTy2BDXBHR5MEvPfIchxdOgCAbcKoebhv95VGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672929;
	h=DMARC-Filter:DKIM-Signature:X-Forward-Email-ID:
	 X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kUqgr6Ebn72/WlEz4GBlEk/lhIUVm9v26hY/9pAXckQ=;
	b=n24bImgO9/vKFtK00DoK4QQzPEyCaWpQz4EQnqnlzqo6seUwnNfQIObMXfPw6BiGWRg5
	 d1eTyzUdAcDhjFmzElxS2I7tga3UWwAFO9s4WdKoiZAolB7jrPfWlN71Q5CLe8cWtLlq5
	 TZ+2mBi3jkBqH+eJFdhv5Stqx2VV75SoLGYBXzbnoC/xF/SGERxRwYU6d7eKsE7VoimSi
	 17+4tLHgwhpqMVFpC5/4apUVBCzL/+jMm14zZbvw4z1ERqRj3bkPfhp2XMZZMQUKYk9AD
	 6pzTROwe9Bu+CElN2qoKnMe6m0rUy8vIy5LWu4vGZ7toNWJsaShkLnyIle7e0ws5sgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ovn.org;
	spf=pass smtp.mailfrom=fe-bounces.ovn.org;
	dkim=pass header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=V11bMTVB;
	arc=none smtp.remote-ip=149.28.215.223
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F8606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B84F8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=V11bMTVB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1792672922;
 bh=kUqgr6Ebn72/WlEz4GBlEk/lhIUVm9v26hY/9pAXckQ=;
 b=V11bMTVBkaqmLWtYjxrW7lLQQa4j1kxIuhNXsWAr+qLwO1u2h7FbN8pqB94E0uS9Jd3u9DRGG
 43/2A/2Z+o7Mt0n5Ax51kpRVXvu72L9dcdbPwk5AtjKIuvtcRQXfzRA7F9b7uXq+3KjHvpCKPvk
 kMQRkG5NixTlS1ELxLUL0z4=
X-Forward-Email-ID: 6ada04971a70b93336fa8f72
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.9
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <372c6019-2ee1-46ec-bf5f-ccbf9b4d8659@ovn.org>
Date: Thu, 22 Oct 2026 14:41:54 +0200
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
Subject: Re: [PATCH net 4/5] net: openvswitch: ensure a linear inner Ethernet
 header on TEB pop
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Martin Varghese
 <martin.varghese@nokia.com>, Jiri Pirko <jiri@resnulli.us>,
 Victor Nogueira <victor@mojatatu.com>, dev@openvswitch.org,
 stable@vger.kernel.org
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/26 11:22 AM, Jamal Hadi Salim wrote:
> The issue:
> pop_mpls() restores MAC_PROTO_ETHERNET when the popped ethertype is
> ETH_P_TEB, but skb_mpls_pop() only guarantees that the MPLS shim is in
> the linear area.  When the inner Ethernet header sits in a page
> fragment, the datapath now claims an Ethernet header it cannot access
> linearly.
> 
> Output to an OVS internal vport then calls eth_type_trans(), which
> pulls ETH_HLEN from an empty linear area and triggers the BUG in
> __skb_pull():
> 
>   kernel BUG at ./include/linux/skbuff.h:2830!
>   RIP: 0010:eth_type_trans+0x335/0x500
>   internal_dev_recv
>   ovs_vport_send
>   do_output
>   do_execute_actions
>   ovs_execute_actions
>   ovs_dp_process_packet
>   ovs_vport_receive
>   internal_dev_xmit
> 
> Conditions to recreate the bug:
> On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
> enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its local
> internal port up with MTU 9000.  Install a flow matching an Ethernet/MPLS
> packet with one bottom-of-stack label and actions pop_eth,
> pop_mpls(0x6558), output to the local port.  With CAP_NET_RAW, send a
> 4128-byte AF_PACKET/SOCK_RAW frame containing outer Ethernet, the MPLS
> label, inner Ethernet and 4096 payload bytes.  The two pops consume the
> linear headers and expose the inner Ethernet header in page fragments.
> 
> The Fix:
> Pull the inner Ethernet header into the linear area before restoring
> MAC_PROTO_ETHERNET.
> 
> Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
> Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/openvswitch/actions.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 27152bca8a8c..03b31e33e880 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -153,8 +153,11 @@ static int pop_mpls(struct sk_buff *skb, struct sw_flow_key *key,
>  	if (err)
>  		return err;
>  
> -	if (ethertype == htons(ETH_P_TEB))
> +	if (ethertype == htons(ETH_P_TEB)) {
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return -ENOMEM;
>  		key->mac_proto = MAC_PROTO_ETHERNET;
> +	}
>  
>  	invalidate_flow_key(key);
>  	return 0;

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
