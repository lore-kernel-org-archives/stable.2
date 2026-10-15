Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D94766AC;
	Thu, 15 Oct 2026 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092989; cv=none; b=UE7kcSkle0A9WFMTygz270J0vGnRL5fU/rQMjyeHm7Sd3Tii3R3jCgNIriudJQSIoRzBEXFEkL5/vq4ASPrlYMtYqnR1tlUJdiUruNyBWJfCYQOM/NVDw9dEdCWw5jp9WCyIl9BSMv8brCVur14+TJg4i8777DZ5RaSVK6VnPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092989; c=relaxed/simple;
	bh=AY6GNTGSZur7go63k5fqXudxgvf02Tk5l/TFk/DKBu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvW0N/cjURFdz9cAYewleOoJXXoLahgwHx8ZeUI5drC316cJOMj+TfERCDOVDZvOsLsJXo2qwkKTS3uTAiGnClieAg3YP4fDUg/VSBInqXqfEmoZxJzjTQg1SDxiQ0S6I0GiM8JrSsJ7VDQbzGxbl3WEk3nT43MiDGj3MgzovwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAjqJKhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAjqJKhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B51C1F000C8;
	Thu, 15 Oct 2026 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092988;
	bh=3l7qb2vRGy3ewivKO1XvYNvhN3iCfDn1ndUs0iBna7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SAjqJKhzmAHP24DcqU11ZWVOnVM5O8qTRO8L22pb0gfUVw1X77rx9MJWzbCN1PyB2
	 Oai0aD66YJQBw0U3/K8are4ZVZwqoD6pUEZeQPax2f5m0zmgd2oCHkV5cYJ77Ev4eC
	 UTi+bB4AxZJHdo6sn/HfiKnTzil8uKS5xOHQ3o2wQ/LuhaT1Rb57ZnBZ5+4hQaY6wM
	 FC1O0oeVV3hWI6pYjHKiOKX2AkNsPc7VVSH+AHU+LMpaA/gyMusNwQg5DebxKCuz3r
	 tfz9anfo5o6FV+En1drRE9Dog+1AW8TGZj2UhgITe31J4U7/LFzXzVr2WOQSiWgzFQ
	 FPDeTW1KCqbUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	jjy600901@snu.ac.kr,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	tiwai@suse.de,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y] ALSA: pcm: oss: Fix data race at accessing runtime.oss.trigger
Date: Thu, 15 Oct 2026 15:35:49 -0400
Message-ID: <2026-10-15-1-daily-reply-0006-alsa-oss-trigger-race-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014192325.24338-1-artem@trailofbits.com>
References: <20261014192325.24338-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Currently the runtime.oss.trigger field may be accessed concurrently
> without protection, which may lead to the data race.  And, in this
> case, it may lead to more severe problem because it's a bit field; as

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
