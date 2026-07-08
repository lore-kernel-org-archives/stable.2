Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6D2F7F12
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554376; cv=pass; b=nTKUbp+ePhjqF3TQIDcd5Amdwt4knTCJZDx1sWT85zTlpOyi7ac61KY32P3P3rNC6VNAc/uq50i0GetFce8DS8puY8g8L/VaZv7m/MknKT3NNwsnp7gxUZsdkkufvLcpgczBsy+aTnsePGOC1mtBWkj25Uo14dqIr26QwmqtJU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554376; c=relaxed/simple;
	bh=bogTf9sKA309KZfQOo05YPNzqJJEanTlOfbP/mni1YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCwwqaBX1D11UxJqn3q/FFVoec9linkatWN5m/DAMXVFPW1DPBEwBV16Ne0mm7AaFBaKwbOawRk0VQoHi59Rgck/tdD6AkYmC6TDZ3O70oiL6b5+Z14NvCU7qt0W1o6jD27HjclW+MBXXb2gyMenbHcozliBxDmjK74inEGK06A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv8MrqW2; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv8MrqW2"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c7fd21b63so7586591fa.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 16:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783554374; cv=none;
        d=google.com; s=arc-20260327;
        b=QkWlvsFxFC7/PNeb0SDBiHK+0g2iWkrlDMOrL9Jwtzh4FDkZN/ZWfGPgRQn0j6WdjF
         jCnQiaSfjdeClFyJAwAyTlb9A8HiqWzJc8p5hbcxqqOhE75QMbAt4IioP+LdEaqJKhbh
         h31CC96gdKf3vqMcf3v5rg8rVXWeQj1cyAK96duYSccuxLlBmvBpxFSbnVDur8G+aPBW
         igzg5BwfdkpXewmGj8BHsuGLzWECtYpP2cvHDWxBxOZShDSKMGCSkaHBwQMVu6TqdcD1
         zN/yQvlysHfc6x14QvCtXfBNaxI/vYD3pXXdat/CjahKBdnAnGh/mOP5RpQ/FNfHJiNy
         xVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CcUMwXmEbA6CGGG/L3J6rC9uyengfo9qTR4Iv0cdbrw=;
        fh=kEXomeS739uDg9WN7TMNaUFmX2hIE8AMjb4ECnlXB3Q=;
        b=F7MvvhOxh++fyFRq58govMqxvgGVaaTZzp9DJVd9KkJf7N8M9tp+ZdQwn8hPnhkaHv
         0270Si76oop5c74QOuyu4U+TmnRsBYFz5AdpQYVloG/6OV+2mMcGMtm2uTcB7EsiHNWp
         8DdYPtdkukOeXT/s6M3Mx7vPt0rSzGWjaCdeQ3I+0D/kyfZ/9b583A8awtSJa0L7C1wA
         soHaxlsrQ1o/lRWO/eg3YAA5BBVn/2BQTqEYeIdazOyqMyWDyMI2SUVUrnaf8cl6qLNe
         CY1iMzfOwPobkMZTOFn8AUZb6lh9B5ivX4XaRjRyjaxW2OIIDkeTI62hWm1I8Xdr8BkP
         RYZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783554374; x=1784159174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CcUMwXmEbA6CGGG/L3J6rC9uyengfo9qTR4Iv0cdbrw=;
        b=Dv8MrqW25nSn6qvw+z+c0ryeqwkovHWxSFqqFmEeJqlEZ2Vh/kE1s641LyvLb+jflR
         GsNJ6pH/rxm+Fhmd+dPM20MzfRphWFK7AjeMemiaZ/kBIrNgwc5k2m4HOXBHC17Pik66
         dahc21h2hgg/BmSyU5YZt1oP4t5k/+V/5wAnREdNiByGF81X73oQ+FheuifaU3jB9foi
         KwGw1ztMcd4WLB2l/5KYRLlDx20GLLJSTs8MgHoJpoK1t8xYBkbtH9J4wUFExjDXKzwX
         BjOcrH3r6N3U3id3YRV0M2PAuXBIPhm2pSyMEUKx+GZ1J7BQUsRcfO0qYn+O9pC6xO4o
         FjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554374; x=1784159174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcUMwXmEbA6CGGG/L3J6rC9uyengfo9qTR4Iv0cdbrw=;
        b=n+Ub9kMY2cAY3UL9wH37i+ZoMw//T7Ea8+Wm+abgDVVvCI3xxpI8qECk6Fye9o3+s3
         qG/2pPipNuRzu0wa1bijsdPeCncbGM1XIPa/dPMdUM1O2FJ0PF9+htDWIO5T5w3zrcjs
         3GUC4FIrlrCjsC/cduAJjYqVyDddfh/6yl8XECVq5XWXy65z0XfOr0GZFUhGlfg1AjFC
         K0/hmbVgrxGDSd8goe5EDMyNaT4KM5dXfss41Y8fhzXsRdcRDAmYHdJgJRKkzGTaFpDd
         l5HZ+uxiLp2HzZoRNzfgeUAka+9isHTQpIJgzhYKJO6PP/fUKLzJljI7Iins3bpc83hD
         /BjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3b+OXl1EPYu63Z5mI3uHO3S2U3kipLpIR9l52pB7Bucw7H3/keNU7aDYiqwLe3TbbQDGtzNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfA3GGoDojB/4bgWz6yeRK/T2rhLhPsvwio/DxhmBZphhJxhu6
	uqJHFLvWGc9+R3WYRwqDG1Nb8MAYO/tTitPQ1Q7GtiugMtV6Bg8kYITGplTFO+EKnF2xcbbzIor
	lmVEmOlCE5J/Tf2F7ZJgk2yMWcix5Wx8=
X-Gm-Gg: AfdE7ck0ter1039tFK68al4H0s0S4qna+KLo6/UcXOVQaZTuVb3AxsgMe+CniXEfdTx
	aJxrhyf8HAmXSM+MCUd2uUDqiNJAEF6XFaWZjZ5I3PLL3WlDnayUQa34SFepdgG+Ng4Rl2dsg+X
	5WEgsGRikumaR6N6mlq7FSR+dtFfF0jI1BJI06rEbWGwjUCdX0pK6JijH9xt2BUCkbA+O6+gX63
	epstFyFmHdP8KKE2ZGDmcxXws+ZQ0jHFV3ecGm4UCzwchcKecjBI7NA5tUgYVxpQqUTUK+xMRS3
	UZXwqGMyAt4CJv63MSw4kmCo1ZKYn1wr3sf4jj3bLGrpR70lcI69mc9B6E6ltIdcLKx5LouQruw
	7KDtF6JS0YRgejkMFsfRIpsaEUIQ6M+FPLXq7LxNESWK/LKcK7Zi9VzOrrzYu1CleFFZc6lrasX
	z5KFEPOogStFc=
X-Received: by 2002:a05:6512:641c:b0:5b0:eda:de2b with SMTP id
 2adb3069b0e04-5b0114906e4mr980344e87.50.1783554373413; Wed, 08 Jul 2026
 16:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <527C2DB5ABAE200F+20260707133017.1740557-1-raoxu@uniontech.com>
In-Reply-To: <527C2DB5ABAE200F+20260707133017.1740557-1-raoxu@uniontech.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 8 Jul 2026 18:45:37 -0500
X-Gm-Features: AVVi8CdYvG_0J3hTjQC5XD4i5qJ62VPNYGj58VfdHkF8ve7UCf11kH2BklMa7W8
Message-ID: <CAH2r5mvfhcz3iDmRmgyQHpPeVtdfHdX_Ah1KT_+TQtLECqgaHw@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix atime clamp check in read completion
To: raoxu <raoxu@uniontech.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Tue, Jul 7, 2026 at 8:43=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> cifs_rreq_done() updates the inode atime to current_time(inode) after a
> netfs read.  It then preserves the CIFS rule that atime should not be
> older than mtime, because some applications break if atime is less than
> mtime.  That rule only requires clamping when atime < mtime.
>
> The current check uses the raw non-zero result of timespec64_compare().
> It therefore takes the clamp path for both atime < mtime and
> atime > mtime.  The latter is the normal case when reading an older file:
> the newly recorded atime is newer than the file mtime.  The completion
> handler then immediately moves atime back to mtime, losing the access
> time that was just recorded.  Userspace tools that rely on atime, such as
> stat, find -atime, backup tools or cold-data classifiers, can therefore
> see a recently read CIFS file as not recently accessed.
>
> This is easy to miss because the bug is silent: read I/O still succeeds,
> no error is reported, and many systems either do not check atime after
> reads or mount with policies such as relatime/noatime.  It becomes
> visible when a CIFS file has an mtime older than the current time, the
> file is read, and the local inode atime is inspected before a later
> revalidation replaces the cached timestamps.
>
> Clamp only when atime is actually older than mtime.  This matches the
> same atime/mtime rule used when applying CIFS inode attributes.
>
> Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  fs/smb/client/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 58430ba51b10..62605928d2b8 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -301,7 +301,7 @@ static void cifs_rreq_done(struct netfs_io_request *r=
req)
>         /* we do not want atime to be less than mtime, it broke some apps=
 */
>         atime =3D inode_set_atime_to_ts(inode, current_time(inode));
>         mtime =3D inode_get_mtime(inode);
> -       if (timespec64_compare(&atime, &mtime))
> +       if (timespec64_compare(&atime, &mtime) < 0)
>                 inode_set_atime_to_ts(inode, inode_get_mtime(inode));
>  }
>
> --
> 2.50.1
>
>


--=20
Thanks,

Steve
