Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698782;
	b=f9X3Qt5QdKNmlrVsengNcsGSs9iTlkp6Xc4OHm8EL56691qtxjs1DIUcyZhLbG7FAOgG
	 H/f363I+PspRFb6O8dqMmoFZeDR5GetNV/GNTfj2xMsRmDTOWCan4vIupQzjL+cFgjiwf
	 AFKg/5fJq+E9mHKjP2l7Y7jd6E2Jmfy8wiqQ45RfweDCCVDRggzRjLIoNdZpK5scVNhHG
	 bxye6FKa+/eI8J/EgYKVNTcgT+auRB+gAQM/t/e5//7jlWvq+kcrvkUOTlb9apJwjwUZv
	 iilMKR6CXVqQxzhdhDA7ZN0HxGhbte308XMMl1PYxs6Dp+4E1/lghyG8FbSR7TgvvzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698782;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yWLJ8orxFraHmiLygxrECrAy0DeQv5sxiwR28si0eUs=;
	b=z8Ak9RJ703TOO2rFGuCUHX2G46EcnQFa4kUdunqsbpLgiPIotcyLzG5lR1Tfd5NuZpo5
	 BR41bTCMF4ks/tKVWIZQC78FR+b7w80fH6HrTDHYA/z/qdP8u6t3kjRhRc0wDZ1UcP+Fu
	 m+KngLrSeHvDGL0cOsGNbyvyKVdMAuE6HTIiC/P9OGQp8ZbZ5UB034L7tIw/dLtmSOLKB
	 Gytei/MF/MxclmH2laHIDlT+CN1YNgu7CmpXzYDqwY95dfcOXdmh82hJIa8gdmZfg8M91
	 8oxjvqskwY6b33sLDGAaCok15B09BgTdlRHkpeuT4bHs8514Xj9mv/jvCinrfoHvpKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GCSn7L3H;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gBiGVjF2;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297B606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D297B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GCSn7L3H;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gBiGVjF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793698780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yWLJ8orxFraHmiLygxrECrAy0DeQv5sxiwR28si0eUs=;
	b=GCSn7L3HQMnR3VbQsvN8PtZAzNf9SenMWmQPQlYfjRildQjy1jCVN/5mlAEu0ZSKss/OPE
	By1L9Y92VGn8ManQVqYG4t+aYAHFKdxr7PbPvKScn+VvHh1cTbkx3ObgItRzLHrnMT/LMA
	waLfewiWk3GmM63qB/8/VY9iLYag23Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-2RcLUYmEOMaMAU8VoZn3AA-1; Tue, 03 Nov 2026 04:39:39 -0500
X-MC-Unique: 2RcLUYmEOMaMAU8VoZn3AA-1
X-Mimecast-MFC-AGG-ID: 2RcLUYmEOMaMAU8VoZn3AA_1793698778
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so39529725e9.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793698778; x=1794303578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yWLJ8orxFraHmiLygxrECrAy0DeQv5sxiwR28si0eUs=;
        b=gBiGVjF2aiIWe9f5oupJu7HR2NwbumoKMBRc9+DzB+kWP8DVG7Zoq9Wi+IRxAblHQX
         99YmWCtfZ32gC+uHhQ/+EzIzMA5ZZe5IHoTBbxt0LE9P9hAVtD5F3K1zmYXNElv+Wtx5
         nTuXogfUoA1lrIF4eQns4lt+rF8UvnLTyD35y4+amaKrO43IkJW+U8RUaKsvRll2ad0p
         0C3LI1RkOixH+XlU2hUqk+cMBv5v9eD4DPbuuXkTiGr3PF5CKsEOs/QkDdsUIVdv2Ddm
         D9Qcbfk9z0OXSmElAwRq57jxZrcBUbrVS5VkgqxDc2yExDI8K+TaUOsa3KAaq+X4DKjk
         a42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793698778; x=1794303578;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWLJ8orxFraHmiLygxrECrAy0DeQv5sxiwR28si0eUs=;
        b=j0CIUxTcM2e4vPRD2iywpQ1xXoZNqmzGWSf27w4benOO1NAQ/F4mQ/Dwm0428PS/8E
         utjH6z6F8OkVFsnxlI9tLp24x2yWvtsemTmfmsk8HMuHF5Kh20ofNF09Z7kw8DdQY2cv
         /LTqN87hMGQ8G+sbHDCMvCRsJU0c4QhJ32p5ZZK80EYgQp56oGNX9A/h/LtFDxGUUEUg
         ZRr1SCilaICFQ+K/oMx9bbO3qM8tvIK3TlgHR4nQ0c8fW5aDOIGzUTjQv7G2ffMI+9jZ
         cdyKLcbq1PxITkwZ1eeMupoSH9zleFUG/YAGw5C3zDakcHwDfh9FTvKzBgY+hmNGZ4Ta
         HbjA==
X-Forwarded-Encrypted: i=1; AKwUvBxKAJY/uOpsEoI+mkbsDyJ54HGLynoszI+ptHC0ewHNIX45xHFrAZvj9ikrpkkJL3WHUinLDsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/t7qzwAo5MvWRqyiriK182WEda4guRyQ19uVJBvpjbi9iOBBpt
	iaq2PfWcUFlhfjRryok/oZ8E3SA4bnlLEzPXVIn//uBjGBJugt29GZ96hPtJzyySqCv/vBlh+GU
	jophhx2b3/SRSiYOIL+JlLESJ+NxbJF98+fWls9S3xtF6QcByB7HamGr7Cw==
X-Gm-Gg: AYBFou247+nYCxorvy+kwSjQI47fxlmMHShpV6+3g5/lDDEeir1zVbuqz+cP4RyyEnD
	BfqIPC/v/E55QbIsxqCCorLWDu5IbPdSRTAI0M05bHCGF4NEfI4dwx/52B+YoXKKDmGAzjYIjjb
	ABjvAiXLyiNSBdlmHJ579g8R5Oy9hOMkL1enCd51athHXvwxbrJn9VvmgobMcdH/M0hMlihrfR2
	okK7yOtTm3/Lbf+mYW+ucUWIfW98pv0/mFv39whI9Z5TzNbCAsqaxLPX02vLwX2Fri2r9GfMToI
	G7+Rq1UqRSpB9x1KUECudrcVtY+Tlyi2BBy7Q7M7Bh+Kb2804Ogg1ngKA6+qBGCX+lJwsznKi/l
	N4H3cDgcSOP5frpZCJaM/2+sU7F1KUaAxzcTYwOI2gg==
X-Received: by 2002:a05:600d:6508:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b0bc65ba2bmr112608935e9.35.1793698778157;
        Tue, 03 Nov 2026 01:39:38 -0800 (PST)
X-Received: by 2002:a05:600d:6508:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b0bc65ba2bmr112608485e9.35.1793698777670;
        Tue, 03 Nov 2026 01:39:37 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm190245005e9.4.2026.11.03.01.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:39:34 -0800 (PST)
Date: Tue, 3 Nov 2026 04:39:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: amit@kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] virtio: console: check the control packet size before
 parsing it
Message-ID: <20261103043238-mutt-send-email-mst@kernel.org>
References: <20261103084156.426810-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261103084156.426810-1-zhugl3@xiaopeng.com>

On Tue, Nov 03, 2026 at 04:41:56PM +0800, Guanglei Zhu wrote:
> The control queue handler hands whatever the host wrote to the
> control queue straight to the parser:
> 
> 	buf->len = min_t(size_t, len, buf->size);
> 	buf->offset = 0;
> 
> 	handle_control_message(vq->vdev, portdev, buf);
> 
> handle_control_message() casts the start of the buffer to struct
> virtio_console_control and reads the id, event and value fields
> without ever looking at buf->len. A control packet shorter than the
> structure

That's a broken device.

> makes the driver parse whatever bytes were left in the
> reused buffer as a control header, and the uninitialized event then
> drives the port state machine.

So what?

> Drop control packets that are too short to hold the header.

And then what?

> Fixes: 17634ba25544 ("virtio: console: Add a new MULTIPORT feature, support for generic ports")
> Cc: stable@vger.kernel.org

Not clear why this is needed on stable.


> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/char/virtio_console.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 019bcae81af5..5e2a4403dbf8 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1597,6 +1597,12 @@ static void handle_control_message(struct virtio_device *vdev,
>  	size_t name_size;
>  	int err;
>  
> +	if (buf->len < sizeof(struct virtio_console_control)) {
> +		dev_dbg(&portdev->vdev->dev,
> +			"Invalid control packet size %zu\n", buf->len);
> +		return;
> +	}
> +
>  	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
>  
>  	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
> -- 
> 2.50.1
> 

