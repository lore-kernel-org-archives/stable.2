Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262339;
	b=CoNxAQ7nPu82WfdxVz165eSnOZXhe3GbJrY5YCaKcEAYPA/zybJ2qc5UBIE24KcmFcs9
	 ZJ8WLTJYuu7cHbZSepIO6I++CKiyIgz4r1IcKdYmzXdMFP6CAYNs+XcnTFKHBOnzBsBOk
	 /rF9gOntlKDAXM8hvWKgdR9TuIBusDloU4p8XTqUKY9E1h4mWztwhX/hQDgJ3TtE9M4oM
	 XepLxZzaABS2+Xy7YFCQTWKD7G8WTmZmeMmaOuPPoaVpKf1OkVjxzKandooJsIAvzmjub
	 zuqQuzW0tv2lTYvVQRXNltB8APWOD/2WOXud0zivzuplB2iboNEcCv+kw8Nw6g51EuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262339;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:To:From:
	 Subject:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=i7BliqTUh+ruXPtCUZKVjBBAkHgZCIiGzPUh2SAN8YU=;
	b=y1+E/2nhbvRPTBk1ZuAHn+H9sK31t8L+7jHlQ0TtEepwLWsGA+527Ga5TW60hFN+sefy
	 +jkQR1SII3pa9N5+gnqtdM4itf6iUdg8Ylgkyd8X2D4abpZnZymw0YVIYGaGAyFXVHFvu
	 SsyQh5lEG6Lo26APZqJI4gyt/aZHDKNqegdM5TiCEgWJjyS+BCIg5UtdIzjgbhayqKq1A
	 hXtclSdHerzCPrY7tOy6luXJ16I40eENYOb7k2RkLINiA/TB9u3atPoTEP0i1/Y1gxtss
	 28gDTCqs8ANhql7sheg9AZ9b9Vx8/WFqEWa0IsKD0K8Z2nf9ohgQjg4ebV/WTDsaqKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="Gi5/RwN+";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A6606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B22A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Gi5/RwN+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 154D81A138D;
	Thu, 29 Oct 2026 08:25:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D39A260360;
	Thu, 29 Oct 2026 08:25:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D2211032900F;
	Thu, 29 Oct 2026 09:25:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793262333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i7BliqTUh+ruXPtCUZKVjBBAkHgZCIiGzPUh2SAN8YU=;
	b=Gi5/RwN+yASwrW6VfMvE/S4XS0WOri5JMkDDX4WyM2rJbSJR6DSixH1w43CDLfewcnktxo
	5EVVKGSWob+WF+J853qHqHE6OYPH1VFPOykVOJcJH6VskN+hUaJGq22wQId/DMGbZN7i0C
	AcuFUNcyN93AyQ/4o+VHvilqoiB+uFl7mc+1fiIm3jDQ2aZfB5IkHMy/25sdmE2PCzGGbz
	QKRnb2fiCwMM2cpuVBITTWSIWsV0ipEKvk47dOhjVZVkEs1ZshYi0wDSGdGEhH3wstfV0a
	Gala+pSEWo8DNnC2T5uh/X6AUNaj1pqB6Z6uQyQBbG1KaUDXMza3Z+MeX+nR9g==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 09:25:26 +0100
Message-Id: <DMH6FVUD4K0S.R8UAMMH8TVZY@bootlin.com>
Cc: <romain.gantois@bootlin.com>, "Cosmin Tanislav" <demonsingur@gmail.com>,
 "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
To: "zhangjiao2" <zhangjiao2@cmss.chinamobile.com>, <andi.shyti@kernel.org>,
 <dumitru.ceclan@analog.com>, <sakari.ailus@linux.intel.com>,
 <luca.ceresoli@bootlin.com>, <andriy.shevchenko@linux.intel.com>,
 <gonglinkai@kylinos.cn>, <rosenp@gmail.com>, <stable@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <trivial@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] i2c: atr: fix race condition caused by static local
 variable in i2c_atr_map_msgs()
X-Mailer: aerc 0.22.0
References: <20261029070818.639-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20261029070818.639-1-zhangjiao2@cmss.chinamobile.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

+Cc Romain, Cosmin, Tomi

On Thu Oct 29, 2026 at 8:08 AM CET, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> The variable `c2a` in i2c_atr_map_msgs() is declared `static`, which mean=
s
> it is shared across all invocations of this function regardless of which
> ATR channel is being serviced. Since each channel has its own
> orig_addrs_lock and alias_pairs_lock mutexes, two threads can execute
> i2c_atr_map_msgs() concurrently on different channels, racing on the
> shared `c2a` pointer.
>
> This can cause:
> - The wrong alias to be used for address translation, sending I2C
>   transactions to the wrong device.
> - The `fixed` flag of an unrelated mapping to be corrupted, breaking the
>   alias replacement logic.
>
> Remove the `static` keyword so that `c2a` becomes a regular local
> variable, eliminating the shared state between concurrent calls.
>
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Was this potential bug observed on real hardware? I'm a bit surprised
nobody noticed before.

Also, if it's a bugfix, it should have a Fixes: tag and possibly Cc:
stable.

Code-wise it looks OK. Not sure a bug can really happen but I don't see any
reason this variable should be static: it is always set before being read
by this function.

Also please keep Romain, Cosmin and Tomi in Cc in future iterations, they
worked significantly on this code.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
