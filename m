Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB274582D2;
	Tue, 25 Aug 2026 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667933; cv=none; b=LOgCLFCxP92ifBKYFQ2IIXKQrsGWcKsJGayfa8y2Hq2n1JjWe52LyuIEbpyiBgyLz9SJik/UJFVASxADaCF/PtWZ5VkGbNMWAuynI5Z6GwGkRPxEf6sx4nJQ3yKJ90jQQGWlAVdBY8EOkqtnoL98/FnhfJozDePW/7FkrdzvBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667933; c=relaxed/simple;
	bh=MkDcXUxOCMypGbIkI04mgokcgesc9VGhmdPm7qYUypk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p/N1gFEnhXjLrNosEqj11hg9Ae4xP2DK8Md96EUf+tAt4HK3atVz3GwdCseeYShf268wD1JMVZp0RHY+9mjWsEyoD6FIVI07iTbU6fIelStwFNrCFimAcj5p3y+HHK++XC91+vW+l3AMRF5QFLLlLSh7V38Gul3Kwftt2QL/SZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtabIl+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtabIl+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120321F000E9;
	Tue, 25 Aug 2026 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787667932;
	bh=mZJ2DiN2JFMxvUlz0saZWT3wecmxQ6Pw2neVKElkkSs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dtabIl+cDfzfBiEgwrEHraRLf0rVWzSrAU6mhQtRLaF1KuNkXeCT1qZOSuegE6vjt
	 wT8Tu1ofUxX8qbdeA7fvvKfoI8mv9AHQDzQlX53XTiV99MU81jsN+C/mFfClDuCvNN
	 8RhjbMVpPciKVv3dLCQNBbrwepVmz+x02LDyVnBhZNVtROTiI9ofIb1Cwzw1/F6L7A
	 9jl93syQKjuJzeIMKA0wpPRYry16xWHYCf5wBsmzFqNfkrhaB+C3+TlZCc+q992ki+
	 eWZKOQsuE8HdSHviYA+YthWMQ5vn4riTB79vuCh8ARlOH4eyI3ruITsAuxxtKuskxA
	 OjTsLKbho+6QA==
From: Christian Brauner <brauner@kernel.org>
To: Simon Liebold <simonlie@amazon.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Alexander Viro <aviro@redhat.com>, 
 Eric Sandeen <sandeen@redhat.com>
Cc: stable@vger.kernel.org
In-Reply-To: <b1bd3b15-78ea-4487-b6a8-aad0b05dd3bb@redhat.com>
References: <b1bd3b15-78ea-4487-b6a8-aad0b05dd3bb@redhat.com>
Subject: Re: [PATCH V2] devtmpfs: restore mount option reconfiguration on
 get_tree
Message-Id: <20260825-hoftheater-kaugummiautomat-waldbestand-3e9312fecb14@brauner>
Date: Tue, 25 Aug 2026 16:25:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MkDcXUxOCMypGbIkI04mgokcgesc9VGhmdPm7qYUypk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1Lr2p9n/p+doFfjE/f2QGHf9evNt5fb34ogU/wm8fF
 F+tJx3I2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARswSGf8aMis8m8y881m+Q
 4FKxtHZD7nXN3BXrbD9xVq/isFpQOI+R4ecirr4LTbvXKb53sfZwYKy3OVWdzPXmg6Dt03NmDoI
 5/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 12 Aug 2026 16:44:38 -0500, Eric Sandeen wrote:
> devtmpfs: restore mount option reconfiguration on get_tree

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

[1/1] devtmpfs: restore mount option reconfiguration on get_tree
      https://git.kernel.org/vfs/vfs/c/6878ba0a7e63

