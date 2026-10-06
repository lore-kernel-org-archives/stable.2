Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355953A5421;
	Tue,  6 Oct 2026 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270417; cv=none; b=fosE8FS8pvMmGtX6bqwtGwBHJdKLNhmPB4Hq7aWHC6LcFBnyA1lVhrbuRWcmroC//R3EpXPEvp/N718XCTzxn7hejopOBOfuVKNA9eg/baNwhthbUEGLXpUX3pu1qNPtDPrNI5/iPlaWaxjhx1mR/vuEE1aA+ZIgHbVemJH2XNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270417; c=relaxed/simple;
	bh=cQxRqSaiZxL4F4PCK3yebx8k0CW4SsErsJmdQgRQYVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXxYDIxrS6D0jTiCi80q2nZ1muvxe3T91vvMNfL+XELJCLdHTA+T53VUVeX0KW8WmFOU9hOOUvveuTJk67X4ZjmGXL3eTMHarWWkzW7qLIAe/mGn6lXd5K90Az4brfZKH4qYC4V8/+v/1J+gCZH8rQTjRxX7GQRUAHWBy38aFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tvidsCKs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tvidsCKs"
Received: from ideasonboard.com (mob-5-90-111-156.net.vodafone.it [5.90.111.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 46466493;
	Tue,  6 Oct 2026 09:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1791270293;
	bh=cQxRqSaiZxL4F4PCK3yebx8k0CW4SsErsJmdQgRQYVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvidsCKsdLju6k3ry4umHRK+Au3IYQvMYM78RppaE/229aIXkHANU+QqzIzf+/XIp
	 JNSl1ZXAEq/H/SqfBLoFc8tobc9f2+NF7377fMrydgOkG5m8guqvsCXFkWG4MLis4f
	 AqaJFQNGvW4gr3sTqEKCRm8OPTDePC8kDtkDwLO0=
Date: Tue, 6 Oct 2026 09:06:44 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Keke Li <keke.li@amlogic.com>, 
	Richard Acayan <mailingradian@gmail.com>, Hans Verkuil <hverkuil@kernel.org>, 
	Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>, 
	Robert Foss <rfoss@kernel.org>, Milen Mitkov <quic_mmitkov@quicinc.com>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Antoine Bouyer <antoine.bouyer@nxp.com>, 
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 00/74] RFC: Switch on IFE YUV, Stats and Params support
 for sm8650
Message-ID: <asSdUQ-2fnvcD-h_@zed>
References: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-0-ed985aefd611@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-0-ed985aefd611@kernel.org>

Hi Bryan

On Mon, Oct 05, 2026 at 07:13:30PM +0200, Bryan O'Donoghue wrote:
> This extensive series restructures CAMSS around the idea of lines and
> outputs more closely matching the concepts in the camera hardware.
>
> To begin with some bug fixing and some dependencies on the OPE series are
> pulled in.
>
> Following that a series of changes to enable the IFE hardware is introduced
> for VFE780.
>
> Supported in this drop:
>
> - YUV output on the pix path
>   YUV downscale 16 and downscale 4 work on a staging branch
>   but with this series at 60 patches I've not included that.
>
> - Stats output
>   Bayer histogram only
>
>   How many stats are intended to be brought out this way ?
>   Consider that scene in The Terminator when the guy in the gun
>   store.
>
>   Gun store owner: "So which will it be"
>   The Terminator: "All"
>
>   More seriously once this series lands then it will be possible to bring
>   out stats for Agatti mitigating the need for calculating stats in
>   software.
>
> - Params application
>   AEC Bayer hist params
>
>   Again there are no limits envisaged on which params are to be enabled.
>
>   "All"
>
> - Testing on HDK sm8650
>
>   There is a repo to test this stuff out:
>
>   https://github.com/0xB0D/ife-tests
>
> Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
> ---
> Antoine Bouyer (2):
>       media: uapi: v4l2-isp: Add extensible statistics
>       media: Documentation: uapi: Update V4L2 ISP for extensible stats
>
> Bryan O'Donoghue (66):
>       media: qcom: camss: vfe: Rename gen3 back to vfe780
>       media: qcom: camss: vfe: Separate VFE 690 from VFE 780/880
>       media: qcom: camss: Fix invalid declaration of PIX for SDM670
>       media: qcom: camss: Fix invalid declaration of PIX for SDM845
>       media: qcom: camss: Fix invalid declaration of PIX for sc8280xp
>       media: qcom: camss: Fix invalid declaration of PIX for x1e80100
>       media: qcom: camss: csid: Configure the stream on every s_stream
>       media: qcom: camss: Switch existing vfe_formats_pix_845 to vfe_formats_rdi_845
>       media: qcom: camss: Define PIX formats for x1e PIX interface
>       media: qcom: camss: vfe: Add helper vfe_bus_v3_packer_fmt()
>       media: qcom: camss: vfe: Represent output as an array instead of a singleton
>       media: qcom: camss: vfe: Move video_out from vfe_line to vfe_output
>       media: qcom: camss: vfe: Represent vfe wm inside of a struct
>       media: qcom: camss: vfe: Add is_pix to struct line
>       media: qcom: camss: vfe: Add comp_group to struct vfe_wm
>       media: qcom: camss: vfe: Define vfe v3 completion group enum
>       media: qcom: camss: vfe: Define output based VFE controls
>       media: qcom: camss: vfe: Call vfe_subdev_init after not before significant enumeration
>       media: qcom: camss: vfe: Move legacy VFE bus client assignment to msm_vfe_subdev_init
>       media: qcom: camss: vfe: Add planes identifier to struct wm
>       media: qcom: camss: vfe: Specify number of pads via line->num_pads
>       media: qcom: camss: vfe: Add support for starting multiple write-masters in one output's group
>       media: qcom: camss: vfe: Add support for updating multiple write-masters within an output group
>       media: qcom: camss: vfe: Update an output group's write masters on buffer done
>       media: qcom: camss: vfe: Add support for stopping outputs which contain multiple write masters
>       media: qcom: camss: vfe: Stop an output group once
>       media: qcom: camss: vfe: Add helper __vfe_pix_format_is_raw
>       media: qcom: camss: csid: Add helper function csid_ipp_bayer_pattern
>       media: qcom: camss: vfe: Decompose repeated code down to __vfe_src_pad_default()
>       media: qcom: camss: vfe: Eliminate ever expanding src_pad_code switch logic
>       media: qcom: camss: vfe: Add Bayer to YUV conversion switch cases for PIX
>       media: qcom: camss: vfe-gen3: Define full array of write-masters
>       media: qcom: camss: vfe-gen3: Enable PIX formats on PIX interfaces
>       media: qcom: camss: vfe: Pass struct line to wm_stop
>       media: qcom: camss: vfe-780: Use bus-client to derive write master index
>       media: qcom: camss: vfe-780: Switch on YUV pix path
>       media: qcom: camss: vfe: Add support for pix pad data-types
>       media: qcom: camss: vfe: Add helper methods to enumerate output descriptors
>       media: qcom: camss: Pass new struct camss_buf_done_info to camss_buf_done
>       media: qcom: camss: Add a status field to camss_buf_done_info
>       media: qcom: camss: csid-gen3: Enable the IPP path
>       media: qcom: camss: vfe: Pass the completion info to vfe_buf_done()
>       media: qcom: camss: vfe: Pass the buffer to vfe_wm_update()
>       media: qcom: camss: Add the SM8650 IFE pixel pipe configuration
>       media: qcom: camss: csid-gen3: Define the IPP reg update port in the header
>       media: qcom: camss: vfe-880: Program the pixel pipe outside output_lock
>       media: qcom: camss: vfe: Make is_pix the only test for the pixel path
>       media: qcom: camss: csid-gen3: Route IPP completions to the port the IPP feeds
>       media: qcom: camss: vfe-780: Add full-resolution YUV on the PIX line
>       media: uapi: Add CAMSS ISP statistics definition
>       media: Documentation: uapi: Add qcom-camss ISP statistics
>       media: qcom: camss: vfe: Select line-based mode for the pixel path's video node
>       media: qcom: camss: vfe: Size the pixel path clock by its pixels per clock
>       media: qcom: camss: vfe: Size the outputs for the PIX line and set up each one
>       media: qcom: camss: video: Support metadata capture nodes
>       media: qcom: camss: vfe: Register a statistics node for the pixel line
>       media: qcom: camss: vfe: Complete pixel line outputs on their own completion group
>       media: qcom: camss: vfe-780: Produce the AEC Bayer histogram statistics
>       media: uapi: Add the CAMSS AEC Bayer histogram configuration
>       media: v4l2: Add the Qualcomm CAMSS ISP parameters format
>       media: Documentation: uapi: Add the CAMSS IFE parameters
>       media: qcom: camss: video: Support metadata output nodes
>       media: qcom: camss: vfe: Register and apply a parameters node for the pixel line
>       media: qcom: camss: vfe-780: Apply the AEC Bayer histogram parameters
>       media: qcom: camss: vfe-780: Drive the write masters through the output ops
>       media: qcom: camss: vfe: Pass the write master its address again
>
> Jacopo Mondi (4):
>       media: v4l2-isp: Rename v4l2_isp_params_buffer_size
>       media: v4l2-isp: Add per-block validation callback
>       media: amlogic-c3: Implement per-block validation
>       media: v4l2-isp: Add helpers for stats buffer

What branch are you based on ? This has been collected for 7.3 and
if you base your work on media-committers/next you should find it
there

Thanks
  j

>
> Loic Poulain (2):
>       media: uapi: Add CAMSS ISP configuration definition
>       media: Documentation: uapi: Add qcom-camss ISP params documentation
>
>  .../userspace-api/media/v4l/meta-formats.rst       |   1 +
>  .../userspace-api/media/v4l/metafmt-qcom-isp.rst   | 219 +++++
>  Documentation/userspace-api/media/v4l/v4l2-isp.rst |  45 +-
>  MAINTAINERS                                        |   1 +
>  .../media/platform/amlogic/c3/isp/c3-isp-params.c  |  42 +-
>  .../media/platform/arm/mali-c55/mali-c55-params.c  |  12 +-
>  drivers/media/platform/qcom/camss/Kconfig          |   2 +
>  drivers/media/platform/qcom/camss/Makefile         |   4 +-
>  drivers/media/platform/qcom/camss/camss-csid-680.c |   8 +-
>  .../media/platform/qcom/camss/camss-csid-gen3.c    | 131 ++-
>  .../media/platform/qcom/camss/camss-csid-gen3.h    |   3 +
>  drivers/media/platform/qcom/camss/camss-csid.c     |  37 +-
>  drivers/media/platform/qcom/camss/camss-csid.h     |  18 +-
>  drivers/media/platform/qcom/camss/camss-vfe-17x.c  |  10 +-
>  drivers/media/platform/qcom/camss/camss-vfe-340.c  |  12 +-
>  drivers/media/platform/qcom/camss/camss-vfe-4-1.c  |  20 +-
>  drivers/media/platform/qcom/camss/camss-vfe-4-7.c  |  34 +-
>  drivers/media/platform/qcom/camss/camss-vfe-4-8.c  |  34 +-
>  drivers/media/platform/qcom/camss/camss-vfe-480.c  |  19 +-
>  drivers/media/platform/qcom/camss/camss-vfe-680.c  |   4 +-
>  .../camss/{camss-vfe-gen3.c => camss-vfe-690.c}    |  53 +-
>  drivers/media/platform/qcom/camss/camss-vfe-780.c  | 419 +++++++++
>  .../media/platform/qcom/camss/camss-vfe-880-pp.c   | 629 +++++++++++++
>  .../media/platform/qcom/camss/camss-vfe-880-pp.h   |  13 +
>  drivers/media/platform/qcom/camss/camss-vfe-gen1.c |  96 +-
>  drivers/media/platform/qcom/camss/camss-vfe.c      | 985 ++++++++++++++++++---
>  drivers/media/platform/qcom/camss/camss-vfe.h      | 156 +++-
>  drivers/media/platform/qcom/camss/camss-video.c    | 235 ++++-
>  drivers/media/platform/qcom/camss/camss-video.h    |   8 +
>  drivers/media/platform/qcom/camss/camss.c          | 156 ++--
>  drivers/media/platform/qcom/camss/camss.h          |   8 +-
>  drivers/media/v4l2-core/v4l2-ioctl.c               |   2 +
>  drivers/media/v4l2-core/v4l2-isp.c                 |  55 ++
>  include/media/v4l2-isp.h                           |  94 +-
>  include/uapi/linux/media/v4l2-isp.h                | 125 ++-
>  include/uapi/linux/qcom-camss-config.h             | 273 ++++++
>  include/uapi/linux/videodev2.h                     |   4 +
>  37 files changed, 3464 insertions(+), 503 deletions(-)
> ---
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> change-id: 20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-aa75cdf2c39b
>
> Best regards,
> --
> Bryan O'Donoghue <bod@kernel.org>
>
