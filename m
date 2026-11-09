Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257496;
	b=0QQFonSlou7IEpIWv/5K1D0TnvplDV2U/uXOmmSBWVxP0nOZpghKH3xCOlvEZ41X6RaO
	 WheVOhLxjivEoY8BTgxUgRlV+Nwoai/owDVqwpNziwy9zNzJY7J+369n9lq4y5Vdr4+JT
	 ssuyCZ7encZuMwSBxmMn+hjzGp/WjEMURWWbykjMJ+oMra3l3O1iDAxRYbUb9Up/PD4BO
	 +GrD/uJrnRJGIXpAs4GXdEGV6AnqEM8VDyS0qp+QHjd9l0Grx6OFO/TmjxeSdrvGOioXZ
	 QCmC11An7K5HeOuAYM2pAOQfZTeeUUXbwPWD479A2qwMJxocAlHDKfGTC1X2XnHdGlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257496;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2EnKYM1O2foiG13flnejDTAFyfiNY9oWVxa4iq2fMgU=;
	b=NcfKx6MyfaceJhRCN1ZHxP5BRC/lekhTfauOykaxLqBDzybY+FJxw7quQUX9hK9yFJ4H
	 aOZ6Vk0g+atsqDOVMFSDV1x/7VuDmHCAw6dTRIg+YhCchNNt5r8jvuzOdSQeHEV3tZ5Ia
	 576dHA6ShJTgzSRQpT0lFLDW8Cp6cA1AqALHWbA+SJuvjvDW0ultEsxuNXfQZzjZoR5XD
	 ZpHUP6heeDaHdYH/K3ht5/QfBNdk8nhsdES//YYTbyayskcP/Csw0bpw1rcoGB7zC7G9U
	 K4qYOWgDGH3XLsF7aqnwfRsqzTGOFEL2P6Hc922apqTncL71DT1jShvBuQqeNZmnHww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.win;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693D606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8693D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c247f6687dcso228734566b.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257494; x=1794862294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EnKYM1O2foiG13flnejDTAFyfiNY9oWVxa4iq2fMgU=;
        b=l2V5Ajk6e7xr9kzP/IbZwQpZ1sxBcKTft/POBnVy6aXWvgyceQ/rActj1kpLDdjEpy
         G5fc/7vlOXrqw1u4HkF+J6YFOwtaIv8j8lkcFoLHs2HI4gOz5Qhi88yDVknlO14tlKRk
         DecoaT6UDTs650cShSLh8UobyxLzBt8B8uekMVAt9Bh6h5bV2SEssPA3V2FwH9XKQ+Zy
         trHT+OTvuAwp2cwiAZkfsVl3zDZR5gDxxDgT/Sfu3hMZUiU3+CGVMcitBtPu3DrRgRoZ
         MzZ+sJh2P96UoDksUzIuqJ+OL2cPyNRLrOTMKp1fUgTi+rZLrm1OBzIYuDPh+KXbqeMI
         gqvg==
X-Forwarded-Encrypted: i=1; AL+hErHmWNS577FZn7P+HG1p9Didc8v5EG7mq/W7UA6F3geAiGcLU4cR3Y5N6B9MPTgL5huBLTR17e4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ky/gx9upDDY5ZNwaABeuUDTsfjNcK2MGrwuJouYnpkFuaYcw4
	cWCfVVkrfClHsSigvCiHTK+rpJh0N4G7G/M/Lq0RBXVR0tNwGKdkRy6gtUftfeQDH7k=
X-Gm-Gg: AYBFou3/zndPqo39F5lX+dbrkifGcnxsjK+uWiWYapB4ULKu7WlxsJwyXfly9NaDe4a
	0kB30sWT+3AwiZ9qjPQKA3n0X7E0fDhI9yn8Yq0s34kVNqciQCR/XUT1LInFioBiwu5vqQPlpmr
	RpGFOsm5uXry0VEGbswsN/9WdpRApGjTwudmij9HDV6Xv5KD8N9zZRr3eev6OOXkS839fB7El8M
	DMBweMDrmaiH8ojM9IK0u8viS95qzGXUo5o/U/BCRBoPfMuGi0/pHjsUq8hOjBkFDUW4DtdvzGw
	DJUH8RnV1nqk4BeBh0p1XedMEARv85TgrfoOWOLjTzhCsKtCVmiLIMw+zk3HD0fi41mToVMHYq6
	cXGEN8b+jtgsob/W5GBMoZgkdMkD6UptKzWCMnmm3wdsHcOY71ldHIDk3D4Hs+eqzhQHDHNFnIq
	2lzN7fB4ZfFafddgJBHnaIrbtCEN7rWGkc69vS4e//BFTeyp0IrcOI9GYhOtkPleVRBhPCmsOwh
	eEAgonwCtrWP1nYF5wAsDKP8wM6ajBu2wzqv3Dyc3b09KdbxADmKULtdTdDTdK3ARqDkABYuKZO
	Xi/owGcc/zDFzwJvr8SxI4oEF9QzHAyKtCAGDPLSxr+QoG6tI4YXyESalb0=
X-Received: by 2002:a17:906:d54e:b0:c46:5c4c:7f66 with SMTP id a640c23a62f3a-c504952be5dmr44270466b.14.1794257493644;
        Mon, 09 Nov 2026 12:51:33 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a67c64dsm14389266b.78.2026.11.09.12.51.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 12:51:33 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c247f6687dcso228732366b.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:51:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFrNYRerOgAUgEBKNyZYQsBZQ778K/stXwc6GFA/hOMSYZ+S/z8TF1pu3hfs3m42ayXjvWwYrk=@vger.kernel.org
X-Received: by 2002:a17:906:6205:b0:c4c:f85f:aa12 with SMTP id
 a640c23a62f3a-c50495f0330mr43846166b.31.1794257492995; Mon, 09 Nov 2026
 12:51:32 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105072708.30722-1-pepe.schlehofer@gmail.com>
In-Reply-To: <20261105072708.30722-1-pepe.schlehofer@gmail.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Mon, 9 Nov 2026 20:51:21 +0000
X-Gmail-Original-Message-ID: <CAOs+rJWmmUbYqU34Yb4qJvJsZ92=AztNwNsqX+xD8WaH8tVz-w@mail.gmail.com>
X-Gm-Features: AclHuK9En0QmOUBY4k-RnKbFBU3eXagm58QT4NOxyknJnRPCI_HjRETQwg25oKY
Message-ID: <CAOs+rJWmmUbYqU34Yb4qJvJsZ92=AztNwNsqX+xD8WaH8tVz-w@mail.gmail.com>
Subject: Re: [PATCH] dm-crypt: defer async write submission to write thread
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 7:27=E2=80=AFAM Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>
> With no_write_workqueue, kcryptd_crypt_write_io_submit() submits the
> bio directly, even when called from kcryptd_async_done(). An async
> cipher may run this callback in softirq or with BH disabled, where
> submit_bio_noacct() must not be called because it can sleep.
>
> Submit inline only when async is false. Async completions are sent to
> the write thread, as is already done for submit_from_crypt_cpus. Use
> the async flag rather than in_interrupt(), since callback context
> depends on the cipher driver. Sync ciphers still submit inline.

At the very least I think it may be an unexpected/undesirable setup
for the user: they enable "no_write_workqueue" expecting a fully
inline setup, but still get io offloaded. Perhaps in such cases we can
do a pr_warn_once() to let the user know their setup is impossible?

>
> Tested with cryptd in QEMU (x86_64 and arm64) with
> CONFIG_DEBUG_ATOMIC_SLEEP, and on a P2020 running 6.18.55 without it.
>
> In QEMU:
>
> - 4k writes logging "sleeping function called from invalid context":
>   100/100 unpatched, 0/155 patched.
> - nr_requests=3D4 on a loop device: 0/6 unpatched runs completed,
>   4/4 patched runs completed.
>
> On the P2020, a warning in blk_mq_run_hw_queue() appeared in the
> 6th unpatched run and did not appear in 30 patched runs.
>
> Fixes: 39d42fa96ba1 ("dm crypt: add flags to optionally bypass kcryptd wo=
rkqueues")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> ---
> Based on dm-7.4 (dab527d83462).
>
> To reproduce, with CONFIG_DEBUG_ATOMIC_SLEEP, DM_CRYPT, BLK_DEV_LOOP,
> CRYPTO_CRYPTD, CRYPTO_XTS and CRYPTO_AES:
>
>   modprobe -a cryptd dm_crypt loop
>   truncate -s 256M /dev/shm/nowq.img
>   L=3D$(losetup -f)
>   losetup "$L" /dev/shm/nowq.img
>   KEY=3D$(od -An -v -tx1 -N64 /dev/urandom | tr -d ' \n')
>   dmsetup create nowq --table "0 $((256 * 2048)) crypt capi:cryptd(xts-ae=
s-lib)-plain64 $KEY 0 $L 0 2 no_read_workqueue no_write_workqueue"
>   D=3D/dev/dm-$(dmsetup info -c --noheadings -o minor nowq)
>   dd if=3D/dev/urandom of=3D"$D" bs=3D4k count=3D1 conv=3Dfsync
>   dmesg | grep 'sleeping function called'
>
> For the nr_requests=3D4 case, run this instead of the dd. The writes did
> not finish without this patch:
>
>   echo 4 > /sys/block/${L##*/}/queue/nr_requests
>   for i in 1 2 3 4; do dd if=3D/dev/urandom of=3D"$D" bs=3D64k count=3D51=
2 seek=3D$((i * 512)) conv=3Dfsync & done; wait
>
>  drivers/md/dm-crypt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 8853e9af1c3d..c0552a300e62 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -1982,8 +1982,9 @@ static void kcryptd_crypt_write_io_submit(struct dm=
_crypt_io *io, int async)
>         /* crypt_convert should have filled the clone bio */
>         BUG_ON(io->ctx.iter_out.bi_size);
>
> -       if ((likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags))=
 ||
> -           test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags)) {
> +       if (likely(!async) &&
> +           (test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags) ||
> +            test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))) {
>                 dm_submit_bio_remap(io->base_bio, clone);
>                 return;
>         }
> --
> 2.54.0 (Apple Git-157)
>
>

Ignat
