Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD78411F99;
	Wed,  7 Oct 2026 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407057; cv=none; b=iHkkB0+erY8INc7+FQeUgn5XII0sPLNxCLhBnT2o8WClLuAyFJ74j10sVg5J6xG1dTBOO8Nsubz0h4gMJeAJfzeF7cwQHutJ4uShwT1o3sm3A7xyW1zuv+f4bnPjzyuDfdcO7x40juS59wt1qpihqrbmReqtW/YFqlKzDlXNf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407057; c=relaxed/simple;
	bh=E49Gil3rVxZ0e/U9oGbrDBRdLfwmXWf8+WmdsUeqBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1vNvNqUBthhG5alAyBZatSEl5kVFFcfsI6Uiy7cLYpjdN3i6Mo+sSDB6eVYbSeE5AKNWPLH0OU5tl3eBS0VU7TKvAyTDasGsUrp0/vi1GkV2i9D5nvi11r+w/CtGStes5SR8fGdJ/jEHwNAOffCKftBqPiUl68pdlV5S8sXT/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAAPJVL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAAPJVL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FBB1F00893;
	Wed,  7 Oct 2026 21:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407056;
	bh=6wpeHbsFxkWlFZ1CZ0VBX1popGcAtgxr/wUf9KVtsPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WAAPJVL8XQHUOLyUVBVYvq2uAtjbsWgaZXb8W/otVjwenghKykIj3VYLFJ1d3BF4X
	 n7lp0Mc/Nyej84YhvwsIqoloG01x6Kq+8lVcuVkaDZ+iTBPZ91C6ZUAbhX60tb2wDH
	 ArPEib1O1+ipZ4pmaZ/fwne1w00O4sm+cKUzgW9ZEkSAYCjkyDStkDjgw9Spt4iEb+
	 M2BZ25d413uyhyt91jumJvV5hCAM3osj9U9COy8BD8OT1FP8MmaoCk+TVB6uOlOmKI
	 LPW04WrWo+ZRKVkA4c7AaaTvUAtz66Q1h82iQercsbuQULHWSjLuP2qLp/fjoPR8YQ
	 je9WXbvf3/d1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 6.12] fsverity: add dependency on 64K or smaller pages
Date: Wed,  7 Oct 2026 17:03:35 -0400
Message-ID: <2026-10-07-1-daily-reply-0018-fsverity-64k-pages-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006214621.52195-1-ebiggers@kernel.org>
References: <20261006214621.52195-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
