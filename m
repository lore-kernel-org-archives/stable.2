Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299507;
	b=HieNCF26qaWayItOAgJNtPvCrQBkWceVyy8j/Nc/hVg+5S3SHGOVfrU+b4dcwlMDguBQ
	 DvNe4kDXtbDKn36fHc4dsS5STYwhsxOuYl3VaaNUjuF8rDGtD4vMWzAzNPeMIc938TErr
	 Iqvhby7a2CY1NdsFt9JVhS+5ta8YloDW2kkNJ56xT4A39ujISqtLG5YbVUoLkHDJaqn+7
	 DiXoRabYFuYyOdNPguJp6IcPYZOomlxTKQqkJrKgUNUD8jLs7MmZTYZXlu9XbPmmfrm22
	 qEKxQT1yixLvNbS1gT2QOoJ5eyTE+8thajLFV7jIs+UyTG5vXnA5SpQ9r3tOgY3PtOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299507;
	h=Received:DKIM-Signature:Date:To:Cc:From:Message-Id:Subject;
	bh=N0YfuE5S7TLOtCEMAv+z9+LjiAnSl4zyEz39ZHosAkI=;
	b=2AK0k/6dLcue0BhlNTpywmSFUMZGWotGgC57pINIu3SycW5nCfimRVO6hxSN1Pa5lDC6
	 Tbw8X694QOujTaDfcZRdJG0584F6gsdyPAwZtO0bMGE5tK62scsSINW2j6rQWIUUOFJCD
	 xpqPHTo6iAFHbLLTOX1ZSMi193t1sVgEoV6/GcIpXksCk1Pwb7GI2z5sJe7A0mxd9akKR
	 oaYTktOE0AK1KZNEEDtlh0ybck2nL0xh2YcmVqeYRmJr6XJ70e+3AuJBy0EcghuOwqY+z
	 0BolvWpd/hk7eqc3UJcCNy/aazuplb/wBcRymtQACv/EK1fi/JWzvsM3E1UVcMgoQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Wp6Y68ZR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C0A606A320;
	Sat, 21 Nov 2026 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Wp6Y68ZR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8311F000C0;
	Sat, 21 Nov 2026 22:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795299507;
	bh=N0YfuE5S7TLOtCEMAv+z9+LjiAnSl4zyEz39ZHosAkI=;
	h=Date:To:Cc:From:Subject;
	b=Wp6Y68ZR+OCI+WL8RDgWWBzIGteS8FphxmBiCZy/21zFlQ/k23FRiLZiK1iB07qUI
	 lihHS9CNc50XF0+y4fj+K2O28wgDvXeHvU65gQPNtBzRL5ymwAThGUqOtS67NBrpud
	 88Jc2W1EphYLz+eKyKQMruJzLJA7eKCJkk6UnvMc=
Date: Sat, 21 Nov 2026 14:18:26 -0800
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Nickolai Zeldovich <nickolai@csail.mit.edu>,
 Baoli Zhang <baoli.zhang@intel.com>,
 syzbot+73641b60a3bc11dfca8c@syzkaller.appspotmail.com, stable@vger.kernel.org
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <08ceefcb212e4dda9767389fe7f162a8.0@linux-foundation.org>
Subject: [PATCH v2 0/2] xarray: initialise the offset of a new root node
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

An RCU XArray walker can read a stale root offset just before another
thread grows the tree and links that root beneath a new one.  The walker
can then return an entry with the wrong index or skip entries.  Check the
root offset after slab reuse and initialize it on allocation.

Nickolai Zeldovich (2):
  lib/test_xarray: check the offset of new root nodes
  xarray: initialise the offset of a new root node

 lib/test_xarray.c | 33 +++++++++++++++++++++++++++++++++
 lib/xarray.c      |  6 +++---
 2 files changed, 36 insertions(+), 3 deletions(-)
