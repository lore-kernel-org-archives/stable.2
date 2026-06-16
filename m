Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446721B9F6
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578675; cv=none; b=QlkpVfOuxzTwM/K1kgr0Wp/zZxEs5XJNFxH7UVKZmKrZdxefY+rQ/40NPYdb6DfCzUBvFLA99Obk2ilw3VKhut2b3sW+cFFfCw0V9qAi6EWZwKJ/8VDrAyCRKE1S00Jpa4buHWwINoVoV5VnYOOE/qUIQe122BhjODbwpGgZhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578675; c=relaxed/simple;
	bh=fvLEH2XaGdSNA00aOZkZ4WTOjQNN4Xnb8DwYGrwK/e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVxYkv2p/51Fx9y9cJ+7piOCvscRgEbC+GqyXsR4xZ9/c9zfk1WYeQswSrbw1IAo7exuFVV4ed9KSYZ23g05mXWhqTSHj+2+PLctLKJDX7Vldq+xjeYm2frxewlJEj9L7hLXvdXZSdltHIY5olaR+9I9DpMciHREOX+iIBTT/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8Z/ypE3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8Z/ypE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63631F00A3A;
	Tue, 16 Jun 2026 02:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781578674;
	bh=fvLEH2XaGdSNA00aOZkZ4WTOjQNN4Xnb8DwYGrwK/e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8Z/ypE3h8XC7oT9gAjuQKBWnq9ZL5XPh1vfAXKDAs8i0jm3QLSjoD66ximG6MNJk
	 QTlc2azgV4hPqoSWUZQ5LZSpzWUkezFtesrMTogDROTlIY2R1MRJIAwuUXWdYq5xV0
	 ss8sPsSdInA/mnDfhScirBgSit6hAsx5cLLk+4BWGOinuQE/g+SK6XygGq9f+v0ZDL
	 VU9efyKkLSptKPl3882LwLtZG5TqCOLEJHQs9Ghuhv9FYFOBk4HtsZn5uwcCtACrlb
	 JyvxgZ9x3I3/Gd6ggz8YQU29LquSd1yNDlzZgkLdYQr5IHQZrbiPkGf0feqh6WzSph
	 JUmUX6ofxV5pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [PATCH 6.1.y] mm/hugetlb: avoid false positive lockdep assertion
Date: Mon, 15 Jun 2026 22:57:45 -0400
Message-ID: <20260616130100.1000003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615164919.343252-1-ljs@kernel.org>
References: <20260615164919.343252-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 15, 2026 at 05:49:19PM +0100, Lorenzo Stoakes wrote:
> [PATCH 6.1.y] mm/hugetlb: avoid false positive lockdep assertion

Queued for 6.1.y, thanks.

--
Thanks,
Sasha
