Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E03D9046;
	Tue, 28 Jul 2026 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225153; cv=none; b=Sx1agUbNEmqmB29zPp64pj8sRDwpR/4qT3ntPHCLm0e65M4UmIiEQa6KNv+/dYiibJa39z/lLKUHfs1hQteuHRzR6rR18qqpGB6hSy6iqMe3iD7iNpPaOLS2qTjeVBYdLW3aJWFS+RYrOD+2+c5262lAQFjzHtNW4oMSYa+Yp4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225153; c=relaxed/simple;
	bh=WttfTXpFo1FK6v30KTdbJN4UNpvV3D74uM9OxSIcvko=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=aaV7k84jIW5L4+1oH4YizYzNNFe8xNlPap+8gkhNqcJvvCqwC8LYx2WT/NwFGfijzrzCRCq9gnCjZkpYjdwZl+6fxJb2VgIG0+fXEyn3VvfZ5UmCe52Ne8Iwsh9KHBAedmM7L8XF4jbteTtZj/iUJhjM2tjbBzeQACo1ba6+0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKhPtadK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKhPtadK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458361F00A3D;
	Tue, 28 Jul 2026 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785225152;
	bh=9I7doRQ50LJFSJkgpIw2Zo/j+BnPeznOVrz2AUXZ7h8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=EKhPtadKqwOEbrU+DMrvlzP78ttDtRR9ftkpQUYpFs/6cpT89x+VLGtC+BWercwBa
	 S1lYw1nT7ezjlf38Ac47cUmSrmi9oKGcV1jmb3rD+Pl4VKONyjCaTAcZ+lmEBu0Dg6
	 N1eBpYbNNBXlw6fpM+Azb6G3X64AZHoOrG6tH4JtU3j3VYpA7Op6GquG/HY0y404GB
	 K/u+60+jJVzu3+Z7iuAJQ7QJWQY/GMavxtwgDd94R1Q9x+SlXNjEPgfCKx01I7g8+k
	 9MnpoDYBbyfeRtTjOMFxA2/qmZRa5pYd47zBTj8T6xO56KQEsaXIuzsh8cV3dgwmkm
	 4ey8PL1VyN+Ng==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm: do file ownership checks with the proper mount
 idmap
From: Christian Brauner <brauner@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260625153853.913949-1-pfalcato@suse.de>
References: <20260625153853.913949-1-pfalcato@suse.de>
Date: Tue, 28 Jul 2026 09:52:26 +0200
Message-Id: <20260728-kreieren-innehalten-anbot-d92ce2dd10bd@brauner>
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WttfTXpFo1FK6v30KTdbJN4UNpvV3D74uM9OxSIcvko=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlxO85a+KsaL7zn7SOm2fc9b67jGs5Jhi3NWozZ+WbV
 9kwzeXpKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEj6J0aG1Z0+DpHFc9ccSU9d
 /X7bFKE30/NDL6X9ThR14M0wZjX+wfA/81ppZyRTzrwVPdHZpksED5yJnWtWrrTvwY600LQdTIH
 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Ever since idmapped mounts were introduced, inode ownership checks
> (for side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were
> done against the nop_mnt_idmap, which completely ignores the file's mount's
> idmap. This results in odd edgecases like:
> 
> 1) mount/bind-mount with an idmap userA:userB:1
> 2) userB runs an owner_or_capable() check on file that is owned by userA
> on-disk/in-memory, but owned by userB after idmap translation
> 3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied
> 
> In the case of mincore/madvise MADV_PAGEOUT, this is usually benign, because
> file_permission(file, MAY_WRITE) will probably succeed, as it uses the proper
> idmap internally, but it does not need to be the case on e.g a 0444 file
> where even the owner itself doesn't have permissions to write to it.
> 
> Since this is clearly not trivial to get right, introduce a
> file_owner_or_capable() that can carry the correct semantics, and switch
> the various users in mm to it.
> 
> The issue was found by manual code inspection & an off-list discussion with
> Jan Kara.
> 
> Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Did that go in?

-- 

