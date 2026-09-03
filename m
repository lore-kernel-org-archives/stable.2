Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C933537D0;
	Thu,  3 Sep 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422460; cv=none; b=TPBF3Jt5NOCWOWqvMZIPqcyJ1S+c/dwg7j/qpwttujz9H1AIk8bGQ1oVPq+GHl+yh004qLKrVlJgivSWJYDoP5A81xOvfyntXBFMmdQcqjXfjYpZJ3KpobY6Y6jIpMNWSSLwel61XxV+2/f1VqwEvpLjdgeEZ4+kzxloaWryySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422460; c=relaxed/simple;
	bh=3B0yQxggvxZZ5uFWo63cufzWDT086haSawUHHnMNr5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxcEiAFjhHO7EVfjiY6aAMdPqnHB1FRpY+jsD8xD5VzNTcHOPfgevs84ZlCADZ8IHTR9xVZ1XPEeUhM1UBJ6bHqePbZ0mpFtSw3I57FnieDAxXU9qhPo4Tgw8qLFUUYV9lSph4BXcQsdPMuGk8Hc++MYCjRhQZ6RWhf+GR2w+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpyY2vGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpyY2vGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF231F000E9;
	Thu,  3 Sep 2026 08:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422458;
	bh=M2tKzAHkjVFj+Hp+uJ12JWKe9IeyurdBa3HZH7DccxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KpyY2vGohdTEJhVq0Pcd6fflmCfDGXd+0P4Ph5U+pQHnmiPJOS/98N22ACikgmUm9
	 lLiqfJpv1mBac2ThEc6n4soCluTWjzGBrKTYu8zswnY+R77RjeE6vfAkkMxrQfZwxi
	 EpM/8bf2ykCuvgKJwrKmDEtrWhBq+jKxqMqGhxPXtlSxfXr+m5ol0x3aRi9r2b8N6n
	 RH6Y7r35hy9d/3nR0GNJqfE8p3nIZKaAgcgAK6GfaSdgfTMHRzbOxgWYWFX+MDp2Ft
	 gN2PWe7DGVmVLWPcIACfvRZ5Y9ijeoJKHUKRcGNmb4tFoug9Safc8nGGE+2Eu4dDt2
	 ejvbzcigEK3uA==
Date: Thu, 3 Sep 2026 09:00:52 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: syzbot <syzbot+f12658786a4153df5113@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, kunwu.chan@gmail.com, 
	kunwu.chan@linux.dev, liam@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lixinhai.lxh@gmail.com, pfalcato@suse.de, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, vbabka@kernel.org
Subject: Re: [syzbot] [mm?] WARNING in vma_set_pgoff
Message-ID: <apkpGnijB9Wwj8BO@gremlin>
References: <20260902185451.5ba1a829a15bb2799d121bd1@linux-foundation.org>
 <6a992326.e7659fcc.146146.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a992326.e7659fcc.146146.0005.GAE@google.com>

On Thu, Sep 03, 2026 at 12:35:02AM -0700, syzbot wrote:
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
> Tested-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com

I suppose we can sling this on the patch Andrew? :)

I did mark the 2nd one dup I'm not sure why we're seeing another duplicate.

>
> Tested on:
>
> commit:         940de590 Merge tag 'hardening-v7.3-rc2' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=147d1f79580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
> dashboard link: https://syzkaller.appspot.com/bug?extid=f12658786a4153df5113
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> userspace arch: i386
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b190f9580000
>
> Note: testing is done by a robot and is best-effort only.

--
Cheers, Lorenzo
