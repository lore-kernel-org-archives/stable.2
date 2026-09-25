Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077894BD35C;
	Fri, 25 Sep 2026 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348276; cv=none; b=pvy1W81C+oRP8eoVl/VSOPymt2KR7WajG/Xag6e0nGNnNu9VbVybCY6VTWB+UKKyjAN4chaeEgnWSSHth91iv0MHQQqHlAMIOgAZ4Ifs6h+tIWVNLy+Y4wTum4sBiFQzAuMOLFqc52fulF9jOaB3DjeXSsKtnP3h3CLnGVBl6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348276; c=relaxed/simple;
	bh=qgiPTRHHBDsdWtpSfEQMVSG8rZenbKuJolNS9oCwZcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ted8SPPKAnI56L3RA5pWIo7bOqBDmDTc1xfS0NFeFdqCInT5V/lK1Lddl49SGp9C9PwiMqm7jajYtiiwGyyWmyWbj4+EDaAWYo70Mx30+G9Se5HxhS78OiXcwWnvvbuHM+wCpj6BcTDOzDmplObfIl3PqHKNld7srB7mIJME6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0Cds4je; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0Cds4je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47EC1F000FF;
	Fri, 25 Sep 2026 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348250;
	bh=JHoWmvc5VW037x1xGuI+6ckYAN/C+4nEMLY8oldVLdw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=N0Cds4je/+07P9mu7EpPfJUB9JJ7PPk40+37cQ+MpBk84kXWd6HSWUytE5Nl/4Muf
	 aFMP3vwxfeKIZzf7XPAWDDJu06NC9FfSTQkEPo2UZ7WWBu10WOhmxzzSs4X2W9OM8Z
	 cz/5rH6OMX4I7THbw2nIzvnt7OddDbxXjwRB2WO4z0WMHpEXLVQi9SgT83Gk6hVnB7
	 wW4pqPoVlYj5hOU2AYfobm9WJCpt+pr2KGUOIpBpf0ET1MHb9SPdqmvFyckuBwbN2h
	 Yx718xpi2zaysELF9Un22yys+JU6OKio3Ipk7rMSlRebYxBptNvMXf9XPni3sF3m9j
	 Qf3w4G8Phx3bw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Breno Leitao <leitao@debian.org>
Cc: linux-fsdevel@vger.kernel.org, paulmck@kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
In-Reply-To: <20260918-dcache-task-rcu-qa-v1-1-963ec83e6d0b@debian.org>
References: <20260918-dcache-task-rcu-qa-v1-1-963ec83e6d0b@debian.org>
Subject: Re: [PATCH] dcache: report a Tasks-RCU quiescent state in
 dentry_kill()
Message-Id: <20260925-tunlichst-subsumieren-wortbruch-130f8e4e222a@brauner>
Date: Fri, 25 Sep 2026 16:57:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qgiPTRHHBDsdWtpSfEQMVSG8rZenbKuJolNS9oCwZcg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRt675WscBM90wrh1DIi4U/Gu7qCM288ceSKXHr1G0Lw
 rgLz/pe6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI5kxGhoNT7FrOn7HZvKbf
 9am640YzD1uh3mQF1pk7V1jeueeb/peRYb4Lu2v/zrmqjJ9fdu/6WHC7yufqjxzn3sT824rcE6N
 WMQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 18 Sep 2026 04:01:57 -0700, Breno Leitao wrote:
> dcache: report a Tasks-RCU quiescent state in dentry_kill()

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] dcache: report a Tasks-RCU quiescent state in dentry_kill()
      https://git.kernel.org/vfs/vfs/c/a647a53bc89a

