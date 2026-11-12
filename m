Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476029;
	b=wQEV4zFPFwuOXuHV+ksYW0Hg4xSpptI65A9Owe9Lm6vumIcFIcST44tGD0VP6+31oLIn
	 VadtBowJKQS7m6fSzwkqYohsujv0Nf/Fhp20ASh70YScvBlCORzILTJaG0c4AQfsSOMN/
	 wyeIOso4DBYUkz+S1EWcl9ewxERtwM/F6jfjyQV4ybNFwnQWUoPMEu3HRda1yP0Pjlvmo
	 FHd2kTEohL2wyN0brtMmLKleqVzchOm4rOWP0P2LiVv3furkxgRmL19BGgdtFfGreyDjw
	 ydZR5B1vIMGriy4iIQXV9h0AfWKm2bIbjvz58g4W3TelnOItkiNSBtp5lUEhGCmpLug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476029;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=LIrhVpNAMQnwriu22bOa0PqtW9YlSEthziGhemny7Ms=;
	b=4o0hCuFJxQ9pK0/qJeEfqyjTcgc9y8TxDXdzZNDNKwJEj5E3Bq2TdSUN0zvo/mYIWID1
	 zWPE0yYE1JN6xv/ZjZSaxgkv3lvu32E2DtLJhomcyggEExDfMoFApyPc8dwaHqDinPtYM
	 ilpYeVn5dZzWU9yAs40xCbH4aW6i5YHCwDeYSITkk44VDltgpNZxGPci6M4/oMabF8roJ
	 r9hv63Qfolfxk2Kh0ZMR/xzKW9TZkHrfQTdHCWHBx/bhvzd5ouqPM5inLAD1Vp7qGnIzu
	 hqjeGHrKAMSqcQHaZbtGFAHNctXY32Nr9MjuDwpl2xKwvlnS5hlH8FIo1lOlZtxZwmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=puI8dU53;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB49606A321;
	Thu, 12 Nov 2026 09:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EB49606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=puI8dU53
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LIrhVpNAMQnwriu22bOa0PqtW9YlSEthziGhemny7Ms=; b=puI8dU532w3bteGL0lW/oF1t9S
	20zPt5U/I9Xawvgy/6VwNm6MV0lfqy1sEMo2zmiIGyfky+MaXBzUrXdIZDSJOjnQKPjoGH6kx6rj7
	VcWdf6/Q2CBhYbnGJNDYm8k52wcBoSYbXHgwCNcgMr+1B+1an6PhPRbbvKwVNoqYI7s8ZtFT4/uUf
	3qplPELIuLv8Y/9S56t9/6NvAe4lYrKV9Oz9uWWuzktlelLvzKxoBrijs5rjDZ2+IRY+YJhnIACRj
	wOT/XB0wsOn0xgZUziRRw8mK8KqWF19PCOHmnagYyQ67hR4kOG53t+n2s05/rSJsyZwQlf+EXFyyb
	dwQ+AYdQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRRBQ-00DreI-0I;
	Thu, 12 Nov 2026 09:33:28 +0000
Date: Thu, 12 Nov 2026 01:33:22 -0800
From: Breno Leitao <leitao@debian.org>
To: Oleg Nesterov <oleg@redhat.com>, akpm@linux-foundation.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, kernel-team@meta.com, 
	syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] reboot: halt when power off fails
Message-ID: <avWGu4l_nXP_eFyh@gmail.com>
References: <20261110-reboot-make-task-dead-v1-1-af88a3f37bf7@debian.org>
 <avTJ3o-n0UZS0YUj@redhat.com>
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
In-Reply-To: <avTJ3o-n0UZS0YUj@redhat.com>
X-Debian-User: leitao

On Wed, Nov 11, 2026 at 09:02:38PM +0100, Oleg Nesterov wrote:
> On 11/10, Breno Leitao wrote:
> >
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -791,6 +791,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
> >
> >  	case LINUX_REBOOT_CMD_POWER_OFF:
> >  		kernel_power_off();
> > +		pr_emerg("Power off failed: System halted instead\n");
> > +		/* kernel_power_off() already ran the shutdown, only halt. */
> > +		machine_halt();
> 
> Agreed. Even if I don't think my ack has any value in this area:

Thanks, Oleg.

I tried to find out who merges changes to this file and it is not clear.
akpm seems to be the closest, as most of the changes went through him,
and somehow he was not CCed here. :-|

Andrew, would you be willing to take this one?

thanks,
--breno
