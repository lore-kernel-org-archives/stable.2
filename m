Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608962F8EAF
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252285; cv=none; b=Pu+CIM2CkmfBiuI9lT/7bXHM7qJKFoXH7r/AxfpjiGbOyMKQO0l+Fx1vMvW8MNrapHS6Gs0KMJbCe4wEi9UTKdXM2LwzTPoHnwbHtmMyjd5hI6x3RtVw9qIraL09XqvdP33Fy6RUR7q6HGc2UHoAig4/nGJjrjzYfkVrxRCUNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252285; c=relaxed/simple;
	bh=LAhsVsAxwdmspSg9ghkW8Y0uIXcZDh83/BmFY7mKCEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JruwA+uCa8S7C7H3/2dZEuj61SIklVWCci7KQ0M9uG6IViSk7voFkWWUPXnSIJUmTpiOk30xg0aPITJjO4/vT9unAU2cwmNPoELyExiaCBF92dhp3rz7tn3c26gKOU1osmkrzJELZZn5IoYlrYc0g+yoXDm6Cm2FD/A3cX7O27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdHGZv2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdHGZv2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A8D1F000E9;
	Fri, 17 Jul 2026 01:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252284;
	bh=PhveUh57r0F5KsFpms2RWgUgCXtV5F0zUolG54ls4tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TdHGZv2J3u6dSkWnb3BKQQSfjFsyUeKZpNnOGsrX+n14h/wtUnkrAzuKhCd09VCCw
	 XirpPIzOrbT30I4iLETOR6K+ZBLQG9277k4GNYSgdKVROZI6NiwNSOy94zqrOaIQNb
	 d0VJbT+//wMjk/aaZGxSjeQfiQBMlyQGdnqL10yjcI2cEHOZjhzN9t9Zkg9qVxx4vN
	 m1IK+S/dcXl0HLFEnGXwvUi/dfnFvR6LklUy02J1gOd6NAj12VWskup1YsWF/XJK/X
	 YHuALZa2cobr7Iv8u8lhCC7Ii//xi/YmTryt0bKs4UhRvumOmQm5WvhuKvEnFzVeJZ
	 PMCwl8dwBg50Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	sj@kernel.org,
	vbabka@kernel.org,
	chenyichong@uniontech.com
Subject: Re: [PATCH 5.15.y] tools/mm/slabinfo: fix total_objects attribute name
Date: Thu, 16 Jul 2026 21:37:41 -0400
Message-ID: <20260716232340.0017-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716081150.1166017-1-chenyichong@uniontech.com>
References: <20260716081150.1166017-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 16, 2026 at 04:11:50PM +0800, Yichong Chen wrote:
> SLUB exports the total_objects sysfs attribute, but slabinfo tries to read
> objects_total. As a result, the lookup fails and the field remains zero.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
