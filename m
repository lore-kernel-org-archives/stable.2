Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DE7348C5D
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787091286; cv=none; b=n3yrit6wtu5wIrODnMA2MAmM+ls/d+Iys4iI2oqizmrjqAi7t9Hr11WX7mpq0oLzb6IM1wshUWSVQj/rbyR+FhvJNqPAITBJ4v9ipEhGM+uZYrjdf4dRueYR8Qn5CIZgylpyYk5QvfXQHoT/Hl96S+3CPlm+cf2X8CtByVFyehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787091286; c=relaxed/simple;
	bh=+/H+wBy1+ETyZpr5acESYNGEUWdWsdU4YXrENI7QCgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWiIP1KLIr5pGZx8k101oxR94VBbhUGFIxYuZ9cAPSBiPzdB15RBfnpTwnb5BuFd0lzL5KiTEarEN5/y0K4xcyUuES+9U1A0OoN7SZNpCbHqJARMSTWLSkQtyrMfRSU4Ph9K3fFQtd0Wv9P2yudprHO23MnM1W6A+JjJvT5uyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuY9p5Zj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuY9p5Zj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so185037f8f.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787091283; x=1787696083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=efM3F+wFbP0mAVU02OW9oAVJkwM8FLNE+I19WeQALlE=;
        b=HuY9p5Zj23pcNkb9huJiePbYawpN0OU3jt9HT7QCfyGaB+I0V7Buy19La+pBAVqBDM
         eyrkwrePD1b3mo8AC9y9WBweVs/2Hz5LOQOEBD0eOTKZwZ9qKfCKGiz12M0qrpjFZIBq
         hxQylH0GyBH1IAwDz0AtmTDg1w+re60HDL3AsKs8qj/ERH7yKqAfW5K4mVT5bwro3cYi
         bT24+QtnvFuJzmzZ8dp879zAW7tXxiL8dfcSxDZ5Pw4/r1pZD1OeJiQvx8wuxDVTwfr9
         sKAfqg6Dg+o2OFx+tHifLwxCvneyAom554txle2iwtaviSb5mRIlHAvoqPKk2Vmmrfjf
         sWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787091283; x=1787696083;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efM3F+wFbP0mAVU02OW9oAVJkwM8FLNE+I19WeQALlE=;
        b=Lv7+Q5t+zzIXd+4hMUjvbBDHW2ByUlrKazh8fp4g226U48Lmv2zJT3A79iFokXjWbQ
         VFeapBoSRcvvKuLg42L8oSOuzPmqjTRyYz7bogU9yVIv/X3Or3hMaz27ZpaWSUehivZw
         hRY/cgoX4WRlziCcvqZrZQd7TJIw1ImDeFiqDudf0B5gbDbtv3sXEveRWmQ46dcYi7j1
         jjOpx02HZb7hr6Km5rxyOpSESpRGjRaagK71iBdQR4wxpg4zQK6YN2sJSXxSN3LGe7+T
         4oUFZzgmN4aq0RQhfw2/+Onetbi8EqVF/H684nRmwRidLgx/S8JNHcZaHWjqU+Dd25dU
         8k2g==
X-Forwarded-Encrypted: i=1; AHgh+Rre/448SI5JNh4RVXI/SouFSMRfpLnN402lGtFhudLHDD0Gt4m6N9T7EC7Z9sVbYLTwxP8PPbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0AR0EAT212TzknLb+HZwWdL8sGDVbWDk0FhrRV0PKmCwhuuKI
	yIpZ3vyb/bu10TSynoI6Xnk60UPQOSRkxJAmuVKpb9yXqLamMdSFpoFi
X-Gm-Gg: AR+sD126PMWIg6ve0Wg0bLrzk7jFvbUMEP6XXU8IabMTxdqVWEn8hKIyn/Yzkijn2ho
	SLJVRuYXCwTuc8ARqUzpGUW9m8Oo+dKPwWqRsMEAi6sBmtoNXxFY2DpnQIpAZeQFIZxsvMsySf5
	i2PK9Vg1/K9NpwHFGSY1fzptkcp5VUFAPuPFZxELKNszZllhJmjIJHR/ozMjr79Fs4m9hnFYqL6
	zRKY2It2Ke+qF2bb/YyPYG49WHabecQwH4xUe6U6mvfsfI6wXY5x4HlZQydDqzUiKRzfo5oTImV
	bgARZecJfchkLZUg++tuLQcgXYAnR2L3GZRBr6cf8ltIFdI/8KQaQcEslvhxoLYCh3ZVQt+/GhX
	hL7udG4HAEqWymYFDd7lshtttKYHtkc88SmNK5lQvH+x2TA7sgdkL48k72bZ2nHSU6ugw0x5Bjf
	b7GR+GVYiSTSmdvmcfHw1gR4QdrcRoqOCv5VdrU6J/pS98HI1QnXWEVwjq7IiiRgjeMpdRqkNMf
	ig8Qg==
X-Received: by 2002:adf:e18a:0:b0:481:56ec:b422 with SMTP id ffacd0b85a97d-482b07d6433mr2245539f8f.9.1787091283389;
        Tue, 18 Aug 2026 15:14:43 -0700 (PDT)
Received: from foxbook (bfg7.neoplus.adsl.tpnet.pl. [83.28.44.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e54sm429660f8f.11.2026.08.18.15.14.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Aug 2026 15:14:43 -0700 (PDT)
Date: Wed, 19 Aug 2026 00:15:11 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Rishabh Jain <rishabh.jain1198@gmail.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] usb: pci-quirks: always assert xHCI OS ownership
Message-ID: <20260819001511.45b3621b.michal.pecio@gmail.com>
In-Reply-To: <2d13e2ae-f5da-4951-bbe4-be7bb0b296cf@kernel.org>
References: <20260815014534.77850-1-rishabh.jain1198@gmail.com>
	<69fdc442-a4f2-42e0-80f6-6b35cbc207bf@kernel.org>
	<20260816220306.64c615f2.michal.pecio@gmail.com>
	<2d13e2ae-f5da-4951-bbe4-be7bb0b296cf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 16:00:47 -0500, Mario Limonciello wrote:
> On 8/16/26 15:03, Michal Pecio wrote:
> > Not sure if this has anything to do with PROM21, or if some BIOS
> > is just trying to use the xHC at resume because it's permitted to.
> > Then it makes too many changes for Restore State to still work.
> > 
> > Potentially, such bugs may have happened and been left unsolved or
> > "solved" with RESET_ON_RESUME quirks and other hacks.  
> 
> What do you think about making this a series with each of those
> quirks dropped one-by-one?  The head patch (a variation of this one)
> could go to stable and the rest of the commits dropping those can go
> to linux-next.

Hard to tell. All we have is a wild theory. I couldn't even test what
happens when the BIOS claims an unclaimed xHC during resume from S3,
because my BIOS doesn't do that even when I clear the "OS owned" bit
before suspending.

Those quirks may be wrong in the sense that they weren't specific to
the particular PCI IDs, but to some particular buggy BIOSes or kernels
in the past. Maybe those problems don't exist, maybe they still do.

I have completely disabled RESET_ON_RESUME on my test system with no
apparent ill efects so far.

OTOH, I tried disabling the "broken streams (UAS)" quirk on ASM1042.
While the kernel crash which those chips used to cause has been fixed
long ago, it turns out they just don't work correctly (Set TR Deq is
a No-Op with streams). So I'm not rushing to remove this quirk.

Regards,
Michal
