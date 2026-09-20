Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BCB42E428;
	Sun, 20 Sep 2026 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789910136; cv=none; b=jM3msqv4XcS6vAQzJBX8aFhUlhpf2Z7DAR8EWKTB5zhhvpSdyBJZl5I/8e1xI0MS8+0xjCpV19+X2VPTep6NEirb7oyEigNVym2uXvkEmVgBCCugxdkdBAIfou/Xq0ISOOYkQVkGhzGl41JUtS3MBiRiNKnNA+SugzViHfyAGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789910136; c=relaxed/simple;
	bh=O9IiKP2yRjWpYxt+UwYSnK+euahPbkA5JKVd7Gw702E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPU7qRZ82kecoAUoRIqESYt382tFGtyzsR7kRMyq/giqjkqN8kp7y5U9DGPA2GXG8A38m+5Eq/iKsjgiiPCas7b3UM3++7tFwyTfh6q1blwszCKRk50ixVXgGBbGjoEApR1BNc2yQgDGorzApMDqOj3WxzUUTmEdMxq1iOBGRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNNVVhJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNNVVhJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB571F000FF;
	Sun, 20 Sep 2026 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789910129;
	bh=2ClvUqa3gFqi46vuVPqQXMQRykM+sC9yZ5XUitC0GKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jNNVVhJc2J27yBQ2EaxxhZUQgKfvsfTeZtyDcVrWX0st4XLFQL5vswTsazFTMwvIb
	 2e5tsoyhxKb9hNf47SEhj97BQ8f+5z6tvMuCqEBlBA4QGADGyZhF2wUM3JTu4UEqpo
	 Qf9HfS7SNP+gdvAxJk6FisVXpe07MPHyneriYq38+7x3xV6zwulbeNLY3GbQUBWOmc
	 ovsekqyPRlI5P9I0W0Wy1NLKKSyJhw8tJGRCFLo6xVs6h5O38nARLT3l9nkDoDbBrd
	 M0QvrhJwTLmEo7zu/2hF6U1CZ7jR/mqnkH8SVlRpY3CkmTYwnD7nMVgL6DvCrKaQkp
	 Y4MSZyXRUHLsw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 06:15:24 -0700
Message-ID: <20260920131525.49087-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920103714.47722-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 03:37:13 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 20 Sep 2026 11:31:09 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:
> 
> > damos_goal_tune_esz_bp_temporal() converts the scheme's size quota into
> > basis points with "quota->esz_bp = quota->sz * 10000", both unsigned long,
> 
> Let's break commit message lines with 72 columns limit.

Zenghui pointed out [1] the documented recommendation is 75 columns limit.
Let's use 75 columns limit.  Sorry for confusing you.

[1] https://lore.kernel.org/20260920131300.48929-1-sj@kernel.org


Thanks,
SJ

[...]
