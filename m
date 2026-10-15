Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5255C1AA;
	Thu, 15 Oct 2026 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093010; cv=none; b=OttLVq+E/t8LGPuwKTk7BlcqlgHfsGKsuEE7rDYaWIHyCk9fSHQAdT/lJBQCyA8oeOfqiVS00zB/vzqymqT2wdTMdniv9tWu2N3kCfLk67oxg4Emzoz3qH74SGlkt0h9FmhNZRWgcFlGZcvkZqNwHDsassiWacF15W4NGCxbJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093010; c=relaxed/simple;
	bh=4HRFBnJWPNjtUhb683sgHnb9wkJWnn1agboUS1I4GYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1Xm9n5q7xbTafwLs8u/n595BIw+B5PKt3aB4IEEa1me2z1PxLDca7iKHQfynEXJAbHKvZotYnp2Jh0o41soqMnMEz1e9pr7vG9cE7WgTxYFIKp8ioBjS2q6hckaBFid1a01maDU3Y9Z7r597UMBjko8zm64Dnsrj3IM5Dcvt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2rLcNDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2rLcNDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF561F000C6;
	Thu, 15 Oct 2026 19:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093009;
	bh=kAw+B127AvCnY9+uLaeoAyqX5LALW2I7ekpbR5PnwrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m2rLcNDLCjXt8+wlN9VxjeGk4vbvQT1vrBug6/EmfOKwnwxAgHvti+j5wiLd/2Hgs
	 Tv/sKtVfRgXCLAvV+UtR0vg6OVNIL2k19YfH1WBu83QGAa+eKPA7c3SHiO/6kZWdt1
	 lsYCag0XDGoyJb0IDOOUKeyst0SF/WPpO9tLpuQivgNsz6ZXjKWSXwXJJi0I4uQmE5
	 csuZedT23MKqJZfqiiiaehNiZ+CSibR7WCJSYzdMOz1NZh1JKWacGTrM+qpds78zDg
	 oHFgvPcR+jQ91A/kdiGIChRPSnay4A6/pTplerM0NgpI55DGlCJEEGJJQlfBqCTl3K
	 VviH/FWcc8SKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gary Guo <gary@garyguo.net>
Cc: Sasha Levin <sashal@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 6.18.y 0/6] Backport spin_lock_irq_disable() to 6.18.y
Date: Thu, 15 Oct 2026 15:36:03 -0400
Message-ID: <2026-10-15-1-daily-reply-0020-spin-lock-irq-disable-decline@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series backports the new spin_lock_irq_disable() API, as well as
> the new SpinLockIrq API for Rust to 6.18.y. This means that any upstream
> code using these APIs can be backported cleanly to 6.18.y without

I'm a bit puzzled why we need this backported. It looks like a new feature?

-- 
Thanks,
Sasha
