Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE8311C2A;
	Wed, 22 Jul 2026 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727456; cv=none; b=eJ9lLK8b5Y4KxmTg+qqeCTzCmMFX2/EYpcuLiLfZKWheSmKpDou37Ow2XI/gw+Tc+5k2lyBeEH8mIdNJbSwoTW8NxUiE0EmuhUItLUaaA4ol0wxZRhiOPoHaiysCXE469AqpjbyftCF4NbeS77/MNzPrDx6QSLyA4fdm0L14y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727456; c=relaxed/simple;
	bh=U91bvDA3b7gRZRy42r6if3WIVZ019vLOkJhGb077BMs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pVWiwjWNYX/kLG0UR9anH41yiLkrWl1tDPWOx/3IAz1id/ZxiVSnm6RYvXzlKjVZLdYJJ7tSpmUFvz6iqSBFFiB6LjPj2sOFcj0KEb2DOEYt+hbIO2GTcHlFT1/9z9z94FTWFN+YkWLOHqSK+aomPHnw8j+DEe00KX5P7oTxC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+AyCoL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+AyCoL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4F41F00A3A;
	Wed, 22 Jul 2026 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727455;
	bh=43NWuSqgzCgMS5vwasXr3DI1Df5f1EdUAGS/kRSb034=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=m+AyCoL8Cfrtr0DoSb7tXzZ5hETr17YLecwyUYWACXr4F1eJJicAdleV5Xzz5Il9G
	 xXIg3+ntJx3JoonOny0jfcUYTk77JNbd1kq1z5sApUttoMTBi0v5KqsktArUSFoCbL
	 1gFhWwKnP/qAu6zGm74slnz1Hb1QV1iJfQzsXpg6+j1mdIE+mAFa095EwESM34sGfR
	 qin8YZZQeIrf0C3kdjF9l2ZaCHnaA/DvT2V93ynshghVhsDXEPPSWL+6l5pQ4gB7YD
	 fwGnsR9tJB6R8bU4utd8+4T/ysLgRFrDzbpxxsJYm982C/JT4n5ln8usBiczYnI2Mn
	 VzAD5H2jZZoiw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>
Cc: Jan Kara <jack@suse.cz>, Magnus Lindholm <linmag7@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>
References: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>
Subject: Re: [PATCH] proc: Fix broken error paths for namespace links
Message-Id: <20260722-anflug-getadelt-veruntreuen-63d5d75b1bae@brauner>
Date: Wed, 22 Jul 2026 15:37:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=brauner@kernel.org;
 h=from:subject:message-id; bh=U91bvDA3b7gRZRy42r6if3WIVZ019vLOkJhGb077BMs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlHJ+z1Vrqc1ayz7zflSu7D5/98Hhakl2sUpF4WvXss
 v7XkTOmdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkZQfD/5ygk5xnDaJlK8Ue
 tEjZznY5wlfnfntud6VGx7m2J51bmhn+u6ZvPrk2Wu3syy0qTyZ90fD7MPlb2HOX8/Gvv2xv6rx
 WxAoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 06 Jul 2026 20:22:42 +0200, Jann Horn wrote:
> proc: Fix broken error paths for namespace links

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

[1/1] proc: Fix broken error paths for namespace links
      https://git.kernel.org/vfs/vfs/c/93f3b5b2cd98

