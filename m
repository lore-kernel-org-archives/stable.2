Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A3364926
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067513; cv=none; b=LkAzIXWQalr27Ykt+ghbxQ6MhR7Dth/AyW4TQQgjgFhAHnJM0uWjf+xiq3rEeL8qGZFRVdR3IVd3ViNmJ7QfiyfE770vkRmWdy3cyFGYWXMTCDtgvIqBgGTgdznAl88DrWJgV9GA04iaRYgxCdjeDocC3bFVbpy1wJRfwjIsCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067513; c=relaxed/simple;
	bh=/ky/835ybr/0c8BYO3kr+Ow47NItS1mKvrqtqqA8A6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTZCAI3dQOTo2CasYfx9Z1FzHdDSKDsd6VkcIHyPYQnjjIL26Du4VUKXfKW44ig/XdnpdWjgz2kRQJ1ORqMqJiFIVTkN7LpWl2VbEpTyhaNP+pem5jetTgQJbpNBa05svswS4gJZVZzjI7qAL79wQjvZlKBuZ/8M5gNnPFHeM+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZwrDOgc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZwrDOgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32B21F00A3D;
	Sun, 26 Jul 2026 12:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067512;
	bh=0D5iFeoaR6z7LS0woIAIzihGrHzxbbaeqIZUtERHWwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZwrDOgcgLQht2zqsEeqEereEDraFeQuQPeIrv9W0ArT39uYiYQEJYvpOEu1H7jgI
	 kXq5Bqy92+hOkAEeVLhfvONT4v0WY5nM0SVgnmmL1mgqjHEpjsZyVZ3vNSFUq3gVkr
	 2OsKXjW2kbLHew5/ET358p0NEk1wBytl8mqxfm4yBUBWlbFvU5HOWXXEG+qgHyy1vk
	 M621F1KyTCI6du1yTyKXmVGY32ntwD8th24XxDiwxRpAM4grrCOqXwKa5nOryP+YHJ
	 ViA8gTHZOGXqwMmEErkdydOClxRqqtXSU/gUK2MCuKaCdih/G3PF21GGZFvMdI2uYE
	 fsFq2TgGLpbDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	thomas.petazzoni@bootlin.com,
	Hao Ge <hao.ge@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Gazquez <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 6.12.y] mm/alloc_tag: clear codetag for pages allocated before page_ext initialization
Date: Sun, 26 Jul 2026 08:04:53 -0400
Message-ID: <20260725192000.stable-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724080327.2337330-1-miguel.gazquez@bootlin.com>
References: <20260724080327.2337330-1-miguel.gazquez@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 6b1842775a460245e97d36d3a67d0cfba7c4ff79 upstream.

Thanks for the backport, but this won't build on 6.12 - it uses several
APIs that only exist from v6.13-rc1 onward:

 - clear_early_alloc_pfn_tag_refs() uses the 3-arg
   get_page_tag_ref(page, &ref, &handle) plus update_page_tag_ref() and
   union pgtag_ref_handle; 6.12 only has the 1-arg get_page_tag_ref()
   returning a union codetag_ref *.
 - alloc_tag_set_inaccurate() does not exist in 6.12.
 - the mem_profiling_compressed static key does not exist in 6.12.
 - is_codetag_empty(&ref) passes a double pointer, since 6.12's ref is
   already a union codetag_ref * (should be is_codetag_empty(ref)).

Could you respin a v2 adapted to the 6.12 page-tag-ref API? Thanks.

-- 
Thanks,
Sasha
