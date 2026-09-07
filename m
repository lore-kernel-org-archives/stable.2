Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16651526A84
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811228; cv=none; b=qupigUwBJYNkScLceOGRnxC/PBWtxUK7KFrsijjzLklnRPLrvBF1vb/YcwleTTed6mJXR/Fd2t5Yb+gHKLmmnGD4VnTFVoWPHBHggm2tePXajupTUEMoo0p8t7pE0qJofzwV8TfuguyE06IxiwzMiqR2aoLGFqoCZ5j8ZpA+8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811228; c=relaxed/simple;
	bh=SvDZnuayCHqxUJt6NA1wNjOKLGHw/t/n4f+6f4lLWQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0GYYyATeQbr7Y6HajgGepU+s4FJ7r76PMP8+lPMzZaTZNhGtzBmZGg5VzAdt85jgozw6bvKRTGVyMUglM2FLOnwssiMFfWqsMN5ttD+VqUe3X0ujD+6H6ehFrVBJqvBX/UAb4KcSiOE4Vh/+8fQJnRpsxStPucvH5JvQNt28HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFAVzG3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFAVzG3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690EB1F00A3E;
	Mon,  7 Sep 2026 20:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788811227;
	bh=5hdzriozcfGMkLEpWKCdqY9vaNAm53DmoH4lrGG7bvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QFAVzG3vguYwHAlsh1DhplNxXZEDu6iaL1i0S0lpi7/LXjzEaXKaFfZVH0teU8Edy
	 tfrZI/KbUr5mo4oZk9gkod+WD6Uwj1tLVwO5n8ubfH/SXO4CXvrCFfTsLcDY1QeLOk
	 dJ3iKvYiSs22LOIFZyqAX/1MVchMjkSgW9jXH8EwuIm/cBbMoWCgeBjRIsrgXlQmMV
	 T3/IvDeisq8LQjvz9/7+hQL6H38QC5MZrzZDuVmrP1no+PDHe7jQNZhO9Sjd/3UAU+
	 pJXERJWkNcIDk4h57ACZlvXmE2TjMd+MPkYexCign6cZUkjne6TQ89ye6gt47D/VMT
	 c39Adx2ybQ8sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] smb: client: reject a tree connect response whose byte count is too small
Date: Mon,  7 Sep 2026 16:00:22 -0400
Message-ID: <20260907200022.327035-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907200022.327035-1-sashal@kernel.org>
References: <2026090336-rising-foyer-5fb8@gregkh>
 <20260907200022.327035-1-sashal@kernel.org>
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
index 696b2a800d7e3..fa643f0d3de49 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -590,6 +590,11 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
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
@@ -645,6 +650,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 			reset_cifs_unix_caps(xid, tcon, NULL, NULL);
 		}
 	}
+out:
 	cifs_buf_release(smb_buffer);
 	return rc;
 }
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index d619e407f6409..8896ec7299cdf 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -24,6 +24,7 @@
 	EM(smb_eio_trace_sym_slash,			"sym_slash") \
 	EM(smb_eio_trace_sym_target_len,		"sym_target_len") \
 	EM(smb_eio_trace_symlink_file_size,		"symlink_file_size") \
+	EM(smb_eio_trace_tcon_bcc_too_small,		"tcon_bcc_too_small") \
 	EM(smb_eio_trace_tdis_in_reconnect,		"tdis_in_reconnect") \
 	EM(smb_eio_trace_tx_chained_async,		"tx_chained_async") \
 	EM(smb_eio_trace_tx_compress_failed,		"tx_compress_failed") \
@@ -93,7 +94,7 @@
 #define EM(a, b) a,
 #define E_(a, b) a
 
-enum smb_eio_trace		{ smb_eio_traces } __mode(byte);
+enum smb_eio_trace		{ smb_eio_traces };
 enum smb3_rw_credits_trace	{ smb3_rw_credits_traces } __mode(byte);
 enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mode(byte);
 
-- 
2.53.0

