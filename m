Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263983;
	b=0+HV0ZtD8VqONnbrDXhumKkp2ClNTj6EQ9YzHuWzFjtAhfHNC9ACfiAWAUKg906fQg9S
	 HhAI4BeldzSoxfuGucA6RJAqUhpwQp4BKOC+Y+YStcxPXi54tpWAhqzT5g6onaT5QBQCM
	 RRBhgqBy095fifb0UQFefZbX/rSDKrsTLWdsJTQxlnF0UW1/PZfH6DIKvkT7w+IIzFZVo
	 Izl8UWR4LWKzAikqWo9d0xbcxjdSQu2hvJ9a0j6p5WFv3yQF1aBHsdJNC0LyUlQhVa2hL
	 lI8q0WgLkClfWehxzpVeRpsWdJZmi9gKFwdVVE04muKQ5X3mf/3zZU7YcVsTI6OUTsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263983;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=C0neY9nO3KCbPA/3zfsAmJZKfNu+EcSR5phNhBE+ICg=;
	b=DhIj0xdtfd/sGSHWvqrFVinQb5N0RPNMG9oSUWP9vk2lvK580mEMwIq3zI/DFxoO14TY
	 m0BCOX8ewu5plIF2MF2cJjPe/P+ePnNA7ntIW0ni1I/WXWgyifnJKolaDqC9DhUoYaLcT
	 pzY7J1wQDak3/KXxgtwdygz8ojfQQtNis1VSx9xRgBJ56+SgV/1/gAkh7OI9a3RTREkpA
	 xvJejQ4pXYyIfT/bMQV7alFm1n22fWFmAWd7LuTkFpCbNTdxudDg/lacQQ4MRNENRPoei
	 LfNnf/GwA3AgYU9qwsmYHtf+oD1VFoJg9+tr99jhOYLv21I6j4vTOYD7aAu3ek+5Kbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBJKd2gZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B2606A320;
	Sat, 21 Nov 2026 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBJKd2gZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C998D1F000C0;
	Sat, 21 Nov 2026 12:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795263982;
	bh=C0neY9nO3KCbPA/3zfsAmJZKfNu+EcSR5phNhBE+ICg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lBJKd2gZtJqmOhALUfIZFUGEvMU9nWGSgsPCQlQVBuILcl3ryODy3jrX3L+5KxaNE
	 A5/UKy/VB9vg4xYZhigz4P5PaLg6q1sMJT26HWNFfUv4AiGMxWPn7/En1V+bzGAWZ5
	 VnEF0dOMlckg76+ITSXFVB4vjFF5pTCqrn2L8KbdQ+SSEWVkRnqQ6/0ZBXkJYcFbMz
	 ftRuhMvhUqewdzBr+hYn/LvI7xnCqMSiKxGDJT8W4F4NOTXhnuQ1sQ2OPsDwmJ0IDx
	 2Rig2v2Ew16plr0Ar6yUMRxKRLYoYEh+XLDaTaoxTeXyM6DEL4tncZsQ13OigoyRT5
	 qgkzmGsCcGG4w==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Nico Pache <nico.pache@linux.dev>, 
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Shao Mingyin <shao.mingyin@zte.com.cn>
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
References: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
Subject: Re: [PATCH 0/2] mm: two NR_BALLOON_PAGES accounting fixes
Message-Id: <179526397954.4537.13435944828068166975.b4-ty@b4>
Date: Sat, 21 Nov 2026 13:26:19 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Fri, 20 Nov 2026 11:34:41 +0100, David Hildenbrand (Arm) wrote:
> two simple fixes for NR_BALLOON_PAGES accounting. I can take both
> through the mm-core tree.
> 
> I tested patch #1 briefly in a QEMU VM with two numa nodes.

Applied, thanks!

tree: mm/core.git
branch: balloon-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/2] mm/balloon: fix NR_BALLOON_PAGES accounting during page migration
      https://git.kernel.org/mm/core/c/99d23a24
[2/2] vmw_balloon: account 2 MiB pages in NR_BALLOON_PAGES
      https://git.kernel.org/mm/core/c/7e980d06

-- 
Cheers,

David

