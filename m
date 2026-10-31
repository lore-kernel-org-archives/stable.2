Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793411095;
	b=jhHx1zf6MOKsqCSgXRCxJyr/cVrj0JGi3s6k9i+/GPJwtKkaagrUPiA0RPV9Y8Pj7tha
	 ueJuPuzXIVTB+0lTBA5TMd7IQcfJk9qdDbSTclQXPX6rnnTRbqSiM0H7Q5FtPAuSE3bjy
	 Iq65ZKndj3Ri5AGrW+8RIZw7VeyUrFqnYoV0AGEMeh69jV1zMxb56f1TtkuukTZO/Yu4x
	 tLNc5ox/sgTuZ52mGp1vdIiHPIizLbCDHsa2SYxdUwoCNPGQvSvXY2Xa6uXn67Pjeq2uV
	 Lf1J2fPqtxyj4Rb7sCafuJmvwtlPGik9i19ptGu3xtCg8+KvR2IdcS7T1BqtQzZ9zrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793411095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6DRdlfcgy+vOtjFUomjk9wUyOs/aRXJNwlIvfhUtZTw=;
	b=DEVFrJ4l+cqqDIDVvbU7pIIZE6kPIAw3/M225QhUO+HHEGnWbGH4a5r+52avNNzYXrGB
	 sOC4Yivgy66tWE4ILS6etPP/nLhmhOAaY55ncg9N2exgqYEIhrwjjoluKLLJFSwVzAQxp
	 WeZwaJTbeNNokiceBVVpWqkCHb7ZBAPfDKuEyx6zTl++kZcdS3Ln7pc75wyXzSbbfGNjw
	 vABuGk6TvdL/vxDjTsRmKJw0of1dSXWXEHd+ndpSN34rN6cemJ7YKiSQQ5iaWeJ8bHq5X
	 ScrCLP3tIU1wffp3mOADjuGuV6lyyZ1K69oJxvwA9gsCKj8ytcBweUM1xWWzShm2nwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pTSxiqGX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB5606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 01:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22BB5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pTSxiqGX
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso25795e9.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793411093; cv=none;
        d=google.com; s=arc-20260327;
        b=UKUcbLSJ61N06JIV88t1rrFW3Q7xu7IrhwXOt0+Y2L+Miydubl7QY5NHD8d5De3fmG
         4GgHF2YERgffzSj2pkVxj9IGlswfd0TZGY4/J/6UtRS3iT7t/MffeYFlMMTllB66u1U2
         nLVIBANmS9pW99UB1EC4z3p1/rrWY7H7ybrk8Tivx9yyY/IWEdtmnQ+PtXkvJYWX1WF+
         fhfBzBezgEoBVOdQ0pUTnRwLqSVmyVgujaLEU3XMvFFvEwPmS9hkZ39Yn1cPqCz1rQFp
         2y4NAtmWOxsilRzq9Weop3tlv2QDtJ3/OqXC/qjVuzZazqut3p8CXE76BXVeBVUAn7Xv
         N7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6DRdlfcgy+vOtjFUomjk9wUyOs/aRXJNwlIvfhUtZTw=;
        fh=0y0Au2FStsh7xP6HPuzmCrZ6EuNfNk+K7Kxjqw3fwG4=;
        b=o+Vi1Yc60ptKOUb7AfYLlpYUeG6HY4oRd2vifP2kLf8skVRkfkxWyDHvQdACq528AR
         CTakp4UBRgeS8TFRZFoF5bbwXzg3HXjw7mz8/D7WXK4xIEcRuZOpViUBi/TlgH8JkPJl
         5Wz+90ONcPZnNzRfN3KGx5tAmT9D84NFTnOtAovAiQo7L4OosQ0vu4mbH3hJsRcbbtUm
         UfiUcC9wZxZWTI3yBDV+4b6n2LVOd0lQGRO/xug68LSGJsqst3XVZKf0dbbDee0ucTOW
         FTHU7cVOlIWG8IUK7l25piK2qyOLWH16A+/GwqaoYvOP5Hykroq1hpEtUO0h5fPPO4wy
         o26g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793411093; x=1794015893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6DRdlfcgy+vOtjFUomjk9wUyOs/aRXJNwlIvfhUtZTw=;
        b=pTSxiqGXeKnIFTgIRow4invbDjsAiH2zV+0YXZVm+lBwyoVWkFdITWNiMcG7yKVf01
         6cFyb/HbYDwNG2aATzPG6gFN2IRQV92WN5bNaZ5rHzhBF3AV8/qi+goJOPdgjcZ3rUbk
         HwmCt4WleDebWqlk/QaMCYAYOXRMXQdZILHvTpCBCsNIFi/RAAuVK98S2ApdGpxqMP7h
         WpiItQjZE43YaWmQwxk/iuvRBP7zBMLoEqpb2ma3YEiVPHXtaStd19R7h2ZfHRUakUMO
         e/5/bvnZZYIeuorAp4zSgc8GtEI7GmDxY/j902qLCrndoYz2nr4oFlsy+SZlEFxldOEb
         HiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793411093; x=1794015893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DRdlfcgy+vOtjFUomjk9wUyOs/aRXJNwlIvfhUtZTw=;
        b=g8XcaEk5kiLRMztUtHzV/7po2Yk3jAIGcuAecM7FBSytQunWD3dS3rpzMiZE4WFbPI
         9cfxG8hR0t4vBACT65IUZzx/kt63qEpdeKTQUneEh8ROotpkv/YxGnr71LTM7wfMY5it
         055QeaOHtfrGOLFOuZNP8AjN9ISlOYWvpLAWBtw7hLET4wKD77xOT2vGvPGX32VS+YKu
         S0pWFvvy4w+qJ5l9krsQUXm3OjfFWELkN9A/Is6T/Jr/WvozfN82TIvcL/ARN0QxMwhe
         w8um5ZQ/7KFRL5+OMLbGbk++a6YxmZ2MtPOrjtZU6Pa9iJmF3qbOhDtbnMb69C5OiPdF
         Qu5w==
X-Forwarded-Encrypted: i=1; AKwUvBzj4X6dtVIxoHyWHNghKY4HYOIjwjZgtC0uBsukcOB+TQ/Tbn2z1wq+ufzSqWow5XqaewnZmO0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIY+ZQRa1pbD97S50G73Wh6D/pM6GaY5gVJXvdUyMoaivL4pIyJ
	BFTXDk+tt0kQryskjs5BYqagnXqeMdyobGygvY45oICBhpSXxvW+mbe1PKlCH1vVTtBp/gDsbYX
	lYFkVnUD1WQmQ8x9ZM9eOWW4lX1Im3qPjheMcZC6a
X-Gm-Gg: AYBFou1bx16fpaxkqSrQR74OZBCFtu31m+rJPU0w6nif6uPBGeD6SDYeKmJNq38wNvJ
	EoXeFuo2YI4We0oPik4f+pystFNU8P75uAzFGRSCHXQ+fqUOWORIsCUGxJNyeAfzOxWw1RrU0y1
	Ar6bAGxZCuHmidhDrf9xbBsfFpsCBgmo6+oI/YOGST3k4+VeigwO/JB1IzZhy86alH8pIL563tK
	RrlApyiN5CkmFAF5Z9s/0AZ80TIkyVS4GVKw7An78ZlUMDzuOtc6OZu6KssZcRPBKmIXDK5Gt/Y
	7JIVE7JLIR8tcgLsR6FYG8rbYbkiWwEsAMcBrI/0ItDc2UR+NqNivNhoLV+kyqNK5ZkK+bnfqnG
	9MdFLgi94+5CBtsmz99K4L/FLbQWmVueP4PjkZj+WARnccItIWaVmoW8FF7SoBu1sjs78
X-Received: by 2002:a05:600c:a183:b0:4a2:ba3:236e with SMTP id
 5b1f17b1804b1-4aab73beeffmr1795465e9.14.1793411093182; Fri, 30 Oct 2026
 18:44:53 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <18e3697ad6321d35.3137322e32332e3235332e313736.e98e6.0000sendgmr@google.com>
In-Reply-To: <18e3697ad6321d35.3137322e32332e3235332e313736.e98e6.0000sendgmr@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 30 Oct 2026 18:44:41 -0700
X-Gm-Features: AclHuK_pX8cbPFC7CZhySlOC0JMrDf_CX2tXJ-CkUmaeXv5SLhTNx2Dk4KoCGew
Message-ID: <CABdmKX0YRmr0ovk7teNQdXdLmC2LKruT59EQarpDMFcxoOFcQg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: Reject private mappings in system_heap_mmap()
To: Chris Wiseman <chriswiseman@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: John Stultz <jstultz@google.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 1:44=E2=80=AFPM Chris Wiseman <chriswiseman@google.=
com> wrote:
>
> When commit 381295758792 ("dma-buf: system_heap: Rework system heap to
> use sgtables instead of pagelists") stopped using heap_helpers.c and
> added a custom system_heap_mmap(), the check rejecting private mappings
> was dropped.
>
> Other exporters and buffer allocators reject private or copy-on-write
> mappings in their mmap handlers: cma_heap_mmap() and mmap_udmabuf()
> check that VM_SHARED or VM_MAYSHARE is set, and drm_gem_shmem_mmap()
> and ttm_bo_mmap_obj() reject vma_is_cow_mapping(vma).
>
> However, system_heap_mmap() omits this check and calls remap_pfn_range()
> even when userspace requests MAP_PRIVATE with PROT_WRITE. As a result,
> subsequent CPU writes to a MAP_PRIVATE mapping of a system heap buffer
> fault into do_wp_page() -> wp_page_copy(), silently allocating private
> anonymous copy-on-write pages whose writes never reach the underlying
> system heap buffer pages.
>
> Reject non-shared mappings in system_heap_mmap() with -EINVAL to match
> cma_heap_mmap() and mmap_udmabuf().
>
> Fixes: 381295758792 ("dma-buf: system_heap: Rework system heap to use sgt=
ables instead of pagelists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Wiseman <chriswiseman@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

I wonder if we should have this in dma_buf_mmap_internal() though. Any
thoughts Sumit or Christian?
