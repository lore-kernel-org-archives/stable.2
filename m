Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB764C0426;
	Fri, 25 Sep 2026 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349762; cv=none; b=A9mY+KqEPLrIg8EnMuH43x2ic5oyzZM/sV3fED4lC3sf1UmcRjFtlwYB5lu+vlWF8yR4VIp7xQce+dduk3LFCUrpFSNmIbOvBeHt0Z/IaAp3pn2pa6LiBXI2YAflpopT04VFZel845tuPabuXU8TDIR0ZnbuHbG8g5Nw+1bnP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349762; c=relaxed/simple;
	bh=a/4ADJbOd8sLho6YLFhg/EPEOq9EHI8pZzqiW7RQA38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C9ycIZfOcZUgCrcAb2k2lMi5fYxCLL0U5h7B8yLFyXlMaf4y7LjZK16UPKM6t0kLcN4JDjQ9ATIcfMcME12Fd0ikxY57nNt2IQ1R/f0NYllILWwDdp5Qxk5STt+9fQv3EUoHYNMNhB4SyO7DLy/4WyIHBrPDB4Kt5MJHHtes8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjLNjpD7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjLNjpD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1741F000FF;
	Fri, 25 Sep 2026 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349760;
	bh=KriGHtIyXKt/JLmxE+VFLzUtULWIvJuWxYuFwNfEJxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JjLNjpD7yGEJYKrOEKr7mglZC0tXCrMymFcE6KcBiLpvLWfdufcbUCSD8oCpMflX9
	 e4GxmLlco2X9qru9boAePq5swLgbzneixNCJeGIQdLy3L0zBekxfjyCvoEU68Q4dRY
	 5JXfb19iGxXSlHOk27TCTnw8/FX+yCgzHSZiC7wxb7+QAsWNbdzyyQTbFJn+vGmNH3
	 c/Dz3s+hzQodg75oBIHLKuPDoV5yJjS4kkd6DYNesUbC8k1pUnXs4GSlb0Ex5gQRlV
	 sitCoUT8AWMpItEbTFTPSqiIojzQ6Vg0DTps5fVTVnq+KtZwY6O1GTS3tX+QVfFDgV
	 HqZytxg98HAOw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260922145530.369775-1-parri.andrea@gmail.com>
References: <20260922145530.369775-1-parri.andrea@gmail.com>
Subject: Re: [PATCH bpf] bpf: fs/xattr: don't assume the inode is locked in
 path_unlink/path_rmdir
Message-Id: <20260925-letztendlich-hochachtung-unzeit-f43c63617e87@brauner>
Date: Fri, 25 Sep 2026 17:22:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=brauner@kernel.org;
 h=from:subject:message-id; bh=a/4ADJbOd8sLho6YLFhg/EPEOq9EHI8pZzqiW7RQA38=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtm7gn27x/dX+5k53wAWObgLg3M5Pf9yTs/M74e0nK6
 /NmDnvXdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEt4jhN0v22dZT+TE/brXz
 u0/hq7Tn4nvuOu+tp42+6mW15d8/ezL80/X347vX0jmv3T9F/f5j+6kH7mr5+3iZLraNF8uZ5bS
 bBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 22 Sep 2026 16:55:30 +0200, Andrea Parri wrote:
> bpf: fs/xattr: don't assume the inode is locked in path_unlink/path_rmdir

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

[1/1] bpf: fs/xattr: don't assume the inode is locked in path_unlink/path_rmdir
      https://git.kernel.org/vfs/vfs/c/35d442ed1f86

