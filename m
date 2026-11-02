Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793591121;
	b=NqJ3LBseJMGqhJI838ZUeUxFD/6oE2UCPupNIz8rHPS4Lr53to3vDGFVv2G5hX4ovGaa
	 8TbBk7p+fj9xcROIFtVkaZId5C1LVNAd6AD20dZY6mDfFDHkoY0oXyvyJMumoqm3oEP9k
	 lL0veEWatlaaiUwv8KaUC9ELhG6bBD8nLi0vsZNUwTcS68sICCSi7g+SC6QSq+K1xKqRG
	 FWSWi0+sdo/FnD8dwLGnJZnG8vOeznLIqfY7v8KOwoWZDIpFArsi/4K8WAiOXe4YgeilJ
	 feGiojKNSqXxUGefG+iGXWaF0nIEUPRkn54oVnP3Ectl0gePb4+Nu0dj5QYl7ODIxVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=thK/GTnCI6aU4GgyCtkZc/ZGtFI5CEa1YKDFDXhlzew=;
	b=G97nfw56GXTiZCJHUOwlDv3wfjn4CbJuAOhla87fxhtyClOqk07E+F+FXn/wIsOaNzde
	 OOkn/ehxyKPuqQuzSAwW5lEdzJitISPxpETtQVXGs/rb0KeR3v+WyiIzLnHJzpNpMeLye
	 UxCQ5NIetWsQum+9f2Ljds6n99dr7hSUXlIryvPwgCE6dYvkuejhNyElnBk3Zq+VhnwSg
	 J7lp8f53wQLQ4470YQSl5sNyHpRGUMEKW46dWWou/JfIjzFBvFr+xdsfhK3OiBumQmhxP
	 CruJjtr9UI7/6Y3vZ2XzwQjPWc2Awe9WzjTl5U4lqVl92g0fUY3XSkYEoh54uIuMG/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVFjeZZS;
	arc=none smtp.remote-ip=74.125.231.128
Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3A606A334
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 03:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07D3A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVFjeZZS
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-84e8a9fae57so1388644a34.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 19:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793591120; x=1794195920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thK/GTnCI6aU4GgyCtkZc/ZGtFI5CEa1YKDFDXhlzew=;
        b=BVFjeZZSYXqx7Gs3BH3l+OE6VwNuHJ0YhCrxJdjSUlj8DcMarADLR8MP9CtIuyIzH7
         y9hszyzulP98siDw46ft1EZNA0bq4oZa5vTGo6p76D30qf4CCTiloc+1kJnj4QL2EF0j
         LdAE2xvy3v3ucp7WMqisviL8qW6qiOyPGBDCzxHOSfPoDbWZXIxnPmG+6x9ZNIKnLisJ
         QCovW6OAzXrG9PTbsHnBUmhD6GQqAmUarvPmPCXJuyZms8fFFLkRm3YalKuATXAZ3mAX
         nj2GF0xHsytE7hriAqtHZenbORvrF9rXOTXDWkc+vdfH0BS9na0TElO4OI54ID7C0b5Y
         bZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793591120; x=1794195920;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thK/GTnCI6aU4GgyCtkZc/ZGtFI5CEa1YKDFDXhlzew=;
        b=NZWPY5X0zy3ZnwaeIViiRrZZNvA46iZDf7UcaI7BqbswG2yHSnISIZlxObsfLzrOTD
         r891Doa73/FuYfqEEvOyQ+Ff50Cs+dpDtPLZkJayc62IR66Ydivo1sQqrqkHi3eMjF5J
         vnvl/sUMTRsfcSg0iKTeyxv1vPkN1whVKxlFk+weuTodstBSqZOwrjbiECM7i3jJnR2k
         ABfiPbp4X97THROyaIn5dAUYM9oOYtV5JqiBElmXx4+Jt4QqDmEQFJsBU+OsVJjhupiP
         cHiDfA1d6Yds9fieWvXN0VC1wvvTwZuXEAmrKCrc2uS+jLycsJ5hz9AcYLed2EYkVtn3
         TvEQ==
X-Forwarded-Encrypted: i=1; AKwUvByVs5R2eZKvOQw00fezPE5y+lFkteMOT9HY2AO0ykq1kOAj+XnVlI6zGofiYxUGxq118JyCaWw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiywMQcm8Mn2otfO7QeG2m5dQWgnOyc49iJyhfLieDhEwkFkFU
	isNr3BzowGyzAWEzGzZ4n/ofk1HQ726SQkPCj9OLEN9N2fLUOfv3Z25u
X-Gm-Gg: AYBFou1gyy+/SKj9VPLsUB8QWM+DRv6yCJuAKvZs6uzpLlahntpTcwrrzxzyNj/fPfm
	41xnMc+ZHhML8FOKZspndW7MzqGv8XqCAhxGhiXTx+aeKtK/AiDUlVAyCf/yf9ufVMqfhy4I7tp
	VToEV6rGqQQ3+RbxD9k+XSHqKVS61edDBd7osdVz9supr4hJNA4KYZdK8+9aHcKBdtklMaNcbfG
	PaZWUAQm5Klie52ejMm2K7r78l/0dAByJJj12yKwqr4K10P2wrv7s5saU3vBytu7XcxLlZjVuLF
	JoFbDiqk+uzMJFTV/s89nUcj3wvnQxuYslQAP7FNNHSO099TtQH3QRwe9yRh6JJpRh4qooC6sL1
	woVK3kyKvgSspugdaP/0+hXXfIOgeJottfJPLwcjiur1JnUQHLdw9duBuQI4cqvo2Gr22Efm6Ma
	zZaneY1JKsP9YL0iwRacIa3cZClyURSuLwuOxN2RBYYUAVHe7nv7eCoJXe95TTamMXKY/96T/gd
	usro9XZbG5kqN2u8AkTEfNcbN3F3au3dGa5N/A2HOGrmtl9OXFJfF5Ru8rEpiqPrBr2iWy8o4Nx
	+AhAEFrdGPbKrARe8/xR3+TAmVGlqnJ7zTJloC/K9cvJ
X-Received: by 2002:a05:6830:4116:b0:81a:9522:f007 with SMTP id 46e09a7af769-85d3649508amr6210396a34.5.1793591119902;
        Sun, 01 Nov 2026 19:45:19 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::f01a? ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354d2059sm8172551a34.18.2026.11.01.19.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 19:45:18 -0800 (PST)
Message-ID: <b0c42b21-6b28-49fd-ac07-7af1456de4b9@gmail.com>
Date: Sun, 1 Nov 2026 21:45:16 -0600
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
Subject: Re: [PATCH RESEND] usb: mtu3: don't run gadget completion callbacks
 with interrupts disabled
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260929-usb-mtu3-gadget-completion-callback-fix-v1-1-8b75b48fab96@gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260929-usb-mtu3-gadget-completion-callback-fix-v1-1-8b75b48fab96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

Gentle ping on this one too. Similarly has had no comments since the 
resend on the 29th of September.

It fixes the softirq WARN in the commit message, which any gadget 
function that reaches netif_rx() (u_ether in this case) hits on mtu3.

Thanks,
Ryan Brue
