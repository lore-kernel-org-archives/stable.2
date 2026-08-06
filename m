Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26153486654;
	Thu,  6 Aug 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038603; cv=none; b=hPBt01d909nofM5qb4QDzSWegOawaUN0oduJj8q9p3uAPiDP+aDyhdoLZU1ht/OwQ6D3CIuKo4iPIEH8g34iKgNch20ttVZ1GhkmhkKjlnBYST7+OzHuYLHlJY3ETBlFoWfcj1v63DFsplj+sg+PIetxAaRgJ5lYW58U8pJPMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038603; c=relaxed/simple;
	bh=8kZFQ0tfZaYZzftS7/Tgrq0ZwuKgc4S5h4KJduHpFb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkgNr1ZrSD34mdzs8ZxM8wxeyIp7Gy8ybXGl3rZEKhWSSfto9a82SCfB+tihmP0VADyP2Dg6aKhtmH2LcCf2rom/dNjSMYi+u7mkOCSftyr+YT1PQcs1k+45TQBBlGx7X+UhcHTTe6QCP7Nea1OMt9vkCBhdFLt554lUCRRnvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUlr7AjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUlr7AjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291331F00AC4;
	Thu,  6 Aug 2026 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038594;
	bh=WOPx2EyXFY1KLS8DPm/AyQOQWbpHUOBhNVa7ZrJKkzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RUlr7AjSkJs8mEMsMOzX9NYI5Tn+OWpi3UjyL0C7eQ0PMdN5K8mYS+ctM1hwCOKM9
	 ck6Eshd+LzCFYrosbPzE9bcvsgB90VaIz0sdLZg0h16nuz/sH63+64Ir7rJA/CdamE
	 LJJ/zISNh/6H2c//99gjZNTMAlGa5gCpGD38BTFqvMOSVLrYtqsC6TNUiEicMacCEb
	 fPtKEQh2PbChvEstKttp2JdBpoQ8G46RMyoExXvc9Xmg/oJv+UdtXlOAs0Y7gAnL1k
	 xMJz57HM6FMNYa7fbvvr4oVhKNPXsbBKsEs/+KevSZfRlD6fyWF0WV5+BUvelYfMVN
	 bNMT84CAZJy7g==
From: Sasha Levin <sashal@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Danielle Costantino <dcostantino@meta.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Hao Ge <hao.ge@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R . Howlett" <liam@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y 0/2] mm/slab: fix unbounded recursion in free path with memalloc profiling
Date: Thu,  6 Aug 2026 13:49:39 -0400
Message-ID: <20260806131001.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806-kmalloc-no-objext-for-6-12-y-v1-0-036dfc3273fc@kernel.org>
References: <20260806-kmalloc-no-objext-for-6-12-y-v1-0-036dfc3273fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 05:37:40AM +0000, Harry Yoo (Oracle) wrote:
> This is backport of "mm/slab: fix unbounded recursion in free path with
> memalloc profiling" series [1] for 6.12.y.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
