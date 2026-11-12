Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484460;
	b=xXNQ2LtrdksR/ic2OKIXMLAdXxZmlvwgLn20W4tYKLPLRL3MrRVVbnLy09YmBe+9/n9K
	 SXxgVsb/Gz0/NGPtl4t6zACQtiftKK/cG+zCFSfbgdzexiLi7jv89nB3Bd9xWE1tp4DYK
	 q5Qi8T9RptRpeHj1ooyAcAhY2rt+Pz54xT1rTP2ivB4fHp+R98/ke15w/y1qKuiUN5HK8
	 mVVYqdG1wN7ggJqypCKC/oBhja88b6lKTZgJ20dFXrvTGkdydp8PAkkptGDW10t6sCGdK
	 tS217mGQ+sGmg1ViIpvqdcLsLMoWPq54rBHcIz5tO78Ap89RSfa2Y6vBvbWendcyv5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JdYD/YdMuJulWiGGAlT2Rpi62/Bld2oVWED5RC6QjGA=;
	b=a1KL9evQNBLZh/uzUjSewxXX1bmoPo1Tmvxe+Ob4bwrLnBOSO1elyWaa3Klk2gTIqiKc
	 l/ATAwO7rE+slvMVnba/ew+eg1T3rXdAawbtaPujeGYak5w+iTo7PZKCVb7xrL2QMmWrf
	 Cyru7EDuLnKe6Ja0So0mb4GarmhSR1MhuueHyC8HlEdvi9q9h1YoNo646954FiTnMB0R/
	 0h0zrUuBMgo6meJSouS0xbg9+JdwPK5LRydAHhpdlb7h5ULwfg2TNTwyxpMxUga9DjNc0
	 Aju42HJyGeMvL4tbS6a46S+nKj/C1YeTRwPMi7KwRttKEQamSExGLOvJdirLAkwxTmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iKZ/K1iq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5559606A321;
	Thu, 12 Nov 2026 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKZ/K1iq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ED21F00A06;
	Thu, 12 Nov 2026 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484460;
	bh=JdYD/YdMuJulWiGGAlT2Rpi62/Bld2oVWED5RC6QjGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iKZ/K1iqB0cnLxYHoQ9uVxCv0b+d4WthJcUEBANL3iO8xDOAY1zdbGmaFlcNBFdFj
	 m6kn2rPrgmUhvS4mRguW4tD9m7jcen5dda5WSkkV0cHEmXhfHUv6eYU3k1xSaNa79Z
	 IXJyky1bTv0gT41CyD7OAkAEUA3rOtRlpcdlcDL/b5LdjB5gyB+HGCMaBWwoyV6fCI
	 +9qQ5vZO5otJptN/vHoJckJUwGwf50A6JCcE9bUOcBSptoHJqtBiMqPxOEHbIUi/X8
	 vDJsTTqEMZPUFfr7/nUpNevSmO3bP7v9Onm5l/L9O5C8eglRGnAo3D8xeluHKe2ev5
	 30/GJP2YZRZKg==
Date: Thu, 12 Nov 2026 11:54:11 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, byungchul@sk.com, gourry@gourry.net, 
	jannh@google.com, joshua.hahnjy@gmail.com, liam@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, 
	surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	kernel-team@meta.com, baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: don't PTE-batch a swap-in over a
 hardware-poisoned subpage
Message-ID: <avWouX4hCmAz9F4p@gremlin>
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-2-usama.arif@linux.dev>
 <avRqaatdOUunxrcZ@gremlin>
 <d74a277f-f14c-436d-868f-2566d90bc144@kernel.org>
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
In-Reply-To: <d74a277f-f14c-436d-868f-2566d90bc144@kernel.org>

On Thu, Nov 12, 2026 at 09:56:39AM +0100, David Hildenbrand (Arm) wrote:
> On 11/11/26 14:18, Lorenzo Stoakes (ARM) wrote:
> > Hm, isn't scanning every single page in the folio potentially quite costly
> > here?  I thought the point of batching was to improve performance overall?
>
> Yeah, we don't really want another helper to check for hwpoison.
>
> If we race with concurrent hwpoison, bad luck. The slapped on memory-failure
> code is full of races. That needs a proper long-term solution, not more pain to
> core-mm.

Yeah exactly. See Usama's reply - it really does narrow into a weird edge
case. Scan there if you want to scan at all.

Otherwise tough luck yes.

>
> So let's please try reusing existing helpers that test the large-folio bit.

Yes please!

--
Cheers, Lorenzo
