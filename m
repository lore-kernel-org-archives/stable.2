Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735352;
	b=Yc/iuAxSPS2odc2n7hnvMxLBjKtjw2NA3TBmJivp2GyltTPOTXKppLo8Apc51LeD8ZM6
	 bbeLMkPn0gZhWT+0QpLEy/9sanePmLtxAYhXxAadA6ONq7D5mwjGok+SBBiCKUsp0D0l6
	 pkJqeWhYhfIwWCJZP8g43wZTCHaK2b7marpdqHYMlfSnQdjxfSiUxzAn4V2OA8Ux5oUVJ
	 FUKYFbDVHHlwFoNpaE0Ff7/Xkcbrgozuk0AareRyZGzlStJTulHIlLEOgXqIF0QIadlHx
	 rdBzvCoY19FNybRxDDR3hjeYjaecFMJNGpwnAAacXqo3bCjztsAT77WwXXuTUe4AGog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=P0AC+ymgXYnQmZ+rTAXF3fAS8FaKmkjFTCnbuMJ/sUM=;
	b=Xa3KzXspjrWWhGnm93nrKDDUEVahltHm8ZspNG5Mv2i9UrYu84MILda7gq8ZrFTKAoVy
	 FrR95Ltyhq4CcmZ/THhwSBpaaFZ+hOy/1pId29hvZMUUI/Vd0qVlkPUtGyVJGa44wjp+w
	 cVyqs9YtHdHVo8/VjVrikLYlv4ALU3TYN9awupnuPaxBP23V28kMDBQHQq7RcwrCOr250
	 t5N2zHwFZejIukW5fGZbQDuclrmgdwifxt6pzT9G65bKVG7gR2hUDa6wKt0o6BGTSzwkg
	 Jc/0NElrvajSkKe7HcC7TCwYzeOGaRRS2l7HrBllVj1UGplhNZAdi/mju1Cc7Y1wucw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aGZ2Et9X;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3135606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3135606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aGZ2Et9X
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5129537eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793735351; x=1794340151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P0AC+ymgXYnQmZ+rTAXF3fAS8FaKmkjFTCnbuMJ/sUM=;
        b=aGZ2Et9XRSoW7cbdfG5lGqV1+6xNkMS1R5B1w4VS3Ui4cwG+dA7ZizFdMHeq/+0/U2
         BilbKO1Fm20PtDD+HMuAm41zwNmvgYD1/eu5ZYOqs0KvvAzMehsm4uvfUZwfY7oaLBib
         FeozBa5ngKAi8pE181aL5qQbAJrKKuOySBVyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735351; x=1794340151;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0AC+ymgXYnQmZ+rTAXF3fAS8FaKmkjFTCnbuMJ/sUM=;
        b=k2LTs9EpyNyhlnVmNSXzeIcbBUq8n5T24gScoIrzozpWJ8o5ZqNQ/yLqKSV3CDm/V1
         zFnqIHi1+PCPJa0qV9Rtr4nlLre9dtAM+fILXPvY/h3QI0CeC55zU12pSGMXbAq+BhE4
         /wf5jWF25e6E/s1VP9/iQEyP1XaTFQM3mWRRTiLkpH8CVG6uqRY3Vj1DRUGK/78krEM8
         LKLjTngLulmhWV6oX/DqjGUJTTaMoDPnJM/t870/4pNmbP+gy2mIcSzGS0Wfrx+roXBT
         V5QwdMIX6gJ84j1K5m60lLhIgC9dgXqH1Jn5QUwQGNtBpruymCLOYlj8jF6yU/IZqYbn
         nJ9A==
X-Forwarded-Encrypted: i=1; AKwUvBydm39/dkXA+VaINHwNucHApZR3m43tk7ONxeMlCzYJh2Hq212ZJWQ+2jw8cVm5k+jrKnCwPis=@vger.kernel.org
X-Gm-Message-State: APuU4Z91+f9bSiQRslqtK6SafMEYBSx1gviMCj7EVPy7WQCz9nrX1UQg
	52Hpk7LbjUhQxACM0l+xT7l5TTYfHQz8jmkont7sjk4irw7s2NLJVStNACMCvbvvhA==
X-Gm-Gg: AYBFou3mS6Mbo1fkzj5YzncuCOr0grAKRxe0bepFyzAidu2isuycMYuwXU5EDqPeHQP
	F+l9gv7BQzvbklOiRP6xRelBdwG5MNZ+UWwTnRIiXVqn2rvJ8cFqD+dnCWb+A5TLcXVpsn3KcFu
	AgzQFfGfOD+qkaUyhRwloVzMJZ9EjB1uAs14SdC8yEGAaN6S3jux3NPSI2hADdVc3ErXue6GOcr
	o3FgJBvf2lAWjYcwxE5u8MkQlGEyz1K5VGYUWfJ4xRy8V4VOtsiPsulaapTgHNCVypa7fNtrixG
	ILVYHlTyfcuoS6KwMKmzVyQEKNQIaTRhVQX7Gw5J3TMVHNy1RGmBxWBEqmgMgteFAIcmutvXI7C
	V4yvu+gD3ldwCqAbM41FdK56/cQDfNRfOE9KHJhBZKJdliG5MwIhMFipL9XL9z1VdCaXEPZQBIA
	fuT/ST3VIm3h/e1IXa3EDMxNUjJ/qa2yxt1t3Zbj524yTt0gxI8Jat9CUKWMN4Bf6zsn8wH7q4+
	BE144trt9oLXZf4NOTmCGv+u48dqmpqtT8Sne40oTJkyMHSCVxFJuTVmyjO1U3tUeSsIM1ijfCt
	hThV6LajTASa1pQclxLKdBr1rR8/+iAD0NQaRUHBTb0EFWX4gARy30Dp0IP54tPur7c+
X-Received: by 2002:a05:7301:4203:b0:36a:50f4:ed0d with SMTP id 5a478bee46e88-36a50f4ef92mr16355856eec.25.1793735350827;
        Tue, 03 Nov 2026 11:49:10 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36ca38a54ccsm382104eec.4.2026.11.03.11.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:49:10 -0800 (PST)
Date: Tue, 3 Nov 2026 11:49:08 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Stanley Jhu <stanleyjhu@google.com>, Jens Axboe <axboe@kernel.dk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Alan Stern <stern@rowland.harvard.edu>, linux-block@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when
 already active
Message-ID: <auo6tLmH0R4_TRG6@google.com>
References: <20261029040001.2100001-1-stanleyjhu@google.com>
 <8125a75a-ea47-49f8-90e4-7f7c83db90e2@acm.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8125a75a-ea47-49f8-90e4-7f7c83db90e2@acm.org>

Hi Bart,

On Thu, Oct 29, 2026 at 09:22:23AM -0700, Bart Van Assche wrote:
> On 10/29/26 12:08 AM, Stanley Jhu wrote:
> > 2. The first runtime resume fails in the driver callback, and
> >     blk_post_runtime_resume() sets q->rpm_status to RPM_ACTIVE and calls
> >     blk_clear_pm_only(), decrementing q->pm_only from 1 to 0 so recovery
> >     commands can enter the queue (intended since
> >     commit 6e1fcab00a23 ("scsi: block: pm: Always set request queue
> >     runtime active in blk_post_runtime_resume()")).
> 
> q->rpm_status should be changed back to RPM_SUSPENDED if a runtime
> resume fails. The changes made my this patch don't look right to me.

Pardon me if I'm misreading/misunderstanding, but I believe your
suggestion is essentially to unwind the quoted commit 6e1fcab00a23,
which might reintroduce a deadlock.

Brian
