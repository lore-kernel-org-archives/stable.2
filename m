Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7AC1DA0E1
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767735; cv=pass; b=U1Nr7xo6LV682r2qvw49kcjNyL+y9lyvNrnr4+iXXXYY6+Ap+HgQgXpV6oKv2xUGlpPMc4pAUVqJvr9kMPvqkVa6ldVQbAdWqjZRHNCUZ4k87pTcGsohSW1iOjYxZm6vfSqpQHtg9e41VIuX4icXSXblqABABNj5O3LwvKQExig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767735; c=relaxed/simple;
	bh=JNAlPXsRf7mdq+EU7xuMk2do63PtbP95K0eesxKPvKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0OaTiZOqCgkXd33zwDU+DoB57BB9C50G2f4kjqR4Etxgm4lysqFFsHQOUGprWnHQ4Kj2TXRdMaEi1Av5HyaZDHkOVgkFksQqZ3AV0u0K9RoIbeS6yLR6i3Nk/8eiGRewrjXDQEKmc1yVYxZW0sCqB2uoQZW+yENbUloSV088Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO5ec2So; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO5ec2So"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66899fe9077so55226d50.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784767733; cv=none;
        d=google.com; s=arc-20260327;
        b=o/YF68wbHBKxk6stmM4zM2rxhcmzHLZ8SwHNjDayQR82Tnnszdo5oVsQck8DwIYVnn
         OGacI2mlUk3ouvCJpHMSyhnC2uMuRGLLsN/hQQNGjC/BC2/9G89KW1VniA238USkyOkh
         y4inIUyqMCc4WWDaqK4QvCCEIyZ1jw8Gp8KSl7XKsHHPYDrr/pWimOJj0Zmo8jUuUsny
         xk+RQydoV+Tqdl0oqUJ0F9/Ywt8cbMuVqo2I9bTKdl2pzF4+kpjm9QVsf3UzklLCmaEh
         iFcdl4YJ65H3nD7QjDItDMgvdUBoxLTbXSbvnb9OEsX8jzaI9nXAzIRYrmSBzQsboACt
         ZPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5kZ5GNTnR6Lx+ffPKMBU2K3iYxVxA0i1MwVrODI6F/A=;
        fh=F0Xu+Hyd89bR+iU03K5SIwqSXAi0ZljV2wVFySQ//io=;
        b=X1LiNhoin/JzkkoIsXDyvGuCcmPp2gGVWTPIl84ulwjf/XssThg7wDffprh0oINLo6
         pKOT86i60F6CBwUdDQgthSx4ZMHBz5sZM2CDWNiHc15I+bLd4iI8O6d5umOVT85tTrDD
         VvEuGsu2gZhFyggI1TD40ca+E8ZkCBEfq6VqP34PeVqdEf+SrkgM2uFGbL1LA+cMPX5n
         wmckf3mXY+EaNcWq/e0s97rGtAYE3D9Kg59tx0YDK+QgLJHXouB39k1EiK7zdsh4sWjG
         pgtOQWyEl1XSfmkK6yvu3IdTJ1Dq5JeGutIKW5Y/yC0yRgMaXkvxie9SpUKsJXgoZe5O
         gySg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784767733; x=1785372533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5kZ5GNTnR6Lx+ffPKMBU2K3iYxVxA0i1MwVrODI6F/A=;
        b=WO5ec2SoFb75puHfK+ZEXI7QPngd72fmjAaTN1J+sORP54UZaAu9+9FP8VjVdsOoXO
         3JJv4R3qAmVqrcs93/r505UTZw5WrKT66my8XJ39qaxmd9yz84sjrZjLQSrw5gWqabS5
         d0P/83Rz2+y7ESSSPkgWKJuNXl6tH0rpyNNwPX7qdcIF+ieLXISoNlCRRfhOWJ1/U2/c
         jFgfRIjICIFOPnrL7CusZFBAHVIyroLAODwpmbDTJHelt3TFB4luPpYDTITnDsEjl9+4
         dd7gMhMoB+5ARdw4mqrpPvutDdt8iX8TSxPOEs4R4K+mI3k69dRLP/DReg16hPuz8I9Y
         hFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784767733; x=1785372533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5kZ5GNTnR6Lx+ffPKMBU2K3iYxVxA0i1MwVrODI6F/A=;
        b=n2p6hfHjXKI8m/dRJFjrKrE+zl8/taoTJ0HpL8VXKVxRLaVvXW3bXsdJ2aP8MxXUvm
         zBmoRiakZ8UFCeF8NgzL7yS/JC+W6RLByzemwvzYaEAdxCp7fuMr1aMBcl0t8jQ9QMkC
         zAqWWdLPFZxuvc9lqkxlwb1OuQQN2ulgP/coj312t1U+YRnB0CS3gbaDTWAS98PLu+An
         KqkTJc+/+fMRMsCY532hLWsUnNz7Ehegy0a/oa5gRToUSeOt6YKqmhKzRF5H12WZ2HVD
         esrQv1zl6IQxLmkp2Cil/fkq6h0u54NFvOzTS9GtlV0BawI8dEdIan4M3sdyoU/4uss1
         D0GA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8VNB8x5GQWewnxpFVz8jDTaSKzCswIf0E75iQJfYyzzIWTXPkMrI5qguRgQFJQ2DRXBzqPpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALO+25F5YB77JVd0akwtNXH32Q2INfpxFL8Bv10/Dl5F3rajO
	YajF4FWBa7Bawn1tmh24LMD38mnlYujI1d10bqHHin5LS1tj48/dEuZDF6OVEYOEZcLnXePavPk
	SxEtoIjSm3Zj/33x+bHyyybfC4OLxk7E=
X-Gm-Gg: AR+sD12zZeFsvgxaCE09Xz1UzHUMHU5EOSUiKo9BvYQ+JQ6Qylorw5yz6ebuJcMBLwx
	93W68ilNVEsAGOUarkjOsaWXk70v3pmhJHZ2eAU2QkYq57cDRoE3n4UX3FgaMzB3PMKRbApNKyo
	SWRuu+onwXu21mamk1zFr1MUkMohcolTNcQwOi7r2geCY+uJjUwMRIklPjEbBtKvl2c7kH9STF3
	Cg7C1QP6CYbj2JoL0sLK8aUz/nW3EvEfCdd3q8/WBNTwBSk6v6EAbftMXx2nC4DaprCh1HDwK3X
	UzAoDOD1+6wrGN721D9rNJTnWQffPd56n70GjGE1mieLdOw1mgJpiDw=
X-Received: by 2002:a53:bb08:0:b0:667:b84f:e408 with SMTP id
 956f58d0204a3-668a4bb065fmr197983d50.5.1784767732776; Wed, 22 Jul 2026
 17:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615070530.371640-1-james010kim@gmail.com> <20260722172135.4fb1e64ce415fb6b8d1d1b59@linux-foundation.org>
In-Reply-To: <20260722172135.4fb1e64ce415fb6b8d1d1b59@linux-foundation.org>
From: James Kim <james010kim@gmail.com>
Date: Thu, 23 Jul 2026 09:48:41 +0900
X-Gm-Features: AUfX_mwSwnWaqYIQuf3CVQiJ_R67XREQhDQ6fhsC9qxL1QG939LgAqufwqQgAUU
Message-ID: <CAPdMtfdA5OkA06KjsBmAGkfqo=N1vmNF+VtbczNdM9Gk5kaV+A@mail.gmail.com>
Subject: Re: [PATCH v2] rapidio: mport_cdev: fix use-after-free in dma_req_free()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org, 
	alex.bou9@gmail.com, dan.carpenter@linaro.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for the review.

Yes, this path is reachable from userspace through the RapidIO mport
character-device interface. When the final mapping reference is dropped
while releasing a DMA request, the subsequent mutex_unlock() may
dereference freed memory, leading to a kernel crash or a KASAN report.

I'll send a v3 which:
 - updates the Fixes tag to the correct commit,
 - clears req->map while holding md->buf_mutex as suggested, and
 - clarifies the userspace reachability in the commit message.

I'll also review the additional Sashiko findings separately rather than
mixing them into this fix.

Thanks,
James

On Thu, Jul 23, 2026 at 9:21=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 15 Jun 2026 16:05:30 +0900 James Kim <james010kim@gmail.com> wrot=
e:
>
> > Fixes: 4b0986a36 ("rapidio: add mport character device support")
>
> I cannot find this commit.  I'll use
>
>         e8de370188d0 ("rapidio: add mport char device driver")
