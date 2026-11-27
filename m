Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795763767;
	b=grMtWvJCtq/cCLnJWuD8HV4ie+8UK31OtRzn5AqHAd40gAfR9454qPeWaLjnRV8fYnYZ
	 4dxuqLpCtrXjcdl+rP5xA05E6XPIk0AQRz4kOFFKzVSNm5myjSTNd2x7av0Bm2udrTWNQ
	 ZtqeDTEu6NdySQF6o8OsjhPRwKavyeoBcUHDujJUsTifzVJmqwE5EW8G1u1jZZHwonWfj
	 ik/4/YPjraZZ8qITELakKU6bPHEpzeEU1woaicQvlFjUBX9fIWVb6oMj6TQN+S3EtEUXg
	 8ahsrRRwxcCEcZUScG3nuAVEvC6bPkGF25XLmNdZXiyLBdwqUPHQL+LqWeHANjddd0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763767;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WlyVMIf+w2EK4kCSEt6kaV0RPIZEQmXW1mV3dcuujUQ=;
	b=Tyiddm6xjel1d5UO8D1RWJQRIo8/UJOhm+LFdtB9PXP6BqkPdGl0KxX/U2/HsOSuq084
	 wSu2DZTacezymbScozDju8nKVzsGIaXcrl+3+fWHCegrflRj5vjQBzlUD3bOvw8Gy2s05
	 h1IRzymxcQr5Y4Y6oR+YREHHgPM6Q4P4Up8hn1EAw89n9G/8MVos3lB44HHtJIbvMhKbQ
	 fDgb5V1gNs+fwMfMYgwUcH9c+CSLFvUvAj2vAbYL3NlzxYG/DPAp2Loe7dmmmFMDpSBTq
	 Ng3KdTUrMUEGwXnnu/9kT/l/OFlAfnEqggoEFJ0lQ/ETi14JQ6J7MmW4w+EwP0nw5Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BAmhBnEC;
	arc=none smtp.remote-ip=91.218.175.228
Received: from mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B617606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 07:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B617606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BAmhBnEC
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UZ9O/NjNPc2csaBXueC5lS/m897rTjKX3GK+oQ+Naos=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795763764; v=1; x=1796368564;
 b=BAmhBnECdHQLGTcuEm4vGzReBW93g4dgWBXd7QcUMyF0AFNUozbGBfV9qHhBcfA87gNHDZOc
 PU1XVxeU1FbAwofaKCY/EpLz2qekhQbM64e0pDDnh1qPVJo4j1Pk0/++IBl8ZMYAbgns2S5coj4
 MSUf5vvUqqxDNcnOo4PBZKyM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 094f7b84a20c887f;
	Fri, 27 Nov 2026 07:16:04 +0000
X-Mizu-Trace-ID: 094f7b84a20c887f
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: printk@lists.linux.dev
Cc: Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v1] printk: clear saved_console_loglevel on /proc/sys/kernel/printk writes
Date: Fri, 27 Nov 2026 16:15:48 +0900
Message-ID: <20261127071548.333115-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

When console logging is temporarily disabled via syslog(2)
SYSLOG_ACTION_CONSOLE_OFF (e.g., "dmesg -D" or Plymouth during boot),
do_syslog() stores console_loglevel in saved_console_loglevel and later
restores it on SYSLOG_ACTION_CONSOLE_ON (e.g., "dmesg -E" or
plymouth-quit).

Commit 1aaad49e856c ("printk: Restore previous console_loglevel when
re-enabling logging") clears saved_console_loglevel on
SYSLOG_ACTION_CONSOLE_LEVEL ("dmesg -n") so an explicit loglevel update
implicitly re-enables console logging. However, /proc/sys/kernel/printk
uses proc_dointvec() directly and leaves saved_console_loglevel stale.
If systemd-sysctl sets kernel.printk (e.g., "4 4 1 7") while console
logging is disabled during boot, a later SYSLOG_ACTION_CONSOLE_ON
silently overwrites console_loglevel back to the old saved value (e.g.,
7), flooding slow serial consoles with notice/info messages.

Move saved_console_loglevel to file scope and wrap proc_dointvec() in
printk_sysctl_set_loglvl() to reset saved_console_loglevel to
LOGLEVEL_DEFAULT on successful writes, while leaving it intact on reads,
empty/invalid writes, and non-zero-offset writes ignored under
SYSCTL_WRITES_STRICT. Because /proc/sys/kernel/printk always writes
starting at console_loglevel, valid offset-0 writes clear
saved_console_loglevel even when re-writing the current loglevel (e.g.,
kernel.printk = "1 4 1 7"), matching SYSLOG_ACTION_CONSOLE_LEVEL
semantics (at the cost of also clearing it if a caller rewrites
console_loglevel solely to adjust later fields).

Serialize saved_console_loglevel and console_printk[] updates across
do_syslog() and /proc/sys/kernel/printk with a dedicated
console_loglevel_lock mutex (using READ_ONCE/WRITE_ONCE for
console_loglevel to match proc_dointvec()), keeping syslog_lock scoped
to ringbuffer reader state and avoiding contention or lock-ordering
dependencies with syslog readers and console registration.

Fixes: 1aaad49e856c ("printk: Restore previous console_loglevel when re-enabling logging")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/printk.c   | 50 ++++++++++++++++++++++++++++++++++++----
 kernel/printk/sysctl.c   |  2 +-
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 85fbf1801cbe..8bae853c64b7 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -10,6 +10,8 @@
 void __init printk_sysctl_init(void);
 int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos);
+int printk_sysctl_set_loglvl(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos);
 #else
 #define printk_sysctl_init() do { } while (0)
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5dbcf8a9909b..c6d2bec573b6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1737,11 +1737,17 @@ static void syslog_clear(void)
 	mutex_unlock(&syslog_lock);
 }
 
+/*
+ * Protects @saved_console_loglevel and serializes syslog(2) and
+ * /proc/sys/kernel/printk updates to console_printk[].
+ */
+static DEFINE_MUTEX(console_loglevel_lock);
+static int saved_console_loglevel = LOGLEVEL_DEFAULT;
+
 int do_syslog(int type, char __user *buf, int len, int source)
 {
 	struct printk_info info;
 	bool clear = false;
-	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
 
 	error = check_syslog_permissions(type, source);
@@ -1782,26 +1788,32 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_OFF:
+		mutex_lock(&console_loglevel_lock);
 		if (saved_console_loglevel == LOGLEVEL_DEFAULT)
-			saved_console_loglevel = console_loglevel;
-		console_loglevel = minimum_console_loglevel;
+			saved_console_loglevel = READ_ONCE(console_loglevel);
+		WRITE_ONCE(console_loglevel, minimum_console_loglevel);
+		mutex_unlock(&console_loglevel_lock);
 		break;
 	/* Enable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:
+		mutex_lock(&console_loglevel_lock);
 		if (saved_console_loglevel != LOGLEVEL_DEFAULT) {
-			console_loglevel = saved_console_loglevel;
+			WRITE_ONCE(console_loglevel, saved_console_loglevel);
 			saved_console_loglevel = LOGLEVEL_DEFAULT;
 		}
+		mutex_unlock(&console_loglevel_lock);
 		break;
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
 		if (len < 1 || len > 8)
 			return -EINVAL;
+		mutex_lock(&console_loglevel_lock);
 		if (len < minimum_console_loglevel)
 			len = minimum_console_loglevel;
-		console_loglevel = len;
+		WRITE_ONCE(console_loglevel, len);
 		/* Implicitly re-enable logging to console */
 		saved_console_loglevel = LOGLEVEL_DEFAULT;
+		mutex_unlock(&console_loglevel_lock);
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
@@ -1855,6 +1867,34 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
+#ifdef CONFIG_SYSCTL
+int printk_sysctl_set_loglvl(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	loff_t pos = *ppos;
+	int old_loglevel;
+	int err;
+
+	if (!write)
+		return proc_dointvec(table, write, buffer, lenp, ppos);
+
+	mutex_lock(&console_loglevel_lock);
+	old_loglevel = READ_ONCE(console_loglevel);
+	err = proc_dointvec(table, write, buffer, lenp, ppos);
+	/*
+	 * Implicitly re-enable logging to console. Under SYSCTL_WRITES_STRICT,
+	 * non-zero-offset writes return 0 without updating table->data, so
+	 * require either offset 0 or an observed console_loglevel change.
+	 */
+	if (!err && *lenp &&
+	    (!pos || READ_ONCE(console_loglevel) != old_loglevel))
+		saved_console_loglevel = LOGLEVEL_DEFAULT;
+	mutex_unlock(&console_loglevel_lock);
+
+	return err;
+}
+#endif /* CONFIG_SYSCTL */
+
 /*
  * Special console_lock variants that help to reduce the risk of soft-lockups.
  * They allow to pass console_lock to another printk() call using a busy wait.
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index f15732e93c2e..a2c204320898 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -25,7 +25,7 @@ static const struct ctl_table printk_sysctls[] = {
 		.data		= &console_loglevel,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= printk_sysctl_set_loglvl,
 	},
 	{
 		.procname	= "printk_ratelimit",

base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
-- 
2.43.0

