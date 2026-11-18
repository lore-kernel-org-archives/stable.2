Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018070;
	b=dKz3ldyLfL3fGnID15SGQFm+v9EF2HqKhwrlmJwg12Fli5RlSxQa7c06geIes2FoFikR
	 oKp70AsOnBwCKPZ/T44lS6zGAzX4n7FwE95Q5vFUtLMN+QLTrjIF8tXPW0PYYZv8AcDfA
	 aLE1gDZFjaEru7vXmFdNnNwOE17a8cGcsQhTkdfArxp/28d7VKqhPd1PLHB09cq1IS9Rv
	 Bw7ZxH/wQiqCvBOgKH1glV5+ck+89Z98/XVH2jTmgsDCZ32iRtNKWh5r3ZxOFa5D4LTox
	 ebWn/CCCcfi+TQtGPZGx3NE0MFipH/TFlf0H70BQfY2BRAQCR9yzGWlFI94RkmEDW9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=uMY6Jb3UDbPrg75ENQ5Iey0rgsluCVDooajDuLXd0cE=;
	b=lfP5GA2qPXOIoWjlLhXfWdHEmtBIF672v1+nJbq1SQr5a2R8i6Pk1mzBy+CnHc3pNmqs
	 IXZe53zMYXOFDEhyEG6/ThAaiJCCU5d4o0eu5Vayuny9JOPqGkcj0NWr5JBI6me8ke0S+
	 bWT0NLQk7xjfwDkMFUdgnGs/lg4KLiV0SA/07cXIQCuw45ygupsbju/m141HAqIzNrfGW
	 j59MmudYPOIdNk/vL7XNS+1U3hL2UWgA3pM3WQzete/H0B4fAHGWhLVcLso2KXAcm4RKT
	 95fdgIr/q+WJLSq6MipsGb8Fm/nuhdnNFdnaptHGQtrkODcQ9GWt3hZUvo3ihgEldjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="K2kH/UYx";
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88A60A5BCD
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA88A60A5BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=K2kH/UYx
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4adea5b7a2fso443857fac.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018068; x=1795622868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMY6Jb3UDbPrg75ENQ5Iey0rgsluCVDooajDuLXd0cE=;
        b=K2kH/UYxJ1s9QIk2I+iFE+8oy6FJi8D0+gEKDqY+gZ6pmW+8qIuvQdlK1zDDZ2tqn9
         +grxhnhVVFi4vC6NoXujmaBAsELkdHD/ni+akIyIdYfnQVXIUdefoLtZsRuvr+oAWjod
         D2kOcmXFzzguDmC6XlwD514NWwSbkg28+3FtOt4YIfS+BzJB8WflsXo9S0UVl6D+SSMZ
         CeUaoy++aAN5yOC7dc450MBb2IQmziuDqQJL1p/6pk+Bkx7pDd2i+HrMHxPHvS7zRqnm
         RGaipKK3GMXRuwVd3yNsQnE8F9AoDHxyWIXb8pin1xjuivCgF6cf5Uuo6uS+rfAjDy+w
         RNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018068; x=1795622868;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMY6Jb3UDbPrg75ENQ5Iey0rgsluCVDooajDuLXd0cE=;
        b=Ok17ZjUsibAAwad4vP2Rn3GHWvo5KbX344WVQeCVultw4GwwbMLNgG+z53lmoid7KC
         dsDOpnXiws4ux0NAC0KqG7kkOB9Y4nWK28tIl1K6Jef85C4f3IzHkGebPqobi+eZcwC4
         I8DXngfJ9ThkdYYpPER8H+sD1rLcfeyjhbm6tpwIdWX/VZE2Z6cRwLP0z6IP6npxT+c0
         uVIYvXjR0Fe/cQ+q94EfUh31BVVkXU9HncrvqGGB0FF83hvAnqExl3nqpfcMN7gpzO+8
         IHTwY8/KJunn5ZApsthMxQdNvM6mEWmqm0oiBH2/CmSgyRLrsn8DSkrokFfUy9I74T7V
         Gvvw==
X-Forwarded-Encrypted: i=1; AL+hErGi1yoCoUL0PwswZtP607SHTUu9yvaBWjXLIpiTl/mZLgNecLh2xsKamcQ/ToWa+TIxIr/0eZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ol67OrZBd7isr2DLUiUOJDy0PmE04Ms0fF3kIk86XO6wSuYZi
	pFyIeemwW2+AtZxisuvIJUlyUiu/DStevEE3XrODcpkjLMH2ZYoethrlcvjT0+TVc9c=
X-Gm-Gg: AYBFou2maBvzC6lXL3U5RX66IFZHB2wfBva6MRBV9lmt85yMDqvJcFj9chp+DtX0dlR
	CyJL9qSSFKJqf0wEEnpgVA+dixcyPqIuq1vN40W78rRru2NKfP8MaHOMpTWwLdo6R85cH0ZsHKq
	6PU/ifWFiFGx3lvddb36iZl+ndp9gamdVhjMCos3yk1ODdJuE6y6lHCb9/CkHWt7N+m0ZnPy+si
	hmVLOWj+vc3PhkOTDB509YL9PMdbA06RweFzhTORtsHJ1Df/DFLTjmeJ/9HsSV6wuJg/ZSXSYE7
	x6+cnCg2TOhpYLwzu7TwyWx8XuO9IZ9MahEMG6izkg1NL5S7VuKflUqd2kzsp4SzFpupce6Ctc8
	t7XiP5bSyg85KG6jxOFHnsqE1ieGXmrUogMSHVcfQGXIZ42yOuMxHfY86eNx8HHAQhHMuP3S7Pb
	h3Au9u09o1L9IQx4zwaT70gJzjVpdf2uW3q3rmAYI+h50AdiDZkWRlc3aPtfVPkpWKIJRiPRWHu
	Ku8Cty6VMqdAn+sZ6vaZ3O5aeqYjZJOMdoI6kqWJ0+4V44UgjgvokKRZj241vflTNifJpMyUwOV
	OGRF/oTT5mLlL7wRa1FHWHGHpA1YgsfeHpfz1iTJXc8+HlTaV11kg34i/8/pvu2KUIghAk8s/f1
	PtxstbbfUx6PkMFOr9aVTRyr/6I+FoUd8h9RbJ4d1f812QTEz7+FNjTqRZS2Afhp6HPyhw7cJ
X-Received: by 2002:a05:6870:4692:b0:486:c1b6:643a with SMTP id 586e51a60fabf-4b75c3790dfmr2555326fac.19.1795018068283;
        Wed, 18 Nov 2026 08:07:48 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Mani Tofigh <mt4022@columbia.edu>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, 
 Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>, 
 Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, 
 Nilay Shroff <nilay@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org
In-Reply-To: <20261106-blk-mq-del-quiesce-lock-v2-1-cd4f72a6eb03@columbia.edu>
References: <20261106-blk-mq-del-quiesce-lock-v2-1-cd4f72a6eb03@columbia.edu>
Subject: Re: [PATCH v2] blk-mq: take quiesce_lock when removing a queue
 from the tag set
Message-Id: <179501806686.17649.15466634007148423129.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:46 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 06 Nov 2026 11:53:21 -0500, Mani Tofigh wrote:
> Unquiescing a tag set can run the hw queues of a queue whose hctxs were
> already freed.  blk_mq_unquiesce_tagset() walks the tag set's queues
> under quiesce_lock and rcu_read_lock().  Commit 71ec3c7d6db8 ("blk-mq:
> quiesce a queue that joins a quiesced tag set") added quiesce_lock to
> the walks and to adding a queue, but blk_mq_del_queue_tag_set() still
> removes a queue without it.  The hctxs are then freed right away since
> RCU only keeps the request_queue itself alive:
> 
> [...]

Applied, thanks!

[1/1] blk-mq: take quiesce_lock when removing a queue from the tag set
      commit: 495f22c5a99ac38e527294cdc4f3972718b9bee0

Best regards,
-- 
Jens Axboe



