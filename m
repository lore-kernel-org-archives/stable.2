Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CFA403EA3;
	Wed, 10 Jun 2026 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092966; cv=none; b=bp8OyXNZHzm8pqB0oN3h4mEZWJ14fJOUY/fwDf8HmfL0XDGK2CEkFhBKwPeGAYQqSuzazdEXRR4bFaZVLIMKn/yNNOnpCbac2n+b3xJBA4Y6/C25apAXxTZDKYvpDdklXNUoO0xmhQX1ycKNlMaxaL5wYxuua7qAB0HVXRFQoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092966; c=relaxed/simple;
	bh=qHJf5SMQVpkibVV6P71M2cXOaVWl+86IzuhFCb4ubUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpYWfErcWe0hEcz7l0h6x3d6t/7j60I2WEpFlJ8GjuGbBKFkSRZZlGGXxQduggoXAEJRiYw8AymYnSxPYWFw+fH0kuEW6HUHVk8jns6BEknM5pa+9Gg+Hm95sEs6ZL9sMiIC3+UF/UGv8PodWfAxNiZwA3zTfZxrLCvNaeV6ufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk3BKe0A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk3BKe0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59541F00893;
	Wed, 10 Jun 2026 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781092965;
	bh=qHJf5SMQVpkibVV6P71M2cXOaVWl+86IzuhFCb4ubUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dk3BKe0AgK5MPXN4cXrsPuSc6gmYaFHsaauZQmj2gcbedhiMqgnrBcYTQxt5sIu3O
	 zXA5qihqi+JJZ4vB7//PA8NsNiSmuY4+qVwbINY7MQmk0MqEO61QNV5I7n5k7yTdGj
	 KJRIcVmPyi965wZmBGDrfeaoG+xwJVcqlrjdoon0CTos6miAZtgCaLtSAvKP/xOxbC
	 Z/hdW6n5jYmCa+VvkyheriU2HZOXrROG78t3Ia7ITN1ZVJrjBEagxlS5HydyM6gTcw
	 w6+iKw4/ZEikJYPhBUzcRwd4MpBtEYxwr7U4QuE7EQN5vi+LIYJMsEEJlV6BJFzqMS
	 Ydh+dUt1VCOOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	linux-i2c@vger.kernel.org,
	wsa+renesas@sang-engineering.com,
	w15303746062@163.com
Subject: Re: Please cherry-pick commit 617eb7c0961a
Date: Wed, 10 Jun 2026 08:02:40 -0400
Message-ID: <20260610.stable-out-0001.0a78b438@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609031227.21001-1-w15303746062@163.com>
References: <20260609031227.21001-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 09, 2026 at 11:12:27AM +0800, Mingyu Wang wrote:
> Please cherry-pick the following upstream commit into stable trees
> from 5.10 up to 7.0:
>
> 617eb7c0961a8dfcfc811844a6396e406b2923ea
>
> It fixes a local DoS via userspace-controlled integer overflow
> in the I2C_TIMEOUT ioctl.

Now queued for 7.0, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10.

Thanks,
Sasha
