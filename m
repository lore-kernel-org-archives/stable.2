Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60253B60A;
	Wed, 14 Oct 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986458; cv=none; b=jMfdiLJdhiNrDLmNDyII12EBsazDm6nVJOLM6bUzd5qRhkr0QBOu1sPmoRIf4YyUddGtnFaE/v6vfzVybSpmbYMMMk+Pkr13K0bZ2zDiOjDaSZbyvbXaGF+iqZrksPWKOExu7CbGiioq+jrrdZTfc1X656DFGniRfVjg9appKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986458; c=relaxed/simple;
	bh=Ra0Y3BvTdz8AJOWltPsW7r1l5tkOwOlPYfZhSkipkvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BixIVl8m9woxtQ4+xj2+8PGecMITcs6gnP4KstD5dnZ+ozp92XY/S6u8X31BulIG8dqgL4yWOlOGJ1ABsyv8ow55lcfTBM5nZIofMW+HqZBjsmziOjIBnO7SSRJEkHB0oIG09/fA1jTs1Svby6x9BVTUMi1xAHHM7/4Qj8GxgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/Izit2A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMEyN1mZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/Izit2A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMEyN1mZ"
Date: Wed, 14 Oct 2026 16:00:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791986449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mq7qJVC1awJnl+BqDUszf8sZ/WuqUk5FNcUeA/mKLU=;
	b=2/Izit2AnR+VKpA+biznr+1OrJIRdHPG8iry1o4qffeEXzlrHF8WrjdtZ63amubKTbMfZr
	gpIKzRukYayjZinZG62htIg5fq/FpU8VXoZehvJxn3n1Q3XGXmG4q49d31zp1DQpwI8zjl
	5+Z8DDpJHTGIq5KP+sjHZS6Yp/rGsGSmP2e3+GKvTIY9o+8vIIU0PF/RnERA7SKuJPO709
	F7QITUtjN2lLwaz2eJDmfhAlu88/B94A8va3E+U7Bc1nWIon0huKxodrw9/8xu8SI1+DuN
	m/M4qlpUak2mcmUM9sY5fos8MKdiZuGNY/FEalu1EnbjIpkqIngR/T9YKRgZYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791986449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mq7qJVC1awJnl+BqDUszf8sZ/WuqUk5FNcUeA/mKLU=;
	b=DMEyN1mZ7SL6/yU3qauW2MnC6dqhYEpTD7Dtp5vlBR80vDVpLmKVJ22z3yn9ppbrdnfJKE
	GgNAFnPDyAwcmsDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com
Subject: Re: [PATCH net v7 3/4] net: hsr: segment GSO before per-frame
 forwarding
Message-ID: <20261014140047.Z8nhXzxa@linutronix.de>
References: <20261009201324.17-1-xiexinet@gmail.com>
 <20261009201324.17-4-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009201324.17-4-xiexinet@gmail.com>

On 2026-10-09 22:13:23 [+0200], Xin Xie wrote:
> HSR/PRP require a tag/RCT and sequence number for each wire frame.
> Adding them to a GSO aggregate before segmentation cannot provide
> valid per-frame metadata.
> 
> Use the core GSO segmenter before normal per-frame processing.
> Each segment follows the usual local-delivery and forwarding paths.
> Remove GSO_MASK types from the master's hw_features so core TX also
> segments local traffic before ndo_start_xmit().
> 
> Classify by inner protocol, not ingress port. Use the core's bounded
> VLAN decoder for 802.1Q, 802.1AD and nested or accelerated tags.
> Reject inner HSR/PRP aggregates, unreadable fragments and undecodable
> headers. Also reject trailing bytes beyond a known nonzero IP length:
> otherwise an old PRP sender's erroneous whole-aggregate RCT becomes
> transport payload. This check also rejects locally destined malformed
> inputs that the base kernel accepted. Zero IP lengths and GSO_PARTIAL
> are left to the segmenter because they provide no full IP extent for
> this check.
> 
> The preceding ordered-consumer patch is required for per-segment
> local numbering. Charge the worker budget by the actual segment count,
> or one on failure, and count each rejected input once through core
> per-CPU statistics on its entry device.
> 
> Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")

I've been re-reading the old mails. The whole thing is needed for GSO
when it can not be disabled, right? And VETH interface has been named as
an example.
There was also a bridge device. With HSR you form a ring. With a bridge
you attach other (physical) devices within the ring. This does not sound
like real life use-case. Do I miss something?

> Signed-off-by: Xin Xie <xiexinet@gmail.com>

Sebastian
