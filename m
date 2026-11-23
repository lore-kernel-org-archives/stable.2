Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795394117;
	b=o88guDKMM7b1ipMpF0tqK52Dc7gScclqSw6QobJt/RfuKLm36FfrTeQzfQ1x+tbtkAxB
	 1wIXMglraPB/LsAfY7YxsTxtmWIAJLV+u+rtSY4w1GZQL86A5rrVToF3spbyV4TvgeIjg
	 3ps5oM4Ae6DOrvAncR7sbbqzbGztEkBTouRYA6GIcwLh3kkupIrnloC+5vEHZ6ct+2Xn/
	 PQcxUEKwTQVIApTkiliEtwCqcXTL3RodEMEueawg259/0LIvMpfn1yXA578UHxq9mQuom
	 TLLzVQxTDTOLu6LEaCSGtne6FRbQwoCfgMCbxJUVI9kuT16uYC3ff9EHV8sCy/066eA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394117;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=QzbkGpaThaci0kNYwvtby6j0S9sB43OpsLlf214c9iM=;
	b=RrQXahTovbmWHEeiEDjMkuUSgCdWXBwhSeQes1TSogWBAk+wrCkCGdX3YrgreEd0kDE2
	 4/6RSBp6EDcKcJ3bjp0LRI7s8mVb2Wx4xa299CTxbEPUtTg3DuCquD/+kVexOIjomsR6h
	 Ne6j268JuP+cdcHmVBElvos+up+bX0Q6sfA4is0cF6InGehjE1kpflVLhKAUktJ938d5b
	 v22EkVaSLXBquAq9W290estnjkqeESxM3Bui4xAIoXk2ofML7MaiyEsCq9oO6NojHvcHz
	 Wq+eV99LN4WuWV+CamhK9cxkS3ZtEzsCTOTmQ9N0bfGK5xVye7D6RU0TbccTk/PVn7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H++9HDh6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0E606A32A;
	Mon, 23 Nov 2026 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H++9HDh6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795394116;
	b=wluBWNl22dpi445HXi9XzJIwt16rYHsHo8KyCNeVNFrEcWleALIcphQRdRRRzJsFuOGt
	 dZEuR133FnSmJSNxmVUOmIHz5L5X8EUF3cxppt0GcE8AZ9g65HdoDd2giKl2Ivyp5v7Z4
	 wJXqUfi02dMdXqx9cxAv2JEdjdyCyrI1iPjNx/gNII4/lbQOHfYw9t+Mfjpv7SEkpmHpS
	 9qItSbxfIBY1W+ZivuHR5Xx4IDZX7rvgPpUjfW/Phq5iyLST5yMYax37pPR583wh9N0FI
	 slJpZ4BmJ+qMzO5jNj+pOB5B+lGNiTnoz4ZOOhfW4ANZx6HHuX/k6xNkFS4M3FzSnRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795394116;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=QzbkGpaThaci0kNYwvtby6j0S9sB43OpsLlf214c9iM=;
	b=HMJ9PpgwrX5YS0GeyEpvnTi3AmC+HlsZl+MIRXyl6/qT4TWIxRATNdXrTZiRz7SZndd4
	 vTar1+jM7TdadfDCCb7ZF3lgw7/EkGZI5TskVzhs+L2juqqJKp2/ysfZRusuNpS2wZ5yn
	 uZVtijr7gYKV2IE1LUA9exrp6XiZp3zCmGoH68x/3zxyyzvgGy3UIDu4LCsw3PSlRwPpi
	 6Iiq9CPXKVX/lqsofX0s3AUNO/vovM+vWiK0NjAOJ10FNB8hzy25aqzyrD0R/ZOabWF7B
	 QF+RuHhSuYubH+A/deYxm1zTe4mj7sAhzY1zDE5f+3EufdgnwxX8mVVUR4ll+98l+kg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EED201F000C0;
	Mon, 23 Nov 2026 00:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795394116;
	bh=QzbkGpaThaci0kNYwvtby6j0S9sB43OpsLlf214c9iM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=H++9HDh6C+GsjSbN5srzhPRPWyFYz8k26B77TmWl0NW7mwgljqIj6yW8I+KLJg75W
	 J8LzER8+JLkmVLDN0ReBnN4sI3lYdnyatBcvhM3LGHHunvigRxyOFd2GVpze6YbWWO
	 U2SSvN5icjJ8POB++cfRVHGvQO+d279GW2AFqJTkspRBXvKU78FSVjtVlCW8FoWOA6
	 wI208ghTSSyZi9JWNHkIEDzSpXk3kmQCqfA8BjptZ4JkcG6mhRHqnfZvZquRGIN6Yj
	 M4VTjeV3IESHG8D1tRx4JYeb5dIVzTZmO5Y8jGIj9PX/Yti1W41WGdksSWhhZOdRkq
	 o1C+WOKl8XCxg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4C2EF4C269;
	Mon, 23 Nov 2026 00:35:12 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Subject: [PATCH v2 0/2] sched/wait: Queue non-exclusive waiters at the head
 in do_wait_intr*()
Date: Sun, 22 Nov 2026 19:35:11 -0500
Message-Id: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNyw6CMBBFf8XM2jG0KfhY+R+GRR9TO0bBtAU1h
 H+34Ad47+ok9zFBosiU4LSZINLIifuugNxuwAbdXQnZFQZZyUYUoVGYbCCHL80ZucsRA2mHtqa
 Dr0ythFdQ2s9Int/r8qX9cRrMjWxe5pZE4JT7+FmvR7Hk/r+MAov31kvta3Ns1Nn29+FhWO/ID
 dDO8/wF5aGI0dMAAAA=
X-Change-ID: 20261111-b4-sched-wait-intr-head-c5e8f0b541f4
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795394112; l=1259;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=jCtwij91dfdagLsRWbPGL+dk8RepKRiMgOkxRuxT9C8=;
 b=L9Ai5mlE7Lz8ZDESqwhYZFIsp7DHH5oMWaV98/BeDTOP2wlDq0TqoZk2Nw9vKWXqwoS1sNkXK
 u6+Trf6KMOyASgkjM18QM5zTgqtmbVPKntcB/6XpTXWokmalKd43MpI
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu

Patch 1 is the fix from v1, rebased on top of Linus's commit
cea5f91daa3a ("wait-event: clean up the internal helper arguments").
Patch 2 makes __wait_event_interruptible_locked() take wq_flags like
___wait_event() now does, as Oleg suggested.

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/evexcl.c

gpiolib-cdev and cros_ec_chardev use the same helpers and can be
polled too, so this fixes them as well.

---
Changes in v2:
- Rebased on Linus's master, on top of cea5f91daa3a.
- New patch 2: pass wq_flags instead of a 0/1 "exclusive" argument (Oleg).
- Link to v1: https://patch.msgid.link/20261111-b4-sched-wait-intr-head-v1-1-17cf2af5b964@columbia.edu
- Discussion: https://lore.kernel.org/all/awMhxEuMHULvk8SA@redhat.com/

---
Mani Tofigh (2):
      sched/wait: Queue non-exclusive waiters at the head in do_wait_intr*()
      sched/wait: Pass wq_flags to __wait_event_interruptible_locked()

 include/linux/wait.h | 11 ++++++-----
 kernel/sched/wait.c  | 16 ++++++++++++----
 2 files changed, 18 insertions(+), 9 deletions(-)
---
base-commit: 6e4122f0242a3262512ee3e6f2e7e6de0bd5792b
change-id: 20261111-b4-sched-wait-intr-head-c5e8f0b541f4

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


