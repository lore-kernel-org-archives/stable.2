Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFED3563D4
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943726; cv=pass; b=HQAea8mauceFXasPAId/UhjXxVhSWYb7tGUV6s5oAXxDtCtPVLJIoLPMBTxdBW42+yeSV2/cB7gN8ge0NT8u+dqEj9BgC5wGAdPzeV0y3bZgVypMg89m8uDXxQTRmNoKdh+EXhAgsQkH/JuCn9pIVp7uaJYGx1YwAOugGGrL+OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943726; c=relaxed/simple;
	bh=LJ0d7wJLEsKMYp2wDMzzqU/753oArVGJUs6SgvTaVUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDlcHjMzd+SWuCPLQ7X4LUB9MChYljhSHtD5l75EH/M6UQ/hjGSe9amvqfJFv6SBnIScEB+VQiPG8IcGTSbv3ICiPgMbaSMFJ8Nekv0b/B0pOTmBJwIVDP6Lscr4zU4QxmKbv61yeIRAZjZ4EML/zbqY4JEQgx7tSIhdEjm9ASw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xiboxo3Y; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xiboxo3Y"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef616daf6so4248337f8f.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 11:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780943724; cv=none;
        d=google.com; s=arc-20240605;
        b=ArO3LTqSGaKG4hWXjaQy5uh78SsdA1fiPc7K9T/ZLomdXIZ8bNmCULgym7Dz9lKnrf
         0X1ZOawjlwBVi16srRljprSA/8l42nTCX71Yn9yOQYe073uqOuGp/l+sWJSMWMdmEHOK
         0sw+hZ6JVSGXt9dIzdav3DRCU38/ukMFgq343RDJnDLvjxbYgo15CqTNpvJOtNBdzBNg
         Q3MJjNXdr2A8mlwPUJCIAPcv+GUacUhL0DEj29nw+3JnZKiLfoGLnmCY7yrryn5YSMv9
         slzpD/73lRyfLy1jk8KXTqS6kQDNZUE7lWuCn+c8xAnwcpQVBf7dEBnRCEAN8+rGSaql
         /3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LJ0d7wJLEsKMYp2wDMzzqU/753oArVGJUs6SgvTaVUI=;
        fh=CSUH6qz3607Fo/gPIuklKaAwd3yCz07rGCeDfDtHavU=;
        b=B1owejXoOR0JJ+3/pRAbizfytstY9/E7V/lNJtBXM119FoPksDcYCXp8gLVCUgqP6w
         6GWXcP9oQsvD1cucVElzIjiWo3Wb3Jsw7qbySPtAkKBJNUNvZyzJlEqSe4KdEmrjJ0r+
         gB869QI+584wOsPxOgucYk1pgZdtLKrvnrs3FAEE5Y3fdzYpRl+C/ov69Z90kP7MyjYJ
         VLmaekNYWosaL4haCuWRvv65itXnCmnfcL7kPMpRh3wySZN+gWFs0UkasYJmLZ1h3vbn
         /gbaOwwTC36amy84YtivQzA5ZbBCumY4moDtlfnM0dQ8Em+ZEKiMCF4mGL2fYa6EXZ0d
         Md0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780943724; x=1781548524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ0d7wJLEsKMYp2wDMzzqU/753oArVGJUs6SgvTaVUI=;
        b=Xiboxo3YLpmkyUWtSi/2TXnTFvQ1x8thp5mCm44PDSuaTQPC5WmaqHfEEnWWyiqD6l
         y8gt74BFUi9N33+BW3NiEjhpJh8xlojzprt2Ts+T/M4cTksmJwtyJZMekUCbUrMLPkTi
         UVwTpxpaZo1ZskYuvCmNuV57WjVZXjTZ6LlHBRO/umpvUpiqVb1e0Gr369lC7HcrjS/C
         eUWetkbDh87byPrK1g1H/d4qQOJV36C8TSC4q5M0ajo18u7Q4p3lvwbGJPvCjUMmDGsg
         r4AW+SPSspanpjXlkoUdTR7SwDva07PrYTPx2jS603/b4ISm2ufOhG2dccqnpIvIRq+z
         FO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780943724; x=1781548524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LJ0d7wJLEsKMYp2wDMzzqU/753oArVGJUs6SgvTaVUI=;
        b=YtcpOGeTanw//s2Cbr4npr9MVORkmHIAwX/utdPWiRF6vLdcSC5g+U9Eg1JEXYSD4K
         ozSajdujXaFN4Gh+FtC3qXcXQbXSCe8u8oCehVlv+zowXOp/pTKihnwlqo2fK9OB9sCi
         jdE54HeX780/81LCDjuA88zyjc7P5EoOnmvqOTDUo2qeElV8AhCQLGcHLNVdMvl39GCR
         P/BIAFvxc7TtsN+jNEf4xhhg5sAUDtit4xuW72AYu3UQuxU4Q1UljL9QPNGWea1Cac71
         4aL4FvEjgscvSufkxCwzvHHDa6FejvlbotLh0vQwSh8IcfYBLZgVGWxuftRpKp/9uwro
         C3wg==
X-Forwarded-Encrypted: i=1; AFNElJ/fUQyEQzR+Af1NpA3qkvY1v9FULiDvke61BZ+QykfZdz0w/d+vGXYooZjvQe3VgYdPFiZ2+r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtusfmkuXqJMeaP5XC2XpOwhkXJ8+7TfeD8IQD226IJPMjDcIK
	h34Jden8mruNy3S5aCat3p4/uuNKZsNTE0jWIwG9hkOIyxupKi2wcMk8WSqf2/eHq54g5QuZqUZ
	EyYpmw3qw3Sl4qwhs10J1Oz/SrWB8W0o=
X-Gm-Gg: Acq92OFXZbNKtGVbhuxiMuVQiba+3Y1gTdrFaE3S7RZh6qbs6+H6SOqww2yipGhYhi9
	RGmmlq0JBOWAIc+vS3vPxwnnvSqULp3xHgUDPPZ+5h521kdUFGpacOYxobSaumKZRrPJNMNmwfk
	GCOblB6P0G9kRknk5z6bjGxoeHDKHGqXA7t8EDLTWC3gNWzeTLfUT+p/DIVN3ZqtZWStZHLSldg
	eoR1cKb+eoLTDQeP+uIp4gYPlIis4pgB5Fn2W7jYEQT6eunpGV67naMCOygxRc7KfL1pbWqTLx5
	eJShkQV1HazqOPyR
X-Received: by 2002:a5d:4521:0:b0:45e:ebe5:2010 with SMTP id
 ffacd0b85a97d-46030619dafmr19903232f8f.33.1780943723764; Mon, 08 Jun 2026
 11:35:23 -0700 (PDT)
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
 <57fdff56-6a4b-4bbd-b191-d63b82a14509@bsbernd.com>
In-Reply-To: <57fdff56-6a4b-4bbd-b191-d63b82a14509@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 8 Jun 2026 11:35:11 -0700
X-Gm-Features: AVVi8CfJPRBB6R88R8NeQOG9zr14wRLwhjBTQyfuneEOQnOyvfk3KG00nzcOj4k
Message-ID: <CAJnrk1b4S3EUb-FzrvojC2Lp-DOD1GZEpvEKEMKhPpZbf+sqLQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] fuse: end fuse_req on io-uring cancel task work
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, Chris Mason <clm@meta.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 10:16=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
> On 6/8/26 18:46, Joanne Koong wrote:
> > On Sat, Jun 6, 2026 at 12:41=E2=80=AFAM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> >>
> >>
> >> I do not think we need 3/3 at all.
> >
> > I think this is needed for the cases where tw.cancel occurs without a
> > subsequent fuse abort, else the application syscall thread is stuck
> > uninterruptibly in D-state in request_wait_answer() for the
> > connection's lifetime. tw.cancel with a fuse abort is the common case,
> > but I think unfortunately we also need to handle the case where this
> > doesn't occur.
>
>
> I see, the initial code was using IO_URING_F_TASK_DEAD and I had wrongly
> assumed that is related to PF_EXITING.
> Well, I think the fix is clear, although I personally do not like the
> exit code dup (or better triple)
> https://lore.kernel.org/r/20260515045541.1171335-4-joannelkoong@gmail.com
>
> In my option fuse_uring_cancel() and canceled fuse_uring_send_in_task()
> should go through fuse_uring_entry_teardown().
>

I don't feel strongly about this. On cancel, the ent becomes useless
since cancel consumes the cmd, so imo it makes sense to just free and
clean up the ent immediately instead of keeping it around until the
fuse connection gets eventually aborted, but I don't think it really
matters. Happy to go with what you prefer.

Thanks,
Joanne

>
> Thanks,
> Bernd
