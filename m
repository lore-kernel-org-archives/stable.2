Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287138;
	b=DkqjTJNOaLwP6lRJwo8P4Ikrb7KE2xQJs3otbVnjbppaoFL4SoVp0CZHBFGts9iJ0QkH
	 1Q8YC4sLOHt19VEhSyk05m+EpGAR3yy5W/bYRpgKLy5AUaQ4N9WjUldoziTFApkBzcLLX
	 GIujBIC1Q9UJvlpyzCkvYNWdf8gl0c101aGcGVQTv7ZPezy/hc/KdfbVaEJmfr7Nca+7f
	 O4Ldo+fMNt+3q+67lxJ7tG3ZcpJwbgju/ytXA3pR9hIEfui6vNDhPrhEeAxDVpK9pXMjX
	 VpzABValJrkOX1RQYE7RB36JkPeVXxtlKasBeqRPezZi5Clq7YvRpTK3nYTjPUt5L+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287138;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=rFMbZlxVwo+tIl2DXqfmP+gsGZkF/4YnuH2JSAfBvq1aGkqz2O423FVyuPIyKAtywBTo
	 rdKyTk1iChsR7P1crwSu3J74FYB50T81EloRhe8IJ3YTDMJTaCcAYV1waxxi7PYGHwuuG
	 BJtSofrVjwSavfd2/TqAfaQ9SlRkZ5Uy52/mOBQlNZxq9lJxmUBGmB2F4AQ65C222QMoT
	 CD8DaUDKnuz0rm5sxfEbbuIlMlkgGfFUXBu1mU/F77x6Y5ggU+liPQy4vuAlY4YGnDi7h
	 0pGw16xvRSFWpRV0LntGk2KkEQpgfvv3wOz56rCCsd7KyPa2Li6SbQk/arc0VQXdUKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G732k7SF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3C606A321;
	Tue, 10 Nov 2026 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G732k7SF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3980F1F0089F;
	Tue, 10 Nov 2026 05:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287137;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G732k7SF1/i81tSk3x9oloi4fealCZWsQIGiY/DeEW5DZU/I+r4oH+NaAPAn6Tv/I
	 lASwHb67mspuCUQNadqtXRp/gxas4gkTuT5+FzJdtGu9fiIgysXfJ80b+lijhFpLv6
	 HDVLBtz59pBIX1cSuZwzCe74MHWfmW2Ge6kq7dGOAAl9vyCZaruwGB3uYUGQ/oQ55h
	 Ot0K181v3f9g7pNbViLm2B97zl1nK9j/91ljptw4u4IaigbmyMiIt/p5zmB/qUi1EM
	 EiVraPZFurqnDjJeh3oY7mNroEnxQ15vn5VtKFyxKNILU7bFlSc9OFCMTLqvE+CcYU
	 khnFg8A0kv02Q==
From: netdev-bot+sinfo@kernel.org
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] net: 8139too: cancel the thread work after
 unregister_netdev()
Date: Tue, 10 Nov 2026 05:05:36 +0000
Message-ID: <179428713681.488859.1644474123069496991@kernel.org>
In-Reply-To: <20261110042903.55991-1-mhun512@gmail.com>
References: <20261110042903.55991-1-mhun512@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
