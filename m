Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6514EB865
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676312; cv=none; b=nlICgQVTl0LGPzkqDknuIIgLpCxI/ilTiX8iuSX42jyCmRErnzHRrH6JCDi7x/WctnUsoHUkmJYbtDhLrLN7msMmIdy3AIlaVLB2bae/obiPbXiPFd7pQcuAThXu95t8S0fn1wf+FkPQsXm4sVeQqRgKMPVmn8kHISVVKuL0dH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676312; c=relaxed/simple;
	bh=TAo26pzkar7YGCe1cBaX7hpJ0vPhFwl5BfTx0crjaZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9ofiAR1DHGVK1uTniDHeIIXzf63ufFnG9drRbXUTigvEf1T7vjNyEPctx69pRCSeMCmhQ9WxY80AYblwRtGUJJ3ssOsxFthAhsVt7axCo7Au2s3uw6AynoyepfaXyopVimpWXmqozKqDGoA4R8ewNpYV7AIL1YyZsaUF3qVufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=B7IVbRCL; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="B7IVbRCL"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B18E33F97F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1789676304;
	bh=y4uJ7C5IvSiTxvav/hktZP2sZh5a4TBnbTehEPbMgP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=B7IVbRCLfTt/BVIPraCok0PWiUFCfZBnmtyX2ph1WJqe6l7sPLDCeyhIispx1zOHB
	 rDxQPykfcAImrLXW2yZzIWnyvWkDuxEWW5PKFaJ3SvRlbmgnme4+dYzJEbtjHNlzGh
	 M6lPIHv/bTl5dVDQx50a1RHEsvR+T2+0mZpudNfetTnD08AW/O6qpLLqAbp/lxnH0F
	 8h5luiQaq1IKPCUnJcOB6PqWL+H03bpv8yI5CMlGMg7hTWCb3IOAs7aJ6ThptzWveP
	 Xhcnj00BCYwrvxf03nmJwZji4+pQdRq+Ie+TatLwlNc5fzxnQ6oAfAEketGJcBzJIB
	 GGBc3CdIJaucLb9ovV8sgh0ET632S2/JKX61oUFuZvssGOXdbAtcUjmnVAzh4zc6Uk
	 UAfomzA8x46Zdth+ulwi2nr3kxFR9eulBuOXGRVSPnHMsb1ZvGHYzbIi+chBq7J8Lj
	 +hcti6XckYDa5v/SNYNgjpakg5txgvjpk2/YlEoEH326aDnLTp8Uw+DM7NJd+dDbio
	 XsnBAKH/Clnsk+hACzTFMHmCsW4A6lxlMEQrtNLzkBIc6iN3vTLB6BjGXhfI+ASAKA
	 8JKxL0B+NWwXLwxPZt4bT6bdQ0G2f3a8QJSJOCKeButVWksDEy7R7AVQ9OE+PmdsUb
	 nn9S3Olx42WGQI67fqzwaft0=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso1191987a91.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789676303; x=1790281103;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y4uJ7C5IvSiTxvav/hktZP2sZh5a4TBnbTehEPbMgP8=;
        b=HpymPf0ezOWaFnpO7sPlcXpfPaIBSocKDUd3/i+IELDRiMz/z58V7JdjFMKZJcj4QD
         1kiBpxYjvrKcEF9sAeLwFHYDjKrm0IEpVkOJfYPkc/1fndAqwdLePOsTP9WbhuFY1o0c
         5KxnPKdLoPGs66cjvHaX8vH+XlEvvVZyoyo/9hQI2HNobFJezUXlbLuBk3hTzqttVkZU
         JqZ5YIZcvjIuUDS7bAfIPMfronK8jz+YH2DA3ipExKqR2FdsrBxcah+gA/FDcMYaVPFY
         O4vF8z8yI1TpwipU5j5EYQYJsops7lAF90jWE3GKqLRJyXjwfnyMKdlLi4E1pTK3F6cf
         5J2Q==
X-Forwarded-Encrypted: i=1; AKwUvBz2fOmi/pitsgRxkx4KLI/YbvRLHYVmRV6jjnmci9pC/9sWileQh/oKWn8xyr/H7DWoWVT/Fzw=@vger.kernel.org
X-Gm-Message-State: AFuF++nCI8pG73Zhs8CcKNC9GvQUJ6DX/bzUYzeFbCAZcswx0RzlELFQ
	X/BYAGn49cS9ptCbrxQ6z6Q6XYYAbDD7yOCEJVPZylca5lJrNJOIlqUc9IPaATi60BrEhSfoDSU
	KqbakbeFTiTwtKVCDoZja27PQNtRKElQtritwMi/FvJpFc2doMK/CmOJumisy4GmUyWPksNkoGQ
	==
X-Gm-Gg: AYBFou2ZEdq/DwfsnWeP2n/DPujw3o87ls7Ye1EoIiEhVRbhTgCGcY4+77SB8xr7QKf
	v5V/ehCWv+TCr7i8NSIQPvRTf02m21v2O1PYjXPYWu6jWJYGg7cpXKT/RKIS+f8Lg5jg+xx4T9k
	p3ualkJG30V0dC/d7c6FVxPBMWVl90oVdLqbJg8wLzFEZKl55knQPDhv3gznovylvkMhSyoS6EN
	U4LdTT1wNGERX7PCWPrMG0xTNTfd31blzQxupmh1uvmZt+3DF6qIMTN3G1KlIOzb5E+xoMUP/eL
	XWUsMyH3aMC8fJmx8VAJoM+TkHK6Pxyzo9BVpAY7uEY3r9wqqUt+fVW8q9xAUAMZouwIs6buHIM
	ZlauxY70j3Spw0CM=
X-Received: by 2002:a17:90b:3b8d:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39e554cb74emr213508a91.6.1789676302810;
        Thu, 17 Sep 2026 13:18:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8d:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39e554cb74emr213487a91.6.1789676302426;
        Thu, 17 Sep 2026 13:18:22 -0700 (PDT)
Received: from [192.168.192.72] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39e362e9402sm6714597a91.15.2026.09.17.13.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 13:18:21 -0700 (PDT)
Message-ID: <760b1f31-32f6-44c6-8a5b-991f228a327f@canonical.com>
Date: Thu, 17 Sep 2026 13:18:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Fix label reference leak in aa_unix_file_perm()
To: Ryan Lee <ryan.lee@canonical.com>, Wentao Liang <vulab@iscas.ac.cn>
Cc: apparmor@lists.ubuntu.com, jmorris@namei.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, serge@hallyn.com, stable@vger.kernel.org
References: <20260917164136.2162858-1-vulab@iscas.ac.cn>
 <CAKCV-6uui82r4U3+ab=2ZFQvGQYnxfhYMHJNzLim-HEw6pRp7A@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAKCV-6uui82r4U3+ab=2ZFQvGQYnxfhYMHJNzLim-HEw6pRp7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/17/26 12:19, Ryan Lee wrote:
> On Thu, Sep 17, 2026 at 11:59 AM Wentao Liang <vulab@iscas.ac.cn> wrote:
>>
>> The inner block in aa_unix_file_perm() re-declares plabel, shadowing the
>> outer variable that is released at the out label. The reference taken by
>> aa_get_label_rcu() is thus lost when the block exits, and aa_put_label()
>> at out is a no-op on the still NULL outer plabel, leaking one label per
>> permission check on a non-filesystem unix socket.
>>
>> Drop the shadowing declaration so the outer plabel is used and released.
>>
>> Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correctly updated.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>   security/apparmor/af_unix.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
>> index fdb4a9f212c3..ecb40cfe7e14 100644
>> --- a/security/apparmor/af_unix.c
>> +++ b/security/apparmor/af_unix.c
>> @@ -758,7 +758,6 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
>>                             unix_fs_perm(op, request, subj_cred, label,
>>                                          is_unix_fs(peer_sk) ? &peer_path : NULL));
>>          } else if (!is_sk_fs) {
>> -               struct aa_label *plabel;
>>                  struct aa_sk_ctx *pctx = aa_sock(peer_sk);
>>
>>                  rcu_read_lock();
>> --
>> 2.34.1
>>
>>
> 
> NACK: this exact patch has been proposed before, and unfortunately
> exposes an additional latent bug around plabel handling that results
> in a use-after-free if the shadowed declaration is removed without
> additional fixes.
> 
> I can try to dig out the relevant exchange from the AppArmor mailing
> list later, if you'd be interested.
> 
The series Ryan is referring to is in Linus's tree, so you should see the
fix rolling out to stable kernels as well soon.

6d25e7b47616c apparmor: fix refcount leak when updating the sk_ctx
b1aea2c196077 apparmor: fix race in unix socket mediation when peer_path is used
4483efe4f2151 apparmor: fix shadowing of plabel that prevents cache from being updated

> Ryan

