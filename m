Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C654B4025
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574891; cv=none; b=nk5g5y6UApENT4Y6Ef4RvITuU6kLe5HFqcdPzxI5CuPSpp5qWQEwB/aXGhqNoe6CYIR8xKUmovCLI0XsGRBwZoHHrupn6ZijVHbd2HdIXZ+cE6SONWQkQaRjjHGJzo6SrCHGZ9C4v617z2eQmS9I7mwoY/bnOsKebt3irIrClco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574891; c=relaxed/simple;
	bh=TwEGKAkZ+SY2PZSIucwEGarR2ZDU123vCZwgo2IitcA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DuIkvf8G4YdsX1RasohvZ6KSPwvl/E6njQWE+ZKvMP+0TEcVBpwE8B8Jln3ZtKEvSpAESI/IwsNTOuT3UXOtoxWwq4seMwdBLfv8YbBrLYQBVsKWcCCwSNZqLEPRU0TxWr6UhfT+iJ6QFVU4MH+ab5zV1mlyBFg1BP4mOtr1Fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=okQcnydB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="okQcnydB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A3D1F000FF;
	Wed, 16 Sep 2026 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574888;
	bh=if0HsGrh7neT+/QrAXKVRz8YWD6zLSTQeI5ZzPCaoVg=;
	h=Subject:To:Cc:From:Date;
	b=okQcnydB5GNU35SFT1V4V12rfBZeKHiWDJ2akOytEv6Hx3Kr68AjTkjHFkqEGUtD1
	 Bfw3KrT0HO4KZd86hZCPWIqzjC0b0VN0cAmAgPW29uhbIYLJ9ww09KV12oGinLM2Fs
	 Qlj9fl1CGfYvGxpfgb1YVN1OuipB5wa7Af7ubJuU=
Subject: FAILED: patch "[PATCH] selftests: ublk: install test_common.sh and trace/ scripts" failed to apply to 6.18-stable tree
To: mngyadam@amazon.de,axboe@kernel.dk,tom.leiming@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:51:00 +0100
Message-ID: <2026091600-snowsuit-hermit-eac1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c4fa55f85c47cd5d54d717fb8170746edb10292e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091600-snowsuit-hermit-eac1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4fa55f85c47cd5d54d717fb8170746edb10292e Mon Sep 17 00:00:00 2001
From: Mahmoud Nagy Adam <mngyadam@amazon.de>
Date: Wed, 9 Sep 2026 15:26:03 +0200
Subject: [PATCH] selftests: ublk: install test_common.sh and trace/ scripts

Every ublk test script sources test_common.sh from its own directory:

    . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh

and test_generic_02/12 additionally run bpftrace against the scripts in
trace/. Neither test_common.sh nor trace/ is listed in TEST_FILES, so
"make install" does not copy them into the install directory and every
ublk test fails when run from there:

  ./test_generic_02.sh: line 4: .../kselftest_install/ublk/test_common.sh: No such file or directory
  ./test_generic_02.sh: line 8: _have_program: command not found

The bpftrace tests are affected even when bpftrace is installed: the
missing trace/*.bt makes bpftrace exit immediately, and the tests then
report a skip rather than a failure, which hides the problem.

Add both to TEST_FILES, matching how other selftests ship their sourced
helpers (see kexec/kexec_common_lib.sh and zram/zram_lib.sh).

Fixes: 6aecda00b7d1e1 ("selftests: ublk: add kernel selftests for ublk")
Fixes: 723977cab4c0fd ("selftests: ublk: add generic_01 for verifying sequential IO order")
Cc: stable@vger.kernel.org # v6.15+
Assisted-by: Kiro:claude-opus-5
Signed-off-by: Mahmoud Nagy Adam <mngyadam@amazon.de>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
Link: https://patch.msgid.link/20260909132602.68852-2-mngyadam@amazon.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 5daf36c6c36c..37883e9d50ec 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -73,6 +73,8 @@ TEST_PROGS += test_stress_08.sh
 TEST_PROGS += test_stress_09.sh
 
 TEST_FILES := settings
+TEST_FILES += test_common.sh
+TEST_FILES += trace
 
 TEST_GEN_PROGS_EXTENDED = kublk metadata_size
 STANDALONE_UTILS := metadata_size.c

