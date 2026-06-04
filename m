Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE723E571
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531558; cv=none; b=eID7fETlw8e4wrBbUQQyG++PJ4/i3EV+XDj0kPL60jEUpMyUbq4fTWe6Qek5xMJY8LK1vyfeMuqgj7LobcD6GzlwwqQHYQ3nxPx8BYsD1PTW1goBWYyC1nKy3wDVixg3ep1u8h9/MpXDpS0oQBLNhHlRkdn7ToPXKHOagl/fkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531558; c=relaxed/simple;
	bh=GgmheByney1OihNYaZYbLrg5n9zOQfrCE6ReLiThJoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDL2VBUfYlzcXeujj4Ig0XgmQV4JMr8RUA8nONV7h6aw8Pbnb+eHqVc2+x3hQkZxskqoYZ872vvQEIXgJumtUzLAAgomjySZchd1EnVZ6aw5sU2EOh0BmB/XP/wVNra7O3YOdL6Ps7OSCEJOxidp8ugFey6p1+X1X8ZgZ5oMzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkBCi6tt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkBCi6tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54051F0089C;
	Thu,  4 Jun 2026 00:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531557;
	bh=G99AG0ZMOLBvwwUAbtYp0zrPRiOlOeE8a20icqlcGDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YkBCi6tt0RgKw0jNUvicHvxyApQvxkLYJ+NvgJ2sZXUZ5Sgp+mWztKKTxuwDhXGfb
	 JXv7Lp8ZIRa6P2ov4JdhKWTxjz8D6llWc4LjNIGyLR2KDhACOGr+vDTCSo+W8hRBUC
	 05vgIh4VGAcj/U2/7/Sfse3b2xZ4pkUka28N4Uq0DEFkLyA8TGJ3qSg841d5LPGlVr
	 YhReQ4qHuObwkEQTLa4LgzuwypdLxrhLCehd+KcBz2KWyXU6QrZzyYyyP1RzcL8ZJE
	 uzU3Ws+gOb7vnGY0NbPwMvCtr5o0K0zsJNSsoGtZf+FI4UaozqUSiwTPcYZT3plfgu
	 3WGxI/advmTfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock
Date: Wed,  3 Jun 2026 20:05:42 -0400
Message-ID: <20260603210831.item007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602020629.613997-1-sashal@kernel.org>
References: <20260602020629.613997-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with
> pmbus_lock
> [ open-coded each guard(pmbus_lock)(data->client) as explicit
>   pmbus_lock_interruptible()/pmbus_unlock() ]

Queued for 6.6.y and 6.1.y, thanks.

-- 
Thanks,
Sasha
