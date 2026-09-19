Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2072AE78
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776559; cv=pass; b=JTAWia97sIqg0BKUYH5T1M0Zv7UcmG8FUY5kYtzEl5Vtxrx6n+qewi4WoiWlmBvPDS7i+seHP9yyR/zKH2KFTpkBe7t1OvJ4Cm6cTBxdC22OhpPAdMNw4LWaP4LJxJ74CehvA9shKbAMtFHVhnDVgTL0uCBNpxyPY9DhqiBtZRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776559; c=relaxed/simple;
	bh=PU+L/CdtC8xOCmRNhBf0E5me78uniQkeih3uFXRDgt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aO7akbtVb5nWXQZlTNiuLBi1fp8JlCaGKxALZnFUThqGpdQWVjMC08YVJ6SecsXDiSRuHQcN/qKZJQK2qdkfLRCPhI6yKW9ZiZcKAtuA34+JmAbG2f1PGUh2HeRvIv4sCpACQSIxWk9IQxu6wVoeZyBj31UPwhdjtBZrqn+UQpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=D6ZZ6QdG; arc=pass smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="D6ZZ6QdG"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-90cdfc93e00so7722926d6.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789776556; cv=none;
        d=google.com; s=arc-20260327;
        b=R509Flw3vd2rY/P1zR6A2JvL2IvjI4FQ1MaX2tEVavNzVp6ut+Cvs9Yg9VhFVqHNNe
         cRbbHV/5vSG/NYhq7qHLvaP9+7S4XZzF1Ymf09zhLUGZh81C2UQLHUysfzNFz8gv5gLS
         +q314pmEBklca9YwdvTUsQYHRHsKk1YcbMolYmGficLJLKrFKRtT+QNumh32Yi8gk69K
         pnqOSDTasMJ6XRMPISG2pnLudMY9wwzXNXPL1iKASM8GRVYEo9pZrG7xVvofhS4AtMkx
         OatY+dWzI6/s8QX50PouLTm8JU362bEXic5xk0BblKQRqe+MjbsFb3+dgUGVpNzZyOFI
         b1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gVNibac69RIusTZEUWTx905GNnSCni+ehiSaDallFpI=;
        fh=u1t5w6JQ1O4rcZN4/IlBhElDKKhcLGvPgMpvSu25Xhk=;
        b=bjKU3w1Ru/j1QAorkuQsSBVhRmYXxcHISpr7QmUuu/wkPtHbPs1AnZgWj9lf62w/Ak
         oiRzw74XSE/OuTYj0dubCCdjcKyGuN0I/ojdM0ijy1tKPUleqhvQNCgv6rDbws7dz8P+
         PXOvIKnACJl25P74OBnGnszAbFoQwQeSsjgOMqfHWvF3jdg7t+N7pAAr2pwoPwiOfcvs
         yLa47kzMK/BJi0WcnJrlPHk77M49O8po8Lzf1mB0br8CzvxJrYPeXWe8dHzCBzGK+Zhd
         vgaZJDRqxohHSbrjuGIIaLRFYJPG+9P/NDPGnS9LFra8WszXUdrrZOs9rPrg74VLuSvo
         4ONg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789776556; x=1790381356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gVNibac69RIusTZEUWTx905GNnSCni+ehiSaDallFpI=;
        b=D6ZZ6QdG2JAgYwEEX/SLW1Iv3TC3qoqNr0ZpUCcUdQT1CbZxHzsHEidgy63BvwJri6
         AkbSD5K3Cg88r40G4X70eRGGJrm/ThIk17HI6jyCfpjuKtMxma2UU93xGZjlBYruIsEG
         VN/ZYCvU/kD7oep01vdqnvAzsDGnZNDgLJ50fDVIoZ/4R/nWqYYspF7gyAuleCGx9oTA
         dCldyLfR5wODDvO49AU8FLEJe9M0m5/UDkFSiTcn5K3xebt8orerp6Scxj3VKt6BOU9p
         /vxZQ4UprImXC57ejg+wdkGSKWSgm3ylrSIGRo8QNK4/UH9XZdhjvll7tykwbBDyX0sY
         g5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789776556; x=1790381356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gVNibac69RIusTZEUWTx905GNnSCni+ehiSaDallFpI=;
        b=ZjaJ8A/5wiDaxncDYNLeXYakMpbjvNG0wZJiPlFX2laCwc7vG/F/zEmJh9iL6fDq1A
         dKUleJjURtfwzuMdj7PQV/p+tG3cpXd2b6OSQqfIO1qYW8txAzK8JUGJQ7UVHH7Tsr30
         lwGLRotBUwjyf84G7137lM0aZhRYpCBIGcPbwN3qGwYTvWM7avXq652/4gM+TEXWK5oN
         Zk2kuCmx7qLecNXfx09gO9IuVyjngdt996E+rYrgXuBtBcxEKzd3efEQT6zVF9CChC8k
         G/IU9niRT92HdMWDYl2supC4R3tp5jWdPoXByCFyHRnS2jYg4ui12SDR0eAgupTpAUgF
         br/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxtQSxFZo70t4aqDDMwJHSxulvjdzOJRiSOuNIgCaYIxxkyTSEydRHytVcdOV+Vs4pZtY3w+hM=@vger.kernel.org
X-Gm-Message-State: AFuF++mK0uHC6asU7kAExJE4m0VLScyawvzVAuZsk8VB7bwrrAltM0q6
	UuFGc8OoE/UQtmU4uh2UJUBM5NQZR3JAhhtHe7eU2/d9hnLlgpRhUoUMufGR4PcpPPllayXplNx
	g5t0mYo809RWDnJIJWLXO8Vf58ycw1OJjXrI9w99Q
X-Gm-Gg: AYBFou1HQeIno3OztwGVWJX/PsWgnUJiUYGyfSFvJlg0MzyBYYxsMZfgNE/Ne6XhV64
	JDTFPWRogILogg29KsvxaEnVUG/yEd9CVhub/KSkoMNbrhq6sphtMqlHZHAqWo0wxWFLG1sa8Dn
	BF2P3Tmo9DsTB1XXJl38Gppk940YIlqRCna3kB+9A1z9ZnspIpYwaKAyq0ffiMv/CLGI+ljEB8x
	ydlcVdJUiJ5inU7RfTuJo9No9qOn85NhrjCmItomdixLT/kjBZVbd52jPg2XedV2glkMcM+QpPM
	c4LYamfeKXCKfKSnU2vvHHlO/E7RuXZbOefN96MpRm7V4Y5L46UlqcTXuHutlEsqFd9a/9HiSTR
	VdtVMpQxQ232o7BhKece6bw==
X-Received: by 2002:a05:6214:3982:b0:912:59f5:7178 with SMTP id
 6a1803df08f44-91259f572b9mr51296146d6.31.1789776555939; Fri, 18 Sep 2026
 17:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918212231.1193758-1-xmei5@asu.edu>
In-Reply-To: <20260918212231.1193758-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 18 Sep 2026 17:09:02 -0700
X-Gm-Features: AcwNN1VEk0TFmo665Y4k-d2dWdC5cPVRtdRowVAey1-mRjtQf5TJXnzVkPticXg
Message-ID: <CAPpSM+TuDm2GRg=JTn_Qb6GzWQfik1j2iVt6AO9Ooa3HyvsD2w@mail.gmail.com>
Subject: Re: [PATCH] ALSA: line6: Clamp the playback URB size to the OUT
 endpoint packet size
To: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Cc: dev@andree.sk, co+f595d33a1b0a565b@bugs.sh, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 2:22=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> The playback buffer is sized from the OUT endpoint's max_packet_size_out,
> but submit_audio_out_urb() takes the length to write into it from
> prev_fsize, which audio_in_callback() derived from the IN endpoint.  Both
> come from the device's own descriptors and nothing relates them, so a
> device declaring a large iso IN and a small iso OUT wMaxPacketSize
> overflows the buffer.  usb_submit_urb() rejects the oversized URB, but
> only after the write has run.
>
> Attaching the device is the whole trigger: toneport_startup() acquires th=
e
> monitor stream and starts both URB streams on its own, so the overflow
> happens in the URB completion handler with no local process involved.
>
> Clamp the length to max_packet_size_out.  A device whose OUT endpoint
> matches the audio format it announces never reaches the limit.
>
> BUG: KASAN: slab-out-of-bounds in submit_audio_out_urb (sound/usb/line6/p=
layback.c:242)
> Write of size 1024 at addr ffff88801b94bc00 by task vhci_rx/183
>
> Call Trace:
>  kasan_report (mm/kasan/report.c:595)
>  kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
>  __asan_memset (mm/kasan/shadow.c:84)
>  submit_audio_out_urb (sound/usb/line6/playback.c:242)
>  audio_out_callback (sound/usb/line6/playback.c:354)
>  __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
>  usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1741)
>  vhci_rx_loop (drivers/usb/usbip/vhci_rx.c:107)
>  kthread (kernel/kthread.c:436)
>  ret_from_fork (arch/x86/kernel/process.c:158)
>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>
> The buggy address belongs to the object at ffff88801b94bc00
>  which belongs to the cache kmalloc-512 of size 512
>
> Cc: stable@vger.kernel.org
> Fixes: 7a0f55aeeb8f ("ALSA: line6: Support assymetrical in/out configurat=
ions")
> Reported-by: <co+f595d33a1b0a565b@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  sound/usb/line6/playback.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
> index 7ebaf125f969..cfb20585c5ea 100644
> --- a/sound/usb/line6/playback.c
> +++ b/sound/usb/line6/playback.c
> @@ -181,6 +181,7 @@ static int submit_audio_out_urb(struct snd_line6_pcm =
*line6pcm)
>                 }
>
>                 fsize *=3D bytes_per_frame;
> +               fsize =3D min(fsize, line6pcm->max_packet_size_out);
>
>                 fout->offset =3D urb_size;
>                 fout->length =3D fsize;
> --
> 2.43.0
>

Please disregard this patch. It duplicates my other submission
addressing the same out-of-bounds write in submit_audio_out_urb().

Sorry for the duplicate submission and noise.

Thanks,
Xiang
