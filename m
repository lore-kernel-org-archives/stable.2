Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8379F46A611;
	Fri,  4 Sep 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519800; cv=none; b=FFBy2jb61La1HZi+V7QpClOTowGQfN5O9E7EA79t+OisZB1c4/g9KCCBujrRHvTv9fFeQNxeWSJLfxsOLN6b9EfwHcoduRDXVJsLCnklFgRm4siZ/dJslkaBn0vArqpwjsyk43dqdwdgr07Bf1atznBakNNf1hVXZQSsnClYXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519800; c=relaxed/simple;
	bh=18YVgvMB0DxfzK9LvsfMuvJ/rt2ebukRfBITnVymCoM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tsoJBNTHGt4PNTb/fxfCWE+FNMOrwPFlnD2Xc+Hig4nsb2JGZnLjoCmHpN+PQorZk31U5hswljAZAjmFv0rxzY28frpu0sGIiN06dRYdhGz/UGXPIZ4rdeG8rdkkU6vauqiLOlirZS0cVu3XIX+gS5V+8wMrXDpeHX8JqOk7ZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWC/7QvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWC/7QvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AE11F00A3D;
	Fri,  4 Sep 2026 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519799;
	bh=uByyCyO/7thPi8sX7zSsrc24iP4tYdZOGq5Jf523xR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eWC/7QvEnpf7dgBL3lABZwTbo+2vbFDMbEcdbqdKD6O3wimagBJopxr93DzvAn7Ok
	 A3f0dmJHDGYmXPVea9TUnFD2fC5JRZB400ymVKBN9lHrCJbQYPpIB8zIW0xrEwTDnQ
	 7Eqfb8w2V3abc+UT2ysjWcmw9Y/xD4bmxUPYn/sotHc1n4TnxV6PKtnaAsj5pJidXO
	 bGci5SSnGQmamWUVtUdWoZ0g7/8jY+qaRq5G0MMPDJhit37O2cDBzA1Kq24hl9Tp2v
	 pa4W/X54s18UrHV6ULC4maTlfryoVNyLlVXzrXGG52clfQ/a/k8+PorZ2KfiI1qt5Z
	 KfoArmgpWmEnw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, YANXIN LI <fadouse@pm.me>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 security@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260718190300.867109-1-fadouse@pm.me>
References: <20260718190300.867109-1-fadouse@pm.me>
Subject: Re: [PATCH] ufs: use u64 for directory size in ufs_last_byte
Message-Id: <20260904-vergeben-macht-dienen-d958c8314f6f@brauner>
Date: Fri, 04 Sep 2026 13:03:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=brauner@kernel.org;
 h=from:subject:message-id; bh=18YVgvMB0DxfzK9LvsfMuvJ/rt2ebukRfBITnVymCoM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNWlr8i21iZz/fmrurtHnfbZNX2pU+a8HkCJlZJv9Xr
 fbxfSp+taOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi+mcZGW7ObNnZsf/E6/8O
 lx5JKqVUsBnsFc1eo9Ke5m3m8/ayvyIjw8Kkh1UbJt2+tdDfydW1opijavWxhBfzLASfHeXrZKm
 5wwgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 18 Jul 2026 19:03:07 +0000, YANXIN LI wrote:
> ufs: use u64 for directory size in ufs_last_byte

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

[1/1] ufs: use u64 for directory size in ufs_last_byte
      https://git.kernel.org/vfs/vfs/c/1eff23433e73

