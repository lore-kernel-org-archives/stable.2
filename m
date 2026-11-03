Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793664408;
	b=ucMR96AeCzvMkyJOljPjiH0Dzc8ZQfFKlW7cixxf+jWS8B40KacRnsj/A3QxF+eInj6d
	 gB62hGxmeZpCqdH/GdLNLnjBeraXSBilDykQ/2mFcPlwTcEzTxyqjOCd5jAR3JQaDcOIK
	 2BetBchnKHLoUNAXmaVBIllKUW/YjKfA24pOiHgg8AeFysIEI7FY0iM64uXbLzXYjBcnH
	 6Gwihq9LX55gTV7iuNToO6QM+2/LN//XlRnb0UTMxwvkjEvNYVr4YGcsFGyEpBXROw0tq
	 0ENHx3M7FYms3QrDdAIgp/w7I71XG6KIMssL2fNT3zUybmcVijvm0meUm6NzF+AP0yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SVB21/AnViTS4HODdzSPipK9V+HrHwv1zpOfO/G5LWc=;
	b=hzeZiTqB3Xz2T0qeVPGPrjDcQIupf83CmkJp7n0Jo11/wmg9HDtPDz/jj8WL6JqDM8Uq
	 2QozEV9Jibfq7YhRKLWYpisdTk2e5LsthnmMsS7BCB/VA5ZUKlVSRsQf0ZM8H9eJP65om
	 /rI1lu/vZxkcCUzJvTY0tXYrfWiDk4PKVdOEN95FSj4DvXDBEjQd3iX4aQFw4zqN7eEw/
	 QtRSrDvRz+wNrjIRffSsle5SueMYUBqpC4ge3DXsZDF1lM8oxkmqxsfheskVLMvhWR8Wz
	 d2jBf9zw/O9nHEBy81yFNvALmzx1lxXc7ud8lfsE3xUI3eyKpCNYIlcmw6qLxxhDrQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=A9AYJOa3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66F3606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 00:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66F3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=A9AYJOa3
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-5641f26ce05so1585559b6e.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 16:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793664407; cv=none;
        d=google.com; s=arc-20260327;
        b=roYYyVzu/PQQRQ8TPZToEKSCx1BE5lbUcLcSZdQjWULvd8QEdzm1/UH8pOCUTrNfYX
         fAKqeVoxDHObvy5nIZ7YrWsG0hHauL4WhSytJbzyV6Bzf84WzFOpGc/UblDmeNPdo4m+
         Uph7B74g2p6nY6E1L7lgM6AP1enpGkVwZobBjS3pyZYJ1cwws5XnQ/Z+kRou0RuawtxR
         p12IExT0niwdZ9DJNTbOrcHtmfBufGMAt2IGRIXpRqG9737CfzLBgOgXiU/QTcoGNqU7
         g3ibq34iunwQcXa8K/4N1taQDXrmmmrvIQyzUkxD1lvuVf9SDmc48awgh8g12Kpi4ZGf
         rixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVB21/AnViTS4HODdzSPipK9V+HrHwv1zpOfO/G5LWc=;
        fh=fS8n4FekyIaf6YRLO6BL5YdiDIL7Y/Xxzaq8cptkFh4=;
        b=JPt2YKCq4jY2rmgN1zdQYk86jbPwPR/4Ux5J6cAwiYi3MSvle2aXaH/W23905hBke9
         7H3F0qbtCFnqYbutLuxD32ixon3f4hlDC+S/wihMk2/TMMGK9xtcqFT31NrD4QGvZU+3
         Y0U3LOM0mcC5yJVncEwYNTGnjuQ2MkfCRoFb9iuNDyyGdU+JRiqUKuNY74pK8CGAp8lL
         qeuz9dlb8azAc0WEsdQXEeHAZAGU0vXp1IRBCqoY+pWoTbNiYtco9kuSk+ujGguVKKgt
         FxhsjEu+79O0GOUhha6JyHD6FrqId1+DFYthVLMCecKgBm3g3TmWbFbPrM7p1xT/6Ej7
         eGLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1793664407; x=1794269207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SVB21/AnViTS4HODdzSPipK9V+HrHwv1zpOfO/G5LWc=;
        b=A9AYJOa3OGIZGbLtbJdt52wFiu+w2TsukdRAIXTFBdhL+8WjOqhl2uEHZBnfOiyDjr
         NrG8Bx7Jc4C9u+1UmWYEcGOgSIBex2U2q59kfZqimvxo4HbZxJUgmbzrzHH5TMiwGhpN
         YqoGY2hrNEPDVddMK3JBTOt48ALpVPKJx8C/sDBy5CYQgZLE3pPguGKf+8eQ/LJgOUm0
         IdHBDVhD4Kiz6KkkYUaXQ43m/vTS5zJl2RV9CdJ7cHhfsacNXt1ylAZJRGlOyBqas3JW
         m+RLKdlC4RfSJC5QCOcRc3PqtCFbvSzdL/9EQrvXTqYAtMgF8cxhz0VWygfoJEuqTBJt
         Gv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664407; x=1794269207;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVB21/AnViTS4HODdzSPipK9V+HrHwv1zpOfO/G5LWc=;
        b=qn0emqlQbe/xfAOGNZy8OglAeeuGi+2D0mN5TXYXQ5KLDL9tUfQj4uBKf7RaEecvmk
         qiFw/fE2a0VoZcCQN0WgMwDhcqJyIFWAeGYHO9uCMLS11GSpfwBrUhQ1NCWex9n/39Me
         yyYXaMcorBNXp42dq8vdFxbauThD+q+1urv/wgFTduvb1mvAesneT23Nzye7Lt8mj+uk
         J+W15PEEvXynw8/NdJYkXyBI3HAoR1B36x+BWisEK8eaBvtQBqKLX4IZHpoFp/dLGk3l
         TrtHkQnUuEYrwNVihe97ou0VMloB2fMqTrza0maMzCrJO/8BMv06XBS/7AFYiPmu3d82
         /pyA==
X-Forwarded-Encrypted: i=1; AKwUvBykrRnulCoc9m9XKSqygSf9AyTp/hRUxRa+K68iBq7M9AcH3Y5ebXGVZZr25+Awe5i0ESVNA6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1iYkPG6UYHyfEvC8OkCvFzo5XyVodlM+TOe1Fna+WvIpfD13S
	BnDMcYIJuac3Jx5QjzTdGbwOZH4HGKPekTqUhBwtzWl4OAv9U6K7pqr+hC789izXyQeGvjJBAVr
	98CwrSldmH3URHqMnRfzhH61GEQGfz/yZTppI6ZPyGWhqhLOwI+BmSO5s
X-Gm-Gg: AYBFou1NtROC41hrWLePNDJO6Culn+nw/uMt0gheFLe1tpMHQXmKbwVbZbGiwjNdEqs
	RL8prVIjCBIYhXbWBH8n9f5bnvjQCPKevN+DTlxMq0DX3gPh87KWn9V1aK/NkM4TAZSKwYqIWbZ
	A3H6Ov//04UMILasF1xAlS+N0rN+zX99SxKR4XaULBnGon1gOdM+VUJ2Ds8sFdp5ouHbppjjF0y
	syM1I66VQYFmwhiItDJfn6hD1LMt9+iXZSbdJfqBHt8EdlUBXO34sAKSxWcMBfU73sS1c4cV+Tc
	vajdXoOmnZ1pydiJJ8p6f0ZzR4vbQYRb1JVtf7PDScXPERwjFD1JLCRldky2j2xD3Hwvo8lluvO
	ycGZ9rWRb3LLS93ZbJY/PNZ7MsozJ1FZFSuJT4Q==
X-Received: by 2002:a05:6808:2218:b0:53c:2a2e:8650 with SMTP id
 5614622812f47-5640df72f37mr7638020b6e.34.1793664406884; Mon, 02 Nov 2026
 16:06:46 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102233041.310900-1-smish149@asu.edu> <a12db355-d677-4656-9715-a537980e928a@suse.com>
In-Reply-To: <a12db355-d677-4656-9715-a537980e928a@suse.com>
From: Siddharth Mishra <smish149@asu.edu>
Date: Mon, 2 Nov 2026 17:06:36 -0700
X-Gm-Features: AclHuK8WPFKvIkjfRdxOUVR8P4RPk3-TpPeZ4GJPv7cbB6VWYA4Uv9k68vyPW_I
Message-ID: <CAKpDGtncRzRwkv6yfxNvMHOMSk_Ejg_HJHEs3k9TVNb_6mArvQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not check support for an invalid sectorsize
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Siddharth Mishra <brightprogrammer@asu.edu>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 4:42=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 8e8fb942d..b348591f8 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2520,9 +2520,7 @@ int btrfs_validate_super(const struct btrfs_fs_in=
fo *fs_info,
> >                    sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE)) {
> >               btrfs_err(fs_info, "invalid sectorsize %u", sectorsize);
> >               ret =3D -EINVAL;
> > -     }
> > -
> > -     if (unlikely(!btrfs_supported_blocksize(sectorsize))) {
> > +     } else if (unlikely(!btrfs_supported_blocksize(sectorsize))) {
>
> If you want to change this, you should touch all callsites.
> Not only this one, but every unlikely() branch to return immediately.
>
> I do not like the ad-hoc fix just be cause you can trigger an ASSERT().

Thanks for the response. I'm assuming you mean I change the whole function
to return -EINVAL on the first failure it encounters and not just the secto=
rsize
because it reached an ASSERT. Given that, I'll send a v2 right away where
any failed check in btrfs_validate_super() returns early rather than
continuing ahead.

Siddharth Mishra
