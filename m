Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922353;
	b=mBNXQzlow87PdpOuULFCUUoEBYBRua87dA+hoPeVZRR2wKn9umdrvdNcEl0sPLtWXHd6
	 HfLIs7+Rw0i/bFhAvZg2jXdOrmmYo0jHUTieMXIebS6ZYKgc1lmtvI4pQF0hzO4SrK5MO
	 gWw1XhZuNeV6nHxYTWIuJfev3iqb/Avo5h7G0tvRqGfaSO64hs1q19qicrHo8ciHjTh0+
	 o52aFVZNsiM9z8Fy5ehZFOOQjkFJN5vhF0Rw5is//QfO/BXzwjp3vH7RcRX90RCVawkoC
	 pcHCQpsurjNznVWuTFmHBUwSd9cer2G4go0mQvsF5gdgqbuSauOD5CYF0ZqPlzQ4aeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922353;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=TNhUvt7V3+z9yILQyuOrF8o1BFxufpMkmYgFMT/d6gw=;
	b=LGTBwABLLBAf3a1B4aJd5HIfXx7H1zQ62wLQpUg9GnLDWCdpAWz5rGrOef/x+9Z8JJxf
	 WEAGjrWxyGK5cyh61+jQ/yOI90qzcPrKHq8UMg9eAaJryMua3iq52jRDxdySq3qB+etkJ
	 c875iF5AU5GR2TlHhSLZR35R3SqBW2qx1fq7qTUo+WYrxq9raiQmne82zex11LdrXoD2v
	 cwzRksENWYqre1Mr8m0WC3ZGwH0bSSZr+I4+FeDF9FVY95iODJ+fvKoKgoPdJX84YnN43
	 guyRps9Neo83gP98s/jhCQHjzh0wNd56k1ceH3K6TdVFCoJ27qq0x+wSh5ATvxioc2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fzTNkJ7N;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83302606A31C;
	Tue, 17 Nov 2026 13:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83302606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fzTNkJ7N
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ED4914E41473;
	Tue, 17 Nov 2026 13:32:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B842C5FC81;
	Tue, 17 Nov 2026 13:32:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4DD3811BC0008;
	Tue, 17 Nov 2026 14:32:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794922350; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TNhUvt7V3+z9yILQyuOrF8o1BFxufpMkmYgFMT/d6gw=;
	b=fzTNkJ7NqGGVaO8SeLv/BKRL0kR/5brrbWW+BVdqpx8Hn6YGdn9SHkF4bhwy8y3nM0e2na
	8AkfGLOvB+VHHAWogLOJIz8hE2jNHpsWbigv51r+SoczEFM0XABBvlLtMBPTXS5JWmtD0I
	DvNo2m+VU3VtwSaSsHH2DFS6cAnoS0wXFoy1UuHYr75G278+2HU6q8MNaiUggZ/SYfyBV0
	eYaCxiFtUuGl0HreX36YTWgvN2h9Jt4TCzgyepWCIkr11Oh/Bzy0HwFKPTMtCFuOwDQ0A6
	M4xs7DjX4N9x77Gt5uyNjAPkDsFkUisFze4hOZm2WzFeFlbjesb8MqKb0vtYog==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Yangtao Li <frank.li@vivo.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: lantiq-flash: Fix NULL pointer dereference in probe
In-Reply-To: <20261106014928.4126855-1-guozh23@xiaopeng.com> (Guo Zihao's
	message of "Fri, 6 Nov 2026 09:49:28 +0800")
References: <20261106014928.4126855-1-guozh23@xiaopeng.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Nov 2026 14:32:26 +0100
Message-ID: <87mrr7lh1x.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 06/11/2026 at 09:49:28 +08, Guo Zihao <guozh23@xiaopeng.com> wrote:

> ltq_mtd_probe() dereferences ltq_mtd->map->virt before the map_info
> structure is allocated: the map pointer itself is still NULL when
> ltq_mtd->map->virt is assigned, because the structure is allocated a
> few lines below. Any device with a "lantiq,nor" compatible therefore
> crashes the kernel with a NULL pointer dereference during probe.
>
> Assign the mapping after the map_info allocation instead.
>
> Fixes: 6145e07e9c77 ("mtd: lantiq-flash: Use devm_platform_get_and_iorema=
p_resource()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>

Hello, this is a duplicate of a wider series from Simon Wunderlich, I
took his since there are more behavioral fixes.

Thanks for the contribution anyway!
Miqu=C3=A8l
