Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794831923;
	b=dI0FnvP8UAqs6U66w8u7q0QQPLFlvU9i6fUXpyaGrKVhbEokiqzMCD2Ij/aZmFYzUUim
	 aXsWoCl1dgOuKwCEZ+X+knfF1VvuwgAew3cMJaYSlrFfrtG0OaPc6yvwp986LTTWoqb2Q
	 Tf8b+Vgu8VjN7C5uk+oH+S5uxB1MaeDchcDoAty4D3452iDC51tJk/lckE5S6QPEtj2MC
	 laG5jq9cJLalPaNCdWumtIbsgSNxEde19nUJDdJUHIlS0U0DeNdYaxHlB+Eorq1ZD0A4L
	 kUKfF6ZeqvZoGCh6iJaLtOiMZ61IjHF6KsFcsekF2cd6ze3pywD+Edy7sWWq+UUDHsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/PiMcjQOkt2ak1BLcowjZuDxANqjoy7CFeucPyIKk0k=;
	b=ZpjXNmuCdNHCvV6L2j6ALOkIdyLrF/rcmaOKPrB4roYhhACsfCbk3F7P2Q+/KHiRp/H+
	 MnvZROg7T3Rcs9TCSa2kg7g+Ov1c6PcqgF3geudoXgEzFLzrG9qQQO3+dQam1hD7hUt2o
	 aAmVM2LX83XVINV/qQzMMhCwWz6p/STCd+syb89yI4515ZkJf6V0pE/cy8jffB8LzcK1Q
	 3Lup4WS7XrO14BKFvWG9emHxUg22jpKJRY1iiwMyJeO6GUfkjtNRbCAkvMfY13LAgnNSN
	 VixmwCCj7wwF2WTwS0VGjmZIySy7WqOYm0MGDCIEaQwLw46pwgrpBEiV2evgnVKRIPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Io6RcOzD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37718606A89E
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37718606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Io6RcOzD
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so30706841fa.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 04:25:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794831920; cv=none;
        d=google.com; s=arc-20260327;
        b=WQKqzTnIKEjFJKhtbPZUNxC7Y8bd8vBZx1IFZsg34aGLU6brVzW7cfNNtCoqMG5AZh
         vV+JWeVo+xbkKfFzw2eJcDmD4DzjeZF+a6pOAXJCmL68RKh3LZL3zWirD5vU7erVJ6g7
         KrGD6l7MmqCOn7TZHCmw341jh4QUDP+N6XYAo1aKd7MPswzhkGMY+SDceqiWEnodprsl
         FVMG+YVPxFerVQZSzb3EHkOq8FMGaUKfXnmVKd3lzut1lmBFtvWrnwzRyTMUTBJOXfjy
         baTlNiIFj7nUHKK97HT2NSk+N45XxsLJoMkm3CMqtn8inM21VB+6T7/CpltUqjV97VJU
         96ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/PiMcjQOkt2ak1BLcowjZuDxANqjoy7CFeucPyIKk0k=;
        fh=YI0GNbBo/9cb5JkbJo0ZIXauL51UW1Uj1FWaV+31MIs=;
        b=IQ3gBke9y4VdwHs/EhldzJ+fU8C9lNS4/UiAg6IjFU5w/RDVKQaDO7MSYZGvL79eaj
         F3aAgpz16cY66CFpezrF391togD5k/L3HmPz5l4FLdV4/XUdd+jQ7aJM0hHMkTh1jRqD
         PfEFoF8hbluByC0ChB6EBLxMzDYRVXTA1I2uhmzpA2Q+ILOb+l9VaF3VNSdbWM25W6We
         eLWYgPaVpJwoXAonkU6Cdfvsw4ryg8u9uufA0TLtKIz7vQ9CaOTAtT5FirHEYSPviOkh
         Sk9USgGKmvMvFsviVdVbo3suEm/cpyYivP0tDBwsDoArH3Xl5QcvEc2/TNk2MspGiXeP
         nY4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794831920; x=1795436720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PiMcjQOkt2ak1BLcowjZuDxANqjoy7CFeucPyIKk0k=;
        b=Io6RcOzDR0JwQSOMZ2h/dhataExRAczwSTQYM2gQGcvveSLFkoliJjGCFbhzZ99VwP
         9xDPwkg0P3o4hEJS2bKPbWl/SIDSTT5vif+ZberzXGPC1gJ2yEZDQb+TVWFrP7aBagAM
         RYdX+hW9Ys6Vx4eHmulxcgkFXEX7FzLwsnbKwoKQeQrQcqbGwro95zEANdjKwE2PWuPO
         I27p838Yp1sAveGpu2sNwbQgbBkK3CP3eIenSSnNb5EWDY7e7UYKfhDUJw1t460K430F
         P2ILgEKZwkxcbRYmPC5i4YfVKTbPg9BldMzn191ptyulfkn5XEb6Zl02u/O5HvzMmSqI
         FM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794831920; x=1795436720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/PiMcjQOkt2ak1BLcowjZuDxANqjoy7CFeucPyIKk0k=;
        b=1ulSdeVa+UpEEP/Oj+Ft5w798Wb6RZ03vllcOVoMcVpnU49JA9+e11g3rATcvSxYRL
         h5VVuKavXOQ9BP4urNmeI8lVmDfajQ2eJ2SFs7uZOYAMk5odllENu2SKX0PKm91fFLxW
         hni4w/OkGD9FH5vpSfFVyUeBqIyKpOAbenQlDlbKFiBrkwRizsQj80Lvka0iF/wz/bTY
         nvEg4hDiAzOniQKYujzPxaz4sjzwSyW1IZVDfZM9SW3mF0T+9/J8xgnAaBG3gcAFu/o2
         c/f2VdESZxEvRCdbitykuLKO7TT/Mr1Xj1ymJ5fxBQRfgUveK4eX12DOvIFLsbGRTk8Y
         KsbQ==
X-Forwarded-Encrypted: i=1; AL+hErF/FTvJZi3OlKQnOgPwXA3y9rGF5uieTDcEPTxSmW603jkl1SD30lExxump+6n5khy1rAUNyfU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AvuO6HDUEd9EmkbVQf9Ch9X9fvXf3DqosEjUCGUv5EK2WnSC8
	xuukVrBy7fDIr/33Vj/OAPZbDUoTxakaUfkhrywcrxXkZfHFh+18ke8YGNn1b3N9uFGInStqcAx
	JB359n5egJR4T2PXHxy0J/q6+Jcw4AaE=
X-Gm-Gg: AYBFou0fFWgOQz+YxYl4aaDh91UqdrtN1Zwh1hYfB/+CEt/Jdm2UTX6DU1JEqN+0EW+
	k3N2eEfTsC1ZAvixww+N0ghafCzCyBFVWVkT6j/uO1JNbuXeKfp6EJ/MAQSUeKepZHdzDgc+gEc
	qgfrw55tcV3/mBmf1sQQ7DmCXkbrkoSvALZ15btEAdB9mM6erZbsxADnYz6H5F4cWAhpiKULpFo
	HOIfmeQgKH5sDZe2aVVKBQdgeFpOjNS9KlCnlC/RTd9DGcTwtmdIi1oeVqp81mTs9P+iKZmp/e4
	hJDpECqNwG5ysfGzEwzEPV65RzG+3mPR3Tokzi+6W6cK1yoM7OGuTXz6uhY3+3VKWR8Z++W6+Ow
	YVBIU6EGdkGPK0pukYMURb+fpyZ2ipfd0SrvPTA==
X-Received: by 2002:a05:651c:b2c:b0:3ad:fb2d:a757 with SMTP id
 38308e7fff4ca-3ae2b5302cfmr27450321fa.24.1794831920174; Mon, 16 Nov 2026
 04:25:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
 <20261115210952.2140036-3-graypanda.inzag@gmail.com> <CAOQ4uxhR=ERNBYsxQ06-sKGrTXvePpzv-xi+62oceNff6Mzzbw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhR=ERNBYsxQ06-sKGrTXvePpzv-xi+62oceNff6Mzzbw@mail.gmail.com>
From: Junyoung Jang <graypanda.inzag@gmail.com>
Date: Mon, 16 Nov 2026 21:25:07 +0900
X-Gm-Features: Aa3M54r2Viw7fFeJwPagRzK9IYztsTnUnL-IHLph1k3bGx9UGsJ-OXrvkjOjw2M
Message-ID: <CAO7ntTQvav7mhK6caZ82afGadP8jeOJ_thanAf8DXBMBboN14g@mail.gmail.com>
Subject: Re: [PATCH 2/3] inotify: zero-pad event names after an embedded NUL
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 16, 2026 at 7:32 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Nov 15, 2026 at 10:10 PM Junyoung Jang
> <graypanda.inzag@gmail.com> wrote:
> >
> > inotify_handle_inode_event() allocates the variable-length event with
> > kmalloc() without zeroing the name buffer, sets event->name_len to
> > name->len, and copies name->name with strscpy().
> >
> > If a dentry qstr contains an embedded NUL byte (for example, via a
> > crafted FUSE READDIRPLUS entry aliasing an open directory), strscpy()
> > stops at the first NUL while event->name_len still covers the trailing
> > bytes. copy_event_to_user() then copies event->name_len bytes to
> > userspace, leaking uninitialized slab memory from the tail of the
> > event allocation.
> >
> > This mismatch dates back to
> > commit ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"),
> > which replaced strlen(file_name->name) with file_name->len, and remained
> > in commit b8f2688258f8 ("inotify: Use strscpy() for event->name copies").
> >
> > Switch to strscpy_pad() so any trailing bytes up to event->name_len + 1
> > are zeroed.
> >
> > Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> > Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> > Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> > ---
> >  fs/notify/inotify/inotify_fsnotify.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> > index 6e3af6452dcc..78eb1e92a14c 100644
> > --- a/fs/notify/inotify/inotify_fsnotify.c
> > +++ b/fs/notify/inotify/inotify_fsnotify.c
> > @@ -121,7 +121,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
> >         event->sync_cookie = cookie;
> >         event->name_len = len;
> >         if (len)
> > -               strscpy(event->name, name->name, event->name_len + 1);
> > +               strscpy_pad(event->name, name->name, event->name_len + 1);
> >
>
> I am not sure it is inotify/fanotify responsibility to hide awkward names
> which filesystem emits.
>
> First of all, I think the solution should be consistent with d_path(), so memcpy
> instead of strcpy here may be enough to avoid leaking uninit memory.
>
> If we want to be nicer to userspace, then we could for example pad the
> garbage bytes with "???" for here and for d_path(), but I don't think
> this is worth the effort and also don't think that hiding the fs flaky name
> with strscpy_pad() is the best way to go.
>
> Thanks,
> Amir.

Hi Amir,

Agreed, matching __d_alloc() and d_path() is cleaner than zero-masking
the trailing bytes.

For v2, I will switch both inotify (patch 2) and fanotify (patch 3) to
memcpy(..., len) followed by an explicit '\0' at index len so the full
allocated buffer is initialized. I will give others a bit more time to
comment before sending v2.

Thanks,
Junyoung
