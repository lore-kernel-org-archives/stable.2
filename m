Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F447124D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323784; cv=none; b=Y7DEK3gSFmu97Cym8NvN050CIpIOdlkeJd9sICk5qzsUyzmmE6KXXSF3q1a8GeDBahNIPRKmJJdc4H2ngMvH+rDl4NcBRgejWUjKuXGMTe54zo4PIK05pXq5gylXu4xUIYhEHGoAgMCw4uH975TCC1WcQ1O8+ZR0W5U8RwBNjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323784; c=relaxed/simple;
	bh=CbHOIka3tE5NLz/MDJx2jWZ1uAR4f2C917giFuzdIBw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AN4FMoKg/GR488qWRnHoyc9QQkUCFBpdzzL/8gvmdnwrgGINXvjb0qHwITpHhGTcaVBJlTwQxidVK740uCuqPDYB9qCxbhxDMKCwjY29MR/18QilmNbr3DdfHuB/q0nOOqt+sDZivM4JF/FYb7bn7mSFx8+cajDi1zqesqYXKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R11mFpAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R11mFpAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917D81F000E9;
	Wed, 29 Jul 2026 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323783;
	bh=y9Lz6ADKoI/IKn54TUS1LWApOBu1AsNxMpG5CyOenSk=;
	h=Subject:To:Cc:From:Date;
	b=R11mFpAxqh+cRevBtjKo/oYr07yWEiFgE0SYsP2Ve6udOdeDMeHhdFq5xRaSveRS6
	 7Uq5ox1UtfUX7KsKfwJsSm1P+gCDqLbvHhIL/+3C0Dbh6AxEH8enorRgVwZ2IKm43M
	 WsrsUq4lshop3QOcCXSMTtF395WcUzk7iZeN1sXc=
Subject: FAILED: patch "[PATCH] drm/amd/display: guard against overflow in HDCP message dump" failed to apply to 7.1-stable tree
To: harry.wentland@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,george.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:15:43 +0200
Message-ID: <2026072943-starboard-brisket-7559@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 93c8fe6d56037f284be7116d0c8155847c6d7fbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072943-starboard-brisket-7559@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 93c8fe6d56037f284be7116d0c8155847c6d7fbe Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland@amd.com>
Date: Tue, 16 Jun 2026 12:17:45 -0400
Subject: [PATCH] drm/amd/display: guard against overflow in HDCP message dump

[Why]
mod_hdcp_dump_binary_message() computed target_size (a uint32_t) as roughly
byte_size * msg_size and gated the whole write on buf_size >= target_size. A
large msg_size can overflow target_size, wrapping it to a small value that
passes the check while the loop still writes byte_size * msg_size bytes
into buf. All current callers pass small constants so this is not reachable
today, but the unchecked arithmetic should be hardened.

[How]
Drop the overflow-prone target_size precomputation and instead bounds-check the
output position on every iteration, stopping once the next entry would not leave
room for the trailing terminator. This cannot overflow and, for oversized
messages, dumps as much as fits rather than printing nothing.

Fixes: 4c283fdac08a ("drm/amd/display: Add HDCP module")
Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d0a775e5d70b376696245a14c09e3aa6dde0023a)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index 1164fd96b714..f0f8e280ed30 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -33,22 +33,28 @@ void mod_hdcp_dump_binary_message(uint8_t *msg, uint32_t msg_size,
 			byte_size = 3,
 			newline_size = 1,
 			terminator_size = 1;
-	uint32_t line_count = msg_size / bytes_per_line,
-			trailing_bytes = msg_size % bytes_per_line;
-	uint32_t target_size = (byte_size * bytes_per_line + newline_size) * line_count +
-			byte_size * trailing_bytes + newline_size + terminator_size;
 	uint32_t buf_pos = 0;
 	uint32_t i = 0;
 
-	if (buf_size >= target_size) {
-		for (i = 0; i < msg_size; i++) {
-			if (i % bytes_per_line == 0)
-				buf[buf_pos++] = '\n';
-			sprintf((char *)&buf[buf_pos], "%02X ", msg[i]);
-			buf_pos += byte_size;
-		}
-		buf[buf_pos++] = '\0';
+	/* Need room for at least the terminator. */
+	if (buf_size < terminator_size)
+		return;
+
+	for (i = 0; i < msg_size; i++) {
+		uint32_t needed = byte_size + terminator_size;
+
+		if (i % bytes_per_line == 0)
+			needed += newline_size;
+
+		if (buf_pos + needed > buf_size)
+			break;
+
+		if (i % bytes_per_line == 0)
+			buf[buf_pos++] = '\n';
+		sprintf((char *)&buf[buf_pos], "%02X ", msg[i]);
+		buf_pos += byte_size;
 	}
+	buf[buf_pos++] = '\0';
 }
 
 void mod_hdcp_log_ddc_trace(struct mod_hdcp *hdcp)

