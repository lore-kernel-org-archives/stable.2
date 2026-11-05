Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893147;
	b=evOkKXd9gV2MrVC549+EVJyfu+YWHphnZA4CalrtB2KTs6n4Np0xGGfCxBRJ1SyqapTE
	 nst6qdHw4cRGRxpesvlFjU89wWhL+NYOMSdHNn7dG+pN0IyeJ9p7Jrc1Tp1c7vdYySnnw
	 g1hRuqsi/wPTfKhJPpJ+d5MCtJoA+J/xP73Wq1Tzn3o1zCCSGmaCZ9F7MDgso5Ba9vw/G
	 Gt5vbwaPqcXapcFLOySteP+dOUnpHvB/DYCT32zuQop9MWHekndUdizj8sDft2G10HakU
	 ts8CSjRcUhAvJ8s8Mo+1oJBWLKSAFMCakf1zUFwT0EVJMjFPVnDP07L6whauC2Hl+2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893147;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=CzkLHzamPhlX9pgW2wiSyKVCqhOdYm38WXyWxxU1dbk=;
	b=CLz7S4thlWuZJ4Pc3anVGTrQiiFSce+nzVZq1w877uv4T9I5qqixeSo6wVC51BwjnI4x
	 Q1mcySdyCRQ5Q2JArgce160t+DyCpDOJb04voGtBzbJPyTLayMFAnZ3d8q8i1/ftHSaap
	 FKpJjYZ7FMut0CDDpX7z80bhuwlivCC2IXBjG2sBZmT7OgB6mF5I45hWnCuVNg4xUqFdT
	 brc9bHsPzOvC0nxx/r3e/sevF+2wHfQiHJvRkYTqYWMvZxBIG/SPsTbq9mLMP6lkbobVn
	 bkg023/8qAKnIceknwouhaJfedIJQ5jAjqgT+neSNfDpH9sf9jcy7zJ37ZHOqwDjFvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=guido.kraemer@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XEzKIbuJ;
	arc=none smtp.remote-ip=212.227.17.21
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE7606A328;
	Thu,  5 Nov 2026 15:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21EE7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=guido.kraemer@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XEzKIbuJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793893128; x=1794497928; i=guido.kraemer@gmx.de;
	bh=CzkLHzamPhlX9pgW2wiSyKVCqhOdYm38WXyWxxU1dbk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XEzKIbuJVEqu1rTCWGgQft5KANmJguVX3CnocYn6tS+7nqtWtU7DDzmndnvXmaFM
	 UYOiELoAQ4w4cS3TWy/wwOnth23q4tEgNQeYmTTjUGKU6G84AehLG029ZzRBI99dy
	 MW9RvDrgkRQnrWTmQ/lX9H5EOdioBGKEcuNzTvGckU2AOKTrIQBjZS+97PY7twNPp
	 jH/LToK5TrNsHwYNqdSw6XH2Z8F1LOjpQ25qG+PJEFB8T2dv6ou4Bfwd2Af+CjodG
	 rkvS2Bwnqh0i666k4ZC2j89ISxMaGauDJg6YPg78rAkhzMOewaiGjBSrRrXnrR6oD
	 VejhCkoXJuM8xskc/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wuq-1xSJTQ2cMu-0038R9; Thu, 05
 Nov 2026 16:38:48 +0100
Message-ID: <b32202c1-b377-40f0-8cfb-5b51ec461f38@gmx.de>
Date: Thu, 5 Nov 2026 16:38:46 +0100
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
Subject: Re: [PATCH] media: amd: isp4: fix self-deadlock in
 isp4sd_start_stream() error path
To: Caspar Adriani <caspar.adriani@proton.me>, Bin Du <bin.du@amd.com>,
 Nirujogi Pratap <pratap.nirujogi@amd.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Benjamin Chan <Benjamin.Chan@amd.com>, King Li <King.Li@amd.com>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>,
 Yifei Gao <gyf161023@gmail.com>,
 Seifelden Abdelmonem <saif.elden.hatim@gmail.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
Content-Language: de-DE, en-US-large, es-ES
From: Guido Kraemer <guido.kraemer@gmx.de>
In-Reply-To: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cztsfQ7sSvrkHu388n/WvlY1l573+cEWP+CZSh10a0Jvm+QXZWB
 gZ0qp2Cg9K5XCPl6CS9RRQD7vKdtXJasQpyMv4cEIOBh/YUxVmfXrSLbYEHxvqpsn7dHZLV
 jhAb4Mqc/DuLc3UqXjDu1IB72TFGkYrn0F75/IcmdRGq8fqL8+fuURZlOQXz88BJKIXXg+T
 4YMXvVUnTzKNc6Bj7VxUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aQZX5XP/cq8=;/A+5eU0wT+Z5Xwdcz0OBwsIT1hL
 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

Hi Caspar,

I hit this deadlock regularly on an HP ZBook Ultra G1a (Arch 7.2.6 and
CachyOS 7.2.7), usually when Chromium restarted the camera during a
video call. After "fail to get out prop" / "fail to setup output", the
streaming thread hung and every later user of /dev/video0 blocked in
vb2_fop_release until reboot:

   INFO: task ThreadPoolSingl:45879 blocked for more than 122 seconds.
   Call Trace:
    isp4sd_stop_stream.isra.0+0x52/0x200 [amd_isp4_capture]
    isp4sd_enable_streams.cold+0x60/0x2ad [amd_isp4_capture]
    v4l2_subdev_enable_streams+0x27f/0x400 [videodev]
    isp4vid_qops_start_streaming+0x114/0x190 [amd_isp4_capture]
    vb2_start_streaming+0x67/0x130 [videobuf2_common]
    vb2_core_streamon+0x98/0xf0 [videobuf2_common]

Tested on the G1a with v7.3.1 plus this patch and Seifelden's two isp4
fixes, with your sequence: v4l2-ctl --set-fmt-video=3D1920x1080 NV12
=2D-stream-mmap, then the same without --set-fmt-video, then the first
command again. The second run fails with "fail to get out prop" /
"fail to setup output" and VIDIOC_STREAMON returns -EINVAL, v4l2-ctl
exits, and no task is left blocked. The third run starts and stops the
stream normally. Zoom also opened and closed the camera about fifteen
times without a hang.

(On this machine the camera currently gets no frames for an unrelated
reason, the firmware rejects SET_STREAM_CONFIG; I'm reporting that in
a separate thread. The start and stop paths run all the same.)

Tested-by: Guido Kraemer <guido.kraemer@uni-leipzig.de>

Thanks,
Guido


On 10/28/26 15:05, Caspar Adriani wrote:
> isp4sd_start_stream() takes ops_mutex with guard() and, when
> isp4sd_init_stream() or isp4sd_setup_output() fails, jumps to
> err_stop_stream and calls isp4sd_stop_stream(). That function takes
> ops_mutex again, so the task blocks on a mutex it already holds. Every
> later open, close or ioctl on the device then blocks behind it, and
> only a reboot recovers:
>=20
>    INFO: task .v4l2-ctl-wrapp:38440 blocked for more than 122 seconds.
>     isp4sd_stop_stream.isra.0+0x43/0x1d0 [amd_isp4_capture]
>     isp4sd_enable_streams.cold+0x8b/0x26c [amd_isp4_capture]
>     v4l2_subdev_enable_streams+0x1ff/0x360 [videodev]
>     isp4vid_qops_start_streaming+0xf2/0x160 [amd_isp4_capture]
>    INFO: task .v4l2-ctl-wrapp:38440 is blocked on a mutex likely owned
>    by task .v4l2-ctl-wrapp:38440.
>=20
> One way to reach the error path: start and stop a stream, then start
> it again without setting the format. isp4sd_uninit_stream() clears the
> subdev pad format on stop, so isp4sd_get_str_out_prop() fails on the
> second start with "fail to get out prop" and "fail to setup output".
>=20
> Move the body of isp4sd_stop_stream() into __isp4sd_stop_stream(),
> which expects ops_mutex to be held, and call it from the error path.
>=20
> Fixes: 4e5e7a7ddb4a ("media: platform: amd: isp4 subdev and firmware loa=
ding handling added")
> Cc: stable@vger.kernel.org
> Signed-off-by: Caspar Adriani <caspar.adriani@proton.me>
> ---
> Tested on an ASUS ROG Flow Z13 (GZ302EA) on v7.3, with a local,
> not-for-upstream change that adds its OMNI13B1 sensor to the ISP4 ACPI
> tables so the capture device is created. The stock firmware does not
> support that sensor, so no frames arrive, but the start and stop paths
> run. Sequence: v4l2-ctl --set-fmt-video=3D1920x1080 NV12 --stream-mmap,
> stopped after 10 s; the same without --set-fmt-video; then the first
> command again.
>=20
> Without this patch (v7.2.8, same setup) this failure hung the task as
> shown above. With it, VIDIOC_STREAMON returns -EINVAL after "fail to
> get out prop" / "fail to setup output", v4l2-ctl exits, no task is left
> blocked, and the third run starts and stops the stream normally.
> Not run: lockdep (CONFIG_PROVE_LOCKING is off in this kernel).
> ---
>   drivers/media/platform/amd/isp4/isp4_subdev.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/med=
ia/platform/amd/isp4/isp4_subdev.c
> index a108d90ace..08512f060a 100644
> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> @@ -745,15 +745,15 @@ int isp4sd_pwron_and_init(struct v4l2_subdev *sd)
>   	return -EINVAL;
>   }
>  =20
> -static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> -			      struct v4l2_subdev_state *state, u32 pad)
> +static void __isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> +				 struct v4l2_subdev_state *state, u32 pad)
>   {
>   	struct isp4sd_sensor_info *sensor_info =3D &isp_subdev->sensor_info;
>   	struct isp4sd_output_info *output_info =3D &sensor_info->output_info;
>   	struct isp4_interface *ispif =3D &isp_subdev->ispif;
>   	struct device *dev =3D isp_subdev->dev;
>  =20
> -	guard(mutex)(&isp_subdev->ops_mutex);
> +	lockdep_assert_held(&isp_subdev->ops_mutex);
>   	dev_dbg(dev, "status %i\n", output_info->start_status);
>  =20
>   	if (output_info->start_status =3D=3D ISP4SD_START_STATUS_STARTED) {
> @@ -786,6 +786,13 @@ static int isp4sd_stop_stream(struct isp4_subdev *i=
sp_subdev,
>   	}
>  =20
>   	isp4sd_uninit_stream(isp_subdev, state, pad);
> +}
> +
> +static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
> +			      struct v4l2_subdev_state *state, u32 pad)
> +{
> +	guard(mutex)(&isp_subdev->ops_mutex);
> +	__isp4sd_stop_stream(isp_subdev, state, pad);
>  =20
>   	/*
>   	 * Return success to ensure the stop process proceeds,
> @@ -836,7 +843,7 @@ static int isp4sd_start_stream(struct isp4_subdev *i=
sp_subdev,
>   	return 0;
>  =20
>   err_stop_stream:
> -	isp4sd_stop_stream(isp_subdev, state, pad);
> +	__isp4sd_stop_stream(isp_subdev, state, pad);
>   	return ret;
>   }
>  =20
>=20
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261028-isp4-start-stream-deadlock-6c33a97d3297
>=20
> Best regards,
> --
> Caspar Adriani <caspar.adriani@proton.me>

