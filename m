Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A6437869
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419108; cv=pass; b=gd3Bo1T+K5fj4Jn4PUxCP5i/66lX8NFLplI/LikbOPvmLbdIlOsWHMFQGCiKZZSAJyWr6l9JTYFsNnVZJnYHPGLtCFoFGRQ3ldM3dY3IiU/Ls9jbvjcUU2ouOS4W/Nkb4qT/gjviM5AZzaHTQKCI5ECzPXAnVcD5jYajPIv8LZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419108; c=relaxed/simple;
	bh=DooZteQHa6eWWZGFxr9TJH9KInviPRQxKqtAVgETm3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GccoD2f96WuUmSLL2Y1HHSD6YOOoaf34MYwkYjGl1HbpgcP5ELkjMN/hyTcN2aMy5WJJ9QTQolruruqjmr4US8UBAxPT90PgnZU/mIoW9ntByBAB6Ji30bUuD1Le/lo0qJ8TG5Dqtc7kZQTuxTKkUzuIb8kyxBk/tJs9K+IhejU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEWYII3I; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEWYII3I"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c3044e4b2so349474a12.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785419106; cv=none;
        d=google.com; s=arc-20260327;
        b=T7z2mHwCHEyXSYy+Yp6ySzlp5leLWziLa3dQUsQOahV9VkhgrYwr7XpKqOgijxfWiX
         fqHsJRc04iTaitEGb4gsAuZ3RF2aTXz9SHLT4Zy9ucJJfgSGMAmexo5Wx3l07hhzCuzo
         KnZYqlFVTN1+d7D0RdTcLnLPWPRF7dNNnPjAwS6RaBmrKqfMxip5IVAvDV4qvV1n0K7t
         BqmC5TwbUisafIbsTke0gx6W3OUD7j8q9dKL7Kompw/SgnbVYQk4DzwVh+6IbjCYGG+3
         X0B+Bkj/pjXQeU/0VaQXc8mYAj9oELpNd8+JvHUQwPhoQxyB0MBsN2DwoEPsol0mM9j8
         S26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DooZteQHa6eWWZGFxr9TJH9KInviPRQxKqtAVgETm3U=;
        fh=B6lSZr9N+KEHPrneLF4Ptys3O/GHpYyVI67b+WMd9g4=;
        b=bDAHeTM4BoaYVkAQ89EY7+B/gcjYLDe6D+XKlnn2DmSXRTTh68GNo7S6x1O8nBnFE5
         Jor2+h/1MKRxFi6Jx3CcG8L1NMBD2OatUkBuEzEN9t2ED9gTORag8U9r5/nKzmbo6To3
         1smyGBv3/Xg2ANxAQDzSpEXBqWjy38ffEBNZXVUcwV9uJlHjv7MN0kifyKu2c7a4rPHi
         QYh9drU2iFq659+CKd38HCSzUFsGX+RIEsbf9YUY344GsyawrNPF54G8Q7bao4/olfAK
         tjQDFv7gXJp5LyDujay+kPbEtutiFNNF1tl1L05IhvsndFbsVyxEfha0Xfhe9R5/hr7v
         o6fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419106; x=1786023906; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DooZteQHa6eWWZGFxr9TJH9KInviPRQxKqtAVgETm3U=;
        b=QEWYII3Ifkto15G1Clm01lB1APsrQ7NLiHyfD3Qm6kjRRca9pUMTSFGoRVNnqJKki9
         vjvjOWLiZlibg85qb8JAH+Zk/dQ3GfYFN6b5aS3xXorYi7PaXzayi1r1qJGXdzpP+HxW
         u0UIfOzkgTrbmsRvB68PffEG4t5bTUjNEdiSvU+Nv+evNgMv+qST1vLSeg89rQyxTNWf
         jDkEKJxhUlpl4QI6Y5I5f1K+FL6YSjdPyWTpytOpJaVjN9syOdZrVgCCtdpT9/O0mBhw
         sbRb/EWcztQWLHec46C+pQvpXFg5kckGuaoyFa4f8IfnjvRXybUC8mqTtHR/KR/SZ6mY
         L1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419106; x=1786023906;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DooZteQHa6eWWZGFxr9TJH9KInviPRQxKqtAVgETm3U=;
        b=l+W4JVr+UX6DhZxfMOr1rgyIWVD34uYte1jNXjS2rPJXf4HrT+lJagnnN3Jql7GI1o
         q8zSoV27JjzrDmKr/B7XhdBOn9WZ/4G1PK0pw5IlTTqxJ2HpJoixWQCNagVPpMTfSABC
         XlItFAMkf7kkbETgUDgXwAveIu/22pQXYao+HWCU4dNgMmJn+rCMJ8dyYiv4hS5Q8DbM
         PaNDHM5pCKTvaJjq6uiJ1VAVqusSPXhp3RhRHvU0HDYpzr/BOBbDvbqYm4ZRdhgh1oLz
         Hzx3M/sSKHlsTQgdbWJmzqOurnQ/WOn6KnyaeV/F3JlzLzknm8fQvtb6sMg0IEOj5Qhv
         xEkg==
X-Forwarded-Encrypted: i=1; AHgh+RoV9ItsKOcOE0NpPchB8Ai3fdFVH2ai1x3GKpUiamsq24zpYEupyQ8UcTaFR9VBIjW2mTqXPdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtdUaXK885KClL2G3mLHyia12cbbF9Fqca7PCT+yL1jI46vyk
	K2cD4uSGI5uzDIBBRg8cioZdQqrn7fQU11b6zkWzjiq4W9F02yStUad8qzQebw1vmJjIZ1O8yM+
	/JEV+Lh8ML9TG0CicCM2MTmGvYy4ze2Y=
X-Gm-Gg: AR+sD11m5RCTOlcEVpE4s/A0zyT/YJFXMkbSYoN9yifpuKY0rSBR+gT6xA1rEy3gLgf
	WalEuFKjmIbGFxFsd27TizujZkY1iHdIHOeVQv+zXQT9lYOucCIqfHsbMELB7upb/Dlk468IFk1
	sjrhzxAUDoItOg1wRAu9CiOYAVLTWjis35nFRqsz7axijF0GPi/3TXahoaRCaGM01Vwhk2xD/9X
	7ynYoiE2Jbmywc1jzGzJV7kTgBeboIMqx5YsUIcyrnz+lICgzSJo/Y/xKaYPIoRC1EkW1Fl+PoU
	+LasLhc255QfWKbYLJJW0zQjORyYRdjTYy3uzPuIpMUTheh/emx754bMCjdWa695VB/xaZoffw=
	=
X-Received: by 2002:a05:6402:348a:b0:698:81d7:b812 with SMTP id
 4fb4d7f45d1cf-6a090d4e711mr170014a12.3.1785419105759; Thu, 30 Jul 2026
 06:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730085801.2068723-1-nicoyip.dev@gmail.com> <lkaqsnjtsfqbnlm456mxpq4k3hchwpmd4rnwydj2xektrnem7f@gwz5xjiduxfg>
In-Reply-To: <lkaqsnjtsfqbnlm456mxpq4k3hchwpmd4rnwydj2xektrnem7f@gwz5xjiduxfg>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 30 Jul 2026 21:44:54 +0800
X-Gm-Features: AUfX_mzQIuIsZgyj3bKZW58ZUjulPcZN3lMNMEWWAdVUByKDmN1gIKHVWbC3Qv4
Message-ID: <CAAo+4rW8f1MB3u4V=uHbw8RRex1=MKUY=kUQo=5zp83eR9S8pQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: fix use-after-free of file range info
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

The v2 is just sent, thanks for the review!

Best, Chengfeng
