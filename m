Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836912931DB
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988812; cv=pass; b=Zl4wizZRslKqPuYINbH3x5zx+UrBCI+zOJjmg4gGCgc6gYrgOAQIs4mIptpNSvZ9mdK45mN6oAs7kaH9AtKkQUINfu0Bu95EXzgfXI8uFo5u4m6oiimq5nusWTxe3kcyEhw4OYmS/lHiLQJVyEqAIj0vxBgoxNRO68jjwhzMlk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988812; c=relaxed/simple;
	bh=4e8bnq4uqeDB4ByQIfPWcHVGt2zIh6CjmAoErXIimQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeFjjWFzljTHOrtLzixL9eL3VfDFwU3yeQ1wIyv7BqqN0cSUFrAJwLOOtsxT/iMNVqbSIIcwgXW6s7VWKdsgd+nVA7mACfudjjHzaI5DqrHNWC/qIOYFwW376JNSFngT99EsZD2QwVx3u+kqi+ZyzkMrBL6dsMFaclo2GhtcgZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6TWV2VB; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6TWV2VB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2074710751so580607666b.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786988809; cv=none;
        d=google.com; s=arc-20260327;
        b=lYDy4H6LXD4pkHY8QF3n5sPjY/Cj4Z+OZXLvsZ6cc6GhvU2ajDSTaQSMYaq2WS5tHW
         ctiPUpfNUUBNjBTFwTDjTsclmgsN0TUfad66ODZm/w9Da9lft77ZfxGchHUbEatzgTN3
         nxuJElx/uLvnuNf2o2tRDE118JTHdifTM/FkMqNMQYgiyko6At+XAz5oRWqO/jeg+Wx9
         t6sNQ2kyePQYgJi1h7Y42GKM77JFFtRbFW02Jc0FbFJAqqZ7IObpRAyD+iUiSKHvDuI0
         m2qMuxWgCvx5Z5QrxIfL2+ft5D/R7d1iDDsA9v6wvVskVCp4XEdPafhfyY+8jdA7Tzn3
         e8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jWfq0kQUzU36ek1O4g7xTgNjp1pjDO9soQYYEygEMxs=;
        fh=CQfZVzDbEeK7BvpeCu3DsfR0S0Avs+ojaBdmPTjtF8M=;
        b=qgGM84ke7Eaf4FFjwHzfaIIqVUL9KwTx1jxvxHDVrzSpD4yMex89fwtWgLuWCCa0Z4
         PBQnaNNUHj2aqWnP8kOgBcQQGzAOB3tjvINg9IaPm+A5leRa/3+Awo27+AtosNtGy1c8
         k51Kvve+TMOVaeqMZQV4i1uEbKfPu3bQAlhWZk4AcJCmUd0GaBjtt6kA6W2FvDk5+7kV
         Pd43g9GTbA7EQO8cvNvrqNYTl/prh8nyE6vhYJykTjF/moylYiR1+MV/bRJJjxejEQoc
         FdMyREUPPOf00b0Rm0A7MnRP0lNHU0R7UtcASLs4L4Zif1A+cq6MWoltIn1WGaRB1HdI
         9Jvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786988809; x=1787593609; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWfq0kQUzU36ek1O4g7xTgNjp1pjDO9soQYYEygEMxs=;
        b=m6TWV2VBalAuTANPz6GIwUc6oRKasqEVQ5tZf3aLVqkAH5wTwgjik2lIT6uH2vez1g
         k2cR51xb7wK9EOJHFDRjGpnbpHlR/m7fzzApH65bOsgnqQtpDECClRlwzHoydpl7v1bu
         St6fvfGoQttmxadfBHMAkz8hR6X23U1XZyw+p1XsX16agHidGha05BLG/jcSzP0Iv6UN
         nWG+ippIxll/YKVwMGfTGlOMbrEqwuG1MS5U7sLN+UtPHyWSusQRM4NOo8GqDmGPrvBV
         OVL6AP7Sl74tDsvI3ros9tXjQ8ILvJaQocj/fVzT0EzRXjfntHcCiyNVKL2jiJeyjK2J
         bCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988809; x=1787593609;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jWfq0kQUzU36ek1O4g7xTgNjp1pjDO9soQYYEygEMxs=;
        b=Nl8hGQNuhfqAUvDqtL+mURZjeAHC3loExdA4zQsmWEzuSm4liOwYIcGQ9bFOz8hUQC
         RTBbz8TuwknAF4goHIVqlywHVkWjn9AbRf4sQvpVfFWsWlpAGLb1D2e6ttQKegfEbkb7
         8LzqAuMlEcwODmwDSDcMawIVXEmCSAfe/ObKS1qVfO+39BNwYRuM5qneqWSzRx9yc4em
         TcGdtux0RSTOImLSZZIbosKtjMETq77CPumqkoKZagBS9MNO0/jufJUB2zuiVz719CDB
         H4Upovhzv0/oyojT6JSQkhlKq2GgT1KSWi6ceVJMiRXihKQ6Kt2xrtTGcIcsUW7DsbDQ
         rM7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrUpFOltR+saQ3mCLwewOPzrAe+7HnbsgAWsmOFuy5AGT5smivuLhpCM6BLxM2cD6EmSQ1rB2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvk8NYVl3JvGDVMYtyDmr+yVvFdD+fHvH4voPPvJwWbNOtWWun
	Nn4fNvMfNYWHDDXS7oFnFq47bzNci3kQLmmpFo2fkg8JQOtL9GNuqfj6+Bym3U4crtpoI05YDzQ
	ndKxfbHTaz1zT3RSoZjLUNqjsfjX4gNA=
X-Gm-Gg: AR+sD13vZwmBd2dDI14Z08CUsku11XHs8huW9gIHClx29k/Vwn5btMQoM/Up/+kuyAV
	rm8vlXzfrMoKM6SJ2gYMIp0j6qslMR0KPQGMe3vqmyVpoEVtfD4J9Cxh17brGNdM+7JIjjB8g4r
	9o2pde7lqoTEZ3SkJJhXAFoz+goQkZ3KGyKr8GU9Hf0ma4qmhqybXio15QsftSahuOUSVAKyqpI
	oTrj+QQIrI3ONG4xereLxZF/HNzp5DuWHyX++HQm+i4aIroB16C14gelKsfO3dwXEZlLKBOWY3G
	5bXBjtPRJZ9ysVI9XJoQ534tFfT0W32IoDALrJJAgLIe
X-Received: by 2002:a17:907:c80e:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c2129b5702cmr1272623066b.9.1786988808440; Mon, 17 Aug 2026
 10:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816191729.2865523-1-coshi036@gmail.com> <20260817065553.GB16255@lst.de>
In-Reply-To: <20260817065553.GB16255@lst.de>
From: Chris S <coshi036@gmail.com>
Date: Mon, 17 Aug 2026 13:46:36 -0400
X-Gm-Features: AcwNN1X5x44M7lIgndIl0Ch0i--1X4X4Boan2SI4Qh3MU6IukQVLH7-NbdtLCb8
Message-ID: <CACd_6n0FoZo88kqzN0X-n6aOXKTeqDL5XwdgEaxGVkfGti2gkg@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

Thanks for the review.

> Did you do error injections to get here?

Yes, on the device side rather than in the kernel.  The splat comes
from a fuzzing setup where an emulated NVMe controller rewrites
completion status codes.  In the wire log of the run that crashed, the
Identify with CNS 05h and CSI ZNS -- the one nvme_query_zone_info()
issues -- appears twice: it completed successfully at boot, and on a
later rescan the same command was completed with SCT 0 / SC 24h
instead.  That positive status is what falls through the "ret < 0"
check.

> The most common case for this is probably during revalidation of some
> kind, and then we'll just keep the old values.  Which in general
> should be fine, but might be worth mentioning in this comment?

Yes, that is what happens.  queue_limits_start_update() hands back a
copy of the current limits, and nvme_set_chunk_sectors() returns early
for an already zoned queue, so skipping the update leaves the
previously validated zone geometry in place.  I will spell that out in
the comment.

> Also we should probably log a message that we either just register
> the handle or keep the old values?

Will do in v3.  blk_queue_is_zoned() on the not yet committed queue
tells the two cases apart, so the message can say which one it is.  I
was going to use dev_warn() to match the neighbouring zone code -- tell
me if you would rather have dev_warn_once(), since this runs on every
revalidation and a device that keeps failing the command would repeat
it.

Thanks,
Chao
