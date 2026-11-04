Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817059;
	b=g5WbisEw6IXLbaXayFke8W97wF+dlNUYMYb5gT3vl8Z427RvUtpV1dNUKfqjqLwLHN+A
	 JTRFNWnqMBKRFHnJq9uI3k/FaHVLIb8wmldiDVfsRqpiohoTm0hB8rKrc6ysCygO0QttA
	 Sl9CuqnNPzFdl+7smDW7wW/WeEhLVs21MCcq0Od+iRQWxKDak1c9IH0B1PRvsVH9swfWH
	 ENHpi+bh1oBSOp5c9+eFKX4/au97tmMNYkdkwT5bqU51Ebtsyqd4wmyG3BJ5POnMcOiMF
	 uwJ4MnCWbX3G6me2UJgjNP5dTxK120jT/K+Mjwd40gIXfwG14avKjkugfz5lCJslJsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817059;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IhNJchUdj1pTiZf569zPQsaScriOAxicd3b8kaZRIV4=;
	b=Jf9bsIhAm3BxH5cdF8wgMbyk6N8t/jb2HaKZ86uwZ++6zkousZxIHN6rKKccD6JbNook
	 RikzOoYoq+mx9qkTx691mZ5K/8LfJMWbzOPieE/q9QVr//qOsCpzNqL00tJdKjiuzjB2I
	 DJwILpfD7rZohJHrrGgp7CaxbQBCRtbJH0S1PkV90iia5ZEagl2dJvOk0b16jGuGmPzfA
	 7GU9LndsM15KnSSI5NZcOazoZYrz4d3d8towEJkTmtmGLDfGd8Fix4y8lyrF+LK8zfXBt
	 N2EOFH/ivTQOCmSrWjQ0hI53p8ebcbzdTvC0DYKQwE8n7qYTcsNTKEQNaL9dc+qbjPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZUa542Xv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F13606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZUa542Xv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259091F000C1;
	Wed,  4 Nov 2026 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817058;
	bh=IhNJchUdj1pTiZf569zPQsaScriOAxicd3b8kaZRIV4=;
	h=Subject:To:Cc:From:Date;
	b=ZUa542XvcJFq6eqpcFzkrO/ThD++Veh5vVKEa7w38aKPFT7RMvSL5LmjF3XBY0Rqc
	 2aEP45FZFyevgKpKQouKcEkhNGkUeSQuH3oy2FMoRwujmmLzprt0EmllyZW+s76Qsr
	 72XMNh1jQa07aoq57lqIRiHRCTO9WrOUwR9kn0qQ=
Subject: FAILED: patch "[PATCH] smb: client: fix fiemap wild read on empty truncated response" failed to apply to 5.10-stable tree
To: suruurism@gmail.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:30:48 -0500
Message-ID: <2026110448-freemason-fetal-7d15@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x f5baa17a0f316c235d61623ac8e8fb32c2b3c0cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110448-freemason-fetal-7d15@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5baa17a0f316c235d61623ac8e8fb32c2b3c0cc Mon Sep 17 00:00:00 2001
From: Abdifatah Suruur <suruurism@gmail.com>
Date: Fri, 23 Oct 2026 14:52:46 +0300
Subject: [PATCH] smb: client: fix fiemap wild read on empty truncated response

smb3_fiemap() treats -E2BIG from SMB2_ioctl() as a truncated range blob
and loops for the next chunk. If the server reports
STATUS_BUFFER_OVERFLOW with OutputCount == 0, SMB2_ioctl() returns
-E2BIG with out_data == NULL and out_data_len == 0, and the existing
length checks accept the empty result. The loop then evaluates

	next = out_data[num - 1].file_offset + ...

with num == 0, reading 16 bytes before NULL.

Reject a truncated range blob that contains no range, so the resume
offset is never computed from an empty response. Also require the last
range in a truncated blob to advance the resume offset without
overflowing, and to stay within the requested range; a malicious or
broken server could otherwise make no progress or underflow len and loop
forever. Free the previous response buffer before retrying.

Reproduced on 6.6.87.2 with a malicious SMB2 server that answers
FSCTL_QUERY_ALLOCATED_RANGES with STATUS_BUFFER_OVERFLOW and
OutputCount == 0; an FS_IOC_FIEMAP ioctl on the mount oopses in
cifs_fiemap() with CR2 = fffffffffffffff8. The code path is unchanged
on mainline.

Fixes: 2f3ebaba13ce ("cifs: add fiemap support")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 20624f5dff9b..dc55cd512616 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4360,6 +4360,15 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
 		goto out;
 	}
 
+	/*
+	 * A truncated range blob must contain at least one range, otherwise
+	 * there is no offset to resume from and out_data is NULL.
+	 */
+	if (!last_blob && out_data_len == 0) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	num = out_data_len / sizeof(struct file_allocated_range_buffer);
 	for (i = 0; i < num; i++) {
 		flags = 0;
@@ -4380,10 +4389,25 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
 	}
 
 	if (!last_blob) {
-		next = le64_to_cpu(out_data[num - 1].file_offset) +
-		  le64_to_cpu(out_data[num - 1].length);
-		len = len - (next - start);
+		u64 last_start, last_len;
+
+		last_start = le64_to_cpu(out_data[num - 1].file_offset);
+		last_len = le64_to_cpu(out_data[num - 1].length);
+
+		if (check_add_overflow(last_start, last_len, &next) ||
+		    next <= start) {
+			rc = -EINVAL;
+			goto out;
+		}
+		if (next - start >= len) {
+			rc = 0;
+			goto out;
+		}
+
+		len -= next - start;
 		start = next;
+		kfree(out_data);
+		out_data = NULL;
 		goto again;
 	}
 

