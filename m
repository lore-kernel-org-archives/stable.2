Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78446983B;
	Thu, 30 Jul 2026 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438223; cv=none; b=eyREzJVLtOGFSt7dUrGHn5GkWk8KBeqiaTvDgqMfk/3bsl785NHMut5KdeGOj5OjF85+tqWgVkz5F08jqt2R2eVSG1Z7Y9oNbCQzi9ycC3UNa2Mn8RRhV6tl3ru0IjYcVAe8KR3vCKAfE4Udynq02leeTq3oOeD4CJrBhruePys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438223; c=relaxed/simple;
	bh=UuXufE5a5AF00jV9V57D39nWiz6i8jzSr3rAMw7EwH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dj7QskJuYcd71oeHIGqtBZCkxMypv414tKp4+X6QX4jWAjWPFI2fGfgpH0UR8ijbmUN41SrGksY3Xq764pIkGfmolzSPgKoWIQCUhE/kPqIw2JT18Vgq3NBo48Q6nDb6hw07t7B0T7xfUNeRbJuGAVALwRE8J0JDGbR++habCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=l6sU10F4; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="l6sU10F4"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9F047C0000E1;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9F047C0000E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1785438213;
	bh=UuXufE5a5AF00jV9V57D39nWiz6i8jzSr3rAMw7EwH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6sU10F4AwOqJ/zl+xFcHz88e4AfcA9BVv1CMxgPZGhbDjIq5N2PCL6n8DtJaIyZ2
	 1cDy+Pu0n7JDb5lGmuEnEIBiyhRk/PLrq1bGiFy7FpP0jOGiB1ox+aCascyRqRXDJL
	 39oCT9KcaZPyYNKodDqJ90rYKejjHA9LRswrsLNI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 6D76AAE0;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Shuvam Pandey <shuvampandey1@gmail.com>,
	David Gow <david@davidgow.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Cursor <cursoragent@cursor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.18 2/2] kunit: tool: skip stty when stdin is not a tty
Date: Thu, 30 Jul 2026 12:03:29 -0700
Message-Id: <20260730190329.3388222-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
References: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuvam Pandey <shuvampandey1@gmail.com>

commit e42c349f4cdfa43cb39a68c8f764f8cafc23a9a9 upstream

run_kernel() cleanup and signal_handler() invoke stty unconditionally.
When stdin is not a tty (for example in CI or unit tests), this writes
noise to stderr.

Call stty only when stdin is a tty.

Add regression tests for these paths:
- run_kernel() with non-tty stdin
- signal_handler() with non-tty stdin
- signal_handler() with tty stdin

Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
Reviewed-by: David Gow <david@davidgow.net>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
[florian: add missing 'import sys' required by sys.stdin.isatty(); the
module was already present in the mainline tree before this commit but
was absent from the 6.12 base of kunit_kernel.py]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I6c5292f5db0f5ce95399ee3dc87c00116709391e
---
 tools/testing/kunit/kunit_kernel.py    | 10 ++++--
 tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 4f0bec8fb4e1..2869fcb199ff 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -346,6 +346,12 @@ class LinuxSourceTree:
 			return False
 		return self.validate_config(build_dir)
 
+	def _restore_terminal_if_tty(self) -> None:
+		# stty requires a controlling terminal; skip headless runs.
+		if sys.stdin is None or not sys.stdin.isatty():
+			return
+		subprocess.call(['stty', 'sane'])
+
 	def run_kernel(self, args: Optional[List[str]]=None, build_dir: str='', filter_glob: str='', filter: str='', filter_action: Optional[str]=None, timeout: Optional[int]=None) -> Iterator[str]:
 		# Copy to avoid mutating the caller-supplied list. exec_tests() reuses
 		# the same args across repeated run_kernel() calls (e.g. --run_isolated),
@@ -393,11 +399,11 @@ class LinuxSourceTree:
 			output.close()
 
 			waiter.join()
-			subprocess.call(['stty', 'sane'])
+			self._restore_terminal_if_tty()
 
 	def signal_handler(self, unused_sig: int, unused_frame: Optional[FrameType]) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
 		if self._process:
 				self._process.terminate()
 				self._process.wait()
-		subprocess.call(['stty', 'sane'])
+		self._restore_terminal_if_tty()
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index ed45bac1548d..0eb61de9abd4 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -515,6 +515,48 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				self.assertIn('kunit.filter_glob=suite.test1', start_calls[0])
 				self.assertIn('kunit.filter_glob=suite.test2', start_calls[1])
 
+	def test_run_kernel_skips_terminal_reset_without_tty(self):
+		def fake_start(unused_args, unused_build_dir):
+			return subprocess.Popen(['printf', 'KTAP version 1\n'],
+						text=True, stdout=subprocess.PIPE)
+
+		non_tty_stdin = mock.Mock()
+		non_tty_stdin.isatty.return_value = False
+
+		with tempfile.TemporaryDirectory('') as build_dir:
+			tree = kunit_kernel.LinuxSourceTree(build_dir, kunitconfig_paths=[os.devnull])
+			with mock.patch.object(tree._ops, 'start', side_effect=fake_start), \
+			     mock.patch.object(kunit_kernel.sys, 'stdin', non_tty_stdin), \
+			     mock.patch.object(kunit_kernel.subprocess, 'call') as mock_call:
+				for _ in tree.run_kernel(build_dir=build_dir):
+					pass
+
+				mock_call.assert_not_called()
+
+	def test_signal_handler_skips_terminal_reset_without_tty(self):
+		non_tty_stdin = mock.Mock()
+		non_tty_stdin.isatty.return_value = False
+		tree = kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[os.devnull])
+
+		with mock.patch.object(kunit_kernel.sys, 'stdin', non_tty_stdin), \
+		     mock.patch.object(kunit_kernel.subprocess, 'call') as mock_call, \
+		     mock.patch.object(kunit_kernel.logging, 'error') as mock_error:
+			tree.signal_handler(signal.SIGINT, None)
+			mock_error.assert_called_once()
+			mock_call.assert_not_called()
+
+	def test_signal_handler_resets_terminal_with_tty(self):
+		tty_stdin = mock.Mock()
+		tty_stdin.isatty.return_value = True
+		tree = kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[os.devnull])
+
+		with mock.patch.object(kunit_kernel.sys, 'stdin', tty_stdin), \
+		     mock.patch.object(kunit_kernel.subprocess, 'call') as mock_call, \
+		     mock.patch.object(kunit_kernel.logging, 'error') as mock_error:
+			tree.signal_handler(signal.SIGINT, None)
+			mock_error.assert_called_once()
+			mock_call.assert_called_once_with(['stty', 'sane'])
+
 	def test_build_reconfig_no_config(self):
 		with tempfile.TemporaryDirectory('') as build_dir:
 			with open(kunit_kernel.get_kunitconfig_path(build_dir), 'w') as f:
-- 
2.34.1

