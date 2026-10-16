Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60D36215F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116438; cv=pass; b=EyM9SRFsSENpiJgPBwWAgDosKysvJnKSW0kX5FKMlkQ/378l5C8q1O3OF7DxfXamUapDY6NNp7xySduJlEIuE+s6jfnE9DRbugL+0VGgirTtnnpf8y2rcQJg4fkJSMXLILanZX6vyx5/YYkbpVpRZCUP0ZFxvV6Om/1Nv4wRqpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116438; c=relaxed/simple;
	bh=EX53AveEWvr1sInCjm4+XROj7u7dde7DD4tvWbj9anw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xv8WUdtxrFqjUA0YdR+vhltRizRy6FAjOFuFAfnRIXpC27ExA3HoSCrFayNSv6Kj8+aX+iPb8VbZDW8l6y92WTWJ/eZwyBmefLBuXhaVyGaT4aevjTT3EL+Byp9ChsLm/9dcz19RLvlxIVMmNNREIX29Y32jF/qeNOZoCG243N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=XJDCHo0Q; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="XJDCHo0Q"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48870973bddso295382f8f.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792116435; cv=none;
        d=google.com; s=arc-20260327;
        b=pbnE+ug0e/hJlv9W/K7L0zCyIJH46g9rDICWd+S1MgKMkvEm4AaUZvqwtXVJgXp4LG
         QZxiW2XKC3b9EQUAP+bUBS/VA3bjcefWzR/ZsCieVUj+W8uYdrPmNFnGLs0eCnXeBp/f
         Vuo13Dw1ksXPfFxCB2xq9E/CJoJfrBsCaZ5K+BLsfVL2GQeiD78B0R/wEkQzaPp4QlFk
         6TObc24Armk8RHui9PDckNOA06/CJHhyI2oST34/r5Bhs7ClinaWYSaE6D+tNfJb20bb
         GnHTFIiVar+AfHjQ/zLuLit3EL9ccVeLh//2TKI9qehvizei7keuw0YuCGgbsC2CKbFl
         FECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dmpL0BrIKQ9K1FnmJJsWfuTcm+ZME8/RBnTvxlPXWB4=;
        fh=GrkZZFt2CX0BK77mKgU3nMVv41+J4ZTobC0kSpmAH0w=;
        b=JexEcOuQWbCAuozvkkItb9kvTfpXlO7P6907OI31+tM3nwr4eeIS9/yGzZQsbe82wn
         IWTcke4a5JCRcKph7P9W7d6+TV7Y5mg1Qa23Ir6qd2iCKmeu5IaeH9nNN3td6rjc1xn7
         4yEhgMtnw7irjcTcRi8UPWhoGf4VSrRNVHsCfkzogjZbWMQIU2Ef04hfhQSqJ/jTyIEw
         tDdb8QiQeIMSDL0gO+HfnZ0Vpu5Qx1XTKebhp28dB3KbMOYv/tnooP42zWMlEfH5sqiZ
         9+luoiysiOmdngE2WpPxgrCzIq7CqQQqSAUCp79RRUnxVE7yDoMoVaEFs6hIVVfX26hb
         JNjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792116435; x=1792721235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dmpL0BrIKQ9K1FnmJJsWfuTcm+ZME8/RBnTvxlPXWB4=;
        b=XJDCHo0QM8yY1cuwMCGmz9kkBz8pHl24vMTwW+cGkRSEDrfTstYxpL85PtDZputANO
         8mCNlxhOqqWzRbwQRDlOx+fZfPeW5cPo2ReJX5FO9oacMCcPVdRyUnxBk+jhXvw53TUy
         u2uHuuSOH3hG3LNt5gzD1frxphSIRqWJBO/wiMZxRGj4iBxDOd8L7o6tLK1Rv6Jbnv7e
         NZMeOclG1BGNY3d8S7fTI0ZqmXP15G7QFy2OGSP2d58NCw7lYBnuZQHzbORqZeEHvqBS
         /0rspwkue+0iSa5jgKJOf5Kpb8DokNO2gHojfxhOcYohPUuAa+Q5SCPLZyqrfW+gZgct
         iELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116435; x=1792721235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmpL0BrIKQ9K1FnmJJsWfuTcm+ZME8/RBnTvxlPXWB4=;
        b=tJaYTa3ktdvT/GmnrHaieFDOiZNCnbiSmDDbDlrVAkeZzKukSSPN9DVtMliG6JFejI
         dyZdBwgGozGCuUtyVYa+90Yon7sz32RVzpeHNWv0hzrMynJ25VxBZ2r7sOjLYZyCN7YT
         GPCV1km0BkDQSUiTKuFD4ZtMhJFWcdFkCC+TRtzkwq5dq0gbjUnx2l/6Ud5umIFzuEK8
         nCB5opbD3Fdja/ewnFr5nDTVORNst171fwwGnljk5/H6u5WJQPznLlW1ekdFq53WO9R8
         hi+qDItk451/j47E3m+dr51ku4w89Xx9w6eX17G4UCp+TTrOdVXpLHnogD2nJlvjy5LB
         +V9w==
X-Gm-Message-State: AFq9FYKBkja4vYUTuTq5GTzfcmuzbYG8W4nMxUiLFakviaBosICukdwD
	oJ1rBs3WNROg1mlrG0YnsZck1YWUT6NjS8SdhKqchAfN0Gs9MjYgr2IE4yk9gFXqykF1WuQSHej
	pRtJ/cdku5/ogXwS260e1BgBbkzJ4KlLeG6MPtQMKow==
X-Gm-Gg: AYBFou1x3B8LL3MsKiyZaCHNZ2W1/4m3bm0t5pHj8V/rTcPnLOf6WvJbtkXkfRMWnmq
	0EI4Bqrckad/Kw90WVsk5rJYfHz3oTguiJtTk/xEGVmoI2rxk5kK2q2GvZwOVFobwrh8vfQzInV
	R1aG4JsLV6r8S0quSeOE7HeXEgtokdGjjSg6IsdQxRYT5On4CwY7lxlx/v5IXRhjipRtYwnJGtV
	NZp7B6Q+rNFlpk9R8hoyMeTK+HiBRn+DoqrJD0jOyl0IWFR0CnUPa1n9m/pUzJbkt7bNCFfmm7L
	3uIatwlWMacGyzihrZ3zCrLfPBco/Z1kKKHNNOAzGPA12W+L6PMBlxIc6xH4R9zBB215QQ1Y6bI
	tea88L2mmBDhvmuQsBiJR1pZeIo1eJqnken73o0pNkVtryDXT8P0ZTWk=
X-Received: by 2002:a05:6000:26cc:b0:48d:fbd8:d598 with SMTP id
 ffacd0b85a97d-48dfbd8d5afmr3401253f8f.17.1792116434934; Thu, 15 Oct 2026
 19:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008192048.98833-1-artem@trailofbits.com> <askqkXhBORyXr-v9@mit.edu>
 <CAP3zxaC92rwQNCpuK_tXR9THQOecVoZwxg8ZUgYt=0iKiMsuxg@mail.gmail.com>
 <asrNX2qBf5qBrFLu@mit.edu> <CAP3zxaD3-QYqe588XGxzTrgAnK4OQC4aRfbea1Ln452mM45KBQ@mail.gmail.com>
In-Reply-To: <CAP3zxaD3-QYqe588XGxzTrgAnK4OQC4aRfbea1Ln452mM45KBQ@mail.gmail.com>
From: Artem Dinaburg <artem@trailofbits.com>
Date: Thu, 15 Oct 2026 22:06:38 -0400
X-Gm-Features: AclHuK8inf3GXwIZ-Bnc-vk5hfu4ep2ADhdtdND_LhDfQfWlLsaqaWOgE0fQ0CA
Message-ID: <CAP3zxaAP-AunA+DTq+x1uoHBZT13TBxtUxm704OKZ3ikWUSTNQ@mail.gmail.com>
Subject: Re: [PATCH 6.6.y 0/2] jbd2: backport CVE-2026-89566, CVE-2026-89567
To: Theodore Tso <tytso@mit.edu>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Max Kellermann <max.kellermann@ionos.com>, 
	Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ted,

A quick update on generic/045:
we ran it another 200 times on each kernel in each of ext4/4k and ext4/1k.
All 800 runs passed:

                  Unpatched       With the jbd2 series
  ext4/4k         200/200 passed   200/200 passed
  ext4/1k         200/200 passed   200/200 passed

We kept the same kernel configuration and QEMU setup, with a fresh
guest and test disks for every run.

We also reviewed the kernel logs from both earlier generic/045
failures, passing runs, and all 800 new runs. During the test they
show only the shutdown and journal-abort messages that it deliberately
triggers, with no additional warning or stack trace at the failures.

Both failed tests reported files with nonzero size but no extents.
The logs do not explain why, and neither failure recurred in the
200 additional runs on each kernel. The earlier ext4/1k failure
occurred during the full suite, so running the test alone may miss
an interaction with earlier tests.

Thanks,
Artem Dinaburg

On Thu, Oct 15, 2026 at 4:01=E2=80=AFPM Artem Dinaburg <artem@trailofbits.c=
om> wrote:
>
> Hi Ted,
>
> > Note that some tests can be flaky. So when you see a test failure, it
> > can be useful to run a test multiple times
>
> Thanks for the advice. We are still working through the testing and
> wanted to send you a progress update.
>
> We have completed three full iterations of
> ext4/all,xfs/4k,btrfs/4k -g auto on the same unpatched 6.6.159-rc1
> baseline (72bada21be7b), followed by one full iteration with the
> submitted two-patch jbd2 series.
>
> We used QEMU/KVM with fresh guest and test disks for each
> configuration.
>
> Following your suggestion, we also completed ten focused trials on
> each kernel for 21 suspect configuration/test pairs: 420 trials in
> total. Each trial used a separately booted guest and fresh disks.
>
> In those ten runs on each kernel, we observed the following flaky
> tests. Counts below are failures out of ten, unpatched / patched:
>
> Flaky on both kernels:
>
>   btrfs/4k btrfs/028: 3 / 3
>   btrfs/4k btrfs/192: 7 / 6
>   btrfs/4k generic/449: 4 / 7
>   ext4/1k generic/051: 3 / 5
>   ext4/1k generic/388: 2 / 3
>   ext4/1k generic/475: 5 / 3
>   ext4/adv generic/455: 5 / 5
>   ext4/adv generic/482: 4 / 2
>   ext4/ext3 generic/388: 8 / 9
>
> Flaky on the unpatched kernel only:
>
>   ext4/bigalloc_4k generic/320: 2 / 0
>
> Flaky on the patched kernel only:
>
>   ext4/4k generic/045: 0 / 1
>
> We are now running 200 additional iterations of generic/045 on each
> kernel in each of ext4/4k and ext4/1k. Ten runs leave wide confidence
> intervals: a rare failure could easily have been missed on the
> unpatched kernel. The additional runs will let us estimate failure
> rates and their 95% confidence intervals to assess whether the test
> fails more often on the patched kernel. We will finish all planned
> runs before comparing the results.
>
>
> Thanks,
> Artem Dinaburg
>
> On Sat, Oct 10, 2026 at 7:54=E2=80=AFPM Theodore Tso <tytso@mit.edu> wrot=
e:
> >
> > On Sat, Oct 10, 2026 at 06:12:10PM -0500, Artem Dinaburg wrote:
> > >
> > > Our initial unpatched/patched runs showed some differences in both
> > > directions. We cannot yet attribute those to the series, so we have
> > > paused the patched comparison and are running three complete
> > > iterations on the same unpatched baseline to assess repeatability.
> >
> > Note that some tests can be flaky.  So when you see a test failure, it
> > can be useful to run a test multiple times, so you can see if the test
> > is a reliable hard failure, or one that only fails, say, 30% of the
> > time.  So to run generic/363 10 times in the ext4/1k configuration,
> > you might do soemthing like this:
> >
> >    kvm-xfstests -c ext4/1k generic/363 -C 10
> >
> >                                                 - Ted
> >
