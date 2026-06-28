Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D65262D0B;
	Sun, 28 Jun 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782673881; cv=none; b=LF5Laz9qeLGEsbEWLmHwsgEhIX9pO33PZKPlFEbN4F5Q0NIpHSV6pRSYF7f8VZmaU76dJdBqkre7B7v5u0yrzOMWsjEjBpcjp8CypKbRIlkbsS768pCqzwjdLcHSyx4Pq9txMkrXoFWwdgMWZEQSVME1O8qaL2CqdaXC/KTxILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782673881; c=relaxed/simple;
	bh=aNeS8aOnU5jLudYB057iL/Skeb6lRLyDbdO2ySG0Uqo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=btNoF8imiAR1yMv8YOdhf1k7LOT6A7xhZ7ggJ3atakwpCi6/JIEktn0Udv47R1gsyWF5g2FcRfwAjTz2gEFOK+2d1S9lh9zAYdW3ygZiJHYmUA0lsL8+VBH2Ah7Rkg4ygUAxz718UoJl9mXCQ8UHc7KeZB3UldvLNT9CqiwRYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q+zpov1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q+zpov1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC3A1F000E9;
	Sun, 28 Jun 2026 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782673880;
	bh=GWGmQCufZdkbfQprXzpkrcsY0swjVfdJaEhJdIdXLOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q+zpov1bE/VqF1rTA+xN6ZIbLvJhDQITYOmKV8AVkRTMlV7xNdLAFvJ6b+H6g/GCU
	 l2bh/bK6T2aCthBeKulca4fgN3KkqYcVot9qa1nH3X40+uRD5llHW3MzkyABRUfhLD
	 SRhulxvnPGAfrf0y3JpjUKHp11NIhdeK06GucsxI=
Date: Sun, 28 Jun 2026 12:11:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>,
 Aleksandr Nogikh <nogikh@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Adrian Huang <adrianhuang0701@gmail.com>, Kexin Sun
 <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: avoid shared siginfo namespace rewrites
Message-Id: <20260628121119.b2803aca486dc697bd142d00@linux-foundation.org>
In-Reply-To: <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
References: <20260622164029.11474-1-include@grrlz.net>
	<86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 20:25:08 +0000 Bradley Morgan <include@grrlz.net> wrote:

> send_signal_locked() rewrites sender ids for the target namespace.
> Group sends reuse the same siginfo, so one recipient can affect the
> next.
> 
> Copy the siginfo before changing it.

Thanks, I'll queue this for 7.3-rc1.  I don't see a need to fast-track
it into mainline, as 7a0cf094944e is from 2019.

Can someone please send along a paragraph which describes the
userspace-visible effects of the bug?  I think this is important when
proposing a backportable fix.  Important for all fixes, really.

I understand that I'm to take no action with "[PATCH v2 2/2] signal:
make send_signal_locked() take const siginfo".


