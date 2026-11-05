Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903963;
	b=dgVhBpCQL5592inbFVdxVCA8JbDu2hQICaSwr9yfjucnZwVXG7SDDZzOLqfbMqJVOiWG
	 AMrCTuH0oUnVfZ06hEIXPuN1Rn3EJjapjjW88snFfNIyeMrSnUkEnaJJNhRqlSrvTijUF
	 Zv9oblhTssax7KpB2vuPnIlWS42018J2CoE/XDONu7d90PYX29zooSyNMF3uAK5Mr4Uws
	 6rfI+cbEmmxW06J0qYyElrqH5hhdfvrDTmqhVazyvvAC+qHZ2c8N3xN35RmBXovZt4QQx
	 LPiJ1z7WSYDbn3ReIwGvufxm3QBKKZSdAGCaTs6drJZJj7dOz7tL7wz2jdE9X4A3JOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903963;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V/SDDxz3wlKXwyaEwTsYPI4t32wBGHndbEsA/WUskPw=;
	b=riemhzZcV8cXmmDleH2PRcXsOu6ehHikkRAK0q+a9x+T3P9IUZbQTo9ejwDllq91dPxP
	 XSP+pU7e4bf5jaVLOj8YLZsxp9ziJEQWhBYDeAdIgcysfCVBWAKf3631UQ1t/o5/qnGvX
	 zhpeAwzTk8K7Ocn7ByqqWVMm795hXdBu0tmOb7FQSP5FBFtaSaWVu+qKvo5N1deGqcYXi
	 bnF5dH3MDRrMbRYw2UzY/lyrENLM0wLN9Ipy7Lf3ThSvXNUYPZ0sCe2+qlKVvP1lhXcHH
	 EiSyQownlmhmXU6lvR1SAwAwk+EwvshcRPpaeJPHmlVs3ulIt+xf32DraagtvxyOt8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WL/9FlIR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E7606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WL/9FlIR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867D91F0093A;
	Thu,  5 Nov 2026 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903962;
	bh=V/SDDxz3wlKXwyaEwTsYPI4t32wBGHndbEsA/WUskPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WL/9FlIR1B3O8gL5tePbPzNclFkescsqZ3igNByTag+F3jKK+DRWiSBS0VZZMQd2i
	 upg8HyE0MaXw1v7ZeuxETOVJC8HXqcIbE2fqDbXw6WY3LvZSKmqO4gM2AStHCVygDF
	 PIHqnGlUJ88TRWRwqqJDQYHrl0gVWoIT1geyir7LEiw0EPbRAK4Ac/+KS8AjjGdcad
	 oE6kjk788Qposg7uPM1RfpVSePPbw80bD5VA0NZmgoxuvfBH/6eLwFBj2XUmzcBOrT
	 zj4wU6hTKgedBpt2jhISXhR53zy4iXA8ovrqLRoO+jmPeYatwwKa2wMBaX+o5QtaMJ
	 vFDiQo7FFCUHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kyle Zeng <kylebot@openai.com>,
	Lance Yang <lance.yang@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"JongHyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 6.12.y] mm/rmap: don't discard lazyfree THPs at PMD level
Date: Thu,  5 Nov 2026 13:39:07 -0500
Message-ID: <2026-11-05-1-daily-reply-0002-mm-rmap-lazyfree@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104155648.4014303-1-ziy@nvidia.com>
References: <2026110438-manpower-atrium-3945@gregkh> <20261104155648.4014303-1-ziy@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> __discard_anon_folio_pmd_locked() clears a lazyfree THP's PMD before it
> determines whether the folio can be discarded, and restores it if the
> folio is dirty or has extra references.

Queued for 6.12, thanks. The 6.18 version is not needed, 6.18 already has the
fix queued.

-- 
Thanks,
Sasha
