Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F159493621;
	Fri,  4 Sep 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519666; cv=none; b=dmeDPrsSO8oY9/dKG5I+jnhEN0LTnBMuFovLYPitRIBcqNttk3LBY3l8aj379kBpGS5hwdKfSk2NKb0HssRJsklPrt6XpiDE79ZyT9P779/QHvms8a+mSQSgA5B4ZlA+wBDbWmRyQvze9W3h+u4enEl9hGlL/jN6v66Yutln090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519666; c=relaxed/simple;
	bh=z2cKPwTNIiqyjogBo6UsI0Fbnr0kO47LkHKPxfZzeNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HK2Zy0ISq+RZkDy89ePJRIxTXBlcE+x7pX5IpZMhchfPIndNlhsUh88Q/xejxIfeDlCGCDYHSISTNmcLrcg29oLEnTA1p6FzQvEskwst+yYWEb7pRQ4g00fhVzkao7hLph1UNsOtEecYaF37uDYHE0Xb/AP61O6COoJzVz5LaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfSQOfps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfSQOfps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ECD1F00A3D;
	Fri,  4 Sep 2026 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519664;
	bh=3xDOOLt7oFW6cDP8mf0eY5M4rroBz7YkCXFh+i4KZLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gfSQOfpso6hqdsme9VnbmP63DLuC8ekNmylHQy1HnWuYV53AAKSZWBJbhlBGbcB4m
	 ym/8rpUSJ33d9N1eX6ktn4g5ouoMTwmBWYSnKf884Zz3Yk4BJXuD2O1R/B0nQXF5JT
	 Xp2mvIiHxMOhVeA9HRnLO0xCnSUh4ZaqNQ+/Ko68Cbyw3EBvvYvJY5ZcCQo4PO7MA+
	 /9HFJVItvwK/SWobAPO8/FZfnPNKUGj733SNc5oNJ0hsIav7ViY2/a+/BSSJ/VYjTu
	 MTXSv1HZOuGpNP3NYuG4X6F6utGKsl5CcRiEIpJd/HNB3z4BFYX2BXrCTUS0Ct19Us
	 62EivXd8OAw5g==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 Amir Goldstein <amir73il@gmail.com>, Daehyeon Ko <4ncienth@gmail.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260902164924.1333135-2-jack@suse.cz>
References: <20260902164924.1333135-2-jack@suse.cz>
Subject: Re: [PATCH] fs: make sure to call fsnotify_inoderemove() only once
 when inode is dead
Message-Id: <20260904-hermachen-altgedienten-aalen-e790d524ea6a@brauner>
Date: Fri, 04 Sep 2026 13:00:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; i=brauner@kernel.org;
 h=from:subject:message-id; bh=z2cKPwTNIiqyjogBo6UsI0Fbnr0kO47LkHKPxfZzeNc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNWvLWfdkNp1OzPsUFmld82/h6SYP5v5qu5yd7nORX7
 H+ws7d6akcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBENjoy/C86/OLDh9xrDU9F
 DbZ1h7GctpfvYQqtru896tYcPtdR+THDb7bM5jTxb8eyzSoneIT2MZjFiExcnL6++KByWbWURrA
 bLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 02 Sep 2026 18:49:25 +0200, Jan Kara wrote:
> fs: make sure to call fsnotify_inoderemove() only once when inode is dead

Sheesh. Not pretty. :)

---

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

[1/1] fs: make sure to call fsnotify_inoderemove() only once when inode is dead
      https://git.kernel.org/vfs/vfs/c/669bb5af15d4

