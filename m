Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693554;
	b=szTMBNYXEoTjLW0LU0jV90ci7z0wHG8TTPYdqI0Eyt+FGrlHze4GXUfYeJkmd2ukjOvH
	 Nyse5fNYHfyMPh9CfgJo5E6Q+te85LVrxFnRuqjVHFd8wMFteACJIJKGgmxzORUkz6S41
	 E/VxiBxF4gGwTCk0LS44oogAZgb8YvY8UiEbTdP5Znizzhtc2zWoXk5VFaO9ikG3XuQbU
	 CugjLZGhThcnLU5iPLOsS14ocipsHUJn5XkJA1rZaxoAK1U4Z6PGyxhwT2j4pwzmbzHmn
	 g081AJA2WqQMA6haFZxq4pA/si+gixheqHHKx6XTx43vuhWsKi8p//90PZPYLVWGn9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693554;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=b9g9ERtPsqpdKcGPaNpKk9eILy9YT2kx2AVKQ0CLRhU=;
	b=uRCSOg3+1LU4+aOjBPM3dqTQqCtKlbLQi9JJI1qk9k8zDjUVIg7WbRHObdiAD4bucsLH
	 NagyMHNvMzluVgYozV3uimWOXJA5sb5mXqGc7oN4K+PoOj6KUneHk/+CCeAgT9a5FjB9o
	 BI5UHDe+rydayIVmbU9QTdVHv4gd8DhtDCQ0kqgNYfY/pn/T0GjKpzrZxeHY3cv2hZkjE
	 oAJhilmXDIdqZJ41/T8f9Mnc1CWezs80rzDs7rHrZq85D0gYSYGQq4kFLRuVErqDgONUY
	 kbpw3wj+2rtZ0Y7ex51d4etGduX3TAQ56nYAOuZLJHUwxPRSjWI5nVFnXcYa5b7Hcqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6xkPRB6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF1606A31C;
	Thu, 26 Nov 2026 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6xkPRB6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EED91F000C6;
	Thu, 26 Nov 2026 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693554;
	bh=b9g9ERtPsqpdKcGPaNpKk9eILy9YT2kx2AVKQ0CLRhU=;
	h=From:Subject:Date:To:Cc;
	b=a6xkPRB6cQrCH5e6BaEUzx/+0t8DOB8mDnrLe/BSLzBbpca0djP+gjPz0pxKgWFBI
	 aOsxs5Qjv7RZnnT9QWVIt6BBzMRiNPRfKuXoxiSO/vQcoDSQQi4ngnmhpg4tpLFbPS
	 b6Gv/v0E2HvCr2j/V7jystut6JFT07iSOXCE0EkaIwJCZLDdXPMYGv3omkuIXE7EaS
	 kMR6ZlP1CxbD786wqmI/78JV9EeNSl1N7dhdaqKAnQYHq4QwRJS2lqKgKBUMyuLrk2
	 jDKYCfomlcNbYoVzeHZipSAk6ugWgrsWg5nKEL+toiAgwqVcYBQZddLaV0QPhzujTn
	 zLR/j0qtRIV5A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] exec: two more sleepers in the way of exec
Date: Thu, 26 Nov 2026 12:45:36 +0100
Message-Id: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NWwqDMBQFtyL3uzeo1AfdSiklxmNNFSNJtIK49
 yYtlH7O4TCzk4PVcHRJdrJYtdNmCpCdElK9nB5g3QamPM3LLMsLfhk7MDYoXuZWetxHowYe0Xm
 zwjouq6qu6gJtepYULLNFp7dP4Xr7sluaJ5SP2vhopAM3Vk6qj1MMiBgQfwHxC4h4p+N4A/zME
 ai6AAAA
X-Change-ID: 20261125-work-exec-update_lock-leftovers-6778785ed04a
To: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jann Horn <jannh@google.com>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=brauner@kernel.org;
 h=from:subject:message-id; bh=njczhrZp/bP2L0rmvaDHQkMbC7BtYSOzATdbUKj/00M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzSL/a8PlCUfA/x6kfGZ4LvnlxcJ+ddiTjjzO8K082R
 N5deIYzu6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAinxYwMrzo3HPO8I7GkuPL
 jp2V1s/uuOp8Tf8Um+GCuIoviio3q4UYGW7Mllp6Z2NuoqlglVPqkj0rDj9do2QWfieliZfn30r
 WbZwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This fixes two more places where a task sleeps on something userspace
controls with a lock held that exec needs:

* PERF_EVENT_IOC_SET_FILTER looks up the files of address filters with
  the mutex of the perf context held and perf_event_exec() takes that
  mutex with exec_update_lock held. With a file like /proc/<pid>/exe the
  lookup takes exec_update_lock itself and deadlocks with exec.

* Without an MMU a read of /proc/<pid>/stat waits for the mmap lock with
  exec_update_lock held.

I don't have a machine with intel_pt at hand. The perf patch was tested
with a hack that gives the task clock address filters.

What's left in that ioctl is that it takes the mmap lock of the task
with the mutex held to find the mappings of the files.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      perf: look up address filter files without ctx->mutex held
      proc: call task_vsize() without exec_update_lock held

 fs/proc/array.c      | 13 +++++++++++--
 kernel/events/core.c | 36 ++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 12 deletions(-)
---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261125-work-exec-update_lock-leftovers-6778785ed04a

