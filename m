Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85E350D7D
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788760; cv=none; b=OAX0FdrkKCViA5l6dadutkP1xh9IOm24dVZ4GPg/1vCvK3MCbCiyxVs2WA16pMBp94z0lPfMX+t2+PNQIgCDTj2rpHgZdS2fqG/WD9rn+Hjkmj+nP1b1M6PwKeh19kiYM8unvZLEcHOu1TRy0+0opVIrMz3RCxf2ilVghO/J52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788760; c=relaxed/simple;
	bh=ZYFZixZOPs2wnUXFfo2fKzeNQImuiBllWcqh+tEw9GU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D4xoNq74XR6Pf+HVd7UPLQ2uVzpEkSv1JOw/xGSXFyv+f6fZffCPxs1tx4635ojQYBCs9TZsjh4VcgffW57fLxZpvMlSo8eJY66qBiGh6lNXAezByn+GRd9FVy+YqGdjt+34VPJLQM7+kD8oMltqiKAx6jC//4kB+EWu915ynhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UM+gxFh6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UM+gxFh6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so127353b3a.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784788758; x=1785393558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r46MXPNPzCsTmVT3q7BLWnTz4bE7Z62X/8s/DZiQF8k=;
        b=UM+gxFh63+qlL/DMHQbm/WHA9DV5EmiH9yDfiZtP5tRJ0FROQ5lcuI1mzrw2xjDH3A
         qgtbTQsXxeBHeGIpN8GJR1TSSmaOtaELr+8bQEN3s5nPuB1JhHDspmzQClPDLUkkTKLa
         742JJ4u0DHvhJeUVQ/dXrnO3Kav+9lr+W6fqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784788758; x=1785393558;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r46MXPNPzCsTmVT3q7BLWnTz4bE7Z62X/8s/DZiQF8k=;
        b=goMlgSWiJyklRX5m1PYybmeCb8D+3zTbgyfo/BIJUyEMo+n3e8gD4QtFYo+vTDvwA4
         h7pg3vxF5skdOxoWiKclf/R6jb/4JZPLdm/6okfoTMI2aF6Vljf3UAC/AdfhTdBI+xFV
         0Jh+U0KzxYJPOuX+ZESmrjq5FsKXp9Ni/dSZNFaJ2F79FPGtuQDBncLRzfYmrbNBzp6g
         w9dqTvaN7BVkv4IicHnUZxXAt/8dLdcGE7h7W3hDW41WtKcV1IP6wxob2cJkfa4tYCTJ
         jqiSK6neRtefQqDkJYi6+Zp5xSQ0sKfmXBTBp6LMg7i/lr9sIIWhQNHN4gyDCfRdewSp
         ERmA==
X-Forwarded-Encrypted: i=1; AHgh+RqDS5FQlXZx2Ah9jkxJTSznLOGCWQtmM6CD7yGMuD6F2WHNwTSH61Y0vqipTAtCwQ0+hxqL62Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KDlI4WXX7HeoSz9+yJHy915Z+BNmtYts4eQ++rou6htshJKz
	rMxZBvpWch1voHKIY412zxBJ0Rxk4CeaJlmfrET/8/w4L5KWiEg7tSr6BcdixuU4Bg==
X-Gm-Gg: AR+sD1098DiGn9emAkfTcZSTQtpcSqcesDKm+mDNYjzw4tfENmJAMaIXCXkwQS6GahX
	nt8IFnNwdEDmWnINNBRNzpEI2qgCRqo8IGOtX8dBP0Ek2UuTSI55Egz28iwz2D4HzSrlGnT1ord
	3fp4gs/Orhdvlw1N99ideCNObwq5t2Ot1e5blQD/WR7wFiHuh8jAnEJ5ZV2WIw9ce6nGYyyjx9B
	MsuMrNZ4164SRbE6VtumxH5ciMa4gNXXEqJtT4IletutbMGw3o04gs3Xtj0PU+9puPZdJ2GCJ5q
	0ZTuYOJgD4022GvEBmlW2twtEuualsXhaWbNfb78J/sMBZELQtOIKx1StXpMHpK6XOI3ElILfuo
	5bLBVoxaQUqfrf3MXsaaTRDO8IcvwN4HDgdGvcuqUkrwVXo0EIdWukmKhGhfqugR9C32sscmeDU
	e7RoU4WJEKVVogkKOcVlQMeIZ9GlGYUBjqyVyCJQ0jaQ==
X-Received: by 2002:a05:6a00:e13:b0:845:eb00:ecbd with SMTP id d2e1a72fcca58-84e2e92a730mr1546905b3a.21.1784788758183;
        Wed, 22 Jul 2026 23:39:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:2d0e:cfe6:a39f:d530])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175d4133sm2478570b3a.50.2026.07.22.23.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:39:17 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:39:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <amG2jCgWugrVroyZ@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>

On (26/07/23 15:36), Sergey Senozhatsky wrote:
> > Sasha, Greg,
> > 
> > this is the backport to 5.15 for the above CVE.  The fix was relatively
> > simple upstream but only due to years of refactoring and cleaning up
> > of the code; fixing from scratch is not really feasible so start by
> > applying the patches that are needed.
> > 
> > Please apply this instead of v1, due to a missing line in the last
> > patch.  Sorry about that.
> 
> Sorry for the noise, has this series stuck?

Sorry, forgot to set proper In-Reply-To [1]

https://lore.kernel.org/stable/20260626174620.1819772-1-pbonzini@redhat.com/
