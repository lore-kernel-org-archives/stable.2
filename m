Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C67082D
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074481; cv=pass; b=A8/WlLdQhP94LFiTARxMKTlrjtnnmJ1Jy2Lxk6KnaAYy6Tk0lBz0XghPOgzq39C0Gz50qG2Bz5pgoxoPo6y3dCyufIztYLmZy5OThnUY8IQ2C36jUMsc6WdiOrKw4q3nt4tMInZaS0t8zbOvmKWoFmK3YhQdoGPvVkwYVDxLNNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074481; c=relaxed/simple;
	bh=vxqRkode1N5DmJUSeBRsPBQbQlVjSFbN5aGURVmKVs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ1ODCtx/H2n93Aw7PQJ3EV/LgzgLWjRncn0dx3qc/FQbb5JgpOY/QbVuy4qDoMZPrGgPE5QIx4TE0MdF059mbsYSvlTEeH03WFoBgm+jtLP3ketKplocL/cVaJ3597lOpAa224GRpvSlKLS0L+VCcH25UsWcZG73EFypLK4pdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFMiuHnY; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFMiuHnY"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b0496f4bbcso582458eaf.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 00:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788074479; cv=none;
        d=google.com; s=arc-20260327;
        b=r1vCzk5HerB/boy+iCGDnRIAmneOQqqFPxWc+dvvwUQq1wHUAXdK5sa6JQOL4aVsyE
         Tct1x01ituBV158FBuQ1H3zQ04tBL+PpUjI7Jz3EVIjXH5W8z8crnjzi/TdqqBrNGR+X
         sZkaB5XQ9I6b/X6Tdux0HWbZgH88JllbZGnhDe8TZXdt0QG5NmJ5DADE3go8DXE2/p5r
         WTmqxLzEyWRqoumvU+LDGAthmtCUIckXliy8VqEIBeTL78+31biIPX7OMp5lCAaCKWXL
         5aN21KHGBaozFJXT2eSVnQekQjhxgkFXukwt9Be9Nj8L806A1b5gkEGfreQvz1Rz8ZD4
         nMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MxFE0zUp+nNkdON9i2WoUi61XXQ1qTC1IWyKmYd9e3E=;
        fh=WlxAqZneDDcGhepTgOSdGz21hXG1UPYRnQzzc2uxEv0=;
        b=sORkL2Rny4rIXFK+8ze/bY/qCp/kBiBfr++gzGVS6pKoKEUzfCllnlpvB7f5ISYSe/
         LK5MLKWXWjM2YgsqVO0QbDUQyTGwNWU4VICCidhz7aeP4q04FihgzTOsJZcSGPy8kIiu
         vGfyOneXhsQLVT7qO26zRC2FjK+RWfh2aWx5WT6sqR6N3c5SKdqK9i6EPq5hP/oiSkgu
         9veZUsm2x6Z90O3DTiGNonEbDZjIV+XKSc1PZlVSMdDY+xDdFP6bWDWD534ObpcMDdvd
         GUCrGIHItEKFrNZf0aL9tolv+LVzDHQM4XJKAzkUX7AUUKehoTJ0D59BhcfUkl6NqH1/
         uJiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788074479; x=1788679279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MxFE0zUp+nNkdON9i2WoUi61XXQ1qTC1IWyKmYd9e3E=;
        b=cFMiuHnYDCu6WWrm9fFrQ6n9xXiknf1Fu/Al7gKNoU9cK/B6QcRBPCqczBZf1Zg3Dt
         GbXTpLh5zJmjt/cTOlX/5J3Yuqul3s2bJ6H9QU/YMrbx1g8FC8vGzaC6RMZWJXVMYUn/
         gVyAhtGncAbOD3DJvrucrXoG3YZ/y9td0O4+VG28Ch4CdFTaTbbdJJ5jkv+vN01o0q/v
         GvPsud4Ow0ID5mwjmaFdM8GmuYR8otFG6NOaRPMjAu7JTJXPdTJmVIbjgIYPRmmay6II
         ejz0TVyd3aVVSu7G67/UrryM+Md+nOL32kIyEKY/h4vayw6mhhwirESOVplVndDIl830
         Q5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788074479; x=1788679279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MxFE0zUp+nNkdON9i2WoUi61XXQ1qTC1IWyKmYd9e3E=;
        b=lnfBaq7vWZhR2OV6WdId2l9jhCBemjZvpODDJ/I/DM7/tL4n6liUsRu6aFd4Z/2j8W
         gEBaLyY3uGB/BkUg16ik+9COaByfAKcjpRBte5dfr/ycwaIX+PnFHg6XTwzl3oOBGfo2
         7uPM7cMPbNyew8TefQNlqw3vf4VyKyReaqpP7I3DLBFaDAteVwyvmNtBlFFuyif3Yall
         WBQ158ZjttKD6NKRaK3l9MKR1iOajeICvGXHlWkK6RlKjLQbMYZ9+flEzaZJ+tWM44IQ
         x6/Tx87i5KqvHcDRDRCviFlwzfVfQIqpVFLabjq3/i3V+Vxkv7/EngGHc0Bo4WbRrGk/
         6XnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqckY5eoexB2WstxA74EbfcgJtLFLYtohyLJ3dGVCX+vFPfdz2bd1gq/pgH2YSweu8WWH6YEGk=@vger.kernel.org
X-Gm-Message-State: AFuF++kzshEBpZ7qv9KP8jC3lXd7kIUlczBt/qQ5QH+zi2veOZrtaqqw
	g4yFr68k2xtB0nKvG6k62k3krCFlR2q2IUo6KmAqalli2OthRQKJekcGArImg6u+tgPqxc2d1au
	JdfXHf2N3qCkHFu8vC9ewEmeTSudL+KE=
X-Gm-Gg: AR+sD12igHYStWHtrjqTbPtKjO1v26I4LSg/TazVaVO+GvJNOBn+fxjmz4gtiTtOZFt
	oR32mwUIqTk5xDi8j7p9MjW6e3HV+msreOqPJq2R2ukntCQSaIoxheSaII9Jh1X4Kf5OmGuiF4A
	iR6LvqgkfYzLVz5/7ab52D+hZLiBv+8YnzS5164lve5WPMEHNWgMQxK/HVcjPJZoiymFYPdF2Wq
	mPcZrboYBtz94mj+eRkzUF9tLwBKE6rF136Q/vZmOWV6kxW2GEI/ZR2sO/acrv/5e+oiQoswGxP
	KKjvpNba5eSBFfq+9d9CUpEKi1J0T/ZGCB1VCBMvDVeaDLIcn1W/Y54LaMSUx5q8ILTwLI/XwV1
	Y5qZmSrmJhEpf8bePiml/8mdhKkYOy3gJKuR75jYUW2Wv
X-Received: by 2002:a05:6820:278:b0:6ae:84e6:2de0 with SMTP id
 006d021491bc7-6b1c6781b73mr11380362eaf.26.1788074478778; Sun, 30 Aug 2026
 00:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026083055-isotope-broiler-88e5@gregkh> <20260830070133.559-1-kpskanna1915@gmail.com>
In-Reply-To: <20260830070133.559-1-kpskanna1915@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 30 Aug 2026 02:21:07 -0500
X-Gm-Features: AcwNN1XuQXBOm0cta1RACNdrN1XSlRBY5mMzk6tirgVNAPg-vNkK-Ups_ZUSHbc
Message-ID: <CACVXFVNajkuPLmLbUA83KRCQTqfZHGcpTf+ROJbRPuy3oChhQg@mail.gmail.com>
Subject: Re: [PATCH] ublk: clear VM_MAYWRITE on read-only ublk char device mmap
To: Kanishka De Silva <kpskanna1915@gmail.com>
Cc: greg@kroah.com, security@kernel.org, stable@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 2:01=E2=80=AFAM Kanishka De Silva
<kpskanna1915@gmail.com> wrote:
>
> ublk_ch_mmap() rejects mmap requests with VM_WRITE set, but never
> clears VM_MAYWRITE on the resulting read-only mapping. This allows
> a userspace daemon to mmap the per-queue command buffer PROT_READ,
> then upgrade it to PROT_WRITE via mprotect(), since VM_MAYWRITE was
> never cleared.
>
> The command buffer holds struct ublksrv_io_desc entries that are
> kernel-written ABI; a writable mapping lets an unprivileged daemon
> process corrupt fields such as addr, op_flags, nr_sectors, and
> start_sector.
>
> Same bug class as the drm/panthor and drm/vc4 VM_MAYWRITE fixes, and
> the 2026-08-13 ptp/vmclock fix (a5edadbae57e).
>
> Verified via mprotect() PoC: before the fix, a PROT_READ mapping can
> be upgraded to PROT_READ|PROT_WRITE and a write into the command
> buffer corrupts io_desc fields (confirmed under KASAN). After the
> fix, mprotect() returns -EACCES.
>
> Fixes: 3fee8d7599e1 ("ublk_drv: add io_uring based userspace block driver=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kanishka De Silva <kpskanna1915@gmail.com>
> ---
>  drivers/block/ublk_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6c5bec7..e5ba07d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2653,6 +2653,12 @@ static int ublk_ch_mmap(struct file *filp, struct =
vm_area_struct *vma)
>         if (vma->vm_flags & VM_WRITE)
>                 return -EPERM;
>
> +       /*
> +        * The per-queue command buffer is kernel-written ABI; prevent
> +        * the daemon from upgrading to writable via mprotect().
> +        */
> +       vm_flags_clear(vma, VM_MAYWRITE);
> +

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming Lei
