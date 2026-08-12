Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F9342CB3
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494441; cv=pass; b=UGKIi98/4/CPxhVSS9p7bd7cYenwkoyy9Jc0FDchH6JsBXZn6QWAnIf+ufCjHqPhjbvRXLfOssS8QyyM0mz4N5nmdgPZFYog7HsSrE0BDFIPKXCF0RxMGmxJR9zUS5Mr6ZuNqu7LDeXYq6Es9R0mvO4GJAsN3dT5v1SfEDxzpqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494441; c=relaxed/simple;
	bh=DC9XWClquj5GXydGUnkiPapt9YRHjdKn6XNvQU5kLgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0b4ZdpsF0Hr+0rnbwq9swC7h5Ytf5NqzLOPaUi0aX07ABV+SDxFaL/MESTX4yQTObvYkHILkjrlEzBJf65hMCiC3X6F3R3mmQzrpOzVd2Ruhvrxq+iVg3PsA/XmnJWhRSsRYXGi84gXYYsf8BMsZyPUkRecOHokV7CTABi421M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=superbaloo.net; spf=pass smtp.mailfrom=superbaloo.net; dkim=pass (2048-bit key) header.d=superbaloo.net header.i=@superbaloo.net header.b=BQdSQbB8; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=superbaloo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superbaloo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superbaloo.net header.i=@superbaloo.net header.b="BQdSQbB8"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso339578e87.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786494438; cv=none;
        d=google.com; s=arc-20260327;
        b=nZmWLI1brarQ4AL030S++N3tTXkN15YYmiBvpXpWzu0hkN8DMpIF46LZ+3IlAqXqZZ
         W1tq+ADDQefb3VP4upOqscHo6iG89AFpS+KBcYPIvlawkoA7hiVghRZMEzF3xF8lBqM5
         Q1gK1O2yaxMjBknjL+BfXncToZRsOZQNyef7WnlbGhM592lnjlFBAKD/la4Eoij+FLja
         tfDcur96oa2AKS5zjOA6X1zvmuQh2KgNYtFCqCyZNMeAuVrW1dbHggYSHgXtoThzUhbJ
         HMQiX03oi+Y7Tf7Zm5zeXJf36Kon67xnyhFl07kDq2lr20Bj/P1LEsrwZaNuXXe1vMXJ
         h24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VPmjvTIZ3uccW5WBxN62erBkUQ6ddD7JJSJUjf67Gp0=;
        fh=1izxStkDu0A/alCpTwfN1bFGhbYbrVzxQrdtSVqvnzk=;
        b=mLUxEYRfqAuwQ5uMsXT9Hb4388wKlKIEyZKQOUIImq2bYz9zUPmFK1XJfFeB78SHJP
         IoWyjTZer1KKu+lKoFwQMvL3fBkRfTNtLjjdoJgefCpzBGUFRMf8t1i3HtPG+BRnEx7X
         U/NGA/jgm2aJ02fS4EciECjZSzYbvL1C84fHy5bQIWUIc+Hg5+z8zB354z+pveKcvlN4
         w78MS8lssCMKfylLQQFbG7wGfDvXgknaRXGyiYdvmnMi/pUANUMSoEnxgelyLVTCN0eg
         74Fzp72ByMwvVDtj2r2uTVPfBxElpGo/lTIam0l5upqU3A7AYG39Ki4cq8ZcRSpV18ds
         uCVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superbaloo.net; s=google; t=1786494438; x=1787099238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VPmjvTIZ3uccW5WBxN62erBkUQ6ddD7JJSJUjf67Gp0=;
        b=BQdSQbB8iV3Q1OTIPZmXAFcMWsR6IqqEiz9b2Q0ogJKHXxaPT/oqP4A184PLSxyVMf
         /fSkl7fIGbZ5dfWgb5LLpB8B4Hw3w5OQNzBZP8e5pI1yq3Jw6dkrc6I1JepI3WbhDRYZ
         A4UK1DrUHsTRgiCkkibMbEIJFeGvm+F/YKl0lPWxNxtJXFCTKIs2d0Vk0j7BHA/1IOIV
         IMwsV6vd5Wl5WyhGIewJA3hHqYcUmySemh3sNfQMFUh5n/igz831aVr2yiEiOgdH6SvA
         F7I4F/YlKuq1XKbpp6AAb94z1XkWFApkByGHTa4TcsEaehw2E7OSHyEcRZRFpbYDvbZd
         Y4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786494438; x=1787099238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPmjvTIZ3uccW5WBxN62erBkUQ6ddD7JJSJUjf67Gp0=;
        b=K2GFM4tA1BQFQdWnHcMO0o6GHglDk+0VYdg7O3b7J+s9aSDbuXFMBrJDqgOssnTcAs
         cYIgVRH1qEOZ+TvslmfhXjAwGgmU8/1E//eU/TEvz3Xe9lHetEVFbyH4PHm38bURNamX
         AgfUUIp47+4Nuk4uZDh7PpOZ9+vx84LyMwXHWQraerb65WmiRiYWeJUp7FjmZRSKVWKC
         +x4mtY6qpNiWz5XsqhxFXRgCglKnQGpUh/zt3XSeIuF5hnkHAePyrdP6TJhXnc+G1HLw
         8vI5new+JH2hxopDGRPeR448GqzFgdKnEkim17q9Icahe54cZfjVvsXjvKJnZ1ZgKmJS
         uYxA==
X-Forwarded-Encrypted: i=1; AHgh+RrexSZc8pkOFA3YVewV4YQZVWxFixW8yUvAXBZrx6vfiKM/VNJRzPpuJB0LrN8zkxDE64aHiz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPdekNSXQyyOg66qexDhp1S6Ty/x035C0xNplGJ0zfDvh390b
	Gmb2DBQS0QKIRyZ6/yPP8yc+AwkF6dxoXJuhLz9LVplVWLDVxdGOdPYZ9jYuT+x9GbK4HmUFwrv
	wJM7HD9WIDkg8ilxSv2zXGpu52wmgoHba4XYI/TGxK21zkHcFEpctRXqiug3Yxcs=
X-Gm-Gg: AR+sD121sjijAmqU7o3Wr3P9rIOOkyAeZRcbfk5nL8YTVccciL3MBJzst1vW2UI+cG8
	tPugnIu3tGFFyBcwpo9K7j8tqhAQakKVo8+eABLe/Zmdydb/a38Yi/mRtpYIasU3B7MP3Wi51oC
	CnGkd0JPoeK9zLcssPrq7bLb1lWAN8cgeasU4/Dywr+DSUxxqq1N4gqDkw3fOXxWgf1yi0L4WTe
	Ibl93a7SUkVl3k5gxEkRIS9vL4Fl/0X6b1dr5hsXjp8VYt36LAwM2ee81LUaU/KS0bgfrcdRDH+
	r4D7c2DzvV0vYIrOvyrcEbzq4OdEaKWLD3lQbDnrzlXBgiBXiGePXjCN6jUD4w5hyTu+Fygnpgu
	6OY/Q6x0Q2XnhJ2bgXmpLphtNCrkc3rtxkvI2EfyBoyaKAicqwDr+QT4XzwxXYeIkXQ6sMGVoaN
	Q=
X-Received: by 2002:a05:6512:31cf:b0:5b0:13e2:4b2b with SMTP id
 2adb3069b0e04-5b44e334dcamr147272e87.52.1786494437610; Tue, 11 Aug 2026
 17:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811033508.1050148-1-baloo@superbaloo.net> <20260811104237.4500b578.michal.pecio@gmail.com>
In-Reply-To: <20260811104237.4500b578.michal.pecio@gmail.com>
From: Arthur Gautier <baloo@superbaloo.net>
Date: Wed, 12 Aug 2026 00:27:06 +0000
X-Gm-Features: AUfX_mwwbQ9S5CnDrRMQIZy-Gj7_vO2BrsVRcijhK0tgO7pmoEIt2UftoQ6OSCA
Message-ID: <CAOAHwbUGophqfWvJw=u4YuYkX==vm-UGv5cZS9brbpZgvs3M6g@mail.gmail.com>
Subject: Re: [PATCH] xhci: fix lost bounce buffers on TDs spanning several
 ring segments
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:42=E2=80=AFAM Michal Pecio <michal.pecio@gmail.co=
m> wrote:
> >   device-mapper: verity: 8:2: metadata block 10850 is corrupted
>
> Quite nasty, and not everybody uses dm-verify in particular. It seems
> corruption could also affect rare FAT filesystems with tiny clusters.

I've triggered it very reliably via the dm-verity prefetcher. For the
last 6 months,
my workaround to the crash was disabling the prefetcher, to the cost
of performance.

See https://bugzilla.kernel.org/show_bug.cgi?id=3D220861

> > Fixes: f9c589e142d0 ("xhci: TD-fragment, align the unsplittable case wi=
th a bounce buffer")
> > Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> > Cc: stable@vger.kernel.org
>
> Note: you don't need to list here the driver maintainer you are sending
> this email to. And no need to *actually* send email to the stable list.

I didn't mean to CC the maintainer here, that CC was for the author of
the commit I was fixing.
The cc just got parsed by git-send-email and sent it automatically.

> > +     if (!ring || !td->bounce_seg || !td->urb)
> > +             return;
>
> Tiny optimization nit: !td->bounce_seg is by far the most likely case,
> so it could be first. The others guard against bugs and "never happen".

Noted.

> Hmm, AI patch? I think most people would write it like below :)

I used AI to walk me through the trb/td logic I was unfamiliar with. This w=
as
a copy paste of one output.

> The code looks correct, though I would do it differently: store the
> last bounce_seg and run the loop from td->start_seg to td->bounce_seg.
> This avoids adding the 'if' during enqueue, and still works correctly
> if the TD wraps around the whole ring so that end_seg =3D=3D start_seg.

That makes the patch significantly smaller. See the V2.
(https://lore.kernel.org/linux-usb/20260812002554.1166712-1-baloo@superbalo=
o.net/T/#u)

Thank you both!
