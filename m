Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79632ED21;
	Wed, 12 Aug 2026 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520615; cv=none; b=iT5oybN2sduC1GHutrewOvY+MbhsNVLqy93ovQU7mdPaN58MqQHAUu3XG04CwJN5U8l+kjgvbBvwxRocBBWaqktQWp0dAfWdD64BzfKCzJi8an9H1k2sqAHrOCYPUDKc/14yQ1T1bRS1AEn/8bg5N9AjbTusQEQz9d0KVoJxj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520615; c=relaxed/simple;
	bh=oCbKEzMrSrLBlfkmyXR1UEYF3RY4CbqMgcl48WwJGKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NcVOl8V46cb0WFjkzSYI98a/4CFeza1Z1hrMz83nQWcO3Hw/QdJtJPdwISk+L/ktIx4N8pxwA6BtBnmzhYvG8BhG/nk8bzDyaV9AYPe4zx8lTlFt4dNUWXtXo6v9ZitCTW79kqIpn9PAmwMCnAYbZQ6R4GC8B1NnOLkeUwSw8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFXqfeX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFXqfeX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A071F000E9;
	Wed, 12 Aug 2026 07:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520614;
	bh=/fNBl1AVYmLz/IVUMwtjVNxpYD2IfzN9xWZKk4qesVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BFXqfeX6voYtzHDWJAkHkCRpwQCiosDHBthG5SpgFTr97PkSzDhHJCEDhmvQ0F3Bs
	 UP1Kx9p3d8OsyuMVRxtIz41Fp1FSO0zCJiJLVvWHZLlBghoGpLSRtl2jO6ExjGDxoC
	 biSXQ+pZsHKXbIVPzjKkOdOI1f4z869PL5Nb5+IoqF3WgkCsFQk/8s8OCWisiA50ud
	 csVKwWJJ9Np00bIuXq+al2D6eps8BB45Y+jlGdEy7KTTZG3+e2lM1yBMhPtkrs2efZ
	 rsVE14o3CI9lxC92iwABg6C4RiWgKGmGaraBpJbrZckAv9SRTG5ipPHJZLzo5Qvpqz
	 PguNRab4Q2Xtw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Josef Bacik <josef@toxicpanda.com>, Chen Linxuan <me@black-desk.cn>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
References: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
Subject: Re: [PATCH] pidfd: hold exec_update_lock around namespace ioctl
Message-Id: <20260812-gewonnen-kasten-heillos-f98528dd6ea4@brauner>
Date: Wed, 12 Aug 2026 09:43:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=887; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oCbKEzMrSrLBlfkmyXR1UEYF3RY4CbqMgcl48WwJGKY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVqKg87tj+79fS8za71C4s/aL0ac6c7/vEvsk2H7oWX
 HnlyG3D7o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ9DAy/BWODhJ5obyTteFy
 cdOKbdVdN9a/UtxcmCBU8N7LWchWp4Dhn86fhctkP7WUPWPJZT2zckcr7w++rmcP72qc3f3WK41
 vGS8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 31 Jul 2026 22:50:08 +0800, Chen Linxuan wrote:
> pidfd: hold exec_update_lock around namespace ioctl

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] pidfd: hold exec_update_lock around namespace ioctl
      https://git.kernel.org/vfs/vfs/c/a852a3066d3f

