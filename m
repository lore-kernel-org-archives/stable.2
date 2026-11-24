Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551233;
	b=LpYPaEvwL2f3qoUGlH9VeuA4S1i4WJn24s4fzHnzCLoSJl95dYfmlbFJJ6mW22rayKL4
	 yhA9AwAJh9KRmUZbZMjB7Sdk8innJigm64OnuzDp0dkl82xphZ1/gCkZ7SMM83jnGI/SU
	 4/uvJqxL3Hmv/WSDzghQdFKt3bZzOjA0XCP25j6+uR/+4+P/i0W1E+RBoUc34lUYWBSfV
	 PBRXtu4jFolr2ZvE0fhIAMve3+pKG8NmfwE9Mzj5418xZSXpYGi8MqApLXPyWKnIpz748
	 Ng6TErXEFBoopl+yOhsN+8DWzA03xkYkoAd5nPrStIIXndueu94kRY3MvmDuU/jF1Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551233;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=TIxa6RhBv/qEcy+umQSc3w7OHrCV0S/F1qqnnQZxpQc=;
	b=oHgQ8Q6P0zAGVHG4uaGEhEOPjPLBbxqHgey+Fec53EzwU3whKYghUvWAY54yqxKhKOKT
	 08DY+47p3qW3FoQ+ajsv13ML4X9UKNVmmhxZqUOvw2tYakRjIIZk3Vdsr0GjtvySZ6Kiz
	 addQlbMTdfBAgJUJeRaV8uCcP83Vb+rHmafTBeUU+oIOSvlQ/nozE4NArYUZiCZAdn6fd
	 OCHLuX6V9XAJmJRSoMDOTawUgkyUA9kAgd8sTXObMB7/NX+mTexQoaZeFdz/6L/T1UmxE
	 zyYFNJ/mzxufyVF2TzPqIVL6UxcsQ1Z+DYrfSHSO5Afcu7/LZCBuuYsRptOvu5wGC9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=V4U0ayHB;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A52606A681
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A52606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=V4U0ayHB
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so2818322a91.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551232; x=1796156032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TIxa6RhBv/qEcy+umQSc3w7OHrCV0S/F1qqnnQZxpQc=;
        b=Ko60Wbyvxlopz0joNOcVK4gDIjrJFCRgikzmGNHY/4FEdUbSGAPBx29iTU17Fo+0OC
         5+pk4//lNC6nCLiYqJYXkdSAAiuVIu8yge0Qw9BAZmICsqlTDdx0f8c4NVPaFOYdJ1z5
         F7yFSqCF9QhvcxHr1w5YtREFGJU8zpon/7L6uOSTSuygKYkxwrjQAzdgl2b/YoEhTyZ4
         s53tD1BsazBNyKgF5o0j8y/nX/dOQ41vCwk5k4/n9rSgw8dnx3sBCpMmWt3FGVrAgQQy
         971iQVJ/OSZOursMeFvIpeeYvc6Xgkl741+tPM61g8ASUGTL+m4Sl+/Jzau5m/44FHsg
         4j+w==
X-Forwarded-Encrypted: i=1; AL+hErHqzYFyQZeFFfORj3LAvWWwppC4ZOqOb2Hxq45TPO4UsGPoT73KfSAQkmov1vaZA6sXxPg7XNs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZucZh6n80JmO5MVy9W77nUEyqKaq/VoJ7pv6U5wbDLDNu1c01
	q1LyvTdKoiyJQcFNkR1Qp/pgmKzNdxa/1UKHPX4KWISQzQS52mxAnJepsQdFQBwbn86M4B7Es4U
	mopZU7YtVaU0Qlv9nKOLO7UqMFr/uAQ/NTn4IX2JgFqJ2yW8gpxSV8WNqNwy+poKt+yyv3YjstZ
	vmrS9eBzr4AHooTrDAXgqZR9Euea1ONd50rbPdg9rM8GBAMeNekLslUO67eXK82/lqGtkn14Fqu
	GFMe3/hSZMUY7U=
X-Gm-Gg: AZFdTZd8x4AoschjXv2Bi9nQRaQGPcsipYhOElYB+a9K1uKS+tEfGcyNUDB1U0kGVdw
	GML6OXIZPrhUr7T5UayhGty4bXzAbO4aodkGXW/kMwYAO2yifuhw44/kuZa5xuZcy9wU+fqULFs
	d98ijklLQwdigFbnSEjRDdojOtSmm9C+BikYLARhuw2sJI08Zvrytc/3/SsFHnaaUMx6S/R1X7Z
	ZAoZn2SAK/9PbI1mD5bWKBRKT1JF6E9aogn4k5QMnjLP1QiN4/mndDhfNH3Lu9d4qxt3PxHGJ31
	wffagQ9s2GtIVmpVKhDeABUj+/z7/0ZUsPPH+lN6ZE9sH+nUQK/psFHsflr6Adw0a2O1mcBmgpE
	Em2s19s8hfq3GZIgNBRGFNKu7Eu/xWzfihx5JQSaRAgZjSfQ2n5iWfbXygmvMXs6mYMWhDX3DAm
	QEbF5aBD8QPGCI8sb2qms1dBD5UupFXTg+yLT2bSLMhQ==
X-Received: by 2002:a17:90b:2cce:b0:3b0:a7b5:c046 with SMTP id 98e67ed59e1d1-3b41c9759cbmr15371938a91.54.1795551231536;
        Tue, 24 Nov 2026 12:13:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41ae532fesm11557283a91.7.2026.11.24.12.13.51
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:13:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99063f4065eso1338548241.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795551230; x=1796156030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIxa6RhBv/qEcy+umQSc3w7OHrCV0S/F1qqnnQZxpQc=;
        b=V4U0ayHBYJdc62E0XX7iYYnLYjvvF4v4PFODp6nL11OP8KBRyQM0x+nVPwUH0Ygb32
         HyX+ggzf7x8MxHP0vNJyS0vfTrGDeblTLCQStMrONVfADWSDfgVO0zCQ/8/TgXme+pmy
         Dc9gBx9kD6lxn+MmNbjJJUx/as1gPJD7dzneo=
X-Forwarded-Encrypted: i=1; AL+hErGkwubfRNVJqSZs5UA28+sVeNYHSkxtNhBU7Zpv7TyLbheeA4zuJMRmcYub236CeiMK4VVydGw=@vger.kernel.org
X-Received: by 2002:a05:6102:580a:b0:7cb:288a:b68b with SMTP id ada2fe7eead31-7d74432e4a1mr7935570137.37.1795551230438;
        Tue, 24 Nov 2026 12:13:50 -0800 (PST)
X-Received: by 2002:a05:6102:580a:b0:7cb:288a:b68b with SMTP id ada2fe7eead31-7d74432e4a1mr7935544137.37.1795551229967;
        Tue, 24 Nov 2026 12:13:49 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b6bsm140905426d6.1.2026.11.24.12.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:13:49 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless 2/2] wifi: brcmfmac: fwsignal: bound the MACDESC_ADD interface index
Date: Tue, 24 Nov 2026 21:13:44 +0100
Message-ID: <20261124201344.3494326-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261115185843.64633-3-maoyixie.tju@gmail.com>
References: <20261115185843.64633-3-maoyixie.tju@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, 16 Nov 2026 02:58:43 +0800, Maoyi Xie <maoyixie.tju@gmail.com> wrote:
> brcmf_fws_macdesc_indicate() stores the interface index of a
> MACDESC_ADD signal without a check. brcmf_fws_macdesc_closed() later
> uses it as an index.
>
> 	if_entry = &fws->desc.iface[entry->interface_id];
>
> A device that reports an index of BRCMF_MAX_IFS or more makes this read
> past iface[]. On USB this parser runs with the default module
> parameters. Reject such a signal as
> brcmf_fws_interface_state_indicate() does, and count it as a failed
> update.
>
> This was found with a static analysis tool that we develop. A userspace
> harness that compiles the fwsignal.c functions unchanged shows the
> out-of-bounds index under UBSAN before this patch, but not after it. No
> hardware was available for testing.
>
> Fixes: b75c1a301b7d ("brcmfmac: destination mac closed when interface is closed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
