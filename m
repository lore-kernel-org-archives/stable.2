Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030197;
	b=4ExqhE0GisSQ53p+6Fr65gOjNu2vfC4r+aRQEtuaErHqdygwg/NNa/Upg4RrrnCA9+4A
	 /FhR9WonJ+g5HgIUvUZWGBwxm5E55NJ2j59Eno8BWcl3dW+Wm+8gNeyzPIkb7z5vkz7eE
	 8VGpxPEnmjdJVulODYwHCc7k2gmJp8WB0Ta+GOx7WENdVgZWbjIcERyi6mpLnuxT8q32Z
	 08Y8h4Mz8bAG0cWeJ2v0xk4BVrN2UhevmZKPVsPuV+j7chA8wBp76NdFSBH94m4MuPUvN
	 8EQBtaU8sPpEpDluViYq30+UCSaUz/MzX/Vn6jD07w1O2Tr8/KizGqZm30UrrrBiFVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030197;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6YIwg1aJhq4WGjRolwPANaDv/TOTLrhkHYOeCEH41Oc=;
	b=HuF69NKDbfXJQYCiPO/YP99zg13uSlPkCfJVrGK6CzMpIv+P1lcqkTtzBfPpQZijOCKa
	 qJT1DV4EEtTa6a0UbdwShC1Ce+Nww8kHqB5UygYeMAwtOuLvpDJ66rwvIqMhbgkEr1oCL
	 7ZNiaqYx6GjXsAPTwjW2Zc+QUoUkYJbQNhDV33YCmWH82h9EEeifm8JnQ5rxN1oFeP8UD
	 cIftJY8ByFEiDH+AkypJAXNWVekw01rvV4wyfPXuZf7SJdsfCVtDsVDg4Ln6H20wm+LUr
	 hC5GoYBqjnDkkbpZGvE/Zk9BnaisAj9gkxyhpmTnY/nCVfy7kJKYviDl/jSD5xd6KAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=uy4OF1Z8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62146606A325;
	Mon, 26 Oct 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=uy4OF1Z8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3F61F01828;
	Mon, 26 Oct 2026 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793030197;
	bh=6YIwg1aJhq4WGjRolwPANaDv/TOTLrhkHYOeCEH41Oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=uy4OF1Z8nc+aGLqmD0I6DdudJyArIB6exyFC9Kl8vVB86ytNblhhLlaRS3H9itES1
	 9GSQ+zpQxO2RAMQqg9+pWfk20mfy7l2rhyePnD0MgUP9jfo3hJdBkyl6hnzOUs61Vz
	 6XawunPDVCOwoHA/PfrzK75cEhkN0H08rPz7eC9c=
Date: Mon, 26 Oct 2026 08:56:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, "Liam R. Howlett"
 <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
Message-Id: <20261026085636.4cc194fdd7aad8e7d3e68c4e@linux-foundation.org>
In-Reply-To: <44405019-7494-446a-86b4-05b2ac03f768@kernel.org>
References: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
	<533c4ef7-e008-4439-be40-1aa2a074dfd8@gmail.com>
	<44405019-7494-446a-86b4-05b2ac03f768@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 11:04:23 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> > 
> > PROCMAP_QUERY does the same fresh lookup, shouldn't d9d1c2d81797
> > ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks") be
> > here as well? (commit tracked down by an LLM)
> 
> Hm, very likely I missed that. So yeah, let's just add it. I assume it won't
> matter much because 5631da56c9a8 is the oldest one either way.

I made that change to the mm.git copy of this patch.
