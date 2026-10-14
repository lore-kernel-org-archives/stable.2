Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242B1A6803
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941245; cv=none; b=mzxAhoWgGmBs5RRAcVWyB2aEsVFoG6hZJ7ymr+O0UbD1QXVEqHJQnvbh1eZ6X0ETgC8kxgqQO99xFeZqoUcczKSWU1i0AWbm9/4dxaIKHWhptnvD7UDWrWg8bscl3Z5n8FqdvvtBkgPdZx19xUzNJs44P3++HN6MQrH7nC8YbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941245; c=relaxed/simple;
	bh=Lit7679EP6L5XiIfVUTCkvSoAYzcNzyCAyR2hqBS9tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG2k4yrrxoPXjQZ2+EAzQ+d01S46Ul5FZC84NB3nNx0MHnVEFOVh6NPxVzpiZm4VcfcFwsW8y2LQYeJja2vXJkeoqXxg3A8wDD7FpQ5qxwMtGLAgcV5Dy53hRT01EFz979JOVQTScyDu5Sr191eixqNfzF6DH4+vojnNiKu90Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtXGv7Ld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtXGv7Ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965221F000FF;
	Wed, 14 Oct 2026 01:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941244;
	bh=wi8Khi+86LRN4rMnUJ6+LTLZvfZZObdbhTARnVRtj6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UtXGv7Ld4r6VSJ1VlOiAgjLGg33sq/acoD9xhqbv0B7BkGUSPZ3PLl0apA/5G4XFY
	 DWjmphs5rCxKICVWjOeskHhXltPAZM8cbIy1Z8btEjh4VYqE7AFa68CRZ+H0Fw2DGw
	 NAxv7rkmOazdLoZRE/RN3BWYdYpqHDt9aYPms4gRQvTeRwaxozTYqON8dQRoHZw8uI
	 234Irzgxg6WZRpISvPeUha1wxFDdA867pclyQIx/drjgUD8q0JT9jeVoYC4n5oTAFm
	 9jwbgQXoqTCkQHRbO/JrgttfNp/3927M1wQ4L2W/piP78Ln61As6sJkECU4hJ9ihf8
	 ioA4DIKu5wzQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	nbd@nbd.name,
	Cristian Papa <pcristian292@gmail.com>
Subject: Re: [PATCH 6.6.y] wifi: mt76: mt7603: initialize global station WCID
Date: Tue, 13 Oct 2026 21:26:53 -0400
Message-ID: <2026-10-13-1-daily-reply-0002-mt7603-global-wcid-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012144150.21849-1-pcristian292@gmail.com>
References: <20261012144150.21849-1-pcristian292@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Initialize the WCID before publishing it.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
