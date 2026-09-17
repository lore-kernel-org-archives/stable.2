Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D57B3DE43B;
	Thu, 17 Sep 2026 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641198; cv=none; b=I70/RTVc0rAW2YgffswceVZp6MTPtyAWwhEcVYDtFYrMvQygeI37J9zgmx2cfoIZ/nQexYp7hPCI7yiWxZUxB1+o8oucpiwxdzu6rIRd9f31TelOksMYJYGcLcgi+GEzoYcuhxyAGGZaVlM0TC7gdfa+orYtYW6smWHcwqIx8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641198; c=relaxed/simple;
	bh=80XD9S5ITmny7QiTJMLakTTVPE6tw/cqdXx5ulS4tx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpG3+7ERthYsDl+EEw0nGKofJaTeuJNNhU4fMRXy6na1s6W94/x1sPe4k4SVB8rT8R+CFgAEtaaBE7mPYUbijFpasq4PCFWiA1CZdob75MKFKAIn0ySto0U9UCeDqep+txi8wI+jKHoUqhV0qrl4w759n4UiKsNyV9ukctl1ZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIL5jHfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIL5jHfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5551F00893;
	Thu, 17 Sep 2026 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641191;
	bh=45lxnxrmgTvvTAazCnIv6gwMgCDwiPn9pKDY7jBHkBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UIL5jHfgB6nWcbr6PGZnH8JagxrAwVEwCT8hK45Q8pfCB+4+iicGiX7IfCTeBYBNl
	 omRkY/W/+U1XZ33fBb9yFlrTpMHph70uHR69/5owUmKO8weFCOxdKG9tpACfkB9aF+
	 J3gTniqKsMBAkIfjY2Mj+P/NLJmB5HMbfqzgdcxiOgOQQ1eg2ovkDs8HY2wekEdthd
	 1V9DCFqAsgY9NNPzfFETRm3w7XMv7flMoTe50u0KPKIGYNpx3Fmow3x0haSg3IZP12
	 l/SkyDGRrbizzx2WNr8amrJmkhpuGVpHxc/tND8rUt8c5EEp1tOgKuAwPAmN5k6+zd
	 Thf8sYXdXcSlA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] writeback: bound cleanup_offline_cgwb() rescans by rotating scanned inodes
Date: Thu, 17 Sep 2026 12:33:04 +0200
Message-ID: <20260917-jagdbeute-achtzehn-klischee-976527317cd5@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911-wb-cgwb-rotate-v2-1-a9ab253a1295@gmail.com>
References: <20260911-wb-cgwb-rotate-v2-1-a9ab253a1295@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=brauner@kernel.org; h=from:subject:message-id; bh=80XD9S5ITmny7QiTJMLakTTVPE6tw/cqdXx5ulS4tx8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStPvhQKiCn/d+MxZ11gvYmS39wxwV8nNhg0y+z8KByl dGLDJMVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRkGX4K7NZ2OXf7+Dra+Ru 3+e8cvHOKq8lDlOM1bWepO9+xsoRys3wz/izytl1Dp6GRVNumR+4ui71+YqaWxWiz9u6JJc0t+Y /5QYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 18:49:49 +0000, Patrick Lu (Anthropic) wrote:
> cleanup_offline_cgwb() prepares at most WB_MAX_INODES_PER_ISW inodes
> per call and is called again until the dying wb is drained, but every
> call walks wb->b_attached and then wb->b_dirty_time from the same end.
> Inodes already prepared (they stay on the list with I_WB_SWITCH set
> until the switch worker runs) and inodes that cannot be switched
> (I_FREEING, I_WILL_FREE, !SB_ACTIVE, DAX, already on the target wb)
> stay where they are, so each pass rescans a growing run of them under
> wb->list_lock and a full drain is quadratic in the number of inodes on
> the list. With ~17M inodes attached to one dying cgwb we saw this end
> in soft lockups, with CPUs reported stuck for 21-48s.
> 
> [...]

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

[1/1] writeback: bound cleanup_offline_cgwb() rescans by rotating scanned inodes
      https://git.kernel.org/vfs/vfs/c/f6988c90671e
