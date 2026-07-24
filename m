Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9243F096;
	Fri, 24 Jul 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903448; cv=none; b=SXyBcM3X5NPW1J4wZobNSkShXg2lCJSXbUwqy6X7BkuKL6Dx+th4dQ0rF5m4NOLxDf3ASs65Rbj3z2nixx6vaslrGoqk+34zMFe8dkl5zLKaO98+J2YWt/5WzDqNszT0DuIzyUvEJq76yXAplKIFPCLIoSFeowXj+cOASvplfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903448; c=relaxed/simple;
	bh=IwGWMUGy4d0RmBiGGxGMMrGuZYDg0FF7nSOrGnAWSU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nw9tlg/FR0W3KjsB4dOH0f1gR9bRrgcYpNzzPnixC3aR5oEw1dALgHsoefJdM77VQQOzu0iLnkmoXvIQQWNxkGdieJFvrMuUHMZlNgZ67rSD2ZsMqeG0Ito6nA9d76CsCAwg8xXhKkessHtMFOF3BmR+09WZjBGOdEYvzwWv7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDKmSevR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDKmSevR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77DB1F000E9;
	Fri, 24 Jul 2026 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903447;
	bh=QYVYdgPS5Cj2uoeadzoubuPSBbrZtwJpYWcA0RRG88M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dDKmSevRZ1b3kALn26ikXK69qUTfOdF/EukPGDEsFBDXkLpsIU+SHwpLqZsONXgRV
	 bxvwPZurbhU7XkQhV8dWW63lPFs+z5TqmX2ZxszusJOs4/BqjgYhoNvZT2/3ePOJcT
	 BkoB7mTqs0U1y9rwoqXz6+bnczcPYLRRfjXlWozjINEx/LE/7aF95SlBStGW6kfwZf
	 sUE3/hfWb5KxrOOD0FaEpi8BnaVfkF5LcnYJ43WS3yLLJM9FGEPikRKB8V7pieXGjB
	 HKlcHHc9SgOCY+R+ypce1m01oQLHwrArFzifx3UqjIIVnWVN56ws/tWW61WT6pOEC+
	 KVcWgzi+OS4Nw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: dayou5941@163.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Fri, 24 Jul 2026 07:30:37 -0700
Message-ID: <20260724143038.94157-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724142635.93839-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Jul 2026 07:26:38 -0700 SJ Park <sj@kernel.org> wrote:

> 
> 'checkpatch.pl --nogit --nogit-fallback' suggests adding below recipients.  I

I mean, get_maintainer.pl.  Sorry if it confused you.


THanks,
SJ

[...]
