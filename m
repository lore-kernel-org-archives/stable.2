Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7943D16EF;
	Mon, 31 Aug 2026 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164762; cv=none; b=Hb3c16ah3VxVEtnaEKF8NlA4NeOObcp/j0tD69wv/OtpD7JluVa6y22DvQIS6O0X62gyVMXhiNInQMUKYgG3qUBM1wKvyGIbF7fGqFVNp+RFtozIyj0+QhQU7hvZk5rNvzW+OH+jrNimnvybs35xsQWW4/0qG8fzdpoGPdaybS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164762; c=relaxed/simple;
	bh=oi3IwRGEdFAcg1n0hcZwUHOudCsYct2I5HEiNEmL5wM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AeN0siJQDxYpVO+dgque4X6TagST1sG69dLR3FdBUB6WTPiVl2t2UdSrJioP1XANDd6DkPcEWjXNelSuhNkuiWMx4aSJtIqukbf1XW92ssdl0dMKxGjCbFhfys9CuVTJOM19wmUB4VREM5rpHlCb5gw8Uzj93UvdLBodcLrf9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4OuzjF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4OuzjF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D481F000E9;
	Mon, 31 Aug 2026 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164760;
	bh=Bkc3TtL3jy2b+pazsu82eelBxMwpygOXYf82m1fuwME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=m4OuzjF+GoDRFdIU0nkSPpq4UhwkK4XUvNcXvhKdh+T1Ag3iPX/NPwRkw4VcZWw28
	 QI+4nqLCPxSfL/kkan7lu71Tf/R/Lp0Z/VHitskkPXTT+HWs8NRni7U2sKENauQpwz
	 VCeOrqAahgIwl0AFd7LVK3goPaJLDWoJm+vFDcffYIkRI5+zTWtQUmQ4Nn9GZ/APyl
	 tX19339lrJz7zsnhU11eBH66L4RELNDsAXdThzKPZQ1N1nqdZreJOk6uR8q8WSZwSK
	 RgVngLlEr6ga1/pFoA8NyhiD7bXUn8kUkIL0UbA/07Jb93KxuT1YbA5q7SoPcs+oxw
	 zz+QfJBZx3QUg==
From: Christian Brauner <brauner@kernel.org>
To: joel.granados@kernel.org, kees@kernel.org, 
 "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: oleg@redhat.com, mingo@redhat.com, peterz@infradead.org, 
 akpm@linux-foundation.org, jack@suse.cz, avagin@gmail.com, 
 ptikhomirov@virtuozzo.com, mjguzik@gmail.com, include@grrlz.net, 
 ebiederm@xmission.com, legion@kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
 tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
In-Reply-To: <20260814040944.16561-1-blbllhy@gmail.com>
References: <20260814040944.16561-1-blbllhy@gmail.com>
Subject: Re: [PATCH v4] reboot: fix cad_pid use-after-free race
Message-Id: <20260831-mysterien-fachwelt-erfreuen-70b49c6e0bad@brauner>
Date: Mon, 31 Aug 2026 10:25:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oi3IwRGEdFAcg1n0hcZwUHOudCsYct2I5HEiNEmL5wM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNtZqSpfKrpOZA64TSpdmqc/dwpWw8mq/5KN2XeZuAt
 ejM/at4OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSepeR4YZk+I9ZU8/r6eeG
 skserhLoCngiIXvW+M+Hj/uqJpy795KR4f4Fh53Xn01o/r13eqPmNhOBz1WbnjteztY518/wN8P
 2PCcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 14 Aug 2026 00:09:44 -0400, Cen Zhang (Microsoft) wrote:
> reboot: fix cad_pid use-after-free race

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

[1/1] reboot: fix cad_pid use-after-free race
      https://git.kernel.org/vfs/vfs/c/5a88f78df753

