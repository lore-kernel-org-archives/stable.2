Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541633D47CF
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939704; cv=pass; b=GZWE13HLQdrZmeRpf/lc7RMyD2Lva63QspeELPeSYlm5E4WS5Hv6VD40LDuoatf1BGpwtmGKxr8qhVHveOw7lmsH6lE8wjSXwEWQ+AJcf7YqzGquXYUo7dXh98uIBGRz7UrwghgnO2zBtADxsNcxCfD0RkEawGt8Et7xHdTdFUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939704; c=relaxed/simple;
	bh=cowmi3+ykQJgNo3AqI6VXQ21WVCN8gyxHrZRNzzg/dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLHCkUVPTK7jZig2TM0TS239kqlwlXZe3t9qad2vvSdEhxgt4pfE6Ag6dhgj6ryhTSzfseQLLrNNqhUvUN6tVDA3Dzh4CMnbai/ZsVblsqzzv3b1gj3A8nDfE+Q7ENhhLUyoCUV4A7vn7yEWI2QiOdmQOmBFhW7CKAo+E1uvhMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=irCwmW33; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="irCwmW33"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5176ca6bab1so49541341cf.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 10:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939701; cv=none;
        d=google.com; s=arc-20240605;
        b=lfTaTMjLmLRF8g9UvYmirE+vOecNtZoJkUL5446UOowFODRCxNJqP6PjIrivL57zUj
         cQ9TZBwlMEw34+Hzi2zyTGEE7IMvcHk3gZUd3uNn0aZJ9Avn5yr6c2p1gXvvg7Gw5nF4
         iPTHSt+TFHSaw+LrWTQw40rliAIRjYOw/u958SuyHeSbef2/9UWM7k+rVVfDeGgu0jNv
         0eZkOOPWraEbnV6veVy4NrDHOLhJO1nsP7kj+DZeX/4mq5SL+VU8Pv/4uJgcEL/Es+D0
         TAugDR/CiT1zOF/+8EQNi/TBHvzH7MJzepcg/5OxEDHMsCmd1osrV/B5nmuwhaUbhVol
         0Srw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d7U4zc/LNIPR/5rhjvkAHPlVmeHUKWR3UtKoj1Vq7Wo=;
        fh=nQOlRDzusLnjlp3yEq+QYSROFLstq7UPDs2H8jc2x2A=;
        b=TQagjfkwZMJP1FdV0rbN+AOIsMF7BADOIq5cKAb3ipZ3HoWbYf4fUt2ie5OrXeZiqw
         F2FcG7vGn9/RZ5T8mQNOYri81BHh77M6Xkk2aZiN492KcAFg9tcD2rPbBgd6ZOdROGre
         EpjgyrIKD2JgLYtC+2O48Dk2gv6DgYB5jCO6Hy33djM67Uc0MNAJlwpSZ1kIFtTUOP4g
         O6cgObBSPEJPXdmqC6XUKufuI5Z0ps+YkKZp+y0LXBNN2HHV5VlVJeplNWEMdUtgYpfw
         JD7m86zqYkPNDiibz0kG8Qrof4FKvm3Z4BHsKv9KBDfG4wywQP1ERr++pHyWH1JPp3tX
         PejA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780939701; x=1781544501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d7U4zc/LNIPR/5rhjvkAHPlVmeHUKWR3UtKoj1Vq7Wo=;
        b=irCwmW33DhJTOZqenN+5dzP48G6DwT99fn9GglKNNT8m5UGSGcOdLUAuVvLmgo92Tq
         XQgXbo0tbvokqkMYh8VB+14LVL2TZ/WoN1FtVexb9e/a01eL8+PQ3pNVAW/C71whW8pe
         +pa+dM/q4cQh6ME2Dz6i0if19SOuhu/+h9zLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939701; x=1781544501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7U4zc/LNIPR/5rhjvkAHPlVmeHUKWR3UtKoj1Vq7Wo=;
        b=C1/EUavgoZo7+CM0IbtVSS4T9oz1Gx2x/8yhqNS02CsJoAB56BZEL0mtqPSmtD/mmb
         QL0Ib4XN8Id6HET3ZQY2KDFm3j7amgFpB/JSlUOpoQK31wviobUNaUQRajjKpbRnzZNH
         fIotA99JPJe1te7YbfftjoqvJFHccN3DAmiVzS0NWKsSDtrJ+UtV01iGd+2PLxWOvlpL
         atm/lJcEvmWEo55M2pnwJmb2bfWu+JbCLo5DwWk9Xj5erV/4ljZ6VfcdVxrb2q4UAtLm
         8496Zh4Mh1S16pSQxp7auh8rXryUTm9WzWkPK/UELqDyVeBxqU7TrYkdQBC637B4vhk1
         fW8A==
X-Forwarded-Encrypted: i=1; AFNElJ/yX1Ubeto5f/3s8HV9AWMepWnhGm9we7PsudTcNSRw1/uAFefOMoW2F6pxM0/WnD0SXjwCTog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Dmg+6kUCiYB7HYTiqja++++ywHTlCoMhWQmcH1wfRLJOGirR
	Yd/Owz2gvGYMbF+3zoDLHKqnAJCnKh9RsTOnPuXeObK3TtBwwAMmTYKUUaL9HeY5y8TS0tCBBwQ
	JY4+NGqszGuXYVsvjiRoWzovlg8GZkuF71oADB5GpVg==
X-Gm-Gg: Acq92OGtx28kG1FgjRVxmwehgLJPZR7elWLz9vO/UCVI84BHY6rkV05EgPWdn6g5jc6
	oSAvguP/Xbraa3A7/AEzAHBwRh5WsbZAxIldxskh173gyy1u0K+6lpcoXdc9H7bACPvRx8YTtk1
	5TOFAoXyMLjKROn3ZMoNUk2SdF2hpx825+w2imMNa2eTnb5AENk921NwHl53j+45QAAqor3a8Wl
	rR5AFl4/pU2xTDAMJSioSajuezOnHulhPIxo9OnAvZ98bAb+bTlIIo3TNDePiqqU8gmx4a2MGAZ
	orOEVMcu8xv1hvTEqije+ZfaHpfE6cQ17smpybArB3l3+v4=
X-Received: by 2002:a05:622a:4807:b0:517:9399:fa83 with SMTP id
 d75a77b69052e-5179888bf12mr166237831cf.27.1780939701082; Mon, 08 Jun 2026
 10:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605192708.141921-1-joannelkoong@gmail.com> <20260605192708.141921-2-joannelkoong@gmail.com>
In-Reply-To: <20260605192708.141921-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 8 Jun 2026 19:28:09 +0200
X-Gm-Features: AVVi8Ceqjpew3fq2St36JCFFgclYbphPBawkkcd3WN0vlnMKQ0jF2eUj0qJh4vY
Message-ID: <CAJfpeguuR+K1r0SVNScjkSnjt3SF+E7V8PbSB3TgEVEhK-bLNA@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: fix EFAULT clobber in fuse_uring_commit
To: Joanne Koong <joannelkoong@gmail.com>
Cc: bernd@bsbernd.com, fuse-devel@lists.linux.dev, Chris Mason <clm@meta.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 21:27, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> From: Chris Mason <clm@meta.com>
>
> copy_from_user() returns the number of bytes not copied as an unsigned
> residual on failure (1..sizeof(struct fuse_out_header)). fuse_uring_commit
> stores that residual in ssize_t err, sets req->out.h.error to -EFAULT,
> then jumps to out: with err still holding the positive residual.
>
>     err = copy_from_user(&req->out.h, &ent->headers->in_out,
>                          sizeof(req->out.h));
>     if (err) {
>         req->out.h.error = -EFAULT;
>         goto out;          /* err is the positive residual */
>     }
>     ...
>     out:
>         fuse_uring_req_end(ent, req, err);
>
> fuse_uring_req_end() then runs
>
>     if (error)
>         req->out.h.error = error;
>
> which overwrites the just-assigned -EFAULT with the positive residual.
> FUSE callers such as fuse_simple_request() test err < 0 to detect
> failure, so the positive value is interpreted as success and the
> caller proceeds with an uninitialised or partial req->out.args.
>
> Fix by assigning err = -EFAULT in the failure branch before jumping
> to out, so fuse_uring_req_end() receives a negative errno and sets
> req->out.h.error to -EFAULT.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Assisted-by: kres (claude-opus-4-7)
> Signed-off-by: Chris Mason <clm@meta.com>

Applied, thanks.

Miklos
