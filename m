Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D83BB68B
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101098; cv=none; b=I+eA3eASsxNqVgmV8fxxGwHh8pVcRFGqAi4faJ5YYgIVKO7DCV98auRtIz+hJJWX3pCZZtG+uwJJwn1SsbQ9/No2XCQxP7EYfP7ww7sWOj4gBL1fqgaZRfQ1NG/jVgl20q3+JVbH2VS/vVzq00zWhEU9Idr82sQI03cQgH3Stno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101098; c=relaxed/simple;
	bh=Yb7DgxqcQwVF27UqJ9sGK+1QE4BTEem7jlzkwCViXQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sID9Aqyc3MavyF2MRopFigO9HpX/ndmRsJ1wtomBprweRAEutw3cHO4ZtMs8sVaXMwn8v9iWPj53vDA4HVHwyLi19RkI8UTlX/gnwM6G32v+FOPY6ItpjRkC2QK9QnIoM+au4S1cN5QIoVNHRDHxlfL7O8zxRG2tzkCJ1U4OUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGiBSTYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGiBSTYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAB41F000E9;
	Sun, 26 Jul 2026 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101097;
	bh=1xq4I7HwZnComqJYLaX2emPbddaH/Y5Yzw6PokX/vQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FGiBSTYVwwmenu27i7hbMHQOu24YG1L4xME0rYIE0VBS5f9d1/pL0pXyM5zofCm9z
	 /YzgUsuIrqDB2IsPIMfJ9Jj1j13ZgazNj6bGIEdX/SwG7xE4rAkEvyP3YohEV2H28r
	 AUi+VL12QVZvkcbztD6jPJH+SyhcDZZ31Te4b2Cg+CTkATKrN2SJ2ZoltpZRMlXhtM
	 Jdie7pi2H9DEH9g5xHidkWeDxDHzRgiTG9aZleDvaUHPqXydDiMWxyHg0E5uZTV6ir
	 8jrX3iyG2qZ879YdB+AFjvJc8kIPkDmlkKMDTDyZ1TjbTDrENDfTjAddnJf8Nh5z4j
	 fD8479zQ7b0qA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	jwlee2217@gmail.com,
	oleg@redhat.com,
	qw3rtyp0@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 5.15.y, 6.1.y, 6.6.y] posix-cpu-timers: Prevent UAF caused by non-leader exec()
Date: Sun, 26 Jul 2026 17:24:49 -0400
Message-ID: <20260726195203.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87ecgqkf54.ffs@fw13>
References: <87ecgqkf54.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for doing these.  I have queued the 6.12 one, but I would like to
ask for a v2 of this one before taking 6.6, 6.1 and 5.15.

> @@ -714,7 +781,7 @@ static int posix_cpu_timer_set(struct k_
>  		 * it as an overrun (thanks to bump_cpu_timer above).
>  		 */
>  		unlock_task_sighand(p, &flags);
> -		goto out;
> +		return ret;
>  	}

[...]

> +	if (old)
> +		old->it_interval = ns_to_timespec64(old_incr);
> +
[...]
> - out:
> -	rcu_read_unlock();
> -	if (old)
> -		old->it_interval = ns_to_timespec64(old_incr);

On these trees that changes user-visible behaviour on the TIMER_RETRY
path.  Before the patch the "goto out" fell through the shared out:
label, which filled in old->it_interval; afterwards the early return
skips it and the assignment only runs on the success path.

Upstream that is harmless because bfa408f03fc7 ("posix-timers: Retrieve
interval in common timer_settime() code") moved the interval retrieval
into the common code, but that landed in v6.12 and 6.6, 6.1 and 5.15 do
not have it.  Their do_timer_settime() sets old_spec64 = NULL before it
goes back around the retry loop, so a timer_settime() that races timer
expiry now reports old_value.it_interval == {0,0} instead of the
previous interval.

Does it make sense?

-- 
Thanks,
Sasha
