Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2745426693
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383007; cv=none; b=q0fZaAydv1x3Zyl1ydnJSFcrWKBPQQ8azmVRg2lH73ARH6RgpA1aAuogc1kfKu7dFOIMsngBkLz8yUE/YgrxPJvXQcCxZYLbxSclS5lRNd8HjYLP7/tJ32KmOxBxlh5f9w9J8bpbrxrVIZsoPjowsfpL4cKh2A+bTbecnCjbxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383007; c=relaxed/simple;
	bh=k3KDWtgA7WcYmwL4xAS07all1L5RZW/scSorm/Uo3wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5CxdWT8bomXeF1ANPPq1TtKre94vfJSQT0ZlvYmL4m3y5FTsEIBwbvLmjNoZTSJJdv5YgocGr9S/fr8/yWyW7QIE2Dl7HDDkNyOmlettqa/g3GKXP7L9VMceA/4DSdXaiOQcGx6iHvBjzpjYQYSfP1tgQsYdWM8hymFMyYGsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X5+GywWo; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X5+GywWo"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so890729a91.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792383005; x=1792987805; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVHD85hcoIbzSKmftE3vBB5fJDx7WHPGDYTB36Ue89E=;
        b=X5+GywWosk6l4nmgFl4CTIvj7xQ8U5PsnlTjnYUUGFPB96vw8w62gh1lRbusNcqgm7
         Oo5EPgZq1swU44RkOUVKBAwfT9yH9Mnxw8Gom319Wjq7bQ4myi+gB0hUI9TCXSQGp82u
         U58Li0irNY0BgdtQJd1KxJ8d82Psr2eupqmNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792383005; x=1792987805;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vVHD85hcoIbzSKmftE3vBB5fJDx7WHPGDYTB36Ue89E=;
        b=GifSYGn7PmCFeyZMnCdrfoSkmXOiJqkAvUFAUJvcq8kh0db5sOw82FYl58MpXkDFkX
         gZN6evzUIO0ipalGK8jdtYzsLv7liqTXE+G+eAiaNzr8dlzONyWZlaIHXvTfujrXUcR3
         XkjOtZWTMShKZuMu2UVfOnZ7ucTqipUO5Hh/TVCkSQT673FnV05gXia5TM8tIzS6JbKf
         EmT2R6VWOibYsPUYmSzqT5YdmDBklT/RpPXh/y82LugJoQtmrTFGJjrJMcR10vO/+Eo1
         ygAe7BS2CFiMH21GrXE6jH07E3FNpAykapWkyTtQY9l1OziY7bv7dIdCDU/hufls2x/9
         yhtQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2KDsA6Iu5Z7G+2VMuCuusSV0B10JXH1Q/62XzzKGCvUSMXuojb8aycr14XTaZmTMiu+LVdrU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMbS9RBhHj4qLL2g6wtTzdWec9J3AbcgZJ1JLJUqW+a3RB+Z/4
	w5NHPfJhpmA8Zd0kU1iGxuosBm6jSu4GwyRIOlPeoTY3yhxyMoskOM8lOgNCeTMErE1gkqvR5W1
	f/Zk=
X-Gm-Gg: AYBFou3a97q73dKtLuT2pn0dW+T3Krb+i28orWM5EyvzzBERS4gd/6wIh6BqsselGXU
	y/Rw8uZfmoH3U171jsj7BVqBygUbBugR4GH14dN9Pwcc6Bf28EZAfLRkDhV6HPeemSkT/d/ecjR
	X8oAP/spT4t4ygMB2QavQXDkgqtJ1xIFp5uw9T3c6PnJl6NdtGEEs5FAb99IXZrXavl6EQYhERn
	isBaRsy32iB3d6L1KGxS+6nbI3fYExvAjIAlZ4dBuIIyg1hhd7L1IBSuqu7UUNFPvjfOSRJQk1Y
	5y6td35T6rQV9IC0qgelCeOTLuCXqKLIplzez02p6DvvMLqscScp78ZWTcIRdNW3SX1ELlWrJIh
	/zTcEnCVEfKNOvzi0Xex+cVM12vdJHhujqE8ZVc13fibZ6UKc58HS/YhD09cVgdRsHVcPtxfx0u
	UMk79wqZ50+0Rgd7QZ8hGuHm0m4TOzWcZcSu1OfnmsPho66W1SEJxN9zuhB5hox2oxD7S09uU4q
	9kTcAgDwcHh0ytLI7QZSw1KnbTxaxAyO9F4aB4=
X-Received: by 2002:a17:90b:2886:b0:3a0:9fe0:3aaf with SMTP id 98e67ed59e1d1-3acef3dc81cmr5104311a91.48.1792383005094;
        Sun, 18 Oct 2026 21:10:05 -0700 (PDT)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com. [74.125.82.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad33b51284sm2543034a91.6.2026.10.18.21.10.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 21:10:03 -0700 (PDT)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso4759048eec.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:10:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzY1ZUsw2F1VTl+79bHUyiP1khgcJ4woisTFzFqFxFYb7CrQFTlYtBfL7IloJpD1eGe+Kh36SE=@vger.kernel.org
X-Received: by 2002:a05:7022:158a:b0:17e:ee5f:6715 with SMTP id
 a92af1059eb24-185136cabbfmr15886031c88.27.1792383002033; Sun, 18 Oct 2026
 21:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014-uvc-release-intfs-v1-1-18d6e8dfaad8@blueye.no>
In-Reply-To: <20261014-uvc-release-intfs-v1-1-18d6e8dfaad8@blueye.no>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 19 Oct 2026 13:09:48 +0900
X-Gmail-Original-Message-ID: <CANiDSCuv7q2oKbxqVj+4ctT3FChh81a691hzt_S1n5szXRTvXw@mail.gmail.com>
X-Gm-Features: AclHuK9J0H30Gx-MhrQ1okymnKWFydqhT85fiyQMpkuIcaVHuFB4mOrXeSAg8XI
Message-ID: <CANiDSCuv7q2oKbxqVj+4ctT3FChh81a691hzt_S1n5szXRTvXw@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Release streaming interfaces at
 disconnect, not last close
To: johannes.schrimpf@blueye.no
Cc: laurent.pinchart@ideasonboard.com, hansg@kernel.org, 
	linux-media@vger.kernel.org, hverkuil@kernel.org, mchehab@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Johannes

Thanks for the patch and the repro instructions.

Could you consider a smaller description? Something like this would be
great (feel free to reword it and fix all the grammar errors :) ) :

If a UVC camera is forced into an USB reset while an app holds a
reference to it, the usb interface will not be released at the correct
time, leading into a unusable camera after the reset.

This patch fixes that ordering issue and also makes sure that
usb_driver_release_interface() is only called with usb_lock_device()
held.

You can add a couple of more sentences and move all the other text
after the  ---. That might help passing the NO-AI filter of some
people...

On Thu, 15 Oct 2026 at 00:29, Johannes Schrimpf via B4 Relay
<devnull+johannes.schrimpf.blueye.no@kernel.org> wrote:
>
> From: Johannes Schrimpf <johannes.schrimpf@blueye.no>
>
> uvc_probe() claims the VideoStreaming interfaces with
> usb_driver_claim_interface(), but they are released by uvc_delete(),
> the kref release of the uvc_device. uvc_delete() runs when the last
> reference to the disconnected device is released, potentially on a
> later file close, long after uvc_disconnect().
>
> A USB reset turns this into a bug. uvcvideo has no pre_reset() and
> post_reset() handlers, so usb_reset_device() unbinds it from all the
> interfaces it is bound to and probes it again on the same struct
> usb_interface objects. A process that holds a file handle from before
> the reset keeps the old uvc_device alive. When it closes the handle,
> the old uvc_delete() calls usb_driver_release_interface() on
> interfaces that the new uvc_device has claimed meanwhile.
> usb_driver_release_interface() only checks that the interface is bound
> to the uvcvideo driver, not to which instance, so it unbinds them from
> the new device. usb_unbind_interface() disables the endpoints, the
> URBs of a running stream complete with -ESHUTDOWN, uvc_video_complete()
> marks the queue as disconnected, and every following VIDIOC_QBUF fails
> with -ENODEV. Nothing is logged, and the stream stays dead until the
> device is reset or plugged in again. The release from uvc_delete() also
> runs without the USB device lock that usb_driver_release_interface()
> requires.
>
> This was found with a Sonix camera (0c45:6366) on an i.MX6Q board,
> where a camera-control process kept a file handle open across a USB
> reset issued by the streaming process. The failure was traced and
> reproduced with the help of an LLM coding assistant. Reproduced on
> Linux 6.18.24 (linux-fslc-imx) as follows:
>
>   1. open() a video node of the camera and keep the file handle
>   2. reset the camera with USBDEVFS_RESET
>   3. stream from a video node of the re-probed device
>   4. close() the file handle from step 1
>
> The stream fails within a few milliseconds of the close(), in 4 of 4
> runs. The kernel emits one KOBJ_UNBIND uevent for each VideoStreaming
> interface; the VideoControl interface stays bound. Holding a node of
> the other streaming interface has the same effect. Without step 1 the
> stream survives.
>
> Release the streaming interfaces where the binding is still ours: in
> uvc_disconnect() for the VideoControl interface, which runs with the
> USB device lock held, and in the probe error path, in the same context
> as the claims in uvc_parse_streaming(). uvc_delete() then no longer
> releases any interface. This is the split usb-serial uses:
> usb_serial_disconnect() releases the sibling interface, and the kref
> release, destroy_serial(), releases no interface; it drops its
> interface reference with usb_put_intf(). With no file handle open,
> uvc_disconnect() already drops the last reference, and uvc_delete()
> runs synchronously from it, so on that path the interfaces are still
> released from within uvc_disconnect(), as before.
>
> Tested with this patch on the same i.MX6Q and kernel: the reproduction
> above with the file handle opened on either streaming interface or
> closed before the stream starts, a USB reset without a held file
> handle, sysfs unbind/bind of the VideoControl interface with and
> without a held file handle, and a second UVC camera (MJPEG and H.264
> at 1080p).
>
> The running stream survives in all four streaming runs, and none of
> the five stale-handle closes unbinds an interface; the close() takes
> 0.13-0.23 ms instead of 38-42 ms (86 ms when no stream was running).
> USB-reset recovery and streaming from the second camera pass. Sysfs
> unbind/bind correctly releases and reclaims the streaming interfaces.
>
> Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> Cc: stable@vger.kernel.org # needs adjustments for <= 6.14: &uvc_driver.driver
> Assisted-by: LLM
> Signed-off-by: Johannes Schrimpf <johannes.schrimpf@blueye.no>
> ---
> Hi Laurent, Hans,
>
> Ricardo's "media: uvcvideo: Remove refcounted cleanup" (Nov 2024) would
> have moved all device cleanup, including this release, into
> uvc_disconnect(), and was NACKed because it fixed no concrete bug. This
> patch keeps the refcounted cleanup and moves only the release of the
> streaming interfaces, to fix the failure described in the commit
> message, which we hit repeatedly in integration testing.
>
> Tool use: this was developed with an LLM coding assistant, Claude Code
> running Claude Opus 5.5, as well as reviewed by GPT-6 Astra. Starting
> from stream failures in our bench logs, the assistant traced the code
> path, wrote the reproduction scripts, ran them and the tests above on
> the device, surveyed the upstream history and other drivers, built and
> checked the patch on media-committers next, and drafted the patch, the
> changelog and these notes. I reviewed the analysis and the patch.
>
> Test kernel: linux-fslc-imx 6.18.24 with three local uvcvideo patches
> (keep MJPEG frames recovered by MJPEG_NO_EOF, nodrop=0 by default, and a
> coherent_urbs parameter). None of them touches probe, uvc_disconnect(),
> uvc_delete(), the interface claim/release or uvc_video_complete().
>
> Not tested:
> - an unmodified uvcvideo, or any kernel other than linux-fslc-imx
>   6.18.24; on media-committers next this patch is build-tested only
>   (gcc and clang, arm, arm64 and x86_64, W=1, sparse, smatch)
> - a debug kernel: the test kernel is the board's production config
>   (SMP, PREEMPT; no lockdep, DEBUG_ATOMIC_SLEEP, DEBUG_MUTEXES,
>   SLUB_DEBUG, DEBUG_PAGEALLOC or KASAN)
> - unplug and replug, sysfs unbind of a VideoStreaming interface, and
>   the probe error path
> - frame delivery after a sysfs rebind: the Sonix camera delivers no
>   frames after any re-probe that does not follow a USB reset, with and
>   without this patch, so those runs check only the binding; the
>   second camera was not rebound
> - v4l2-compliance
> - any camera other than the two on this board
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index cbc1456..f71dfce 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1976,7 +1976,6 @@ static void uvc_delete(struct kref *kref)
>                 struct uvc_streaming *streaming;
>
>                 streaming = list_entry(p, struct uvc_streaming, list);
> -               usb_driver_release_interface(&uvc_driver, streaming->intf);
>                 uvc_stream_delete(streaming);
>         }
>
> @@ -2026,6 +2025,18 @@ static void uvc_unregister_video(struct uvc_device *dev)
>  #endif
>  }
>
> +/*
> + * Release the streaming interfaces here, not in uvc_delete(): after a USB
> + * reset, a new uvc_device may already have claimed the same interfaces.
> + */
> +static void uvc_release_streaming_intfs(struct uvc_device *dev)
> +{
> +       struct uvc_streaming *stream;
> +
> +       list_for_each_entry(stream, &dev->streams, list)
> +               usb_driver_release_interface(&uvc_driver, stream->intf);
> +}
> +
>  int uvc_register_video_device(struct uvc_device *dev,
>                               struct uvc_streaming *stream,
>                               struct uvc_video_queue *queue,
> @@ -2356,6 +2367,7 @@ static int uvc_probe(struct usb_interface *intf,
>
>  error:
>         uvc_unregister_video(dev);
> +       uvc_release_streaming_intfs(dev);
>         kref_put(&dev->ref, uvc_delete);
>         return ret;
>  }
> @@ -2375,6 +2387,7 @@ static void uvc_disconnect(struct usb_interface *intf)
>                 return;
>
>         uvc_unregister_video(dev);
> +       uvc_release_streaming_intfs(dev);
>         kref_put(&dev->ref, uvc_delete);
>  }

nit: you are always calling to uvc_release_streaming_intfs() after
uvc_unregister_video(). Maybe you should move that functionality into
uvc_unregister_video() and rename it to uvc_unregister_device(),
uvc_unregister_video() already does much more than unregistring the
video nodes.

In any case, this patch fixes a real issue, and with the nits fixed
you can add my:

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
>
>
> ---
> base-commit: d7e7bca7169873b46e857c025c10f3336c1258d8
> change-id: 20261014-uvc-release-intfs-ff95e3766b15
>
> Best regards,
> --
> Johannes Schrimpf <johannes.schrimpf@blueye.no>
>
>


-- 
Ricardo Ribalda
