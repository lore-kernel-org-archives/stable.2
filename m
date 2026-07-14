Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB322737E3
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030876; cv=none; b=FgRO4ndv3lZMAIGI8HdPgH+nsb0JPAZMlmTrfhicZhp+/UHrtJZHhpWRirSsUOb1fl6VD9fYp7ecTnItBLLV9OeiDAKBycfamw6Y9vr34x92zIdRnMUMni4l0mWLU/86rxUdfq/87zbfnn0x3KD0Pc93CCsQjGoHfJxMq/VcGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030876; c=relaxed/simple;
	bh=OMgrFuAHO48rjnve0IC7BkW6T1cWgVV5IqCaIa4ACps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3eV4D3jgz43f+dJVjUjxvAtu2JJStfOLy7pWfyW+rTTKkw9pQJ88YsgywDpS3cSZw/4mJWjyuNFihCfKo9fRP8uzi7I0CA0CL9LgK9Vcm4jrSuwdNB8X+K6si6EtXhhg3sQzlX7Q6e3vsmxw+KIOSljrBwqUtEL0Bk5DM13gRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym1S2jkQ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym1S2jkQ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9dc546f40so562673a34.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030874; x=1784635674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rBtlx7iHFHOhX9UuDDBDnXkrtPmiJE4QMJttkANYWxs=;
        b=Ym1S2jkQ3rodfkYBfpZ076IJbKQQVkMe5Kuqr6FjFVopmfSS9VRACdnAm+a/fgjFis
         eVzx/bCmqjtZ+PiHUAbkkFGlBZqbYaaIvA6xG1XLruvJZc8i1J1F8e4Kao9o1H00s3iV
         R1v0RaSyFmtaLJGZCczITdVJCDWLUWu5IOaCOk4BOsZTcLiCa+gYX32nF5TLtexkyJFH
         EwWtT/up56cBmdp+kvtlpqt5i6d03i/uO6Jci9S/0d5LPHcr5vEs4zwG/VbVM7hoQREb
         nt3TlX+M5YJZ9YThD3PTwsss2ph/hVVkkLymsSH46u3+LLFm14gJkxhYZQ1tyjgXu/xc
         2mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030874; x=1784635674;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBtlx7iHFHOhX9UuDDBDnXkrtPmiJE4QMJttkANYWxs=;
        b=HHg75oBYcMCUfpW7JKUZEkb9s6grcJUSoY4icyByYb4HBdw1ThstRjyDQgcmjGH80g
         YRRR5Zs8Ro26ucUywLML0Y783AAK99OzNnOs9bggHDjH3rrL5nTnLahM3bE0GdeHKNIk
         pLCN+bw+8kNXeh1oD2yRWJ/18LrtUg8TESTsdyBYnY44mEeP5U/Pun19Ev8o7xgNI7+a
         QJW7vp9qRn4Ll3KrPPE4Y8VJ68vyxeYRL2+y5UP2MzlxHEZ3q2+Wyxep88tPeRwzfO4A
         /uMAboBMoK7IemOgxhHrrWzrr7c54iLa3mxwvzryMWc0ggfy8F/km7SVsOLUvZvERweT
         V2Og==
X-Forwarded-Encrypted: i=1; AFNElJ8hJ0qNoVX/ooEhYWwpoUiYBBGBk4zstWZmFRpj+tNU+lv8sTpkNYwCBHE3Qrw3RObdTavx/L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLl1YsGCeu75V50UaiJzqOIqcJO11h9G9sJNUsB01YOMkkWUc
	aZn8+yLNfB2jcK60vIFuz/lpirisIuPiP1qt8lX1mTN+1+kpvAXTpppS
X-Gm-Gg: AfdE7cmHXxz0Y/4hShQZKbwadVoAKDMqcOQqeD6DqZ6r7hGm38G2vK8yf8qFnNaGJh+
	mWCJOXbWmT7qUK91tazjpcSVgBcBLFN/6Vu0/y5t18g7cOj1URhSsXJNN3PvGyXR8Hhg2Zyk4ci
	T7CQ5jOszUhKjYTc9DBTGJl9zN/q5kw36HNJZO5J6W2p6Ibwj2Ha9oH4t1GXK8WSPH3t5W/csja
	83tA+BVrYcdQjuwrkiDpw0VVgZiJ/W/DV0upSRPiRWEmntPQsPaFml4kyeRO7/WKyq1/MW9KR57
	VOhPD9yx5j2JzC+/7WjlOfhmpX0vx8kKtRs2HN83NcLIeEJ6pEco4cFxwOhj5cX0ce+Lv/DeSvx
	DayUAC9ap0R8R0PiQhpZFuG28raILTA7mYmg1fTu34kys38S6AH2FJ27HfpIcPCnZQhZN80jZ94
	lQ9LyrRH5U9W6kwVCilo0pfujA0A==
X-Received: by 2002:a05:6820:1627:b0:6a1:50f8:abb5 with SMTP id 006d021491bc7-6a39bee703cmr6227343eaf.32.1784030873900;
        Tue, 14 Jul 2026 05:07:53 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f2b86sm14964026a34.26.2026.07.14.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:07:51 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:07:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
Cc: christian.taedcke@weidmueller.com, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Message-ID: <alYmkuGtjGRvMqup@stanley.mountain>
References: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
 <ak96OkpYvJrK1Vbt@stanley.mountain>
 <84676bd8-3815-433b-b531-2715b8e8693f@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84676bd8-3815-433b-b531-2715b8e8693f@weidmueller.com>

On Tue, Jul 14, 2026 at 01:58:53PM +0200, Taedcke, Christian wrote:
> 
> 
> On 7/9/2026 12:38 PM, Dan Carpenter wrote:
> > On Fri, Jul 03, 2026 at 09:56:12AM +0200, Christian Taedcke via B4 Relay wrote:
> >> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> >>
> >> When one irq is used for errors and each channel gets a dedicated irq,
> >> the total number of irqs is num_channels + 1. If the error irq is not
> >> the last entry in irqbuf[] but an earlier one, the loop assigning
> >> per-channel irqs terminates one iteration too early and the last
> >> channel is left without an irq.
> >>
> >> Iterate over all collected irqs instead of num_channels so the
> >> error-irq skip does not shorten the effective channel count.
> >>
> >> Fixes: 188c6ba1dd92 ("dmaengine: nbpfaxi: Fix memory corruption in probe()")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> >> ---
> >> Changes in v3:
> >> - Guard against out-of-bound writes to chan in case of an invalid eirq.
> >> - Link to v2: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com
> >>
> >> Changes in v2:
> >> - Advance chan only when assigning a real irq to fix out-of-bounds
> >>   memory access.
> >> - Remove now redundant ARRAY_SIZE(irqbuf) check.
> >> - Link to v1: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com
> >>
> >> To: christian.taedcke-oss@weidmueller.com
> >> To: Vinod Koul <vkoul@kernel.org>
> >> To: Frank Li <Frank.Li@kernel.org>
> >> To: Dan Carpenter <error27@gmail.com>
> >> Cc: dmaengine@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >>  drivers/dma/nbpfaxi.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> >> index 05d7321629cc..b1f06f0bd0d5 100644
> >> --- a/drivers/dma/nbpfaxi.c
> >> +++ b/drivers/dma/nbpfaxi.c
> >> @@ -1374,14 +1374,14 @@ static int nbpf_probe(struct platform_device *pdev)
> >>  		if (irqs == num_channels + 1) {
> >>  			struct nbpf_channel *chan;
> >>  
> >> -			for (i = 0, chan = nbpf->chan; i < num_channels;
> >> -			     i++, chan++) {
> >> +			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
> >>  				/* Skip the error IRQ */
> >>  				if (irqbuf[i] == eirq)
> >> -					i++;
> >> -				if (i >= ARRAY_SIZE(irqbuf))
> >> +					continue;
> >> +				if (chan >= nbpf->chan + num_channels)
> > 
> > Prefer my check, but sure...
> 
> I tested changing the condition back to check for i. But after a few different approaches, i think the check in v3 (chan >= nbpf->chan + num_channels) is more robust.
> 
> It handles the following cases well:
> 1. eirq is the last entry in irqbuf[]
> 2. eirq is not in irqbuf[] (which is not expected)
> 
> This check also makes it clear that the write destination is verified.
> 
> -> i would prefer to keep the v3 patch as is.
> 

Ah, yeah.  You're right.  v3 is good.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

