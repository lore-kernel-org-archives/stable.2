Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766328;
	b=2UADlIFjI21hWlPuoDlJg2ee7FVh4eXGnNfhUVEY4oOblgYAnGAFBnN3OuuBQmD4UCLY
	 mzcv4/n3EViw++zBfVbrpbm8MXa76ldHAtM6NQEFUMvkGb1bKvluKajPKMWzL4sPH9ZGu
	 zxq4NSsSbx80Xi7tsTQ+cA+f6UM6VfO91jJHW++2zWp5EhYbjFXoFs95j2Jrz959cyBvl
	 IkEc+O1GkyLTrYmvxexqCfmJEbtLGlpscGTspHqcIPReX8TNYhS0in8RSp5Q3a2TEcHD3
	 ra4bKhc8S/o1Y1Nz5CA9LWdTkYSN8WJ+/hE0EDLWDH65n4mC47NDFC6oHr0D+fazcog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:X-Mailer:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type;
	bh=8kBP06/wOlnERuCqJs+Y5bm/y6KqBpdjzMi3s4CcFqM=;
	b=XTci35r1riv1PEmEQIsiup1e5yJLdZ8NXH1IfGAh/uCrJS2Wb7ec+G27rl2st2duz/zW
	 SZ+cZJbaXueQu+r0gUYwUg+MqG+GNIFuxoYRSI9LTV115CEOqbFl0awjJlzJgqwhDp6V5
	 Gxg+NjXAz0GOA0WffZbscmMNmH38PIE3Z3wBXRWuZtQeDtPtyGM6EKsKfidwQZjBQqUJI
	 mmv3Gk603vkDi4quasKyskdVKwdGmpi3i3UzJiMJISNRIN4wNdd0ezKxMtVc7GUcypSIZ
	 Hcv1NwaOiR8yx30+MzdIBkPDPVNe/0D0lQbaoGZf57uEIUe9Um1iy0ZbMTR6ttFq/6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=LgrTemra;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA676606A333
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA676606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=LgrTemra
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-843cf077f10so942469a34.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1792766314; x=1793371114; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kBP06/wOlnERuCqJs+Y5bm/y6KqBpdjzMi3s4CcFqM=;
        b=LgrTemra783sa+ZxdZU6VF2t1/CBhSZTakPoKDDnqRhwM+Cyo5l7vdQZOd2ULAzkin
         Qi6WxoWZkZKyM6NmxjfLu3v9wIbidpPs9EREXZXorPg3G6SlheMzuZJNxRDpjDlKWgUn
         Mzc0DSyDc94g3QeXFqUAhnrb/DCHy5OZmF2VZdswK3CCEKr2rufeKmt5xCVMWW34yDkQ
         QXORijeTC9K4Et44lXGEfhb6ewHNblhu9XjYTizos1yVYjgK727XB3EpnDPy0dpqQfaK
         6ghokHtT7xF2O4hM0ZgXPOwocxAdmBv3XbxyVFiSONwbOZM4opGFAK5icV5UAetdOaXp
         GjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792766314; x=1793371114;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8kBP06/wOlnERuCqJs+Y5bm/y6KqBpdjzMi3s4CcFqM=;
        b=dvQTyGEBR2xyvH7dU9HM54rqcWTasHnLF/gxe+nTRrbF4P9mStcmphlqbNytkwyBP/
         NCTIjzYBs+vpi/z7ojqlq7MFA/hvYdt5aaxtIWLM8vZm1NT8QGGMbwrc82AwgTzdvoPs
         RoXFcWWXRHrxvGrQWe+UQ4z1e/OXK8yiVqCQakSmr+G2m5F60xPr0b/RUde1G4Fy+CA6
         ETsTRyufQeREuu9PB4x+FqFas1DP8XV9gjxXKiGR1/tueN5WpqC7kHYVxy/rEV8cmBL+
         5T3yWFckeX1t6AVl0JszzP2PGb66B6MTLS0AlqG5zfkTZEHO/SK42UN58C4edRyxzQbU
         InZg==
X-Forwarded-Encrypted: i=1; AKwUvBwM1pJnG2cjTvZOVCdz/OYRPytGsVLOR7Jq/2BWJrEdec8hKzwx6OuD/GLaUFIShKqcUNllhHk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsYAJE0ULmaDHeJXE2CcpB1RbnV2Sl3L8yJmCoVIAW1EvflQ7M
	tMeNnOcvAN/cii0TQ1TsyMMkHrwchZaxliMHA182S7VVVKMl8M0bbGezWiQ4ZuX20/rX7apYWrm
	x4Y/T
X-Gm-Gg: AYBFou3qxifEOH4Y9/ORfxlZ32119n7FF+QZceqU5ICrTrXSZmlzgiI7WXlDm7Ezl3Z
	agPJlgsWwDQ/a4B6iuNavzHCeY20qvdOS4rmnMQr303C77Cmmsc/l5iL5QtwHQcCziEcOFu1Cdk
	QwwHjMuGwHlAqoCwQOgDN7yYB+r5rHEwd93LZcIJNKyySLonEF2J4gPfR4pl5qqO2khqUKX8gXd
	y1iAbDV0FmP1l8Pu0iPaF1ZG4i7z5num4BdjWmYDn9w1XgNjoFHI+CNQFd0Yiix+kdsjgHxxwO7
	8/usR/EQwfQFy9VBLVCklHc3lSz4FejKj/osnQ92Dz5zGAZ6sEDs/8pPBse/8i5aeV0/7MayAM8
	QCPUqSG7RpEO7pgLWHVNH5mnntkg2LjSaOsfU6fmGKXcMRQbNy7yKgYvlfWl4XX9ptji3ForG2y
	8zRNHVH34rpoXYRQc9hkibE+1qQYyhzSW/FpDglU6vNo+X2aBHJdBYIfcBs2L6hUR247/15LZPM
	hq2foRAMpzbAzgE4YaW7LrPbNud4hIZpSuaT9JYwATv7CMOxKEhA9DQoYV6cdLXrCTDwwOd/g==
X-Received: by 2002:a05:6808:150b:b0:4f4:857c:98ae with SMTP id 5614622812f47-55be80c4668mr1554002b6e.11.1792766313526;
        Fri, 23 Oct 2026 07:38:33 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55be987bb39sm1555431b6e.11.2026.10.23.07.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:38:33 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: trondmy@kernel.org, anna@kernel.org, cel@kernel.org,
 linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix TCP-with-TLS transport class identification
Date: Fri, 23 Oct 2026 10:38:31 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <FCA6692A-E79E-46E4-8349-D4A77B818476@hammerspace.com>
In-Reply-To: <20261023084819.609293-1-thnkslprpt@gmail.com>
References: <20261023084819.609293-1-thnkslprpt@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On 23 Oct 2026, at 4:48, Avi Weiss wrote:

> xs_setup_tcp_tls() assigns the ordinary TCP transport class to
> a TCP-with-TLS transport. When rpc_clnt_add_xprt() is called
> with an unspecified transport type, it inherits the class
> identifier and can create an unencrypted TCP transport.
>
> Looks like a copy-paste error from the commit 3 years ago.
>
> NFSv4 trunk discovery uses an unspecified transport type when
> adding server-advertised addresses. If the additional transport
> passes server-identity validation, it can be admitted to the
> client's transport switch.
>
> An isolated loopback test reproduced plaintext application RPC
> transmission for TLS- and mTLS-configured clients, including
> an unpinned TLS-client RPC that selected the added transport.
>
> Assign the TCP-with-TLS class instead. With the fix, the
> plaintext-only test peer receives TLS negotiation probes but
> no application payloads.
>
> Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport class")
> Cc: stable@vger.kernel.org
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Hi Avi - does this also fix the problem where the sysfs "add_xprt" silently
failed to perform STARTTLS for the new xprt?  If so, this is significant fix
IMO, and worth mentioning for products that might use that interface.

Thanks for this.

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben
