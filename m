Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8E4457DF;
	Mon, 17 Aug 2026 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980294; cv=none; b=F6wWiLnDNLUJGpd5nRJt6X7P2AeVVKu4VknYXX6GW64QWqCVAG8HkYRRMSjtftQ/ZIv/P+tA7rdHyFIHvvo8g+H4Rb3fPuQWxR08shZ/lc7iUMcVzkGa0ytPW7vtfyZm7a+5MJRDV7AUpvVVHaz/NxHmodFgv9AQRrEQBFBgHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980294; c=relaxed/simple;
	bh=1fCRx+j82Ea3DipSByRKxpuE1ff0rvHHjwpo0rQEDlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfZQXZVKcIgvl8b1qaYU5QncRs+KR3k/gdij3CvonDjjvt1ERFmKoEE3rtE92SoI1mlTzHCduZ9/edkjqelIO/lrxPZTm1+m7v4dqnv9ec8hgSu4xGl9a1crVQ9NsMt706fvSPixzNbvg2wKKLGdlIl8wMjTuBO8h8n4oZnTfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAImAg9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAImAg9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F321F00A3E;
	Mon, 17 Aug 2026 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980293;
	bh=4GmyRrtEoG6Z0fVcBgv9RygGkhjxHW77HD4BrVvMePk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NAImAg9T6AZP8NaEE3tg1Jh+65gCq6ZsFRO6jmRqLNMr627fnIQc2Qo+x4Oa/536h
	 TJx/4KBUdmMIW5XkcOsZAYzx4+O29em2o01m8rjEKYJi2BKBZXdOQWrveAfi0JxGS8
	 UsyvUttfBNlSjO/IBf3HPmqhoq6IXDgZ+5FOtHv5aNzlemB9+rUSd3m8lxjlN/+ana
	 bIRxqI2Ih7Bi9gIEwxYBXjrZACPUHmFECf+uaFLaXCNLFqt0oHzybZU5g3pNNoP2f3
	 Q6RXXGo7DG/61k5/+UnxCiA0cR1nTCa7uFj7LLEtOZvQNxd48VBSijLZtXxtRJm5VN
	 aYo5oa3ZKY3Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	David Sterba <dsterba@suse.cz>
Subject: Re: Patch "btrfs: move large data folios out of experimental features" has been added to the 7.1-stable tree
Date: Mon, 17 Aug 2026 11:24:43 -0400
Message-ID: <20260817150000.5@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817103330.GA54102@suse.cz>
References: <20260817103330.GA54102@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can this be handled in a more generic way, the fixes to experimental
> features? If you pass that through AI, it should be clear from the
> context (changelog or code).

Agreed, and done: the selection rules now reject both commits that
promote a feature out from behind a CONFIG_*_EXPERIMENTAL (or equivalent
staging) gate, and fixes to code that is only reachable when such a
symbol is enabled. It keys off the config gate in the diff rather than
the changelog wording, since neither commit here reads as "experimental"
in prose.

> The config option has been added also for that purpose, it does not make
> sense to backport that and assign CVE's eventually.

CVE assignment runs separately from the stable queue; I will pass the
same signal along there.

-- 
Thanks,
Sasha
