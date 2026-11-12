Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794519625;
	b=hxceBd6rZRNCFU/ORfOX260KRm98daYr/WAgYpIrgYcZu0yTOiX7/UjnZxzYA+lx/NIu
	 ccTq09QcCE20Qr8E55ZD2fv1UGuovbqOJhfZ+5N1qxD2FczM8qPnum4uAVcqOT4cnM6AP
	 xbeHrAzeXBS/eGmPJ7bhP5xumSi5Q1iT/T1caxdFfT9ruXvQhPMzAftJA2fEkmcvmA460
	 xsXW8DWu2hwub5ucCXbqW/D3APlJzo6cBgp6dHbbS7Tshs/5ZnIkCS3YwL1lgs3e8sA8N
	 GS2BI2LcPOWn5LTs5HNVBDbEt5hTHh5chGyKLK8BCF3Plgd2TvR8xhboItLlgDZSckQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=r7tUMESnGuHT04Vkq8tfouLXmNvcHODCZ4NpjFvO4WY=;
	b=p8hH1NNWabbWye962lUlace6x1kEw3VJZxO/GezZuUPGSsh+f1dSLI/i3gRwCKTWlwa1
	 Xx7vVe6lE4wu4bGG+19KAt2rEh1XVc/JfXUcQplDPa68MxbXE1UAav049Roh9JuL+oAUc
	 CmGSxhq5W5d0nTnfRgBxJmy4m00rBmAlmxka+fcrfwoLfkPAiQ/DuBlylJ+kG50so9Nt/
	 co+h06n7vHiIC6T6HHPXUe2Z0nAzv03lSCVASDqXFMqxCppiETJzyqmoziNs58ET+R1Tp
	 tLM1A1DaE3wkNp1AvXzHAUCCr9YdVdLmSu1S/xRr0zZVywwtHm9X77VAetAp2hZ/zWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lwKKxJ/J";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7796606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 21:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7796606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwKKxJ/J
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49a3521d4d0so9286f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794519623; x=1795124423; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r7tUMESnGuHT04Vkq8tfouLXmNvcHODCZ4NpjFvO4WY=;
        b=lwKKxJ/J9/7p2JXGfMiXSJxz20fys6eBBo8AFa2LIDeMBxpFiDBrs6g4UvyDxi51q3
         VnscTkd4nGY/6Fm4lA1hqeVSd9RfMPZK1uNSaRBvv6tQuiveQHsu0lZym718WQkD4mpK
         ItpHzn8eIu9MfLddvRb3yoQTtUXZDWjWx+VyfkUsPqVRJmItPEwYsgs4yJ5274Sosbui
         jpF4+RxIVAnIKoo+FkGyMINQrJUIyPXkJEjikOS/n7J6GYtxeTlnotfXJ80HjbMJ5Eyf
         3VbzX8PCUJkNvgtLOn1HG8WuxgED/uka07orXiNRulBwHWjMWvH/bVCNh6WMBya9nJdF
         +XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794519623; x=1795124423;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7tUMESnGuHT04Vkq8tfouLXmNvcHODCZ4NpjFvO4WY=;
        b=GcC6/W8tBWKT5YPdoZk/wdDtkCsy0ipyYCdLou+G5soEdJa+4OQiaLqujuwfm9FqaE
         uP3jdCR45YxjyYfhOIauVgMCT9yZndsrYiU8w8Ik4Ukx+t5vpnFJ9W4lTzGSwm33pNAg
         r8lB8bti7fFbNPE6xbtHV/g1d4JbPpByvT5tjeOqBL6ToQmnTOtdIFiKwCZoQehZYXYG
         YHtM1Dk39RGsbZ+/0aoO8uCBIkGonOzA8SdgGrqS1xqLYsUAOhZ7TeKRow9LXh7ylV/r
         aw/05e6kBtWQNkcVoclprFjZpmTFKbmjQy6TAsBrDasT3H60/zgLdJoJrMrs5NR2X46o
         Ku+A==
X-Forwarded-Encrypted: i=1; AL+hErFkXMfGUQROlGYy9f04gxKAoyFv2rxmLIbchzgEJALbEO11z9LKUUaWLzm1xxi+c1e/Bo/hgqg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vPd9SJwyun4YrQHxhOcFFAzzAntzq9nKhirJGAIJ2LKqENJYp
	UnXLSHGCUEC+m/sIAGWJTWNsgFMC3w0CGPqH00aSWLNZ5qdMJo7MZ6L1
X-Gm-Gg: AYBFou0AolazhJNgaB/WjYIWoYvQR+VY8iDc5oyPM9Ju/RZQw6V6Z0PpiYSvuIdT9KK
	M1UJF3r8JnfztA6zC788OBnUoDqJt3pMeFvW/prib4Io2UhpI9Mois/g9uT5E7YYcfrhbx/ssFo
	Zb75uI/jDf1ILUFZcaSFsCQuiwq2ZodG9E/o/DMaglWVDrZgXzj8EB6BzuM/O7cqWfRhYJxOUhJ
	xop22fRWXSCo9joC3K5Scaq//cEuQcC0Atl1tX0ab57VyjRueC0+8BfzWOVYw2FERenBTEEBRkG
	VwFFOyk1iC89c6ig0JyNUuGMyweWKZyJilkeGjd4LEz0AaF42EB5nUQIe/O78Zc4VoPXLyDf/Re
	3CI/G8LyXuVJnBiQLlBubBQD3mACYFgtHRAnb9K6BkDk5qaat2mKStjKwiC/MjoMSSJPG2xqi87
	YMkq2JLeaphPRQIMJLqoebTFeLZzHj/9xejwZkiLAgqBWGTwvyrdzQUJRw5ICKubNV9KhO3xSVz
	sY3+6SKzmgYjSyffY/Fpl3zvwcmbUMPeeB2/dTrNLUxNGUatKZrCQHadWtddB+W/jDQ0vAidzA8
	g0U6dXDurl/4vNwF8VbjSshNkHyLFpjEPjwxrQUI09TKUhpiCqOvLPxdI63gjm9vwq0qznqRJfd
	JZt+5ud4=
X-Received: by 2002:a05:6000:40cd:b0:492:b1c5:6dc3 with SMTP id ffacd0b85a97d-49c723fc6f9mr1514901f8f.6.1794519623235;
        Thu, 12 Nov 2026 13:40:23 -0800 (PST)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60021375sm1279890f8f.29.2026.11.12.13.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 13:40:22 -0800 (PST)
From: Marek Czernohous <mczernohous@gmail.com>
To: Beomseok Kim <dilddream31@gmail.com>
Cc: nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Fab Stz <fabstz-it@yahoo.fr>
Subject: Re: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
Date: Thu, 12 Nov 2026 22:40:21 +0100
Message-ID: <179451962164.1494544.10983579250194846394@gmail.com>
In-Reply-To: <20260928081450.19340-1-dilddream31@gmail.com>
References: <20260928081450.19340-1-dilddream31@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 28 Sep 2026 17:14:50 +0900, Beomseok Kim <dilddream31@gmail.com> wrote:
> nouveau_fence_signal() clears fence->channel before dropping its
> reference.  nouveau_fence_no_signaling(), however, removes an already
> signaled fence from fctx->pending without clearing the pointer.

[...]

> @@ -488,6 +488,7 @@ static bool nouveau_fence_no_signaling(struct dma_fence *f)
>  	 */
>  	if (nouveau_fence_is_signaled(f)) {
>  		list_del(&fence->head);
> +		rcu_assign_pointer(fence->channel, NULL);

I think this patch fixes drm/nouveau#443 [1]. The nouveau_fence_sync()
oopses there and in the reporter's thread [2] (MCP79, Debian 6.12.43,
6.12.90 and 7.0.10) all fault at CR2 0x40 on the prev->cli->drm load,
with prev taken from f->channel and prev->cli NULL. A channel's cli is
never cleared, so prev most likely points to a freed channel. That is
the stale pointer described above: the no-signaling path is the only
way off fctx->pending that leaves fence->channel set, and
nouveau_fence_context_kill() only walks fctx->pending.

The fix looks right to me. enable_signaling runs under the fence lock
(&fctx->lock) while the fence is still on fctx->pending, so the new
store happens before nouveau_fence_context_kill() takes that lock, and
thus before the synchronize_rcu() in nouveau_fence_context_del(). With
fence->channel NULL, nouveau_fence_sync() falls back to dma_fence_wait()
on an already signaled fence.

Emmanuel Fleury's prev->cli check for the same oops [3] only helps when
the freed memory reads back as zero, so I prefer this patch.

The patch applies to 6.12.y with an offset; compile-tested there with
W=1 only. I have asked the reporter (Cc'd) to test it.

I did this review with help from Claude (claude-opus-5-5).

Reviewed-by: Marek Czernohous <marek@czernohous.de>

[1] https://gitlab.freedesktop.org/drm/nouveau/-/issues/443
[2] https://lore.freedesktop.org/nouveau/b7f523dc-fe41-4514-a1a5-747005311cbe@yahoo.fr/
[3] https://lore.freedesktop.org/nouveau/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.fr/
