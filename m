Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637225;
	b=AiS4TctmYnUFykUV6nlgDCTwTyo/LIcsGUDMqPDWngBxwlFlSe3nfX4cpaKv5Tw0zIuZ
	 T5SX3MOim4+9aJfVK0JhDBsp85GxYOjxUqmtspXKSx5Q1p9qBINNEZR0aJEeFNPU8o6AE
	 Am+NCsbNRJyVX5E5VCIUvKTGqUlHLX5y3zQ6VRl42Pi9qoLNq78vk4CnBX9itIqsURd5V
	 uRjTIHRkzxt0QhvJ2dgmkD9LreL7U9Z3q7bbY7dfxkk3ekOBvJHyXypuCdsfzOhrT7EX5
	 HUC51ezNcX91TpvefK+qnTFISLfkLpxJNuKdmehUqF5kMKR+YvZpxjPyCXPT3yWrzMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637225;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bZDM7pjFprraJZ4e9RLnqLxhxQi43j49i/Xcsi5OwC4=;
	b=ORHNVFBYaeGM6Cyk0DHcCyr+az354kiSp2tX+wY9TXxF+pFC0wvVsjnLLwG9PP0MEAg0
	 nNsjmTmN2Brb5vpNrV2ntjZ4yHCyy/hmPOxeMvkqMihloHRAJagd4pKe0bmqCcWu/xdsG
	 3jYRAeBtHNdocPAGz26/QwAoMF5gJRGZ8lQg0Px4LeNh4dgxaH7QG7qPkFGttZ77i+wLK
	 HvHN6/OBQIVWAGHFIVXJZicOaZiocR8NTjdwPv7JIMRhabYItYJqE9r6M7q0QhVOjuxlq
	 LeXp26fQJ/S7Dne4Jo7h1yUNRgHcxSCKdFRhceYykMlkUUVzVrQjmjBaSWnpmowy6Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V71Xzz+P;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hdWOi1K5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29590606A337
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29590606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V71Xzz+P;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hdWOi1K5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793637224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZDM7pjFprraJZ4e9RLnqLxhxQi43j49i/Xcsi5OwC4=;
	b=V71Xzz+PVUdwC3u1S70sRjYPCmmeNxnLrA3oNETGGbgvkCYXaePKYqniRc5+9+NDg8q8Nh
	RIYYMLZG2xECIRcRyIxaBl7X0CgXJLYb7d34OGqpMmUivl50farcsONuo5cQqHXnPVnoFX
	EjJIpIWnSohv1DEut1rAU/wRYiCe67M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-vMLsokYBOISsU35WP_d_Ww-1; Mon, 02 Nov 2026 11:33:43 -0500
X-MC-Unique: vMLsokYBOISsU35WP_d_Ww-1
X-Mimecast-MFC-AGG-ID: vMLsokYBOISsU35WP_d_Ww_1793637221
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df5b058ddso2165101f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793637221; x=1794242021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZDM7pjFprraJZ4e9RLnqLxhxQi43j49i/Xcsi5OwC4=;
        b=hdWOi1K5Rt4fY3wUvl6SM0n4EoS5qVNvtjTcBHodW6OKuOdWzHE1EIXvDCyG8wlKnC
         0W0JFJDRGrb8meoO0QvTu0PgSbP0Vdd5mlsBXBkM1OB/TfXR+p/WrhLDBOMNeYpLgN2p
         Z/K5EyBlox8ImybpREjqAyGMjAaMqQPFi6gxOzxerfubgMmAhbivf6EYf/zds2CJAt8l
         REdDemdTU0uL7uqBkuGGt6r0EGUar9G5wBq3d7kwjzs29Pu/On6UXIx9aLuMwPB5fzBI
         WG3RiYxseXvItGU0aQxhKJJciwz6EQ5i3tZ3jZNn7/xh0p/gxXSxZeIDFcP0jCSEOc33
         qACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637221; x=1794242021;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZDM7pjFprraJZ4e9RLnqLxhxQi43j49i/Xcsi5OwC4=;
        b=PsIJzi/8sl0GujMge54rMQLZHJKTFckkI1lLEGV26dnUfGUyrvFK0SjXUha5sotWbT
         G40xSrEPjobNexB7K3Pk4Z9O4CZDf4D+xne3dHL6rfRHjChhUCp6b02hS0pjdVv2U47o
         /M9LJsvAv6TLICYCY2ek0EhvDBKps3bmrIzwYezEYaRYiwWrJbSrw7OlFfHIUReLbzEJ
         9n8dWgLDJKn8N9rGP/3tlVpCiB0Kosu9nrqGgSqdno9xHX5ejZK2KmWyYEFBKPRV9OwE
         oOjWU3w01qbmOeAb+kaKbKbCwXnnw8UKbqqyOaLs9FbIb8QcEFTIpRmY5t++xnP0A6jJ
         5MlA==
X-Forwarded-Encrypted: i=1; AKwUvBzaXzICc8rqCAE01KbYNm8oppagxz285hKg8WSRHUe6O7Z8bkCduVH0eWzerXXePG/TC9bIxnc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ahrMLVMr+IVD50L2NGAt0r9QTw5EyMqK9WT7R7sI7xNjLncNY
	tgz6V9nfnqcQWxJU8To6ytXAeXtR1Un46XGZVvxP2FkMUgZxVnw6ctzcz0/13PK9VZSLWYWXnsZ
	/oGLnlJkdfLluN5oiE6I33ImPYhTaDjh3FZraZobbtlPOzf5EqUottM9Wag==
X-Gm-Gg: AYBFou1dyYd1Y3qkoIoUWopWbh7Infg9KLQ50lmOCmpOsBJUvaO7wPk3Klo5uT7El+W
	u4ro4zlc+al/o8GZ96oRQC6sNjz1wNfF0pLJgLmxSHqaav9mTHVX5snrsXT3b00XgLA9gaf47ps
	CoIX4kMwLJvQtnoZkOpufT4lYSnIdD687ToYtofy414P5NeXYSTk1TbSRsQqLkIhk8Mxnyz2MMH
	IHhLzxpsvTSGJQmsLprMvlBt9As7H191Et7XbQzCuk+aDwuACZ2j4GXU9M8rr1nH5++C+7nG6KG
	P4fIYsPn6OZSWICcoemFXKdVSRsxI/bdVZ94JHcVahU+9V+DTXAkG9kd8+zwNAmbwomexH6Ve1M
	fcohcuIWweet10VAIEK4gHBy17MCC73Lh8g4o2TJHWQ==
X-Received: by 2002:a05:6000:4311:b0:48e:75a1:1e38 with SMTP id ffacd0b85a97d-48e75a11e48mr17141427f8f.56.1793637220618;
        Mon, 02 Nov 2026 08:33:40 -0800 (PST)
X-Received: by 2002:a05:6000:4311:b0:48e:75a1:1e38 with SMTP id ffacd0b85a97d-48e75a11e48mr17141372f8f.56.1793637220112;
        Mon, 02 Nov 2026 08:33:40 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm20861861f8f.38.2026.11.02.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:39 -0800 (PST)
Date: Mon, 2 Nov 2026 11:33:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] virtio-mem: only mark the device ready in kdump mode
 with vmcore support
Message-ID: <20261102113328-mutt-send-email-mst@kernel.org>
References: <20261016023521.747447-1-oss.patchbox@gmail.com>
 <25a35fa8-9540-4892-8375-1788e6795dfb@kernel.org>
 <CAGG=RgDUFpDqtbws4YO4T8A3pS4Dr9twVqP9hSD3J_zP5Dc_mQ@mail.gmail.com>
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
In-Reply-To: <CAGG=RgDUFpDqtbws4YO4T8A3pS4Dr9twVqP9hSD3J_zP5Dc_mQ@mail.gmail.com>

On Mon, Oct 19, 2026 at 07:46:50PM -0400, Yuho Choi wrote:
> On Mon, 19 Oct 2026 at 09:05, David Hildenbrand (Arm) <david@kernel.org> wrote:
> >
> > Which kdump kernel exists that does not enable CONFIG_PROC_VMCORE?
> >
> > IOW, why should this be stable material?
> 
> I tagged it because a9403425b3cf has been in releases since v6.14 and
> PROC_VMCORE can still be turned off with CRASH_DUMP enabled, so the
> -EBUSY path is reachable in a valid configuration. But as no practical
> kdump kernel disables it, I'll drop the Cc: stable in v2.

still did not get v2.

> > LGTM, but I am pretty sure it does not make any difference in practice?
> 
> Right, nothing is queued on that path, so the device has nothing to
> access.

