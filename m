Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837678;
	b=sbWRTnK04RMb0KtODseqZ3gol918YLKf1kpcusztY7RK4S5iPH4FATTAqR+yb5CnHMHm
	 TQpkTOh2ImUl003wcLtQK3FX9p+vnfxu9zgVeG1XsYKkbMr5/eVxJyVVgNQFfMvf1cqZh
	 WD2jjDxKQF+ZIc6gLww++BZVWybbovN/2mS3mrHLWPWMXn6RNsVZ+ey6bYTHGawemZbnp
	 vDxG/LrNuWjPsToY0NPMA+IQWtDCY+UM8r1hXeMH4eCVej4KowhIwz5fF2LAWYeGuRQXx
	 tpd9nESpL1KewDJ5GF+WctZBZT50wRRpIxyll8TlyaadFYYtw3di/8kvIm16YZh7sKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837678;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=g+FMrZ2Yss7ffWu91xmKsLSGEfD2dTYbKly2DTAxGi0=;
	b=e+wXMKa80oa5AIidEnyRbLZB94oWX5Kd1PUghBViplA2pq5S4gp1Jusa0fyPpmwyiMw+
	 uTAVJlFrFnZP/DdKRcM+sNhNo9DA4Ik2yNIYb4u60lMRtarhM36BE/sAIicXJYn0PVUu9
	 6lezR4WMdi7GYfIzfu77TCEQqZJmmvIikMz3TY5JS+UnW2WgDRvzplyxtG/uPgaXsiy2I
	 UkvUQpzrcci95lZTA82m4WYxxDq/s4LORnbcGQM/zoEjb7Ui01tOWUH5EpV4+KziiF2ma
	 b5KEoSNq1l3uvgWXWZrgI8FzjJs9GHvgB5GtLA3vGVrFyixAOE/4ZJuuVxf9h+ubZCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=OczjDRTI;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62A606A88E;
	Mon, 16 Nov 2026 14:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A62A606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=OczjDRTI
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97A4F4BB;
	Mon, 16 Nov 2026 14:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794837528;
	bh=g9a5Nf9FQfAlb9mT2jHLg92T6EhG5dLjGgnKQk03YQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OczjDRTIfk58NLlH97R5+6Bqea4nnFHly7hcMPqeXdP8KLqwTQlZgtmCINzNt0klF
	 RLC1NJt2OmQ60UzZR4I45tatdkbsz7/+SUl99g26wYqlBImFy0ZuV+FFHVWsS2UBJK
	 t4jBfxsbSQ1xENLMDGsbrO6vlS7Buia6zeLCEfag=
Date: Mon, 16 Nov 2026 16:01:14 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] media: uvcvideo: Fix unaligned and OOB access
Message-ID: <20261116140114.GC1714298@killaraus.ideasonboard.com>
References: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
 <20261116-uvc-shortmeta-v1-3-487cfe42fa89@chromium.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116-uvc-shortmeta-v1-3-487cfe42fa89@chromium.org>

On Mon, Nov 16, 2026 at 11:56:39AM +0000, Ricardo Ribalda wrote:
> meta->buf and scr point to packed metadata and USB packet memory that do
> not need to be aligned to anything. Also, scr + 4 is a 16-bit field, so
> reading it as a u32 reads 2 bytes out of bounds.
> 
> We use *_unaligned() in the rest of uvc_video_decode_meta(), but not in
> the debug print.
> 
> Fix this.
> 
> Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index e9be0a627033..3e3296ec5c65 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1532,9 +1532,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
>  		"%s(): t-sys %lluns, SOF %u, len %u, flags 0x%x, PTS %u, STC %u frame SOF %u\n",
>  		__func__, ktime_to_ns(time), meta->sof, meta->length,
>  		meta->flags,
> -		has_pts ? *(u32 *)meta->buf : 0,
> -		has_scr ? *(u32 *)scr : 0,
> -		has_scr ? *(u32 *)(scr + 4) & 0x7ff : 0);
> +		has_pts ? get_unaligned_le32(meta->buf) : 0,
> +		has_scr ? get_unaligned_le32(scr) : 0,
> +		has_scr ? get_unaligned_le16(scr + 4) & 0x7ff : 0);

I wonder if things would look cleaner if we introduced a struct uvc_scr
instead of fiddling with manual access to buffer offsets. What do you
think N It would look like this:

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index ce99795cfea4..30c6516f0340 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -943,8 +943,7 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
 	unsigned int header_size;
 	bool has_pts = false;
 	bool has_scr = false;
-	u16 scr_sof;
-	u32 scr_stc;
+	struct uvc_scr scr;
 	u32 pts;

 	if (stream->stats.stream.nb_frames == 0 &&
@@ -981,8 +980,8 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
 		pts = get_unaligned_le32(&data[2]);

 	if (has_scr) {
-		scr_stc = get_unaligned_le32(&data[header_size - 6]);
-		scr_sof = get_unaligned_le16(&data[header_size - 2]);
+		scr.stc = get_unaligned_le32(&data[header_size - 6]);
+		scr.sof = get_unaligned_le16(&data[header_size - 2]);
 	}

 	/* Is PTS constant through the whole frame ? */
@@ -1012,7 +1011,7 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,

 	/* Do the SCR.STC and SCR.SOF fields vary through the frame ? */
 	if (has_scr && stream->stats.frame.nb_scr) {
-		if (stream->stats.frame.scr_stc != scr_stc)
+		if (stream->stats.frame.scr.stc != scr.stc)
 			stream->stats.frame.nb_scr_diffs++;
 	}

@@ -1021,17 +1020,16 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
 		if (stream->stats.stream.nb_frames > 0 ||
 		    stream->stats.frame.nb_scr > 0)
 			stream->stats.stream.scr_sof_count +=
-				(scr_sof - stream->stats.stream.scr_sof) % 2048;
-		stream->stats.stream.scr_sof = scr_sof;
+				(scr.sof - stream->stats.stream.scr_sof) % 2048;
+		stream->stats.stream.scr_sof = scr.sof;

 		stream->stats.frame.nb_scr++;
-		stream->stats.frame.scr_stc = scr_stc;
-		stream->stats.frame.scr_sof = scr_sof;
+		stream->stats.frame.scr = scr;

-		if (scr_sof < stream->stats.stream.min_sof)
-			stream->stats.stream.min_sof = scr_sof;
-		if (scr_sof > stream->stats.stream.max_sof)
-			stream->stats.stream.max_sof = scr_sof;
+		if (scr.sof < stream->stats.stream.min_sof)
+			stream->stats.stream.min_sof = scr.sof;
+		if (scr.sof > stream->stats.stream.max_sof)
+			stream->stats.stream.max_sof = scr.sof;
 	}

 	/* Record the first non-empty packet number. */
@@ -1062,7 +1060,7 @@ static void uvc_video_stats_update(struct uvc_streaming *stream)
 		frame->has_early_pts ? "" : "!",
 		frame->has_initial_pts ? "" : "!",
 		frame->nb_scr_diffs, frame->nb_scr,
-		frame->pts, frame->scr_stc, frame->scr_sof);
+		frame->pts, frame->scr.stc, frame->scr.sof);

 	stream->stats.stream.nb_frames++;
 	stream->stats.stream.nb_packets += stream->stats.frame.nb_packets;
@@ -1468,8 +1466,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	bool has_pts, has_scr;
 	unsigned long flags;
 	unsigned int sof;
+	struct uvc_scr scr;
 	ktime_t time;
-	const u8 *scr;
+	const u8 *scr_data;

 	if (length <= 2 || !meta_buf || meta_buf->state != UVC_BUF_STATE_ACTIVE)
 		return;
@@ -1479,9 +1478,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,

 	if (has_pts) {
 		len_std += 4;
-		scr = mem + 6;
+		scr_data = mem + 6;
 	} else {
-		scr = mem + 2;
+		scr_data = mem + 2;
 	}

 	if (has_scr)
@@ -1490,8 +1489,13 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	if (stream->meta.format == V4L2_META_FMT_UVC)
 		length = len_std;

+	if (has_scr) {
+		scr.stc = get_unaligned_le32(scr_data);
+		scr.sof = get_unaligned_le16(scr_data + 4);
+	}
+
 	if (length == len_std && (!has_scr ||
-				  !memcmp(scr, stream->clock.last_scr, 6)))
+				  !memcmp(&scr, &stream->clock.last_scr, sizeof(scr))))
 		return;

 	if (meta_buf->length - meta_buf->bytesused <
@@ -1509,7 +1513,7 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	put_unaligned(sof, &meta->sof);

 	if (has_scr)
-		memcpy(stream->clock.last_scr, scr, 6);
+		stream->clock.last_scr = scr;

 	meta->length = mem[0];
 	meta->flags  = mem[1];
@@ -1521,8 +1525,8 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 		__func__, ktime_to_ns(time), meta->sof, meta->length,
 		meta->flags,
 		has_pts ? *(u32 *)meta->buf : 0,
-		has_scr ? *(u32 *)scr : 0,
-		has_scr ? *(u32 *)(scr + 4) & 0x7ff : 0);
+		has_scr ? scr.stc : 0,
+		has_scr ? scr.sof & 0x7ff : 0);
 }

 /* ------------------------------------------------------------------------
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index af8cef94ffff..a3e1c0fb129f 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -302,6 +302,11 @@ struct uvc_streaming_header {
 	u8 bTriggerUsage;
 };

+struct uvc_scr {
+	u32 stc;
+	u16 sof;
+} __packed;
+
 enum uvc_buffer_state {
 	UVC_BUF_STATE_IDLE	= 0,
 	UVC_BUF_STATE_QUEUED	= 1,
@@ -383,8 +388,7 @@ struct uvc_stats_frame {

 	unsigned int nb_scr;		/* Number of packets with a SCR timestamp */
 	unsigned int nb_scr_diffs;	/* Number of SCR.STC differences inside a frame */
-	u16 scr_sof;			/* SCR.SOF of the last packet */
-	u32 scr_stc;			/* SCR.STC of the last packet */
+	struct uvc_scr scr;		/* SCR of the last packet */
 };

 struct uvc_stats_stream {
@@ -525,7 +529,7 @@ struct uvc_streaming {
 		u16 last_sof_raw;
 		u16 sof_offset;

-		u8 last_scr[6];
+		struct uvc_scr last_scr;

 		spinlock_t lock;
 	} clock;


Actually, thinking more about this, I think we can also simplify
uvc_video_decode_meta() to only compare SCR.STC:

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 30c6516f0340..7513083fadad 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1454,8 +1454,8 @@ static int uvc_video_encode_data(struct uvc_streaming *stream,
  *
  * Ideally we want to capture all payload headers for each frame. However, their
  * number is unknown and unbound. We thus drop headers that contain no vendor
- * data and that either contain no SCR value or an SCR value identical to the
- * previous header.
+ * data and that either contain no SCR value or an SCR.STC value identical to
+ * the previous header.
  */
 static void uvc_video_decode_meta(struct uvc_streaming *stream,
 				  struct uvc_buffer *meta_buf,
@@ -1494,8 +1494,7 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 		scr.sof = get_unaligned_le16(scr_data + 4);
 	}
 
-	if (length == len_std && (!has_scr ||
-				  !memcmp(&scr, &stream->clock.last_scr, sizeof(scr))))
+	if (length == len_std && (!has_scr || scr.stc == stream->clock.last_stc))
 		return;
 
 	if (meta_buf->length - meta_buf->bytesused <
@@ -1513,7 +1512,7 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	put_unaligned(sof, &meta->sof);
 
 	if (has_scr)
-		stream->clock.last_scr = scr;
+		stream->clock.last_stc = scr.stc;
 
 	meta->length = mem[0];
 	meta->flags  = mem[1];
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a3e1c0fb129f..b2d39c742e34 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -529,7 +529,7 @@ struct uvc_streaming {
 		u16 last_sof_raw;
 		u16 sof_offset;
 
-		struct uvc_scr last_scr;
+		u32 last_stc;
 
 		spinlock_t lock;
 	} clock;


I can send patches with proper commit messages.

>  }
>  
>  /* ------------------------------------------------------------------------

-- 
Regards,

Laurent Pinchart
