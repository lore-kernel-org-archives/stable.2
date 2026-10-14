Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD4348C67;
	Wed, 14 Oct 2026 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941270; cv=none; b=hyBwba5fpxhwaW2WV9xQXaQmPbLg5Iy3L+hsJQnwUqooZEKJ0Lb/3YoUT2dQ68JuyoofDt6ruNotY8hiLTYq8Z11vb0KR6t1/hVmDfIFM+sb0Kq4wPxNpCXmMS4g4F5RzvB3c3ROVDCQh4qvUwtFeIw7uY4W4veNaDgFuFI2cdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941270; c=relaxed/simple;
	bh=GK0BlMzuZ/h/iCQ8d+CiN0BtOtFbKuaKBYUOLT2JGGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie711ZMoN715bSjelh3uCRpuyj1uVJrl/SPtj/8pi6jx+LiQKRkO0McllRm2Oip4qhDBKlfr20AbCwjy4SwMulDCjqO2VYbJ9K/ItKu1+x3iv6xVJP6CZNo3izB33lSwe8juAmEWe2O+Ta0wKGK8HD/TU2g5vmhqiu2iUEyASBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnUlHYZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnUlHYZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93131F00893;
	Wed, 14 Oct 2026 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941268;
	bh=puC3FBB1+sc5xov80jQYGR3YcWFEFJL1foICeQhUtCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WnUlHYZbUfIoA8K/OQW7Xy1ykyE47K4EfUO39x9in7FxaXGBMFy9FFRi3TfNwPQTX
	 GhN3QqpDD+zSqycEwp5mY3CHQVT2NpHKD1PV2f81Ldkn5VsWvJOJ8Tn2a6+gWEqp2W
	 xdlHR3MKS3O73Os/ZMqQbuc7WzVupXjJ0aVfWlHvjP5fi05Yxbyx3Q/T/Ybm8ylwK/
	 M9v0pWF8Xf4GMRwoGHj7eBC5oH7qOwFPJntLZCZXbmM90zNVJpljZi3Wim6FtUw+0L
	 9DnBW520D6bu79flUfNjFCgHCmt78pakXjsCBze54ExL7ssA8csR6FopSeNhTLbS/L
	 5iTdWXuHQvu8A==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [STABLE v6.6 1/5] HID: hid-steam: Make client_opened a counter
Date: Tue, 13 Oct 2026 21:27:18 -0400
Message-ID: <2026-10-13-1-daily-reply-0028-hid-steam-6-6-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091156.528734-1-lee@kernel.org>
References: <20261013091156.528734-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The client_opened variable was used to track if the hidraw was opened by any
> clients to silence keyboard/mouse events while opened.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
