Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645331;
	b=27PSg/hrnsXfFYS28yqyT/+rh+ggEMe0WPjdAkE8aT3lT8ptl1RAOENsVY0b1dgbUBcB
	 Sk019mz1vAqZnRlSWTZqew1evZUS8KMkykPi1LsTe+hH6bn8yAbcMay+cyLj8bqUOoIdd
	 qEIaHOpR7uWzOUAvesKnncyuczncWDY9S0Y2sPY6YLNBXz+tcIuS8C0CVgyUd4WpQyWAq
	 3Ao8Km9fy9FHF4XCnrS8GncxhmMFKf452R9Wi/wOnlCbaZVnRDyW0gKoacSp96mB98dmG
	 cRFoZSlJlbHSTKLa0+24cJDtlUXHqdvVsqxj8rwL0wytTDEHhoCSR/X0rnFsw9hv2mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QW8zqydOTZ07N3+e36tZRL749kq/NvBgBV68uNCfZKc=;
	b=JiWY9UL8YitnT0/z7kTvD/vMYF4fi1u+y7J9AcfGYWJrchq7Re3TByOiKQbtTk3wkCu8
	 ANlwTDOypOEeTJpy6Lpv6Jmsi/8hlinoOVzkH92qKYMNRz4MpDHvr8jrFoHGs15VGKzff
	 7+mVztwaFS47O9bX/eho414Gv3O3x4diANGspNGnSKY+hWsJCO9X648LC5hWIBufTGb8d
	 MSEdcxgXjeMhPAXswSdf8maI5Xaev+Tl/Xh0Q75m6OQLPw1wPMtUEzjc72CI5SB/gW/Fc
	 k6Jz3W46MaN6k/lEsJ489b7uPUgounANSPpIWgInnTyY6bWginbUCCF+b32JCVhD2Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jl7zDihx;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D14606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D14606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jl7zDihx
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386177b0516so15907974eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645330; x=1796250130; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QW8zqydOTZ07N3+e36tZRL749kq/NvBgBV68uNCfZKc=;
        b=Jl7zDihxusFu1wz1wydCPtGP0LSswruJDsp/3ewbNWG39zidQO7gunXz6/43rJ9TGw
         pe4H0AluCuVa3eJYgvbKsPngfgSa29zcZKCQ5hhS2DeNAQc2NgrvDD3UDnOAMfHLCEXR
         3zbLcqPsmjxDuf6BZxk+EZ5YhTLUQtMu6oIslaDa/Onz8F+u9B7B9Fog4lJXwwhVHKhT
         69j9CZDQkaQ9OwgwWcLNPL72gFx60AClkZlxZbHIsBgZgbbhGvy2kpM/olNoevYhbTro
         rv45t/XCLUvkpuIilx6qQg2/UYWcablkFuLUWOhfgc0s8oglvqvqvUjZ/YT4NlLBK//o
         VA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645330; x=1796250130;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QW8zqydOTZ07N3+e36tZRL749kq/NvBgBV68uNCfZKc=;
        b=qI+KvlOvSKrLWSAshmxpjCi6rfoTBQm/dMFhru3UTYhVYGCPcWewAs2S0X5CO0nEQ8
         KHSIJSrg0JhQ0m9Wg45MDg9uTAt1W+IJ6ZoLut9EcqZW7JiIpImvEfDuObqtW0F1EA6+
         TE/lgNaQx+XH7rtuXnF0D6avd+uT5NCMi6L9CRW7ShtnoasQhlGG1f44yx7UfQvR4b0T
         j0AJ2XtKwIGC+9esxLdhq/lhY9vGhnTT2UYncvc5XKHrFjs78Jt1hEmvKok8euFTXN6A
         XEN/ij/AcTK8gCC6M8uw4BFAjd7ZDI4JZOZJybLr6sfsvGo6RPto8fVceyK5FUIqo8Jx
         7HSg==
X-Forwarded-Encrypted: i=1; AL+hErHqB+sDhFuFdlpoz4Cl6tfsd8iNjQTJ29qvrpxUgHignDeczhFHYCupWzw1kKuumSasHaNKDN8=@vger.kernel.org
X-Gm-Message-State: APuU4Z93IBGXvSs8rgs4qaUb/24JnfX74fPCfCFnD7ZCGroaXCoz+GXC
	vx10vskQE0pqyEMTe8JVWEyJcy5alwz+4KypmtPVHfJxXepwLKmaqQz7FgeNIKocLJnfYp/qqan
	Q0A==
X-Received: from dyblf15.prod.google.com ([2002:a05:7301:a0f:b0:384:e0d0:f88e])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2728:b0:383:c2f0:e753
 with SMTP id 5a478bee46e88-3856c0d0a68mr22214108eec.3.1795645330238; Wed, 25
 Nov 2026 14:22:10 -0800 (PST)
Date: Wed, 25 Nov 2026 22:21:01 +0000
In-Reply-To: <20261125222102.1430675-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222102.1430675-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222102.1430675-2-elkin@google.com>
Subject: [PATCH 1/2] media: s2255: validate transfer size, payload, and offset
 in save_frame
From: Elkin Cruz <elkin@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In read_pipe_completion(), pipe_info->cur_transfer_size is never
updated from purb->actual_length, so short USB bulk transfers leave
save_frame() scanning and copying up to 16384 bytes of stale data.
In save_frame(), marker scanning in S2255_READ_IDLE reads 20 bytes
(up to pdword[4]), but the loop bound only subtracts 12 from
cur_transfer_size without first checking cur_transfer_size >= 20.
In addition, skipping by DEF_USB_BLOCK can advance past the buffer,
payloads smaller than PREFIX_SIZE underflow vc->pkt_size - PREFIX_SIZE,
and frame offsets past cur_transfer_size underflow copy_size.

Record purb->actual_length (bounded by max_transfer_size) in
pipe_info->cur_transfer_size on completion while submitting URBs with
max_transfer_size, require cur_transfer_size >= 20, bound the loop by
cur_transfer_size - 20, cap DEF_USB_BLOCK skips against remaining
bytes, reject payloads smaller than PREFIX_SIZE, and validate offset
and frm->lpvbits before transitioning frm->state to S2255_READ_FRAME.

Fixes: 38f993ad8b1f ("V4L/DVB (8125): This driver adds support for the Sensoray 2255 devices.")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/media/usb/s2255/s2255drv.c | 51 ++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index ba717cdf31ad..9ddc13c99a81 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -1714,17 +1714,21 @@ static int save_frame(struct s2255_dev *dev, struct s2255_pipeinfo *pipe_info)
 	idx = vc->cur_frame;
 	frm = &vc->buffer.frame[idx];
 	if (frm->state == S2255_READ_IDLE) {
-		int jj;
+		u32 jj;
 		unsigned int cc;
 		__le32 *pdword; /*data from dsp is little endian */
 		int payload;
+
+		if (pipe_info->cur_transfer_size < 20)
+			return -EINVAL;
+
 		/* search for marker codes */
-		pdata = (unsigned char *)pipe_info->transfer_buffer;
+		pdata = pipe_info->transfer_buffer;
 		pdword = (__le32 *)pdata;
-		for (jj = 0; jj < (pipe_info->cur_transfer_size - 12); jj++) {
+		for (jj = 0; jj <= (pipe_info->cur_transfer_size - 20); jj++) {
 			switch (*pdword) {
 			case S2255_MARKER_FRAME:
-				dprintk(dev, 4, "marker @ offset: %d [%x %x]\n",
+				dprintk(dev, 4, "marker @ offset: %u [%x %x]\n",
 					jj, pdata[0], pdata[1]);
 				offset = jj + PREFIX_SIZE;
 				bframe = 1;
@@ -1737,8 +1741,9 @@ static int save_frame(struct s2255_dev *dev, struct s2255_pipeinfo *pipe_info)
 				/* reverse it */
 				dev->cc = G_chnmap[cc];
 				vc = &dev->vc[dev->cc];
-				payload =  le32_to_cpu(pdword[3]);
-				if (payload > vc->req_image_size) {
+				payload = le32_to_cpu(pdword[3]);
+				if (payload < PREFIX_SIZE ||
+				    payload > vc->req_image_size) {
 					vc->bad_payload++;
 					/* discard the bad frame */
 					return -EINVAL;
@@ -1747,9 +1752,12 @@ static int save_frame(struct s2255_dev *dev, struct s2255_pipeinfo *pipe_info)
 				vc->jpg_size = le32_to_cpu(pdword[4]);
 				break;
 			case S2255_MARKER_RESPONSE:
-
-				pdata += DEF_USB_BLOCK;
-				jj += DEF_USB_BLOCK;
+				if (pipe_info->cur_transfer_size - jj - 20 <
+				    DEF_USB_BLOCK)
+					jj = pipe_info->cur_transfer_size - 20;
+				else
+					jj += DEF_USB_BLOCK;
+				pdata = pipe_info->transfer_buffer + jj;
 				if (le32_to_cpu(pdword[1]) >= MAX_CHANNELS)
 					break;
 				cc = G_chnmap[le32_to_cpu(pdword[1])];
@@ -1806,20 +1814,28 @@ static int save_frame(struct s2255_dev *dev, struct s2255_pipeinfo *pipe_info)
 		return -EINVAL;
 	}
 
-	if (frm->state == S2255_READ_IDLE) {
-		frm->state = S2255_READ_FRAME;
+	if (offset > pipe_info->cur_transfer_size) {
+		frm->state = S2255_READ_IDLE;
 		frm->cur_size = 0;
+		return -EINVAL;
 	}
 
-	/* skip the marker 512 bytes (and offset if out of sync) */
-	psrc = (u8 *)pipe_info->transfer_buffer + offset;
-
 	if (!frm->lpvbits) {
 		dprintk(dev, 1, "s2255 frame buffer == NULL.%p %p %d %d",
 			frm, dev, dev->cc, idx);
+		frm->state = S2255_READ_IDLE;
+		frm->cur_size = 0;
 		return -ENOMEM;
 	}
 
+	if (frm->state == S2255_READ_IDLE) {
+		frm->state = S2255_READ_FRAME;
+		frm->cur_size = 0;
+	}
+
+	/* skip the marker 512 bytes (and offset if out of sync) */
+	psrc = pipe_info->transfer_buffer + offset;
+
 	pdest = frm->lpvbits + frm->cur_size;
 
 	copy_size = (pipe_info->cur_transfer_size - offset);
@@ -2072,6 +2088,9 @@ static void read_pipe_completion(struct urb *purb)
 	}
 
 	if (status == 0) {
+		pipe_info->cur_transfer_size =
+			min_t(u32, purb->actual_length,
+			      pipe_info->max_transfer_size);
 		s2255_read_video_callback(dev, pipe_info);
 	} else {
 		pipe_info->err_count++;
@@ -2083,7 +2102,7 @@ static void read_pipe_completion(struct urb *purb)
 	usb_fill_bulk_urb(pipe_info->stream_urb, dev->udev,
 			  pipe,
 			  pipe_info->transfer_buffer,
-			  pipe_info->cur_transfer_size,
+			  pipe_info->max_transfer_size,
 			  read_pipe_completion, pipe_info);
 
 	if (pipe_info->state != 0) {
@@ -2111,7 +2130,7 @@ static int s2255_start_readpipe(struct s2255_dev *dev)
 	usb_fill_bulk_urb(pipe_info->stream_urb, dev->udev,
 			  pipe,
 			  pipe_info->transfer_buffer,
-			  pipe_info->cur_transfer_size,
+			  pipe_info->max_transfer_size,
 			  read_pipe_completion, pipe_info);
 	retval = usb_submit_urb(pipe_info->stream_urb, GFP_KERNEL);
 	if (retval) {
-- 
2.56.1.839.g22a8290db9-goog

