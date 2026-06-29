Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D92332B121
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741424; cv=pass; b=FII1Q1HBBogp8kh40iTwVJYsSeLcnezmLlUaffahxAZp7pRzSX5c1DWhQdiBpce6795cuQKjIlatX/wF2tZQ9F1/KuHgYmy6LdKGADhaY8yZdKmvywJ3Gwifj2LXPf6xWtWvRZb6Mvic2LBAeUqYjFo7dsysA0KUrTjm4cjkNBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741424; c=relaxed/simple;
	bh=jdFo5cH/XscFmXKFc2L0Oc/loLftDgeJhJslg7IrnE8=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddFGemzqCyNDTAX0saNIhAORSB1wvxxQqjVSFunvKrFCKSlClXKQ9jeG97E0kbuYZ49OWtcdtcMlEsOBA1hZpT9VOOHp/CIFNhEtSbOP0FPwILH27hGmwPR+9AA2asyD8G7+kXqS7UZZD0uFvtG1t6FnTYh6czjrU0WW3mqdSzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkmpHrKW; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkmpHrKW"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80e46c00f3bso8039067b3.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 06:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741422; cv=none;
        d=google.com; s=arc-20260327;
        b=P+51hId6m8ccKQjRfLOSGLt7Bt71to/mj58EwqdF15gFxf/5BD2kdAowDxwfIpsgUs
         Vp6rNHq2mazs5c7k/fT87NignXtVUKZSK1GT8oGlEKkovrpezSW6u9fpbqe2iBcpN2HK
         VaV6R+yWTg3tqbRBQhLJgKSmPkwBaG8NT8RpIJ5QhmjPVE+ZNkEmQsx9FKLyGMWfbTjf
         gH++eNNdkwD8VuKWc4oIq8xVVA/fJYut5UBMASplniq7kJPuWW6EnkEtIUsKuQ/8WaaU
         BMyqCXaVV+HcLpTBoPeLYZjgG5bLZ71nG7W4VjQPyRBVK7gobLiI9vIFufKDRXYFJKff
         iRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=jdFo5cH/XscFmXKFc2L0Oc/loLftDgeJhJslg7IrnE8=;
        fh=sZXlo0RNq4z58HCew+U9swLeZOJ7ZKMyne5FIFoYE0k=;
        b=dPUErmph/l/C46kLFZMrhXWSFdK//bbr8OammpFtcXsqrwqz0CiILebiUJlHrrwNIu
         rSCLyT3dESRJA/7czYyZQdd/HDGobOFD6NwrS13xK+HUHaIECm8TMha5D+RX9HE4cAr3
         43GRAebfZscCpkOdXorcJQc5CQ2ih6Iqj9bT4a8WOM7rMBibORF8QBBEKs1yBI4pPcrc
         sj3tZ7dyjrJU0NlUUdJOq+CHpkOnyYSMVUEeq1jfIiS5lwrieSMtfqqJhrOZX6YwDAKa
         d0CP6Fo7WnyllruOxW3XdaA7mkNe1c7CKOZM7XGMSwq4Pim26oRhTp14OpM2y5Py6AIZ
         pMyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782741422; x=1783346222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jdFo5cH/XscFmXKFc2L0Oc/loLftDgeJhJslg7IrnE8=;
        b=FkmpHrKWrDCN+xC5CS7RwX0yPsA0ZJDMHiI4jEts7qQHnJAg6c+uD+oE0TnWaR4+no
         zrkmSX1+3PKDc+OJ09K92ic9TycYYpFWP7KCvdPxR+SPueujyeJRnmXgtsQFOXYIzX2X
         djZb51RHnwB1Azw/av8uI+RxSYBauRcfiCQHzb6NTXcmjIASraxCQgXY0SZQGBeD9LA8
         7S9SCyuMkMZ+qCo6mdDUpBprDsohx+Kzc2E7gocbUrIBfJWmK9KHmOEXTj8tI5at01Lv
         lXDKq8peF9pOc65P/ArcK27gTQwtZNKHu1s5Mz1oE3hUC1163LKAAMirE7iWFhyOxXy3
         gPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741422; x=1783346222;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdFo5cH/XscFmXKFc2L0Oc/loLftDgeJhJslg7IrnE8=;
        b=jzp2PTiqnJQ5DRuDcLVwoOTL+/GUfoLxrcov76d5s+vxMhJEDJX9gfHqgq/gqnL/yh
         n1ncjuYuZ+CtoVvfqxDSss9lU2bXPKO2qVGKjYCEzdAHsE7gYSw6bB4Xm1cMw5vW6WFQ
         95d4WDV8j/Lx/oNexqZ3jrpZWtGRpKq1bhVm4OsYvpi0tM5IHMgKU71+2tY/Cvh/P4Xk
         MbxNQanifrY+6Z06H5Q+TJzKPJpv/AGnrdCk1R3Cw1vHowzR4CLasut+tAdrImahaNKa
         hJZD/My0tIeadf4FNll4nA6iYksQWTuDTEyLSrUN6fIcfiHmucNzrSrj15bq+nYbiqFb
         G51Q==
X-Forwarded-Encrypted: i=1; AHgh+RrZcLPrdssQsl/Au9kfrqnYd2Y+p10jhsPDOqliD30sU5Ox2t+lCsUHd+kz9thgQPsy2CS4FNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ijd2kF6pENIf8UaVQbrLBAM4/QzXXKvDp3D7l9eHn5CcdtUB
	AH1TxCkvXpu7lTw+H5nJvl1Z6Gf1pNd3bxuo27Qee2US6F/51QP9X2gZGUFCMBkZmcenQIMLzeh
	SpSwK0J9sqj74ao/FWiNIQRQOPY5jxpeWE+x7
X-Gm-Gg: AfdE7cnwLz9UZJHDfsWz3r1yXAioqiB4T2cXqoGGLBs+ikPYt+8m744MPcP8a/j50dF
	pa91ooQvNp1NQ4FsSLbF49YMWQqXi3UWCSw8sYua5+IO8kY2POsg+pfiQj9lZOYTpUzaL8lDwwV
	DJiYZv0+IW8AAyWi0n+SieaTkCcwuLTzesR5YpBUx5OxPN7urnlUxHaDjhryoiWEL8H90yGkplO
	DfjwDm4Nc/SX9/EeolGeKmppqJTAu6lctqvENPB+JO+vztNI9ZkX12lz1KYiE5Wgvadx3Hi
X-Received: by 2002:a05:690c:6c08:b0:808:f9bb:3832 with SMTP id
 00721157ae682-80c7281f47cmr91490817b3.22.1782741422304; Mon, 29 Jun 2026
 06:57:02 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:57:01 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:57:01 -0500
In-Reply-To: <dde92cd4-c6fe-4339-a892-004ca78ebc30@linux.alibaba.com>
References: <20260628004314.27370-1-alhouseenyousef@gmail.com> <dde92cd4-c6fe-4339-a892-004ca78ebc30@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 08:57:01 -0500
X-Gm-Features: AVVi8Cf117p4oIGfG8WMvH8mjl3V9I8oAyu9H_TLtIAqQHBS5gnrowmyLrhOSto
Message-ID: <CAMuQ4bWRePpX_R0BcGgvFYuACGPL2e8pVqf=dh54EBteTx-Bxg@mail.gmail.com>
Subject: Re: [PATCH] tmpfs: zero unused folio tail for long symlinks
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"

I only observed the KMSAN uninitialized-read report and did not
establish user-visible corruption or disclosure. I agree that does not
justify stable backporting by itself.

Andrew, please drop the Cc: stable tag if the patch is carried.

Thank you for the review and for the pointer to Barry's earlier patch.

Thanks,
Yousef

On Mon, 29 Jun 2026 11:27:47 +0800, Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
> CC Barry.
>
> On 6/28/26 8:43 AM, Yousef Alhouseen wrote:
> > shmem_symlink() marks the entire folio uptodate after copying only the
> > NUL-terminated link target. The remainder of the freshly allocated folio
> > is left uninitialized.
> >
> > Reclaim may pass the whole folio to a swap compressor. KMSAN observed
> > sw842_compress() computing a checksum over the uninitialized tail. If
> > the folio is written to a swap device, those bytes can also leave the
> > kernel.
> >
> > Zero the remainder of the folio before marking it uptodate and dirty.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=bf5586280a66e9ccdfa9
> > Cc: stable@vger.kernel.org
>
> Do we need CC stable? Have you observed any actual impact?
>
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > mm/shmem.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b51f83c970bb..b06c1ae2f50c 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -4057,6 +4057,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
> > goto out_remove_offset;
> > inode->i_op = &shmem_symlink_inode_operations;
> > memcpy(folio_address(folio), symname, len);
> > + folio_zero_range(folio, len, folio_size(folio) - len);
> > folio_mark_uptodate(folio);
> > folio_mark_dirty(folio);
> > folio_unlock(folio);
>
> Thanks. Barry sent the same fix before[1] (though I forgot why it didn't
> get merged). I think this is a reasonable fix. So:
>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> [1] https://lore.kernel.org/lkml/20251224020424.52976-1-21cnbao@gmail.com/
