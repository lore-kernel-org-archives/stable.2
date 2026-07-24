Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F91E372EDE;
	Fri, 24 Jul 2026 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881211; cv=none; b=USbjH62N2RFfPRAcO/qNlMohoQUDPHIzIQcRqlR/ng2bmVSSFSfs92y91JDw1r3GrkYnwFxxKe4stN3fBmTP7p6qSj/wD0iJ/qYvC1FT1DoIZLoC9xkbdffxPqYxU80SEHF8XqhbWydVZULPVMA/RJqZN/TTH2gMJYtKTgoxGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881211; c=relaxed/simple;
	bh=IrOYqjRaFd12E3GTzqwo0vH1b5sBPaGRzNKEa04oA08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0zqQqA9k+gd4G+lbddOXKQKspZKBs9XutNEvRKZZjLSJtPgxHduEruyMqpxR+DqHCuleaU9+7XppHnmaqp31//nGuuV/1g6C8Bac9uA4f1xMiUW5nOZQaS5Iw+e0mnx/JPMwgQI8uTU7QQICwiDODxpfdOQ4nN47B5DJam3uV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOrNjMb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOrNjMb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168741F000E9;
	Fri, 24 Jul 2026 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784881206;
	bh=NTBW17vaSWk++3PC8WWf91qtpv6YX9UUvQqo18ujOao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZOrNjMb8d9dtmomhc1VEE+kcjlshlpGHRi4BZMl7DEU06tC118eLcwIyhyPIWkoiY
	 FfXZrh4aBAjHIwCItnq08fC8hQkS/QaOrNZyhTva+f9X5mofqglbjonEv9CWX97oiM
	 hrnTEHNoZzIMBDAJ1ofZM7cWGj7nG5OL6DuBfI3r/JgWWqHJAP9lu00OzVd7FF1sLQ
	 8HfDu/iadipgSaX87IddQTPO7v/6OvCG3nXIA9n949nAUOyuvPDf1BUGvWFK9sGz+e
	 mWmBZqxW730Gv8IlX2HxiIJUCTE5flLrZn4F1rm5Rl2fEugv/pVVl8Ux7CNuhWvHDK
	 nWFjPzdQR4IWg==
Date: Fri, 24 Jul 2026 10:20:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Keno Fischer <keno@juliahub.com>, 
	Ingo Molnar <mingo@redhat.com>, 
	"Peter Zijlstra <peterz@infradead.org>, Darren Hart" <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Yang Tao <yang.tao172@zte.com.cn>, 
	Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
Message-ID: <20260724-rausspringen-beeindrucken-bezeichnen-8255bc3fe282@brauner>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13>
 <20260723-obgleich-kippt-gegeben-c84192e6d6bb@brauner>
 <lhua4rh7s9l.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lhua4rh7s9l.fsf@oldenburg.str.redhat.com>

On Thu, Jul 23, 2026 at 03:24:54PM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> > Fwiw, I added unique inode numbers for the lifetime of the system to
> > pidfds some time ago. The inode number is allocated for every struct pid
> > and available via pid->ino. A pidfd can be stat()ed to retrieve it. Just
> > mentioning it in case this may be useful.
> 
> Is there an efficient way to get this without allocating a file
> descriptor, and without /proc being mounted?

No. You need to allocate a pidfd to get access to them. I have never
considered upgrading them to a generic propery. They are tied to pidfds
by design and to inodes. And I think introducing that number as an
orthogonal concept would risk implicily upgrading it to the system call
layer. Which seems less than ideal... Fwiw, pidfds also support file
handles where the inode number is encoded into the handle.
