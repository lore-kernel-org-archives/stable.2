Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213552;
	b=xeAa4iKO/bnKzXeMEItki+uiw0+6Ppu8xPY1OPW5MxcZBPTvrKVVBMtBXYGxN/twRj64
	 VUMryXAFIxUkyOBzsodXmoHyYYLFPOrxoI8M8DJiA8cKo5IUgMKw4ULX29EBMbeViO2P8
	 7uegs21BINf28LG/ke/DzJe6LNhCz4kd1o1phOX5wGsLp3nP5BEzibCKPOugvAzcxCyYw
	 zZP6+jNen0inX0ojhX84QWR5lBmw9GCUV/eNjL0VIaeco/yAihWHRCX7obm7mYTm3KxEF
	 ZmwCyVTBJ9L8YE7ElkHtaF4t8nCYdPvvXr/c5zFaWVQzm/00b9XJVoJu7f0IivIjTKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0BEsHb9r/ZqDzu9FPC1kBx0oe94gE6mCVbWLiXY+XYs=;
	b=HDlsxAl1+nDC67AMJXNcyuoau+qeVtoBgpmMeQOXH23frXtqJyKNJkhCQKCJqzh1L02/
	 VWQAvo1DkhI+yzD1fFDOLJpVUvowKOdhG8CPbbNaO46+FKR+CzZCVfzuf5G+o6zFzF3SY
	 gkn0+IZxn1jkZcuTpXTGztxTy+OQ/NLpGgXG10oQxQA+Mak/HyAL0h5EwVwhQxgP9m/QE
	 o0+11yjNX5gQV+55Z1pbpUzii8gnz79FO7GqvowlmK2HrbcUPE/oceD7l9QeamBbEF/zy
	 dhhFRjF4A9cUMz6rrarnrcn97kDP4Cde02OVrd+1bj7ka7gJ00omEpNHmguDx5h3hUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kerneltoast.com;
	spf=pass smtp.mailfrom=kerneltoast.com;
	dkim=pass header.d=kerneltoast.com header.i=@kerneltoast.com header.a=rsa-sha256 header.s=google header.b=Lu+FtGbL;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE9606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AE9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kerneltoast.com header.i=@kerneltoast.com header.a=rsa-sha256 header.s=google header.b=Lu+FtGbL
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-679a420b5afso1337226d50.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1793213550; x=1793818350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0BEsHb9r/ZqDzu9FPC1kBx0oe94gE6mCVbWLiXY+XYs=;
        b=Lu+FtGbLOGkDFrmG4LD06Eq2dbLYRKTP3mSbPtrWUrAaexIpL6XN0j7NR348Hb/q32
         JvT86Lv4PZ5WHRy0RAtvCwdA+yDG9sU675DOv9Mb/mC2OZf8iIl+Hih+bzI/mjoLghDb
         9DignMrctd+QcfrOLFl/bqKn2kt0xEwMB/bh5PJy+oWU1aodgoNxGgXA/2uFht7fqyXu
         kB9GXSjqC9F4CkOuBZnTRougezgJHBLeZ5pytXOWF3RRpIJ5UE4Dqik02LCAgGkoOMz1
         SEt3olgSE6z69gWgPSb7DXqxNMo9XdMO2dSc3WoL9zUbEcgNNQdAX8CBcJLIAwvHV8EM
         lDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213550; x=1793818350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BEsHb9r/ZqDzu9FPC1kBx0oe94gE6mCVbWLiXY+XYs=;
        b=nJsmka6/EHcjy8UcME7qeKd7irw301FC7QCa/aZqHfHDoqnltZFYGfMfw4I3jxMNIW
         XLJKRofpQ8mAtkbkHc48fGuRqLoU/Xhk/MpAQpdsZa4ovSPW30h/4faxN8YAHqqEV+dk
         qUeJ1PxH3p7C+ReEAHLwUYYcZYvHhhyb1V1AThtwJClSQcAK13p2A9vRIvtJVTuM5XpY
         GTNow+rZi61l//o6AyuCwOmL0JlyPlgl1Hqz9E+LMGPQd6viHAdWbMG7ofvQckZK1FkT
         x2vxBTloSBzu5qJxWkK5NtBWR0yEI0qK23t84Fsed4Mfa/J7FwAUeeEHEQMf/A/HKXaF
         8o+A==
X-Forwarded-Encrypted: i=1; AKwUvBwdRl2Ds9BHjIZZvxHGyt5NLV296RC2ck5V/T7EcpD1OXWpXze8XNn5mDhuO4qS/EsIjxwS8k0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxrELZmtXkUZOl2ny4kHZc3+nKqk/Qg0pA/YbrkYyGYpovsvJS
	ZVcyBmLrj92JbIA0Tgpom+q/tFpFQh02nLCfarS59VwFNzSEKevdZnvhyacxOhjnxRwQ
X-Gm-Gg: AYBFou3OKYMGcpSR+jckDw6cy80VxFSUOuCNvWBwjz07LyQQxh+rAqk69PR8m3frMQw
	rrnT8f11oHxO4LYGY5O2ChLujFgP/NWyeqnQQqbNfWqhHeZTvf8kH0nbv3AZt7m2lAm3o5/neI/
	p5dAfLDRmisErlF5fBYRBMML0224ixj5GlTJI9qWjs7bmYOwRM5dyfRRTpI5VQRdhp3k4ztPp82
	Gs8eXZkE8kIGRn+VIB0Tak0Qjif2bWCHewd/5WSdN2ZyF+nRRGhjtcHHznSY9Ax0OgxZf2sxIRA
	bZyl3LbGyF8nwGgvp/F+GgX+nk9Ka+YHZUnLAUAomuXeqYxVGVOWC9P/WMesqAvhXOVJ7kSahPe
	KqpFSaUKw/rwfgknj1rezl/hEofUy3v0sE497bEt1tuoXmGCRAjUvrswkE1yk33SicCc2tRbOlF
	Qq0SJUx9knK1bGNE7ujPB0zoLVrkmWyQFgl31WzE5IvRjrx+Z4kL9G0DUPJtrxFjyAlzZaXFyMe
	dczy15HzzCtQSN0PSv4LRo9wXL+2mgTnbvrZEn+7raOEMHM9wnd+WyK6FFODkjbtNbM5CeCThCY
	g4Z0Jxr3T0GXTzbVgnk/kQgwUCB6Dp8F
X-Received: by 2002:a53:ee0c:0:b0:679:9afd:c0dd with SMTP id 956f58d0204a3-67a7bd81c47mr1564139d50.111.1793213549589;
        Wed, 28 Oct 2026 11:52:29 -0700 (PDT)
Received: from sultan-box ([142.147.89.222])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a79f38dfesm2247957d50.1.2026.10.28.11.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:52:29 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:52:25 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: caspar.adriani@proton.me
Cc: Bin Du <bin.du@amd.com>, Nirujogi Pratap <pratap.nirujogi@amd.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Benjamin Chan <Benjamin.Chan@amd.com>, King Li <King.Li@amd.com>,
	Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>,
	Yifei Gao <gyf161023@gmail.com>,
	Seifelden Abdelmonem <saif.elden.hatim@gmail.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: amd: isp4: fix self-deadlock in
 isp4sd_start_stream() error path
Message-ID: <auJEaXevXj6hNTsK@sultan-box>
References: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
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
In-Reply-To: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>

On Wed, Oct 28, 2026 at 03:05:41PM +0100, Caspar Adriani via B4 Relay wrote:
> From: Caspar Adriani <caspar.adriani@proton.me>
> 
> isp4sd_start_stream() takes ops_mutex with guard() and, when
> isp4sd_init_stream() or isp4sd_setup_output() fails, jumps to
> err_stop_stream and calls isp4sd_stop_stream(). That function takes
> ops_mutex again, so the task blocks on a mutex it already holds. Every
> later open, close or ioctl on the device then blocks behind it, and
> only a reboot recovers:
> 
>   INFO: task .v4l2-ctl-wrapp:38440 blocked for more than 122 seconds.
>    isp4sd_stop_stream.isra.0+0x43/0x1d0 [amd_isp4_capture]
>    isp4sd_enable_streams.cold+0x8b/0x26c [amd_isp4_capture]
>    v4l2_subdev_enable_streams+0x1ff/0x360 [videodev]
>    isp4vid_qops_start_streaming+0xf2/0x160 [amd_isp4_capture]
>   INFO: task .v4l2-ctl-wrapp:38440 is blocked on a mutex likely owned
>   by task .v4l2-ctl-wrapp:38440.
> 
> One way to reach the error path: start and stop a stream, then start
> it again without setting the format. isp4sd_uninit_stream() clears the
> subdev pad format on stop, so isp4sd_get_str_out_prop() fails on the
> second start with "fail to get out prop" and "fail to setup output".
> 
> Move the body of isp4sd_stop_stream() into __isp4sd_stop_stream(),
> which expects ops_mutex to be held, and call it from the error path.
> 
> Fixes: 4e5e7a7ddb4a ("media: platform: amd: isp4 subdev and firmware loading handling added")
> Cc: stable@vger.kernel.org
> Signed-off-by: Caspar Adriani <caspar.adriani@proton.me>
> ---
> Tested on an ASUS ROG Flow Z13 (GZ302EA) on v7.3, with a local,
> not-for-upstream change that adds its OMNI13B1 sensor to the ISP4 ACPI
> tables so the capture device is created. The stock firmware does not
> support that sensor, so no frames arrive, but the start and stop paths
> run. Sequence: v4l2-ctl --set-fmt-video=1920x1080 NV12 --stream-mmap,
> stopped after 10 s; the same without --set-fmt-video; then the first
> command again.
> 
> Without this patch (v7.2.8, same setup) this failure hung the task as
> shown above. With it, VIDIOC_STREAMON returns -EINVAL after "fail to
> get out prop" / "fail to setup output", v4l2-ctl exits, no task is left
> blocked, and the third run starts and stops the stream normally.
> Not run: lockdep (CONFIG_PROVE_LOCKING is off in this kernel).
> ---
>  drivers/media/platform/amd/isp4/isp4_subdev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
> index a108d90ace..08512f060a 100644
> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> @@ -745,15 +745,15 @@ int isp4sd_pwron_and_init(struct v4l2_subdev *sd)
>  	return -EINVAL;
>  }
>  
> -static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> -			      struct v4l2_subdev_state *state, u32 pad)
> +static void __isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> +				 struct v4l2_subdev_state *state, u32 pad)
>  {
>  	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>  	struct isp4sd_output_info *output_info = &sensor_info->output_info;
>  	struct isp4_interface *ispif = &isp_subdev->ispif;
>  	struct device *dev = isp_subdev->dev;
>  
> -	guard(mutex)(&isp_subdev->ops_mutex);
> +	lockdep_assert_held(&isp_subdev->ops_mutex);
>  	dev_dbg(dev, "status %i\n", output_info->start_status);
>  
>  	if (output_info->start_status == ISP4SD_START_STATUS_STARTED) {
> @@ -786,6 +786,13 @@ static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
>  	}
>  
>  	isp4sd_uninit_stream(isp_subdev, state, pad);
> +}
> +
> +static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> +			      struct v4l2_subdev_state *state, u32 pad)
> +{
> +	guard(mutex)(&isp_subdev->ops_mutex);
> +	__isp4sd_stop_stream(isp_subdev, state, pad);
>  
>  	/*
>  	 * Return success to ensure the stop process proceeds,
> @@ -836,7 +843,7 @@ static int isp4sd_start_stream(struct isp4_subdev *isp_subdev,
>  	return 0;
>  
>  err_stop_stream:
> -	isp4sd_stop_stream(isp_subdev, state, pad);
> +	__isp4sd_stop_stream(isp_subdev, state, pad);
>  	return ret;
>  }
>  
> 
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261028-isp4-start-stream-deadlock-6c33a97d3297
> 
> Best regards,
> --  
> Caspar Adriani <caspar.adriani@proton.me>

Reviewed-by: Sultan Alsawaf <sultan@kerneltoast.com>

Funny coindicidence, I ran into this independently 2 days ago on v7.3 when
Chromium restarted a stalled stream, and I made a similar fix locally. The
trigger you mentioned is a another bug: the subdev format shouldn't be cleared
when streaming stops, since the video node keeps its copy and userspace can
restart streaming without VIDIOC_S_FMT. I have a fix for that, plus one to power
off the ISP when starting the stream fails, which I'll send on top of this.

Sultan
