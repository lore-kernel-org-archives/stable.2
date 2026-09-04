Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAFB3CF02E;
	Fri,  4 Sep 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508132; cv=none; b=i1TzGZ6MKPlll/VHAzvUWWKXGdxAkr1GSRo/AZcIvlK9zWt4Ipb3waNoVpl/VtICYtiyuh4X8pfynXbNx3K/tbHBzQGY87XOObc+lEYlrrp7Ab43+tGMnJmiF60cmuXzMlXDr6E+oQbdCSsgX/VZ16WM7UROaKC35NkSSesMvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508132; c=relaxed/simple;
	bh=3suuW/WPNHxJ4naV580x1p8zMeyrhXQAmIfX9M8X370=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUy6yZu9vaF7CUVqNCE809Bm6/wZGNsQZ+NfQYwpZRQMkLXdjNObZymfWU7djrFkiY6SemadYk4ynhSwtJEIW1Q0RmY2oPmbp34UlvJHrfZbyg9QwofL5yVsxPjd1/49K/TNJ1dhKBmeH4Q4M+ZuLEyt4iCjKY+bJn4BUYEDHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ituYMMNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ituYMMNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB8A1F00A3D;
	Fri,  4 Sep 2026 07:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788508130;
	bh=g/hRjVwq9fUsDToDiqPe96z1+CyN9A9espmJr7PDA3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ituYMMNGsx8cHBERBH2p9hQ6Siuc6jQwTsXRCiodHhADkJ1oABOX9towzpIXqaAhM
	 tcni0gVUf7K4LGhOy/p0bCAo9M1DN+IcvW4YcGxPH7FMNBg6NSYZnyZdHf7VIkMIin
	 eWDpcUn61dzrwMVpyfr+dEJu1xO9eJaa9h7ElkOyK5VXf4Px89NpvhVDyUKxaGz3K+
	 KJ/glm9p7VUW2Mtk1Z/eSsZhrQyeVP1mQXj4hsnxlR5aCaF3fo5aps2RyuZvwY9noO
	 +qwVAgwUR0f37BOvYH9H6WtNIQq07uMIf0dxI5OXtypI7lTezmtBENJZ/71MlYFheZ
	 b3lSPWPL/iKug==
From: Christian Brauner <brauner@kernel.org>
To: raven@themaw.net,
	Jeffin Philip <jeffinphilip14@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	bodonnel@redhat.com,
	autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+df1db6e034b3953e19f5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: autofs: fix memory leak in autofs_fill_super()
Date: Fri,  4 Sep 2026 09:48:44 +0200
Message-ID: <20260904-knochen-klemmen-weisung-48c397853dbe@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903081048.132524-1-jeffinphilip14@gmail.com>
References: <20260903081048.132524-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=brauner@kernel.org; h=from:subject:message-id; bh=3suuW/WPNHxJ4naV580x1p8zMeyrhXQAmIfX9M8X370=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNKr/rzf3Yc/XbFvX1JsqKx/NCTfoEFz456NTQXKpk/ nyTpMr/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImomTEy3BNt+Ws854HEsqji KeXXFx9YtNn7ssP19d46ii93cRSbGjEydMew1xsG2/X8mzpBZv/+h//0+vbsWrQ+9HOTfIaQ3zJ NVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 03 Sep 2026 13:40:48 +0530, Jeffin Philip wrote:
> In autofs_fill_super(), we create a new inode using
> autofs_new_ino(), however, if we fail to create root_inode,
> (that is, root_inode failure path), we return -ENOMEM without
> freeing the new inode(ino) that we created causing a memory leak.
> Fix this by adding autofs_free_ino() to free the inode we created
> in root_inode failure path before returning ENOMEM.
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

[1/1] fs: autofs: fix memory leak in autofs_fill_super()
      https://git.kernel.org/vfs/vfs/c/5ab54837fce0
