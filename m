Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069547;
	b=zxu9DM/vjJhmRGghrQIiKnp6zDkanTw2jYrIpzQcr2G+2Z1xaK0xUyEq53Q62ama77Xe
	 LOarqnTxRwh2NmmTsJ4TDE1FzUvpSCT47t0zhoOXMY0SnDBOTo3NnbnLtKcL86swwo9Bn
	 PiOB4VVDSrDVj/mi3wwQEcEptmR/EcLJP8mzTYmAKaq1I/E09fwDNs9Zi8ACuXxkGLGdF
	 WAECsFDc8DObX5uZmk999pZO+0Iw0mK4BL808dsbdGDRT/3orE4BC+NMUszVMRykAECCE
	 y3hDXye8Lkc6X2sqbGMzhaYNoxgj8L9Su37owgQri9iggdJRxzJ6yEiXY8iUaw2NdSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069547;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B13IPkujBKrzvAEG/EO28Xz4oMqOP3ahOkyfpShC1r0=;
	b=agioWqZJJH+pw6siWdPJoArz/Uq503POuDKPkVMac6vAykbgkeA8xtx4XLo2/j9YDEG7
	 5Qbkz/uKOqZZORkSunC7OJyFFYeHBDSZOaGILgTWhNRBohhWrBFZiEkeN8kCZzFdBoFu7
	 24bIR4QvdRdfhTsuLEoN1GO1AjUQ8sMHDd+yqsuh7m0QW1h+uPtLwRffXEBpfvuD0hrxG
	 pX18waossapjLFy4wex9QeJBKpnpS/90aClz5+xNemKOx62gchzHxox/1XkUEU4/GZ5IX
	 trYu3/1yHkHeaFV0EaH2OKN/5unmRe+LRjShBSeWvuYJ8wEvEIWewy38N6G8qq0pi9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=covCMItL;
	arc=none smtp.remote-ip=91.218.175.84
Received: from mta0.migadu.com (out-84.mta0.migadu.com [91.218.175.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08691606A32F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08691606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=covCMItL
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aPv5vtAhvmvZ1Ntq8qJPLJcnAl07+2ec2bP64Rkkmn0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795069545; v=1; x=1795674345;
 b=covCMItLnxl+a6RDjXUYrwHFDRALfeG+WKnuWjdTNjmUmvjYjXLOhl1XhmI+NIHRz9nwdcDg
 wmngYsEwd2WFoeeMF9ISlJ7mKwtB+OxS5yv3r26E62bdG5KbUmV1N9jaXIZdJ+tjvBjpSL5j+dX
 72aaXNyICKNBjvcLGkaQpfrI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a813b69a0796f372;
	Thu, 19 Nov 2026 06:25:31 +0000
X-Mizu-Trace-ID: a813b69a0796f372
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Qiliang Yuan <qiliang.yuan@linux.dev>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] dm thin: stop waiting for grace periods when activating and removing thins
Date: Thu, 19 Nov 2026 01:25:25 -0500
Message-ID: <20261119062525.1488091-1-qiliang.yuan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119-bug-dm-thin-rcu-gp-v2-0-055d627763c3@linux.dev>
References: <20261119-bug-dm-thin-rcu-gp-v2-0-055d627763c3@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 19, 2026 at 12:24:21AM -0500, Benjamin Marzinski wrote:
> I posted an alternate version of your [PATCH 2/2] that fixes the issue
> I mentioned. Can you verify that it works for you?
>
> I squashed it with your patch, since it your original patch did most of
> the work of fixing the issue, and it seemed easier to just have one
> patch to backport to fix it. I could refactor it into two patches: one
> the fixes the bug, and a second that just swaps the synchronize_rcu()
> for kfree_rcu(), if people would rather not mix the bug fix and feature.

Ben, this v2 crossed with your patch [1], and its 2/3 carries the wrong
Fixes tag. I'll send a v3 built on your version, still as three patches,
so that the fix can go to stable without the kfree_rcu() change:

- 1/3 "dm thin: drop the grace period from thin_ctr()": unchanged, and
  it keeps your Reviewed-by.
- 2/3: the fix, taken from your patch. thin_dtr() marks the thin dying,
  the walkers take references with refcount_inc_not_zero() and skip
  dying thins, requeue_bios() and error_retry_list_with_code() skip
  them too, and the thin leaves active_thins only after its refcount
  drops to zero, followed by synchronize_rcu() before it is freed.
  Fixes: 17181fb7a0c3, Cc: stable, with your Co-developed-by and
  Signed-off-by.
- 3/3: replace that synchronize_rcu() with kfree_rcu().

Before sending it I'll rerun the KASAN reproducer on 2/3 alone and
remeasure each patch.

[1] https://lore.kernel.org/r/20261119051620.507189-1-bmarzins@redhat.com

Thanks,
Qiliang
