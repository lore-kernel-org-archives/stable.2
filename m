Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E99352001;
	Wed, 14 Oct 2026 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941271; cv=none; b=FQTQOCZBBVAQ3vX8ZEDW8TNJgfZ3PFY9sX7/576exTv8vT19WLNQQcCF4YZaEW+gak/trpaSSBZp0euYMazoPLJ37A5qzsgJ5tOzah7tFryFYPtbpcc4DEk/ZIFNE8dOIfnz6lbh4b8vzdWv5/2CBOHDwndpV+dqMonCYSDBntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941271; c=relaxed/simple;
	bh=lIoSS5Pt12IXv0vFW3cQLN4zvOG0pt9nhAd9FqulbNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckPtvVuhyBqVPms+qM5K2kDC+WZsWerQ9ET5bUW3hif5WGIBgFtToFnUAdVgYxeWuTejYsXkwAKUYkZCkj67oHRb6LULkpUB0quoIHzQMS40dNRHL+2DRExYuBgMOaUEhFIXmofFP2PLV7JjwGPhzKXu73tqQA5WQ0GfxDUAZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3pJpz95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3pJpz95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5CB1F00898;
	Wed, 14 Oct 2026 01:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941270;
	bh=eT7JstgYSmKmBqob+mPJwXnYO9btxKtHo37gvw6ON/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3pJpz9510cadSktglm/cjqbNQAxCDJDHsiu0H/osEtCb2tXjc1PlM+D0O/CP3s4s
	 nb2YRPm5XX8kmlC69vm1MHP71N6mL2aA77GtOFRg832gym8lipjSH82T0kQ8+RcG+7
	 HSm3dHhA5USmLq/jdm1z6DwoJXosS6yBbFHlZwFZE1IhWTUYoBYW0JMnKQKFJJm1GD
	 asj5QuGoVXMAQbvDnUI9VDRuIdq8/EU4LCtqpHBU8O8Gctt9FRT8fPyYRsjCqL3g4d
	 4niaN0AXgQ09m+g+enwQoXA43v6692tocwe0OLKMVhqnD/zzmL3tpzKGstJyqUNbWm
	 LTarba0TLJdqw==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Vicki Pfau <vi@endrift.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [STABLE v6.1 1/6] HID: hid-steam: Fix cleanup in probe()
Date: Tue, 13 Oct 2026 21:27:19 -0400
Message-ID: <2026-10-13-1-daily-reply-0029-hid-steam-6-1-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091204.529049-1-lee@kernel.org>
References: <20261013091204.529049-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> There are a number of issues in this code.  First of all if
> steam_create_client_hid() fails then it leads to an error pointer
> dereference when we call hid_destroy_device(steam->client_hdev).

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
