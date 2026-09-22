Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337A54CF78
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090045; cv=none; b=NeDteSwbRrxCeSMjSJQL4A76t8h/GQuDy7kCMWvNHaKlTOmh780rIjOZknDNIyRqVZmkkt1tDync3cvI+frBNAFgdy8obkwBgdQH4HyZVi5gO4VLpohixCNPcJhywKroV26x7zXxerhKwlhM0ki200vvwGF7EuYbyX0Hv6n+LLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090045; c=relaxed/simple;
	bh=ioUkfJkZeXSggh1pwYYENYoIpTM4svRARqJFC+NAODc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p19Fuy9s7BKWAjS1qk7PvxuutRUtPeKAwf8UNwQL9oKObZDIzsJIqU6Xnj34iNBYnIIsISJNWwjfyFrGWOaZ8QaYH9tgWLOQJF1Yy4pFIJ3iAUdOXNdIFwg50FpzJE8Sm2OOQx440hJMOAqIOfPpGMRHcxMFdfNIJbJnnAnMru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBUaywTJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBUaywTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02AF1F00893;
	Tue, 22 Sep 2026 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090044;
	bh=tioEmNEVpxJp0zSFPKSKdpFD0eJlrTNVxfIDQwcimb8=;
	h=Subject:To:Cc:From:Date;
	b=XBUaywTJnV3fV7xT+7PkpfZCkc7OJnjpke40svtlnU+Wbt0QxupbJDgQxOi5im5Do
	 alBCBOd7KKX5quNA8pF5eqeNqE/BmDFx7xyLZG47rP6xyJO8qKUjqwcQe58G5P+/ID
	 +ke5agshGbf8VMlh7P+CXvJSt32BPXsHzJNdt4bA=
Subject: FAILED: patch "[PATCH] smb: client: fix OOB struct field reads in" failed to apply to 5.10-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:07:26 +0200
Message-ID: <2026092226-freeload-voltage-f314@gregkh>
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
git cherry-pick -x eeb5ef6083e1cefa2ef75041b5597ff228b8d7bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092226-freeload-voltage-f314@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eeb5ef6083e1cefa2ef75041b5597ff228b8d7bb Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 16 Sep 2026 16:33:57 -0500
Subject: [PATCH] smb: client: fix OOB struct field reads in
 move_smb2_ea_to_cifs()

In move_smb2_ea_to_cifs(), the while (src_size > 0) loop condition is
insufficient. It allows iteration to continue even if the remaining
src_size is too small to contain a complete smb2_ea_info structure.
Consequently, reads of ea_name_length and ea_value_length can occur
out-of-bounds.

Fix this by ensuring src_size >= sizeof(*src) before attempting to read
any structure fields. Additionally, reject any next_entry_offset that is
smaller than sizeof(*src) or that would advance the pointer beyond the
available buffer.

Note that for calls where the server returns a malformed EA list, the
error returned to userspace changes from -ENODATA (getxattr) or
-ERANGE (listxattr) to -EIO. This correctly signals a server protocol
error rather than misleadingly indicating "attribute not present" or
"output buffer too small".

Fixes: 95907fea4fd8 ("cifs: Add support for reading attributes on SMB2+")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index bda940cb3784..ee3c98e3f316 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1053,8 +1053,9 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 	char *name, *value;
 	size_t buf_size = dst_size;
 	size_t name_len, value_len, user_name_len;
+	u32 next_off;
 
-	while (src_size > 0) {
+	while (src_size >= sizeof(*src)) {
 		name_len = (size_t)src->ea_name_length;
 		value_len = (size_t)le16_to_cpu(src->ea_value_length);
 
@@ -1110,14 +1111,22 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 		if (!src->next_entry_offset)
 			break;
 
-		if (src_size < le32_to_cpu(src->next_entry_offset)) {
-			/* stop before overrun buffer */
-			rc = -ERANGE;
-			break;
+		next_off = le32_to_cpu(src->next_entry_offset);
+		if (next_off < sizeof(*src) || src_size < next_off) {
+			cifs_dbg(FYI, "EA next_entry_offset %u out of range [%zu, %zu]\n",
+				 next_off, sizeof(*src), src_size);
+			rc = smb_EIO2(smb_eio_trace_ea_next_offset,
+				      next_off, src_size);
+			goto out;
+		}
+		src_size -= next_off;
+		src = (void *)((char *)src + next_off);
+		if (src_size > 0 && src_size < sizeof(*src)) {
+			cifs_dbg(FYI, "EA next_entry_offset %u left truncated entry (%zu bytes)\n",
+				 next_off, src_size);
+			rc = smb_EIO2(smb_eio_trace_ea_next_offset, next_off, src_size);
+			goto out;
 		}
-		src_size -= le32_to_cpu(src->next_entry_offset);
-		src = (void *)((char *)src +
-			       le32_to_cpu(src->next_entry_offset));
 	}
 
 	/* didn't find the named attribute */
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index b442cccd1530..bb8d0197cb54 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -27,6 +27,7 @@
 	EM(smb_eio_trace_copychunk_overcopy_c,		"copychunk_overcopy_c") \
 	EM(smb_eio_trace_create_rsp_too_small,		"create_rsp_too_small") \
 	EM(smb_eio_trace_dfsref_no_rsp,			"dfsref_no_rsp") \
+	EM(smb_eio_trace_ea_next_offset,		"ea_next_offset") \
 	EM(smb_eio_trace_ea_overrun,			"ea_overrun") \
 	EM(smb_eio_trace_extract_will_pin,		"extract_will_pin") \
 	EM(smb_eio_trace_forced_shutdown,		"forced_shutdown") \

