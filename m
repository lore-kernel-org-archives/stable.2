Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793678976;
	b=axTUWtcHCTs+TndHaMt3I49jDkb2b8Z8/kLhvRS5PiScPUib1jg89n4nCTA85lP3FjoN
	 q0VikuESzCY3Kdulldu8cz1ntXEwoEBWNB0qh2oHh/XyoVQGpFddre9GTmr9B147TbnDu
	 vHM9dqERsZC78z4z0dBoHhHknZ4g3reEUB8rFWAl5+hUXeQta06ROnn2MTafyoQO8Dh8N
	 Zl10/e3lYtQLLN3PmDJ5r4Q+F2y0+mZEgisFpUI6aIMgQe1AySPzWDkOj9TiKTEBJMSTq
	 UzBBDwn5z6M6srb1m42a06SmtwNR1G5JYCReHLs5pTyas9mkqktKNMZX6Wq44+gvpDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793678976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4iC8L9iLkA3pQkFSYs2y6EQR6cAV4OUXqfYAj5Wz1OA=;
	b=FxSmffJebllN5fV2X/A/QwwhsK2IbaHOUo5kSMOGH5E34QkneLA5rgDEeV5viBqZfQ5i
	 2reaUf6PygYjPCXo8Pfb8s6BvD/BCmNJUVy77qbNJUOZ0CUGDtwVYYVMQpXVufIYlHznn
	 6EKMMvXVCCbisCRMeZKkILkXPub4zqHUjriWuIYTDFlEFm4s5Y4qDuBTxVO/e3Lzp0D/r
	 ckprGMIcFZ0f53Vu8+0gfXRuoFZEeMiBzsVTEsMly25/reCv0WWjMj7LdRKsJcEf3/3xp
	 +Wwj04OJFsMAGWcdINX71sklduWlD4Mj6HXQeFUsveaaU3+VVHh2P6usgoOQFgzniTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O9Oe40HC;
	arc=fail smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03754606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 04:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03754606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O9Oe40HC
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab3b29a210so3137741fa.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 20:09:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793678974; cv=none;
        d=google.com; s=arc-20260327;
        b=k2ihxkwAp/+U1RWNFlgvYTtVer8aXJ8Bfh+lPoIYRHg5mKCX+6+gM5QyL1EPOEA40j
         9XzAf9lFgyC31TkncDLh2e2HKkSkiXnYLKfaTbuZg9dWiMxLgz2nSSGxBVJq8BrbdF0C
         ikjXbU9ZjTA5JxMAnBHLcV8j5UU7Yw3jdE0wMtA1VPVgDMuWPIQeYQq3KzLriysrNC9A
         pSd+qAtU73ZTLzhcALDpWRrCy/98lFBIxwy/XPpVFmEyRpPtl1JdRN4vNhzKO8F2w3G0
         A/kU7t80gQPyFWlzVO+PJ8YCCaRVZUrXco4TQcBpDBzeZcUo3sf4kYEF3fHjFcbUwEi8
         G2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4iC8L9iLkA3pQkFSYs2y6EQR6cAV4OUXqfYAj5Wz1OA=;
        fh=NMXoWgctxpUR00TVB44RZotmkeu0EySa/MAlZb/QgPI=;
        b=GVgVoFFGWcX41PFuWCHt7yrznuwXibU4DTgjhPbtWa2evkrtwTw33BUG4D7EOn5yhI
         WcGZdj/8J7Rn+/vDJOJhdtiug0potvWhuUeDLbB0VDbmboDtsjrem6OhmESCIkLJv0jW
         STUwR6VFGB8FgVtAGAB7Zpw8v1I7woi1SKATUA4z5IvvxaIBpJMMcD9FM1kGzj2x6Pom
         RybHfkdFyIXJk1Ionqa374k89/br/Qy6ubMrCTdqNnUvHrMqXBEupdFll7U/H0LhEzp2
         rq7mp3kdmu2eTJnO9hd0gIBuOjD+EoXFT/3mLlRbrSsGIJFug0+2uB1NNDTWJkBJtpR6
         UF1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793678974; x=1794283774; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4iC8L9iLkA3pQkFSYs2y6EQR6cAV4OUXqfYAj5Wz1OA=;
        b=O9Oe40HCGOmRZfS9ArojsTOkWRogCLAA8RxP7OvgGHe4QdWC8+f/a/UhQiCIqrzFSR
         Zf9+JCBgW0u3La0oKPOF3Rm3Uo1kkRh986BsRwuHjs0+kuh89j5xdGlurOo3gPMyc4DT
         eQdNNZj8ulP6qpC2nI68ljZ9XYYIret2oD+U6FvbOdoNw4JucvZaChg+qPE+GY08uTXo
         8vZK1h0MpZlpqlwQFPeytDtE1nuBIwwFY62FfSeZ7gLvq4m72c3Q2bpGaL04KSlALTTo
         j7SvmBVy23rklLq9v5dKeZwEDM7ar4hvp+hQ03ssTzFhdy5tOEZDivhWCTrB87kxpjK2
         K5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793678974; x=1794283774;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4iC8L9iLkA3pQkFSYs2y6EQR6cAV4OUXqfYAj5Wz1OA=;
        b=yrkCUt4a9fhPoxQQ6lHrjz4k1Pekw2wcboUgWuMXHoBAtupur9qAx47E6ddhypxMUf
         ABoqxd+FmeYeHP215IojtU6sZngR3JPuoEbCCaYzwe3FZR42yxB4c3WDircxXceHEKQu
         GFkgE4ysoW4CYWKu23XwB1UbFdPOXBJmZq60GkGt0Ssq4onYVQ0B4xWvCvcDp5X8F7lT
         lZwvFwIdjhSBNXlBxO4DDaNm50ZCiynMBdQi/0dxwraOtzTc6A27F4gWyP1ki7nxUtie
         +zm8eZ87hBtUoiPMpJ/RPV2HSyIi6KNhVpLqFOHoqrKBvrVSPyMH+0A2lH7fItfdG8YZ
         cHvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGugSEnniEB+5/Z10Urr0CLJIUedlA/pUC9U1+vA6D5J8q9tyaSISu6ktLdbbCGSMctzkcJnY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DOwj+OJY760GF29kF4sbmhuIPfqp1FIXWp6P0P59S3GDnI4dW
	gaiTV+cK9Byb9b2J1qrhCLMQfPza/4nm7b6ZwyHMu0CoMiFGgFLfGPvpWtAlRfIw9FwnpuobX4e
	kwB3uy7r3DZROr+sl/bOv6gR27COQunc=
X-Gm-Gg: AYBFou35tt5ZYX7IY2hdOz5WYam0pp1r1q8AnAc8qkkzyYpT0Ek/umfDU+FX6N2TcFk
	zXDUVMcdtuSblRSsMPspuelM7P+tiZeHk8WyPfAH86IMj+ZJbIfSzeZQsjdMXD38yExzhYKppIZ
	CbnchIPfPHlIhpzyyUUQeKTlj283XalFyyZ+jv9cXEbWS9ckQ5cFJVbbFFYfnr5mJ90sN+4YKh2
	Lc0bAuYpcAWVDtqEeqqdiyjSnEyGdOefihfRjXy9hoq5Gvl65TuEEz8urMYUWUTaG9vIta4BQZb
	/lDSS4YTPdvxZ/T5xYnilXb5646skPPRsTOuQub3XDO5QZeW20LtwzFH2oq2mHLTeTFY1rXCzkK
	d0gtO3AcPPvw+xT8etvvHrJuQmRQvXXik4RAb
X-Received: by 2002:a2e:a99e:0:b0:3ab:40b1:c4a4 with SMTP id
 38308e7fff4ca-3aca57eb24cmr35150011fa.14.1793678973932; Mon, 02 Nov 2026
 20:09:33 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260926041943.1124650-1-oss.patchbox@gmail.com> <aujDcTjvpWbIJ8wm@p14s>
In-Reply-To: <aujDcTjvpWbIJ8wm@p14s>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 2 Nov 2026 23:09:21 -0500
X-Gm-Features: AclHuK_exdT8gjqeTXLCJXxzkdg7czt6b3ePUopm67pTCoxxb-Of6GIPUcH4Ph8
Message-ID: <CAGG=RgBW9O7PfwaDPY_jYkE876EALQ5JsSnP4=7YubZg1XvwJw@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: virtio: Synchronize virtqueue teardown
 with rproc_vq_interrupt()
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 12:08, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> This patch doesn't apply on rproc-next - please rebase and resent.

Thanks for checking, Mathieu. It no longer applies because the same
race has already been fixed by commit ffe14d610cb0 ("remoteproc:
implement synchronize_cbs() for virtio devices"), which is in v7.4-rc1.
Therefore, this patch should be dropped.

Thanks,
Yuho
