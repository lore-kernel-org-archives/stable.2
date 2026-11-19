Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795128309;
	b=pqKdtAVct7vZrT99OENFvogetzuok/Lck+0rSBrq4tZKdXRbGl1CNEH5NirSTN+FsZx/
	 IdTRWW0hREJOwBMFDDzeI3qxqTENUlKP+M/CQI7c0cvfkd417KzWnFMfuzHGo3D79Y7e4
	 V9JBqw7qQpZ+KspPoiZbKemPL8hJQlOQwyaRLORX2Tudz1kulKHF4zWEVeTlGx/Ar7kMc
	 KtpcqAqk1jr0x6yHTe1fYPzqTEhp0b4+E+4Gx1KdeS/KlrTYJal1CHe5olj1Ay5VBtQ3/
	 F4c5AfYgWGLirCW0PtTZFTzSBGJH+T57HY6bVGtcWrdPIWPaSwJoOXsxDEBv0pMSJMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795128309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=loFCLmyZ5e+oKb4lypNtX85tyQq3Dij1rucPTMpgb8M=;
	b=MpmJIcuyQxb9RxX6+Kh97K9BXt/ikoZ3TevYI1HStdRqZU6lwBr0Vl06XXeYbvOAmv8h
	 xvHX5LcgK2J6DRsRHHC2Bc1Gmlhs6E91xMzfgvVPPMnI8MZj6yvlk54nFLxG2ZUCLsKsZ
	 TsklRjRK7dludel3uZm1i3EJydmJ69Ng1b5ubQvoN8DQKooZTKNi3KsBQ+wOeW00/uJp3
	 cKHAF06o2py9ncvpsP0CwV7mDqyvjUoHSer8NdqQAkw6zTOL2q+uaUU0/zoq2CKEPjHDm
	 DMc0MdIkk71jVpi75Wv9R1E3EohloK3TMVkwQFdNHMaXwSY8IWd4+Je71d7mIgQUowg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=KXOZo9ps;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5AF606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB5AF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=KXOZo9ps
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-71ac9be615eso4266eaf.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:45:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795128308; cv=none;
        d=google.com; s=arc-20260327;
        b=aAChppaMVzr21E61y4WrW0tSk3vxnj6g7Nq87Y/SFi7cbA4PsQnrzDd9ZI8tlhPuYw
         /GY1kh184GQre9lZVWyMcNszXcogjPKA26kN6o3nQ2S7t16ufTKYVxJbXu7DJdfghai6
         E3obe49q0UXo7oI+j1s9FifpuPTGkwRWAGfXDZPCZZI8/DXbMePTWPYnnFM0uYoHaBw4
         RQhZgJDT/yz/WHZ/f20cNw4x0tUSZBPjtWcLRZuXu6g/tUjYh7Fr5dH8lWqu4knsJybL
         SZfR+U20OeaZhvc2zdbVtSw3cv2gl2mXMxmVVUXZbCQE2cAXkBwbqgpmmYK/CD+l8qhp
         ISHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=loFCLmyZ5e+oKb4lypNtX85tyQq3Dij1rucPTMpgb8M=;
        fh=mhxwxPVJjpJwDJEHuIrNuPn2S1eeLTwhos8qBo2hhnk=;
        b=q9S8gk2MP2WwWb6enAeMPq1pJdSkGDEKKwKhnokNawAW0BJWeKSq1CbzXA4gf21Cmg
         c+HOnb77J+ix+l/l/Luj3IMQDihdjnT/McQL0GBaBSXsB3MoA33Fs4id3T6KHtyy5lB3
         QtVHh2cHhBx82Cj+FYN6B9a0ETL25/CpAiaPFlfmKv0yHLsLe8efPd4YGMw4I4Gqexx5
         7w9IjhLiciqXW9Z72aYPUEAIsOlNJ1sgtCFMytPOF+sxph7C4VJhUZPHKVsy6UOpJ9G3
         mi+JtmACN2P1SpoaDt0mYEjOYGTTAlwC9Dd/MlAzRPY3hKYQ1fm4Um+gw2zypb2wpZDC
         bXXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795128308; x=1795733108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=loFCLmyZ5e+oKb4lypNtX85tyQq3Dij1rucPTMpgb8M=;
        b=KXOZo9psIU6r6nzPhsiwozZ9n7/gAyN4ytjOxdjooTyzKsZcy/lZucgv0+wbwtyF9r
         +Kz3w5V1elSsQzc3TFaBiqDX1B1ltUIr+KLi6KV7fMQqvZ5wsMfUwuVMq2xvWwK0Z4PI
         HTyxomcP5+VrDT03sxWLsqzO9hRbrHjZRR/kF0SoF1RdJkQJ89KYlJbqTwTo5q7QRd0Q
         baW5Eai40WVuc8nJnPbf4lQCEeadtXjxLdArnZdETCi76Flqos5jZBnz1sYr/MES8lJ3
         Myxm5KhtjVBtKaQQsmMsGgQjvHq6u3k9siLRw8Wdau+K+ScKxN29sMvQbV+4MgjChFTT
         0wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795128308; x=1795733108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=loFCLmyZ5e+oKb4lypNtX85tyQq3Dij1rucPTMpgb8M=;
        b=z/aeCov5G3YCNblFDFZLzNPL+NmMJoN4LiPCHMWbg8c5j0sC+hijB7tUyCsrQeQtwU
         RXCbmfZw0pqVvan7uZ8LJkK1QVyqVReysCsMbeJMx9vBeBSouRbNhasK6AjH2zb9vnhf
         gTQal8ASWKVNV63iiNeCvDXn+Z1VEYpo1c4Xxa6KWM6bTlko7qlChH5YQ/dIaAMu8DH7
         Otv0zbxPG/Cx840CTp82roRyI5HbP8iOdQjcM9VQjjP4UDgMPxu161TPcwPe2ong7jVP
         rsMitOyXtTrUJJib92TFXDUiWl0MzwYty0dNvyPoZ+J4rZvjyaOnjXjYadAKkvX1zaSv
         wHrw==
X-Forwarded-Encrypted: i=1; AL+hErFXZkKrX0yy90JQIv5/N2sLXnnNrh5PcN4OB3wm72T73N3kS4CACDEHYWw0UTg/rTLK8+wTTaA=@vger.kernel.org
X-Gm-Message-State: APuU4Z++kbKvKxlpiyYwed6fc0rb+9ebKjNm5btbx8fbiveQ4AK2R1sT
	UAUgJ84KsuS7ZZY+yWelF4vxqQw63E4WANaZS4IQ7482q0d1rqKCyS9cJCHvSw38Y0AcdvRW08x
	fIaWQ2OCxfRCDwlayAa9b+wrfd/t33yz4+EVhORwZBA==
X-Gm-Gg: AYBFou08+hz5s6oDbxhBYrrbtW5IWXXJJFuYwZVt+EcOc8ap0qyF6Ni0tuumW/Rtwy4
	t3Z/IVETwV9NBztUftC9JLtkrE4R3zETAO26APWoZcpUFHLpvt296qgcalDbbOF1XXszzHfmS8z
	w6qTzbIzq/oeQBqLhb42POo9XOzU9t0jKRwxpVGLEIiVDoIEnJIADoMDMsK2qtpPE7crDsvZr9S
	p7KwGPw8JaB3NyUQB+OE7w4/OxNfYnInLqu3pZDQXzq49Mf4UsdbJmnqtT41t5Y9WXcCI9Jxfmg
	MAxLiDGzZszftXkrlcZ/clPlodqW2ix94E7jx6uFu5FIWroOfNhS/w70722bCj9rmmxg+L8L15T
	mTYTrJLNmlg0Lif5EI859a1a+NxxPAdG8ygxi
X-Received: by 2002:a05:6820:3504:20b0:71a:fbe0:a6d4 with SMTP id
 006d021491bc7-71b39325f06mr1304500eaf.1.1795128307460; Thu, 19 Nov 2026
 14:45:07 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118154053.13218-1-zakaria.belkadi@inria.fr>
In-Reply-To: <20261118154053.13218-1-zakaria.belkadi@inria.fr>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 19 Nov 2026 14:44:55 -0800
X-Gm-Features: AclHuK-20fKaJbwldjq_qAX_xBJaBiJ2DaYwt5DufQcV7VQJOK-PRVYssNvtcQE
Message-ID: <CADUfDZqgU8Hc934Oe8MTanj57W97AmoQ+VzNK2MSLC0pato0EQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref tags
 are remapped
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr, 
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 7:42=E2=80=AFAM Zakaria Belkadi
<zakaria.belkadi@inria.fr> wrote:
>
> For an O_DIRECT write that carries a user protection-information buffer
> (io_uring PI attribute), the PI pages are pinned as a data source,
> without FOLL_WRITE: io_prep_rw_pi() imports the buffer as ITER_SOURCE,
> and bio_integrity_map_user() pins the pages and normally uses them
> directly. It copies them to a kernel buffer only if they are misaligned
> or in too many segments.
>
> If the integrity profile of the device has BLK_INTEGRITY_REF_TAG,
> blk_mq_start_request() -> blk_integrity_prepare() then remaps the
> reference tags in place in those pages. So the kernel stores into
> whatever page backs the buffer, including a page the caller can only
> read.
>
> Write access to one such device is therefore enough to make the kernel
> write into any page the user can map for reading, wherever that page
> comes from. Two examples, both tested: the page cache page of a file
> the user can only read, and the shared zero page.
>
> Pin the pages for writing when the request is a write and the profile
> has a reference tag. A read-only buffer is then refused, and a
> never-written anonymous buffer gets its own page.
>
> Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zakaria Belkadi <zakaria.belkadi@inria.fr>

Yeah, this looks serious. It's pretty much an arbitrary overwrite
primitive for pages that should be read-only to the process: userspace
can choose the starting address of the metadata buffer so the bytes it
wants to update are part of a PI tuple ref tag field, it can choose
the seed to determine what ref tag value to match, and it can choose
the block device offset to determine what value to write in its place.
It does require userspace to have write access to a metadata-enabled
block device. (Though on kernels with ublk enabled and
UBLK_F_INTEGRITY support, a CAP_SYS_ADMIN process could use ublk to
create such a device...)

> ---
> Resend: my first attempt today went out with an HTML part and was
> rejected by the lists. Sorry for the noise to those who got it
> directly.
>
> Found by a source review assisted by an LLM. I first sent this
> privately to Jens and security@kernel.org on 16 November, because I had
> missed that Documentation/process/security-bugs.rst asks to treat such
> a finding as public. So I resend it here as a normal patch; sorry for
> the duplicate. The patch in the private mail was truncated, please use
> this one.
>
> I reproduced it myself. A reproducer is available on request.
>
> Affected version: mainline v7.4-rc3 (aebb72744764); both cases below
> were observed on it. The path exists since the commit in Fixes, v6.14.
>
> Path (line numbers at v7.4-rc3):
>   io_uring/rw.c:220, io_prep_rw_pi(): for a write, the PI buffer is
>     imported as ITER_SOURCE.
>   block/bio-integrity.c:368, bio_integrity_map_user(): the pages are
>     pinned without FOLL_WRITE (lib/iov_iter.c:1784) and normally used
>     directly.
>   block/blk-mq.c:1377, blk_mq_start_request() -> blk_integrity_prepare()
>     -> blk_set_t10_map_ref() (block/t10-pi.c:483) stores into them:
>         if (ref =3D=3D virt && ref !=3D ref_tag)
>                 put_unaligned_be32(ref_tag, &pi->ref_tag);
>
> Setup: QEMU guest, emulated NVMe namespace with T10-DIF type 1. Root
> gives one unprivileged user (uid 1000, no supplementary groups, no
> capabilities) ownership of the device node of that namespace, and
> nothing else. That user does one io_uring O_DIRECT write to it.
>
> 1. PI buffer =3D read-only mapping of a file. The file is on another disk
>    and belongs to root (mode 0444); the user can write neither. The
>    write changed the reference tag stored in the file, as seen through
>    the mapping, through pread() and by root. After dropping the page
>    cache the old content was back: the cached page was changed, not
>    marked dirty.
>
> 2. PI buffer =3D never-written anonymous memory (shared zero page). On
>    v7.4-rc3 the zero page is read-only, and the kernel oopses with a
>    write fault in blk_integrity_remap(). Up to v7.1 the x86-64 zero
>    page is writable, so the store lands: on stable 6.18.58 the write
>    succeeded, and a new, independent anonymous mapping then read the
>    reference tag where there should be zeros.
>
> These two pages are only examples. The device is the one thing the user
> was given, and it does not limit where the store lands: that depends
> only on what the user maps as the PI buffer.
>
> Conditions: a device whose integrity profile has a reference tag (NVMe
> PI type 1/2; SCSI DIF type 1/2 by the source, not tested), opened for
> writing with O_DIRECT. What is stored is the 4-byte reference tag of
> the device, at the tag positions, not data the caller chooses freely.
>
> Fix tested on v7.4-rc3, same user: both buffers above are refused (the
> write fails with EIO), with no fault and no change to the file or to
> the zero page; a never-written writable buffer gets its own page; a
> normal writable buffer works as before. Not tested: v6.14 to v7.1 with
> the fix, stacked devices.
>
> The patch makes such writes refuse a read-only PI buffer. If those must
> keep working, the PI buffer could be bounced instead, always or only
> when pinning for writing fails. I can test another fix.

CoW pages should get copied to a writable page in
iov_iter_extract_pages(), so that leaves only memory explicitly mapped
read-only into the process. Seems pretty unlikely that any users would
intentionally do that (they would have had to initialize the metadata
while it was writable and then mprotect(PROT_READ) it before issuing
the write I/O). So this approach seems fine to me. Might have made
more sense to disable ref tag remapping for IORING_RW_ATTR_FLAG_PI
I/Os from the start, but would be a UAPI-breaking change to do that
now.

>
>  block/bio-integrity.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index d3df726e0..3ee2d49d8 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -487,6 +487,14 @@ int bio_integrity_map_iter(struct bio *bio, struct u=
io_meta *meta)
>                 return -EINVAL;
>
>         it.count =3D integrity_bytes;
> +
> +       /*
> +        * blk_integrity_prepare() remaps the reference tags of a write i=
n
> +        * place, so the PI pages are written. Pin them for writing.
> +        */
> +       if (bio_op(bio) =3D=3D REQ_OP_WRITE && (bi->flags & BLK_INTEGRITY=
_REF_TAG))
> +               it.data_source =3D ITER_DEST;

Could probably drop the bio_op(bio) =3D=3D REQ_OP_WRITE check; reads will
also write to the metadata buffer in blk_reftag_remap_complete()
(though they will already have data_source =3D ITER_DEST).

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +
>         ret =3D bio_integrity_map_user(bio, &it);
>         if (!ret) {
>                 bio_uio_meta_to_bip(bio, meta);
>
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> --
> 2.39.5
>
>
