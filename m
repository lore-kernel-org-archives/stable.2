Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31411349AF4
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737319; cv=none; b=I9FI4LnnheSk+y4jLngXeFTkEvMr0u0DBFaRXAJpC8qKsAJl8GW5+JvpKDZ6b7VIQAwBpVQLFi6RTWVwv0s9u85xtSF9UMC/1hnsKp4UWIs54D4Pm6ZFYgPohWCiCni3uTA71cEvhIkX+E+wcMiEF9TpOn4vz56mGP7uQj/aV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737319; c=relaxed/simple;
	bh=U9lugLl/2JWQnPwM9ntA050Of7TxGEwWBLwwYjVyLY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVuTIJgT+lL8CUYswmrbsYM0CB/ZaPM2PYitQLbnuWkVMM9o1AFMUm5INIglZujdgaaieFcpJI/zNSzprxxa/jYwyl4tkvFSrPXGnbp1c9s8xK5J+GxsmynDzNXzo7+p9m6j7qEBqfWYpNTTHgR/U5vfeVEwDHF8Ned5MLd3mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDeaL4FD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDeaL4FD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EB01F0089D;
	Sun, 11 Oct 2026 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737317;
	bh=rTkeJ7497Y5USbg63LcsttJV/vy9qA1WCr/fkXWBRjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aDeaL4FDE0WYGI1cuyK4WOzxGvAQiF9nhl7Q24ZrZ9uOaLQVdxNMz6bBWg7TKP7JL
	 hC80H+iNpUvNT+Ae8jPeYBNWMq8dLJma97dGzLZw9Z0f5l9UdzB9PXY6r1EFwGwVCF
	 Yv+4x+zf5fiBVDnNxAyM75OkO8nyU+RTNnpHGUv1381RWl2bIau8uM9Pqof7LZMdSw
	 exN6pBFSyjR/iR1bLKcZDH1xpt107/cIwLymZaHELPjxrVELRzZ6h6iQK+37QPHxVW
	 9a7WDmS23PXknFdeSkwNMSmpPLGEjHfSVzPmiiWYWdf8WJLHQzjACZh/Qe56y9crB2
	 C65DJsid/aTFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH RESEND 6.6.y 1/3] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
Date: Sun, 11 Oct 2026 12:48:14 -0400
Message-ID: <2026-10-11-1-daily-reply-0007-f2fs-pinfile-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009112140.2275137-1-chao@kernel.org>
References: <20261009112140.2275137-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It needs to trigger checkpoint to free space reclaimed by f2fs_gc_range(),
> otherwise, fallocate() on pinfile will fail easily even there is slash
> space in conventional zone.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
