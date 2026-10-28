Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164273;
	b=MS3bQdqcmInpES7IrWFRSnoGonyHTl6Ge1YHZWYIDHvdr+O93Texl+5kJsaOFKNT9iAI
	 hwYXLl8HvQWEXmnU0PXDZity5muZ0UTkWcGhokwx8QJkS+8phpdHUS2kZHVoOfvn6eChT
	 emA+vU37W/X0+MAZJtuvELN9+TLiSIOQz+8nf4YjMQNq798BBO1iDcDBIbtzyBXHJm664
	 f/goq0ISt/2Ovxa63DOhcYN94NSL40LzOh1S6UMD8AAGkWsUHmA1XMou+vV+BPNus9NYV
	 PwuMw0aJfvjQ1CKKF2+k0Lb7yrXMc9/mUxOfBDi1ecsUe+p8ea7hel0s9D8n8kwzdog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3pS9CAQrAJLVnQcJS9FSWP6kxBvqhToAiMsGHORpn34=;
	b=uLjq/EM/NfhXjsjF8QZv6CKqNUNxg2kkEUnDvXXD89hQuGt672xTdMLg5ldTyPY2Bsig
	 GpFaoQfEjkAIpnrWYEVjde5tzXTuNuMiaJhe8x5qJ4ewKeZ3JtH4FJKrKUNuEo8E8eRwS
	 NcL6q/Z3Wi/aWPXZnvVUJVB7UwLGOISB9AMA5MpfGmRcUmqii6DZ82B+wwT0ljeINfWKm
	 bWeJCqJn0lf/AhjXzZTOyhSAZxRR5dnoJ0uRDW+jG1h1XsnIPOTnSEt0m5Yrc2+3zeojo
	 cxLdasNErze9DLiwYsz7yGUNhJdWB7dSZ7lW1QbyysE4FZo2+8v8MWJymGUshiYa5eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM7+JxHl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87700606A31A;
	Wed, 28 Oct 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM7+JxHl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0B71F01828;
	Wed, 28 Oct 2026 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793164273;
	bh=3pS9CAQrAJLVnQcJS9FSWP6kxBvqhToAiMsGHORpn34=;
	h=From:To:Cc:Subject:Date;
	b=PM7+JxHlWTwo2Ik9zg/BlT5FVYX/ie60vqdCZjcrhWFWWzCyH6ykp93wUbG+o75oY
	 Gw4ehDJsaYvSWssTO51ia3ZeKLh5GLLECO+RywpdBtah8+lTKRGi1sPTl831Oh5lYI
	 s9xLvllWJrbMj41XwUYMZM8HA01P/b4u8j402n6/HSWn+IxVMJz6pzrxV62U0gGEd2
	 v2w7WQEu+DIORlwX/JNamAzGpntaT1sfC2kt7UlYqHnt03DJwms9HUGsa9TQoMABxM
	 SxfsPp3KrIXD86L5mFA2JA0QIFA4RQeRIZDHfP8wFqy5D8ivgigHHXgmzDOwPW+2RN
	 3/zasmou6Hcdg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.1.y 0/2] mm/damon/sysfs: fix pid leaks from wrong error handlings
Date: Tue, 27 Oct 2026 22:11:01 -0700
Message-ID: <20261028051104.154232-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface can leak pids due to wrong error handlings.  The
issue in the mainline has been fixed with code refactoring.  The
refactoring is done with commits including 7114bc5e01cf ("mm/damon/core:
add cleanup_target() ops callback").   Porting all the refactoring
changes to old stable kernels will be challenging.  Hence submitting
this non-mainline hotfix series.

SJ Park (2):
  mm/damon/sysfs: put target pids for damon_start() failure
  mm/damon/sysfs: put target pids for apply_inputs() failure

 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 969f73b24b91eb0b5042d4d7b26b4bece1f27d18
-- 
2.47.3
