Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CEE3909A3
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659963; cv=none; b=ctClQfE47+n3fSNl6wypVcwfr+Ya+NMwfHZHSJS/KunE60uWZFrM2EdJPKZQsHjPsPGat5LxSgQG5BuU/eGjqeN5tOxHYZnsJ1DsN8clxu50ugtWSkkjC5L2nyaZqLwaBf2mzBQBPCg2lx6cHvTtrS7mUj23eI3/fI/ty6QSrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659963; c=relaxed/simple;
	bh=a8ofd41JnpFBwTjDBoMfI57jlMXgC5Ho/1LsoAdjqgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o56KSTpQZM/e1tuIkdkUt/AuTm6CshnmV7+FUmu2paNzNqHzRgSdYK5XxkUk1FnlK4x+sasl+kMJpD8uFJZUctw4K4z9jng61LWOfJa0y9u8Xp1GN43IfwhgQDG4GA9F77TBAWDbsTImUH3i5igZJC3jfhLtpYeiQU04rbf9HH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ghZWMDsD; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ghZWMDsD"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5bf95ade656so917479e0c.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 01:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785659959; x=1786264759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lR3bhmlqcQbP7TXCmWl9MzUNxiTSwB/0YI3MWW/Lfsk=;
        b=YxWwsRinlCouSfAF0PPitBbovGPchvivhEz18BlZa1c/Wo8UPfGE0kLoNWvRqD1zih
         XMnetsZ14JySCw7usltVMFbtRDFduylPWAFwDswtUQdZ5Ix5VOj3wLBDQ8qZBB8j3hrA
         xn4I333Dexae2CKq5sXiHxaPpQ4h2WOKNsXFNKw0/KcBXPDM7In5WtEzz+fyf306+09c
         mXDQfK+FVtWosil0/xmmRxyOmHQQJneEvJj+8Yp2OxXN3mdru53GSIGeHbAIdmLOwcYn
         iAvwkagWRJOXfX7jF6MS7DyE8sZbk0WlGnfOhrBPKDbDt8ksvmtH9R/rYkePyzdJy0Pb
         oufA==
X-Forwarded-Encrypted: i=1; AHgh+RqsGvgEZ+Y6e3WuS1C3L7mmA/vk+YwsUqi+QZqq49hu2mtPzOqTM7Tk8y91x/OY3MaXYYoh7Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6p9ESFs6Ox+E69uaVDIdaJ7x/3IY1QHfqKNDPI9CtqOzgD64
	4s7suFjwXw3Mfzqx5KtTq4WujhTRBcyUm2Xy2AGhQ+6p04TB8nLBH4+akEcVoJgzSTNly3N31G/
	DCQNK9OI2sle+eIwdyDTMYGtpBLY9KGLz4+t9K70EKiDtD1X6MjQjnxNwoYCsAG7Y16p0MiZt3n
	fskhcWVTAl4psD7YkucrmUtQKJYif5AyZmMb3DrhWUNUjFgkikHIgeoWSfpgMK4bGiCanejlrJq
	XjOxNBNI1uPm9QBwA==
X-Gm-Gg: AR+sD13RXOOCO9dL8+uu/kHmKYykVFiI042YbrO8tuoicSRpLzexTgcY8TPW+5t5/k9
	Lg67SRRB3pv8TYq6WgHZeK3D3JW87In4TwCPI8qYh3U3b9ybzWFb89WaKzIxGKXAVwA7K673gm+
	O6YoKeF2p5l/rf4sOGJSKG3gdXmMhQbBFwtMQm7e/Y3p94pWPP8tzJqPXVLV1IcHHMFWsiS62S1
	q8B8fcNy9zPtiIEvHC/C3GnVYoRPmUBslcImhd94a5YMSOw+IfAyV2GKb7Z5MuvC9yNNLOw6nzG
	kD6R3NIL+4GlXtb6W5EyKjNnRmhMbRT3Ze2y8lvCAMGK5M+bn0w16/1vjXU/3Z8FJgSg4O17MNG
	YCxUXnfqZuK3JgwUnqfZUJlTycd7K+C2dJW6iWhZ6oMQNzB5hGHyWHQjooPIqwrBlOPybSlxorz
	HiZ2ZJZmKG2XfuMtYAFFZXOaqKcIEgPtPdbQpxSN8=
X-Received: by 2002:a05:6122:3a04:b0:5bf:7f98:9657 with SMTP id 71dfb90a1353d-5c3876a9c6amr1613932e0c.6.1785659958407;
        Sun, 02 Aug 2026 01:39:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c37ed13c3asm863886e0c.8.2026.08.02.01.39.17
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2026 01:39:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8fdace20927so22892126d6.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 01:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785659957; x=1786264757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lR3bhmlqcQbP7TXCmWl9MzUNxiTSwB/0YI3MWW/Lfsk=;
        b=ghZWMDsDeOjPOOgr5PHNqE9ETn5nQ/54xj6btUDhL2P3mdtBx9rLm32dUwy2Q68vuc
         t6x4RYUQSyRFEay4RblOLbhG4NMnuHkMg30oG9m10dtW0DQ11E7vXfRMuBGGyjkV/xg0
         v4y/7QXJhd5haISCTmH3PbAbPpbB3jdoVUFXM=
X-Forwarded-Encrypted: i=1; AHgh+Rqk0pUA6YWCQvImH2E7oaPC7wFUROl9+szEGBwzcxY7L1jVTsQYKFFkoRbkBlmtT6mk9VhQbu8=@vger.kernel.org
X-Received: by 2002:a05:6214:3286:b0:8ee:b05c:596d with SMTP id 6a1803df08f44-9084967def8mr138780436d6.22.1785659956945;
        Sun, 02 Aug 2026 01:39:16 -0700 (PDT)
X-Received: by 2002:a05:6214:3286:b0:8ee:b05c:596d with SMTP id 6a1803df08f44-9084967def8mr138780166d6.22.1785659956516;
        Sun, 02 Aug 2026 01:39:16 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435def8fsm49457956d6.38.2026.08.02.01.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 01:39:15 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Can Peng <pengcan@kylinos.cn>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] wifi: brcmfmac: Set DMA direction for msgbuf packet IDs
Date: Sun,  2 Aug 2026 10:39:01 +0200
Message-ID: <20260802083905.3819981-4-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724092530.674624-1-pengcan@kylinos.cn>
References: <20260724092530.674624-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, 24 Jul 2026 17:25:30 +0800, Can Peng <pengcan@kylinos.cn> wrote:
> brcmf_msgbuf_init_pktids() takes the DMA direction from its callers,
> but never stores it in the packet ID state.  Since the state is zeroed,
> pktids->direction remains DMA_BIDIRECTIONAL for both the TX and RX
> packet ID pools.
>
> All msgbuf packet ID map and unmap paths use pktids->direction.  As a
> result, TX buffers requested with DMA_TO_DEVICE and RX buffers requested
> with DMA_FROM_DEVICE are mapped and unmapped as DMA_BIDIRECTIONAL
> instead.
>
> Store the caller-provided direction when initializing the packet ID
> state.
>
> Fixes: 9a1bb60250d2 ("brcmfmac: Adding msgbuf protocol.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
