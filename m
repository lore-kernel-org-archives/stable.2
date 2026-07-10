Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E33AA1A6
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717422; cv=none; b=GuzZmsiAy/2whqB2tSnU3kUZ0XjaAxhlPGmTMV0w7lTJSnCAVpAm4p4urGjJLfUl3Hv8gxHcJSnAMvH0b0NlIkW1+fpSCUjNwob0oa8vJsbbkBz5ZJn/f/ENMoi0Cz1OxL4RaeZh4Qki+QtTMA4V1xXEmGN8GNFstq82QCyCsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717422; c=relaxed/simple;
	bh=gfJpRQ0oLnLfcg1Ceafuh3VK290e/PCZL6OphDIXO2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnG5KKzN/7VLVWcqr2v9nXpbeNgs02Chc3QfsanoXGqx471QJ1Khs/TK/rVrdNZjZMYlmC2GPmAMMsezhpF8vUhBaLro7FI2KrwykGJp0WpMqaRB9yOHKfaahtIy0UyNJqJSEz0tD6XdEvuMyS8qz1ULR3dTMuoyDIvWAj280GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCwBkRum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCwBkRum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F3C1F000E9;
	Fri, 10 Jul 2026 21:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717420;
	bh=P+ZKPLQkXxrKw23dewsSVwudgZ2sfwp5T+Gd2CMSNMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCwBkRum5JyiwOkpA6z2C6QxR2SWGzYcAki/eNIdLSGcMYvCl+VBaW92dFeN5Tj+5
	 fOqGzaRLLcgGKDP7gzqDZTIgjcCIU7USwoF1m/LyOOjTwzA/UcJGoe1zCUP15SQyx0
	 AbaBBSO3Yd0zSfcke7MswZphqZcCeeZ14o8ImXyvOYVso4jyl2yN0f1NL7GclS7JGo
	 mLDQQBWGGSx5kJgjhligd2wYYmezgHA5PLTDu4/+y26U2R7BipM2PuB3XCxTyup34J
	 Ex593uQqQV6VsXVYNf8msX/tStxbUCQRpqZwg0pPKjzdVhVdWXYWJQMrglLv5Ql2V3
	 bhDmZ8a4xx63w==
From: Sasha Levin <sashal@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Song Liu <song@kernel.org>,
	Eric Hagberg <ehagberg@janestreet.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregg Leventhal <gleventhal@janestreet.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios when collapsing
Date: Fri, 10 Jul 2026 17:03:10 -0400
Message-ID: <20260710163023.agent5-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ak9hKFnS8uQj1Yqb@pedro-suse.lan>
References: <20260708151357.353173-1-pfalcato@suse.de> <20260708194323.agent5-0003@kernel.org> <ak9hKFnS8uQj1Yqb@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 10:00:34AM +0100, Pedro Falcato wrote:
> Thanks Sasha! FTR this also needs to be queued to the rest of the LTS
> branches (5.10, 5.15, 6.1 and 6.6).
>
> (for 5.10 it looks like it might need some good massaging...)

Thanks, but unfortunately v2 doesn't apply as-is to any of those trees.

-- 
Thanks,
Sasha
