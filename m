Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097853;
	b=qU9joVQF8UabbsNFhciBNSCOsAqeY3hRh18kPzMFopnNai+jv0Ob7nM15nQJ7FD8qenL
	 yYSpg64mu6zmh8pNW6US5fxJ13rQtgMZnt0NIw+GtrA+uL10N5ZKouQU8a1FoGEVLvGgU
	 edNJMm4FCO4NoLt/dzBRPwDqDjmQg+w982WcRKBu4+215QY7+Fj0xfY5OVosCHo9tgn6R
	 EgcHU5NAsRwoZC2g2EiqKFz+0BPFWD6K0ko0PTNwELrUtWMRgWuMzhxDVlAbM2JqTUwef
	 vzGpx8HRisidco2Sf/K1ljTDo5bp96NPCElFLUR1gIAMNghDRPXBY4fWcJDSrYYxswg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097853;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=4a2jBxmTGeS7x0J+UPLdZcnBsOb+omT2yoUVF4EpeHM=;
	b=ZmBvPUbh/gHurok9Z7iXfh2XhHOp/AlLEeO+OXkB/bcqEhXUAZuyy7h1C9CWDTsrdYU6
	 LGhxl7GPIQFAoYx1VP3isQw8JABQnVPekJSkO44Yi6Uylg2N8C0DQIJeugsaw8VnhXQ24
	 K2Tqa0ZFzcUf8WDWhRQNowY6h5aJfutCMAKgg9281hU7YLz1RoyFt6AtxRADTGcoiM+Gf
	 zeaq/5PFxXrFzgupNypFcYImeN7IF+WkQaBo7x+tKwlmxgymYonnv99DY7j4MmU+DXaGh
	 7otMbzzk/Uf4de5P6hyTi4msUAiWHKFI7Z2txC/8ekKNBIF7HNZEogt5biNHpX95yNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGeyCwJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE09606A324;
	Thu, 19 Nov 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGeyCwJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3BE1F000C4;
	Thu, 19 Nov 2026 14:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795097852;
	bh=4a2jBxmTGeS7x0J+UPLdZcnBsOb+omT2yoUVF4EpeHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aGeyCwJPpTXE+mb4vrU34Ck9HTX8hTPwoByPNqaY4fBorqdYdyRnYT89SlsWMypq0
	 FghWPT2lrkdazc/twL3n8P7Nc/LJh//5LqzPbw/eQ9x/JuT3wxVFGOQep3sx7ZyhCU
	 Aah8tPaygOZ5RLWKFxFNt60IDxpW49Td6vQQ/qhiwgzm0klHZklhfkGGTZwHCqmanz
	 H1yCpTcuU1LllyPYmmtZAvvDr224na5HEiPViwxOgoyuaicsLOq29KSDEJqny1oprk
	 II9a2xmrdr8kxzmfkWdjzgih0L3G+2P4uzc8IyP/oK6W+Jitjyys1RpG5btrNMmMvF
	 Ca5aitBdpdS5A==
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
 Daehyeon Ko <4ncienth@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Haocheng Yu <l1za0.sec@gmail.com>, Tal Zussman <tz2294@columbia.edu>, 
 stable@vger.kernel.org
In-Reply-To: <bc6dc5eaf825462783cd3a606636e92b.1@linux-foundation.org>
References: <bc6dc5eaf825462783cd3a606636e92b.1@linux-foundation.org>
Subject: Re: [PATCH] iov_iter: validate extracted segment for bvec
 alignment
Message-Id: <20261119-zweihundert-zerknirschen-halsschlagader-e8fdcc40189b@brauner>
Date: Thu, 19 Nov 2026 15:17:27 +0100
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
X-Mailer: b4 0.17-dev-04696

On Wed, 18 Nov 2026 10:22:37 -0800, Andrew Morton wrote:
> iov_iter_extract_bvecs() validates iter_iov_addr() and iter_iov_len()
> before iov_iter_extract_pages() selects the first nonempty segment and
> limits it by iter->count.  The checks can therefore cover a different
> range after a leading empty segment or iov_iter_truncate().
> 
> An unprivileged O_DIRECT preadv() reproduced the empty-segment case: an
> aligned empty segment followed by a misaligned one completed 4096 bytes
> instead of returning -EINVAL.  A truncated iterator has the same mismatch
> when its full segment length is aligned but its remaining count is not.
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

[1/1] iov_iter: validate extracted segment for bvec alignment
      https://git.kernel.org/vfs/vfs/c/5f149185fdea

