Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404FB39A7FA
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122112; cv=none; b=hbY/wyNs3uIqy44lFnX/4Bd/2Ay6d4LbbMdz3Vu4arURQUgrMXsqDyj5Tuc5lV4u9nDWmPBLjv0oBZspCeQ/UMnMDo3v2XbipaXiNFTxJLtmkfq6T6oLxfvO7eoPdgNuUdmCqYXy9YwK4cpo6VF9kqrx1+c3SyhlEnagV6RZEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122112; c=relaxed/simple;
	bh=22NiOE2gMGGnQ8QJedCdcB66z2sCqgnYoka8Hw/b4j4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=uUcUb4jjhb9KqdSNxP9z5rfzYCgBOkxUbBeMODyQyHbcWRW1eguXUqK7nqtNM1WTnWqJbpjVHsWLeELUVBTpyU0FSPe88qlLwt9ommHs83JdlV8m8S6/gw6+Zu4c1c7TzWSJqv7LHWgbrhK07uErpvpcBNjGvGLa8o6vpG3AxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkdfdwmz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkdfdwmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD591F000E9;
	Mon, 22 Jun 2026 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122111;
	bh=EIQXIFZQ7Fv6o3MA3NeTORGu/XgvCk+YOy4a+ZvIj0A=;
	h=Date:From:To:Cc:Subject;
	b=MkdfdwmzGbpYAbqJi++XfSsLmU4lZLLOy5t9OAD4yQM4K2wgoS0A4wJ4iuPWh/xYX
	 YWhErycJCcQUl7vW73UEBno6uAggx6CND3qIJNaDWTUif8xtxjCWobUkacxQ9ZR8K0
	 b2YM4xAL8IGpxL0c2fdiZhsCzxfkqwRB7OtjtTYo70QLgElWNfpcwDNfxhdV0IFbfp
	 A20WOV6FuDYLoRefGrDVA/igPdzGuJMxCTM0O0kicZtYQKSVfc69bjSdHetkiKszYK
	 F9tITaKFs5NDrj2Nz2Uunk1Yl4HAA8aWOA+d+IDE5DUUIMidXQxOHNZUwn9Q7Xy4+X
	 XN0p5c2rJmO6g==
Date: Mon, 22 Jun 2026 11:55:08 +0200
Message-ID: <20260622092400.929691694@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.6.y, v6.12.y 0/4] debugobjects: Various backports
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This series contains the necessary backports to apply the recent important
debugobject fixes to the linux-6.6.y and linux-6.12.y series.

Thanks,

	tglx


