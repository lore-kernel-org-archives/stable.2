Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270668;
	b=X5Q4/G0cNmFjFuZ9NHtn2IFvhdXT6NksdfZeck0CKXT4BK0bsDreJYerL9CabuGRT2Tw
	 +P9YhffCBGgSWzRx1/nZOB77GSRvLtaiPnKIUxvPdd/u6uNNm1WLiyjD9HfIRwpt9QzPi
	 RvlBHM688PulU/IpGVIOeam1Wl4Tubckx5mCsu4+KL9XUUjAwhmkSWzULvNUzs7L3rDlX
	 dLIeI+JbDueK7Oi4UJazC+klvsRde1WN1c7levDJdlMC1eVMaC9/4nhswnD0zOczZIr92
	 G+CK4WgHj4eK5AceICI9CWAjczWfZeiRouQzJ0oejLYM3oagOd8gR0TWGrNv7YwjT8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uMxg2j2ArABS94uWcydZWkjTN2mWanzLIsJic7WNb3Y=;
	b=gaHOXPkQA8/YjXJ6DZHgs0kuqx8lJC1NT4R3zHaL1keCIGEZ5GRIWDAbq6irsTqsM3Pw
	 HSw5XQad5tCQKxgLBJWmmaAxAeDUuC5V6xLolVl5BjbXyKT1MvGSqYFhvdQDFG4O9lfWo
	 7ADsUmLLPYWz8EVg74TGdEB4Wa7xTcZZhbkY/FesVQhCGl807/hUoqxLbVBQXBFq42D7M
	 H/kdqCRQIYu2N4m/fECskn7vdsAZmt+QOT9pTUVvljejfXSijgnArTYfxM/e9gAL7FvFW
	 zKCV/6A0Lqv/R5o4oNZFcVbClfwPvv6jA8+nlnDrwetNr/r6DtD9JqJOWeZLAo3rZFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04ifj2We;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D6606A327
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738D6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04ifj2We
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso1247332f8f.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270667; x=1793875467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uMxg2j2ArABS94uWcydZWkjTN2mWanzLIsJic7WNb3Y=;
        b=04ifj2WeyAAOGlbfGZESAOhUycbW9j4QbHFFNujZ5tSmSmuJOXM5dHuCNLyc7ojP/u
         FmjatzrJrM8c5B61zA2LgYjDPi7B5bDxKPvP4GiHp/4YF4xxpuUsSDj5nrepjRcDNwd5
         uHkFjqZE/NBRWhjykCjpSEnFW4VCYJuYkak2Y8XZz4WPiXUUDCVt+0Z9rMxplabU6oDW
         258K89rMmvrwjCfyY6RExMHK9T1w4EXjvuqaC7Ft1DxmPAhME9NPQO/waRki9IQecuZl
         2J00O99Vit+RAvb1By+wEPo0VN9k5/bWb14gwkDglMMpok7ZorOl8whIHFF3FhOP7Kkp
         kt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270667; x=1793875467;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMxg2j2ArABS94uWcydZWkjTN2mWanzLIsJic7WNb3Y=;
        b=CUW3U7UTroNsIgXWWvZJ4QDzRZAaOToJkiKJIowSDwQuTq7H5rwrMHrqlgqTpfQEwq
         50Sp2otHsNryzzmQR2kF4sYVHC+qo51+hAEECdSkf/Io8HOBFeQFKNOk0ghWpYdbonxc
         m0PHkEvWCO/aVzwsaGqLBQ/M1ScpuLTTiDzQihOj6fidWF2If8bmpDo+Dlwj5zjGuxq8
         /AR5z+Io0WOjJfvze8F/TMcnJ1/D/1bwGb0n+Z+LzBAUX5bPY7bk1n6WuNxrr23l3EAK
         LBnlOEORMf6NmF40gyII0qUBnGKlf9TCPGam5Ai15FeULmZqezyFrtdGCsiC0BVg5mFY
         zcsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxn/49tTM7g9ychTQZofED4SZiTzUYcPFUxK2zhAI7wVcQ8KubU/0RAH8luO+FrnbgEYIo1q9U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrdisXaqVuEoi1YzlFolk55sBQWjYAwB0gmO80PSAlB0nZp5zn
	K8OxMFPyYTVVyTMHoJo+9ookwQEctXo1SWZLwettb4GmsckS8dGYyMz7
X-Gm-Gg: AYBFou2CXGJd7GfRg4YhZD9qm8y1XGBDAyRRGUfml9gYPHknV944aUzz1Y1DRFppDgG
	zivt8+DWQNPZq/NCZNxlB+v2K5z9/vnFb/GwTHQUgEMYz+GKc1o9qWf0LY5xGXu/imfvGCLbFKE
	4ve6HlJg4AjLsmKnYyTi9gbulPkwW/sYK19dVMyH+Y1peb8URV3PcavMmvr/sY4vqpWRhkkeGMq
	tNn1mFAkRk44o8FSRYwBmTsBnGX52xyeB0kmpw+RNNqnVN6ezxVxYncg+VvibiNCXhFyVhjfn8d
	tZcNlBLy82X4HENZHSxnM6jeEHy/ch5hYOzkpmqlRNQrVWh4xXUbRDpLD7PAFjaOXmJKuYhuWcV
	Knjtmlz8l4qOFHt9R1RFUX/ssMfdEd/IS8rM74TeMriyjumD+CqSPe7hFF4EQaKmaUINJkF+v99
	lYfh9hTW4n8HeuKA4D5iNQsIRjLg0An7bVPVhdpbCDz1iIeFz2avQeUwiyZhw/cx2KRMRKeV23U
	kUW2fch6HdtL/jBVeZyC7WWozfN3RoNxK24CCKILceAIAmAw2/Bh1qGsTcGjmFP829jYLpy8E6I
	uRT2nsItkSz+F7CDMm/XDw+VuSdHoLrtMBszDQ==
X-Received: by 2002:a05:6000:1a8c:b0:48d:eec6:308b with SMTP id ffacd0b85a97d-48e5d2ecf6fmr11893654f8f.21.1793270666746;
        Thu, 29 Oct 2026 03:44:26 -0700 (PDT)
Received: from foxbook (bgu81.neoplus.adsl.tpnet.pl. [83.28.84.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm32900670f8f.59.2026.10.29.03.44.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Oct 2026 03:44:26 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:44:22 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: IgorpetinDev <igorpetindev@gmail.com>, Alan Stern
 <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>, Oliver Neukum
 <oneukum@suse.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: core: hcd: flush giveback work on stop
Message-ID: <20261029114422.2ba64d53.michal.pecio@gmail.com>
In-Reply-To: <2026102924-flashily-myspace-60a8@gregkh>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
	<20261024155614.2732-1-igorpetindev@gmail.com>
	<20261025000643.425c57ca.michal.pecio@gmail.com>
	<CAG21Q83f_Oj5+-OPjFdxzmLWnFkjfYhY9ordyO0zoGtxkWEW3w@mail.gmail.com>
	<2026102924-flashily-myspace-60a8@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 10:42:35 +0100, Greg Kroah-Hartman wrote:
> On Sun, Oct 25, 2026 at 10:54:57AM +0300, IgorpetinDev wrote:
> > Hi Michal,
> >   
> > > No such domain?
> > > Looks like you trusted an LLM ;)  
> > 
> > good catch, that was just a clumsy typo on my part: I accidentally typed
> > appspotmail.com instead of appspot.com in the closes tag, anyway - the syzbot ID
> > itself is valid. If Greg or Alan prefer a v4 to fix the URL typo, I'll
> > gladly resend it, or it can be fixed up when applying.  
> 
> Please fix up and send a new version.
> 
> thanks,
> 
> greg k-h

Hi Greg,

This race had been reported by syzbot previously and a patch
has been hanging on linux-usb since August.

https://lore.kernel.org/linux-usb/20260823125831.6ea35650.michal.pecio@gmail.com/

There is only a bit of controversy over flushing vs cancelling the
work. I think that cancelling (and leaking stray completions as opposed
to letting them run, likely UAF things and maybe corrupt memory) is the
right choice, as a courtesy to anyone who might create such bugs and
need to deal with them.

Regards,
Michal
