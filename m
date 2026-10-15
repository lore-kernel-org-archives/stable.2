Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C91922FD
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023603; cv=none; b=g5wL1l3M0sVmFYySzkoxvm6DRXbGuPtHWd1LfZAsro8BdFhHhoadO9jvrLzZulI5wIIZZxSTx9b4d4WblpQj181DNGcnNGLSdbvnlr9O9d/rjmN0EUflRnUmg3yF9WDNvuK0KnLwpdHjhvI7n4pkA9psM/vzatUXP/M61C1Rvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023603; c=relaxed/simple;
	bh=hT9C8KpbWvhuKNsWMFmwkxNYGUnSTIDYXUV4/uXNbho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lWWUwXW5AN5y46HIG86xgf65W2WrAghny/BHVhMC8PullN534oAIcd4e8X22WaNb4lWREP3kGjRtCLTI0RxPfTwA3EYLIrEaJ1Co/wFLMNFBgd3GlF2jwIjSwC33KGOvF8oEVvmXX6xJRz3sIrBgiIMtq2QgZ5SGmymeesDReBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eF64rZKq; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eF64rZKq"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a8ae5154e7so6044620a91.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792023601; x=1792628401; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c63/iXJr8hVZch+xmWANZyQNFENMpYcROr3AAHKmacE=;
        b=eF64rZKqiBB1tAQasG7iSWR5w7CFmUFF76Y2xi/uiyrmcvazPjvVoqO2JH6dPsTFAv
         9Fp09Ev/1pgWxUjG3fqW4KybzZp7tckWpGfp3kIHhOS6wmELUfKN+RjvhLxzzLoXGion
         B4Ay6VuOmuOryQaz4qM9FLpDwpvQLGBWW2tTNuwMJOdGBOkWW676Fl777MsE4oNpzBjI
         LZZzoWZ092iYtym07V3I7zjxH20rYJrYi1vJFd9VsRCaKNsPC8vgVtObyi1Epi1a1qPN
         HJExF5rf+y6dmPy9pNx1BotHhSRFptQrjH6QGp5egyZZQmFFR30P10f7F5Pgcm9hADzy
         vGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792023601; x=1792628401;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c63/iXJr8hVZch+xmWANZyQNFENMpYcROr3AAHKmacE=;
        b=GgB7eN2ijRS86VpY9KSaOEx0lyrWgx0aFwX4tMlKn5W5imYAnxAPNCMr0ll/FKIVAc
         UNxelFka/MTV3ZLfL3oxvR2CBONcXn0Y64syiWO8h98msKeBezfXSHLIUeEXhfDD43Jt
         EP7Tmu5mh9X1CUKClCi7QJb40UCSUGzaQVE51hvIvw1t+zzgZwA7OApiBx7OZAhXAX99
         R3kjm8Y/kykKCJFM+X7H8cAYJe9SPSNpHJ6I+vgxM6oDp9PGj8v5WViu83S9f1+VHUMG
         SSf/+8zqkyBy6RyUkWKGtsOrDpWeO9L9Ysb9AvhX2tsKCHNIRnamDiTDJelbLnDJnigF
         eN9A==
X-Forwarded-Encrypted: i=1; AKwUvBw4T8Nj+6S6CXzhET7h0w4JY2N4skBH+umhUaNM/WCpP4TaeoPOWBqu04OZ5jgvLrA3zvmRwv0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+jzr6Cd5VqDuqkkWhIRP0LTFvMfos6kA+ka43qsrBn6v2dYLB
	YUGw/7wDxkj4XIVmJJF1YcZTva3lMH27EGghoJ2y70YhxqZsN/t9gKrCOkb9oNBfXmIhWSTJlMo
	1rFQISRBalmywHUVGE00N8w==
X-Received: from pgdo18-n2.prod.google.com ([2002:a05:6a02:6212:20b0:cc7:b455:d1fe])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2ec3:b0:3a8:240e:b493 with SMTP id 98e67ed59e1d1-3ab3acf5c6amr14581156a91.45.1792023601145;
 Wed, 14 Oct 2026 17:20:01 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:19:59 +0800
In-Reply-To: <sashiko-outbox-169843@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <sashiko-outbox-169843@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015001959.3452983-1-stanleyjhu@google.com>
Subject: Re: [PATCH] scsi: bsg: Pass reply_len to bsg_setup_queue() to fit UFS
 ARPMB replies
From: Stanley Jhu <stanleyjhu@google.com>
To: Jens Axboe <axboe@kernel.dk>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <mkp@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, 
	Mike Christie <michael.christie@oracle.com>, Bean Huo <beanhuo@micron.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	mpi3mr-linuxdrv.pdl@broadcom.com, open-iscsi@googlegroups.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 13, 2026 at 01:39:40PM +0000, sashiko-bot@kernel.org wrote:
> Since job->result is 0, this check is bypassed and the full bset->reply_len
> bytes of the uninitialized or recycled job->reply buffer will be copied to
> user space. For UFS Advanced RPMB, this could leak up to 104 bytes of the
> previous request's data.
>
> Should the reply buffer be cleared when initializing the job, or should
> job->result be explicitly set on all error paths?

This is pre-existing in ufs_bsg_request() and not tied to the new reply
length; the same happens today with the 96-byte buffer. The other BSG
transports complete the job via bsg_job_done() on error.

Both points are fixed in the UFS BSG series v2:
- 1/5 completes failed jobs via bsg_job_done(), so job->result carries
  the error.
- 2/5 clears the reply buffer on entry to ufs_bsg_request().

https://lore.kernel.org/all/20261015001855.3450573-1-stanleyjhu@google.com/
