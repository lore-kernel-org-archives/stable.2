Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529171;
	b=jJbuupE40lXb/1u4c2ZAD5ifw1Ye8XGLej6QwdDL5r08yJW9BI75y+Z9C9SsC0Judz1s
	 /2Bwl7MFViyp34evl9eN6dahj854sL41szPqOqjWxc0/kJ/g7llqw+D3jCK07PJb7g43Q
	 Br702EQVz6SGhEHTf7ck6r8Bph5buYmy7PS5cBH8ZSdPxm8hz5gxMAWIz2TsBrbFALWkg
	 XC785a2REjNlhiynk0u+w3CHykkAuClQpWV6gVREYnlKMfTEK+zjfBs8OVfY3EuzYmnxc
	 lq1DwNOJEQ+d8MYjaByi8ExCELWkdRJXvBAMhsi6WuJkKUdLDzhVq3yDi1PN3YTm+mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=S8YJkHkm/SxGQO4kohbKqn+J7zEdKLPkqIyPpPevv7g=;
	b=5LKXCVa6cKNhXKjgIKu7E6BwsDKQgaJFdgxcU8g8PKAHGrkMrdtwFgI1G3JZdAeHtFV8
	 C/W8JDSgfAeQp38kzb3KLKkjOacCHtRoHftSTRSZg6+W1K6IkxHFBJk06qNM5vHcNFU0z
	 4x4pOy0WVLBXbTxbBWKW3oHUYN07MoGcFXrEH1zsdC8DuekXJqpoXWxHZNzmV5fYMMP2u
	 Bd3n5vni8mj0zItiRyfI8lPa3FwLFRt7f8QSf+la8D/Jvyr12bxpulRVZjOdZ6MtC3Fgx
	 166i/HeiTfB/7rdYNrnC0dQwUj+15H2lWArq5iLes76rHN7hmAi0ojmR1okolpjHg9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DSpjVVcq;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD663606A69F
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD663606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DSpjVVcq
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so2833985e87.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529168; x=1796133968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S8YJkHkm/SxGQO4kohbKqn+J7zEdKLPkqIyPpPevv7g=;
        b=DSpjVVcq8TeO6xu2p0bIyse844LUdtnK12XipX9WJfEckvekJT6TGuo5IfecGiEZsr
         v071ioGelwCA7o5zeO7eJTG8/QBO1Kz+VIB6TlcVHLWi/N90IqBjX1QiTbM54iYGrAPI
         JFQVArhHv2J3shIslplatk9W7G35DDP6cJWcawYkLSsAl5n+yef3zBa3+aT4zc8WvQ8J
         JPApD3jOSJsDnOgqnDl7p7UaQ/3arAd91Z+R3l0h27Bs2EBq0xvRdp3Jhi6A638poxVG
         o0qf8wBg8e5vZVka9anRlXVegXB+wg91whsM1cfYYn3A4pR12aDrZHMJpB9ofp3f7dPA
         HTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529168; x=1796133968;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8YJkHkm/SxGQO4kohbKqn+J7zEdKLPkqIyPpPevv7g=;
        b=zFvG35tiOC7eNFeVCEWhNbwjWoRH16Q9Ap711baV0SlHDxtEAsfgS0R3xnxhr4jPlm
         xhxQuImwuZZ3wx/d9sRDnPJlbpBIvB07YlBok6ytieLSCn4c4gSob5+p3jrC56o1cL+r
         CsfZ6itzMG3n5rA/Vs71IIw9f6iZkiHoALxAuhOwOlMQFtCOlYFIYkj73jsj2JhQ3PWO
         cu5Ri0gyKynBgRFgobkbKFJzRfieC/ALqFeahyPznw0ZnOGEx1b6wbhhIPCMh+TXf+8K
         rhTayZvpCZHPoQBodghu2i8siurB+BT7rQuOgyBu7kXnhc2VRayu8ctfsGtMwFqfsqzP
         NdmQ==
X-Forwarded-Encrypted: i=1; AL+hErFHsBQgmVdpNlvlSW5LmxvWe8Wxs/McsNWtbLG8jAMjN+weGeHVQEyC7bYVgRQ0skIowElHn0s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pjDOFENubb5trn3MBSuOSeA2Nfx6pfF/p81Dqvii+sxNQRwIZ
	mOAN6LiP/9BRAg3h35yDdPua8wS4Xbv8zG6wqQu6Ih74ZUIZCBy8XcCy
X-Gm-Gg: AZFdTZc2NOt8ksFfsHdhWbiI9/J6dggXJ6EusdC90zuMSrkBQd/m2UXrP341aaU9fRg
	Np7zEDrlpHHJ2hZNMaxaAJWpqrNnIDL0VzK6HvPRsWBCaMhCfeeGXgRrXXaJWXzGNJsxYI8YYpC
	YWtHXuMMznSMYnFKAz8JLshgLFkUVQJzwQqir8mZMSFJ4nydFfQyNYw0hc/gm1XwrdMZaHZX2gk
	Fp6Fd01qqO6YWsbljV7MAht19ACtjLXfiHI57YJgCiipLOC6Rim5q3kVOO3hcKieD/SdUa2JDYA
	JU8p/0mQB38gRzA5hCDz20HOPY69zm1m90hE0lqXJfZKpcJAbRwX1mPNzE7pFwYHBixwKtjpoVI
	QNHs6i/9qCOfX3tobax2Bdp0RL/jjev0KWZx7p79JoKv5YHsIsKUhFPR18ItwHxOJ63+A45JtqO
	EM4qfHZ1cC41XUtHY5HpqGahm7TvpM5gwtVMs+siE6GsOqOmWnPfLQ70a/4CO47nbsyaYHVRCXQ
	rcSv/bdZDO1RLQ+0YFwSHS3ivGnG3agjAVMIEsZEmQzgjqt1JP5cIxX1dNe0BhnwR39p6aEWUtf
	1lWQ7heMDd29YN1GlI4puJyFmaVqZYZqd3cD4CAQ+TS5P0Fu/w==
X-Received: by 2002:a05:6512:3043:b0:5bf:a34d:5961 with SMTP id 2adb3069b0e04-5c1bc660762mr4326463e87.1.1795529168154;
        Tue, 24 Nov 2026 06:06:08 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd04451csm3787629e87.59.2026.11.24.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:06:07 -0800 (PST)
Date: Tue, 24 Nov 2026 22:05:55 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v8 8/8] gpiolib: remove the shared GPIO proxies before
 freeing the remaining IRQs
Message-ID: <20261124140555.GB48187@rigel>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
 <20261124-gpiolib-chip-removal-v8-8-aambrozewicz@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-gpiolib-chip-removal-v8-8-aambrozewicz@nvidia.com>

On Tue, Nov 24, 2026 at 11:20:39AM +0200, Adrian Ambrozewicz wrote:
> gpio_shared_proxy_to_irq() returns the parent chip's IRQ, so an edge
> request on a proxy line holds an IRQ of the parent.
> 
> When the parent is removed, gpiochip_remove() frees the IRQs still
> requested on its lines before it removes the proxies in
> gpio_device_teardown_shared(). The release of a proxy line request is
> serialized only with the proxy's own removal notifier, so if
> gpiod_free_irqs() frees the IRQ between the release's irq_has_action()
> check and its free_irq(), free_irq() warns:
> 
>   Trying to free already-free IRQ 22
> 
> Remove the proxies first, so the character device on each proxy frees
> its IRQs before the rest are forcibly freed.
> 
> Reproduced on arm64 QEMU with a shared gpio-sim line and a test delay
> before the release's free_irq(): 3 of 3 runs warned; with this change,
> none.
> 
> This patch depends on patch 7 of this series.
> 

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
