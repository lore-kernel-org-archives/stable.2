Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF94570C5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323798; cv=none; b=dkndYwJT5Uz7Qzh1ttI1XIxQ/rmTtPWzsfaVuZsAIo3GZEPs4juHHt506M4Nji07dlHd/EHgxWGc335SDyyGKGsir4MCk8QBzBZOEI5wjPEYZIF1LYUTy192WsxQXY/v6mrT82OKOpsEMDto5yMOJOgCxeuTU3ibmQ/x7WzUL04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323798; c=relaxed/simple;
	bh=ygbuPzlFqrsuVbqxWZyf7sIlgz0cX2F+NaMVRIThaFw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=csrSz6An38nnBzBTMxNsLZaGbnesXHe3UaO0TaBDc8iAxeWbTMjrmc7fEV8OFqFP7a16OhaMLoPlp20MjWKZRHAmLYaf0OI1Ijnh1qSxe11KLUnHlLhhIlLClcRT5BiPsOBM+9c3Bsi2a1TYEETtTy2sEyKbCWrNRUXgDeg1GDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAaATKFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAaATKFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15AE1F000E9;
	Wed, 29 Jul 2026 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323797;
	bh=Nj1yTfdP88OtLAzHbkzyD0GC/qm0NIM4HwOjfUpRL/k=;
	h=Subject:To:Cc:From:Date;
	b=NAaATKFKWxxbqAlpGrM7JG3N61ZGbmWM/DfrhouOQ5TWbRhlMJnRV/V+Ek1f0d2yK
	 1VMBd3yWeR2+uFboiHKYV5inyhkT61V0Jyoqr2iwgeL28iZPN6J28xAvmdJIzr9S+P
	 7ejAdlSdHbVGzLxKy9Nn6lZnSiaJoPb+NzMIpA7M=
Subject: FAILED: patch "[PATCH] drm/amd/display: guard against overflow in HDCP message dump" failed to apply to 5.10-stable tree
To: harry.wentland@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,george.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:15:46 +0200
Message-ID: <2026072946-undrafted-imply-6e98@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 93c8fe6d56037f284be7116d0c8155847c6d7fbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072946-undrafted-imply-6e98@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

