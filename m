Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECB2DCBF8;
	Thu, 17 Sep 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636667; cv=none; b=F6wdA23aMBhP1teBTtYCZnd7JvMYnUvaandzqykZsN/JR3h0WGklbgwRGStVS+E5Kqtmd7cjvn2RWy02Grtz8WdmBbIx6yIWciZ0R2aV/o+eY1j1CkQkBEFnqPs9C9S5vHK3Uac0+NIr7/zxvluzrJ3wiNfJmIbvPQHms6Mzlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636667; c=relaxed/simple;
	bh=mmzPQj/v9mvBIwNu+viZvNM5NC3I8C8gJ4ZNeVSEI5M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uclz8a1wANnbp5/Xx1g7Af9xSaxWODzUB+cDavY9cCVypKjwr+8u3zpcpy4XgQA4/4/nPiXdDQbtzWRxUSn/Pw3HlutnLrK19EEarvYNR2JnZ1sN7mZ+pPw/MT3DYQgWw1I9hs+Aw/ywv0lKZnhxxJpgd1vPTRRw/FKvlvMMYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq830zGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq830zGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71891F000FF;
	Thu, 17 Sep 2026 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636665;
	bh=XRXB4eKXDh9tzHWSRw/MZmLlMVEZcS/C30rGMlm+zko=;
	h=From:Subject:Date:To:Cc;
	b=cq830zGnvva+8bgfDs4bFsp29vmF3yELM6zTGVErjy4IfDyv3qjh4BmGG4ojI9vM4
	 /wU8vg/EJT4NMC0z4SlEnPTTkt8fPGCbCE5RycNqeuxvokp+N3OpU9GPQkgReTYFTW
	 k4QKRb50uMeKC0ESGuG2bpLf+/QVBf2VJBvYIKppGxlkt0Jd56kAQdq097xInQxkpM
	 QoNMj67aKh7T51ysO+g+b2qs+hCJlHb09FbWINJpRXa+61SwiQ580a6sbj+BfIC376
	 VkxDe6K08R4CQL3TQQVstF9QHLXCPZjS7gr0C0LUifzfD/3Fu5jCHH62XynByyDs/R
	 /ROyID7sf5T+A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/7] coredump & signals: an impossible affair
Date: Thu, 17 Sep 2026 11:17:27 +0200
Message-Id: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ6CMBBFr0K6tk1BkOLKexgWpUyhoi2ZAmoId
 7fFuHX5Z95/+SvxgAY8OScrQViMN86GkB0SonppO6CmDZlkPDvxKi3o0+FAlUNo58dItXmBp9D
 qSijBNZSChOaIsD9C8Vp/s5+bG6gpqiLRSA+0QWlVH09Ryn5StndZRCLaGz85fO8LlzQq/49ZU
 sqpPha5knlaCq4uA6CFO3PYkXrbtg/kp+FZ9AAAAA==
X-Change-ID: 20260915-work-coredump-fixes-edf98c80fe78
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mmzPQj/v9mvBIwNu+viZvNM5NC3I8C8gJ4ZNeVSEI5M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3mBsaaDA92pHz8xsg4rvM3+nbZLacGLjO5PvpxvS9
 234nrM9t6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiDYYM/1Qstq7Yu8muYO9r
 Id+y85Mae3KWS7VN/sirqePYwF8yQw2o4rNT2LJ3GscPXOEv6ZJepSwsbP7m/CXPvrao6z3aQZP
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

I asked Chris (Mason) to look at some of the coredump code with kres and
he found a couple of things. Some of them I had already found and fixed
but there's some good stuff in here.

Other parts should be more straightforward (hopefully...).

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Add fixes for retarget_shared_signal().
- Expand fixes for signal_pending().
- Link to v1: https://patch.msgid.link/20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org

---
Christian Brauner (7):
      fork: refuse new threads while a coredump or an exec is in progress
      coredump: hold RCU while releasing parked threads
      signal: only SIGKILL and the freezers interrupt a coredumping task
      coredump: parse a snapshot of core_pattern
      io-wq: order the exit bit against worker creation task work
      signal: don't retarget shared signals in a dying thread group
      selftests/coredump: test shared signal retargeting during a dump

 fs/coredump.c                                      |  72 ++++---
 include/linux/sched/signal.h                       |  19 +-
 io_uring/io-wq.c                                   |   2 +
 kernel/fork.c                                      |   6 +-
 kernel/signal.c                                    |  12 ++
 tools/testing/selftests/coredump/.gitignore        |   1 +
 tools/testing/selftests/coredump/Makefile          |   4 +-
 .../selftests/coredump/coredump_signal_test.c      | 238 +++++++++++++++++++++
 8 files changed, 318 insertions(+), 36 deletions(-)
---
base-commit: b813a7ec026ca59a444ba0a36c2e17ac823eeed0
change-id: 20260915-work-coredump-fixes-edf98c80fe78

