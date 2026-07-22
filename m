Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587D361972
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736881; cv=none; b=ezkKxjqniiOZsOhoLSGE52BGkpUOF9W5faGy7EMtcOMjdGP7mw4vF+gELE5tIizXxGzrBI6hhkR36rTSt77x9ptClS5CnHfEQfN49dW1KzGwjbQdvtz13N+nTmnlGKjxppOmiEv9djMJpL+d8ZSSYqzUM7cXsSlJf3dlCtQ2enU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736881; c=relaxed/simple;
	bh=UVsyAsJnYLt3KHGaqvlDpHqK0M3cX3d9aJ+cFDVZaec=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=l1hflf5TdR/CfVO6nWz2RgeYOIKnPfWtYSalwXidPyTnYUJnQohOUix4mxNoYQQg4aWJb6I8OvXp2uSgUxgH+h8UY4DApi8X6lO5ICow+Ios2Nsrlh4qAA1dt2cbFykEdf6xL+Eb/ImjPaQMA00M64XGYMLrAptdS+bQnrFiw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqi0gkac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqi0gkac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148DA1F000E9;
	Wed, 22 Jul 2026 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736879;
	bh=yf7kXKxGIBhdnGIVEOrzEDw7IwSdZx3Ehij7GR85b74=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Aqi0gkacUtrUhuJtOoOd3+9mJWmIYJ44ZOoVzXRv+E1+fSL9oBetbMRLM2BLhQFlM
	 nqEtzXxut5h1Sfl+IQuMzm893z+2ZCwr6pv+ab71gUbM9TnoquAUkkT/aZwdFU7KQ9
	 5UUcQpzYQfNzmlluQMkYhrjd7iEACExMM/4Fd/1OSPl96y32hdA3jRl0TWKaMs9+n4
	 SHm6iVtoq4QCM/IkqOUl76ktiGxkO0RbF3m5Nfcq6lRRIJqaHKi6/j5aUsHixZO+DA
	 w/CEpqqT8goD2grdGwyf1IKl7Cns396ijaxDTuyvVTkE8XEYlGkBu8cSorrzdheFMR
	 tnXTvcLNBugjw==
Date: Wed, 22 Jul 2026 18:14:36 +0200
Message-ID: <20260722152737.461825448@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: tglx@kernel.org
In-Reply-To: <2026072141-striking-reaffirm-3311@gregkh>
References: <2026072141-striking-reaffirm-3311@gregkh>
Subject: [patch 5.10.y 0/2] rtmutex/futex: Backport of rejecting fixes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

As promised the backports of:

   3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")
   40a25d59e85b ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")

for 5.10.y. 5.15.y needs another tiny tweak and comes separate.

Thanks,

	tglx



