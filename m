Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA58B261B8D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617628; cv=none; b=qxE/XSPzrLQCWRhcLMv7WB7OdBRISyFwoYLRwTbnnNqoeMOZ7MLn4N+JyAZFOB2vmb3U7oQPV3Wh/N4KJjXeorm0MEnKfrEpDIGxXV3KJmdFjyKHbS7hD5YRZSkcPmY3gtGNJFKw7LNyu1KVdMCikWJabZJcwp2woN/Lsz7jy4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617628; c=relaxed/simple;
	bh=+7kILXoFyJu3adRKjSfxuo1ItOcMXU4rmrcR6mbom/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz+szCy/g0EIVy47nJdkGihiOhE0KBiNHtL0V3v2jO6zQsAcDBfbFbYzcphcJFYD+VHt27TqyHbo1HsL8XRT8DjpR34oai8WkOSBb689XLIRPc+lp/oBaSS7mfNRwS91zG50bEFdPPphWaY/58I4JhUDHtQ9W3LjBizIXZkxSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grr/001m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grr/001m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1EA1F000E9;
	Sun, 28 Jun 2026 03:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617627;
	bh=+7kILXoFyJu3adRKjSfxuo1ItOcMXU4rmrcR6mbom/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Grr/001m9GznrYoR2qh+9pedHbKCkSd5eMtqMtInnWz5LufksfIlEGa48wUJwpH9z
	 f4mygdAFBg/e2hDly99puIiU713DjrFXU/4+T9sRs8Hh5YJuh528KACAOK4dynZn9S
	 jdAg7BZTMFpdUda3APguavSIzhrWDYclZ81lG8pmpEle33NKTLdLcButN5DyiaaBl1
	 7tReLYLQV/M9ZlXA10ZxSEPGEBUzhgfGH0iHjzzuZw3+JMgyOo/OvT2w2ae1yQJBT7
	 tPb4oTkjRqBeMkyUqil30wgSUl/8rObG+lqFf3O4UZG0igDydQ1TBZ8EVq5Z8W1ZHh
	 EK87zxZvWw0VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.1 00/25] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:36 -0400
Message-ID: <20260628032401.0006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161123.124273-1-sven@narfation.org>
References: <20260626161123.124273-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 26, 2026 at 06:10:58PM +0200, Sven Eckelmann wrote:
> [PATCH 6.1 00/25] batman-adv: 7.2 merge window fixes backports

All 25 patches are queued for 6.1, thanks.

--
Thanks,
Sasha
