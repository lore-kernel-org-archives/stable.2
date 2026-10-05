Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060D3033C6;
	Mon,  5 Oct 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220540; cv=none; b=shvJknWD2n+vv8A9Gt8rIf5sGQsRttoktuPtz6hD8BoUcGn83rKW9rt1Kil4DxkrwpexgQJ36vuvdh43jEdAuJBXs7qoVeYSySJUyo8FeJzyffZ2qmGMOvUtN4o+TRKe19EBMKfc0/gee1F+TJ0S2i1s/v+gk2EakEVIqGb+l9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220540; c=relaxed/simple;
	bh=VTqElObZzu3AgucPucei34XLiLuzYqPFin6Re7K65MQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AtAOzPi7QPu/0GGLS6IDGrGlTDzTPvaSH7dIDY6WUCrJNFhyQ9jeg/iP9RV5aPpSCSsRk2MCXA7kaSwAuvRixsYGnPEjg6se8M2Ita7lvATGnz9ipeh912o+a+Z3MbXn1YRzoUWfD2ZxTU8N04g0Bc10nVLQnK6T4YnVp31zZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2asujR8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2asujR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB95D1F000FF;
	Mon,  5 Oct 2026 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220538;
	bh=ELfJklC1/4nQ0PiQSEKiemHMjLa23LJTS4uJyWbEWFk=;
	h=From:Subject:Date:To:Cc;
	b=P2asujR8qUcK1ppDStFR++Eme5EdYyGt1EvMEZcM5cY86iQxiaY3wqK1XYZkm1gYa
	 ZVvJJk5SLJEBrBBsAj3QbrOiroDcjspr48KLzVdK06H1wRbsHs8md3E1yh6R2ikVos
	 WmiZazuLyr0ox6rIVXRBECmEOACUXaQXxngvRm7GzJWf0a4TmncbBbKFJGw8ftZEDp
	 gzkDzG9Kyt2BkrjWqbrpfKC61g2liWCiILoP2jkFeYkuVVcYvYUxH6dH4Q85YcAeI+
	 BMXFDGSeBb3/QZq8eY7w83j9KvACZ/mBDVehMzgSG24LeUkpunJUDc3bGL7VeEBUYc
	 t/oSUaVbIV44A==
From: Bryan O'Donoghue <bod@kernel.org>
Subject: [PATCH 00/74] RFC: Switch on IFE YUV, Stats and Params support for
 sm8650
Date: Mon, 05 Oct 2026 19:13:30 +0200
Message-Id: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-0-ed985aefd611@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBCF4auQWTvJUFNQr2JclOlURqWSVgwJ4
 e4U3b1v878FsiSVDJdqgSRfzfqOBfWhAu5dvAuqLwZDpqmJLL40TjMOTmNZgi0azMOpsYS9f2I
 KjITOtZZ9MHw8d1BKY5Kg8+/levs7T91D+LOnYV03iu/MLocAAAA=
X-Change-ID: 20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-aa75cdf2c39b
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, Keke Li <keke.li@amlogic.com>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, 
 Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>, 
 Robert Foss <rfoss@kernel.org>, Milen Mitkov <quic_mmitkov@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bod@kernel.org>, 
 Antoine Bouyer <antoine.bouyer@nxp.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9318; i=bod@kernel.org;
 h=from:subject:message-id; bh=VTqElObZzu3AgucPucei34XLiLuzYqPFin6Re7K65MQ=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqw9r5toi356/VgegBCJEcZE/1kWweZp8sgF4cE
 N5G1uATFoiJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCasPa+QAKCRAicTuzoY3I
 OrlqEACVn31wPj0EBFz43m3xehG9k/3yykJS2/OSfSUx/wGOCLOV92B5b9HEeju6HfdsXW6OOUv
 WbTMsstP5BcT32YsFFxQ+kJZx9RXSfhJ4vZH9mdWdVM8ytt6sS9IkIa4IucHDNJ7ZcI7BpEAq28
 VkuIISvWz2QuX5j6Go0lm3wQcadwUBhyC2/fiqXk6/qCvIZrEszEFafPAc2lrMiFfKYkzhx7l64
 F1dmBx9WukmQLcaujiTwu3lSECxIL7dhtymtPStQ4NRIunndIA8NVOD0c+gr32/1vraZLpbJxPf
 xK3g6ASg80QY/M7Rtl4pXmMavY4a1N8oMYbiIx6tiJVzgPynEVRI/dAJH1rX2rSh4H13UBP4+SF
 aapb/FMfAVkVAfNe/1zZy1p4bclXSLsOSJhHCUr/Cq3R/O27MDB6u+m5hUYAFWS+wjEEDOoTsoW
 RQSJ3U8a51MaN86eqbIMwMwpJJ810Q8XqudYoTcl0Jr2CYyvokWkMNepmCz5ChUYdLwvfEc8KWE
 DXaqzZt43y2KV70v/jJ2rCzejEh+sazIFU8ZxTLc9W3p0HbqNaQ66OhD8bQbf2R4zb/dgoEkXCI
 0iri56FzTFeXFbGTp3yxXfOTNjmTEBx5Q8OZMIJU8cfBMm5o6EY2RJCIiNgH/AZIpjBasFk0HWX
 yW5scllHHQBII3g==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

This extensive series restructures CAMSS around the idea of lines and
outputs more closely matching the concepts in the camera hardware.

To begin with some bug fixing and some dependencies on the OPE series are
pulled in.

Following that a series of changes to enable the IFE hardware is introduced
for VFE780.

Supported in this drop:

- YUV output on the pix path
  YUV downscale 16 and downscale 4 work on a staging branch
  but with this series at 60 patches I've not included that.

- Stats output
  Bayer histogram only

  How many stats are intended to be brought out this way ?
  Consider that scene in The Terminator when the guy in the gun
  store.

  Gun store owner: "So which will it be"
  The Terminator: "All"

  More seriously once this series lands then it will be possible to bring
  out stats for Agatti mitigating the need for calculating stats in
  software.

- Params application
  AEC Bayer hist params

  Again there are no limits envisaged on which params are to be enabled.

  "All"

- Testing on HDK sm8650

  There is a repo to test this stuff out:

  https://github.com/0xB0D/ife-tests

Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
---
Antoine Bouyer (2):
      media: uapi: v4l2-isp: Add extensible statistics
      media: Documentation: uapi: Update V4L2 ISP for extensible stats

Bryan O'Donoghue (66):
      media: qcom: camss: vfe: Rename gen3 back to vfe780
      media: qcom: camss: vfe: Separate VFE 690 from VFE 780/880
      media: qcom: camss: Fix invalid declaration of PIX for SDM670
      media: qcom: camss: Fix invalid declaration of PIX for SDM845
      media: qcom: camss: Fix invalid declaration of PIX for sc8280xp
      media: qcom: camss: Fix invalid declaration of PIX for x1e80100
      media: qcom: camss: csid: Configure the stream on every s_stream
      media: qcom: camss: Switch existing vfe_formats_pix_845 to vfe_formats_rdi_845
      media: qcom: camss: Define PIX formats for x1e PIX interface
      media: qcom: camss: vfe: Add helper vfe_bus_v3_packer_fmt()
      media: qcom: camss: vfe: Represent output as an array instead of a singleton
      media: qcom: camss: vfe: Move video_out from vfe_line to vfe_output
      media: qcom: camss: vfe: Represent vfe wm inside of a struct
      media: qcom: camss: vfe: Add is_pix to struct line
      media: qcom: camss: vfe: Add comp_group to struct vfe_wm
      media: qcom: camss: vfe: Define vfe v3 completion group enum
      media: qcom: camss: vfe: Define output based VFE controls
      media: qcom: camss: vfe: Call vfe_subdev_init after not before significant enumeration
      media: qcom: camss: vfe: Move legacy VFE bus client assignment to msm_vfe_subdev_init
      media: qcom: camss: vfe: Add planes identifier to struct wm
      media: qcom: camss: vfe: Specify number of pads via line->num_pads
      media: qcom: camss: vfe: Add support for starting multiple write-masters in one output's group
      media: qcom: camss: vfe: Add support for updating multiple write-masters within an output group
      media: qcom: camss: vfe: Update an output group's write masters on buffer done
      media: qcom: camss: vfe: Add support for stopping outputs which contain multiple write masters
      media: qcom: camss: vfe: Stop an output group once
      media: qcom: camss: vfe: Add helper __vfe_pix_format_is_raw
      media: qcom: camss: csid: Add helper function csid_ipp_bayer_pattern
      media: qcom: camss: vfe: Decompose repeated code down to __vfe_src_pad_default()
      media: qcom: camss: vfe: Eliminate ever expanding src_pad_code switch logic
      media: qcom: camss: vfe: Add Bayer to YUV conversion switch cases for PIX
      media: qcom: camss: vfe-gen3: Define full array of write-masters
      media: qcom: camss: vfe-gen3: Enable PIX formats on PIX interfaces
      media: qcom: camss: vfe: Pass struct line to wm_stop
      media: qcom: camss: vfe-780: Use bus-client to derive write master index
      media: qcom: camss: vfe-780: Switch on YUV pix path
      media: qcom: camss: vfe: Add support for pix pad data-types
      media: qcom: camss: vfe: Add helper methods to enumerate output descriptors
      media: qcom: camss: Pass new struct camss_buf_done_info to camss_buf_done
      media: qcom: camss: Add a status field to camss_buf_done_info
      media: qcom: camss: csid-gen3: Enable the IPP path
      media: qcom: camss: vfe: Pass the completion info to vfe_buf_done()
      media: qcom: camss: vfe: Pass the buffer to vfe_wm_update()
      media: qcom: camss: Add the SM8650 IFE pixel pipe configuration
      media: qcom: camss: csid-gen3: Define the IPP reg update port in the header
      media: qcom: camss: vfe-880: Program the pixel pipe outside output_lock
      media: qcom: camss: vfe: Make is_pix the only test for the pixel path
      media: qcom: camss: csid-gen3: Route IPP completions to the port the IPP feeds
      media: qcom: camss: vfe-780: Add full-resolution YUV on the PIX line
      media: uapi: Add CAMSS ISP statistics definition
      media: Documentation: uapi: Add qcom-camss ISP statistics
      media: qcom: camss: vfe: Select line-based mode for the pixel path's video node
      media: qcom: camss: vfe: Size the pixel path clock by its pixels per clock
      media: qcom: camss: vfe: Size the outputs for the PIX line and set up each one
      media: qcom: camss: video: Support metadata capture nodes
      media: qcom: camss: vfe: Register a statistics node for the pixel line
      media: qcom: camss: vfe: Complete pixel line outputs on their own completion group
      media: qcom: camss: vfe-780: Produce the AEC Bayer histogram statistics
      media: uapi: Add the CAMSS AEC Bayer histogram configuration
      media: v4l2: Add the Qualcomm CAMSS ISP parameters format
      media: Documentation: uapi: Add the CAMSS IFE parameters
      media: qcom: camss: video: Support metadata output nodes
      media: qcom: camss: vfe: Register and apply a parameters node for the pixel line
      media: qcom: camss: vfe-780: Apply the AEC Bayer histogram parameters
      media: qcom: camss: vfe-780: Drive the write masters through the output ops
      media: qcom: camss: vfe: Pass the write master its address again

Jacopo Mondi (4):
      media: v4l2-isp: Rename v4l2_isp_params_buffer_size
      media: v4l2-isp: Add per-block validation callback
      media: amlogic-c3: Implement per-block validation
      media: v4l2-isp: Add helpers for stats buffer

Loic Poulain (2):
      media: uapi: Add CAMSS ISP configuration definition
      media: Documentation: uapi: Add qcom-camss ISP params documentation

 .../userspace-api/media/v4l/meta-formats.rst       |   1 +
 .../userspace-api/media/v4l/metafmt-qcom-isp.rst   | 219 +++++
 Documentation/userspace-api/media/v4l/v4l2-isp.rst |  45 +-
 MAINTAINERS                                        |   1 +
 .../media/platform/amlogic/c3/isp/c3-isp-params.c  |  42 +-
 .../media/platform/arm/mali-c55/mali-c55-params.c  |  12 +-
 drivers/media/platform/qcom/camss/Kconfig          |   2 +
 drivers/media/platform/qcom/camss/Makefile         |   4 +-
 drivers/media/platform/qcom/camss/camss-csid-680.c |   8 +-
 .../media/platform/qcom/camss/camss-csid-gen3.c    | 131 ++-
 .../media/platform/qcom/camss/camss-csid-gen3.h    |   3 +
 drivers/media/platform/qcom/camss/camss-csid.c     |  37 +-
 drivers/media/platform/qcom/camss/camss-csid.h     |  18 +-
 drivers/media/platform/qcom/camss/camss-vfe-17x.c  |  10 +-
 drivers/media/platform/qcom/camss/camss-vfe-340.c  |  12 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c  |  20 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c  |  34 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-8.c  |  34 +-
 drivers/media/platform/qcom/camss/camss-vfe-480.c  |  19 +-
 drivers/media/platform/qcom/camss/camss-vfe-680.c  |   4 +-
 .../camss/{camss-vfe-gen3.c => camss-vfe-690.c}    |  53 +-
 drivers/media/platform/qcom/camss/camss-vfe-780.c  | 419 +++++++++
 .../media/platform/qcom/camss/camss-vfe-880-pp.c   | 629 +++++++++++++
 .../media/platform/qcom/camss/camss-vfe-880-pp.h   |  13 +
 drivers/media/platform/qcom/camss/camss-vfe-gen1.c |  96 +-
 drivers/media/platform/qcom/camss/camss-vfe.c      | 985 ++++++++++++++++++---
 drivers/media/platform/qcom/camss/camss-vfe.h      | 156 +++-
 drivers/media/platform/qcom/camss/camss-video.c    | 235 ++++-
 drivers/media/platform/qcom/camss/camss-video.h    |   8 +
 drivers/media/platform/qcom/camss/camss.c          | 156 ++--
 drivers/media/platform/qcom/camss/camss.h          |   8 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |   2 +
 drivers/media/v4l2-core/v4l2-isp.c                 |  55 ++
 include/media/v4l2-isp.h                           |  94 +-
 include/uapi/linux/media/v4l2-isp.h                | 125 ++-
 include/uapi/linux/qcom-camss-config.h             | 273 ++++++
 include/uapi/linux/videodev2.h                     |   4 +
 37 files changed, 3464 insertions(+), 503 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-aa75cdf2c39b

Best regards,
--  
Bryan O'Donoghue <bod@kernel.org>

