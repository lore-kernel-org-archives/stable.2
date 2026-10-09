Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B103CFF55;
	Fri,  9 Oct 2026 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565845; cv=none; b=u3PZshyOVzAjO5tzWHKsFJWTPorthA+hi5b2POsydPl6T+zIs/5LfMucOoAg5NS0+UdGkc7Z1t6TMRYmhMFkfmCT1GdWr8J0NAR2PsoV7rgPfU49FWXAhzDKC++a+V8JdUBxivEyzLYpo0UtagbGVgE6QnbRm9bopePd9qitCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565845; c=relaxed/simple;
	bh=uv48+kF31Zmc+6a69Q7ShDFTuB4abgN4OPPjNU0jOlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSS5yIBwDQcYfGf5fxjHGfpMjIVFcOZbNGkooBWX/BaRn8fgg+wgv52ofKs5Ubcs2RRClmVJHM3LxEVuBfekCG2akBdCyp2CM0/on67P4PMZcsafmOlby4EUS2jWIVJxvdSUPY+5f97DhAa6ImV5GBwtGMR8hZWZNw03mQNNpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDTVl/8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDTVl/8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6957B1F00893;
	Fri,  9 Oct 2026 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565844;
	bh=C9JsI/6wJG4T+ggUBIVnC01WngD4K2YbeltQKR7jvZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XDTVl/8ZElnPShtbJWWGn4xE7vTpc/qnZ07Y1HJ0qdEHQ+snST4gHg4ebMmvRdw4A
	 Sf28Xos5nEcLFoJa+mxgOgLuL3MyAWO/kfu+7NDz94riLY3gdwIKC8FhHstrbklyMA
	 M0IaPX2x+UwsymiIZldBNSsZxCStoxeoF0zQPhmBLFY6/Qa5SuHAJkD3XAu87I77kp
	 1k590VLGTfEvp/4sOgT0Gq8gp8drRrp/Vg98VesogTZv0qfi2rJpxNn8P72awnmGPf
	 j2yGCSJKfBG7zqD84uQ8kfOPNg5PeZXcYRbmzXvU1GiruP5wUBhun1il9j83gKMiJp
	 YHwfzMnPH2rnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Min Ma <mamin506@gmail.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Eva Crystal <0xiviel@gmail.com>
Subject: Re: [PATCH 6.18.y] accel/amdxdna: Bound the sync_bo flush range to the BO size
Date: Fri,  9 Oct 2026 13:09:50 -0400
Message-ID: <2026-10-09-1-daily-reply-0013-amdxdna-sync-bo-6-18-holding@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009032616.432392-1-0xiviel@gmail.com>
References: <20261009032616.432392-1-0xiviel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This applies only that check: an offset at or past the BO's end, or
> an overflowing offset plus size, returns -EINVAL.

Thanks for the fix. Ideally a maintainer could ack it.

-- 
Thanks,
Sasha
