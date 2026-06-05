Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB834071CD;
	Fri,  5 Jun 2026 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688273; cv=none; b=AQwb7suR/9CuevpIIDhsPFMCPhOqXLg8zrcbIhgZP5MeEx1IX/DYTvVvyrKcj6dK20FseemUlHyddjQPs4N8aUyDoZ2DlsUinmWVdyu6pBaDK+8Aru1V6dATPalqSOjeyORVnWLXQ99PnY5v/gJHGRrL4BmVy1PAlA7URLAUMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688273; c=relaxed/simple;
	bh=mJC3qcoSFMdR/DCxwL5F1cdGaAsS/d9gyWtHOdT8Oqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xw+Bytg7iQpKBNmHRCgD4Jv/BwoBddYPsOjSx/yQLAVed49ELgcKoJ1RIJrVkBpcgrvqsp8xHGwgDT0d6VsYPhEwNp+U/tLbVJtKZicO39j627OwPizAa4SY8CqmhDyNQGqgWgbbRGzTHxUEHQgD6d7SG5tM/qjiFob4ZmHLtZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWLCY6pk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWLCY6pk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185FA1F00893;
	Fri,  5 Jun 2026 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688272;
	bh=I4JXR3hp6VucfzphrHCgJeqWuX0M2i8SBkIetIFF8kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWLCY6pkgAIH+SJWpyRRKYLIOpLUXyQcBBu3HU7KHIxi0okflHjTxz8bm/r1wiYKz
	 d6k85QkJV0sdesBhg8NxbTZyNz5N2zy4RlAeh0WnDT1yN83pl5ruDfHnGG1Bip7EnU
	 rkBUYm7+rEhKuOAG+JeGd2xlEp7KC+F5j8ybQTcCQ6z7R54dNRvY8LE4zi3mXVwEAT
	 39/1Hnq7J3cUPQzP9FO3KgqdQVYsJLKrnBSLOMXIMz8xL8RwtY6B7s/zB51A8p2u9M
	 /QVSGhsg5827D0h7//j8sqyueB9JT0IKQmN7vzYloVf3Q1oA0YxZp2vp0yfJp9npn9
	 mZDNAhPjUw1kA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	gnoack@google.com,
	mic@digikod.net,
	Christian Brauner <brauner@kernel.org>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Bin Lan <bin.lan.cn@windriver.com>
Subject: Re: [PATCH 6.6.y] landlock: Fix handling of disconnected directories
Date: Fri,  5 Jun 2026 15:37:26 -0400
Message-ID: <20260605-stable-reply-0019@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604101618.939488-1-bin.lan.cn@windriver.com>
References: <20260604101618.939488-1-bin.lan.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] landlock: Fix handling of disconnected directories

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha
