Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793196387;
	b=L4BNq3jI5c7icIV4FVX8ZnimWqdQO07yXaoqisYp9IKvCKeBRvevVbK/7Y2RFXAKg36A
	 fjYhRBZkxWW7lifc+RjdGnHuhTMKB4BSJ3nSASfZQFZWdPKEdIcGyKO0iXkrSOIJ86Ocd
	 2Ip3/4vu++xeToNxD9Wom/BZbCRuwkQ9hBVUbFfW9dy3UP2zDYurrEVdtwrEnpSEMgeLN
	 /oRasTO0h1yhIIB5tATGGuNc3VJ057YzfIoTjT078NbR3VuvEtZqsW6WkoqslX98Akhk9
	 EC/tGqQntiPqBPr/Mybk3dyN1kLomx0AqIZK76qWm6kAY6AW5Ni3QI0b3RwcIrTIYKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196387;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=i+4HsX7u15luUerB3ybl59m8EoZRssUv4SeGg+A6dv0=;
	b=CLZuKhWdg83zr3QRBtMY3nS1uh6tQE798PAJ76AnLGLYVjbMQSQ7c+fK+b6tX5yicjmp
	 wWwvk23dgaHfywM4B7Tg38NqpzWmUWHz5SNcEjh62SlaYbRQ53t/E93qBMRtfoHwZbmqB
	 F2TBXm2fuhANZgRH+fXfgGEOGnCnASXD4p/muY2TZdN9dRFDkAUrpCUbr0vZZgN/Cno9F
	 RgM9eclQujbau5PapHPNdmOeATIpIgomsuLhRj3BKuSTWSBZVzdeFLc8kKTFaz4lkQn4j
	 oKTqgZ4vaFKK9lPxIT7cknRCtscMnM4UOw/0Jy4+c7NHuXBP2HjzI7LNYiKoE98WTbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeDRYdXG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E8606A31D;
	Wed, 28 Oct 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeDRYdXG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793196387;
	b=XVXZv3hZgk9MAUNRGYjhnuNZn9/grcqydX5dIZ9dJxjtlCwUoPBhMF2O/W359uUGovIm
	 Zx9m/VB6jOKE5dqd8Ca5tqtS1vf/8PvQatDooK52N+vCHMSyde/sDPCFt7en/c54EAXkn
	 i+qX/J7tb3KrJvlys4j0vExQubHwe9xBjke7qK4L047lvgFpHljoD/ezlUlkOKbv3QG8B
	 fSoJYBe/qQgXcFG3ec5P5wJZwyiSWtaLjJq0t2vCRtApr0vIiR8U/V8b/bePuKu/SocuC
	 CM5Sy3xTO92GuaWSessgxKnizOvlLoVhZbXmla2IABC+XQim1exWlV+iWiWIxBmhtTw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793196387;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=i+4HsX7u15luUerB3ybl59m8EoZRssUv4SeGg+A6dv0=;
	b=g/hj7QZpWBfrT3RCzOKi0yNahFeiEvd3s/AatAinfoIWYZAekvTYQfB8EDbYUrxciVG6
	 XLkyPrSDvW0fo3+V6hN0INzMsmBITrHbhmGUGIWdAURt5AYMSRncOF2CCkQpJbrVREGvS
	 mGQQK9bpahYIiZE9VY5I3BctUDWgjl1AivZ1JuVEo2MAKk2zjqAzyTL1d7xVgYAjHzPIJ
	 Ui7iZxQX+nVMuVBPffqejszmAK31a/XR6l/VMdO/5le3XoXMjHu0ttQk+a4l49wOQck3I
	 DXhPyKc+f/SHsTpwjMvT2bkEfivfzPMwhhRghSAni9FK6EtvTmDNZSHnX3O9j5bJ0jQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 60FE91F01825;
	Wed, 28 Oct 2026 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196386;
	bh=i+4HsX7u15luUerB3ybl59m8EoZRssUv4SeGg+A6dv0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=VeDRYdXGaQMPygta93Tspvu7im++IALOP+LLYT7m1BuddzgBDsgIh1aw7Jeqnhzrc
	 18oqBQ8frY+lBLKH7gYkC3wZ3XS0IpebSX9z7hV1eIpZg6u6NnTJIhA8pLpei+4roS
	 tLFw1h8EIxfKMRSS0jSlD39WnZO6n1hAoC7JdSlZlNrohK4XUwoqbg0QlO+s4UcGGv
	 eVGQepuwEPhdlhgA+Awi2XGtTZsGcgdN6fKxCb/g6u8lD8Jxg+cKV3NTF7PFiDFrcF
	 MMXgMD/HROjO4+FY/zagtBRSBmL9bBmTmhRW3ntkwdp/1Xh82V4hYLMW8E9QUiHtCX
	 BLy5e26CLlZBg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B0CDF4548C;
	Wed, 28 Oct 2026 14:06:25 +0000 (UTC)
From: Caspar Adriani via B4 Relay <devnull+caspar.adriani.proton.me@kernel.org>
Date: Wed, 28 Oct 2026 15:05:41 +0100
Subject: [PATCH] media: amd: isp4: fix self-deadlock in
 isp4sd_start_stream() error path
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
X-B4-Tracking: v=1; b=H4sIADQB4moC/yXMTQ6CQAxA4auQrm0CMwbEqxgWdaZq/QHSDsSEc
 HcH3Lzk27wFjFXY4FwsoDyLydBnVIcCwoP6O6PEbHClq6vSnVBsPKIl0pSrTB+MTPE9hBfWwXt
 qm+hd20AejMo3+e7zS/e3Tdcnh7QdYV1/FCsNcX4AAAA=
X-Change-ID: 20261028-isp4-start-stream-deadlock-6c33a97d3297
To: Bin Du <bin.du@amd.com>, Nirujogi Pratap <pratap.nirujogi@amd.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Benjamin Chan <Benjamin.Chan@amd.com>, King Li <King.Li@amd.com>, 
 Sultan Alsawaf <sultan@kerneltoast.com>, 
 Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>, 
 Yifei Gao <gyf161023@gmail.com>, 
 Seifelden Abdelmonem <saif.elden.hatim@gmail.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Caspar Adriani <caspar.adriani@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793196385; l=4193;
 i=caspar.adriani@proton.me; s=20261028; h=from:subject:message-id;
 bh=Wpb8Myl41MGt4qqba1ihIdNcWGW2EqaKevO8Ep7ksRM=;
 b=bqMhtGPN1DmAUCg+oEEF0sAc5Qdp3/5Vtsb+TW6TWfV0LK1NrFyYsGEam0v0Jbb+UtCnbQCRu
 2KQX3yfy2+FCZ4kjFQmfv1nJz3/4VAfGwvXGZ/DZw/WIc7AOT89ldJA
X-Developer-Key: i=caspar.adriani@proton.me; a=ed25519;
 pk=cTxx5jb7r3X/atKU2VZ3+evuxnjAt/muekxKfcMI4Hc=
X-Endpoint-Received: by B4 Relay for caspar.adriani@proton.me/20261028 with
 auth_id=1344
X-Original-From: Caspar Adriani <caspar.adriani@proton.me>
Reply-To: caspar.adriani@proton.me
Content-Transfer-Encoding: 7bit

From: Caspar Adriani <caspar.adriani@proton.me>

isp4sd_start_stream() takes ops_mutex with guard() and, when
isp4sd_init_stream() or isp4sd_setup_output() fails, jumps to
err_stop_stream and calls isp4sd_stop_stream(). That function takes
ops_mutex again, so the task blocks on a mutex it already holds. Every
later open, close or ioctl on the device then blocks behind it, and
only a reboot recovers:

  INFO: task .v4l2-ctl-wrapp:38440 blocked for more than 122 seconds.
   isp4sd_stop_stream.isra.0+0x43/0x1d0 [amd_isp4_capture]
   isp4sd_enable_streams.cold+0x8b/0x26c [amd_isp4_capture]
   v4l2_subdev_enable_streams+0x1ff/0x360 [videodev]
   isp4vid_qops_start_streaming+0xf2/0x160 [amd_isp4_capture]
  INFO: task .v4l2-ctl-wrapp:38440 is blocked on a mutex likely owned
  by task .v4l2-ctl-wrapp:38440.

One way to reach the error path: start and stop a stream, then start
it again without setting the format. isp4sd_uninit_stream() clears the
subdev pad format on stop, so isp4sd_get_str_out_prop() fails on the
second start with "fail to get out prop" and "fail to setup output".

Move the body of isp4sd_stop_stream() into __isp4sd_stop_stream(),
which expects ops_mutex to be held, and call it from the error path.

Fixes: 4e5e7a7ddb4a ("media: platform: amd: isp4 subdev and firmware loading handling added")
Cc: stable@vger.kernel.org
Signed-off-by: Caspar Adriani <caspar.adriani@proton.me>
---
Tested on an ASUS ROG Flow Z13 (GZ302EA) on v7.3, with a local,
not-for-upstream change that adds its OMNI13B1 sensor to the ISP4 ACPI
tables so the capture device is created. The stock firmware does not
support that sensor, so no frames arrive, but the start and stop paths
run. Sequence: v4l2-ctl --set-fmt-video=1920x1080 NV12 --stream-mmap,
stopped after 10 s; the same without --set-fmt-video; then the first
command again.

Without this patch (v7.2.8, same setup) this failure hung the task as
shown above. With it, VIDIOC_STREAMON returns -EINVAL after "fail to
get out prop" / "fail to setup output", v4l2-ctl exits, no task is left
blocked, and the third run starts and stops the stream normally.
Not run: lockdep (CONFIG_PROVE_LOCKING is off in this kernel).
---
 drivers/media/platform/amd/isp4/isp4_subdev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
index a108d90ace..08512f060a 100644
--- a/drivers/media/platform/amd/isp4/isp4_subdev.c
+++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
@@ -745,15 +745,15 @@ int isp4sd_pwron_and_init(struct v4l2_subdev *sd)
 	return -EINVAL;
 }
 
-static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
-			      struct v4l2_subdev_state *state, u32 pad)
+static void __isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
+				 struct v4l2_subdev_state *state, u32 pad)
 {
 	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
 	struct isp4sd_output_info *output_info = &sensor_info->output_info;
 	struct isp4_interface *ispif = &isp_subdev->ispif;
 	struct device *dev = isp_subdev->dev;
 
-	guard(mutex)(&isp_subdev->ops_mutex);
+	lockdep_assert_held(&isp_subdev->ops_mutex);
 	dev_dbg(dev, "status %i\n", output_info->start_status);
 
 	if (output_info->start_status == ISP4SD_START_STATUS_STARTED) {
@@ -786,6 +786,13 @@ static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
 	}
 
 	isp4sd_uninit_stream(isp_subdev, state, pad);
+}
+
+static int isp4sd_stop_stream(struct isp4_subdev *isp_subdev,
+			      struct v4l2_subdev_state *state, u32 pad)
+{
+	guard(mutex)(&isp_subdev->ops_mutex);
+	__isp4sd_stop_stream(isp_subdev, state, pad);
 
 	/*
 	 * Return success to ensure the stop process proceeds,
@@ -836,7 +843,7 @@ static int isp4sd_start_stream(struct isp4_subdev *isp_subdev,
 	return 0;
 
 err_stop_stream:
-	isp4sd_stop_stream(isp_subdev, state, pad);
+	__isp4sd_stop_stream(isp_subdev, state, pad);
 	return ret;
 }
 

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261028-isp4-start-stream-deadlock-6c33a97d3297

Best regards,
--  
Caspar Adriani <caspar.adriani@proton.me>


