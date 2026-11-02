Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585211;
	b=RcymbNTIk0uhAKFmY6g7qPof9IrObBZHS4g0um9AvoCev+0c7iBQVv3t/JOi5UbsM0M0
	 v2YZJtFfxmY7iqHsYBIbEe7xp7ZhnsJhviUyrwzfJCfpTJtCJPpHA4wzk/Qw/VHgXp1Q/
	 GPVXUL7OZDl5dsUhk8JzZEpnQ42j5piDQe9YPo8GtrYITI+JkXLbn7xK1f5dHkHSfS2V/
	 6vU5zOzjNhWhQNbspkxbRcHayeLCCmaLHNcAMNUzGkkcj3RL6FerA0/bYlJjsorbREAL3
	 sJJX6l7v0CGcSkYGk1Cj2sKHX9/N13IRc/hy1rPQuchc+c/VKer+qzL1DSaEhWgPxlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dcFBFWUE+FcI5MXNPVjGcIjPvakXuwpZdE8kWcsdxrU=;
	b=jSYLp570Rp3UTp1Ih4spFWkPGSxZwiXBa1Wb6ipcvnOvKPJSWWKjW5MGkknGqxUrw1G/
	 YkQLgat7wymqB/B4H0nF+Kqrlzt+ZnJ+MNJLdgSj6K3sxsNpxujBzhH7XWdACi20owl+C
	 QJKvRddQdSNE1+ZONuWCxIkyNaKdeR0OpBhQTpPMlAaOvT4Wp0FbhTZqot6wymfCfOqjs
	 4iSJ/HyGRuV+hT5Ud8+ewEg/d48W1ZNCwdJdXPgaKYeajY2+ExpyQ8AeYy58uWRFUgyLn
	 G/pAbipnipL8ewWP/5Dm7H8Vwr+i1c64IZG4slG635jQ7y8wwm4YN/CmHAGA0eX1Ksg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=eI1I54pP;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058A606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B058A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=eI1I54pP
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c60e30054so28398156d6.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793585210; x=1794190010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcFBFWUE+FcI5MXNPVjGcIjPvakXuwpZdE8kWcsdxrU=;
        b=eI1I54pP4sNRU18kmigYVKdzA2j7INmfP0pOhyIJWUWyn9HdGjuny2p01+EFx3KVIP
         OlJzSU3Bc2Z1OHFSXrFpt8z/SVF3c3RAdiOl9neXox4aRXrCKmqbBF5eP1kA+N7T036V
         6neDfF9UZcv7j65OJmRtRESZ7YS7+rod7BKwV6Wj9zYcF/eVzxizLT4BDwRltIXJFWcS
         cgaQYjDk7VzmrQ0gsomdizXfiblBjmxcoK3vWhDzkSo5p1GcOZTuwnNaQeC5QywTB2z6
         uxbqPZwHqL04oSubPrJPjJw/ZKPE7OolOMj3YCNsh0g4czSaxTjlTc5K8HL26r8s9VAI
         DsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793585210; x=1794190010;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcFBFWUE+FcI5MXNPVjGcIjPvakXuwpZdE8kWcsdxrU=;
        b=oJvlRLQe/oGCRBsluynsAFJM/aDua59evfYqC8/Quvw/qQBM1nuTStpvpMT2jFX4da
         ZSCDYh0vYkIxl1Vn4sAyt4ZcZaXJbqD96TB+vH65cXzKjF80holZC8Cb+22cUHhgrVwi
         rTTXuIpSfIADCBJ7bo9XyGukN/Qy/BLMePLghQB+z0GYw99T7rvrjweqQUjildoNoQs+
         B85n9+tcdLffQwEre2AZXW+zsR0O+zkZTHsvKca9dHV02JfPZVf49nfAvnFHP+t62evP
         eoJJmr92iVOf94QbEsheRdiZ0HQTvlteXgfoGZuST7H3HoZ5TQVp2G7vXmFsJ7ZAp1qd
         UgNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuldZpzU0/PQ+jvx6iggK9LqPm0e0HNtcVfrN1wvRfTlSu/tOxEokIdQ5LY1XgrJ/faaMuZzE=@vger.kernel.org
X-Gm-Message-State: AFq9FYImTCtDP8DFopyGy13G/GtgYHhhep3OfwcbzPfl5OeGmMJ6QRTZ
	MC+mDRWc6rCo9pyq/ws3BG/os4m9VY/7zhQDMuKTK8yoGx0mcXCB2e0uQkr2vKjBow==
X-Gm-Gg: AYBFou3/qGawHVRVn5dC9XZqM3LH7XXIJg5QxhoblYj9p1g5a7SIAsPixK6LNqjk2Of
	r/8C+VorDD5EhpfmK6SNhhg29T+gsoGrWAh26WnR3OSkrZ7eN1fzWPdIPz7+StGiRY8tOY1T0bq
	4mrb1lHROUPrp06NdX61G7aVwH+0yXTwe8F3K0+tQ7lI5P74hHo/yPjwltvBN1pGu8lz9AES5cl
	dPYXZCuIcg+rUyCTNx7Gw6gxyQ/1Q+AUmhuuNCYmRKfTC76RdkjMzEvxcb5APJEKUyQxd3Gg6+g
	qmNCAHhyi6gid3mh0G71cIyqRpkbFwBqETbb3uAdgfh4fSGdPKY9ap2Rr/q3eFpyr9ubnfr7TR8
	xesulPv8iHVYE7Qjbr2SBv718YvBnW5NJo2v52FoMtugvgX5e7fqKcZ5/nTj4V2aBLtMaIk7Jmh
	qyPQAW+k3Z8CxZeGVgj28JQ5/mhtAEAdT55kZBhC4KRm3q2FYbwyroME4M1NSsAi09cB8RgqaOz
	froH+/7zQxs6TD2SvBsmKp6+KCpOp4V4bCi+3IZEoOs2yCN3CBHaqYoVHtfNBOzoY7IBYvoWzBX
	CCByGRN9kf3sF8sB1ngsHb6A6LCEXQ==
X-Received: by 2002:a05:6214:240a:b0:91c:a1a9:44e0 with SMTP id 6a1803df08f44-91ca4b1bbd2mr149665266d6.28.1793585209484;
        Sun, 01 Nov 2026 18:06:49 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f254a1sm78503786d6.7.2026.11.01.18.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:06:48 -0800 (PST)
Date: Sun, 1 Nov 2026 21:06:46 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Bram van den Heuvel <bram@vandenheuvel.online>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: add NO_LPM for Kingston DataTraveler Duo
Message-ID: <da413fa5-0563-481d-9f14-e156a13f5ac3@rowland.harvard.edu>
References: <20261101172944.59384-1-bram@vandenheuvel.online>
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
In-Reply-To: <20261101172944.59384-1-bram@vandenheuvel.online>

On Sun, Nov 01, 2026 at 06:29:44PM +0100, Bram van den Heuvel wrote:
> The Kingston DataTraveler Duo (0951:173c) repeatedly disconnects and
> reconnects when attached to a SuperSpeed root-hub port with USB 3 Link
> Power Management enabled. The kernel logs only a plain "USB disconnect",
> with no I/O errors or resets, and the drive re-enumerates about 0.25 s
> later. On a Framework 13 (Tiger Lake TCSS xHCI, 8086:9a13) running
> 7.2.11, one drive re-enumerated 72 times in about 5.5 minutes. The same
> drive also disconnects repeatedly on a Dell XPS from around 2016 with
> older kernels, so the problem is not tied to one host controller.
> Several drives of this model show the same behaviour.
> 
> The disconnects happen about 0.45 s after the host sends a command to
> an idle drive, such as the first INQUIRY after enumeration or the
> periodic media-change poll. Sustained reads are unaffected. This points
> to the drive failing to exit U1/U2.
> 
> Disabling LPM with usbcore.quirks=0951:173c:k stops the disconnects
> completely, including during a 497 MB read and accesses after idle
> periods.
> 
> Another owner of this drive reported the same problem in 2021
> (linked below).
> 
> The Kingston DataTraveler 3.0 (0951:1666) had the same symptom and
> already has this quirk, added in commit afaa2e745a24 ("USB: Add NO_LPM
> quirk for Kingston flash drive") after bugzilla #208257.
> 
> Link: https://community.frame.work/t/device-incompatibility-kingston-datatraveler-duo/11477
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222222
> Cc: stable@vger.kernel.org
> Signed-off-by: Bram van den Heuvel <bram@vandenheuvel.online>
> ---
> Not boot-tested with this patch applied. I tested the same quirk at
> runtime with usbcore.quirks=0951:173c:k, both on the kernel command
> line and through /sys/module/usbcore/parameters/quirks.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/core/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index a4bcbe9..5ac44fe 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -425,6 +425,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	/* Kingston DataTraveler 3.0 */
>  	{ USB_DEVICE(0x0951, 0x1666), .driver_info = USB_QUIRK_NO_LPM },
>  
> +	/* Kingston DataTraveler Duo */
> +	{ USB_DEVICE(0x0951, 0x173c), .driver_info = USB_QUIRK_NO_LPM },
> +
>  	/* TOSHIBA TransMemory-Mx */
>  	{ USB_DEVICE(0x0930, 0x1408), .driver_info = USB_QUIRK_NO_LPM },
>  
> -- 
> 2.56.0
> 
