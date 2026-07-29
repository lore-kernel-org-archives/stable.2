Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AD471CFA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323787; cv=none; b=nWXiizt1I75izky/uwgXH3Mf8G7vcZZAHug0+P7vReUhbrpdIItRpjUTLBIuZCZ7XtAqN3lm5eJ8DZFUwSc974CN4YnEiPY2/7t5Rq+42dWyoJ2SAehip3E3+yrYxb1rlfX89JiwL7fMa6f3Mfk2PQ7UUe0l2etmMLeDapIh/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323787; c=relaxed/simple;
	bh=h/Hr2E73W3wxUzCVyV4WuEtO99bXKlfp8JAszIMkNC8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t4QZPlIFKYF7sVXqK7F5VEx0jdpakUOtDdO5xtcpafKEJHConlAnAVFq3lGMnItEhEwBSV3mq+g37AoSCfvffiT6JmxdQ+QzZT8BrejAGrhJzofDiWVK5XNe7O1A6uxbWO4z+IPiI2EwHvwukIeuguM1uf41jrx/1AhsAWC2cWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dhkuq/v4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dhkuq/v4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662721F000E9;
	Wed, 29 Jul 2026 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323785;
	bh=0aIRdqWGhd7l9Tiq3EFk3FFKpBk4CzHqHDS/F0N2/wA=;
	h=Subject:To:Cc:From:Date;
	b=Dhkuq/v4hBMeEm+7r10VBh7oVxierk1E9TWtQtoCyNEsAmgsoA6QpWd0gW730D284
	 8DwWStbMYvdOPznbLao3+eO2rfLBKpTq+e5lC50/nS5V3bScWyxTfzBGIsaXfgZ92c
	 JM3Z/G6dJcF2H6cUVtDsyOngirBr4coeOZ7qCd/Q=
Subject: FAILED: patch "[PATCH] drm/amd/display: guard against overflow in HDCP message dump" failed to apply to 6.6-stable tree
To: harry.wentland@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,george.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:15:44 +0200
Message-ID: <2026072944-flagman-thimble-4ccb@gregkh>
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
git cherry-pick -x 93c8fe6d56037f284be7116d0c8155847c6d7fbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072944-flagman-thimble-4ccb@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

