Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985C3672A8
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434053; cv=pass; b=ouaMCIivw0kbD6AmU/d2dLvZ3NHtvra0lB9EN93z2n0xweGwWSUMsNFlMHHJMJXPFm1vhFfrthQp8VdcRp8DPkOy3AXQ3bF87vItErwAO9OlnFjksOA4+Gfdng+9Oc4WA5pSkNtRqxZP0Rui+dbwKfUgSWzc/hsgNAx6R0zkDNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434053; c=relaxed/simple;
	bh=0Pmyp4+fKGpQSRa/JRAnhA6Y6d88du6SFSR8E/Xq4Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXhVq1uMkD1pXwmVtltEY3iRTsqiHnXxTM5BXtvoDnWtDNcPja2Le8UJt0S25bpbZKw3luX80qD0OOPmYzG+D2bvIoij3mOygUlda2WNMepk5hX3IBo7zmrp7I0Dn+VLgDYBPCvyKNnAA+sfADPx2i+6JhmsqegPPp2FUwq/Sws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up32RJgd; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up32RJgd"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698562f10e7so5740966a12.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783434050; cv=none;
        d=google.com; s=arc-20260327;
        b=Zr2KP/ay8elT8mBUc5a3QJc/r2irZC7/u9uXitC4U5r9hCnisEYgZsQqaBTxvsVJ54
         iB3S/ijg8PnRBoGr6Gllaa+RFBhFKJ5U+UlakbFg8xBouRANzRzRDYwHGy52XxwWfmqF
         98Qcpc020Gz64SxR5NQXpqhWyrVtbbwr1drKJlAkwwrZ+riHa6vDbn5PqrvAObIN5r0G
         Gll178GLD0GjdzukbBh84kuscQ7gXZbIorhF5anXehWmrEtntbZ0O9Oler6mL15W2f6o
         oytK2clu6zTz6BGjBvdTlTkDwnadOTi9qd4QzkOHTaVpS61QGTMLou4zY/FqQzhqHLaf
         4KoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iFw/uuft2ZNSb/Wju7Fc7KgMmtW46i8JZGDIIBDOgNM=;
        fh=XMhlrdmeLcsZXS2HTUd/ZDsOOI5EHZ9wEotAnNax/tw=;
        b=YutAcdhUHtgeEOE6U5tia3EZXd9J5Zk/u1cgq2w0+tbDfTwPTttxYAaG+4E9zvUn2T
         eMgpiq17TFpPSK3CXo06nSth2GbldQJ2jbwQvjlC9GDuZUIAXWNZY8h6KqZktERo8D6B
         HS2gF06pyCvckp+RLOx6mALjbR91s4RPdCOEwsV3XzheK8Su4fU/BgQmLnHOaujw6no/
         2m+At5aJn3h9VOAhLrZS64sBCXHfXlbneGuzqiUiig9LJRW3zcEoP1Cm8ICyqgEzVG65
         Lo4c5B5Bcadu9GYStWzAhIJWzghPJwDZiDvmc/ToZy8cUNuPWQvFc8zD7PFbci3zxbXO
         j0Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783434050; x=1784038850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFw/uuft2ZNSb/Wju7Fc7KgMmtW46i8JZGDIIBDOgNM=;
        b=Up32RJgdYCyOYjGnt2M6zmwpKb9ifSJOlUKy6FVCREmmzGwLd0OhwipEWCdpGb9Zsv
         GWp3fCo1Jqk5WyL3j6ChyEUcL+bAIhGrn5N/G1ULVVv/hXgOLcYaZ55wU0oQrVYyNsGM
         7OQLgVmdUjbVkANIO3aOAawIG/0pZTrgw3xCbFAH4xbCE+NLIwYogqf/tThxfuzlshBR
         jePdx1Tyjw5UyJAcValzYJ/hiO1/Q3Hn5JUDvcZ3U8row48WlUiB1MD2b+cgG60TcmjB
         Q4nC46Ho8bnf1GmfzFIefvPuAtbfhfQmZOkcT0H9MFft0EKuZkUPXvl2phz04M0zMAFu
         qwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783434050; x=1784038850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFw/uuft2ZNSb/Wju7Fc7KgMmtW46i8JZGDIIBDOgNM=;
        b=bwA0GA6J4BOvZGf+qdShNKOdOYOB3Djw7QcCrjmwLvdvMA2OsRiYDT+1NH5Mjtu9yD
         ZSO48ro5DHQyFz4vvViwuX9nFxY14cLzpNfFjT62WcnSStuVvnl7CgWsYH3m22g3SlB4
         QBDk0q8ag6tb00I7/gT/C9NZGqouzYYO9VsO9Q30cSsTRYjxpL7/HvK1eAEVHNbQwKvt
         KcLc/SldorypGyEkfha4YsndLNdMSONNTi/DgXfxG0o0IIlHe5AAkqTc9WgR+CiJFZzb
         9p0Vv7dxG1gn/2F59g5ldnx0aQ+YfAXcUrLPPNw5Rymp9LTs3W+ZI7diuLUtA3wE8XqQ
         6nlQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/EEUE6I7SbKyrWQVxxTFTiS7jOn5YdgNRN44jJteleM+Rio1uTsrrLjg8+r56citPrs5IS04=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXAAqcnjR8negGOy5jPQPzGM4HL8qu5u4aHMpCjuN7xH6nYGR
	ul2e7dETrkpji/DL2naLsxQCfqqcgPJdWjbLTkgQxgjyfFaz879x4T8OIv9Pb+IIoAM+EITafz2
	FZBN2y6Kzw9AWhtJT9NG08F0Xt2sJ1L4=
X-Gm-Gg: AfdE7clVvT2YZEJOCEx7Mm8FqPbz1rQXmqK0cGV2jzOd1gyBFq2FtVJR1HNXGB0k3lG
	D3WxRW2dqz/NI0wl6yqBmGz/ggOwepXdNZQutu9sHw9b5GBi7XGxeB56DrNrozpP6bATS6zFNtq
	/O38ygoT0U+sOiqYxA4F8FQ9B/dCZ6iK1cBDZXvHYUNKMm8uvk0FfnnuRkHoLUq+zt5lJLOIeod
	ZlhzGc24ikG8KomHhtL/Nom0OYYkU8UPtCykGaKFpr1SkbBAUbVYUQ5/wzeeikoCrLBcX28AYFO
	Tmd+G+PW378eNCd67xfp9IQQC5nPDo7sheEO5EG5tTqORv8jIYf4codZAPXI
X-Received: by 2002:a05:6402:3229:b0:698:5f47:1d4b with SMTP id
 4fb4d7f45d1cf-69a85c0d3d7mr2863068a12.22.1783434049767; Tue, 07 Jul 2026
 07:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625202911.26782-1-mokshpanicker.7@gmail.com> <2026070712-gift-curtly-5f96@gregkh>
In-Reply-To: <2026070712-gift-curtly-5f96@gregkh>
From: Moksh Panicker <mokshpanicker.7@gmail.com>
Date: Tue, 7 Jul 2026 14:20:37 +0000
X-Gm-Features: AVVi8CeD3RwiVLji4-TTiExWVp2TyEKcBkmmhXz5DauvaGb9_i46Um4R2cQZkyg
Message-ID: <CAK0z5OkkdOcXkz_sUj521e4Om+HGGesqkoBpau8kYDDjvY8S1g@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This issue was found by code review while analyzing the OOB read
patterns fixed by Alexandru Hossu in sibling functions
(rtw_get_sec_ie, rtw_get_wapi_ie, rtw_get_wps_attr) in the same file.
The same unbounded IE iteration pattern was present in
rtw_get_wps_ie() but was not included in his series. The fix was
compile-tested against linux-next. As this is a staging driver for a
USB WiFi adapter that I do not have physical access to, runtime
testing was not possible. The fix follows the same pattern as the
accepted fixes in the sibling functions.

Thanks,
Moksh

On Tue, Jul 7, 2026 at 11:30=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Jun 25, 2026 at 08:29:11PM +0000, Moksh Panicker wrote:
> > rtw_get_wps_ie() iterates over IE data from network frames without
> > validating that the IE header and payload fit within the remaining
> > buffer before reading them. Specifically:
> >
> > - in_ie[cnt + 1] is read without checking cnt + 1 < in_len
> > - memcmp(&in_ie[cnt + 2], ...) accesses cnt + 2 without bounds check
> > - in_ie[cnt + 1] is used as length without verifying payload fits
> >
> > Add bounds checks at the top of the loop body to break early if fewer
> > than 2 bytes remain for the IE header, or if the declared payload
> > extends past the end of the buffer. Also require at least 4 bytes of
> > payload before comparing the WPS OUI.
> >
> > Fixes: 554c0a3abf21 ("staging: rtl8723bs: add r8723bs driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
>
> How was this issue found?  How was it tested?
>
> thanks,
>
> greg k-h
