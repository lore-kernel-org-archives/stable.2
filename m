Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389003;
	b=4Bu5Mj56881NbMrvIDUhrnOGJJICLRH7c9tTXcSmmEeHZqPHbPEYqEb/KWdVgrgpSNbS
	 K7Sl8mDq4v6AqM/3DcS7PhTUYQ40iu+njllZuy27lM1XokgFbHeHgZ1AkrRqW8AutWTDE
	 /E2EEZpVEpPCVtdStt3dlMarohrhtXpHwcSGWy3w6t6WNvHsTGCD70zoz1ERsqOEztu/Q
	 6lndS44HYZqeC7F51Ss+zyTebeWRXD52luDVygZKTxbj3gVmEkL+OXsKDybG3YnWb4XNz
	 LXwFLO7/aSx+O7Et3a/Gs6r/djUH2pybT44UDKpL0NuLsVXYsxsJmoCPHp7L61kVzXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AVaau5y8hwo+5sTMNM/it+5IuZGWaaPTl9DZXOLv2/0=;
	b=KVVnh3p8pEyDUvX3mSCSDut4hkrma+bduJyrZ3QMzgRPHsmAoL5+s/4IrgpKsc5/MVox
	 GWN6QJp6Lwzcty+bUYPQ7ayEEMOsKdgU0P4nwh/zaOxhwUk7ibvlSL/MQ++bT9/mt8aMO
	 iYzYw0BmyEnb4e9bT9KugZ75NNNR6X3ZUQT+xob9Ch0iIfptOKOSa1xJw5GNpR1xCS1SC
	 WfmjxvMXpP/+U3LZHQTsaDS7mdio9OJv8dkrDT2gf8v9VdeZZlhGRuR10pJTshMkc8Xrt
	 R01mVsuow5ipJGgi2MdskCe8Z7zt7KbPzoRsRrg7/Ixs01B83rDN29fWBqexwad/2PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ODxpJ1bH;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29315606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29315606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ODxpJ1bH
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9d52f684fso10977875ad.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793389002; x=1793993802; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVaau5y8hwo+5sTMNM/it+5IuZGWaaPTl9DZXOLv2/0=;
        b=ODxpJ1bHMzzUwe5Lx+VKgMzYWIxYluNtfud6pQLLq8DH6sEfdgAm/CqcVSIJb2SBGe
         pLWYr1ssNy9i445gE6+cEssKgYQZY6H7yxItGsz8NXjcrgTB59OeklgrAuKE4jZHKtHF
         g2nsrIqsS33XTW8DcL9hFwtr1kFbtG4DObJ5d1LCFnSFndyDgYJAHn1HCdw+u2dUtiCu
         ccaG0nEDXpC8BpNxRcXp2w3yb984ghIRC2OpmRnxpj+vaB+OeB4/yx0rdhpfSw+csdyy
         3E/JnRRM18tSubKRxhe2S0GXSe2apZqgwMiyTbtpd6Ki1PY/sJiqy4vn6as1YRSzK2q4
         1ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389002; x=1793993802;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVaau5y8hwo+5sTMNM/it+5IuZGWaaPTl9DZXOLv2/0=;
        b=g+OifQK8MNEhiLiy7NkmUOQ40DeT9E5cNJ/0/zUIaQv4KJkUw4t28FhILx8rAEconr
         /AmNpWDv2sDda2Ekd6gpgpBaA7bzEvn/bKRsNsw5xUJiew5sqIHLvaK3xeXweigRZUMV
         pNpzUXBmfwIKEjgWkdvX/x5jUqq49Vn8GsibMnGvcsKQvq3UUyHT2MkXmtKV9iIhU4n8
         FZsmYNnoy/ButF66HCuCmTw6hA6BUyNX/wjaCcIQ21pd3/2/m/q73S7RCbpL57F7Cv3F
         gZPLmzVTjq7tv3B+5aX4xqTOtWgW/r7okt0O1nNa1zJvVj4NASRCEIAi4X4TLROGtjUJ
         nKXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdwln+RasyaDkomQBO19j7GbEdpCSArYOXbOZB/ZfgKBtQ6TInHHA1faK+wHrz1Hy9hSkdKQo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHATuCd+G8/fKOZ1P+wb6sZfPIAwl6JkTPvXnL4KevvST8rvTb
	VSwwcX/m6Iajd/OSiFn7gorpXI/OJkq2g/o9LIa0c84IjDbao3+aBcu91jw8+IgXdnJJwIZlSZ7
	F0BPjXTUduQ==
X-Received: from plcy11.prod.google.com ([2002:a17:903:10b:b0:2e5:6ae7:d701])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ffcf:b0:2e9:a782:bb82
 with SMTP id d9443c01a7336-2eb364e93afmr30322805ad.54.1793389002473; Fri, 30
 Oct 2026 12:36:42 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:36:37 +0000
In-Reply-To: <tencent_6FF2EBE4EF5FF4F324C8DC4AD0F39588E505@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <tencent_6FF2EBE4EF5FF4F324C8DC4AD0F39588E505@qq.com>
X-Mailer: b4 0.17-dev
Message-ID: <179338899796.2590875.15337207674245295434.b4-review@b4>
Subject: Re: [PATCH] usb: gadget: configfs: NUL-terminate extended property data
From: Neill Kapron <nkapron@google.com>
To: Yingjie Wang <1075151112@qq.com>
Cc: linux-usb@vger.kernel.org, Neill Kapron <nkapron@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bingquan Chen <patzilla007@gmail.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

> Unicode extended properties account for a UTF-16 terminator in
> ext_prop->data_len.  The configfs store path currently allocates only the
> input bytes, so ext_prop_data_show() copies one byte past the allocation.
> 
> Use kmemdup_nul() for the configfs data so the source byte implied by the
> terminator-inclusive length is present for both the configfs readback and
> the descriptor conversion.
> 
> Fixes: 7419485f197c ("usb: gadget: configfs: OS Extended Properties descriptors support")
> 
> Reported-by: Bingquan Chen <patzilla007@gmail.com>
> Link: https://lore.kernel.org/all/20260421141010.5607-1-patzilla007@gmail.com/
> Cc: stable@vger.kernel.org
> 
> Tested: x86-64 KASAN configfs readback through a built-in RNDIS function
> instance.  The baseline reports a slab-out-of-bounds read in
> ext_prop_data_show(); the patched kernel reads back the expected 0x41 0x00
> bytes with no KASAN report.
> 
> Signed-off-by: Yingjie Wang <1075151112@qq.com>
> ---
>  drivers/usb/gadget/configfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 51df6d1d1487..c302e8dd25a7 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -1351,7 +1351,7 @@ static ssize_t ext_prop_data_store(struct config_item *item,
>  
>  	if (page[len - 1] == '\n' || page[len - 1] == '\0')
>  		--len;
> -	new_data = kmemdup(page, len, GFP_KERNEL);
> +	new_data = kmemdup_nul(page, len, GFP_KERNEL);

While this fixes one case, won't it cause ext_prop_data() show to report
a larger size with the trailing NUL?

The OOM still exists when switching types in ext_prop_type_store().

Can we add a couple of small helpers to convert between the raw payload
length and the wire length and use them in ext_prop_data_store/show,
and ext_prop_type_store to standardize and sanitize the length?

-- 
Neill Kapron <nkapron@google.com>
