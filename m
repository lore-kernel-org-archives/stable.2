Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C9361972
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736899; cv=none; b=f7ZFIAA5e9glhrhnzXc7UCHIoWRtrb5pU/RdA24zKKnIeqT+wZ+vYVzuJ1pG+5MgyAjfR7XFOKesCsa1MGr8XL+pcmydQn50gd9wC34NRWpZEWxIr791ejsIsjoVf3b5lB8ElBfhAtR4gRaX0sih3iHnKhFqcNEeDve2Lh63ja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736899; c=relaxed/simple;
	bh=QMnjzL5C30Euh80Qp1VqHr0pvJM1tM2Bs4dHI2dErf0=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=cttLmc+95ojZgsDSGZEmyfGAhv/UfFyj6vUszzSrnm6ub4VZyP6x2RqW+h1JULhz9gNr/A1rhvhVnSOaQkIBAmMNosxu6N8AvsOrZtkWzOzCjCxJyCaMT/U9UFFeJYxW3dLwK3P0j8MErQUUeKbflCSaTFIyXsW4PgSEkcHCZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZq7yz/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZq7yz/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646D31F000E9;
	Wed, 22 Jul 2026 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736898;
	bh=civ6QRSZPkfyDkOFOd3Tn4RsSHqGDxY0c+lLRCXYCfc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bZq7yz/1aG2D4G90YtqOhq1X8nHV1oyh2ZyDyo58MqB2l/U5mlwqdTSLVZYDkReyo
	 PVS9kuqE9nK7xpPaOKB7RHkU0ZUXl/OFLf+RHznrVV+TolyVwSONLQqkKIb96SPITv
	 pKVpsE67iUl8iYBw3bg7SnDhmuC8Pfff0Xnc764uu5y4bEQ4pW68DQZ609JlEq9sVn
	 NlTbHqHpFv0BSN3HAMUeCJfa3vF35IeDQ5ikaqIylqWVIcQbNEKFl2NORwmzjSoNeV
	 b4UzIbJgyKmrj0LqI2+gkKwdgZc1aGqFeTv+TZpereGE3y7a3crgMsl+6DBMZeFF9h
	 aZoj0DBfQuTvA==
Date: Wed, 22 Jul 2026 18:14:55 +0200
Message-ID: <20260722155049.973195593@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: tglx@kernel.org
In-Reply-To: <2026072141-ravage-display-0696@gregkh>
References: <2026072141-ravage-display-0696@gregkh>
Subject: [patch 5.15.y 0/2] rtmutex/futex: Backport of rejecting fixes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

As promised the backports of:

   3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")
   40a25d59e85b ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")

for 5.15.y.

Thanks,

	tglx


