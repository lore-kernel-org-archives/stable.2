Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5483FD971
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535257; cv=none; b=g4F0xHHbXgrsXZBfdnXbY4HdNhic+YMlZYRwmpNZLaxiQ0NeuyQURMDE+EI7XvAq8yGoRuJljSkXrdGH1IBTKgCJ3j+f5yGAfVPq5io1EjGsWDUbZI8F5W7L2IC/ob4epg2N0oDnAkcLjH1QO29WSZLX1Q8mntL53iql12qCjn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535257; c=relaxed/simple;
	bh=KYBcS7h0pNuUxhCatDx8FkyldB1WhenoX3VwO+hlFKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewMz7RfxS4g+vHVOigna2Mnt+L2SdpuqPW5uT5Xl7s/binidWv74D9se7bRX+AmAVa0dnLlWQV58vd1u1Xj2WyqvlAPJ1WIz4ujx7fheMQh6kHD7UmtatMmFIQzmrxgREbkCR3gFKYje37uT5RqY5Ky4KX7jtPBk2sd+qKPxvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I6U+fGUn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I6U+fGUn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490be03d47bso36556825e9.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781535254; x=1782140054; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmZs6H9aAPAvXyfQHo8A/76oZU6GrjxGn5dT6papBg4=;
        b=I6U+fGUnmTPvxmxzjRlkS4MQ94VqKcEw6ZFKest3+ZNQ/qFrhhGWthehbgGfdsXVuj
         tRjelmrXjtBcM1OYa6stoULIsKvm0rLypq7qOF/MGA8NdhSHiRJUGxLi+iXc+zkPxZih
         9TYdPjPtas5SPwLMiveei6UrWs2cg8URlsBPPxU3BlNFFhWRU550t2Rn/+aANy4fuwb+
         fi3gzTzFSnywHuaJ8gP/55Je2uLRWfOImeu9OxI2NERhv/efAqnuW7c3IFsTNZyGOm/U
         V7ChYZnuLe3aIg/oPfCCVQerFyliwEqahsL26rhjUY1xHrSyrOqgXFjObCSoIyQN6ST6
         6ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535254; x=1782140054;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmZs6H9aAPAvXyfQHo8A/76oZU6GrjxGn5dT6papBg4=;
        b=sCUnVxXZExxqnI/lIpoyapnv5RQFtckhI6XdWlyDIo7pCLGcYFK7XFWhp0RNWuqX8+
         WUvKuV7Yzie1eM30H9Q9HYJivLkjRTvRVPFkpS4JYuMh+7YG0ZqigiNs7KxkUN+GW62c
         Uc4SU11UcNy9cuPztLlD9jh7n8D5NxA9t53QRAWc1a5qyzVisSVytJfGtRudgzHAgfqS
         /irBcBBCSdB6FX+2t+8gY+9/zJ8ClqL2eYwasPw/Fv3T4yryglkuvvVsBlp5ks+QouhF
         H/5sYVjpa7xlYRuJtWHcRg9LBgNHDQmLFntYfzkQHg9FanDGaHtWEZVxt4fXWQkz7PsM
         g3VQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iygWg5s6fNY732kuqzAotEMjf0q9DVWhyZqAZQkkkYtVFcRNFKhJ5xCOC5E7swLG6SC7iqHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+dDp/1W5CO76eBS4+d7p7+sLx383dqUUaIaLcNLYX8qjoLyx6
	a6pF5YcRYqvJPoNe9I5vOxFxaJt+Kmx6PFYIq01mll6vdxgiSOLE//ulr4jBZfvusU0=
X-Gm-Gg: Acq92OFvng6ke+2ED0wwQRST78QwUo3h4aQofSahCCfZcaRqP3tebWUSkr9BN8PlNM1
	vgg0CeUciN3yLU3eflyyCbBUITnwB8O9DDhoRqPhXKNmyoNrzeKz5wUvt+aOJZtRExsBexxFDKj
	jzV7zUL2KUnpyGW95HDfSqOoK6+LbL19fF2cN8Knak6T18Dad5CedNlVaodfnFM8XEH4JnDIjP/
	8+dVbJ9h8AbsOjWYSlRt+3wivNq6/AiTKHER2qg/jh7F8fbGyq4hEwAyxN/dgZToVC/UXL9oNeM
	WzTXY4fPGSgdyQCnCcslYZ3Qr1mE1TtIBAowLAtaaOw2kWIXHiYlfLMg6L+kl5mF7n3yUxII2f4
	CgK0KDqI26xZLQoIzyOj6Uzm2FeuViSBQn71F3k4cRnSKozgE0XOJT2iAKiTZT+E8RWNupuI2JT
	T32hLy0wTaxftttg==
X-Received: by 2002:a05:600c:3512:b0:490:bb45:79da with SMTP id 5b1f17b1804b1-490ec4d650amr196478285e9.13.1781535254039;
        Mon, 15 Jun 2026 07:54:14 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm16670216eec.7.2026.06.15.07.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 07:54:12 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:54:06 +0800
From: joeyli <jlee@suse.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] debugfs: Fix lockdown check for mmap_prepare
Message-ID: <20260615145406.GQ11413@linux-l9pv.suse>
References: <20260615104750.1000-1-jlee@suse.com>
 <ai_fWlr61AzrNrDz@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_fWlr61AzrNrDz@lucifer>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Mon, Jun 15, 2026 at 12:18:29PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 15, 2026 at 06:47:50PM +0800, Chun-Yi Lee wrote:
> > From: Chun-Yi Lee <jlee@suse.com>
> >
> > Commit 651fdda8406d ("relay: update relay to use mmap_prepare")
> > changed the `mmap` file operation to `mmap_prepare` for relayfs, but
> > the lockdown check in debugfs was not updated accordingly.
> >
> > This prevents debugfs from being locked down when the kernel is in
> > integrity mode if a file uses `mmap_prepare` but not `mmap`.
> >
> > Since the conversion to `mmap_prepare` across the kernel is not yet
> > complete, update the lockdown check to look for both `mmap` and
> > `mmap_prepare` to ensure comprehensive coverage.
> >
> > Fixes: 651fdda8406d ("relay: update relay to use mmap_prepare")
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> 
> LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>

Thanks for Lorenzo's review!

Joey Lee
