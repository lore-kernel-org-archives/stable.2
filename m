Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707946;
	b=vjDAN6Ea82SSe0jHmM9DKozuQOuaJ/JF62A9EyZe/fhQ85xBB1Go+Qb0JcXSaC1Uuo/y
	 9fYpzk6LfVY2iIkawqciP6rvkDeJxS5zFZ0nxDaf5SZplCY3e5pWRbeBLj7g33aG9wsDd
	 +zvz8F1JEdxafDJqaadAHrUKrslssEPzMpWXGCx3u8TwLU/HMMokGw9zAoBcidxe6bLCz
	 43RdA7Zd4+owLtjKqriv5t2uw3x+iLwHw+h0MBhLA3bYPZTG3XSnoEUn3xjUmvScfSjGW
	 bMzRm7lapbavLrOmePyDi7sFlsKDYMcagpSQwDZfeHJmZhiMLQz97f2GKHU4oi6BIIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707946;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=witjTFs0XRhQGHANRoqXunLSxwvVpHwobjifW8w61A8=;
	b=SmCuKoCM0eraEcBkr942U7PyjSqjT7Wkf4eYAUUFeiJizcKObTkUGjUNo+OzHL2KOs08
	 jCQ7gokoLWRhN664pdkT0i3wKQYXqHRrNWVOKhxogzMxoMzBDdoY289H4ar5a9r+3UL/Y
	 TozM/ypBvNWqT8yT5FRv8D/0oZk5rIckr8+O+V64I6ciiUarHgnIXMUfdgPDnGX9Z7lVj
	 HNMWEBiJNe/tlFztX9xqBILe2lgNEYKtCaSUaVZgIOix5FFf/RMqX36jMtokZrIMN8JQz
	 O95cHNAInjpT3Am6G4P4HYuQSPXlff2IjLUIA+FUuwNNT8FyTyzclvovzSfc2L0W1Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcutroK8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1E606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcutroK8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC361F000C1;
	Tue,  3 Nov 2026 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793707946;
	bh=witjTFs0XRhQGHANRoqXunLSxwvVpHwobjifW8w61A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FcutroK8CsN0QCVtLTa+eGCpIWLSFhFI8O5WwXrMXdMuglYIk77DCjmIouseIrN7Q
	 K5l7x6t2CVlHuWESS+qN84YzzEadqTZ8ndoJ8vheNr6zwK6A5wrvc8saoYMQChHxjG
	 Ip4el72mYYEWrX9gGZRziAM3YJJqH70wJN3Ilxzui76w4tr4JgaU0eyuRzC2J8R+B2
	 8Z7l3ABkbU6/7ZxrQ0p2YOvKuP82wD7kv73W+PJo+nCm5PkfcQAHQ1WGty5s4hToOg
	 +7XbZzw8ImrTRG2R9lC5HhY7XFa1LcgOuxl7UtI9TEdXhMgj5rBuoBop/DwnOjGkmK
	 hP0D8z2sV5olA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id B5561198003A;
	Tue,  3 Nov 2026 07:12:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 07:12:24 -0500
X-ME-Sender: <xms:ps_pamx901-gQ9NgO9PbyRUJhPljJIF3g5vxcjkiwDH6aY5ErN6qOw>
    <xme:ps_parAKdLQtAqhV47NADyuhbWYN1csTAbfnoxNSVveUQLlUG7BZJIt_1NFWUDoET
    DVpNrTHMR59Cm54jlggx2A8wph2DhMax_Pq_7_WIcXZAxfbv0rFQ7b->
X-ME-Received: <xmr:ps_panDM4dvPLM3uldS3BuM7OSHVj_RAomXjfNjgzGWyz1L_A_2x-GNedmw>
X-ME-Proxy-Cause: dmFkZTFD6S4SqM24tZE6F+asJNAUKyWWUc97bzVAgcQA7flGOnDjhEQU22Rjt0vmbXDr2U
    k4HE2t9Z6iwbd3CGjG5eGlmZrERGt6xH6LTZJQzacquKN0rKfrcFehuVkofpLQNKI7cE4P
    qf9fswyJkIUyh7n03WoL6EhXVjbOwoGD2FHbXW6vVau9VkB5wT35j0NBJ3btq8xmsKlxjf
    R7EusK8UVJRFTbBqiB6Pcd1WpnMxzI52oE7gFRO+oqfedKyvMNUkLCctbN5I4Qt2rjSTgY
    J/mNGsB/WEc29sGhbJYkuS8EF0OiZtqsIfSTqPRWH5HXsC+CCeuX3AHIL2MeWwxk38PnTt
    T8tfosuUuo3mfYcIKr7qyfScKI6S4Q1+mllpc35VloJ0BHFdApz8hPuUMiS1RdsSKU4DkP
    zXSMjF/fczxYotS4FPhuvxJC5+vtGrMVYI328iDod54taA7J0ygmAuKiMUX4O+I/g4glVd
    h9BR29e98BHEDA8Vpi7vRBb9G/pYbbyyLm6NYxgcSvMn2TlL+jklB1SY0CpDJ/QRgEKEAv
    E+nYVIO5+k2P8wF05PnjbpwtvuaBWQhx2AtmkvNmKkD7GFQ9ocGcYvHN7CNP9TEGEio5md
    +FpmXG1BkbT2KyNt/tQrj13aeUjLFnM3dWvqQoUgI4BbnbiMpesZCoFD8lEg
X-ME-Proxy: <xmx:ps_pau5CK3bT9bRWkylSajSfn05LqblBzOTyRUZeb8vKRwEM6RYOkw>
    <xmx:ps_par0SrOHQB7Cjc9hXjGz4gkpQl0wuhfC5QFQv5JOZkiSG7r-kNA>
    <xmx:ps_paiB_TN_-DySTOk-IeN2BmE_SL5bmXbRHOgrTQ6xj7pCcAc-oLQ>
    <xmx:ps_pajHq7tT-BD5pWB_hZXxpXWgAHHzyFsXhLkBACPYEcBPykcTxAA>
    <xmx:ps_panQaMcjl5J0sTMVZaIsGJ2khidfQTU2yWk9RrG4DnJ9nsN9zXy4e>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 07:12:21 -0500 (EST)
Date: Tue, 3 Nov 2026 12:12:20 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] buffer: avoid extending i_size after failed writes
Message-ID: <aunPPm1d3G6yVCLC@thinkstation>
References: <20261103072234.55611-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103072234.55611-1-dennylin0707@gmail.com>

On Tue, Nov 03, 2026 at 07:22:34AM +0000, Hungyu Lin wrote:
> generic_write_end() updates i_size to pos + copied even when a nonempty
> write copied no data. Since prefaulting moved to the slow write path, a
> pwrite() past EOF from an unreadable buffer can fail with EFAULT after
> extending the file to the write offset.
> 
> For example, on ext2, a one-byte pwrite() at offset 4096 into an empty
> file fails with EFAULT but leaves a 4096-byte file.
> 
> Require copied data before extending i_size for a nonempty write. Keep
> zero-length write_end() calls working, since generic_cont_expand_simple()
> uses them for expanding truncate operations.
> 
> Also call pagecache_isize_extended() only when i_size changed. Otherwise,
> blocking the size update would leave its endpoint beyond EOF and trigger
> its warning.
> 
> Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
> Reported-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/linux-mm/at9xXRhD2xZhszEj@thinkstation/
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Jan is okay with what I proposed here:

https://lore.kernel.org/all/at-XtWBQg3jv3H8Z@thinkstation

Do you want to give it a try instead? Or want me to submit a proper patch?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
