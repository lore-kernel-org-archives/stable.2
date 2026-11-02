Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640675;
	b=332xNILR7eaSxf2YSSyTdJ75yG0NkDhA5Ykgk0srw+Y3DtLZ3USKjmWZz5wrC9NgkJLS
	 BEO0jMkuJTI2mG/GdpGUf6mlEU9v+kEr6HWY0AOxMafcIZlkkncMQ+uuOBLW9LuZs4ypW
	 KbfDqGsRH0ErBGUr3K3IX2q1O3JCutNdEjq2Yyhx2HDOLrxonPKfYUbZ2bEHeOspcFVDZ
	 0c2wRNTUaqx+CUusCn2iG01mwxXLWGBfd9SD/s+DyAEo7WJvp1olnzATfH7GrSEmrDxHW
	 +JJrEXbnR2qyn8UqhGbqe6aj/BptqKGVZs0BCcJ56TCWpFARdprJDcFEoBKL33zeArQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640675;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
	b=gf4WQQD4g69F4TYiANT0Ituq3x7jpc20t2u50ZwRfoFdCZJTX0qo6Gai1bRtGn1Y6GkZ
	 9iBVbiOhlWcvJw0uwOvxQmrHrNPCSXDBFwMyiUEnm9NaUuno0d/BGk15NT2eFllH3YMtK
	 4mTlOcXCWMT94fVZs4DsI5bJ6qxzZDNBEbSRtd7ObfT0L3u+auBXMbWSh+MnpaxAOqpeU
	 DpiU1JRzO2m7mBNxsJR0/k304t/ltWWuePrtvCkeM1ibANiAf0JJMc0npmCrsA7S7A49u
	 uA9erjnt+U1Ekr7vlswpceT7c7Ydzl7fTG5euvn7PswzM1y1Fc/+7tVG/cHLcPa64Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="bFkb/vMW";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nDV52+Pg;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660B606A595
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B660B606A595
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bFkb/vMW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nDV52+Pg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793640670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
	b=bFkb/vMWCT3rJIsDMZi/KtU4jyU/vegGZHH3VoXOG014BVkMXzKSOLF0bVIsM1D2IZ+5Yu
	D+oUcjUz6ndyVWm+naP1ASrHGve9KCwn+vaGi3jVeyDuONmFd48ymp9nl8+8lHJ7FzFdIR
	DnRyU8ERNI6+nniuN3tMn11VmfFju10=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-rRiAa1wIMbCOFoHDKPEw2A-1; Mon, 02 Nov 2026 12:31:03 -0500
X-MC-Unique: rRiAa1wIMbCOFoHDKPEw2A-1
X-Mimecast-MFC-AGG-ID: rRiAa1wIMbCOFoHDKPEw2A_1793640662
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso31022095e9.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793640662; x=1794245462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
        b=nDV52+Pg5PDNA7V1QVQKM2uUoSBEq5/BhVNKgQQJ0jEhyHgyBTW3BdAc6ZdiJsVv+M
         cJ382PbjYgAWqBRtjiDYCtAqHaV7ygbLyJSEZF9f+Zt7Yu7YNASwaXvmYwbqaFFZQHzh
         Hpg/v2K5MYoGB35N66S2kl5yIFgHuQBPtmtjd9hKeP/zAas5S1Now+bywd0l1DCHZOkE
         piikiCezukkgW16O2vEVHcn23DQQbyukWIFiTiqC7pqCxMYRxcapQb97oZcHEOxEcYbY
         V0BQI/tPYp8WuoQV4+DeSpaNDaxZxczCm/BfmpiEuqSVuarNGVNmF7ePo2Ffbwdb52bl
         TV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640662; x=1794245462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
        b=MKQbDjEDnRZ+hVlxfraw8p+RUiwAroBUjnlVDsa/y5AVmPBA7K1vDHwAXfeQY4Or2t
         A4oTuRY/T6TosuReDrXwRVCIvncGYN+NYPfyM04IdLz/OmA6ct3bwQt/yTTi4y8Ukrx4
         C2iSj9wZIXI5qEZI9XD/DNpDWuiTvNrQHrDnZl4uIg8DHHmybzmIcNIMo8JfM037tdSu
         pwKD4DaBf/OuiYSSQ1ZsWlHL6el8o+/9f4sm/Diy3odG4LLd+Te3MJYAJazadTQHU02z
         qiz2iyqGZyuS2Aprg6A2NGIcwERPJlVtdwcZcHcyeYPBgbt491mpuclPSPrkiP4quqEb
         k9jg==
X-Forwarded-Encrypted: i=1; AKwUvBwIe+VOca1MMPXC3oCpDcaf4rStFUVICKINluKs6jkxjx6tT8CiPQVCDLSb7rvOW6hXQv1Buzs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4Zxm2BqcW0XQwKFmALXNSZah7UZ1W9EXX/XxpMsLiR1fhykvf
	ElYJ8l/xEbeRkvjvOD0a/t6SRXLULDtu0DsSe0BK5CfoNFEZcAHMxfxHet4IaN8Va0MPDfSnGqJ
	bvs4DqPcYLm0ArBJB2E6oC9a3i+Eag0x/qhJlMdqL8DzmGNbl0sjVE4P1bg==
X-Gm-Gg: AYBFou02gQG9bGySjV/w1gwZPguyF4Q6Q2zR7Yz9iYMbLcg0Sldn54PFe3k8QoabG4x
	CavFcM5aviyISenu8TY/8wZOB1fzoA0OjLD7SkmTwgKezuVBIYPqzF+uAeWj8Bk8iy3AwWl9JKY
	1EBRPoFB6UuiCGMoGpPNZVkrrqjtQ/2RtixoD65hPWcpy/KNref9luA8nzByPCpmBUaPWfXWCGg
	QO4LWpiOVhrDTdEsngCi6h2EM4OTCw9gDUPDcJ4W+Rj9FJMJy45Jr/ItwbroJexXb4Fxs76MGGA
	SNqM5esXRqCanMvPFqjDfjaIRy7wRag8QBdPmXfL3Cu+QUSUW83n/RIdtEnmVXv81fHTc7ap+bT
	6wYloCbRIOQKo6TpkZpZGtMQQSbL6RPPrkMAXCtAxtg==
X-Received: by 2002:a05:600c:310e:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4ac1709ae70mr245615685e9.15.1793640662129;
        Mon, 02 Nov 2026 09:31:02 -0800 (PST)
X-Received: by 2002:a05:600c:310e:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4ac1709ae70mr245615175e9.15.1793640661652;
        Mon, 02 Nov 2026 09:31:01 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa953d35sm1240835e9.9.2026.11.02.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:31:00 -0800 (PST)
Date: Mon, 2 Nov 2026 12:30:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lianjie Wang <karin0.zst@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
Message-ID: <20261102123049-mutt-send-email-mst@kernel.org>
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
 <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>
 <auCkXHi6IulXgm7v@wang0.localdomain>
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
In-Reply-To: <auCkXHi6IulXgm7v@wang0.localdomain>

On Tue, Oct 27, 2026 at 10:53:16PM +0900, Lianjie Wang wrote:
> On Tue, Oct 27, 2026 at 01:06:41PM +0100, Paolo Abeni wrote:
> > On 10/22/26 20:26, Lianjie Wang wrote:
> > > [...]
> > > @@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
> > >   	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
> > >   		hdr = p;
> > >   		qid = le16_to_cpu(hdr->vq_index);
> > > +		if ((qid < first_vq || qid > last_vq) &&
> > > +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> > > +			return -EINVAL;
> >
> > I think the above check could be simplified to:
> > 		if (qid < first_vq || qid > last_vq)
> > 			return -EINVAL;
> >
> > squashing the following in virtnet_get_hw_stats():
> >
> > -       if (enable_cvq)
> > +       if (enable_cvq) {
> >                 virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
> > +               last_vq++;
> > +       }
> >
> > (likely with some meaningful comment).
> 
> Thanks for the review!
> 
> I looked into this, and I think last_vq + 1 matches the control vq
> only when all queue pairs are in use. The control vq index is
> max_queue_pairs * 2, while last_vq is curr_queue_pairs * 2 - 1 for
> ethtool -S. After ethtool -L lowers the queue count, or when probe caps
> curr_queue_pairs at num_online_cpus(), last_vq + 1 is the receive vq at
> index curr_queue_pairs * 2, which is not in the request. The simplified
> check would accept a record for it. Since the ethtool -S array has
> slots for only curr_queue_pairs queue pairs, with the transmit slots at
> its end, virtnet_fill_stats() would write the counters of that record
> into the transmit slots, and can write past the end of the array.
> 
> Would you like me to keep the current check or change it in some
> other way?
> 
> As for the comment, I would add the following above the check in v2:
> 
> 		/* The control vq comes after all max_queue_pairs pairs, so it
> 		 * exceeds last_vq + 1 when fewer pairs are in use.
> 		 */

didn't get v2 yet.

> 
> Thanks,
> Lianjie Wang

