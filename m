Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F373B52FF;
	Wed,  9 Sep 2026 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940091; cv=none; b=ZMGQrzJQ+SRbiiDtOT0+OUTPJC4AQT4G9PBTdqUMsmkKbBChNK4EVHb/3H0cliwcyLhmupmqXpLQClN3aXNv8pSNBpaEfEkfJcM9P7cI0FwQXkriWBWQp1y7PyxIpgr/mSpUwl+Y1AE8M5tDQuadrK+olpn3/bx0GnEKHHc19AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940091; c=relaxed/simple;
	bh=I9M3R04EkQEegir+Lu1VoN5C7jd3YRUSo0T4jh5BPL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mXV+sAthQhw96ZVQfE+7toliEVYAbll+aVOjaf3R0cV28sZ4dKWQUnXyS3EnKpNG37UO8yT387uRq4o+WiM/IOon9Ce6iw8LkwhSN7Mp6DrPlHHHvxjGuomxvZarNJU8ETAP2oN8fx1F4+Kj+r5bRmbbUkvcFi9UQL2klHJEq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMGqn2GN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMGqn2GN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BDD1F00A3A;
	Wed,  9 Sep 2026 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788940090;
	bh=NmTlZYgllcdAcwuXRLAtZm3VmnUi3KHwBSOsSf3DGpY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DMGqn2GNnmnQxN6YjDAydKtb2qxX5FH9QZMqaTn8TDpTHwWFiDDs9UNwjpYRnrkBS
	 AL29TgpPLlgwiM2XF1R70gEKbEcgGz9s6hjCFFItfMxL+w+h0dlEADR3M1mu90Ftmf
	 c/ene2nicwnVw2hiet1YNn2yyCTXbP/HJ319oXSzHXhWwJctWt7ZSu+EgEGgmXJ+62
	 cf9lm+Za2MUjz+9U0SH6Tz2gtzYigDfD8PUs7I/dZqQbkHdZ8BYhKjiupm4O3eKOcC
	 7PV5ffuw73G4JKLlH4Cq1GA0b2Tma6thUswAB/pTh/rzPVHd/IuCidWRHj9iX2fLQ7
	 xabheRt9FjjRQ==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Benjamin Peterson <benjamin@locrian.net>, Jann Horn <jannh@google.com>
Cc: Jan Kara <jack@suse.cz>, Arjan van de Ven <arjan@linux.intel.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
References: <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
Subject: Re: [PATCH] exec: do_close_on_exec() before taking
 exec_update_lock
Message-Id: <20260909-glossar-filter-sorten-0cd07b1e8ad0@brauner>
Date: Wed, 09 Sep 2026 09:48:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7

On Mon, 07 Sep 2026 23:26:32 +0200, Jann Horn wrote:
> do_close_on_exec() currently happens while holding the exec_update_lock,
> which is used in a lot of places that access process state to
> synchronize access checks.
> I recently added another such use of exec_update_lock, causing a
> regression.
> 
> do_close_on_exec() can block waiting for a reply from a filesystem.
> That means a hung filesystem can block codepaths that use
> exec_update_lock; and it also means that a FUSE filesystem which
> attempts to inspect the calling process can deadlock.
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

[1/1] exec: do_close_on_exec() before taking exec_update_lock
      https://git.kernel.org/vfs/vfs/c/e780259b54e6

