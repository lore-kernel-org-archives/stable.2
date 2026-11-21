Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795219688;
	b=cVbOnEIfFMxgc+cXhCDFRDUjI5tZhq0XwQnbbqe99/99HPwHNudbvDbRZTczGErE/LeX
	 5CE1nWttuVrvOjh6+ZibfvBsGnpPmiPTb/YupZ2H16h6+ziKnFjHzGJ9lXC22qeXlWsNK
	 PYOnGwJ2cLgeLrVwCbZdkZzJdyoRM01VhRJ53jCvAM55FTylO3YS1hfChFAxcWq3NknwY
	 +4xPvuimHkZoAwrN7wedZ7yUCpQfkEuOP3jhWStUUFdsBEu/VQJXea3fnvl+SNMVwPXKv
	 vNllk+WvMKdqKWrDroB3KSzpyqVkPniO/wHnOjeJH6iRutu8F9bVk46lZL/i7klUjJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FsYdnJMQiXGx+l4wB1iS5+Tppoq3uO18Wl9vnGYexkM=;
	b=vs+unq34rn4/dzNcyVC2/yQZQpJnfldVfoAW8XMCPxHGIxM9cCOPSjipLtN+61d7sGa9
	 MgN98IxhjWkgREGnjBYKhUls2ega6B4qmqNdoOeEAMKuF6lfENYpDQ/gyNR6R4SQJmUvf
	 08sAyHZjZIBA0qHzmOpuB5Qec+OYzjFf3pAMuD9/7v7kLx2Cs3SZ1s3LqGrGE096SyKk6
	 K+J0dDM/YA3hkGya8r7b6SULtRmxeqADkN4xpg4QMHD21JGN1S0E3EqPXVQgmY4eYwVm8
	 /K1nvcDOcF94Z6lanCnXJSVMz95mnbgUrXh850IA2B2ZmoR1dyx13z74dJRo+Trt6ZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Ed2U7PXw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88520606A68B
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 00:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88520606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Ed2U7PXw
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6ddaf3b8defso41231eaf.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:08:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795219679; cv=none;
        d=google.com; s=arc-20260327;
        b=AzDA+nzyE3UempAD03+ZH/CfvnYKBpGjc0jR75nEvCCDpHhQ9Ilnx9RusnaZksIcYb
         WqRtMyrM315GP73ox3ib/AC/zk6laSrk4PhIta9klJMT21qhYpAXS6TnAKn1OShl0qL+
         N52QGA68/QshU0xDnWKkOAaVvys/WCsLIcOGkUvNOH4s1J/cUYfXZNzGfVUspZirrw2i
         LsnjZWJGzTehsxw7bFDtUpcaJssZ7lUIfGqUBtfsIWAdeMcWswPkKUE7qcJi8kfMV5vw
         uITPB48Kro2ujzQtUwYEL5ya2ECYhGI85yTyCKjYZbd59M0X42XKhfF9hVZfOIWA0huX
         XTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FsYdnJMQiXGx+l4wB1iS5+Tppoq3uO18Wl9vnGYexkM=;
        fh=MfIfYV9xx3GlDrSgpZ3Dbi8WsDyRVrkJoMGAC0MuTFk=;
        b=XJP88GvsEzyJPcbawEZeH/NQ5gEXjuCvQF1uvn01ZITZUB+il9dHSv3mCMV0/nHnUi
         3Kgu/sx0G2UuJ2ua5wEKqJwUngn3OspnTwSgkoYB6GoEOLLVzhyoMSSB8BCQV45Sc36P
         a0XzEx628oLS/eZn6B68P08q/L0sV21hw65V7ZWEmnqwQ8B4RP7kB7ePtzsBnOjL26If
         Rw6O6LKGj9/Ks9q35DAKHKDJVgfbEuQX/xDBqZVknFjWCSNO5Ea3K72KWqzaH5Fksfhu
         UuSXrtHjRMf7s25H8XG0Wg6FLVzEWb9i1WIarIYQHnL1ZSfLsqF19pALgnoi2cbdw4S1
         UbIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795219679; x=1795824479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FsYdnJMQiXGx+l4wB1iS5+Tppoq3uO18Wl9vnGYexkM=;
        b=Ed2U7PXw6MISwxBLMOCl+VIadm1US5dV+Ir45yownslIgxA8LVqntjLWpYBc0Eb3ih
         tuBOgHGJlmEiI9IG+4enilv0JZqtryrgJcEVls4oyensXmdxdLCdhEsS3QK/PE9GQYfo
         T2TzLop2IOwT5Jby8AZJEsKqgLn3uEyIqaFon2Z3Yflw8KuvdMwC3+rKEd30ADiTiTX8
         q8Er/iHZm8vsSNpRI83WDVEisA4kjGFtAVn5fRR90a3gt+aqgUjEz2nuRqJGZjQZIQfV
         +OL6nEUtDY8rqjdJgMBZfgMSfq+kpalrgBtVkNl/77i04XJ3j/kEpoeh01v18xUtW/ge
         RCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795219679; x=1795824479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FsYdnJMQiXGx+l4wB1iS5+Tppoq3uO18Wl9vnGYexkM=;
        b=JSO0SY+OJvRzFl0C2CwcCNvA3s2YQ5OVJDw/UVkANFUNsF/f7btldCGpoBAhmnFUt/
         KvBjz371LJpXklAUQYf0iIUxR8SYynrrxlgA6jq95fppn8LFU8MoSSEgwnClr5E6HNT9
         JWUl0zNxYVSjhp/rY4O7d0A+W9wkLMiZQInHFD6WZfAm9rRnCx3dxXclkv+rpce4xmAo
         Vq44fPcE1EVbA431DbV4An8f0KuK0yPWZuxh6KUZwkCCJfH22fKO/U4sTgTNRXuLwGzi
         gf/uHTm1DgnsCRCgSNVR2o8oGxtn8pN23B9gD6HHQG40gD6rqPB8rqyEM3Eg2M88TmZe
         KcBA==
X-Forwarded-Encrypted: i=1; AL+hErHKTWA4WbD0NrwnEmK32FCv44FT2NfEVtklAh6Fff0Zxe+NC0+OW2+qz+VhxojltCLgKFIbqNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eRCf7NxaJi1hoWtrjZDk7tiGAUCfoZyLQ4HWeKth4iePcrzA5
	tQxSb0jW0q+vQnrpZR97yX1DNlWkXcVjlK3TLbULf/GZ7vuwFDccpb0AJyPjFi2ErZBWUMhxpZO
	yHyIyEHrKzpo4YloO2gArzmSNkE+Hm3CFRAh+SK83XA==
X-Gm-Gg: AYBFou098T3cpU2kDMfScAcL749cHSZWwDjOvgUVjvm8BauctckIjd9q4jICYgOp23V
	N2xkqHnw2jxQ1Szg7vwkDIpLSrBFA2QS2WQ57qMA8HfR9GSoJAiGx58QQsjqAXE08F4Bt2juH/b
	8DfaJny/KWW5n/lkKitJ/RzATYAQuztise3fcgxhL5E0juMvZ/rX1b4qtgRS32j0KQmPau5Xth5
	7Pfg8QDegNM13drmOfrg36CvvIq5Q/ZNhmt/rX03wpsylyHDxCPIwQfN2EQynyoxvS7ZLQOMRdq
	5OPgKb/KsppbQgolQd2TE7MWR8KaobYdbniFXdA1H6Vnpv30gqKVwiQP5b4kOiOAceXkY/EulMO
	9NnbndaBms8UVjGIiRhW4nODqnSyNR9WAa3t5
X-Received: by 2002:a05:6820:8599:10b0:70d:73e2:ff02 with SMTP id
 006d021491bc7-71b3932ca28mr4872166eaf.1.1795219679399; Fri, 20 Nov 2026
 16:07:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
In-Reply-To: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Nov 2026 16:07:48 -0800
X-Gm-Features: Aa3M54rN4fU2kZ1g3VyH3yN2HzL0XDhjtM9rK5s54_qMhP3uUFFQ5hk9tg3rtPg
Message-ID: <CADUfDZpvgi5t_iy2AOhUTfQ9p9XNC_xosdKkMsQ-D11KntK-Yg@mail.gmail.com>
Subject: Re: [PATCH v2] block: bounce user PI when writes may remap reference tags
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr, 
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 11:56=E2=80=AFAM Zakaria Belkadi
<zakaria.belkadi@inria.fr> wrote:
>
> On an io_uring O_DIRECT write, bio_integrity_map_user() can attach the
> caller's protection information (PI) buffer directly to the bio. The
> block layer pins the pages for reading, but reference-tag remapping can
> write to those same pages.
>
> A caller with write access to a block device whose integrity profile
> enables reference-tag remapping can therefore modify a page it can
> only map for reading. In testing, remapping changed a tag in the page
> cache of a read-only file. With a PI buffer backed by the shared zero
> page, the kernel faulted during remapping.
>
> Use the existing bounce-buffer path for REQ_OP_WRITE when the queue's
> integrity profile has BLK_INTEGRITY_REF_TAG set. This copies the PI
> buffer into kernel memory before remapping, so the caller's buffer
> retains its original reference tags.
>
> I found this issue during a source review assisted by an LLM.
>
> Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
> Cc: stable@vger.kernel.org
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Zakaria Belkadi <zakaria.belkadi@inria.fr>

This approach also looks good, thanks.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
> v2:
> - Bounce the user PI buffer instead of pinning it for writing (Christoph)=
.
> - Dropped Caleb's Reviewed-by, since the patch changed.
> - Corrected what the caller controls (Caleb): it chooses the address of
>   the PI buffer, the seed and the device offset, so both where the tag
>   is stored and its value.
>
> v1: https://lore.kernel.org/linux-block/20261118154053.13218-1-zakaria.be=
lkadi@inria.fr/
>
> Open question on stacked devices: the test uses the profile of the
> top-level queue. By my reading of the source, a device-mapper target
> with members of different profiles can get a top-level profile without
> BLK_INTEGRITY_REF_TAG while a member has it, because
> dm_set_device_limits() ignores a stacking mismatch. This condition
> would then not force a bounce. I have not tested whether such a
> configuration can accept user PI and reach reference-tag remapping on
> the underlying device.
>
> Would you prefer bouncing all user PI buffers on writes to cover this
> case?
>
> Tested on v7.4-rc3 in a QEMU guest, emulated NVMe namespace with
> T10-DIF type 1, as an unprivileged user who owns only the device node:
> - PI buffer =3D read-only mapping of a root-owned file: without the patch
>   the reference tag in the file changes; with it the write succeeds and
>   the file is unchanged.
> - PI buffer =3D shared zero page: without the patch the kernel oopses in
>   blk_integrity_remap(); with it the write succeeds with no fault.
> - Writable PI buffers still work, and the kernel no longer modifies
>   them.
> - Stored tags (as root): a write with a seed different from the block
>   number succeeds with reference-tag checking enabled. A subsequent
>   read using the block number as the seed returns the expected remapped
>   tags, with identical results before and after the patch.
>
>  block/bio-integrity.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index d3df726e0..aaea5802e 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -394,6 +394,11 @@ int bio_integrity_map_user(struct bio *bio, struct i=
ov_iter *iter)
>         copy =3D iov_iter_alignment(iter) &
>                         blk_lim_dma_alignment_and_pad(&q->limits);
>
> +       /* Reference-tag remapping must operate on a private copy of user=
 PI. */
> +       if (bio_op(bio) =3D=3D REQ_OP_WRITE &&
> +           (q->limits.integrity.flags & BLK_INTEGRITY_REF_TAG))
> +               copy =3D true;
> +
>         if (blk_queue_pci_p2pdma(q))
>                 extraction_flags |=3D ITER_ALLOW_P2PDMA;
>
>
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> --
> 2.39.5
>
