Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAFF5FDA7;
	Sun, 11 Oct 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791681018; cv=none; b=LjN18NTn/AhM4mncpV6B8AFzc2aWZrqini/b/CVXc4EOtlGv5KuhiD+6yG92CzRvQiTdilGzq7gdQDki7ULeNfzxLFvBy07uT5fu5/JC+vJxx6miB2FE7WVT9AjO9m/EENCEZnViezImedvuUEV4VLArLti44ua1C5MfuaUPa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791681018; c=relaxed/simple;
	bh=ag5QCl9bG2BLx6Q+izRedzJ6zhKoRZLaRrYxN7QNwt0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iM1TTMX2PPeWeySNjvAqQixU95aOh3Hy5YWrOwKC0gP4mY6xBoiuQuy52hXo5Yv/Io/ZvZkRJF5ZBTQH+PNmlWqNykFSWR3XAWb2xrBDK2MS6DgV/HmxHukFIPifVS7nROb9zXr4Y4Y615nw+LyMN99GeIdH0qnvePfOy6rYplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PK9+v9li; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PK9+v9li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5241F000FF;
	Sun, 11 Oct 2026 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791681017;
	bh=xltzwB3NQYDsmBs7/fawoEbWxdY8ZqumAutpEK8h9+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PK9+v9li3U5XqaVPu8ElDX3Hu6oj8rZHWjl8VDl7rehL/duOva6+mndCiPVHQ3elA
	 VdpQOJrXeEbGPDotExzttZ4w4FUVV3ZeFuCLyEcRgvO5mjICOFACBTCa9EepVvmUpb
	 P5zYo7Zjg9WkwRI5TNrLv9pwjQ9tPDrjjDVANtrU=
Date: Sat, 10 Oct 2026 18:10:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, I Hsin Cheng
 <richard120310@gmail.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chris
 Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Barry Song
 <baohua@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] lib/plist: fix plist_requeue() shortcut inserting the
 node at the list head
Message-Id: <20261010181016.44f5e2883b6820bb32c04204@linux-foundation.org>
In-Reply-To: <CADGQE7G-PAiJ2W8uhFO_-e9GGtEPey=drfSqLfWdxXDys3mJNg@mail.gmail.com>
References: <20261009051857.758182-1-nickolai@csail.mit.edu>
	<20261010162558.62abcd2ec967b009d0cb3bbb@linux-foundation.org>
	<CADGQE7G-PAiJ2W8uhFO_-e9GGtEPey=drfSqLfWdxXDys3mJNg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 10 Oct 2026 19:33:46 -0400 Nickolai Zeldovich <nickolai@csail.mit.edu> wrote:

> On Sat, Oct 10, 2026 at 7:26 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > I recently queued a fix for this problem from Alex:
> >         https://lore.kernel.org/20260903222456.1881786-1-handyhandyman.adam@gmail.com
> >
> > The two patches are rather different.  Please review Alex's change and
> > and let us know of any alterations/improvements which you see.
> 
> This patch is equivalent; I don't see any reason to prefer my fix

Thanks.  Can I add your Reviewed-by:?

> (except for the test case that might be helpful in catching
> regressions).

I like test cases and I take patches ;)
