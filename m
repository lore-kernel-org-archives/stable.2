Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878138;
	b=rGbvg4cqOOGFBzJ8ukCiP1XJLdSFb4xG3wMQea95dt2MsnEoIevX0JRrwfLSIv+y5O+P
	 eRrI6+qKSn+SlSqlbZqNmA7gZWqyX29fvziGAhXzhA84hz6IvZpOt+e8Cu10I2kDfPii3
	 MWHrXWkgZyeRgBOG9gIck9yV1NP0WBZJtO8nCV8ZmR047XS/y9nvTEafJ+yY8/LiwXtlH
	 CSKAL5krQLQa1aWoupxEyU2x3FIamc0Gpnx3mlp+IgjlXkd6QkiB1MyKSGBpx2DxuE5+8
	 Ln890KdYYoNVWz7hbjvRQqqeGrhBBMqcoP0mCDYVH7BIPIL4TBQAlpQOXz2npETl8WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KYuAf/nYjeBNHG1mG8AOx1BUbgAUnA1j6gAMCPYxxlM=;
	b=HsZXSHq43Wtz7UY7A5+iuWI+H2982aBFtystnkKCL3Hs6WweE4EJT7OEB1r6N+jna0Gg
	 rIzx8M8bqZ3FTcZ2xqu0SUdxDKEZ9cmZmj7AY5jognKHJr9DSWA1xg7lbt+XhYmOJNOW7
	 M9F0zSjHOOmk/Ii7bIS6mQ1BdVNfLRtWBUEg94tVJndlEWhJcCmfaZv0R15cDs1khuMXr
	 bug/59p/UkT0JCb4IJpvUbk2te+uQP0Dr0QqtNlKDhcem12ChDvLxhBwATh7/pxmW3ity
	 fl1OkFKoqBhBLbZPO2wJoMbYhuXk1DU9Zr1ir74iDlwUR3+2siyC+WHTQWlchLxFSiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="gqx8gRD/";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E4606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 11:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C8E4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gqx8gRD/
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so9581245e9.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 03:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878137; x=1794482937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYuAf/nYjeBNHG1mG8AOx1BUbgAUnA1j6gAMCPYxxlM=;
        b=gqx8gRD/xAb7RuPGcePdw5i58wmVjCmdROs5keeVRsQ+e2FiKoCw2xe2wLD6r0eLTr
         KHS62rHjipUJbgzcUJm0UJJFNQH84tknqVP1NKhf4RrRFF0DXKC495rhGra20vqL+SdZ
         LPTESJdsXY1i33d532BzUnFcBlAmWFrNnRDtv2wQRyNyyZNqQZugtCwz5tbgS2jC+Qaj
         e3JFtJuxOUhYudTFkFTRmFe7anxpOOIsHbtyG91/iDvDN20qSNsgdH2698O0wM0D1HpP
         7o8G2JvBXOIrHelgOM/7oTsIOraf5Ocdxxsv8+jwMP45cwBaHf0ao90s4qrt04njJ+8W
         JV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878137; x=1794482937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYuAf/nYjeBNHG1mG8AOx1BUbgAUnA1j6gAMCPYxxlM=;
        b=BkKMl/A8gSb9ZLekZjhZm5JXnW3cXDxj+1js1bBs9Bc85oKBpkUcx5PpRBZozxUgW6
         uLZY03P5H1LfYbRWi15bSCYw92mlZvZCvHkj16QrzOTVD8hdoCu1IOZqvcgGYZWXdZzV
         hGMd5/nkBUNsMONDN3xYUkC0m+eLJEAYXIpc4iFJ4nxrxkzf+WD7eWBuJNVzZz2x6VDL
         XvGzvC/lQ0e+xOz6dM2PlNenLPDSNKVd6J/Gu+ABpH1FsKvNbaCB7R8hV6A5nBpib3np
         FGwk0liDT0vVXtFvZxzZDvCY6h3LhUU/f9Rkd7/HdbGYpnr2y21hCp60XcntJS0eVT7a
         ltIw==
X-Forwarded-Encrypted: i=1; AKwUvBwX+p0RDEKjFyYWiL9ApfO/1eKZ4J5K25Gp/WhWW+uEDKvpcKCoWdbxWOP8Pqd6HbNUSq49G9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z3hfSYzkUEqQHVz+KMi3PAOMGxITIym8ZTdjdDgZ6waawULad
	ecsoKY8uHnfq3O4y4P4LkElZPqbonIq09Qm4o/PYVjFzjKBnTdz1k3TV
X-Gm-Gg: AYBFou1N6UtDusix/OwMTSG+T8c3AUzoMtt/RJYkbgReswksEx5/S2hPoXLWoS7V+aB
	Q/Hq7l2Ir/j9wXIsnGbshTq5omkrAGJLsFmPWyuLG2xGAT1R9mfJSRqaINy8BjehR1VaYNcaqOi
	/gblCdjTqvBRzIuCZ2LozZngIonHVfvkoH8otY1DUv02Q2WyqkyP6HQdQSdkqIhUmPE0AJqpki9
	TPSL7BjfFkNr7wqVT/8ckM7+mpZyEBjT14UpMnFpIa4UX2zKOaV073AUDd6WvACz2JqP9nkGWmK
	I/2bRqVND+ZpUXouzdgNFJQ1ZnUxZef4g/F7vHQrT6lKznF25pTyZhpcghfXIWMpGv5zTPxjl+B
	S40w84+CU12MRoUZp0H05JsOAmuSEnug2HubiwjDZyKdVJC801q8U1P4FbP2jaihuSOAWNJSx+9
	hBE/B/2rSTZIoTBwI6GPMUgqn1xY1h9s1dhxGqHrNv2SobL/Rc6rbaZ7LJPQ9+6tApT11Z4KYT0
	vkpKtI1rI6xjte5GNuNJaT3RmH1+U3TPoQGMndXrUkeOvMGFnF6JLI7H1fJjWMugiPIEKmq81Bh
	TxGIYYQ0v5qow1KXelmmKw4=
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4ac17d168b1mr461927035e9.11.1793878136849;
        Thu, 05 Nov 2026 03:28:56 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae72dsm102176495e9.3.2026.11.05.03.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 03:28:56 -0800 (PST)
Message-ID: <4f63ce1d-4e74-4fed-aa97-e00cd30781a5@gmail.com>
Date: Thu, 5 Nov 2026 12:28:55 +0100
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
Subject: Re: [PATCH v2 3/4] mm: hugetlb: fix GFP mask propagation to CMA
To: Qi Zheng <qi.zheng@linux.dev>, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org, akpm@linux-foundation.org, lance.yang@linux.dev
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <ac2de9b321f68c1025333e92e3ce94beadcb0b6c.1793850539.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <ac2de9b321f68c1025333e92e3ce94beadcb0b6c.1793850539.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 5:07 AM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
> during the first MPOL_PREFERRED_MANY allocation attempt even though
> the caller clears __GFP_DIRECT_RECLAIM.
> 
> Pass the caller's GFP mask through the helper so CMA respects its
> reclaim constraints when trying the preferred nodes.
> 
> Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
