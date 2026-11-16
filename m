Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856740;
	b=eiKVJXHlv6SOeFnOQWo/ir9KxEsLbjTAi6+n4jbgcMIN63Ng2IX03MqRYKtXSvQCmP0o
	 uPH7uhp9Ub/1viUZ5LcfEMt1XkSg8WfyU7YSyAH9oLO5I6ueMflRGE+RFsihuTzvrYopn
	 pyFfKOVMK+HkUmTWfOkUpE6E7c7RSbaVpjmLkRj39RnHop7ZYgxdHJNd/Bb3KSPRcttbr
	 HBusaFHywVckjcTETiN7YMp7wqE43OYG4+WzCTV2J/6S5YflgYTIL71b+tAq7h4Adkmvq
	 HlLnhkJxuonZXt9sXOF1mUtj2aWsTFZct+t1g3z8eqClJ2dZNQPaKNDZCslVK1BVfRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=P+Td53i4gLVL614EDe7ngJcewRkwlZAfzI7C1/wn6i8=;
	b=u6wjYqG/o9bxLk2GWSEiiiyis4vAapQKWekOJ/9GoHQu673x1ILVCEAs+HhoINCgRqZJ
	 0L81rzxnMqik180GC48aVcepjgC/OlE6dKSi9kzennz85Ig3BVwzNDh7U1Apa6T+5i+Rc
	 /ewOiHgL7E9SZIzqtImOjcp5QVFXbqF3fJ7y5yT8cyTPjCfuMbAol1jOqRy1iAUB1pp68
	 reWVX5UT7OzqC1f3z1c5giF9ZgO1WSwwc2uLzlfm1/eAmYdOKrmib1eOCYBv0j488O+JX
	 AZnsOQs2nqdwLx0xbfutKOj61Mpsw+a0JcnvKD15AlmRmDqq8ApsgTmrbrpryiKLf/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ptwj5T8A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A393606A338
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 19:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A393606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ptwj5T8A
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533202fe429so32911cf.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:18:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794856738; cv=none;
        d=google.com; s=arc-20260327;
        b=VX3jvB6bw0w7k1G0G1Z07yu5wkrDS/VrepjA7pxiuPFey6/lzo5HLKE0e90aw0RcH9
         SZUeTqyx3kaReC/d0tzj6l7TyJfafzc3wyGDwwMPr+VruXpcYmHJ87LacdlhShblqjPi
         /X2P/k3fuRQv5SnFTiMyWHdrabPXsHUGt4RWdl/hFrubhPPkplykdwPVUZKYjqrtKiuR
         RDdZFKyKM9KUUXR4Eks3sIPmyo/AqPxLNDVJ3Gd3rb0NR7BxFakfYf4viCDGyi5To3lG
         bJPrTaW0l9j8q448NpH16HGUqx+z2o4ZtV+szqvpOjD62R39AWrsHilXN3CVrRhMvNXz
         b0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P+Td53i4gLVL614EDe7ngJcewRkwlZAfzI7C1/wn6i8=;
        fh=23NtbWaGiLMJMkDo74qTiRjvqfqQ2TD3t4lpd6/cX34=;
        b=UogVc0Slq2dwMWoQQOqDIXoXCC96AyFYzT0uOhKR9J4JeOaC4CTw8S8Aih06pvQtfr
         RRba4QL36l/ozPOky3VO6o5DsH1+7Y7pdXNReySVAJrWSW6sgymkJ3+CbnkzCadOFSzF
         XuC93C0Mh9NP2Yn8uLFfdR8BwXL2jEGAuZpyuRKVss5iUcyS8qQGcDBMHyMTg0j3Ob0h
         ql7tOLIYK3FDAcjMEGEP61og8J/2F6n0OH6gyA419U9xb3za3/tH3rdshsFY01vCw1v/
         Zck3XkKYFCYSePtyxAHm31a101m3i+6UQtkfdQ1oV6PZzu8l9GJRXvP2lAPho6qAWcbA
         +aHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794856738; x=1795461538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P+Td53i4gLVL614EDe7ngJcewRkwlZAfzI7C1/wn6i8=;
        b=Ptwj5T8A2K5rkWcZIEp3+ufdL54DvuHuh2Phf4+nbzG4fLereFTIkUx/o1lJt7ZVLv
         k5lfh4/XghQQxieOkixIAXcMlAx+mKGoEIMHdvvFwAL9HfGJvOEPIOc+/toAVpeU1Qh3
         mISRTsByLEhBCpog+L6eh/f4nnerCyGnBr/NulkliNZGlEg1npRciErR/GoAehR92fkO
         o9/UNpr6DLjPVVP7Ccf1N3uvv0XzKnuVBgOkUZKw9l+INwAAQL72EO7JurGtSyHbg/Ap
         QPp+O5IIOcE1/LfsEylsdnkq+9LlJ3ckkFR5HTRvTrOFYxjP+q3mcZaAA8TOMQZChkko
         K+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794856738; x=1795461538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+Td53i4gLVL614EDe7ngJcewRkwlZAfzI7C1/wn6i8=;
        b=GtxXL6vhRPbVQoqadAC9y5q3zmfGKU2U6bbxe8A1iSFZbF5Ewnr9DjWHPSyRn0Az4u
         0/yM1Pq8EU2ecS2em7fOw12bytP45tyZOYl74/qZ7I6Ow3/5Xka2yjsAjCnzby1CbAXV
         4IziKQocZPlhS2DNvdZtyXfxrTWYaP0fiHEGXPCOeMvdC0SyNd9xnchzyh1pZyRsCgpF
         /QK483jQ/ipRDn6Nfab5u+k0DRASjisuOfBiZHDafEbLPLE8ddhm4s5/eAJQHagFuEjC
         JUqkAuJTM52xgLB2M+gR3k5AvUF/wsR+G0E7Kmbz87qptIZR85E80UiIWOumHE0ApMB1
         DPZA==
X-Forwarded-Encrypted: i=1; AL+hErFutev0b/qMMnmtpXcdwOU9m1T95pSl2R+osAEecZ9CDsUApNt5dd8+BtoA0WOf4AFiZtRsx+w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YQHt4SB33ZNxNFQ+LDnFC0N5AuKMChLCwSyX7wQVTEdpTEYpn
	McfXKOqszf4zNjEPR2swW8Wcr4/r3XNJMT7CLN28DZfCxBPVETnQg+QbpzLViojGtwKx4lOgs0Y
	xGmQ7jHzw357TKDdQImDEbKI0Yts7rTc+8j9x0FLb
X-Gm-Gg: AYBFou3EQm7zEfJxWn8EuT+dIpsVF1ephk0swzkortQOaW34fmayCBk5eiI4p+q22iX
	QCRP+Adco5ZwA5RIx8/N+34zXHSXbXwP6+FLEAcQYGoSqnRHmHQt9zLGhPFfVoVjhZ+VEqD0j58
	iZ06rpu9B6PkGcv9rJkS98/22ui+Salup21fszCGMc2CdLrqnNlVfqKWCRQmvfrjX/dff76mgds
	p/clUrCnyaMcXT5VdsM3mfRNOJBeFdxVkp/7kzLALYNKS6FrdDK8NV2w7aAd+bC2C836+3w9UL2
	N2rSjvK1XSNbAs8KJiBloXnMv5rAt2qJxT+++Qi1q7LJ8Qo1stSvhWpC4cf2p3HXYulEKOna9AA
	NqhfKZONrlXYO/CeUjUUSfdnNYhwLOX/vyHC+HtSD4QLzrmQaXKhnmjRiPSkmPY4tSGW/
X-Received: by 2002:ac8:5cc3:0:b0:533:9731:f0f1 with SMTP id
 d75a77b69052e-55d4a2054d9mr1659681cf.10.1794856737600; Mon, 16 Nov 2026
 11:18:57 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116000534.2303800-1-daeho43@gmail.com>
In-Reply-To: <20261116000534.2303800-1-daeho43@gmail.com>
From: Daeho Jeong <daehojeong@google.com>
Date: Mon, 16 Nov 2026 11:18:21 -0800
X-Gm-Features: AclHuK-qQ2-LUVPUDC8WbXro110m72c8YZKmMgPHn_9p8GCIathgq-RTR8N6zaA
Message-ID: <CABdZyexiNTnEkbrY0Pzw2ADWMCiwq2dSu521yBmec2+0PGiEnw@mail.gmail.com>
Subject: Re: [PATCH] f2fs: don't skip the inode update for a size grown within
 a block
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 4:05=E2=80=AFPM Daeho Jeong <daeho43@gmail.com> wro=
te:
>
> From: Daeho Jeong <daehojeong@google.com>
>
> f2fs_skip_inode_update() lets fsync() skip writing the inode when
> FI_AUTO_RECOVER is set and i_size is block aligned, relying on roll-forwa=
rd
> recovery to recover i_size from the position of the fsynced data block.
> However, do_recover_data() extends i_size only by a block that starts at =
or
> beyond the recovered i_size, so it cannot recover a size that grew within
> the block holding the old size.
>
> For example, on a 4KB block filesystem:
>
>   write(fd, buf, 14KB); fsync(fd);
>   write(fd, buf, 2KB);  fsync(fd);
>   <sudden power-off>
>
>   - the first fsync() writes the inode with i_size 14KB.
>   - the second write() makes i_size 16KB in the same block. If it is in
>     the same timestamp tick as the first one, the timestamps do not chang=
e
>     and the inode is still clean, so FI_AUTO_RECOVER is set.
>   - the block is already allocated, so the second fsync() updates it in
>     place and writes no node. f2fs_skip_inode_update() skips the inode as
>     well, since i_size is block aligned and equals last_disk_size.
>   - recovery finds i_size 14KB in the inode from the first fsync() and ha=
s
>     no block to extend it with, so the last 2KB is lost.
>
> Repeating a 2KB append and fsync() up to 16KB and then shutting down the
> filesystem left 117 of 1200 files with 14KB on a 4KB page kernel, and non=
e
> with this patch.
>
> Set FI_AUTO_RECOVER only if the old i_size is block aligned, and clear it
> otherwise, so that fsync() writes the inode for such a size change.

Please ignore this patch.

I missed that Chao already posted a fix for the same problem:
  [PATCH 1/7] f2fs: fix to persist i_size extended inside last block for fs=
ync
  https://lore.kernel.org/linux-f2fs-devel/20261022125244.2205275-1-chao@ke=
rnel.org/

Sorry for the noise.

Thanks,
Daeho

>
> Fixes: 3a3a5ead7b6d ("f2fs: do not recover i_size if it's valid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/f2fs.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 50a5f845176d..b328e678d295 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3676,8 +3676,9 @@ static inline void f2fs_i_size_write(struct inode *=
inode, loff_t i_size)
>  {
>         bool clean =3D !is_inode_flag_set(inode, FI_DIRTY_INODE);
>         bool recover =3D is_inode_flag_set(inode, FI_AUTO_RECOVER);
> +       loff_t old_size =3D i_size_read(inode);
>
> -       if (i_size_read(inode) =3D=3D i_size)
> +       if (old_size =3D=3D i_size)
>                 return;
>
>         i_size_write(inode, i_size);
> @@ -3686,8 +3687,16 @@ static inline void f2fs_i_size_write(struct inode =
*inode, loff_t i_size)
>                 return;
>
>         f2fs_mark_inode_dirty_sync(inode, true);
> -       if (clean || recover)
> +
> +       /*
> +        * Roll-forward recovery extends i_size only by a block that star=
ts at
> +        * or beyond the recovered i_size, so it cannot recover a size th=
at grew
> +        * within the block holding the old size.
> +        */
> +       if ((clean || recover) && !(old_size & ~PAGE_MASK))
>                 set_inode_flag(inode, FI_AUTO_RECOVER);
> +       else
> +               clear_inode_flag(inode, FI_AUTO_RECOVER);
>  }
>
>  static inline void f2fs_i_depth_write(struct inode *inode, unsigned int =
depth)
>
> base-commit: b9d7379d10d43386b59082da8c9a0b111e054781
> --
> 2.56.0.611.g1030f0b940-goog
>
