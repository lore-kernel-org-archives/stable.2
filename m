Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780624CDDE8;
	Fri,  2 Oct 2026 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950815; cv=none; b=CvPh95/S6y/p7zSHBmZ/7LBL4s8ZgKv5ejKZJ448kHEMt24fjRVkNjSso+DgAW6NBdaVhZu37qNgGoGc6/GxiQJw3C8OlP9h2KHoKZGpIaPgJQyahxsBg/N2UPdfQquE7mMOoM2HyMGOFNieLHmZ5JvJL7p6uTvEUtVeXL8yfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950815; c=relaxed/simple;
	bh=h1/j1IvycmRIYsgHxy3AC8SStAT6WC+AexPltHetJew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NquYnCJXJQYgnasR2u+z5ib+Wkd8VKUkfCXq+ugJ31QWzK9CD3lPf8OKXHqgX/PYTZAKY71QeqXZARXS/X/qfXaIMEVMK3aefd2lYwwPaIxX0JPJXRI4Gh70C/SJkzuHflivAsrEtVJIY8bWwSimQwEmBxGnPz8LTMF4cn5qUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXfKd/ML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXfKd/ML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F75A1F0089C;
	Fri,  2 Oct 2026 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950814;
	bh=JogZY0RZbEUyUbCNBGTEVaiesKdFkJlXz2wm9vOTr9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kXfKd/ML3SxbkLYQEyKEwbiyT8QbOREUKVo6XyDJNIB+Wr8ojD+kAq03bTinztrZr
	 YlN+mJA00lOlMA7W461X4D9xtpPYMjd4/gC3dl3uiUDwATFAfoKuwQ7j5Lq8Fk9K32
	 yrGuOVZO1jq5i95Gfnc0DM2c/YKv3MhEJDcsUTz4eDoUhK25/Kq8Ws8ihYopi/RSQX
	 nNkz0Ojy+SwjavUaFV1leWJ/2hKp+JzZni85C38Z4bm1MZlGld/AiDBXxYhkeLWKtL
	 qOlANCcGaSK29s8IbSwg0oseL2p3+AKIvaDzKTc78CycQibTt8Uju3KwlMrXzCRFfe
	 dVz18xqxzxrjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Mark Tinguely <mark.tinguely@oracle.com>,
	Siddh Raman Pant <siddh.raman.pant@oracle.com>
Subject: Re: [PATCH 6.12 0/6] Backport of XFS umount hang fixes
Date: Fri,  2 Oct 2026 10:19:56 -0400
Message-ID: <2026-10-01-1-daily-reply-0012-re-xfs-umount-hang-backports@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864403.git.siddh.raman.pant@oracle.com>
References: <2026090954-revisit-dowry-37ee@gregkh> <cover.1790864403.git.siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport of this series:
> https://lore.kernel.org/all/20250625224957.1436116-1-david@fromorbit.com/

This is about all five series (6.12, 6.6, 6.1, 5.15 and 5.10).

6.12 looks good. On 6.6, 6.1, 5.15 and 5.10 there are two problems:

1. d2fe5c4c8d25 ("xfs: rearrange code in xfs_buf_item.c") turns the
   bli_refcount early return in xfs_buf_item_relse(), added by
   575689fc0ffa ("xfs: fix super block buf log item UAF during force
   shutdown"), into ASSERT(refcount == 0). Mainline only gets away with
   that because of 3762113b597f ("xfs: don't lose solo superblock
   counter update transactions"), which 6.12 has and the four older
   trees don't, so the superblock buf log item UAF on forced shutdown
   comes back there. Either keep the early return on those trees, or
   backport that commit first.

2. d62016b1a2df ("xfs: avoid dquot buffer pin deadlock") fixes a
   deadlock that needs a40fe30868ba ("xfs: separate dquot buffer reads
   from xfs_dqflush"), which those four trees also lack. There it only
   changes behaviour: the dquot shrinker stops writing back dirty
   dquots. The patches after it apply without it.

None of the series has an XFS review yet. Could you resend with
linux-xfs@vger.kernel.org and the XFS maintainers of each stable tree
on Cc (Catherine Hoang and Chandan Babu R for 6.6, Leah Rumancik for
6.1 and 5.15, Amir Goldstein for 5.10)?

-- 
Thanks,
Sasha
