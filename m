Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B894503E0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588868; cv=none; b=IC1hC24pSkdu7bqgGnZHyQPEpjKctFFpRDBjENdEwoPGXr+aJUOYFcLJsOjP7H1HGKvy1ujg/tvlpMJZ30a06CX7w4cbQY3PQPRgZra+l5OHmMiMvjC9Y2kaic10JL287Z5y/m1JnpkfTDjxlOzd2W4RA4XUHVqf9aYDUUEIUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588868; c=relaxed/simple;
	bh=6C5h/PwjOIhW2PTc3T4q4WtszvuF882kVpHLd2gzcY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpgXoHi1knGin0gdTC6cFp+HJUX7LQ0rQdPjecc9EP7LrzVlkfMMyBFBGrA/F/CHdIjVZiT8La2YPbqPyznd0gzIrN2hIacTJ8u+RQNkJGBiDWE1vTrx/KdwGGs931FAcsDjg+qbKs08XN2omRncDB2cclpGOxnDJR3eHGJsre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxAjpel5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxAjpel5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA901F0089A;
	Wed, 16 Sep 2026 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588842;
	bh=1yPv7U10sxqhFD1bL2qBoUgVkIcHA6MK2FYvih2ea0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KxAjpel5ohvn1kXot5y5u9FmCLpbmwD/cxAW+v6fVu6aKg0dGtgYlsI929Gkv9TxL
	 i6C3yEaP7QnaSWeKdXBs+xDm8wf4/JD4gSxArbQpzy5hwr5NCtFKFail487+oTk0n1
	 9nxpPvWyAlZqjfiXaAkg8zztlkJDgaTjBYwpVeIyCMxa3fKndG9eedY5+vnbRmCw1i
	 7jht2ZQR+hXI1+eSNUCrj1ZcEWPvYdl3jvJgayOYHmPDs9LdP08FS782DRVXO7ChU+
	 Y+Pl6s2TSpyQcph7WKbmdl91iRWiJkWFn/pLgh1EgibRr4ZXXSVVHFMh7oQ3TL7dI5
	 SS2ikGunvlnZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] accel/ivpu: Limit firmware log name prints to field size
Date: Wed, 16 Sep 2026 16:00:38 -0400
Message-ID: <20260916200038.2459399-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916200038.2459399-1-sashal@kernel.org>
References: <2026091615-moisten-showy-63d8@gregkh>
 <20260916200038.2459399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

[ Upstream commit 95bf070f3225dc7175725438c916ad321d42fe45 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_fw_log.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index b1919c0749640..0ea0b7e0e8a18 100644
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
 
 void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p)
-- 
2.53.0

