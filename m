Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6631A057;
	Thu,  4 Jun 2026 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575829; cv=none; b=fGmhdb9AaF0qSFdWURB9XBqGTZRlvNIAP3tFQUkgjSSUoL2hgd+C5++d8FmNF0B39GoTwchJXCFT6WMqmQFd83vJZsrVzgSXy4sfofvZhdEgbbeNWZKvjlqLVPxjgotvUcEyGMDliIbzfEvQx9fm6J2uyt+c+mHfaLzjh7vLB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575829; c=relaxed/simple;
	bh=PajzQvgqdYv9ANQVnhYfDELz+BsNVw2FuLU7mD82fxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfcBWZsF+lmoOz/zq/I5Poo/NYapatWJi8aQH7OLwgcWONeDPp9302csxbCtoj7zviDAGKHL947hBkZ9Y5R3JU3HMluak3860L2caivutm1iprO6Is6xYAlsiGLm/HUijpYsBHM03cWWkGB91xkzk1a8Gs9gm+tvUxB0TuWCHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNwvmKFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNwvmKFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4751F00893;
	Thu,  4 Jun 2026 12:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780575828;
	bh=GKLKezgv0QscaUzM63UMkdQvv6wICAP3OtvV634n6JA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PNwvmKFhlk0IskFEA+qSFZzyFFa+s/gSIJ19VqcpyQfDQScwWO0qBVPCe9fXkP6ba
	 FbXg75+jwGtMPL8UBE37J9iMEvxEr3ExUENqJ6H+ERE1/KG1Uf/ekzc2A259Zp30Rt
	 skoFxxKUnoXGNN5R+uFI9WX3tgC/cWbgDjBB4j3w3qFOSulx8R0Lp3pg52Iihah/x6
	 eHCJo2gMEdIMhAnJHGV36qsQ7ooyN/yXVBfAyRzESJBKVc5e9EoG7OBriimyXIuDYz
	 38dSCxrMcsF+vGRGJebmZBUIyvVjMbasf/25piMagqUnps0cza/JqT2SdcKDXyV2Ok
	 CXi2TteiBKsxg==
From: Thomas Gleixner <tglx@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>, Amit Matityahu
 <amitmat@amazon.com>
Cc: anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, dwmw@amazon.co.uk, jonnyc@amazon.com,
 abaransi@amazon.com, alonka@amazon.com, ronenk@amazon.com,
 farbere@amazon.com
Subject: Re: [PATCH] timers/migration: Fix livelock in tmigr_handle_remote_up()
In-Reply-To: <aiFJLiWDIVaMQOoV@localhost.localdomain>
References: <20260603170139.33628-1-amitmat@amazon.com>
 <aiFJLiWDIVaMQOoV@localhost.localdomain>
Date: Thu, 04 Jun 2026 14:23:45 +0200
Message-ID: <87a4ta5wa6.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04 2026 at 11:45, Frederic Weisbecker wrote:
> Le Wed, Jun 03, 2026 at 05:01:39PM +0000, Amit Matityahu a =C3=A9crit :
>> Questions for maintainers:
>>=20
>> 1. What was the original rationale for the cpu !=3D smp_processor_id()
>>    check? There is no code comment, commit message explanation or anythi=
ng
>>    in the original patch's email discussion as to why
>>    timer_expire_remote() is skipped for the local CPU.
>
> The rationale was about assuming that such an expired timerqueue actually
> reflected a timer that was handled locally already and so it could be saf=
ely
> discarded. So we could spare some locking.

Right, but the assumption would only be valid _if_ the jiffies value
which was used in run_timers(GLOBAL) is propagated into the remote
handling.

>> -	if (cpu !=3D smp_processor_id())
>> -		timer_expire_remote(cpu);
>> +	timer_expire_remote(cpu);
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

I'll add a comment to that for posterity.
