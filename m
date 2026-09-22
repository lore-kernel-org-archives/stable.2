Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11C55D87C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091809; cv=none; b=W6azQcnq2fM6NQddRoVpx2LtGL0/9LUlV29A17+DMbXfZbnhWwUlu3ws1uR7xEPTfJwp+9Zr/xHNKAxlO6yvSDs6XNHm1qN2dZ3PUi7Smq8w3XzfAZoHN6I2rIyyKuaGKXLOz8WU8KSMWGNW3l4/RIHB3TpWFmQPaF0QwXpxBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091809; c=relaxed/simple;
	bh=GRqgTHPRWnG9IwMRRfG26N3mDu61p8pYCpytvjGSY1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9lq6D1a/rHzGsGNrv1FvzFfckPeGxJEs7LZaEiRbKjVzomJKxfiNrWWrgmf4aYpvwBR3uShaP9qhPNpwnyz/OKBAzUWh8hGJWYTzSI687VnOLQFHgF7LWy5IxzrEzGvPbzhILIpfcPtRrTZxHykh2A+uZmRMxdejnmSq47fhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so28679f8f.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091801; x=1790696601;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhvTPOuk38OAJeKZ6IPjN37kqjVi+x1d9H+4Ju5mOtw=;
        b=j6g+UYugwNoW9ENMEgJn1a/2Vh/6h7oLhtI51OQsV6HQrGALkwlynQ2I3p+ZXbSlfH
         ErXm/9GT5ui1+8zi4sWBteV/LEYGBQyXZ5HW1t8KiBd5OrTns+S1fninwbklTbcAjIsD
         eOxKvCvHSJ0VAhuMnUi656E+JUiCukltykN/05MheKMz8eboYYRZF0f4L5o0EVvqHg6t
         cZhifa953dOgahDfJwkuOx7rK0/4PnqSECFUrWtIQlmVdNaUvPuzmshPCkdSYR56QQx1
         IVeA6bIlvybC+f+UtNshwIH3S/pA4pyGvVBEys8bXHuI5sBoSMCx4L1cq+UZGV4ICGDX
         wALw==
X-Forwarded-Encrypted: i=1; AKwUvBzxKJcChAKbcOUFSJ6K/SCvdoHRPTroyj0Q56hHVq6cOYKgxKDn6v0nw194KNtYHj5F3LF8VIs=@vger.kernel.org
X-Gm-Message-State: AFuF++mk5bPJ5g+AADwinBfIMdQBbzO6UAKnr++4cMHQJ9nZtverx5lK
	YmR64RDUIR8EErnC66xUTQuVhKr9YSaqIENmzEAvohB473cN4Jno+cVK
X-Gm-Gg: AYBFou2Psj9L7mdU2hmXtZbUprR9y6pYMpzmeGuUIzac3GaLbrUTAanzWQKRJENhSMv
	X9d8zyqaEkVTYgtV3r5ZGMQMMxrp1XhABR7pilz+CqVmsREyDqv9GBowbnMMsnx2N46gX17gkiY
	GJ39hBftE9DxnPtlkDxbST48nbOZ9HyZxAGF5GUhb8RQ1BdgRgAZ0TE5cTO9+m6aKGipQxxZT27
	NWLtAW5du2p8iUfhunzQQ1HJpsEwW5VwcX6wtPsd48uzKqSYBKjdrg+jynVw07CLP0yo6wVD5Ia
	fMAriDTi7Cd/A9ArT8vnaLekdq6nhVG/BxRYUXxM7Im8MDodlZr6GMRWUEIMrYNoXrztPMOkRYi
	3634MsQBS+4m4PrrYlV89wtYNVJdtgLSzIeoyhvAh5Q4DGOtogqATH2MyVDbXSRP7rYTBeViqMB
	qOSON1sYEcF19GPl4ToMcroEdcrwUSGCAg2ue2XXymcKhXh81ISzmL1oRJhiHWBJet/Uq2w3adp
	8Eju6a20I+EmYMLaUfbwb4ZGratZWHrFJUH0OEZfRtGlFY=
X-Received: by 2002:a05:6000:2004:b0:487:242a:c020 with SMTP id ffacd0b85a97d-4886704a921mr11085f8f.6.1790091800734;
        Tue, 22 Sep 2026 08:43:20 -0700 (PDT)
Received: from [192.168.88.241] (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862773ee0sm5831124f8f.6.2026.09.22.08.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:43:20 -0700 (PDT)
Message-ID: <51f0cbae-71e3-4b9f-af91-55a610eb15d0@ovn.org>
Date: Tue, 22 Sep 2026 17:43:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] net: openvswitch: conntrack: fix helper UAF due
 to extensions realloc
To: netdev-bot+sashiko@kernel.org, i.maximets@ovn.org
Cc: netdev@vger.kernel.org, pablo@netfilter.org, fw@strlen.de, phil@nwl.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, aconole@redhat.com,
 echaudro@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 lucien.xin@gmail.com, marcelo.leitner@gmail.com,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org, stable@vger.kernel.org
References: <20260921145655.3167436-4-i.maximets@ovn.org>
 <179008911935.2160803.14933035266780079917@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <179008911935.2160803.14933035266780079917@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/26 4:58 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] Inaccurate newly added comment in __ovs_ct_lookup()
>   (net/openvswitch/conntrack.c:820-826).

Same thing as for the previous patch.  Comments do not need to
spell out everything that happens in the code.  The intention of
the comment and the code seems clear enough to me.  So, I'd keep
it as-is, unless someone thinks it needs more clarification.

> 
> Pre-existing issues:
> - [Low] Concern (INVALIDATED by later patch in the same series): the
>   identical helper/expectation use-after-free was claimed to remain…

Preexisting and fixed later in the set.

Best regards, Ilya Maximets.
