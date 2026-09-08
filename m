Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A91A680C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831315; cv=pass; b=kGks8IHEu/XA5keoSo96+AZBTaRibHtLWSh7tTblUTfHgEVWOsmPOh3VsYuCLTj385Wbt1993aHSpboQusPEHwSk6YwBJMH8KCacIZx9HV+YYLh7ogoHiv4qRkzaDdffVoEu0B3zYVi+tw7oBN0tanGHYHOJ6yKujyHtQ9VeKiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831315; c=relaxed/simple;
	bh=INc7vJnKmcPadUVe0TBusKMD0asFCz4Y2fnVdUat3cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUlcyCXAK3gViPhe1lgWWazchBINr/3NJoqaxkPipzcbD1EYkEWlgULQeQuWkDakK0pI4JQeAWHPmPgrUemcVz6a7MhUIKRG0VhjPO0FPXqaH5bM8WQgHw0xpdt1YQuR0FmwguMz3lFVCzQd1VwJ+dyFOJpsQf3HbfWSkgPQ7/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=fn2U3WK0; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="fn2U3WK0"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso663293566b.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 18:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788831310; cv=none;
        d=google.com; s=arc-20260327;
        b=d22yrOTgAXFtwOwBTPMBO7cgzaqenKcDyjR7J/Iwwuzz/VT5o8P7JUw/X1yHstC0EY
         85+/g/RmENHzKbrEz8XzHX2N1XI7q802QA2NmIZsXC4M5of+XtvMzy3USkeXHV2eVl+N
         95kkzNj1A82imdozzdh7neWUwP6f+3GFp+g/1UG3TrfR+FcphrcIj4ivMy2tIGgpkyS/
         XvoTWbF1h7xH8lO4mcoIasVZvMSwygWhqQwjNMhneGJwFrF1ioAr59EuCAvsyOlnth12
         DcRpxKUjazIHpCXk+6BnEZZP221nhpGr+QxbGpxYwhbN/zVUxylxT/7BkiAVD+wCLnP4
         xpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JKmnj8WAMV3B+i0SHW5NJwI4T8pRLiTOo5rUmCTrPvo=;
        fh=Rd6hAkocrA0eCWLnKESeP5YmHJPZdyUQ4MQ8B3UJZ+8=;
        b=I+3w8f40QqRpUvoozH41OW27t7hIbfWCTs8x3w6vFwhFfQKueJ1kvm/kSNDT5NzZx3
         ObFMcxHqSvG6bdN7dFI29r+AMSwlrgO2ekegVMrGYmE1VIptREu4o4/p7dqVyOP5mMxo
         UMQ/E0Hi10/5RTG9T/amlEt1AE16X4Rq1YKnzu5PgWeYg7qNr3+zCmEWBRnp1Bt3ZskA
         MJkqu4OxZjekGv3G0LlF130woC3u6ssFtOyjBtQtvUsT6RDlSEjNLi/tov+CJU/bk81E
         fkTSD3U2xOZbYGKOZ1AcoV0yE1nih7IOd3ezDv1iAkV2PFSIP8BA7HwGXmB3TT2EpHx/
         EEgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788831310; x=1789436110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKmnj8WAMV3B+i0SHW5NJwI4T8pRLiTOo5rUmCTrPvo=;
        b=fn2U3WK0LRPIWvBglrbhzM3uQGjBLbGzcSXeFddhdU5EixfXzSoB8ocYAkYLdTs8fg
         mfsP1n8s8IFKBE0P/5LPCl1MBrVoufZk13As7rtUcfKf7VqyGZx1VtH4y/vk7kGa2zUP
         EPkUYRMNu7Ih0cEBZna1Q1exOf9tcE9yTb1R7qFva7aAM5LyIkwGHezOYhbpYFE0aeqx
         G6J+W6EhMS0ZBGE4RIHQVKrEjEkGhEYFLerbsyyphg4P5i3IWtChN8owqffS3Xr7xPnr
         EasiIrmoPyT3n9ao58sL7gy8Qkc7zGB+Z6ace3gPQtgFALcbIs+1/m9SXAVUp8gHfm+1
         WZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788831310; x=1789436110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKmnj8WAMV3B+i0SHW5NJwI4T8pRLiTOo5rUmCTrPvo=;
        b=QH/zyeTsvEmQXmbfw/BXlOk2VwpR867MkDVjW28qOcXI7Mi9Jqc5Dy4SrbY7Zpmg+X
         WLg3s3+hXzYVIxAbUEXe0m32Q/mZPLeQD3/4Fcw6Ze4M7mH+OrIfp9boxO8c3HtH21vF
         X7Z+U/iYrtA6neDml6Wz/wZS8QYS1M8ObgYF9bcgjQ58SfTrt3iUVCk2vX8lMCAhWiaf
         0xgupvlMdSwYs0BApX9Qcu/ozCnT40Z+trdvEj2rC96zNUbh0QcNMfuth+jiXteoASkn
         2Zuz1ebEQhtYOB3NR5oQOz+J6sZQ5la4+Hfxm9srxJYno9TEYSsdaRozOv+VCLgt7WuG
         vnZA==
X-Forwarded-Encrypted: i=1; AKwUvBztpQOjoJNxyPrqvs01+afCivaZBszjOHe+Kq9oBKS0sWpQQuREUe1e0HwpD7heXHlocxI01Ec=@vger.kernel.org
X-Gm-Message-State: AFuF++myMJgZGP8ck906PpgyExvEdt2DmOtbVaNX3EmGxYJpyj00wnNi
	ZCfYZ3Bxc2iynzyKoZt2RLE/grKMfXNAc19MnQXj+e4mIlsw+BKxbV+px2y1ugHu05ID7ychWqw
	YOJeU9gxYr5wHbChycC+PP1GScWIFUtUGNW2E0xiUUw==
X-Gm-Gg: AYBFou1Azu7+JI1ipWIBYibzznB5xBERdoFrpDRspvck5fkScNuzphLV6zyFlphYhAm
	FBCT1GiZ/OwvI4NZK59PEIX1l6f6UYL2N0+LM8qmzyy82DIrZ/PeD24IIGbtqCxnZ60Dtr39cMx
	qoypRKZgvDYpzxAG8UtBdL2cFDQ0w1sGpXU8D+zt5o+qmCI3jk7An8xYkRk65VARFs/jJqY3nLa
	lVQCRYAoLti4urZP9WmJ1DOBzJfI/keff5zdlBHUWbbAq8ZRnkhOtxri2seVUvG4K8LqiXEDCH7
	Eah5UVLYjH3450GfmFo3vjFNIpfP8G9PExKkAJJo3mJHuQ==
X-Received: by 2002:a17:906:2083:b0:c26:18be:68a6 with SMTP id
 a640c23a62f3a-c2618be6a62mr1178802166b.18.1788831310377; Mon, 07 Sep 2026
 18:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <20260904150304.49104-4-max.kellermann@ionos.com> <CAOJNxRKxO3z3H0xXG0J0W9_hp2qwBfFEUeKFGFnk_MRQtu--tA@mail.gmail.com>
 <CAKPOu+-zixbekaeE3+96hV+abQxnEAnTQnFJwhgPeNa7__6irw@mail.gmail.com>
In-Reply-To: <CAKPOu+-zixbekaeE3+96hV+abQxnEAnTQnFJwhgPeNa7__6irw@mail.gmail.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 7 Sep 2026 18:34:59 -0700
X-Gm-Features: AcwNN1Uuu5Oqsq4KB3cfDtW8BQx-uR9OtYrv2nZUZ2oDtvc-LBhe7NJyJM4ABBo
Message-ID: <CAOJNxRLW_nfbqDReOQTS3Tewv8EAhKOAMzAuvzC8R_1gq0uHTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ceph: don't unregister an MDS session before
 removing its caps
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Max

I think you are right. I just checked the code again, I might have
messed up the code with my local temp patches.

Then this LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks

On Mon, 7 Sept 2026 at 12:15, Max Kellermann <max.kellermann@ionos.com> wro=
te:
>
> On Sat, Sep 5, 2026 at 3:56=E2=80=AFAM Xiubo Li <xiubo.li@clyso.com> wrot=
e:
> > Just one remaining teardown path still unregisters the session before
> > removing its caps: the fallback loop in ceph_mdsc_close_sessions():
> >
> > mutex_lock(&mdsc->mutex);
> > for (i =3D 0; i < mdsc->max_sessions; i++) {
> >         if (mdsc->sessions[i]) {
> >                 session =3D ceph_get_mds_session(mdsc->sessions[i]);
> >                 __unregister_session(mdsc, session);
> >                 mutex_unlock(&mdsc->mutex);
> >                 mutex_lock(&session->s_mutex);
> >                 remove_session_caps(session);
> >                 mutex_unlock(&session->s_mutex);
> >                 ...
> >
> > The rest of this series consistently changes the ordering to keep the
> > rank occupied until remove_session_caps() has completed. Is the
> > ordering in ceph_mdsc_close_sessions() intentionally excluded?
> >
> > This path is not limited to shutdown: it is also reached from the
> > corrupt snap-trace handling in ceph_handle_caps(), ceph_handle_reply()
> > and handle_snap(). In those cases mdsc->stopping may be false and the
> > mount need not be in CEPH_MOUNT_FENCE_IO, so a concurrent
> > __do_request() can register a new session for the rank in the window
> > between __unregister_session() and remove_session_caps().
>
> I don't think that's true for the call paths you mentioned. They call
> ceph_mdsc_close_sessions() only after ceph_update_snap_trace() has
> failed, and on failure, that function always sets CEPH_MOUNT_FENCE_IO,
> which prevents creating a new session.
>
> The only other callers are ceph_put_super() and the mount-failure path
> in ceph_get_tree(), where this is not relevant (no requests exist).
>
> Am I missing something?
>
> --
> Max Kellermann
> Principal Architect
> Hosting Technology
>
> cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
> General information about the company can be found here:
> https://www.cm4all.com/impressum
> A member of the IONOS Group
