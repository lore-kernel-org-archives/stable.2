Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9B521237
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572455; cv=none; b=W3A+yYX9PIaURuHt1GlsiocrVin/MkqaDRoLZBXL3zc0IHiiLC8teytA9IR/CFAAkX66IGWkrqIXtyp9T16L/eaXOvjJIUkATgxH2V8rEONTrXAdNXp72Qj6BKDqktU5viYvNF9ok/Uq0j97bSuGBClCJh01uUZSIagJZj5iwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572455; c=relaxed/simple;
	bh=v6V9zkU48NTv0QrPkJj1H0SZQ2GOrJnJt0/4uPQpTIg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OvZjYDLbzfEAitVD/JISnlWofHOU3aViGHteb//XBEeDeoYlPbz1h64814AGDkoRAg+c+CsvGFrrmOaNicYKR+mC6PNri2F42PpqUbm5ovd3lbKkkwPCwh+6gcZHu9Xozq3Tw1KeNSvRnFEhBbdGfpbY9k1LphBej4SxhRYD2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ta179oMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ta179oMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8611F000FF;
	Wed, 16 Sep 2026 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572450;
	bh=dX+6rVw51Ae6eEV/Y6uhbUuxrKvqWuzmc/PdAgxaxCw=;
	h=Subject:To:Cc:From:Date;
	b=Ta179oMppb14/b2TCVtuOsrLBiBs8GmsIHTD859SUoUScdsVt/2woQf01BcxHUFNo
	 vA4PbxGnk/bBScSpVf5/oAn+FnT8h+P9+Z1CmHm/NkfF1YGhq6J/wdJRKbDdujqHKB
	 IjU4g4b9Nu5ooCKo3U35PHy2gmdoN3ImhU6zn/zo=
Subject: FAILED: patch "[PATCH] accel/ivpu: Limit firmware log name prints to field size" failed to apply to 6.6-stable tree
To: dawid.osuchowski@linux.intel.com,karol.wachowski@linux.intel.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:13:15 +0100
Message-ID: <2026091615-moisten-showy-63d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 95bf070f3225dc7175725438c916ad321d42fe45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091615-moisten-showy-63d8@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 95bf070f3225dc7175725438c916ad321d42fe45 Mon Sep 17 00:00:00 2001
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Date: Tue, 1 Sep 2026 14:57:49 +0200
Subject: [PATCH] accel/ivpu: Limit firmware log name prints to field size

The name in struct vpu_tracing_buffer_header is a fixed-size array
populated by the NPU firmware. It is expected to be NUL-terminated,
but nothing on the host side enforces this, so printing it with an
unbounded string conversion would read past the field if the
terminator is ever missing and expose adjacent bytes of the shared
tracing BO through dmesg and the debugfs FW log output.

Print at most as many characters as the name field holds, so the output
never runs past it even if the string is not NUL-terminated.

Cc: stable@vger.kernel.org
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260827102339.281799-1-dawid.osuchowski@linux.intel.com?part=2
Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260901125749.404338-4-dawid.osuchowski@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 4f9055aa9d33..9eafc42120b6 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -69,9 +69,9 @@ static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *off
 	*offset += size;
 
 	ivpu_dbg(vdev, FW_BOOT,
-		 "FW log name \"%s\", write offset 0x%x size 0x%x, wrap count %d, hdr version %d size %d format %d, alignment %d",
-		 log->name, log->write_index, size, log->wrap_count, log->header_version,
-		 header_size, log->format, log->alignment);
+		 "FW log name \"%.*s\", write offset 0x%x size 0x%x, wrap count %d, hdr version %d size %d format %d, alignment %d",
+		 (int)ARRAY_SIZE(log->name), log->name, log->write_index, size, log->wrap_count,
+		 log->header_version, header_size, log->format, log->alignment);
 
 	return 0;
 }
@@ -123,7 +123,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
 
 	if (log->wrap_count == log->read_wrap_count) {
 		if (log_end <= log_start) {
-			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
+			drm_printf(p, "==== %s \"%.*s\" log empty ====\n", prefix,
+				   (int)ARRAY_SIZE(log->name), log->name);
 			return;
 		}
 	} else if (log->wrap_count == log->read_wrap_count + 1) {
@@ -133,7 +134,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
 		log_start = log_end;
 	}
 
-	drm_printf(p, "==== %s \"%s\" log start ====\n", prefix, log->name);
+	drm_printf(p, "==== %s \"%.*s\" log start ====\n", prefix, (int)ARRAY_SIZE(log->name),
+		   log->name);
 	if (log_end > log_start) {
 		fw_log_print_lines(log_data + log_start, log_end - log_start, p);
 	} else {
@@ -141,7 +143,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
 		fw_log_print_lines(log_data, log_end, p);
 	}
 	drm_printf(p, "\n\x1b[0m"); /* add new line and clear formatting */
-	drm_printf(p, "==== %s \"%s\" log end   ====\n", prefix, log->name);
+	drm_printf(p, "==== %s \"%.*s\" log end   ====\n", prefix, (int)ARRAY_SIZE(log->name),
+		   log->name);
 }
 
 static void

