Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3E40C5A0
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596366; cv=none; b=AypPEdBPU33DpkJWhY3nshUjWRypv56H5N3bN1B3E3k7QOAk4Q0dcM0RkDysZ2OuIPiTCRofguq1KNpNQnd6UpBUsS7iX0Tj6rWoOs2f24QoXeJpl+yQtutbzoMot4pawk1XJhcLAQyxBkBOGSdGJBvwdhw/B0xkVJF/6wrhZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596366; c=relaxed/simple;
	bh=roAbmkmF2Ua744ApOcxkj0ppmjvG0gQMyEjsgkuHtJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3SP8p42EMR7CX38PHH2DpsOFQxyuoLRVYOhf8WdE5dYp0aRWE10oBpYkt03CELgW0o88e9EjSNO5b4uI50Nz5jgpJj8D+p2/2VpxHQLhx46nHy0hK0CGUqabrqFaN+hhRVGmNjtRvrW7Ht6rh1PD0wD279pjLSYRUXJxzMmggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfpTub+k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsiUYfbf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfpTub+k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsiUYfbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781596364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9C1tt1ScGlutsIGtKWOVOCVDGyzg8ZLvaEJnUvjWVXY=;
	b=NfpTub+kSmsLzmwATWKRnwnahG4I2GtPZyS91scYMOgvVGNOaQShNtQXiIlNCkzbEq3FrK
	ZbaeONuALdTT/uRGtjs1YxHR4YwfCN5nUqjk3o31rgHw9ujmtt9ppEEpmWfEsTduww330A
	nfSh/ZY15IXd/vmw79hvq6r/jH/bt2M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-HcE_Kd6NMO6gXFwV11xU5g-1; Tue, 16 Jun 2026 03:52:41 -0400
X-MC-Unique: HcE_Kd6NMO6gXFwV11xU5g-1
X-Mimecast-MFC-AGG-ID: HcE_Kd6NMO6gXFwV11xU5g_1781596360
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45eee3f9f03so3825649f8f.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781596360; x=1782201160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9C1tt1ScGlutsIGtKWOVOCVDGyzg8ZLvaEJnUvjWVXY=;
        b=EsiUYfbfR7EJUhPpJ5SJspkl3eZrR7Xo+7hxJHnO8vpwT6N0UtY0LiPF8KHXkc0Lc0
         Z9ZWV2eimdFCZspeXqnSEdXL9qelxNwmIknvAWLvd11qTnhluf2mxKtCdXYlEPFPFex7
         x/nJg3nEciRR1uOTxzPP9xWQn7frJukydiO+TDYC5XiuN3GtLOHQM5AhNkvMh/0kSD4a
         qL+BrjjC0vC8mBnCybLlFiN5BZ80DVhUbwi+hqhg8QP53bHqfRKLm2GcV+OQ8c/7NsD2
         OlZj64kW9Wv0tQ6fVx4sn04cJzmKRPtPAf01H5eXTfFLBxvl0xUrOdFolIQ3kwvC9FFR
         DICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781596360; x=1782201160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C1tt1ScGlutsIGtKWOVOCVDGyzg8ZLvaEJnUvjWVXY=;
        b=k3hSK8Yx/wAKD8qLJJKQmZ7sHLGHLxCPnHoUFaYXclfsZ+Nvnzx7BEVBFU500mGJJB
         axd5bnpEB+cqylm/t6WPzt1WUu5yL18tswWEWLInHO0OtNPjAUiiENejAE3ToLeQ7yd0
         4CYG2fh2F5aHwoxO5UwTtKa2VDmD9J/uV+wkWNgmmusph/AL+X8ecKjqk7+nHpsRDnyH
         GocDPywjbvxRvUEiRUABgb3YV/5w8wrunLtoPjcKbUwMzLP02PbbdizXzEjzOxdAbxEU
         FN0LbX98W2EVSbknqXcdMkhVRxLyc5r5s3hG7wOLwVyD7ZYMiFH+qoStCIswpE4cAykz
         H0gg==
X-Forwarded-Encrypted: i=1; AFNElJ/uaGXSmur7br80Zh8i0vVpVYcxRJ4eQcWISohGeSEbU9uVCLY0dSAGy0cp8u+xaZ6+KZIFVzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyawGgG8z5CYU0T4PczG0C7aWpb47yXuIhh8g9As/MMPIFTThhS
	sjt0pOKxXDCV+wJj9RYBlBmrZwW3aGjgGy9NJThKwvNtDwgL3Bp28uAbgHc5ddKzpEGLFiRQaq4
	JNiYtlILnuuLMUtOOaxTYm0cZWsdCF4jIs/+yWTnrYuFT1sjJLVBbElUNnA==
X-Gm-Gg: Acq92OH00YFE5g0nkYRUqPGLLJ8OP+zTtjIVrFJ026/NDis3B0zLElObIOtz7sDj65w
	6Hd1UPED9+nkAM/2UkmrAIkQu4dLCTyoeDwz6o0XS1+BpwIvSiQiizww2OIhuNbpEjdOCbxIOG9
	cQb3Zdsvj1GFcIImGgpmWrnfRau+dJYQ20uAfhsbzlECaUQ6WE+JjG0fnhL97iWwt1NnLfZATR0
	CVLuSOMKnhRcHwXrkPvDCzEfO8DBC7iBW0mEU4sTlDBSz/m2mWFdjyrBo9sIIFC0yjERUq/9a5e
	oppLus36Ih0VhtJAy/bKW3TAYlzy56zjmTTbVJ9HYzJ+zc6tiZtAuya70EZRLNCkGzBumwvBHBp
	R41yW3yaaiSG/+vDzbHYYkcK0tUpVF6nGpbBMLCpZhpsJCn0h0qGgx7OPTjYlu6WrPpXH9Do=
X-Received: by 2002:a05:6000:2082:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-46074b82278mr19488744f8f.14.1781596359939;
        Tue, 16 Jun 2026 00:52:39 -0700 (PDT)
X-Received: by 2002:a05:6000:2082:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-46074b82278mr19488703f8f.14.1781596359500;
        Tue, 16 Jun 2026 00:52:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d9becsm39985553f8f.34.2026.06.16.00.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:52:38 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:52:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com, jasowang@redhat.com, 
	kuba@kernel.org, leonardi@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, stable-commits@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <ajD_FBEak8hKNdIK@sgarzare-redhat>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
 <20260515114521-mutt-send-email-mst@kernel.org>
 <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
 <ag8EvTp29B-Q3nCq@sgarzare-redhat>
 <2026061624-harbor-capture-a5bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026061624-harbor-capture-a5bf@gregkh>

On Tue, Jun 16, 2026 at 10:17:31AM +0530, Greg KH wrote:
>On Thu, May 21, 2026 at 03:15:54PM +0200, Stefano Garzarella wrote:
>> On Sun, May 17, 2026 at 09:33:06AM -0400, Sasha Levin wrote:
>> > > > What's the status of that fix?
>> > >
>> > > Stefano posted v3 and is working on v4.
>> > >
>> > > >  Should it be reverted elsewhere?
>> > >
>> > > Donnu. With the change we have no DoS but the socket gets silently
>> > > broken.  Eric felt given the brokenness is upstream already it's better
>> > > to work on a fix on top, not revert.
>> >
>> > Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
>> > follow-up once it lands upstream.
>>
>> FYI v4 is now merged in the net tree, so I guess they will land upstream
>> soon. I CCed stable on both patches:
>>
>> a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
>> c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full
>> buf_alloc")
>>
>> Both are related, but the second is the main fix of this patch.
>
>THe second one doesn't apply at all :(
>

The second one is the fix of the patch originally added to stable queue 
by this thread, so should be applied on top of it (commit 059b7dbd20a6 
("vsock/virtio: fix potential unbounded skb queue")).

I'm working on improving memory management, but for now I think it makes 
sense to backport all three to the stable branches.

So, in summary:
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full buf_alloc")


Thanks,
Stefano

