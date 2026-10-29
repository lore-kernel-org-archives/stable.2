Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793304532;
	b=RPRF+znNSmhorxE3MreJ/k4Eq3sDcJSC1yD4Qt+M3UWBF2IQOWv3jw1USVMxf7fqu52s
	 s4Njaps4ol+O6nKCcvB+wapLJp3n3uE5jglBUsrTmrHBJnFXeJTgJT8bUdemCFXDbarxc
	 /QkUknEZmMCTH2j8eHThaZ22oIeiCgTH9id5nakmVjwSR1+dyvmM49Kp490bp27TngyJB
	 rEooiVbGn/kSiQhtiWfSVk/2y4nVCsHUPiiySTECrxkg4aPw8MtMGq5ALTjWF9OhSz3zC
	 iIp5Mac0ycOgWLhMArsw+mF3VeO4LKHugCPn2vUBoE7sIsonYxtPFogjciI50HENWGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a7zkNlVrzlPSpxoUpXt3vRmcwmTKMbpAgzHY1qs7+DM=;
	b=zl3Q0Mzr8Kq7g84cC2kJ3XktUTuJ5nhlkw042OtVjTeOE4tjMOOhEGweWxvMmVrZ3DcT
	 aKsjVPt3KTfNuI8NUZ7XvxBN/PY+dIkW+Gdr5XjONyj7aLAOx4evY4hqUI5gYHmvPZOQM
	 7fq5sBEaySGKC535ZUT3lp5BhJNcELRbdMfHRt2ThAW8B4HTJG1k/ryCJKlodB1nmBeIo
	 ePKOjyc1w5O8nZ9CEm28RJ2K1XJJYWjpPdUqpirNtAjqq+N3+q0TFnLZ2RB4jng/c2t0Z
	 X0dKWms2gLcwFkQEO9hNFVzsP+X5eJPXodHzkbyv1YkOUvy0H+GkQ+03VAfroTIXkyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cF5c8VtD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9A606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A9A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cF5c8VtD
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48bbb06e746so6216f8f.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793304530; cv=none;
        d=google.com; s=arc-20260327;
        b=BZgq3QwVKvXuuG3BT+NUExN+3OZzIOwnIatj2Fmp4jJPzvEL7+4jhU/tsrIot2p5QI
         1YDS97Zkz+fx9VhQpP4Bu1IBvYaLydlluSNxdVEP5aKp9pfaK5YhGeOcLPxiR0XP/UMa
         CrVAI9N21OJ8fojxRvC4nq36yJOLgYF2Cpmku2PiCLPKr84FkaeahL8FLqxu61vZy///
         C1zEkuX4ZTWm5whJTd7PCGB3+/fgA1GZWBHmBCteKwi0cfpMSgAyGvtZigLFvFwu0zID
         hAYlZu7a0cthtdb7SucpMca2GmJ1r5Ftmz9aZJEjhgwmcqtJJiK9f6niaNAsz7JODkGV
         QGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7zkNlVrzlPSpxoUpXt3vRmcwmTKMbpAgzHY1qs7+DM=;
        fh=K+C2XCGKtBtBfRlN1s30NIeABvPE/T2AoHYiW9MBBBY=;
        b=b/yBq7Vqq56/Uw2H3/ttEAVnEGVKgtBomriGceswtu8mmhuF2A8AFxfADkqOa62vHB
         VoJ56m40MYc4NnBtA5Pb3TnduzKhE22lwMCBlxGWLjN6xumUZkxrvp3WFyexLTQFT9Xn
         9wvd3eM4obU7X7rFKUFpH3d/48/0CKCVJnbc0mTzfAaK/ucM+tVdqGHWo8nOV7PxNlSR
         PtRrWgY8R2/tHIXl0FwZ0Rcw976L53M0C4PggoBrgsO2Mb73kNy4ggqA/8+n8Lsc2ns5
         L5DKpfUUhIzXS6acjJNQmO5utNCA+LBiQwc2VBx6FExjii1yGChMEiF6jXonBA3+XdLM
         DCcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793304530; x=1793909330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a7zkNlVrzlPSpxoUpXt3vRmcwmTKMbpAgzHY1qs7+DM=;
        b=cF5c8VtDD9mtXXMfx73tPPZP6ZGyc7Iyom5qIfSSirBoVjl+k1aJU9TlqtCNPsvv6t
         YUj/b2XjUvWOJEgA+rmpLJCfK19zhHTB1E2NO6z0KZh+kricy7kJQ9VZbjQpkW4sHs2H
         GNH8iRpemMGf5zAL7uGgGkMT+qaLFijGwdUVsaYuCiPasfiKk96yNECS37KfKjR41wvN
         zZRT7TKNKbHpIe1WqHXSoQbXF9sNULGInMaoyeU9alUXbydvm6CBahzyFHaCUh+Rfvjl
         KIIq9oRgvQUrNMFu9mgicexxTpmFPnBWaby0bq75EL6n9D5+kcYsM2Ye5O9qfRLcDhDk
         D9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793304530; x=1793909330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7zkNlVrzlPSpxoUpXt3vRmcwmTKMbpAgzHY1qs7+DM=;
        b=bKVXhoZJhnKeHLggGZElKeWWALfAazfvpH/CMsQg9QzIvB2qLNOX+iYt+Fvwc2pXjB
         ef23NzotEfpVL9rMx6+kOtb6BAS9BG9/+6pDn8d0OffvmjKSKfxr44NgMSfM8UGlNjqs
         z0EYh2nlK5ZRO9l5gOyaX1K+ZtHf3PsE15AZdVc8EElmgXzc2G75TY7YMa0DlNDbiseK
         lyGwMCFHg9jl4+pzNQTNXfue/NeEoUiwhJgI++4zsijnTHqSf583hDB7YK2nwsCnC2Lw
         vSts2LzMKFbNSBLmomcI2gQxEvItqbj6IWKjv+jOq1o+aS/frpwOy6xjd0YF33SALWmV
         8jmg==
X-Forwarded-Encrypted: i=1; AKwUvBxiRA+nzQHeDzWs/MqQlIKGp6zjRamT+rTagFwQuZGj2MUzCNmwmxlU8dRplZt30qh6OXDkTVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJREwbtMZbRfFTTvdTawl2fzZN5rSHoy1w0ixVHlvdAtpfiEb04
	bCqxw27kZFFV6Cga3ycB/caf0Kmkg/UVd6jjoL+d6Ft/W0+y7+I7rw0c0WBepNC7x7zBslMF92P
	GI695tNv5WT2Ua1ioTjlcI5kvhSbWLX4=
X-Gm-Gg: AYBFou35uWk49BfSSfhwJqRqDfUv7TaZ8Z4iS3McLWZeBXj39+WpRtBQZ/4g2R4bDXv
	vUXhLyGLC0D6r7QPwm7UYwpXouxGVUPRBZy2ojOOnQ8QM3yzALEsx6kYJbiEjaABYcNKXnNoo0p
	hXmSsghvxSxkKckMmNJ3I91TikHTaNHrLF7lHBv4dgTf8LHN2dMRK+n7AehGBEoFMS0CMLbDAVx
	BoDY9ccz4K09qkH+UNWpQfxohqIp6y16T9Vt7tOjZBPuO8j/h4AU3t7Hw4bBeOZ/LtCgbnuiSSt
	N+Y0LXgAgZxjBBI0Ywk2zkG5r/BXJmCa7ouYPihT754uOeZz8TSkonS+FuZrWspidA4Ua05A6jK
	XMLuZjmRwJ6tvbvMh72kMNyk5elp3xeORXZmVbzmabE3S3Md85Ba3sX8P72zmuMamqeJyqhVc5j
	SbloigJFjKu5nIEkDC2A==
X-Received: by 2002:a05:6000:1ac5:b0:48b:116d:56fb with SMTP id
 ffacd0b85a97d-48e6e2bbfe0mr1122858f8f.1.1793304530377; Thu, 29 Oct 2026
 13:08:50 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-iomap-ai-fixes-v1-0-7eda63bc1b13@kernel.org> <20261029-work-iomap-ai-fixes-v1-1-7eda63bc1b13@kernel.org>
In-Reply-To: <20261029-work-iomap-ai-fixes-v1-1-7eda63bc1b13@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 29 Oct 2026 13:08:36 -0700
X-Gm-Features: AclHuK_mxORIH-qEHKr1ZEzSnp2s6A1zchn0cpynNg9TXiYPbvV1ECJaStfOffg
Message-ID: <CAJnrk1YiF=OEYQzwFpkzmBY_78+fNKgg5CafaWOa7KwGR+XN-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: don't mark unwritten parts of a folio uptodate
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@meta.com>, 
	Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, 
	Zhang Yi <yi.zhang@huaweicloud.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:35=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 907873073b03..d6e2f1ded5ca 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -920,6 +920,7 @@ static int __iomap_write_begin(const struct iomap_ite=
r *iter,
>                 if (iomap_block_needs_zeroing(iter, block_start)) {
>                         if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
>                                 return -EIO;
> +                       /* uptodate once copied, see __iomap_write_end() =
*/
>                         folio_zero_segments(folio, poff, from, to, poff +=
 plen);
>                 } else {
>                         const struct iomap *iomap =3D iomap_iter_srcmap(i=
ter);
> @@ -943,8 +944,8 @@ static int __iomap_write_begin(const struct iomap_ite=
r *iter,
>
>                         if (iomap->flags & IOMAP_F_ZERO_TAIL)
>                                 folio_zero_segment(folio, to, poff + plen=
);
> +                       iomap_set_range_uptodate(folio, poff, plen);
>                 }
> -               iomap_set_range_uptodate(folio, poff, plen);
>         } while ((block_start +=3D plen) < block_end);
>
>         return 0;
>

The fix looks good to me.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
