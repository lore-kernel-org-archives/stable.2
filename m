Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9AF53B60B
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190960; cv=pass; b=jRHwAdc/s75XXq6eFVcm5gKhMP3UkJkLOR0p76kNh/i8emDvOkik4+YI5/hICh8DWWtwfFODSXpjjG0i25MoIkjNT/MIM8WcO4FW41U/L8thsNkQYNUnziI/dFoHfl+RcoDbMHNuMaPd/rJSla7x8q2E/6a8GgG7rp6lSM/Rpcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190960; c=relaxed/simple;
	bh=1fO+H3CaJeix86W//NLHqNy5lAb7mvgci32QvoqP3J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIr4wp7nETi+8BOTV3FGoved+N7xhTWVTlWa+oJz4wa6r7DBZSgbYZdFaah2vQdeNfK+5zvfLrDfgmWz+sUxH25z//HSRffeUHfeE3EyOSF+9DTulZWi7zUEoPeHasa7FqcPgafa9CUixlgqE8GpV9GlBX0ISlubkXwtv/7mNIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqU0tMh+; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqU0tMh+"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43db0c17so22460597b3.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 12:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790190958; cv=none;
        d=google.com; s=arc-20260327;
        b=msLyZnOdYV6+Prbkd6Rk6MZLgkSm19Eowqn0+MYxuyjPiqqNUQl6qhUN+Goh1+Wh9s
         EQX7DrRQWo/bOZoARRdOTtjdVE3VxTuAhdP+A5Qgd8sPe1D0eldPf8uFh+kqPDwy9hlz
         T68iM3K8MuB0UkO5dvLT4qoJikeU0OlM4rF7OopXlphyw6Fxmm6C9mBjHOkE/oprYjSH
         CLpEmRUO0F4rHTPP7HR0FopcuN+NB4Ot/+21RqzkjTZu64XcNwWr/ePiZDA8fXwO1S+V
         /TTq0cxgeFM1G0RctE0HyIlMbQR17ilRaZnwGNZv0j4P+3ORikWHv/kurCK77BlaZ3GK
         WTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZVj1AAbZ6yw4i1ZgIrqEGNJhPbwd8yPIZklKAdOq/PA=;
        fh=y2yBiBw87vpDzD+21RpINIAB2q4kVbiQb1d7I4+pJSY=;
        b=DMsrAZjA2S0F9qIFDjHXtoO8gNXtMYSRXJqSeYV2AFq2C1nPUXI8nydd8NvmSuEX8i
         KG0eRMaO97bZa6mnh4P5hfPXiJpeYXrAJEszHNbKb7Q2Owta87vjuUxNwBqjzYTIKf0F
         myOg+AA8dg+7VDXDHkbIYMgOCVhw/4lvLtiSrXwp9/b1MYUSNf39yipcC2hNQZkJYuyd
         WCHyhOjmlFcKLqyk/D/JDKxsTRcCLjPH+McqWs9qTxkRaBZzHSKf1ji8MA0DnxJZynoF
         0gHMZCxBxWgHkxg5aoiVgqabDIYoOPGJUD0p0gvgn4n3PsyZgRm+T0OcaLKqb9gduteS
         Cz5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190958; x=1790795758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZVj1AAbZ6yw4i1ZgIrqEGNJhPbwd8yPIZklKAdOq/PA=;
        b=HqU0tMh+ouNwqsekAmGMUtU0Vk0cY7pg8vTvuRloWikvxQevbHNHYrmibaMACACoCW
         C/0/mSD5w27pZr5lT7zFOa/p+NKAbnCynY/49zs6QMEzTY76KIJ1K0DgOyylcWr4Cimo
         DR0IRqZoVFua3BuDZpQoXzAuJW0Tgc2PpORszUJ6Su3YGuIA2msrvSIqcA5HWtJBpmfw
         zx+fSmH9TQobwO0M1VYM9As/eGIq4oTff9I6MLuCwIeDPbsstSECYzBr75FYJ0YeEGnT
         +LcoJzrPs9VMZ4GzH4x/QgTlmzz/JnyFxMicqOM10NCe4zEHX5AztZrrSrItlWok9Il5
         OJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190958; x=1790795758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVj1AAbZ6yw4i1ZgIrqEGNJhPbwd8yPIZklKAdOq/PA=;
        b=VeWLmjbhY4L0bPlOvh/0M/l083zWW+af07OeB7aKjLQrJgndU/y4kx1dfDgiDraFtM
         +fz6xgkgt1nONdnmjS/CrYjCk3RRm5Pry2iBl3SJLDbJmWxO+NbK2kN0qUM4j7IQ/H+r
         o+q3XXcH0euR34lNDwwRwdy4ceW04OB4Ix/GhNYZ0EF46+XeqkMqiwdqSV3ueMNhidVK
         nngnLbeyyn2eGY3TyV8nAKvPxsUmhf00a/oLMRaTlhAbLbYI4hmkxYaP1fr59CAKhK09
         w0Mphwszg09H0YoDvhW8u+sEHXfFpqlc1tQIJjcsqiUITUDTS4Yr6bmm720+zVn8BAGQ
         CWPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1WaKQEskrGGCW1FnwvWWj3MWxvJEqkY3tm4V9yIB7Hk+RNO2dCqYm53awOzv/P7vQa3z8stE=@vger.kernel.org
X-Gm-Message-State: AFuF++mMeAXODffVnaQ+virLOw3hmPklVzZJxCgjRT8ny/TNhioO2MY5
	7kYhLAHIG4n8O+rHDUywhbTN8mosTkW2RU7/vc1Xz1SnG41nuaAgGJvrK5C7tbmp/PmkYfbtDEL
	Z2WpnDpDqv9Jsu2d5LfTpb/BAIv5hGDk=
X-Gm-Gg: AYBFou05vL9E7LWiwnk8y8ae0tnQ+3LAtl3QZsdab6H2bANa4dkPCStO2KJ1AMHMrK/
	CY1ZZCMiJwEcYuZFxFObwEtJcZZOYGKHG6BbvTE/aEOKKooDvsGC/1flwPZgfInYSac18mtsJxB
	Iuaf2pG4QIVEdkew9w0pSIieJan/LxbCcFZtq1y+ts0/V5Cm/sP3fFFN9OoHdjOZIqHNdBRhPac
	USR/R+7X4i4SbAh9mv1U69W4s3mdUgV5jNnrIc6q6mvMFBk7jYYBQS9tZ7x3eRy/4aukBHysLBH
	8au/GdeXUdEED0eUON3kjCQno6PCWiTLL6YoEHpE8Okx/qAbr8wdr+U86gQHZZzLYQ==
X-Received: by 2002:a05:690c:6610:b0:873:17c9:b054 with SMTP id
 00721157ae682-8a648505a0dmr1055207b3.21.1790190958227; Wed, 23 Sep 2026
 12:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922215849.16739-1-vladan.kalaba@gmail.com> <arN08yVxjhAAyZ4S@stanley.mountain>
In-Reply-To: <arN08yVxjhAAyZ4S@stanley.mountain>
From: Vladan Kalaba <vladan.kalaba@gmail.com>
Date: Wed, 23 Sep 2026 22:15:45 +0300
X-Gm-Features: AclHuK9JgAQsoEghJsGDXhi9vPLNpnYzGw31sUj4uH2GUgZlNk-AGNv2A8t4vO8
Message-ID: <CAMfJq18GfekJgaCi7uOT9MazN+_scyCHfOjC3o_umzJzmZPMBA@mail.gmail.com>
Subject: Re: [PATCH] staging: axis-fifo: fix integer underflow in tx_fifo_depth
To: Dan Carpenter <error27@gmail.com>
Cc: gregkh@linuxfoundation.org, ovidiu.panait.oss@gmail.com, 
	gustavopiazdasilva2102@gmail.com, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 9:43=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Tue, Sep 22, 2026 at 11:58:48PM +0200, Vladan Kalaba wrote:
> > Fix integer underflow if tx_fifo_depth < 4 in axis-fifo.c due
> > to check in axis_fifo_write() subtracting 4.
> >
> > Fixes: 52ff2b840bc7 ("staging: axis-fifo: fix maximum TX packet length =
check")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vladan Kalaba <vladan.kalaba@gmail.com>
> > ---
>
> This has been sent a number of times before.  The information comes
> from device tree and we trust the device tree.
>
> regards,
> dan carpenter
>
Hi Dan,
Thanks for letting me know, I will keep that in mind in future.

Sincerely,
Vladan
