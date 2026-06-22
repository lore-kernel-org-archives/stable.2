Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BF39A808
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122150; cv=none; b=VcFLRN4ipNeIOfRXwiTYotmd8H40Aj2JOXN7pEIZ2pRBUgIppmnrqu05OwIHZ/ajOfepmyHeImDBxA9Jyq8Ij2dVM+iP0o8kTCGB8cDvOEnVgrfI55IxWTIik9VLGvzbQZmBhFNP1kRdlTLREFDMqpqZaNgdOoqvvbGmMXmrOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122150; c=relaxed/simple;
	bh=HDB6j8e5qUiMR8lbBtwzfDilGrSweIwDWioQIiqYgA8=;
	h=Date:Message-ID:From:To:Cc:Subject; b=N8rpW7CX2fS+ba5E40HM0879x3hAon96/bKj8fS43m16+6FFWX/urZyfT8nb+Vs3W+FvJhC2aTrNTnhSjegbm6suONAhRYFme+akG6zZ9LSCPtThXQzSoIrXo+MpnnEMZi/FFtPvnG88u2neTmx1JEovA0DSph6opa1JwuYGbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZLmUgAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZLmUgAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905B41F00A3A;
	Mon, 22 Jun 2026 09:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122147;
	bh=iTFKPSyhCXqiQRjtlZa4vx3+4u7YEeob48ZhJWuBUg8=;
	h=Date:From:To:Cc:Subject;
	b=WZLmUgAcZIlNUYXZE5RPBvo2iIjjNidgbp9GvEQbC+9Agynv5maXd9FRC0rvfEh16
	 sGkBGIbznKOCCW7MwOQhHvXEsl8bpIU763pAzlyB0ioZRl3Q6+2w5ks2CaVw73gGHO
	 KWxqeOIo6RfnCIkT/GVK+Z1eHq1Oy1/60swtk/QrIu2QVJ/3gz6FfOAtY3U69iWEOQ
	 kX0Fo+q3EzUlja70rpAroo6e+aT9fOpYa0Wc6JQvB0UEy8UVkdnpBt6J7vFPw+rXkB
	 gtphwjclCfya5qK4QBit1LwdFEmbZ/+wMWCEfF7Rk6QnKqYA2lfNeg5C+9iaVIq8Ag
	 rhljv6a6/cGnw==
Date: Mon, 22 Jun 2026 11:55:44 +0200
Message-ID: <20260622094345.511524619@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.1.y 0/5] debugobjects: Various backports
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This series contains the necessary backports to apply the recent important
debugobject fixes to the linux-6.1.y series.

I leave 5.15/5.10 for people who are into kernel necrophilia as they need
much more care and effort.

Thanks,

	tglx
