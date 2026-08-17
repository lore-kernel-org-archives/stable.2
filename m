Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90E3A9879
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992587; cv=none; b=RDjPW1kz6G2m8nwS+dfV1t2K5/D6NwLBK0pMq0ukgoxHaGgpLvntwkDgWQGs+/CuLU63am+FC7QzKuWbxr9m2OeTIS2a0SeVBmobpTlYDDV4jAnZ/yO0F/cMxnn8LBZg/qkQ2gt8BZ16joWbNKxmdNjqnXQQlG2j6ZhoAZnE2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992587; c=relaxed/simple;
	bh=rApM6GX98lsJOC5CYCvGiZv8S47Vhqm1pWqmqbaHGa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEt8ppCLIO1TKRlVGJoVahj5IBfo3QwdTDYuXPooFXLdJOE/IlaEBgncZgdsPb2e1uf9hzQVwoLpSkPUdgWU7IzlA1ZPFMLqnvBIbeRK5nv08ZUZzxGw5rsN+TvG0ZzU9WSHzM0aOywo+46GnV0iodffZU5HJ683skEVM5ojJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-481512c85ffso1511249f8f.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786992583; x=1787597383;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S9H7C63C2s25VG5aW8sc9bKlnFa7ZjO/sL0My+WrHq4=;
        b=Ik4Q3z8gDHtQQfcmTiIb5UqkZS1PNdK4dW351WWTL/QrTfPzuZYbQbBIyYNp/c0Ani
         c1nuUTs3F/Bha273u2ixAzSX/UKo2UjknkWT5lYRQL7S5BRGwoCbUm0/2HsNWkjRlWEL
         O21WcHRGoUJVUT7Td7KwUCghNWXwSBV/raC8IcblQO+lK5T5MB5GRDpmp8hdjHY+H2El
         JI+1mc7NjD0TVnDp2M1y10WPLVvXJfgGt+vj2M2msKKoQQxAlD3xHKwI3U0gXxozMgmB
         3lqo1ukX/IkdgXCQMZn++p4w3/abl07hntNr4oGr7sHeouW3lGfy3PhZ2IM7QO6n/0lG
         KwMg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0xiS9xnBRSdJmDcO4VAOUHDuZRnXCRzJr9dzAJk3Wt8fTVnGVKTQDCd87U6CDYw4vSNUbj3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh3mENCHIVd+xHAnaFM+eYMW85e88HOH5spzoy3hBiwL2kPdOO
	8iX0sXuSk3tst4mD0KMCLfYJs7ethgHUk0cUO+1zyr/wYaHIga7ZjSJc
X-Gm-Gg: AR+sD111TLS10NI686zGCtgBbylp5yHTEJABdyq6Qm3IcSJmMNyOFsBzEZPY74DZOW7
	u6IeQKGLnagOdsYi1K00ae6h3Kzf9ebnRMPFQoiArfgG3NG6tlOn+dy8keL5NcZO5eimE6N1QNh
	rTiuqIq+qvYeiaqW+XZAgAJedS5H2AnNga9Jr+nMHZyvRBpKYu1ldF/wdJl+D/uHlbvxWjh7h3r
	MUzVZWIqUPMvsOr2ZKrNmULJIbPigHyJExzgLRhSjT41E+JRYeghhg0KTLe1XJBIHH0rUPZJhfS
	Ke0j1iGcto1jnJGTSdHZ34irDDfhh5a1BibW7+v8tm3MhnIYMybx5yPf8jOvl3AiUctY4NMXlRu
	VxtB+sbf0rMeqP/SQ+WBvwE58CqpUEEVhoHC10Hn2U4OMdwQVmQCmAHtLDX6HjS4iU/yyTHC9Rh
	I8NOCBTDOpQaQqGxyW0mpIK0O9uQ4ITt+KlorS/wYN29Boqi3/W6nZeusUsUEjvyfrwoIpJ0Hs3
	J78lJL6BYklqoXK
X-Received: by 2002:a5d:5e90:0:b0:47f:8183:e9b8 with SMTP id ffacd0b85a97d-481607656b7mr41963476f8f.22.1786992582645;
        Mon, 17 Aug 2026 11:49:42 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c5e7sm5803419f8f.24.2026.08.17.11.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 11:49:42 -0700 (PDT)
Message-ID: <8823f2b3-3516-4fad-bc9c-c6dbad9653ed@ovn.org>
Date: Mon, 17 Aug 2026 20:49:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: openvswitch: fix nf_connlabels leak in
 ovs_ct_init
To: Ruoyu Wang <ruoyuw560@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yi-Hung Wei <yihung.wei@gmail.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260815151729.3757984-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260815151729.3757984-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/26 5:17 PM, Ruoyu Wang wrote:
> ovs_ct_init() acquires a connlabels reference before initializing the
> conntrack limit state. If ovs_ct_limit_init() fails, its error is returned
> directly. The pernet core does not invoke the exit callback for the
> operation whose initialization failed, so ovs_ct_exit() cannot drop the
> reference.
> 
> This leaves labels_used elevated when Open vSwitch pernet registration
> fails for an existing network namespace. Subsequent conntrack entries in
> that namespace may allocate label extensions even though Open vSwitch
> failed to register.
> 
> Drop the connlabels reference before returning a conntrack limit
> initialization error. ovs_ct_limit_init() already releases its partial
> state, and the original error remains unchanged.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Cc: stable@vger.kernel.org
> Assisted-by: unnamed:gpt-5.5 typestate
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> 
> ---
> Changes in v2:
> - Initialize err unconditionally and use one return path.
> - Add the stable Cc and Assisted-by tag.
> 
> v1: https://lore.kernel.org/r/20260814134040.1386967-1-ruoyuw560@gmail.com/
> ---
>  net/openvswitch/conntrack.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

Note:
"contest" reports a conflict with the other fix, presumably:
  https://lore.kernel.org/r/6cb36cfa28844b05919ca7c45c6c2bc812d3dc2e.1786936669.git.xuyuqiabc@gmail.com
However, there is no real conflict, patches do not touch the same functions.
'git am -3' applies them just fine.

> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 95697d4e16e64e..38c6f34776c280 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -2001,6 +2001,7 @@ int ovs_ct_init(struct net *net)
>  {
>  	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>  	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
> +	int err = 0;
>  
>  	if (nf_connlabels_get(net, n_bits - 1)) {
>  		ovs_net->xt_label = false;
> @@ -2010,10 +2011,11 @@ int ovs_ct_init(struct net *net)
>  	}
>  
>  #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> -	return ovs_ct_limit_init(net, ovs_net);
> -#else
> -	return 0;
> +	err = ovs_ct_limit_init(net, ovs_net);
> +	if (err && ovs_net->xt_label)
> +		nf_connlabels_put(net);
>  #endif
> +	return err;
>  }
>  
>  void ovs_ct_exit(struct net *net)

