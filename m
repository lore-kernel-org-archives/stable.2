Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC2503BC3
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794096; cv=none; b=kmGaenoaN+XaiXfzOYJFQP35g3antVYWWTFfOTS/0HsNJCOIwaImEIqcWpUzSNkr8gyrSJmbFXzYH3dmc3HRtYi8r7chSVm+QYADpe1o/gO4DpA3Vl03FfbNWOdZ7VGq38U3fxpPgFgKp4j7dX2UmJOU+3Rh9ND9iX4C9d5yYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794096; c=relaxed/simple;
	bh=mV98fX3r/0rVQDec31h1O392VC2d08s/XLwFPDj+zWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6nyAF/EVovhwE0gwnKAUaUVy6BrFVCW6Dsvh7CbTkRFyC39iwF0daGprEO7meW4Qv9p7+cIieUXCeBSC123KfuiAuq0O6IpnR5/IL/iKJhODOIpvI1uF5ktTT3vNk01LGuuzdi8oDTRRK0tMmlUGpW8UjqFI5CXevYuAT6rI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJc+19YX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJc+19YX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628161F00A3D;
	Mon,  7 Sep 2026 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788794095;
	bh=eQqyP6kC5tsOXWENMVjzkOS2BvTj/JG4vlUaA21M0nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bJc+19YX1Pz212IdLGG975FTqnAhvlMpOTd9LzGRHOsZvWhiN84r8IMAZyW3BiWX4
	 I2ji15swncHXzmMosRtdnCz12wjUZlQslDDk93W1o9orIzrb4W66y2eZORHPRLxRtA
	 8HUARqQThYQ6st0NJj0+RCkwpbcbbFUlcqJcR2AvKSezn5f4ODAKBp1WFk4PeB2aqY
	 qn9DW06bqqsxnzKWCTUTT2irDaLXeKXK88epMRgXqpebNa9sZtasdlojJfRP9HqHvL
	 +i4NIEzGd2dJjAQC4EcLQ2ivahLSnl1WOwa0MZsGKaNIvUVzk2rJM6bcieQ2KfDDqN
	 haPtdcnHy1BSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] smb: client: reject a tree connect response whose byte count is too small
Date: Mon,  7 Sep 2026 11:14:49 -0400
Message-ID: <20260907151449.3749114-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907151449.3749114-1-sashal@kernel.org>
References: <2026090335-figure-bright-e488@gregkh>
 <20260907151449.3749114-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 65deb18359341141d37dc86fc7853511be3c87a7 ]

CIFSTCon() bounds its strnlen() over the byte area with the server's
ByteCount minus two, which for ByteCount 0 or 1 goes negative as an int
and converts to a huge size_t.  The later subtraction wraps the __u16
bytes_left, and that is what bounds cifs_strndup_from_utf16(): a bound of
up to 65535 against a ~16 KB cifs_req_poolp object runs off the end of the
slab object, and the bytes reach userspace through tcon->nativeFileSystem
in /proc/fs/cifs/DebugData.

Reject a byte area too small for what the parser consumes.  Two bytes is
the least it can consume, and no conformant response carries fewer.  The
new trace point is the 129th smb_eio_trace entry, which __mode(byte)
cannot represent, so the attribute goes with it.

Fixes: cc20c031bb06 ("cifs: convert CIFSTCon to use new unicode helper functions")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 6 ++++++
 fs/smb/client/trace.h   | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index fa5f01ab119f6..7518ecafa3bc1 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -608,6 +608,11 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 		tcon->tid = smb_buffer_response->Tid;
 		bcc_ptr = pByteArea(smb_buffer_response);
 		bytes_left = get_bcc(smb_buffer_response);
+		if (bytes_left < 2) {
+			rc = smb_EIO2(smb_eio_trace_tcon_bcc_too_small,
+				      bytes_left, 2);
+			goto out;
+		}
 		length = strnlen(bcc_ptr, bytes_left - 2);
 		if (smb_buffer->Flags2 & SMBFLG2_UNICODE)
 			is_unicode = true;
@@ -663,6 +668,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 			reset_cifs_unix_caps(xid, tcon, NULL, NULL);
 		}
 	}
+out:
 	cifs_buf_release(smb_buffer);
 	return rc;
 }
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 6fe0369b19142..90fd665ff8dd0 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -133,6 +133,7 @@
 	EM(smb_eio_trace_sym_slash,			"sym_slash") \
 	EM(smb_eio_trace_sym_target_len,		"sym_target_len") \
 	EM(smb_eio_trace_symlink_file_size,		"symlink_file_size") \
+	EM(smb_eio_trace_tcon_bcc_too_small,		"tcon_bcc_too_small") \
 	EM(smb_eio_trace_tdis_in_reconnect,		"tdis_in_reconnect") \
 	EM(smb_eio_trace_tx_chained_async,		"tx_chained_async") \
 	EM(smb_eio_trace_tx_compress_failed,		"tx_compress_failed") \
@@ -214,7 +215,7 @@
 #define EM(a, b) a,
 #define E_(a, b) a
 
-enum smb_eio_trace		{ smb_eio_traces } __mode(byte);
+enum smb_eio_trace		{ smb_eio_traces };
 enum smb3_rw_credits_trace	{ smb3_rw_credits_traces } __mode(byte);
 enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mode(byte);
 
-- 
2.53.0

