Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D04B1277
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443374; cv=none; b=N0MY+RdwRkRxWJMsKB8FoQU9d/yWSaQd702u/9mdopCPV5az4/s+NvbskYLie8ui12IkgJxHDJDTzQ7qjoIFmfgQ6YneHrLuGpfT576gNVJc+zoJvtn7IlrirU+OojmHCOJb2cyTCmr96R4PaPx3Xoyy7vVxSjUF8a7cv8zviWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443374; c=relaxed/simple;
	bh=yZ6FexYnxxzp8eGT/sIx5mYBTecZLW2Aepnp+HeYyTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CxDQlF0kBdl72WhjOVI1tvRK8Vsvela/q8G2Hb5w9EoG62I907uTskDAXWe7x1AuW/gYFxHh4TNZ8CmOOSRXHMRW426Xa6wq60RHq1LIm1NuOCf4TePQog73OxN2KctUaHjIhR0NcOl+ToU/q75R+u7CucgfVHTku6lzfY5AUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmKRb7en; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmKRb7en"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE7C1F00A3E;
	Thu,  3 Sep 2026 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443361;
	bh=5a9sSSmOiv6pfg7KWhLHY5DL7/BoUoxdovuu/7CEJew=;
	h=Subject:To:Cc:From:Date;
	b=CmKRb7enWjbGtP/OyaScMRW1STLjuoxr63o4kJeMiFmfU9fCO5QdAG6PbszHOU0o4
	 oB5b+oq0kkaLc0zHWDC6T1ba7hXe1PGNgq+PspzHz+hPRxVlfK+KA9RGePkYiNDCD5
	 vsFJ05uUxvx21Rcv8h07jV+kdb0YYuxqu45i5li0=
Subject: FAILED: patch "[PATCH] smb: client: reject a tree connect response whose byte count" failed to apply to 6.12-stable tree
To: hexlabsecurity@proton.me,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:27:36 +0200
Message-ID: <2026090336-rising-foyer-5fb8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 65deb18359341141d37dc86fc7853511be3c87a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090336-rising-foyer-5fb8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65deb18359341141d37dc86fc7853511be3c87a7 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Fri, 21 Aug 2026 07:36:16 -0500
Subject: [PATCH] smb: client: reject a tree connect response whose byte count
 is too small

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

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 1f77512252e7..f5aad5f61dce 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -615,6 +615,11 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
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
@@ -670,6 +675,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
 			reset_cifs_unix_caps(xid, tcon, NULL, NULL);
 		}
 	}
+out:
 	cifs_buf_release(smb_buffer);
 	return rc;
 }
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 5b21ad3c15fb..12241abb8e2e 100644
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
@@ -213,7 +214,7 @@
 #define EM(a, b) a,
 #define E_(a, b) a
 
-enum smb_eio_trace		{ smb_eio_traces } __mode(byte);
+enum smb_eio_trace		{ smb_eio_traces };
 enum smb3_rw_credits_trace	{ smb3_rw_credits_traces } __mode(byte);
 enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mode(byte);
 

