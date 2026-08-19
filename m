Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169B2C237E
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787175194; cv=pass; b=q8fjuhU0XZZB77ZQ7Nscuu2Vf9pGj/PmgsToxMnJw4QRFpsohSbXyATijuOIvX9jvGn8k7yfwrTZxlbzCmFCUJywe1BIPyjCv6ostiCx4RklmECdsLT3R8OP4BRuyoCe35KYN59YKaKz1Vdl4XrEPx4rwWbaYoFriAVNuDkLUJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787175194; c=relaxed/simple;
	bh=0yuQiTtflkY/YAVo5ipfAt9RToVOI1Q74XMibElEASQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnBjPPVqsYpVI3O/SfJrlUItNr1xHWBKoam00+bmSpFZ97hTKv84+5KME9RwDRDsouW+Sa8VUUiGVMsKmeABKsSttkouwWN2huMGYPwpsGYPP34I9wi5w7K1X75BqbF+v3BL7DLXKfPSCOjY0X1jTuVr4/Q/PcHg7zKGE62Fi0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxKML53a; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxKML53a"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b14b207e05so102084eaf.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:33:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787175191; cv=none;
        d=google.com; s=arc-20260327;
        b=QHArzKBph/Mi/N5kHqRy2aTbd/CjH8Vrqu7m8y+ctXfunD1XHlG30BgeM4RD/UwcBw
         FbpF96K6MkkYYobfl4V9YQ/mCGfmtdDKjBWFMC7XgjreDMYIOp+I1hKWrXOP6Qh8CTBj
         M+zr98xibFfNFJK4Gaov0eSUrO4jMA7kIsJWxWR20MXQKVioqeCsnyPIJ6OZCr57TP4o
         Mg+4o0ql2h7PtpGcHWAJlTK4okrey74WZJIwqTF/pJLtULwXI5Ma/YLC9FIRSihSvaZp
         MJhWx/0TXehgormbahFwaz7PdRjyxTdzrsA07UrAaAnxaZp1OiPnJGJAlGk81Ft4nYWj
         e/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gx2FaQwosf6l9TDjg935G3BICKMlJHtJrPTe2w1aBGk=;
        fh=SYW08DPr4+cpqYhShH1dz0q+Zg/9a8bXcjzjt/URZ3M=;
        b=eUYje46JpWJNIvJjyvQcte3Y7S1kfFwTxEB3txSCiZKivA3y/Rz28ruZK26/0BXtCW
         HReBKt8ZZ3XoRlg/kO4Gvzq4YkXUSpxhcnbh5x7/jN+roUfSOfpvDue/Vpqg7qE6DQuc
         fzJuPuGR2VmWIbHkgicctFDa+AZhwMA11DcAybgx2/OF1iZmf9OYhTFBB8b3nnDH/SSk
         TtMzzrDKamtZf3TD4z+sLXQrBzOtiE4lbWqaIjP/vq17HUba3qptOQcwmQcm8X5t1Uq9
         5OrFrWn4BbVkJBvwnth6R+UTP8hgoZEj8irDNCMODK7h4UtonevRoRaiByNRothJW5vH
         kD6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787175191; x=1787779991; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gx2FaQwosf6l9TDjg935G3BICKMlJHtJrPTe2w1aBGk=;
        b=lxKML53aLPuhxb2t8kolIm5WWEv5xumqH9H8lPg1Ws4Ovb6TNIF9FUswmirvLUUvi7
         gRn70XtB7VTSxXnk5hOwFVDNXE+TXjkPNHbIyzQBWubjnWfMwFFRAr0Gkn0zw2jBk4tz
         GSixoA6eCT7Y8Rm9+OcBA0ETY188k5JE6dZfT/J/pKF9bGTtw1UIlEZtb58GwcHSOuPn
         dVUVZnjT+QNyQPwxiqAZyDD0DUXIjMwSTHiIWsRTOTtEtTwCvKmPN0Lr8pswKUcFg6ID
         c23ewvnEivrrFWLRLNv10LoB0GUYI5ch0VJug2H79QJ2ttqRoUMu9pSZmsKn5V3qaaKp
         sU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787175191; x=1787779991;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gx2FaQwosf6l9TDjg935G3BICKMlJHtJrPTe2w1aBGk=;
        b=mjkiUj2Vl9kbe2z4moBgfZQA4LRaimI+B8j0RV2bEnf5fNZ/2Ulheqj/4cmgitdrAy
         j9v0jPchbAyb1lrmB+w5xAM4hnHp4HLlb00dhZl/C4txzazwosnXWAmvYW850M0FAJ6K
         ApDoazODz3X/LF1ap89nlCz1OfQatK5xxflD7mY3moM1A0SrhGzo5G2I6nf1SXZoIoIS
         lJhaT8wlcOqQaxexSlfldenD7mFDjr4QbCJ0bu4l1Fn+GGLuIjqqZKw521WVJAA5/ZSq
         d/wL75UixD2gdark8xkbNbmpnTZJ+JVyp0gPCLVfNu5U6pIvpcsq0eBmHV8UqxK3so34
         8bmA==
X-Forwarded-Encrypted: i=1; AHgh+RrrF+ADBb1QbdAkKppS9gkDtas8XibB0IRHtWyyqD9SjpICH6Q50KLmXaUiecY2fzQuDOQzSWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIS95g/cs8/Fw6dIdAms0ef3A6QErAfEEPPwnSjkGtAkpRwJAI
	Y9jfdzWre3ZEGR4TV0983anV5PFykowR7foyqrcHTPqkfLMmE28M3U5kwVMEnFz+CVb2q1PA8jQ
	q+2CisQewT8QyXm1qh3pfPn/TiteVxHs=
X-Gm-Gg: AR+sD11Ajoe/lUQwpeVDOizI2h0p645PjBvlNCpjiALJPZufJFxZwp6W8CDLmSDc9Hj
	bmiyt9MtEOxkKk+l10UGvYDoA8kOo4FHwxkafPWiNK/LenrZ+5UusAROyU2P+q0K4p5xoVHKmdd
	c2c3ZyQkw0o9D5R9rNwUuDozrr/pmyCPytcCOH2Zsypdu6QCJ+zmxcFHVSJ2L7FaPEosHK+TEzt
	ZzMMID9xv952qdoahA9bMhnkOezy5TtIbVYEM2hzVFuL3JlXWXsHvit6pwh3usmjAAq/n2fSESo
	dTQLhvWVnjE2eGqFrpyHspTYQP1JXM4YxB6ltIVHS8GNllR7RbmyKt8pz5DtpE6Jn0fvBa6R8NE
	=
X-Received: by 2002:a05:6820:a09:b0:6aa:e70f:301e with SMTP id
 006d021491bc7-6b13c32f644mr7794601eaf.8.1787175191390; Wed, 19 Aug 2026
 14:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818105642.65381-1-devnexen@gmail.com> <aoXC2xL-J21mcxW9@zed>
In-Reply-To: <aoXC2xL-J21mcxW9@zed>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 19 Aug 2026 22:32:59 +0100
X-Gm-Features: AcwNN1W5zcg_-tTwF3YLwQ8dh2q7T81Rk5bauiLW9pzbMrBtNue3gCWN0-vjtsE
Message-ID: <CA+XhMqzZqLFeDfNLxmXUTpc_FauD9C2odaSQb9HfWxKMmpf6Sw@mail.gmail.com>
Subject: Re: [PATCH v2] media: v4l2-isp: reject zero-sized parameter blocks
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Riesch <michael.riesch@collabora.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jacopo,

On Wed, Aug 19, 2026 at 04:56:33PM +0200, Jacopo Mondi wrote:
> shouldn't we refuse the whole parameters buffer right away instead of
> ignoring the 'type' block ?

Yes, let's do that. It costs nothing either: with the header size check
the walk always makes progress, so skipping is no longer needed to avoid
the stall.

v3 keeps that check and replaces the skip with:

      info = &type_info[block->type];
      if (!info->size) {
              dev_dbg(dev, "Unsupported block type %u at offset %zu\n",
                      block->type, block_offset);
              return -EINVAL;
      }

which also leaves the rest of the loop unindented.

Cheers.
