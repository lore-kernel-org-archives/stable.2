Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA173C3F7C;
	Thu, 10 Sep 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024943; cv=none; b=bhyLUQNXkzSGVA8zBus4tdKdqT4QT58ClOigWKFDZbF2w3ED6cPB5Vz5bOOQrLbkYtXGmpnwl4PPHIdJFijuF4PBem0ePmVTqewyvqs3vTPGclrMIzDwW/r1rQex3WiA3lxhkUIgPyiExjTt40Hbmqw4EwtvhBFqvZNp4MGmlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024943; c=relaxed/simple;
	bh=M/1WWSkETfqoyY1iNz5Z3vXCWfB413XOrMNZIKu+EKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IwyD9osDb4T7i5zwCYK+pL6MavWgj+IG7yLHNWnXfOsODPs20MCadyjq8sPoy1JN59roF1enIlL83trxr0b7j4iTqcgxFQyGcMHjJTsaY1Cpi2G0GsU8mcM/+WtUXjf6r7lV+28YAcyZV3sfptS3tMlLMoYkr9aNdcAJLU7Jcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJOH2bZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJOH2bZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361261F000FF;
	Thu, 10 Sep 2026 07:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024940;
	bh=s83Rm25xPXSOYy1Iwg12cDHiV8jbFWg/wF6f3Gu1nxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZJOH2bZBjXlVlzSH+hbwUF75W60ezWzbLM8RQkYlRSedWHZubjL7f8FNPZ8s9dBwM
	 9pdovSq3xfH1NWHnOqQweMdS9MhappwswRFSfVx5zl+ziBJRb9amgTtVJN+AU/b/fb
	 xi5r1hJ1ChWpgO39G433AwNEwAyfqq9kE4T5xNK0EMxZqXzrF7fGFhx0uhRpFDqdy1
	 hn2swoa1Va9jyis0u76fp3lccQHszOVVovxamXmUBzZ0Dwxr42dPtKBjVK1IbKOqBi
	 l4/0HNts5m99fK5V9tIqaEfhqeX+eBUFdl11Klj8RD5r4fPRpCVA3iGeF2r60vWBxA
	 Z8ksgQIouoV9w==
From: Christian Brauner <brauner@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, jack@suse.cz, 
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
 ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
 syzbot+2a13ad6914e6fcec716c@syzkaller.appspotmail.com
In-Reply-To: <20260909-work-ntfs3-d_instantiate_new-v1-1-2db697162ce8@kernel.org>
References: <20260909-work-ntfs3-d_instantiate_new-v1-1-2db697162ce8@kernel.org>
Subject: Re: [PATCH] fs/ntfs3: use d_instantiate_new() in
 ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
Message-Id: <20260910-erbsen-beurteilen-affront-6a121821c172@brauner>
Date: Thu, 10 Sep 2026 09:22:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M/1WWSkETfqoyY1iNz5Z3vXCWfB413XOrMNZIKu+EKU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtilrOcMH5x5/y6YHPinTPxJXobf05TeXKrfKyrvJLl
 2JmNH1c0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJrAhXJwCMJHHEowM82MfK0mscfUV3rVQ
 9YPXp3kWqXFHf/6Zcvz2r9MP1swvWcnIsP+Pmcurm0VTKjb7cBXtlEldwn/jsP9d9eR5KY9YmKa
 3MQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 09 Sep 2026 11:03:18 +0200, Christian Brauner wrote:
> fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
      https://git.kernel.org/vfs/vfs/c/1abd643f3783

