Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC63CB910
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421131; cv=pass; b=k2W5k1XJZry/2CIUeO536Il9xl3psMHOJ46lUX86WwlhbU6Xzl0LniM5gP2vorM3QwIs6TAHDSXEunN60lYGrJKDYLQZpE8fUUFTV441G8tAot4BiG5NNOJk48n2ns5BFNs9B2Wn5EVzhYbs+I6o4NQ5QsXXewxbosE1o0qVcLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421131; c=relaxed/simple;
	bh=iPgtSJPnn2WLSAhBj9utiFu+5JnduVtlglZ5qvPeod0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnQvt8wpH9aUTNahSKzjOLVu+5Z/HnHN8ST8U9zjrFr7QxFIxOIic+rUqegZdhjK8q+jOWJNOCDqAhmXfp1dqVOV9RBUr/Ju3N4JDOyc/HWDmd06QKimyzl4VdAeB336lg6lRpEcqGlfwx5+sZFQoUK7fxCUXrt/9a0nKb9G5So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm4nah5x; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm4nah5x"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso27938475e9.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 10:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780421129; cv=none;
        d=google.com; s=arc-20240605;
        b=J1aX/rJH2R0X+1sfglmLedbRiLWqz/n+zZG89iIysDiogO5cNumPj28MkyDklKfv41
         sCUT1B3NnjB2ru8y3Z+wRw37mkYquI3LLvlQj8/JHbk4fghgY2WrBVsm9DGzrmdPBYjr
         fMNuArjsb/X2Hq9Tl6lcymfrI4bGMI9zszKL30ndDZJIujWmxWRxbBGGN0SpjNLZA/Ve
         xOdmq08Jz7Vrm1k2fG4gVSL8CzqwXpm+t2s1JABkM5Pz8xG/Tnbe/Qz052Q3KlEnCN++
         mZT0TRRAKOU32JL6XgTdVeYW1V1atImxxtjlXBq+XXroqQ0QExasr2bp/1X4n/R94h4F
         ASsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=keziT7iw7tOqjOgD7A8G8bVoF7lb6QaFK2jdA0hJANU=;
        fh=pk+pIJZfiqXmAOCWdGnbg9Nig+lOY+Libk0negs5+4o=;
        b=DyA9bj54ynRyCRCspNiyzGEdgmYIm3rs8abOIOMHWl0XTZxRzSWVEWHT5XPeWa0AKr
         wTFaYLm23HuDpkuwdW/kD322tynORuaB0oz9Fl2lS1OQ887cmFn6eRRhUJicsn9jOgw/
         XBfl58/aKR+uVdXG7Pxs4hz+F+7b4rESv89AyXT5R5ZnhQGutyfovON1re3NqK4Irzst
         9RPdIAQAjOOQUYX/SgkfbHWArKLQKi94VBU1p2xKkczwAtH78cYDff25aJ0DEB/QrT0Z
         65RG1+E+HapbRCZgq+3hIbcwlmgq/RM8EEj7yBXAUdBnfDPNz/3RXLrtYP1blcK/Q5AV
         rguw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780421129; x=1781025929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keziT7iw7tOqjOgD7A8G8bVoF7lb6QaFK2jdA0hJANU=;
        b=Pm4nah5xpa3wkF6ZJXN93iQqTajfLaLnk17Wng584ZfLw6yW2f6VU85r0ZzVvoybuZ
         2dJD4fh1H+b7lHO7w6te7uv3VKo+4FCfqg5bT8+82qF6qrUCEf8Ti4RZ+CMcghcbLJL5
         BILyClz6yTr+8oG5EEWCO4J43ISN3WJv/FTqYT2ojC0rQCmTStcvzSasC8s9GY41NRAG
         KqcIPjXkAmUvmMn1FP0v+FjoatKbdQld4fpVRy9AoIKgUqdFLBStTJXcEYU9wQtRK7sw
         bKztzsF7zm8dy2R9DOg0a8bDQDg2INgwRUiv5rB8zU/F0fXu2zoEL5H5WBcYOgZ05ylf
         HWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780421129; x=1781025929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=keziT7iw7tOqjOgD7A8G8bVoF7lb6QaFK2jdA0hJANU=;
        b=dpzjylOcZ7rCIuQgZOxELd4/BLohoPJYWLswEoVKAwGqbFRBWnIwQWZDvhUaKg72ua
         KhFryHiNdJLEtxZz8yGWdDGCxKTVwxIRUBxpgODEU96W8fWXLAOoEmQG4Q/SJVSWTZ+N
         i85utAKjLtsZUioy+bjRlgxzt02MenpLiVDng8t7TmlOngqm8oBpooLZpsHR+NEdWhL3
         TtnMyxnvn/kMT3nGzBEkJYp5t2hC56xwYziZaFzH01J7l5L2p8PqxPT/RjA5IVABQE6s
         FAGr8ohISIlLKenF8pgo+sXFJBqbN7mQ/n4v7Z+jqsEvqALrNVgeBVyX7IHk+rWPQKlq
         MRCQ==
X-Gm-Message-State: AOJu0YwSD2VFvUQR7k1AP1VHPg3ajBrlItOEkFex1fmriM+90AxTWLd6
	G5T9Vdo4YSeZDKABmwtuc1Csr5GuQmnGhHe7E2u52mffC3R6OuXeC/mxyFLfHG/NV967f0E/woh
	zS6/JdTYL8bSsEHeYHNiVKgxI3ePh+/4=
X-Gm-Gg: Acq92OHbcH+qwsL0j8jQixSaa+UiqRmMnmfvyc+7DFkNvJhGMtyw8KTypFK28XG7mYU
	jkxLO6jPd8SZf+xH6/7fhMyWiKRz+k1Egw2wB37WP8/9cRg9nt3AvYtKJQGl/5nUbN778O1Jt6q
	bLQdzIg45mL+6/DiGMDza9M/RE7zcFYPTTELmRC00TLMl3Coa4pgbbvPShrEmNx2zopnqRR2Sfl
	Ls5DQMvpogZbTsf6aKIf5XBQID3nwqb+irKz68eCJ0FkRG4EnGm8868Y6HpjaECnMjHKp/DAEm+
	LheXVqxXyoTKxRl8mVU=
X-Received: by 2002:a05:600c:5394:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-490b50b524cmr11269395e9.24.1780421128348; Tue, 02 Jun 2026
 10:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601180400.1381736-1-jt26wzz@gmail.com> <ah5pf25fhVH9WuU-@u94a>
 <ah56iBM2P_9hF3_L@u94a> <ah6dLESn8tHAtxS9@u94a>
In-Reply-To: <ah6dLESn8tHAtxS9@u94a>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Wed, 3 Jun 2026 01:25:15 +0800
X-Gm-Features: AVHnY4Jp20ELFLjNCl5evWNbTrIsnG4ugFKakTtRdkdRYG8va887rnwbiwM2mx4
Message-ID: <CALgi0X=qjiB756FnrYowor26sybA4z2jNCPrjieGcAA52KJS1w@mail.gmail.com>
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking fixes
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, tamird@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shung-Hsi,

Thanks, that makes sense.

I was mixing up two different things here: the BPF docs say not to add
"Cc: stable@vger.kernel.org" to the patch description as a stable tag, and
instead ask BPF maintainers to queue stable fixes. Cc'ing stable@ in the
email headers for awareness is separate. Thanks for pointing this out.

Thanks also for pointing out the 6.6.y requirement. I'll make sure v2 takes
the stable ordering requirement into account before targeting 6.1.y.

I ran the suggested checks with the same reproducer, where BAD means the
program ran and observed the unexpected error, and GOOD means no error was
observed:

- latest 6.6.y, v6.6.142 (924b4a879cbb): BAD
- bpf-next at b93c55b4932d: GOOD
- bpf-next with the d028f87517d6 JNE refinement reverted: still GOOD

So the issue still reproduces on the latest 6.6.y, but d028f87517d6 alone
does not explain why bpf-next passes. I'll do more narrowing and update the
candidate backport set accordingly.

I'm also happy to add a BPF selftest for this. I plan to send a v2 series
later this week.

BR,
Zhenzhong

Shung-Hsi Yu <shung-hsi.yu@suse.com>=E4=BA=8E2026=E5=B9=B46=E6=9C=882=E6=97=
=A5 =E5=91=A8=E4=BA=8C17:18=E5=86=99=E9=81=93=EF=BC=9A


On Tue, Jun 2, 2026 at 5:18=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> On Tue, Jun 02, 2026 at 02:42:35PM +0800, Shung-Hsi Yu wrote:
> > On Tue, Jun 02, 2026 at 01:47:01PM +0800, Shung-Hsi Yu wrote:
> > ...
> > > On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> > > > Hi BPF maintainers,
> > > >
> > > > This RFC backports two BPF verifier scalar range-tracking fixes to =
6.1.y.
> > > > The series is intended to fix a verifier state-pruning issue where =
an
> > > > impossible scalar path can be kept while the real success path is p=
runed.
> > > >
> > > > This is a verifier scalar range-tracking issue, not a helper-specif=
ic
> > > > issue.
> > > > The visible failure is that the verifier can prune the real success
> > > > continuation, which should not be skipped, and keep only an impossi=
ble one.
> > > ...
> > >
> > > This sounds somewhat similar to the issue fixed in "backport of itera=
tor
> > > and callback handling fixes" for stable 6.6[1] by @Eduard. Could you =
try
> > > to test on the latest stable 6.6.y as well at see if you can reproduc=
e
> > > the issue there?
> > ...
> >
> > My mistake, the reproducer you had doesn't use iterator or callback, so
> > probably not fixed in stable 6.6. I'll take a better look at this later
> > this week.
>
> Two more ideas beside testing on latest stable 6.6.
>
> 1. Can you try testing on bpf-next, but with commit d028f87517d6 'bpf:
>    make the verifier tracks the "not equal" for regs' reverted? My
>    concern is that it is possible that commit d028f87517d6 does not
>    address the root cause of incorrect state pruning here.
>
>    If the reproducer _fails_ to reproduce the issue even with commit
>    d028f87517d6 reverted, then it is possible that the root cause was
>    fixed by another commit further down the line.
>
> 2. Have you consider adding your reproducer into BPF selftests? Would be
>    very useful to have in stable (though it needs to first land in
>    bpf-next first).
>
> > > 1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmai=
l.com/
> > > 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules=
.html
