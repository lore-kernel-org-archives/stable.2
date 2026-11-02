Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587239;
	b=jedpoW/9hZkz4BFnAnxzw2v6WjG9CYX357A33yENIxqkwSjuEXSSZmpRnwdG/n2+7aX2
	 /stk8y/7070aTVjtI8Zdwz++pUmY5Ej+d2te/srCgh9CJRws+JwgCFo8prPPZWy8+W7h7
	 KPkUBhf0klAOJ3nJrJZWjvsfMDq/x7QM+F/CMLnipLBlStIBv+giYiyImfW1TZpXohap0
	 KgNMOnp0xlY7SBop0KY6dG4xEUh3OSneEJe9K37hgqUDB0r2W5QJSGubkojdto1RoYDbZ
	 iI7G7jWQEkpdNlJK+XjzDrFGZFW8GDwCmf35n/MuxxxeOMPr0Bm6HAoMJoWHuPYcwmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587239;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9MZi1hD6WqJcKS3km0Z8C+kRXVD/0KRLDA2g4HTFty0=;
	b=TaozguMBakwJDPZ4qnc00+33D367gyLnqCXkpG2NDE0MwTykgjeGgVAITT51Ij7sxnqW
	 NAscNWSLz8Y4mjQetrNCoSpF5diQh93taJwmqamYP6D8Xy6AC6hhgvnvRbh2Dzc/ORmt1
	 NI+X9lGZ/n2yhit0cmyfzb5keosMfcj69tGdZZovte5oCFCXeeRHBumK4Oz9txwQDlLb/
	 j3gjT5+a03GWOcAelUpbsaHr9rDMW/motgcIV327M77FTm/Yy9nbZ1YbPT1B2BJwDlIxA
	 MNrLrpkhWcIZBo0v7W7Ml3tZ52b94wf4fRv0/C4jPS2hvkyTs7Ar+JJM4glXZmwcZug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=V5EY1ZP8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9038606A324;
	Mon,  2 Nov 2026 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=V5EY1ZP8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D451F00A16;
	Mon,  2 Nov 2026 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793587238;
	bh=9MZi1hD6WqJcKS3km0Z8C+kRXVD/0KRLDA2g4HTFty0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V5EY1ZP8wlTtErpAj4wIIH2pjK5+yBnubEbEeMgLYjUfOKwx8kblJ7Z2Z4o3TYYt1
	 9/AoT4bhgHjfeNuDZ4H1MEqk88MkqBy+TuLNOwKAyLd9GbB3LJbgLfJ/gjsRZDqjc9
	 ah4YNs8AOkLHGA5usNB2fmwsr41n1qzW6/p2a00w=
Date: Sun, 1 Nov 2026 18:40:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: joasantonio108@gmail.com, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, linux-mm@kvack.org, Hongbo Li
 <lihongbo22@huawei.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] hugetlbfs: move hugetlbfs_free_inode tracepoint to
 ->destroy_inode()
Message-Id: <20261101184037.5398ecf4c8348462a70b3968@linux-foundation.org>
In-Reply-To: <6FC96012-76AA-483B-BDA4-8E1C1ABB5FFE@linux.dev>
References: <20261101-b4-hugetlbfs-trace-v3-1-051b716f490f@gmail.com>
	<6FC96012-76AA-483B-BDA4-8E1C1ABB5FFE@linux.dev>
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

On Mon, 2 Nov 2026 10:24:38 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> > static void hugetlbfs_destroy_inode(struct inode *inode)
> > {
> > +	/*
> > +	 * Not in ->free_inode(): that runs from an RCU callback, when the
> > +	 * superblock the event reads may already be freed.
> > +	 */
> 
> Since the trace point name has already been changed, the comment here
> doesn't seem to serve much purpose anymore, as there isn't any ambiguity.
> 
> With the comment removed:
> 
> Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.  I've added a note-to-self to track this, but I've left the
patch in-place as your observation doesn't invalidate ongoing testing.

I always do this!  But this doesn't appear to to be widely known :(. 
My fault, really.

My notes-to-self are mastered in
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/pc/devel-series,
so the overly-curious can always look up status in there.

If a patch has a note, I won't progress it until that note has been
cleared away.  This often involves sending annoying private emails to
people, or fixing stuff myself.

