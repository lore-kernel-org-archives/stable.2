Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B6F34752E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054236; cv=none; b=FhY0mqC1jSvMXmzwnxv107PBKHyL2st0eWBQXrxPnzVZH6MZPsf3eyqnH+LvQvpsvu3lKMbbOmFDmJUx1XdlWlQmYvcnVBd91K86bOFAS6clJn4mgOdn2pIpCjVhXxGdjlLKBIfPloDsZuEC1zi4GrskD9xpvp5zfcY4VaNxXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054236; c=relaxed/simple;
	bh=cJ8LYFjzTM0muHUyVe+/MCjNYgwZO4f/9W0uzAKmrqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUc10j3Xp0bE1J4Gczyieyq8ZFns4QV1uJzTtMSs5ulW5SZY+wsTbih3Br2g5TeBQcuRNXpdaQcyAqVCpFqaCsNuruzHUqduMf93enmOYN8fpHjliC308Fvg8nyRF7o8XD6pn8SAKXbzgL6XtpDLirroSCvNZ7Ac0D67j011tys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoNLgpnW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzjpVvyL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoNLgpnW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzjpVvyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790054232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbjiIJwGtn50Qj/9ch4dBHBIATv1QNB49rzuobzPxM4=;
	b=VoNLgpnW0iP+P6i+oUby4bEh7uDA0nzjUFsPeVMuA3JBw8KBCv0sBJCxXnV8YMKx5q1bne
	dzTrfVbTZrvKAmz4u8pqtPmW+91zMNblpiQq8WKdcnEleN0BjAnwGb2u86+1GZXVfngDMr
	hTd6kaE4sLtsHrEVwR+pXNf/+cq73s4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-PdMR2A4FM4-40M-Wj7W8jw-1; Tue, 22 Sep 2026 01:17:11 -0400
X-MC-Unique: PdMR2A4FM4-40M-Wj7W8jw-1
X-Mimecast-MFC-AGG-ID: PdMR2A4FM4-40M-Wj7W8jw_1790054230
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49fcd86b8d3so25137085e9.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790054230; x=1790659030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZbjiIJwGtn50Qj/9ch4dBHBIATv1QNB49rzuobzPxM4=;
        b=DzjpVvyLQbK+J0ImsSVj1PjansFk16/JqKP32w3PPrU1bINsbMQmdK7+SyfZffEk/J
         t6tdkMzKdW/y8ZqJB9r96rLfk64KXhmRW/x1JZAAq9dTQLUsr4zx31Zoq6qVTbiDV1Ik
         FoTHXrXb3Wi6v+PgYFvSonlxFJcemzh8pq1b8rua2ZFGTNbs09ueCtEY+HVmw6mP5YGc
         H6jE9YI4VItFK/lFU3JuiG5Z+BTUI5UTAJ5g88i+VWTg/nBp5ssquVr77nuTN1Jv39r7
         2GtUib+sNsnt8POCZuOzZzLCWCNJvMgGDfgRLyw+eIiNVa09rFXzqmEQQVZ7yJnoCZ+l
         Bn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790054230; x=1790659030;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbjiIJwGtn50Qj/9ch4dBHBIATv1QNB49rzuobzPxM4=;
        b=OakfM5YBm8IjSpJJ7839ec+3JklRdRdzNkXC+Pz8mZbHmO9m4hAgZcxgxS62T7wzg0
         PUvllc6+qnyC29nXR4kqjeYcRJ97/DXaw4MsM+vYMu/J7EecyBq8tZgL3YRMGIYtdXBz
         oIW0Sa8T2/VBK4zlN024CJVK8USLyoR7Zg4ePhqbks/KP4RCDsnjNuyQbWALV1mkcaIO
         ZrQxJGiPm/665wiImjw4ijnw2aZC4nLwa6HLP9FDbMMq+I9olbnwbJVSt16oSnkIf1GB
         3IeIfW3TGWmYDEPB5nhzj2zAr2eW6Q+xvuMCr2McxOEGTXj9dYUd2CU7+DexUJewbAqu
         Z0wg==
X-Forwarded-Encrypted: i=1; AKwUvBxzpwPw9uI/YKUtKrl8KFv+IkKc+JwUGCzlj9TQhH/c40sAcjDcJe5mwDWD8PrdJ1rEcgTiBKk=@vger.kernel.org
X-Gm-Message-State: AFuF++k/bfg3Ai1o5KnaEKWPUBry+UWlxdtvcZxk88I+6MH12BB3sGMq
	trHbHD4dwkBch3eR4mY7VxLsLLfCNtCRpYab2EapDX0DdbWf0CFf/BdF/5JfQSsgqoKurxnKJu6
	8USPCC+i+BqiW3CLu9GuHGv+cNHRLD8hs2x1Dr6QVeW166Dq+pLJUEhmwmA==
X-Gm-Gg: AYBFou0deJp0yLfTd9QicnUBUapS6LBYX3GKj93a5s3L34vySRxlbAJiGnKSiuE21as
	I8PMT+IBwQblOvyR90DDLrwd6v7ZZcINs0fW2mUJs+7ceorHmQqyFhSygDDkWAvI6DMFbzb4oMK
	yYPxw0BDL/U8NStWstLuxceizwdi1CgzHZnv5VfUc8ggtJr8zbkeXTCRCTaagiKlRw4WmqcHoBr
	5XtVcMPZmxAkiCEpbo1xjoDoMYTR6kCqK5WcBOdKXuqHXY4HtmFFtZZFdtrFGcfrk9d53CimVO5
	HcAGf35RLJ3cuWeJFu3a7d1UyhI5P/QZgR9Adh4ZUdyO44gli9pn6Wqoh9pxPxlOZX729FeAyyT
	n0kNrVgwy1Ok9XSjgUxPmk6U=
X-Received: by 2002:a05:600c:4f41:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49fc56db975mr194430325e9.5.1790054230055;
        Mon, 21 Sep 2026 22:17:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4f41:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49fc56db975mr194430075e9.5.1790054229668;
        Mon, 21 Sep 2026 22:17:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cc05f9sm44650175e9.3.2026.09.21.22.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:17:09 -0700 (PDT)
Date: Tue, 22 Sep 2026 01:17:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	linux-i2c@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] Revert "i2c: virtio: Avoid hang by using
 interruptible completion wait"
Message-ID: <20260922011619-mutt-send-email-mst@kernel.org>
References: <20260922050251.403857-1-oss.patchbox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922050251.403857-1-oss.patchbox@gmail.com>

On Tue, Sep 22, 2026 at 01:02:51AM -0400, Yuho Choi wrote:
> This reverts commit a663b3c47ab10f66130818cf94eb59c971541c3f.
> 
> When a transfer is interrupted by a signal, virtio_i2c_complete_reqs()
> stops waiting for the remaining requests and virtio_i2c_xfer() frees the
> reqs array while the virtqueue descriptors are still in flight on the
> device.  The backend can then write into freed memory, and
> virtio_i2c_msg_done() calls complete() on already-freed requests.
> 
> Commit 84e1d0bf1d71 ("i2c: virtio: disable timeout handling") removed the
> exact same failure mode caused by timeouts, concluding there was no simple
> fix because the buffers must be held until the device returns them.  A hang
> due to an unresponsive backend is preferable to guest memory corruption.
> Restore the unconditional wait until request lifetime can be decoupled
> safely.
> 
> Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> A proper interruptible wait requires refcounting requests and bounce
> buffering to hold memory until the backend returns descriptors (similar
> to virtio_rtc/virtio_pmem). Since that is a larger rework unsuitable for
> stable, revert to uninterruptible wait first.

another way is ring or device reset, if that is acceptable.

>  drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 5da6fef92bec3..581e55b5c65ba 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -116,16 +116,15 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  	for (i = 0; i < num; i++) {
>  		struct virtio_i2c_req *req = &reqs[i];
>  
> -		if (!failed) {
> -			if (wait_for_completion_interruptible(&req->completion))
> -				failed = true;
> -			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> -				failed = true;
> -			else
> -				j++;
> -		}
> +		wait_for_completion(&req->completion);
> +
> +		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> +			failed = true;
>  
>  		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> +
> +		if (!failed)
> +			j++;
>  	}
>  
>  	return j;
> 
> base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
> -- 
> 2.43.0

