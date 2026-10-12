Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD06B283FE5;
	Mon, 12 Oct 2026 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794915; cv=none; b=PXxVvwjIkJ85pJzUMDZT8GgGUwNw+Yr8YtiHUXxfhr4Y63NiIE5i1UbSGbv/JL3omuqXanBQ59jlF0LwhDZfZsimVfci8mKoIgvxtQJTaVyewiDHeRFM/wEf+TCP2wuQFOHHAEK5W+c+Mm/MXCeg0P8y/geKqj1/WQWYeJH6o+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794915; c=relaxed/simple;
	bh=D2T/ZcrViDIEMuf2BBjGpYyjwTw2ZFyvcawker9vJZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H7YN3Ab10J6ExcS7u0O+ujdhpti23wi5TTtcAvC62iWZSrQ/2Zq+ppEBHIVc8LDKeIdgVr7Hgix0r+BPBfqVTTCE2OI42hR8lphFrQcxAVdzrOYYSf4ugpfxCXyzymP+UM3/ya8nK4j2RedF6a/5zm9VSPnDXOUpWBGfQm3M3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRqymb4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRqymb4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6790C1F0089B;
	Mon, 12 Oct 2026 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794914;
	bh=G+CtPiDfQVkz9f3GwytSDEGRsU21v8WZagiW8IUBOdw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bRqymb4x5bWra+5w9vuFnjASch7trGBb5KiYFmlG+o9C9L01prbkAWp09LazrU5Vt
	 djBM4kDuFoSEYyFQolIIkyAfXxNOZYdzPYzSlrMuSn5cl7GmTaYi/Kwtr2STZITng/
	 hkkgNB7QWa2WxBGDPAB8MnbE9VgesGlY+l8m5Agxyq7eZhDC6Y9/7yy52pd4HNO9dN
	 EFdn79JAwT0zxl5awGHIy//DdiuVwug5Q7sehg9yZ74fS0gLSekzMjTA7nPohrLffD
	 rNibgYva95rgOX+1fHYL3ZwxRoMUNuEJlOxIfyZMp7j/sKop03/2aPr/w5r3/IZ/5P
	 yAKd5JxdY0l8w==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>, 
 "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Kees Cook <kees@kernel.org>, 
 "Dae R. Jeong" <threeearcat@gmail.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
 tgopinath@linux.microsoft.com
In-Reply-To: <20261009224715.46121-1-cenzhang@linux.microsoft.com>
References: <20261009224715.46121-1-cenzhang@linux.microsoft.com>
Subject: Re: [PATCH v2] watch_queue: Fix note pool publication race in
 watch_queue_set_size()
Message-Id: <20261012-umgewandelt-drehung-ortskenntnis-40e943ecacac@brauner>
Date: Mon, 12 Oct 2026 10:48:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8

On Fri, 09 Oct 2026 18:47:15 -0400, Cen Zhang (Microsoft) wrote:
> There is a race between watch_queue_set_size() and post_one_notification().
> watch_queue_set_size() publishes wqueue->notes, notes_bitmap, nr_pages and
> nr_notes with plain stores, and post_one_notification() reads them with
> plain loads under a different lock, so nothing orders the four stores
> against the poster's loads: depending on the build, notes can be stored
> last (gcc 14 on x86-64 does this).  Since keyctl_watch_key() lets a watch
> attach to a queue before it is sized, post_one_notification() can already
> be running on another CPU at that moment: it reads nr_notes > 0, passes
> its bounds check, and then reads notes while it is still NULL,
> dereferencing notes[0].
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

[1/1] watch_queue: Fix note pool publication race in watch_queue_set_size()
      https://git.kernel.org/vfs/vfs/c/e184fdfd7ea0

