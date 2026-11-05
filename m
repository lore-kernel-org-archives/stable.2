Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865166;
	b=ltn55ONrT2GooNkNftqfjwPwcEGndrNYyCy3reaZTYy7CFM+9/Ysz/YkapsvzX36w2KH
	 rR7u8GoXeFnHT68JQ9sVbeLlNT0P/wH9fYKcfZMWzM4lcEkGkKJeJ6OpwCQMRFaU9K2Ju
	 A+oIz0NhEVH2OacG18nUPrWuzOTX2UbKRaittr0+tX1D+oyEdzA6qmaTV3anQ1S5kiP5u
	 q/9ORuBOkLRy+zYYYeazonWdezkKrw3gccGBIyEZfwh85vaYQI0iw4R2x9Y/Zj6S4lwK4
	 sZ0NkdR/9Z9kupMbwEYk26oGTxJhuQcikh+qNlY2lBRRPF5KPT51ggmrwUcHrg10V3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=unsN6AHVNkCocRJQkDsmHPRKXeUWrdzS8/flo7s7TFM=;
	b=jHRMTkEJQIS1vTNXzxO69vgzri/ihAmVZBdDcBSpNGAGwmRF3Mnu92RNtjiGTxfDDZVa
	 mG1kkvPDgfTNvSFb+zZJGF3y6/GuEijWW/aSBlFf4vT2wQm0JvZZsWbLu1OiCt/jGwyCf
	 t0GborbWBK3vMQ7/XSRFaqIUGqAXy5P/N6vhZ0u45rkeEiuHtaSwFPlpo3g+s3OWc8yn1
	 OnxvLNflGnPTqYQICacLo1A9X4txTSNjnxYb6wAH3Dp1mtja4yAieJWRuACp6ABUUwQ1m
	 luOmd2WAjDHLS4Di3RTz9QZ0e5LnMRKybDT2puIXW4ka7Y8n0b1xoH5aVUY1DrpXzcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gTYTL5WW;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC832606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC832606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gTYTL5WW
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dee593f18so1185469f8f.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 23:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793865164; x=1794469964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=unsN6AHVNkCocRJQkDsmHPRKXeUWrdzS8/flo7s7TFM=;
        b=gTYTL5WWYDxqb80o00A+Io7d6oUAzHxd1+A00C6XY8mnit39plO17qP/RrflebpSln
         xJoeT+4Zt/3aYy4vtNl0ptOE+QqUmgvSWjpIO/9+HLryekbeBoIMr0/2xO3hJ7bTmBUp
         CdwapW/909bXq2FYfecX0cA8VHiF8ftUMcevWmqTYhBeMbUF7dbTzLYSPWCiZDKsnnst
         BNNSkIP7AD60RWz5gX9wpnXEdyWMvauoP+tmX7t77tC7DXFtTKv1SAaIiGAtfOI57vlp
         zTU9AiTm/MYGeAzGX08iXfeeU3IMqnUjiqZut/T70pnzggmVlDyS9xAdwAISeNMlfoEd
         22fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793865164; x=1794469964;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=unsN6AHVNkCocRJQkDsmHPRKXeUWrdzS8/flo7s7TFM=;
        b=xq32tNqC4F9h6L7/uCCdpwEDpCuICmw7/QfsHEyk2RO5+t5sbUwGibIP0DA/SOpHcI
         6/b14VEtN/Gxtj05UkaPZk5h1rPKCp0NeeDmBWhMESF/SxKXL0ZjSAlRx1J6S/MsdV0s
         hm/Tywmf6X4cNG6VD740g3lasuLgwixT9UySvDk+C7gC6OTzvIfVjjndEHYPx/oyAC2c
         yo9SFpOsaRHx6prJLj0x+pjb5o/n9add2FCkbaQHs7+Q6vJYs6tEagwLq/Kv+C4KMP5E
         yeeJ7ldshrQ2+E3by0ikgvP+gmIFvTk2hsikDW84pxdW8JQzlhMzfvGE3NMW8qn9f54q
         Xa6A==
X-Forwarded-Encrypted: i=1; AKwUvByKDFPbvXEbOJbM8gizkSAHsf7lL3zlfN/8Tw58vnGMVhdSdOR8/v2Sewsx93KqbmHxUiG82l8=@vger.kernel.org
X-Gm-Message-State: APuU4Z89evZNrZEQLR70IAoiQF2/b468d91k0l2A7Dr4t7D3dhHaxZkM
	/3t8hXGn0Jd6pr2ABeCbYnFiRCZG/ntZGs6jzQChr3ORhjpcHIkUZJID
X-Gm-Gg: AYBFou2Q4nfnI7w02VoN15NKaUzxKPJdQMG0jWcn3+RbHXg1+1S2do9B7CMVzRqdEGE
	8JPj6EQH422aQYfagZEUgLi3AT9aUjo0SH6UcnjslFAssyuY45ppOgr2ks1rLbfc+jEh/gckjlB
	ZN7OBDovL04OzqHTMGZlbzY3mS/MP+0zngN8+7siwEqkAtwL5HEfP7gde/3oxLqvje4Nj8L85qP
	EZUrDaLJhxwJbHBg2h70bqsInDYmzMtH4U4tzUMupCc57Y6gPIh41KjfzLGjj3XN8su3AVOSzBT
	+CxhhbajJW3Mz5VhTkzbvTfkz4BtweEW9xHsbQP/9DFYm3rWXEzqTak8WkXLNY7GERDWN9RsJP0
	CBilEmBr+t+dWrsz8jmHB1esYk3v2FlfGpMwlgvC2nn0u3vtpjjhNxwTiRFxDpPC5BVWemmtUK/
	MxM5LNvmIC8qN8k5TU6V7VR2Q2lGpZ4ZW2PJahXgvtD9fhmwK4SrOQCJtgQkxJZlf6Yo9AZYJNf
	2tkbsM9wBx8RCO/jWIKR5TVRU3je5VmkZaDqZ6e6UocegycdX5PDVLOGz429TKGd9V+bPDbucy5
	jcQcOpYEMxTfLHhRuPjaIksldh3iuOOxkXbZOITpIC8UgEmIj8IJ3hxXFU9G
X-Received: by 2002:a05:6000:188b:b0:48e:3df8:74cb with SMTP id ffacd0b85a97d-48e6e2ba5dfmr41503809f8f.6.1793865164140;
        Wed, 04 Nov 2026 23:52:44 -0800 (PST)
Received: from foxbook (bfg124.neoplus.adsl.tpnet.pl. [83.28.44.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda20567sm8958338f8f.51.2026.11.04.23.52.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Nov 2026 23:52:43 -0800 (PST)
Date: Thu, 5 Nov 2026 08:52:38 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: YuanZhe Liu <25031212351@stu.xidian.edu.cn>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>, Cheng Wen
 <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v5] usb: xhci: Fix use-after-free race in
 xhci_stop_device()
Message-ID: <20261105085238.337cb70c.michal.pecio@gmail.com>
In-Reply-To: <d7448504-a63e-4f3a-a828-7656b1084105@rowland.harvard.edu>
References: <20261104000031.679944e7.michal.pecio@gmail.com>
	<20261104035637.3325-1-25031212351@stu.xidian.edu.cn>
	<b8ea2f8f-ff9e-4cc6-853b-114fe51173e6@rowland.harvard.edu>
	<20261104175949.71804650.michal.pecio@gmail.com>
	<d7448504-a63e-4f3a-a828-7656b1084105@rowland.harvard.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Nov 2026 23:54:39 -0500, Alan Stern wrote:
> > What I find more disturbing is the existing protection from this
> > race added by 88716a93766b - it looks like core was triggering this
> > too.  
> 
> I don't know anything about it.  That commit only touches xhci-hub.c, 
> not usbcore.

Well, it looked like core was calling hcd->bus_suspend() before
disconnection has completed.

But I just found that xhci-hcd had a bug where hcd->free_dev() would
return before disconnection has fully completed, which can obviously
trick core into doing the above. Now fixed by 7faac1953ed1.

> There should never be any outstanding URBs on suspended ports.  If
> you have any examples, they need to be fixed.

There was a report of some HID driver leaving a pending URB on ep0.
Core blocks and flushes other endpoints, but ep0 is still needed by
device driver's suspend() call IIRC, so it only gets flushed after
the port is put in suspend. I wrote a patch which reliably triggers
ep0 unlink on a suspended port in this manner.

Reporter's HC wasn't expecting this and failed to perform the unlink.

> The core relies on drivers to unlink outstanding URBs and not submit
> any new ones after they have been told that their devices are going
> into suspend.

That's a little weak. The reporter got an LLM to patch the offending
driver, the LLM claimed that other similar drivers have similar bugs,
business as usual. IDK if they have been fixed.

Also, core ignores suspend() routines returning errors during system
sleep transitions. I'm not sure if drivers are *allowed* to return
-EBUSY in those cases, like they do to prevent autosuspend, but it's
at least another opportunity for bugs in drivers to cause issues.

> I suppose we could check that there are no errant URBs still in
> progress just before putting the port into suspend, but is this
> really necessary?

It's already being done, looks like those drivers aren't *actually*
trusted very much. But there is the ep0 loophole.

Regards,
Michal
