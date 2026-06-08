Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905123D3321
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944847; cv=pass; b=RcLjs0dsZDzvnuTCZ1PTCpMblUuWVwyzVuop45hIyW08OOAqiF8P1UbezEL/SJ3Jp8RUbclSRURFHt5caQOgxzOJ9Bt4a3WGGzhAgo4U/Bodww/tSKtWpTAyuhl5X7rwJO314Xn/9uJCRKRSOL2HGH79wB2tya68WV7XoU1+ATA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944847; c=relaxed/simple;
	bh=7j/39w5zlEu65/nVwL81VQqiOlCjTXCrIWFh3wNBTKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGGfhA2rRwG+x1Yo7hzn/UkdLezBv1Aisk8P+jtexLIiwqbHAGw7kuLyewMJSEIW0nb+lVYDa28YnxvSZY0zxQQCkQVjRfK9wdQpe1AJWBoFghDlCSypQGofLH4pn5VSSkESGURaP6PjZAtvqX8rsApCMoqUCCuug95FxPd6/KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLtj+dfF; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLtj+dfF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef616daf6so4262379f8f.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 11:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780944843; cv=none;
        d=google.com; s=arc-20240605;
        b=UXyhVxFDCMNsRXYqGCUbogNBCvqc+UVURP7DGO4PtdA9zn2ZTs0uYn+XN51XyuIJlo
         UWpZsI2Pnvg6QdFyVe8GW+DoraWBxWaga3WvLrXwrSPzyg1kMsQNMrPwGaImTnrd0x8+
         kmGB5B5/CTXuly/ksHFNDXTSO2GAqEYp4JlGl/uQ/Jxtbu196PxwejBL1BNEr13uJST7
         3Kp68WDYytwzf/uOtXrE88QdPcJ5SxpF1dtY5HKQbGzPwiEBV78T14xweJn5Sn7pRVhS
         UyHaz/vRO22ghjbgL+6hAurWsRv6VFu+q0i9kCpAY3g+ZsNsFeqcg0P5hu5k1ybbP/EM
         /O3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7j/39w5zlEu65/nVwL81VQqiOlCjTXCrIWFh3wNBTKw=;
        fh=MIMupFTNZBV8GiY+morJX2R/yLwIsME1A6WomEbPq1Q=;
        b=JV0oe2NDT9gl+AQuRFfF7u6ldXATvfQjxJKEwVl/sqDGEeJmUpYuz+uzyJeWquVdkZ
         2O9p+V95/QiDDWdp02KDT1xQy92X7n9XJh6eqn5MGr6O6S3yP4S5A4EnSrVxp4iVLGTd
         V4n2qyIakdcRfOcE2Vgpyacd59FvXyX7nXjxf5bCkfbLMvpYrMHwBlTn/rmkVzWUIUG2
         3J83ceef4L7UXpMYemAds99x1iU51wAPBTbsMtkAXwDZ1YoeIL9Tij+CrFFThjZKdDo1
         9A4lpBw/cQOT4eYoZ+nINeE8BcNZOVF31hnTt+PwGnsZKEvSGmE/TxAvUUrZVNRW7Ohi
         X3bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780944843; x=1781549643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j/39w5zlEu65/nVwL81VQqiOlCjTXCrIWFh3wNBTKw=;
        b=gLtj+dfFG+/ZMF/9zYAn9S0K4RORfhwuvIiWquFd8ztSITgWhGB1UVbj3ta4wATZPf
         /r1fpc01v++JIaNRJkyKpsQ9jYfdAP1ypIkM4TJpEDjq6mDY/LnoGTgZ0A5WLEr6t3rU
         kD5W9uX7a+4gn6hA4RqdsvMc2yLgrGkDJe80Akfu0Jc8LXsi+2TYBCBP/Xqh/MlhYdJb
         aMvCZ6HRVZL72WYiGRUUyosdS24erYvSU5EJ6fBhQBakfMoRKSu/tiauJ9Rrtrd2YZip
         /WJe9xECJZ5bszwYxX6q/8UJmpypkXwye34DKem+/vTbZUOAUeNpHj8vQ2eRnh9Hwuu2
         VRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944843; x=1781549643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7j/39w5zlEu65/nVwL81VQqiOlCjTXCrIWFh3wNBTKw=;
        b=gv8KLeEATVAifhjis2k7wqKnsyKNafQFsFb9UQQScgMQYmmQ+FIQowXGgc8tzkYw86
         zhrB4o0x9yYT2JWx1ihDsZxQQWBqqqGSUGzrSP0eHVvO0mGH/RCuZzkd8yPUgT/4t64H
         tam5q1boubwSXB337MUrypynhRTnc2ZQmmoAbIpD+LvpD1dJqGVcLS6t9UZDkhUKlWL0
         9ArDKRYvd01EU8pCPSKQiPrzMCK91fgFeGDGV+tCVBI1nbK0H8nlnt3g4Sh6bBep/Q2r
         aR7W3Q4pvlfqNnuMp0S5lElq7hsnS9PLUoBvQ6m2JpL7vW12EoxT6NrOHgdOuomFXHRp
         ocXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/aEJTX3P3zW5yVAM7HW0HxI+dQPCcHXh0ot8mNVswVXXNS4Mu3ZeQiI6QPtqY7eA6y6VjrdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI54auwt2xpExZ7gq9b/s79pJECJHFJfoHhdsDd3dqoCjLcWwa
	VR53Ivpd9C4FHYoOPUNPvZTauLc+IPivTEz0x/lbtFy54KNtfse2JHCll7G/hHD3lOz6rlpV3da
	Mx88yjNwN+aSa3R77ilm1NTwzuPaPnCk=
X-Gm-Gg: Acq92OHtmvIbrfQhIIoXDGxBFqR5LBF6evT4RSQ+NAb6uxjMcM/JTl1MYRIt7ZiWUe9
	91tYfYVXJUJ5Y98LsfzTZu9RVslLnbipIpsQux70tSrkvv0IXhV48bIM40eoEtqUmCOXi1m16EJ
	Ztbw24165bJL5F1LWfjV/hKfAL02Qij5T0JVOtVQ866P+8++qcRnNRuzb4RWib9wuTl5OOiWEA2
	/51uicCdbgSmw+kN8XHHN1wHKiKtp6UVmJds36I6N1l/Ir2Q98pUR56kHxBDfKSyRHHj+sPf9xg
	b4Vh24+aX7upUKTU
X-Received: by 2002:a5d:4712:0:b0:441:1e41:194 with SMTP id
 ffacd0b85a97d-460302eca25mr18499330f8f.17.1780944843186; Mon, 08 Jun 2026
 11:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605192708.141921-1-joannelkoong@gmail.com>
 <20260605192708.141921-4-joannelkoong@gmail.com> <058fd2d4-3ba4-46e5-9107-3a7e0ab66653@bsbernd.com>
 <CAJnrk1YHQEtpwA-ForFWXsLntc950ekqAHg=L9VExVfJ2WF1Rw@mail.gmail.com>
 <742e68e6-c456-4655-a441-aaa8267f1a48@bsbernd.com> <CAJnrk1bz=BHryaWkZ0uBCpzLoVM-FSsb4mhA8F7+fnMQ4Tt_YQ@mail.gmail.com>
 <57fdff56-6a4b-4bbd-b191-d63b82a14509@bsbernd.com> <CAJnrk1b4S3EUb-FzrvojC2Lp-DOD1GZEpvEKEMKhPpZbf+sqLQ@mail.gmail.com>
In-Reply-To: <CAJnrk1b4S3EUb-FzrvojC2Lp-DOD1GZEpvEKEMKhPpZbf+sqLQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 8 Jun 2026 11:53:51 -0700
X-Gm-Features: AVVi8CdDFuKrlVaJlTazwHovScoR_I_5UkB_wB_OsNcZsV3y6VrpqIUFwPF_04M
Message-ID: <CAJnrk1akASWprt4VpS6uB63pKqf4WuKq+nTBQ-v75KfLi1Na+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] fuse: end fuse_req on io-uring cancel task work
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, Chris Mason <clm@meta.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 11:35=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Jun 8, 2026 at 10:16=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com=
> wrote:
> >
> >
> > On 6/8/26 18:46, Joanne Koong wrote:
> > > On Sat, Jun 6, 2026 at 12:41=E2=80=AFAM Bernd Schubert <bernd@bsbernd=
.com> wrote:
> > >>
> > >>
> > >> I do not think we need 3/3 at all.
> > >
> > > I think this is needed for the cases where tw.cancel occurs without a
> > > subsequent fuse abort, else the application syscall thread is stuck
> > > uninterruptibly in D-state in request_wait_answer() for the
> > > connection's lifetime. tw.cancel with a fuse abort is the common case=
,
> > > but I think unfortunately we also need to handle the case where this
> > > doesn't occur.
> >
> >
> > I see, the initial code was using IO_URING_F_TASK_DEAD and I had wrongl=
y
> > assumed that is related to PF_EXITING.
> > Well, I think the fix is clear, although I personally do not like the
> > exit code dup (or better triple)
> > https://lore.kernel.org/r/20260515045541.1171335-4-joannelkoong@gmail.c=
om
> >
> > In my option fuse_uring_cancel() and canceled fuse_uring_send_in_task()
> > should go through fuse_uring_entry_teardown().
> >
>
> I don't feel strongly about this. On cancel, the ent becomes useless
> since cancel consumes the cmd, so imo it makes sense to just free and
> clean up the ent immediately instead of keeping it around until the
> fuse connection gets eventually aborted, but I don't think it really
> matters. Happy to go with what you prefer.

This fix (as well as [1]) needs to be backported to stable so I think
it'd be better to keep the fix as minimal as possible and do any
entry_teardown deduping as a follow-up cleanup after that. I'll send
out a v2 that fixes it minimally.

Thanks,
Joanne

[1] https://lore.kernel.org/fuse-devel/20260516021138.2759874-4-joannelkoon=
g@gmail.com/

>
> Thanks,
> Joanne
>
> >
> > Thanks,
> > Bernd
