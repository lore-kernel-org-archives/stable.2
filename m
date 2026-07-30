Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43F469837;
	Thu, 30 Jul 2026 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438223; cv=none; b=Obr7l91l1sio8rKapQfGrzf4dwer0VjiY11AinXsDGB9aGN44izNxWTghGI2LqkIcXTEJJImNHAR9i3pNtQvXwYMippFM3mqNRMaNQoMjIzJkt3BpFRK8QgzqNf4p+yYcMRFLd0jKPxpX4TVOiawkGkdug0ituexfT5T/xuX3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438223; c=relaxed/simple;
	bh=bEojjssgy+3BVmNhMsFy/IPLoFjK4P2FmNivYkd0/vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ur4H1BlX4vuor5dzaqSmGPbevFcFx9LqzGqudLuxM2DVnVYLz9nNAuadF9bnu2oO/GfmiRKa/MmgyxlPfYhbp3bjJz1wXtebwk80qFqIgOabepQorZHyPALr9nzA6DdqsDXDIdQP817SQTBVRIxV1VGHBN5kKfYIh1+oj5371BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EHy+TmYm; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EHy+TmYm"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A6F0DC0005CB;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A6F0DC0005CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1785438213;
	bh=bEojjssgy+3BVmNhMsFy/IPLoFjK4P2FmNivYkd0/vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHy+TmYmSosSUrvVzqRYNpqu7/nfKORF0xH9EjA0uhDbMXlIYp9hWakGokxvR9gdY
	 mkCEH7154OFsRD0zRr151ISuR27VxXSZtWs+JAyqjouwto4eeZcPGK6UBjiA8NfHEt
	 NQZgolfED513EOQk/MvwATI4lSR1Mpi2FvvMym3Q=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 34531ADE;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: David Gow <david@davidgow.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
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
Subject: [PATCH stable 6.18 1/2] kunit: tool: Terminate kernel under test on SIGINT
Date: Thu, 30 Jul 2026 12:03:28 -0700
Message-Id: <20260730190329.3388222-2-florian.fainelli@broadcom.com>
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

From: David Gow <david@davidgow.net>

commit 8f260b02eeeffbf2263c2b82b6e3e32fd73cde2b upstream

kunit.py will attempt to catch SIGINT / ^C in order to ensure the TTY isn't
messed up, but never actually attempts to terminate the running kernel (be
it UML or QEMU). This can lead to a bit of frustration if the kernel has
crashed or hung.

Terminate the kernel process in the signal handler, if it's running. This
requires plumbing through the process handle in a few more places (and
having some checks to see if the kernel is still running in places where it
may have already been killed).

Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Closes: https://lore.kernel.org/all/aaFmiAmg9S18EANA@smile.fi.intel.com/
Signed-off-by: David Gow <david@davidgow.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
[florian: resolved conflict in signal_handler(): upstream references
_restore_terminal_if_tty() which is introduced by the following commit;
retained subprocess.call(['stty', 'sane']) until that helper is available]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I4fc947a1e9268b8611151f7845edb4c832f05890
---
 tools/testing/kunit/kunit_kernel.py | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2998e1bc088b..4f0bec8fb4e1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -16,7 +16,7 @@ import shutil
 import signal
 import sys
 import threading
-from typing import Iterator, List, Optional, Tuple
+from typing import Iterator, List, Optional, Tuple, Any
 from types import FrameType
 
 import kunit_config
@@ -265,6 +265,7 @@ class LinuxSourceTree:
 		if kconfig_add:
 			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
 			self._kconfig.merge_in_entries(kconfig)
+		self._process : Optional[subprocess.Popen[Any]] = None
 
 	def arch(self) -> str:
 		return self._arch
@@ -358,36 +359,45 @@ class LinuxSourceTree:
 			args.append('kunit.filter_action=' + filter_action)
 		args.append('kunit.enable=1')
 
-		process = self._ops.start(args, build_dir)
-		assert process.stdout is not None  # tell mypy it's set
+		self._process = self._ops.start(args, build_dir)
+		assert self._process is not None # tell mypy it's set
+		assert self._process.stdout is not None  # tell mypy it's set
 
 		# Enforce the timeout in a background thread.
 		def _wait_proc() -> None:
 			try:
-				process.wait(timeout=timeout)
+				if self._process:
+					self._process.wait(timeout=timeout)
 			except Exception as e:
 				print(e)
-				process.terminate()
-				process.wait()
+				if self._process:
+					self._process.terminate()
+					self._process.wait()
 		waiter = threading.Thread(target=_wait_proc)
 		waiter.start()
 
 		output = open(get_outfile_path(build_dir), 'w')
 		try:
 			# Tee the output to the file and to our caller in real time.
-			for line in process.stdout:
+			for line in self._process.stdout:
 				output.write(line)
 				yield line
 		# This runs even if our caller doesn't consume every line.
 		finally:
 			# Flush any leftover output to the file
-			output.write(process.stdout.read())
+			if self._process:
+				if self._process.stdout:
+					output.write(self._process.stdout.read())
+					self._process.stdout.close()
+				self._process = None
 			output.close()
-			process.stdout.close()
 
 			waiter.join()
 			subprocess.call(['stty', 'sane'])
 
 	def signal_handler(self, unused_sig: int, unused_frame: Optional[FrameType]) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
+		if self._process:
+				self._process.terminate()
+				self._process.wait()
 		subprocess.call(['stty', 'sane'])
-- 
2.34.1

