Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465911;
	b=sMuiRq/X42LQXavw3eSE17+Y82hxjkLvxAuScoaYTN5wZ3TPyP+CSIyv3qxKdKWkq3wC
	 rfrJayoqyty2mcpJYDQfTCjeTaqlf97MFpkD2BOmTHmDjVU2PyfRamnnO4+H15oCnxAMY
	 9CJoLgRbItyayF3Gt2I/Rd0tUkaGPfkfURPlOwUBCg/md8eN1Sgop3pNrivN27GaAWhNV
	 mmFO4QECtCkmCpUINzhyrHzUki+QeNCnycYsOO1HZPU0sNyI22RDZ6MnfrJoEy9hCem0i
	 8m7YOFL53KkggXg7qhsHUlDJCLVMQWk+ZtQTSj34fYCu3QaAQ66lWO/OwJOtvKYXbOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465911;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sQ0FWTFeQrG6RUMpDQbCLQltxqCADv7gp0oxnC4p/b4=;
	b=xcHOAjw1OG3UlJ/FTFeJpZAHhNtr4pPl+mRru6+BfzxqaqT+R1ArOmgKq2h2G1G268zW
	 B6mr3WFS7Ebb7p11PXx26XT6UuHghkLEzE3CMZflN7kg6v/qqyn2/skAqIWwHiAobmYNF
	 xovx9Lj84+SZqP4/U9AVJZ1Wtn5blVdBxMeweESQcN+J5dsQtM3TCnRHr+ejt0eGLcqkD
	 GwxeJuH3BR7qc90CYgmWtAChvViQziUOmPIfxjgm2kyRkG/BUJGg8zgHhKrnyP/d1rlxS
	 rR2N5v6aTKfWA1Sy+9G84LWgni8hl5i0vI9wo3ski3kJtx+99vUBJAru99DSWeWvYYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7F606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71E7F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a42b34e930so3323661f8f.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465909; x=1796070709;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sQ0FWTFeQrG6RUMpDQbCLQltxqCADv7gp0oxnC4p/b4=;
        b=l/OBIwBLqdUcE5UkMdOltqG/h227QRmW4bACm6XrNJ+p0NOKtz1QkUEwDfp5CQsdAN
         vUQpowjQRizrcDKWNWcoyH6isszqwkiQKdsmUX3nXoqAla1S7KrD4HXlmBX7V2kZVXQ+
         +PgxoJKiL1xIDYVpEPnjht2Cf8jZtgFhyJdwAdvTPHKqMR/wUR5mzIaY9r71aB7Q9DMx
         sieTTqwMYXMFm1IF0t5g5c7bUdn2JC0Iji8C3H9qgAO5qaXgM7s5nQAqMEfyrqvUHDIy
         rLog/cKRRx56MUypoIVQuKLS5ygtg4ql2187tu98mYxylcgYF9EHMg63ZA+j/if21ZRD
         +3Rw==
X-Forwarded-Encrypted: i=1; AL+hErEQGP9NGhqgjwhPoZU/FMWeqBXxKbzn9cc2jRIP3xCPvGMsSGuU4rlt6pnlOSJlc3fMB4YIlRs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K5YAGzGlr2a5Ve37fcdHOXDq9aGDPdwKOxolHqWhPuyEhc6pX
	uN3AvMXmBJRbXXnpKX9Xzft2by/i1ZwtAfbUGCtOkbm3uXapRsoQw7jP
X-Gm-Gg: AZFdTZf7AFhODw7SUBaHeOFbb9LKnbqyUBX6OyTkZrZ+2ZGPjYj4ICEyXUznu1MIyR1
	0tnRuGWgFfYGD6agQU08ZypvvWfhodSMjIEpGWXwbsPziyO0ifu3WTKsLVLTsLH6tCwCdqp4IVP
	YxBQ8amjNEHZ4Q19cKTBmlP59saj5Lh855Qd/hBKOmVkDzgXcv8jxKhfxIdrio7AiT+rPZA2Jda
	8lUy1FLOK2RLybiXizHxZtulv3Qh1mwrbCiFSgOhT46J25O2xMDiBNL11B8iH/Mslyv2iylj8a+
	0i8XajdxfY/yCGu+A/mfTB0M+yqW1Xh7cKJ0jQiXH5NKa3N3VBWbO6ecbkE/0usBlIq/2+jwpN6
	M96CLU0XBgD9ewX+/vOIdjZFnW+aZkAk15aphT+h5lxFu1HL5I2Et5l/81o0KAXRYdBQdWwZ80O
	7fGoESfcP4vr82WS6uRHDtCLwcvntiAhcbmqtyo5P4c5O0V4eEsb/THLF1nce8kDJG+0V1SHXDE
	OYDh5pjBLK+HqLBzrtzC9QbIKpalgemTgsDyP0Do40TkL6Yrqt19T+WcdtOB3D7W3i/msLt/4Zt
	wZ55FJG46EyrhZxWOWI1yx1HlPNJ
X-Received: by 2002:a05:6000:4304:b0:4a3:1e75:16c9 with SMTP id ffacd0b85a97d-4abb4c7bb49mr23773054f8f.40.1795465908646;
        Mon, 23 Nov 2026 12:31:48 -0800 (PST)
Received: from [10.68.32.41] ([5.194.175.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm23601389f8f.47.2026.11.23.12.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 12:31:47 -0800 (PST)
Message-ID: <06ed8001-24fd-46e9-9481-b0862dca90a3@linux.com>
Date: Tue, 24 Nov 2026 00:31:40 +0400
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
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: fix copy_buffer() OOB access due to ignored
 clamped size
To: "Kanishka De Silva (HEXER)" <kpskanna1915@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, stable@vger.kernel.org
References: <179514990028.24686.6400570561985206166@hexer.is-a.dev>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <179514990028.24686.6400570561985206166@hexer.is-a.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Thank you for the patch and the report.
Applied,
https://github.com/evdenis/linux-floppy/commit/d4f804348d99f6b79066f593a67d585ac0fc4fd2

Please, use plain text git send-email next time.

Thanks,
Denis

On 20/11/2026 08:45, Kanishka De Silva (HEXER) wrote:
> Hi Denis,
> 
> As discussed, here is the formal mainline patch for the copy_buffer()
> clamp/copy mismatch.
> 
> Root cause
> ----------
> 
> copy_buffer() correctly clamps the per-segment transfer length:
> 
>     size = bv.bv_len;
>     SUPBOUND(size, remaining);
>     if (dma_buffer + size > floppy_track_buffer + (max_buffer_sectors << 10) ||
>         dma_buffer < floppy_track_buffer)
>         break;
> 
>     if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
>         memcpy_to_bvec(&bv, dma_buffer);
>     else
>         memcpy_from_bvec(dma_buffer, &bv);
> 
> But memcpy_to_bvec() / memcpy_from_bvec() (include/linux/bvec.h) ignore
> `size` and always copy bvec->bv_len:
> 
>     static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
>     {
>         memcpy_from_page(to, bvec->bv_page, bvec->bv_offset, bvec->bv_len);
>     }
> 
> When remaining < bv.bv_len (track / current_count_sectors clip), the
> bounds check validates dma_buffer + size only, while the copy uses
> bv.bv_len. If room to the end of the validated region is in
> [remaining, bv_len), the check passes and the copy overruns.
> 
> Impact (corrected from my earlier private note)
> -----------------------------------------------
> 
> The overrun is on the floppy_track_buffer / DMA side, not the bio page:
> 
>   FD_READ:  heap OOB read  from floppy_track_buffer past the validated
>             DMA region / allocation end
>   FD_WRITE: heap OOB write into floppy_track_buffer past the validated
>             DMA region / allocation end
> 
> The bio page is allocated for bv_len and stays in-bounds on both
> directions. One bug, two directions — please do not split into separate
> FD_READ / FD_WRITE issues without coordinator input.
> 
> Affected
> --------
> 
> Introduced by:
> 
>   13d4ef0f66b7 ("floppy: use memcpy_{to,from}_bvec", 2022-03-03)
> 
> Still present at:
> 
>   aebb7274476403040d582c61478df8f4a7bf9cd3 (Linux 7.4-rc3)
> 
> Verification
> ------------
> 
> 1) Proposed patch applies clean on the revision above and builds with
>    CONFIG_BLK_DEV_FD=y (floppy.o hashes differ unpatched vs patched).
> 
> 2) AddressSanitizer userspace model of the copy_buffer() inner loop
>    (faithful clamp + bounds check + memcpy_*_bvec helpers):
> 
>    Scenario: 16 KiB track buffer, dma_off=15360, remaining=1024,
>    bv_len=4096 → size=1024 passes the bounds check; helpers copy 4096.
> 
>    FD_READ  UNPATCHED:
>      ERROR: AddressSanitizer: heap-buffer-overflow
>      READ of size 4096 at 0 bytes after 16384-byte region
>      in memcpy_to_bvec
> 
>    FD_WRITE UNPATCHED:
>      ERROR: AddressSanitizer: heap-buffer-overflow
>      WRITE of size 4096 at 0 bytes after 16384-byte region
>      in memcpy_from_bvec
> 
>    Patched (both directions): clean, exit 0.
> 
> 3) floppy.o with CONFIG_KASAN_GENERIC builds without warnings. A QEMU
>    guest with CONFIG_BLK_DEV_FD=y + KASAN ran I/O against a 2.88M ED
>    floppy but did not produce a KASAN report: ED uses a 64 KiB track
>    buffer, so room stays >= 4096 for standard geometries. Live kernel
>    reachability of remaining < bv_len with room < bv_len is therefore
>    not yet demonstrated end-to-end; the clamp/copy bug itself is
>    confirmed by source + ASan model.
> 
> Conditions for the overrun
> --------------------------
> 
> CONFIG_BLK_DEV_FD=y and a floppy request whose transfer is clipped so
> that remaining < bv_len while dma + size still passes the track-buffer
> bounds check (short current_count_sectors near the validated end).
> Requires local floppy (or equivalent) access to submit such I/O.
> 
> Fix
> ---
> 
> Open-code the copy with memcpy_to_page() / memcpy_from_page(..., size)
> so the already-clamped length is used. Restores pre-13d4ef0f66b7
> semantics for these two call sites only.
> 
> Patch is attached (also applies as a plain git am of the body below).
> 
> ---
> HEXER (Kanishka De Silva)
> HEXERLAB
> contact@hexer.is-a.dev
> https://hexer.is-a.dev
> 
> -----BEGIN PATCH-----
> From 67606424cf8dc4bd1baa690494a2644095beddb7 Mon Sep 17 00:00:00 2001
> From: Kanishka De Silva <contact@hexer.is-a.dev>
> Date: Fri, 20 Nov 2026 06:45:35 +0530
> Subject: [PATCH] floppy: fix copy_buffer() OOB access due to ignored clamped
>  size
> 
> In copy_buffer(), when iterating over bio segments, the transfer size
> is correctly clamped:
> 
>     size = bv.bv_len;
>     SUPBOUND(size, remaining);
> 
> However the subsequent memcpy_to_bvec() / memcpy_from_bvec() helpers
> both ignore `size` and always copy bv.bv_len bytes:
> 
>     static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
>     {
>         memcpy_from_page(to, bvec->bv_page, bvec->bv_offset, bvec->bv_len);
>     }
> 
> When a transfer is clipped so that remaining < bv.bv_len, the clamped
> value is discarded and the full bvec length is used for the
> floppy_track_buffer memcpy.  The bounds check above only validates
> dma_buffer + size, so dma_buffer + bv.bv_len may pass the check while
> still overrunning the validated DMA region / allocation:
> 
>   FD_READ:  out-of-bounds read from floppy_track_buffer (source side)
>   FD_WRITE: out-of-bounds write into floppy_track_buffer (dest side)
> 
> The bio page itself is sized for bv_len and is in-bounds; the overrun
> is on the track-buffer side.
> 
> Fix by open-coding the page copy with the already-clamped `size` via
> memcpy_to_page() / memcpy_from_page(), which accept an explicit length.
> 
> Fixes: 13d4ef0f66b7 ("floppy: use memcpy_{to,from}_bvec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kanishka De Silva <contact@hexer.is-a.dev>
> ---
>  drivers/block/floppy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index c677d7838..b492e35ca 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2488,9 +2488,9 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
>  		}
> 
>  		if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
> -			memcpy_to_bvec(&bv, dma_buffer);
> +			memcpy_to_page(bv.bv_page, bv.bv_offset, dma_buffer, size);
>  		else
> -			memcpy_from_bvec(dma_buffer, &bv);
> +			memcpy_from_page(dma_buffer, bv.bv_page, bv.bv_offset, size);
> 
>  		remaining -= size;
>  		dma_buffer += size;
> --
> 2.43.0
> -----END PATCH-----

