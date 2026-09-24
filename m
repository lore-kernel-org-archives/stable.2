Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AFB4CE67A;
	Thu, 24 Sep 2026 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281707; cv=none; b=HKUtTPC4FbHKj3Oaecs22UvfuGt2vHkIf+uaWytG3u6PT2bGdWPrhJg0X0dcnDO5GerAdr628egd+Gv5yiQTerv7cI0YhJpBAJrekD1ewbE4PCsXNtE7viyfPSdS54brSTSzOwTG5gtVX3s1tFKMNrURjaQ5fncX7iXn5RB2Khk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281707; c=relaxed/simple;
	bh=/24pHmW0tMHYsRs5q5YjvnJhsHslqlSjqq669/OBrRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMB98LrnEXo8KYpL2PVrQKO3GFmVFGK0SlFlR6XiqWEVZs8K0eMRfQGQbSbqTjQbnmQpH4oQuq7CPefWb3q8nux7/O2vHv88xK0v8BgRXx8jykpbl4hsIcA8Qjr7TM+WQEBXznu1CZbrue2c+/UnkGRKktaOdP7oJc/cNWNA+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTvJKGgH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTvJKGgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4841F00898;
	Thu, 24 Sep 2026 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790281700;
	bh=mj2nxfp8a8MvY9/fQ8w1l7StlrKAQ0MmfyffH1beKyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTvJKGgHpKc1cDVZOCu7HiuN7ehKD8WNhkzt8tnu/L15py9t1NimtU2IUKVpWxWH1
	 LzU3X1/JzLxFW87j5BBHIJwb4XhDYCmKE4k7PUr0F0y0uh97ykaIZCONUXqe1bg2hg
	 VY0inWbya2Vfy8DZlgGpv+jS5NrVB9HTEp9WqVqJUpvoYQokgmJw0HXCBj5R0W+FQn
	 nslMY7VBsod/ptJLG77UDy0RsEQqoosyrcttmsPyofn35T6firEinQukSARKZF9DWD
	 69QCnCEyxL0MWV8weT28VlB+FNjCvCTPoHzl0OWq1mjtAseSP60Op6SLJwxaXjwZjT
	 PEG2DH/I0JFmQ==
Date: Thu, 24 Sep 2026 22:28:15 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yuho Choi <oss.patchbox@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-i2c@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] Revert "i2c: virtio: Avoid hang by using
 interruptible completion wait"
Message-ID: <arWHzKEfy6HKMZr1@zenone.zhora.eu>
References: <20260922050251.403857-1-oss.patchbox@gmail.com>
 <20260922011619-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922011619-mutt-send-email-mst@kernel.org>

Viresh, can I have a comment from you here, please?

Thanks,
Andi

On Tue, Sep 22, 2026 at 01:17:06AM -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 22, 2026 at 01:02:51AM -0400, Yuho Choi wrote:
> > This reverts commit a663b3c47ab10f66130818cf94eb59c971541c3f.
> > 
> > When a transfer is interrupted by a signal, virtio_i2c_complete_reqs()
> > stops waiting for the remaining requests and virtio_i2c_xfer() frees the
> > reqs array while the virtqueue descriptors are still in flight on the
> > device.  The backend can then write into freed memory, and
> > virtio_i2c_msg_done() calls complete() on already-freed requests.
> > 
> > Commit 84e1d0bf1d71 ("i2c: virtio: disable timeout handling") removed the
> > exact same failure mode caused by timeouts, concluding there was no simple
> > fix because the buffers must be held until the device returns them.  A hang
> > due to an unresponsive backend is preferable to guest memory corruption.
> > Restore the unconditional wait until request lifetime can be decoupled
> > safely.
> > 
> > Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > ---
> > A proper interruptible wait requires refcounting requests and bounce
> > buffering to hold memory until the backend returns descriptors (similar
> > to virtio_rtc/virtio_pmem). Since that is a larger rework unsuitable for
> > stable, revert to uninterruptible wait first.
> 
> another way is ring or device reset, if that is acceptable.
> 
> >  drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> > index 5da6fef92bec3..581e55b5c65ba 100644
> > --- a/drivers/i2c/busses/i2c-virtio.c
> > +++ b/drivers/i2c/busses/i2c-virtio.c
> > @@ -116,16 +116,15 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> >  	for (i = 0; i < num; i++) {
> >  		struct virtio_i2c_req *req = &reqs[i];
> >  
> > -		if (!failed) {
> > -			if (wait_for_completion_interruptible(&req->completion))
> > -				failed = true;
> > -			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> > -				failed = true;
> > -			else
> > -				j++;
> > -		}
> > +		wait_for_completion(&req->completion);
> > +
> > +		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> > +			failed = true;
> >  
> >  		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> > +
> > +		if (!failed)
> > +			j++;
> >  	}
> >  
> >  	return j;
> > 
> > base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
> > -- 
> > 2.43.0
> 
