Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754481;
	b=20Fvp/VU2Smqj3h/twApBRys5yrCztGBc1kpWvcG2x3mOCIm56BCyInc+IZjx5lPSS53
	 d1pjSUbBKZD9SUgNcqYwjXZKb4+ZQyQboBrN0tHFbvkaYN4u1twPVPQAdVRUoByj1BMOO
	 hLJ2z2Tb40lwfd8anf0gKys9T0uDMxqK9g72GFG7DAhDn9HYU+mxKd+wlRazBn5Kui9Cn
	 rWRxEwBHBByR9kggZU1qjqJ/oFFe5eso+e2gRKa13vVTAgVieSWi8W4gSDwkb9f2w197R
	 BiTZVzKXNGSyn7NhAlmePeQIP8PHlY4qBCvTz6f3fhfdnb2/bVe+mULaHVCJ97rU+mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
	b=mqIw9Pgv3u66nFQEopHBypLskvyJGQ9pBZlPsC+HD+82ORd3H3GCCZCO8lvLr0ablQTl
	 DEI5QJs0ad+eTC9z9vGUpkTCcyhmEyNMzVhSXj+dLTbXwAdxflGcEPGmY/E7WPrv/G+Q6
	 VLUeuqcpmOoCkGvArxkLmTS1sZ2+BYtlkuyiptCVkZkmA4wSTCAgbYmKBYC6YsdO6B4fY
	 oMnWuLgH3aSb+NwjfGn73QmRW4tGHrLd+ceUosOLM0wrDmTIAKMmin56EG2/EeYgNmAJC
	 W6BAnLUm9allNeCAB7+SRx5FU6QvpFBns+C8eZawoKiMkaF10yikLxdZIsc3bknZF+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C7606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C3C7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so4466938a12.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 06:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754478; cv=none;
        d=google.com; s=arc-20260327;
        b=lk3aAwRCgjzRZL3clwtivIjEEVHUwpZRmj/iXbIHMOqiC0CNexgOS5Sf4+/j/U4WxL
         rqwxp8jYkyVyf7dgpV2MgYrLXqKQkjtNJBWJXXct/CkKBaF9kdYzl9SS96UJKyMjzEwO
         iTObryzbaL8F7/rtT5uiE9MAWUp98DjZYOt/NWM6lO1E6OHOWs5ZwVXiznY4wBKD0c9h
         j5IhfCqe3qsmnFsXRJTbsNF4N8f6guwNgmd+pwtolW95QUYhZoBi4wpYI4uS15E6pwVh
         NBRhE7M3ONwDkmB5EVrrKtb0IXM8HcHQenrBBTxz8vxYNrWk4lM/Mg0qs8PnLgRJs1jb
         j9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        fh=5s472S28nb2DBauQvDdpJqc/DD6SZobOLacLJpViVAs=;
        b=ak8QlZEVRnvL6B6zOtYepFdFmErc4algbvnRNRLI8I5IF39WJPO5zcSbwBWNh/uzqi
         z5b5bFWJWGbqDY9SGuHBfja97YHS5aJMrEaxWAH1Rfu7fB/rTGbW0E9yj3plxtE5Jn/L
         h9kgbTpiRf7ECEnUodc80i2LUHcDXNglEsAP1c8+EvRZmAhcALO9xpH502Izf86p3NuA
         1lfdL5O/TD07jaA6RhOAgipzSbr9mouM7ZaDUEHDrZ7MlIfMiMNfpjCP73BIqi2d03OF
         KIpeHpFiS2lljC3AKTAO/IaOKeVKku/u/96nq4lOf9mlUcSr4GAgoce8paBaA9nVd3rO
         8GDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754478; x=1795359278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=Nene7tW5gi/n28xM9GPcsrsbApaftwN+5VLijlNSUx682MtoFHHSTEvDl1z11fpu1X
         HvQApdaPQrGfQyiS3FbYQVWjhD4Evwt6P0rS5BC7bOQTZVXFLWaPO4OPsg6ddRko0o+q
         9oJBo3AXuMJZvhtMaEl5yxlnDv3/Y+/ZTOoPRzC8SnU76nRTNG9VsBQOFmcVN+eTzILI
         pLq9xeN6fA01RGoB9NuHnqix3fuxZlQryfHYntRw18u5V1gyWgLisGhonGsU8L2T6Lkf
         J6bkZRN93M/WAUT22qxzPXNMWojuGB568xJ5NJFT1QuthxcS4hfC3ctLRiOXitSCJ+gM
         bTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754478; x=1795359278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=I9CUf0nbJUVE7Sz6iSd2BWLva6hIsYBBgPwbFqAu/qABt1Pdeu6/GvovfostViN3qv
         Pic5pEgQ2SB5KfpCIjDL0ZKFzUoGxolrjhkIA1uKYwcthifQGj21YgwWzCMDmUroQ/pd
         Dz4zXoKOSNCuxUd+QDdwjWdgz3Eumhdtg6vddy970eER18xqSagnNDvADcFh8ruBV8xZ
         jHC4tnQyOntHiWzud/cyV1Q5A8/TJXLka8ecXLHH1ZDYII2xeXfTDmNWonirAuWh0GSH
         SsD5gRYna0mltoX6PKjvNGoYQk0j3L6YFBPA2ymeRfuMxhHuWXXXbzPxh8A/u/rTAatE
         5MSQ==
X-Forwarded-Encrypted: i=1; AL+hErECxI2tneg3bBsVFZiBk9A+USNT7NrVwUG+Ab0qNWs5A36WMc6WB6hf08XEqrRolpdvSoyLvQs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yDIBguMA2t3dcn0pIsxm4/hBKX0XYGLguVuypNmroSveHd4Gz
	b7qxw2CI/MzFT9Yw+71URs7iOxbGwSBHAQpy8M58gZRjLXqTnhLEzTjI3eafgPGEF4jbQf7EAWt
	3PMfB82TnJuIDSyH+hVTcZgQGobceYhc=
X-Gm-Gg: AYBFou0tkMgHLX2MOx5HB1TTbSiYAILVjIL7Qpc38MoejEaMUa+I+Jjbym1LlLLhQLs
	miOyBGOaFd+31OFmgUAxjw6TDgCPBhuUlC/4bYrXd6wGK4UTcQM4xo4I8nwR8lv0EV7+ENSpj2Z
	ZnRmhnmhjcSF5+PN3Omhpo3QwsL/sD6kyr1EJVd1otYzVxI2/URV42VEQDHoFHHVS2GSOuorHyG
	sALuh7f3HelZEzgCLa+8kAVDwjYTra7aKY25M9F4cfH2xxdhlgJIwwNEbpxpJLQFCQ5GN+f8d/J
	ZGjlun8Y+SrTsGtiW3LbalHhrkORH9GHBJ50o+IdV8HvuQztSwMGrZKDEfzsIkcEpiSlEFLrec3
	Tu+78c/Qy35GY29xGix3wr8dADmaNzUVXQI1PTHzeL0IWc6oC0MoGI5av6yUFC/mW0eKOKA==
X-Received: by 2002:aa7:d1ca:0:b0:6b1:c2cd:db0c with SMTP id
 4fb4d7f45d1cf-6b7c0957c1emr4306146a12.10.1794754478075; Sun, 15 Nov 2026
 06:54:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:54:26 +0100
X-Gm-Features: AclHuK8KXHVL-duO-F-YZ8XPwW63n9hxew9z3khJWwo4KtxA0bTnHEz-HW4OPxU
Message-ID: <CAOQ4uxhkqQE+ONrcgJNw2Jah59bKruxUAsLohTtKnsgTVQBw-A@mail.gmail.com>
Subject: Re: [PATCH 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> ovl_d_real() looks up the data of a metacopy file in a data-only layer
> itself if nothing has done that yet. If that lookup fails it WARN()s and
> returns the overlayfs dentry.
>
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there already.
>
> But nothing actually guarantees that. trace_uprobe takes the path from
> kern_path() and calls d_real_inode() on it when the event is created and
> again when it is enabled. So a uprobe on a metacopy file whose redirect
> points at nothing warns twice:
>
>   ovl_d_real(/f, 0): real dentry not found
>   WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2: sh/27=
9
>   Call Trace:
>    <TASK>
>    __trace_uprobe_create+0x1869/0x25b0
>    trace_probe_create+0xcc/0xe0
>    dyn_event_create+0x46/0x70
>    create_or_delete_trace_uprobe+0x3c/0x70
>    trace_parse_run_command+0x1a6/0x320
>    vfs_write+0x1cd/0xfa0
>    ksys_write+0x116/0x250
>    do_syscall_64+0x10e/0x5e0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> bpf's uprobe_multi does the same.
>
> A failed lookup isn't a bug though. The data can be missing, its verity
> digest can be wrong or a signal can interrupt the wait for the inode
> lock. ovl_open() simply fails in that case and
> ovl_maybe_lookup_lowerdata() already warns ratelimited about failed
> lookups. So return the overlayfs dentry without warning. That's what the
> WARN() path returned anyway.
>
> Fixes: 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in data-onl=
y layers")
> Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata=
")

Nit: 42dd69ae1af4 came first and opened the possibility of goto bug
and then 184996e92e86 came later and depends on 42dd69ae1af4.
I don't really see the benefit from stable POV to name the later as Fixes

> Cc: stable@vger.kernel.org # v6.5+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes: https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chris=
down.name
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 08695a99f4f93..1985b553a47b7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -58,15 +58,13 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>
>         /*
>          * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry.  The only current caller of d_real(=
) with
> -        * D_REAL_DATA is d_real_inode() from trace_uprobe and this calle=
r is
> -        * likely going to be followed reading from the file, before plac=
ing
> -        * uprobes on offset within the file, so lowerdata should be avai=
lable
> -        * when setting the uprobe.
> +        * the real lowerdata dentry. Callers may ask for files that were=
 never
> +        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> +        * here. Return the overlayfs dentry then.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               goto bug;
> +               return dentry;
>         lower =3D ovl_dentry_lowerdata(dentry);
>         if (!lower)
>                 goto bug;
>
> --
> 2.53.0
>
