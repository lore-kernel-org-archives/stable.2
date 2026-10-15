Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D542E42C
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094541; cv=pass; b=ofHmCKAcJ9KD3a/jQ7/cC+uAsnVVVt0HjdA/YceBW+HblNXzj/6wIXXLnv2ufIM3ZT6ubNDFojlIeKKXfvnQxB8oSS5uBvOw+QWY3OQvTwweK4Y2rg6GEjuXcPV4XVxmEwO0Q88F1MlkQJ9nuSzel3cqKoxQBnzfJ1ZeGjv01Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094541; c=relaxed/simple;
	bh=mTPvvAdIxgOtHuBEpEFyNQt8LStAshIksTq74xqzhRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd6ZC9sW7Dek6MaGOxrsWwxjBQhOtFx7roHCiSkYzuPX0bBIv3/2Po+4p5F648pmjR1ROTiHn4Du5+dA0OfAoEP6O+IQJ8v5Q81WHshZK3G0ZY0xnkpVxQySAensohBgfJgJ2Dr8u1neS1F12yfdeUYPdlPwF7poAALytYGujCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=J6tqORvj; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="J6tqORvj"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df4f540ebso685808f8f.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792094538; cv=none;
        d=google.com; s=arc-20260327;
        b=ZH6op+TxZSmDylmS9L9TU1od54wjKTcZCgOACO/AnVCO2Bfi+QKrGzPc3OtSMk/dfr
         R4POj1gZBPoKuyEQSeBTpdh+NsjYnTAXrOb1ee3Ho3xmvkr5Uprkg0fcsskfGwn0PAKs
         XtxydS3yRM/ICBCsGVqwWtCo+G8nf0fy7YdgsC0jypDqzgakn49IRipRmBfSRc2E1mtz
         5te48a6xA7SJ1Bh9X4E0F3qoH4LjaccoFoWGezw/S+gzakdeHzmmkMLCvLSGYQzkAWsZ
         T8lOe3Igvg8sNV05njYoWUhkTPYE58NgBA+GB8D71JVLwdYph5s8vI4TqAfp7duTL6Ki
         rhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=adFghwGxsnRj3hxYZf8a4TwNZCzfV6GnTk1GcsiUceg=;
        fh=GrkZZFt2CX0BK77mKgU3nMVv41+J4ZTobC0kSpmAH0w=;
        b=RZbrtLltgdY9bUOMo0iSXz9pwDG1CX7xQd0L4/yVKzRowJjqamCppTlYKtlr7ugLqS
         8rcVNNwsQ5SmcEIm8QMRf6XFGJJb0gyWX0J+TJf9SaQiVbBtEYsvy/G/yGBdZvAn8CLX
         9M/z1CRlza6CasXbHGgAnYgWQNLTX+FK/GrN37a36wQ4yHXIbMaLEliTAp3keEiXX78X
         gZsLVFCpzfeStaeuQ/Wbw6NR2xNrPNSVNV80d2lU/t8uAHDH+WnnOgDCayOqvhVMKqwa
         K3F9Qbu4I88rdmYTwNz2udZKun9I4eUa4/cE5tXsnXFriX01v77qG4+/KUciGhMVLBXS
         VIKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792094538; x=1792699338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=adFghwGxsnRj3hxYZf8a4TwNZCzfV6GnTk1GcsiUceg=;
        b=J6tqORvjRuFkEkkGRW/2LhUoSr3JqMvg9Fg+4R6PXROwZ/ey/9K3hnFRKuH6BlyuaO
         6ndrOb40SHg0/bR7Hhl8I4CB9UHTvSh6t1GZT7oTU7j6bJkmb4nsg2m6Ydgghckt350w
         EGiyldwcAVUCimvFv7FHdpzwBV8EafymP4TSA+8Y9NHPPxdPk9dpujAsgDRWgJcR79zQ
         I6/xF9PK0B54QpcY2W7ZMuFuk8o04TQjeZ8rNfgdI5w60T/5gujFXfpfY0txIejuAhpU
         OM73573QKnsIxRbYpE5hzvvEFpIpqODEIuHQgoAC3LpBEEekPcdkrdWsCAz8QzasjRdV
         FkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094538; x=1792699338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adFghwGxsnRj3hxYZf8a4TwNZCzfV6GnTk1GcsiUceg=;
        b=E2PsmAERlzVCGW0Xu3LRCFhOwYem83XVEmZM7y4SHmk9NPPMfiMLYQTLzcE6AmI9g5
         DZ5W9egdZkLJU2ewF+yh+ia9mF5t34Ac6pTRio7ofeAwcUYjKYPt/RgY7TDu7OiWLFt9
         pTAbj2+LRpSzcLyOQPvQpbMkGvKaUUpdwc0QzIzmihsUNByaNf5/ESeaNAi3rjtWzFQU
         PvMHOypt52J65hsFyTH7u9I0bOl6NYzjJnClePVAJPr3lkpUlaHSNt+cHxiuPUJr2OOP
         R8oBoo8fEvf+DQplh2xKgRet+B7InpXIaTc0lSAL/4KBzO+SRkoXxRRlBws3uexl557K
         NNKg==
X-Gm-Message-State: AFq9FYJUKolP/nzcYGH5fJhfW3ZmrO1vXio/ZixelTEuOUUfBJqnRgIr
	cK2xEHDx57WICj1BKjNTuj5B/QF+58BIBFvy6hpaL4o8VK2kFh8Ut+7ewsr0yPHHPOB0HxNzTmT
	bru4blhxDUbKLreWqgwlRZy44jIUjoFuPkYBm9hJrDw==
X-Gm-Gg: AYBFou0ni9MXcwqqjX1Bzxx+gs1IlRJscSz70m4UFOfX20N0Umk3iW3QpgsZJA7KqBq
	bbQ9OoM9FpP9J3bigp73J+JU6orI3VMhh+8nXKEevZ4dGFG5R0gJorM2v/3AnbmucCV0iHhGcAO
	bNYqhZiHQr83DUo4Zq8HaCJ5mugfmgpK5KeG2MWc3iPDawv2ViC2pXIco1MxPU3Hk9K9Ez7xzHK
	8f/mDj/E1/s7LaJBtQA/uDA7EVHx+WVxoz3EYU2/+47hNKDyvEyWe7OTZVBy38kMbnvaFdpK9x2
	GaSICU2QAJc5tzQbWGmpYlwRMaDfd15zRz6y0o1XUz23r9Au/MhgSbnW0SpSlK7roJPcqcmhFCo
	4pEsueRa+dfP1nu6Cllx/YKuSGxloKRHhiBjr0ccL0v/14A==
X-Received: by 2002:a05:6000:987:b0:488:7787:469d with SMTP id
 ffacd0b85a97d-48df14ed887mr9923470f8f.25.1792094538039; Thu, 15 Oct 2026
 13:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008192048.98833-1-artem@trailofbits.com> <askqkXhBORyXr-v9@mit.edu>
 <CAP3zxaC92rwQNCpuK_tXR9THQOecVoZwxg8ZUgYt=0iKiMsuxg@mail.gmail.com> <asrNX2qBf5qBrFLu@mit.edu>
In-Reply-To: <asrNX2qBf5qBrFLu@mit.edu>
From: Artem Dinaburg <artem@trailofbits.com>
Date: Thu, 15 Oct 2026 16:01:42 -0400
X-Gm-Features: AclHuK9tJDFa3d3xJEx_0hqszb3wpW9Z8si-SJpf2vKpIgukHzjFNUgs2VdIVxA
Message-ID: <CAP3zxaD3-QYqe588XGxzTrgAnK4OQC4aRfbea1Ln452mM45KBQ@mail.gmail.com>
Subject: Re: [PATCH 6.6.y 0/2] jbd2: backport CVE-2026-89566, CVE-2026-89567
To: Theodore Tso <tytso@mit.edu>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Max Kellermann <max.kellermann@ionos.com>, 
	Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ted,

> Note that some tests can be flaky. So when you see a test failure, it
> can be useful to run a test multiple times

Thanks for the advice. We are still working through the testing and
wanted to send you a progress update.

We have completed three full iterations of
ext4/all,xfs/4k,btrfs/4k -g auto on the same unpatched 6.6.159-rc1
baseline (72bada21be7b), followed by one full iteration with the
submitted two-patch jbd2 series.

We used QEMU/KVM with fresh guest and test disks for each
configuration.

Following your suggestion, we also completed ten focused trials on
each kernel for 21 suspect configuration/test pairs: 420 trials in
total. Each trial used a separately booted guest and fresh disks.

In those ten runs on each kernel, we observed the following flaky
tests. Counts below are failures out of ten, unpatched / patched:

Flaky on both kernels:

  btrfs/4k btrfs/028: 3 / 3
  btrfs/4k btrfs/192: 7 / 6
  btrfs/4k generic/449: 4 / 7
  ext4/1k generic/051: 3 / 5
  ext4/1k generic/388: 2 / 3
  ext4/1k generic/475: 5 / 3
  ext4/adv generic/455: 5 / 5
  ext4/adv generic/482: 4 / 2
  ext4/ext3 generic/388: 8 / 9

Flaky on the unpatched kernel only:

  ext4/bigalloc_4k generic/320: 2 / 0

Flaky on the patched kernel only:

  ext4/4k generic/045: 0 / 1

We are now running 200 additional iterations of generic/045 on each
kernel in each of ext4/4k and ext4/1k. Ten runs leave wide confidence
intervals: a rare failure could easily have been missed on the
unpatched kernel. The additional runs will let us estimate failure
rates and their 95% confidence intervals to assess whether the test
fails more often on the patched kernel. We will finish all planned
runs before comparing the results.


Thanks,
Artem Dinaburg

On Sat, Oct 10, 2026 at 7:54=E2=80=AFPM Theodore Tso <tytso@mit.edu> wrote:
>
> On Sat, Oct 10, 2026 at 06:12:10PM -0500, Artem Dinaburg wrote:
> >
> > Our initial unpatched/patched runs showed some differences in both
> > directions. We cannot yet attribute those to the series, so we have
> > paused the patched comparison and are running three complete
> > iterations on the same unpatched baseline to assess repeatability.
>
> Note that some tests can be flaky.  So when you see a test failure, it
> can be useful to run a test multiple times, so you can see if the test
> is a reliable hard failure, or one that only fails, say, 30% of the
> time.  So to run generic/363 10 times in the ext4/1k configuration,
> you might do soemthing like this:
>
>    kvm-xfstests -c ext4/1k generic/363 -C 10
>
>                                                 - Ted
>
