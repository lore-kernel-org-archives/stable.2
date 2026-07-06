Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30540A92C
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343782; cv=none; b=FHoknneV+Qf+fSe2KkPM7YKCn2w8SK2O7UTlbzw8qvIdnJL1FTW7vKRlUeRiCAEVIzXxke1i3qlZl+e9mIt/Wd85PRkSoorxBFp9so7sfGhZoWzmPcALTRh/a5uCpSqfTAEOmvYYQlOXJZX6HiWA3qembZsw6IN6FHXhuKXAdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343782; c=relaxed/simple;
	bh=iZO7UJmoKqo2Js4YAEPS6GeuLtX5Yha65THfQuxwRLI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HBYRT4zn/3UD/RUwHaqxz0us5SQZtV+7J5yjJtJrISudI6nXZMmWKGC4sgx4YlvuUNTg2yW5GlP6mNGOZ084OdEU+MKSvQBZ3xjPdR3VdpgCPfsYTrKc08BSBxKljM9WUKVY/DYAUplSporzwo5dII8Xq+6xDl4zE7Jsy1RVf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4e7be03so2282975e9.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783343779; x=1783948579;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIiiqzXRF32WNsiZGRhA0NE/qXMc61zioEknUOFZclo=;
        b=nuLSG7jcmBUg9GCLqMsvNPGmjQSzPnN4rJmFQ2vKHc5ZBaz8X8+snTy9GrMtAsdYJm
         r/AMaZ9lXRmQsVC2VHPWLwXyBjlrjFS0pNlpF7qZMTWdbRECyltoY13hFa8M7k2QCB1K
         lc5JyC6znjbVo+eRRDqLpIkmMsYgLZeiGN+gdAA2hWsK33vCp/7CPcvTL0q9wMI8fMHQ
         oAhzns77+QRUoVZ68G707LOpVMjZ/VzZ4VUNueU98xUm0ssSMT+a75bVAU1/EJebbHH0
         Vfb9wYVgM5y3cFQExyz+NoadBC7yh5JD97ZjQxJ28/2krqa5jjOxNN0QbRyLb5WnbmHK
         p0SQ==
X-Forwarded-Encrypted: i=1; AHgh+RqT3KIQavfEpSo5b88DRVe4Iz70acFZsDV5PeSGDDaj5dQlQda2vdQmsmXTN8MBCEw2bLelOm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZEXe5rqs+JZ0TXAdZZuZA3I1WwKCGyaZ1fzwcKpM/+RmqXRC
	FSIJhDdkJF0S+FlzMh39kFdLFuQp4OfXTQNrlxCm3xTi2rLSK0lxZ9h4
X-Gm-Gg: AfdE7cl7WiSLSZuLDd9bs5Ba9yPm/LweNKqKnYO2VdQBke32gU6UBWXqdzyp9P8Vgrt
	WZYAeJEWDRfS32axkD7pF/nNL2ydTR0jDeo7/W/YvontHqEw/QWVlDPk0SUPuhsNg7k+nghS69z
	CmNVGG7iEdi8XTFk2EffbclGkjlT+MDRzFFvHKz5lpaXbIf+o0Z2pG9D6/nYfJeqN0CmYG6K723
	VsjPEylYcyT9kKss6aDNlHhIaa3BgMPzuKc9uThRFbh3FyaXqUIs8rIJ8DTMxMhwrhhr1p6jVGs
	Pd5qcCARX5wdTFp4+Mc37+fRI/AKHw8FMYBj9Mital5Jaz9yO+KIzttxlD945wdWANJjhOtmmE5
	Zqxkf/rKxUNOfKWLZY2sPOl+ILeRqwIAxdYUS8F0jPNscag75QXiPJiWaXqXpp3DfdFgjJ+Nxru
	FPfoaJcgJKK6j6LfZ1M8Noz8d/ywLrIys2w9inyfahSz77OK0lvA==
X-Received: by 2002:a7b:c38e:0:b0:492:6f6f:fa42 with SMTP id 5b1f17b1804b1-493df0a1b84mr3528435e9.37.1783343778676;
        Mon, 06 Jul 2026 06:16:18 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493d1b83e5dsm125477615e9.0.2026.07.06.06.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:16:18 -0700 (PDT)
Message-ID: <36bcf7e1-e590-4df4-a908-42e93435ee03@ovn.org>
Date: Mon, 6 Jul 2026 15:16:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, dev@openvswitch.org, aconole@redhat.com,
 echaudro@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: reject oversized nested action
 attrs
To: Asim Viladi Oglu Manizada <manizada@pm.me>, netdev@vger.kernel.org
References: <20260706094336.38639-1-manizada@pm.me>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260706094336.38639-1-manizada@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/26 11:44 AM, Asim Viladi Oglu Manizada wrote:
> Open vSwitch stores generated flow actions as nlattrs, whose nla_len
> field is u16. Commit a1e64addf3ff ("net: openvswitch: remove
> misbehaving actions length check") allowed the total sw_flow_actions
> stream to grow beyond 64 KiB, which is valid, but also removed the last
> guard preventing a generated nested action attribute from exceeding
> U16_MAX.
> 
> An oversized generated container can thus be closed with a truncated
> nla_len. A later dump or teardown then walks a structurally different
> stream than the one that was validated. In particular, an oversized
> nested CLONE/CT action may cause subsequent bytes in the generated
> stream to be interpreted as independent actions.
> 
> Keep the larger total-action-stream behavior, but make nested action
> close reject generated containers that do not fit in nla_len, and return
> the error through all callers. For recursive SAMPLE, CLONE, DEC_TTL, and
> CHECK_PKT_LEN builders, trim resource-owning action-list tails in reverse
> construction order before discarding failed wrappers, so resources copied
> into the rejected tails are released before the wrappers are removed.
> 
> Most failed outer wrappers are discarded by truncating actions_len after
> child resources have been released. CHECK_PKT_LEN also trims its parent
> after branch resources are gone. SET/TUNNEL close failures unwind their
> known tun_dst ownership directly, and SET_TO_MASKED has no external
> ownership and truncates on close failure.
> 
> Fixes: a1e64addf3ff ("net: openvswitch: remove misbehaving actions length check")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> ---
>  net/openvswitch/flow_netlink.c | 201 +++++++++++++++++++++++++--------
>  1 file changed, 157 insertions(+), 44 deletions(-)

Thanks!  As I said before, this is a bit of a lengthy fix, but it seems
to be the best way of dealing with this whole class of issues at once,
given the restrictions of the historical interface.

I see checkpatch complains about couple lines being over 80, but it's
hard to please it with such a long enum names, so it's fine.  The
'inline' thing is also pre-existing and unrelated to the change.

Let's see if LLMs will find anything (they didn't when I tried locally),
but the change LGTM.

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
