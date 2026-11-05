Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900138;
	b=cwzDXQ1StxkVcP2nlwnYmpiXJ2KB/wfgFS8vXqI52VTP4HxKSSe3qrECBSaM98qiszPI
	 60LBefuX8yi3EFU+KuNIw/7wOqWCfDcc9rjejq7OjZsDNAn/GLvw7Ct9I7Yzq8pFWmPbv
	 vyEECPYgI7JPrRml2IHE5mmfGebh0WhSLzgyFM8I7RyAxcID8YPJOGc3e9TvW9k4mEU7d
	 DjbHMpFQ7QgwTQaUTbt3twQRMUO8hxy9esGWMFZyBgfLqmP+MCWFJZYr19EnZEtUjMPXu
	 Wop7CF7hVm3uHD5tpEYEx8SGMLDmS4PqIqeQ2D056hBfKTi/p4e7vYf8qR0j6ltiugQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900138;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4lQSMqVmiWYmpzZIwYz+8bZJ0vt71kWxHJIli9MDZcQ=;
	b=xs3XEyL4fLngxP+4FmepDO7+Je3j4/+gLGSk/COtrFpblN0wTka01pyLCArdTjrVY6Xk
	 vw28JhdZZgcFA5XqwQoUatgRSyLq9uu3Xf5tBMs+6Vn94LlYIi4Qimkd9ANYbSVv0ZvR/
	 YomyfAM3/+Qtqnz0wa8BzkkAkee9KdnXrfo43apUSAVDVI6OzE9DiKq65ShKGEOW/VztD
	 phria6Vi3kVFF350Tg/4cwvlEw+ifKDb/3Xx1vkvK3Ad8JnInWVEgHo5UIwf0zWYjvXg+
	 VvU+cfJY+LLJL7gWAEi3w1nFSuxNESEeGjiFJce+zb6AoRvuDDY5gdlVVu36AWBwLlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XjF9/TVE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F1606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjF9/TVE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563E21F000C1;
	Thu,  5 Nov 2026 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900137;
	bh=4lQSMqVmiWYmpzZIwYz+8bZJ0vt71kWxHJIli9MDZcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XjF9/TVECqjePMsgJqiUdFuKVsBERc6Wgz51QHGHJ3JcVcmJZdni1s44z4CP9OINt
	 jALXZt/6HEvg3xN7o3PQtpC5/0z1IPvEa84JUSJEw6/6yBxVCmc0GIThKTmJw0lKwY
	 OWAmxYJQfhTyad3KxMX79l795qwxnsUvFySVsLTA/rjxmpCqTkY7WxGQqHoPN/VSvP
	 pLX/AT/bkEZaz/YDeZd/z5xY6fjUOXjQtaNovBsXTIWbJLAXq9EBTfwlgEDQMSoAwT
	 dHyVPjL+O60pv17CokvG1Lm7FuQL5HZ79nG0PhkGJooI+I7rbe4/mcZsH4vSkRsHEu
	 zCMlzfN81tlWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix fiemap wild read on empty truncated response
Date: Thu,  5 Nov 2026 12:35:36 -0500
Message-ID: <20261105173453.2191544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110448-clunky-cupped-464c@gregkh>
References: <2026110448-clunky-cupped-464c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdifatah Suruur <suruurism@gmail.com>

[ Upstream commit f5baa17a0f316c235d61623ac8e8fb32c2b3c0cc ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 781fe599dda7e..f829a1a7291b3 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4167,6 +4167,15 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
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
@@ -4187,10 +4196,25 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
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
 
-- 
2.53.0

