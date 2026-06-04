Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDEF2AD3F
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531559; cv=none; b=bg9EtzFLfCciMJimFb3FC0Jt7Cp9plfMFisR43yZXtUX2rIFydRcv+JQolZaC3YX2KMiWdIpG1rlP7SRecyq9gf7A0gNavTu1PPJP3gIQDdcoY2gRvittMw/Vbe6H2efNKvg7aH5yr813chhdpLTuQmF3F1rIXb+dHyaBsYlkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531559; c=relaxed/simple;
	bh=VfwKdx076uFvOgswmIdLDYaoQMA7KbkR7uoemqtrWsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWPebGVoaOTJcLWF982eHGfgJxj0PUZA/HhliolJri4C18pDtTk5HStWQcXb5O9XxiGJIkIYKfbQ2OAsxx0+GRWRreMmjgdau7mj94/XIkM7zO/uUXGBrGNkmfIPy9OIgDccBAHgpzCuWnMgXa2Je0dB5ymT3h9dIYViE7oS5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWc7y78Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWc7y78Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B951F00898;
	Thu,  4 Jun 2026 00:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531558;
	bh=Iug++xhKzQkwVUtTBnK1wyPkERCloXYPOsionDwhWfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aWc7y78ZvfveghCi9ZJmtfRKvDvy0PaM1LzEC2++2UncQoSt9wj0VsJjOvGb+YMMK
	 V31fauoxU/9yy2A/trcXeOwfQeZgn1hodG7Y0ptEjsS+3T2FIPjX+IYngixGQ+ABT4
	 YZ+pPANHJhbqT3Y7fZcrdK2UpAOGXc77YU8zHKpXxzjgAjZCdGb0iINKMiu21RsDSz
	 06em78ZzTPyOYMjWRFNiLEB8Q3Vx5e2DM6m4T7bM4GL/L3XZPyceo8kTq+NKELdbb/
	 2dgWyBePJpVsGVssIRd3c5HEw8J23DVNoDQnn4ZLSC8x5MtWp55VV2OSkIxAaqkPRD
	 gKBtzSd0mZ/eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.1.y] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
Date: Wed,  3 Jun 2026 20:05:43 -0400
Message-ID: <20260603210831.item008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602020543.607205-1-sashal@kernel.org>
References: <20260602020543.607205-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs
> read with pmbus_lock
> [ changed guard(pmbus_lock)(client) to manual
>   pmbus_lock_interruptible()/pmbus_unlock() calls ]

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha
