Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8630FF2A;
	Wed, 19 Aug 2026 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110363; cv=none; b=lKjqPPAa0W/H2B5kV1k9G6o8VP0q8EY2xvfiHqKqYZqu8E2j60lijdudqi0TjkbYUZwxr79JVSDKvpildCJTutzmd+UAB4bqAdBnfnYFS369Y8rYL4pc0ruXNK6HKMVxjqpJG+SWvCwGic5SkLxYbdLFUfWNWs6Eya9BUaLnYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110363; c=relaxed/simple;
	bh=DmvMKQ2ehLKAEmnyrShJHbODyafazJXf4MMdQBsnGTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6rR8PfIDKhO+4TOJmmCObZgpsFIEZfeWHyjv3ZyNsNw1YNvj8qr+fvYmiz1JNlLbUXso17+XfUdBBJwnZGXybGwvCinAFfgCo7X99mQNsoF1QrI6mmUdsyOhSdKjijuEEUfMVl3iYAe7973K6cCKhoMhzB51vD/6g+1uu8I4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipXgGXZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipXgGXZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204431F000E9;
	Wed, 19 Aug 2026 03:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110361;
	bh=mZAFZcywDwGorGQQcSN0+bT74HZjeYGTpfN0ulkygWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ipXgGXZxZ4o2c7d+TYUM6OxgoLVki+Ris0OaPOqynF2GXMYHHlHYcZ1TgJRVERW0n
	 d6eYHHfJqac796wcdJbDpbGgxmNoK1BHa2fHlC+w9V/+Ape0bBIZQ54oN5ttwno/b0
	 rLA1FipLQ2sTC93MILe1kUsMSXPmY/Tj/tk6Zyxtv6ida5kFnUFRVCaOKYYI5sJJt0
	 5VJ92oDwHjaguRZ7G5FQNLpEnNn5GGTn+6DI8H2yi7Zam+m+WqZukaHMZOJdlWDDR4
	 6cds6fipbxV4hFIVh1r4tyinzfyy5fRsTqzxAzokT6W951tndJVPohgJy3RJhFochJ
	 QABjUrBNolzPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Tue, 18 Aug 2026 23:32:23 -0400
Message-ID: <20260818220420.9@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818062518.91960-1-sj@kernel.org>
References: <20260818062518.91960-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 17, 2026 at 11:25:18PM -0700, SJ Park wrote:
> [PATCH 6.12.y] mm/damon/ops-common: putback folios on invalid migrate nid

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
