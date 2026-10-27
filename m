Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102807;
	b=cOu/2teGwFYobGh2/OfH9dOIPazq1TsbPxbJqnJ2uORQjyotBZjE1p1vMYRyreJJKfo2
	 h5ZrG7C4b/hbwODhmJ+jj5Fyc+H2P1jaDB2IX8JkD+1zeZGAa4yQh0y/4I2oY4UOQa6QE
	 t2hdgMNGlsrfGjnEU6fj+JRgvf3woaQ67H4PC8hNAoSsE6ezdfaD8Llytolm9hhPTZO5C
	 2F6uA5SmPspIcuZinDcBx1xXcLpSuX7Gux1uRmRQ9Iw7uZ2AJZGOZUCGW8YCk6kzzOBRr
	 qL0lRQk5ZOpFFS8o9i4ecKaFRRp8IVG5S6YuHUzxZfiIecWsmVpjr7IaGTWLTESAbJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102807;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
	b=xsKER7p9EzGvmTnQzoSjGpPWqnLm0FM3fTKQy5zTAGu2c9Xj1B57hJWTpoWPZpudNRVU
	 KY7OeH/HxlLLJJAju2sNT0V0E6uUQbBq6Mylas8W6bVQA3HZWdOmPUnpSfavUwDIvumZU
	 huHynRD1mXqHQzsxmphgTsB3AJMyTl9xfkBBu0tOYProNsv/zrOG3L2N++0BN7HDlqkgM
	 QlBW4vhpn5jrSVwA8SLlPC5UjCKeARmb0QOYNDZ0/0ojiRDIRmId9oKnFcHxdk3LhN4It
	 FwXoRDaSe9fSLM32L7Qj5ZaaEM18GrmIQZttZTUBWQsA6mFhAP1hcarmYSgfF4Cx94Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8wf6H+A;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RXPeLHkn;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0D606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD0D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8wf6H+A;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RXPeLHkn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793102806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
	b=C8wf6H+AYeIBEpNoYU9zy+75ULNP/v8GQ+JI8YeV0z07n1Y+A6DfJJMoiLDsRAkdopP1nm
	mDDqcgNZtSs6bwlt30sfqIwMVo1hpfZjo5uyPypqxGriI9Ja/hmZFjb/UVoEAAKB0hRrO2
	t5vzy8hgE7y5Sd8a2kTPo8g1uS2cPCU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-YdnLd-gNNd6NAOBrTjuTIg-1; Tue, 27 Oct 2026 08:06:45 -0400
X-MC-Unique: YdnLd-gNNd6NAOBrTjuTIg-1
X-Mimecast-MFC-AGG-ID: YdnLd-gNNd6NAOBrTjuTIg_1793102804
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so20434135e9.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 05:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793102804; x=1793707604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
        b=RXPeLHknvGdIZGmmQOg9CAJu4ZQtCgOy3X3PowC0Os1DVS3R3aAap0u/wm9XlHjjU0
         HM7EnBYUihFyrhh1OeTuQm1swnYuwj1Fq5vCpeTtiKUZayZvLx2FW2nE2iCCCEN8uLZS
         rm/XjIP89WmKbQEYcS1deWV+VA4VJRJYm+1PAToAyM5Brkq2jjR8JxmcLQ4Z7AVNuVBl
         IHAFFIrp8q1UELTYZ1iRU7F0s+8NonqxUEMQqQIT9XKQIOqDtIAL9X6LF91LY+mc2I4L
         bl2+O7sPWb1g0mhON7TtdHK9xkW+VDA6Y7xxWXbXmAA0J1q8u4nHXpudB6pPMGTKXTzt
         FJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102804; x=1793707604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8KMQj2HsPBF8Jjs/G4X6DPysUQ80f4vvkU0TZL7PsU=;
        b=1oug1naiI5EDFD63uGNaEhVgH1B1EGhe2MhvLapi3fQfVruZ0nBqQyFlCrX2F73puN
         nDuae41qk6IZ3Jrhu01fAdAHXfa6DDTfXtjWXo70zBfTy+cyAowMDyjaxBlsh+IEu4CF
         4XkJZJ8ogRdXTEwKQ9ljteVcvMkGK1Fa1aHCQX5ExC/XSm2i70U8nrXwsHNTZYD6By9q
         jkUkcmjXmCuXzVAzK7IqiVniKMR5IPYdEeS5pmbirI04ZiYULP3/8LsW3LXCmc4S08Xw
         /ry4U3RLsb/nc1EvmpIo4VjqNEgooKf3uMHx2hGT38v20pD50p1nRJ+HTUl6GyBfixQe
         wxnA==
X-Forwarded-Encrypted: i=1; AKwUvBx+2jj/MGvBjxVnL5UcQYxnjQjV+x6IcqC7TPP3rABID3nSfoxpk+pO6xft45RBHGUmXsswiXU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ+AnEZLuWONCUK+Aso7JYCQf1NILT8nS+GHTXxpuFh8EXcE0j
	6O54skB1hk/Lc7Xzs4fJ709fPcR/bXIG9nOUW8FcrkEPnKkGafwBhj8P3NXYFlb7kbiG8L542Ur
	ts0fXxk/as+D9lvlw332yjxbMusB6YmawKqM2MqVjZC+m1KYXOyjNn7olAQ==
X-Gm-Gg: AYBFou0dlKTYbMcre2uYrSJaHaJptoxBJiaiwv2Y04dtWr+EetO4aYCfCen1Rz/kZDo
	LD1Y/ycVPJzcHpOcqkt6eH81lYnEc7d2EK2GHtJsf05mbPt9VWSo9CG5B/DM4t8Vt+nLesCfEhJ
	VwbeGXw8ayF4nmqanEN+ky6bnoMQ+DUTXQ+c7Z40P7POaNIpCCommeAHtfIevTzAUE6Zt1/x9/Y
	TUlFPf8JzrtzFODGQaQL/iBs0tYZ4PP0sEO/Uzr6CQZTa4XmoYWkUvcu1e3RAHQwpc4qgh/wyPi
	pCakYGA+snw2pj7LPUue+2o/QgJpp69hSJcgY513fJ047GRDzr4e61pF7rWF6EcqTTZK7zfqq7D
	xQFTKNQb9Fdy3sHQ5MQPaYf/XISc3oKSQDtYmv+rFQ3CvxeJZinD8bC4wjHX5X6xiFptjwukgWQ
	==
X-Received: by 2002:a05:600c:608e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4a642ccc70emr103979865e9.11.1793102803692;
        Tue, 27 Oct 2026 05:06:43 -0700 (PDT)
X-Received: by 2002:a05:600c:608e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4a642ccc70emr103979245e9.11.1793102803120;
        Tue, 27 Oct 2026 05:06:43 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d9280sm259748385e9.13.2026.10.27.05.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 05:06:42 -0700 (PDT)
Message-ID: <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>
Date: Tue, 27 Oct 2026 13:06:41 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
To: Lianjie Wang <karin0.zst@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261022182710.2055771-1-karin0.zst@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 20:26, Lianjie Wang wrote:
> __virtnet_get_hw_stats() passes the vq_index of each record in the
> device's statistics reply to virtnet_fill_stats() without checking it,
> so the device decides where the driver writes the counters.
> 
> For ethtool -S, virtnet_fill_stats() uses vq_index as an offset into the
> output array, which the ethtool core sized for curr_queue_pairs. A
> record with the vq_index of a higher queue makes the driver write past
> the end of the array.
> 
> For the per-queue netlink stats, the queue type also comes from
> vq_index. A receive record in reply to a request for a transmit queue
> makes the driver fill the struct netdev_queue_stats_tx on the stack as
> if it were a struct netdev_queue_stats_rx. If the device offers
> VIRTIO_NET_STATS_TYPE_RX_SPEED, this writes one counter to the eight
> bytes after the tx struct.
> 
> Fix this by rejecting the reply when the vq_index of a record lies
> outside the range of queues the request asked about.
> 
> Claude Opus 5.5 was used to review the driver code and draft this patch.
> To reproduce, the virtio-net device in QEMU was modified to answer an
> ethtool -S request on a one-pair device with a record for a receive
> queue the device does not have. On an unmodified kernel, KASAN then
> reports a write past the ethtool -S output array. With this patch, the
> driver rejects the same reply with "Failed to get hw stats.", a
> well-formed reply fills the statistics as before, and the
> drivers/net/stats.py selftest passes.
> 
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Fixes: d888f04c09bb ("virtio-net: support queue stat")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <karin0.zst@gmail.com>
> ---
>   drivers/net/virtio_net.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index daab43ac92ce4..0473fa9947858 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4955,7 +4955,8 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
>   static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>   				  struct virtnet_stats_ctx *ctx,
>   				  struct virtio_net_ctrl_queue_stats *req,
> -				  int req_size, void *reply, int res_size)
> +				  int req_size, void *reply, int res_size,
> +				  int first_vq, int last_vq, bool enable_cvq)
>   {
>   	struct virtio_net_stats_reply_hdr *hdr;
>   	struct scatterlist sgs_in, sgs_out;
> @@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>   	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
>   		hdr = p;
>   		qid = le16_to_cpu(hdr->vq_index);
> +		if ((qid < first_vq || qid > last_vq) &&
> +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> +			return -EINVAL;

I think the above check could be simplified to:
		if (qid < first_vq || qid > last_vq)
			return -EINVAL;

squashing the following in virtnet_get_hw_stats():

-       if (enable_cvq)
+       if (enable_cvq) {
                 virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
+               last_vq++;
+       }

(likely with some meaningful comment).

/P

