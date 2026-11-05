Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901106;
	b=HtdqyvtNtXw9+XiEiAlJvC4W59R4Bsy/LY3hAOaPQmiKcAoR8ZapLbOqZUzBx/2oI7rx
	 CBpZl/FUya9ahty9lVPFlYMiRLxuvF4GeFULsVKWEUYnmjFolnhNqH+dnHI9hGBj0u4Te
	 Ivcc2PKrU0IRS4H/CKi4LArUxTTndg3kH9IduqPNYTj0TiipheQJZFn+wl+xn212uIa2+
	 kCeQQAE/Hf0QwOw37ZanvJlHwV2IwLh0Yidzz5Bne1+N/rjBguCzpOJi6gxbRNejd/ZxA
	 xDiiedx/tdfWld0P0WWMQX5vTyQZ7qqQ2e3txh9AjkwT3w6UGjCgas9L7tbagtqKAlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fhzy3KFyDdQSYQcQv9yXTQpFZz2nuIcDTt0lGpxe3/g=;
	b=3Tfm9e7r+v7FUo+gLpBaQDFPQ5sMOWL2O67QIeULEu1P0f0mD7WLtWagX1rFyRi+DB92
	 pdXt4Yk5s/wl3N7ZI9U7cyj0kx66bgB7GpQEDgyw5siUNYJoe9TcwCGv+9t/UwnJrxIjt
	 Nv/0maVFZLT+dR3SlL/H/bh95GD9Bi7MYb52GQHvpQnPA/8dOOiKPw5xLs5jwGLIa2wXA
	 OYb/b/FX5fwXIKuNCBKFtgcyiLt6SpSXPt5qgR18QgCKFPalU1RglUb+CRoH5NrlrFPB4
	 I9MOiDN4sbQs0xoVSxprJBt7bXBf4njPbgLFVtPApvwjxgrjyn/1bX+beD9O/U+tNVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGL2oH2C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F8606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGL2oH2C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1573B1F000C1;
	Thu,  5 Nov 2026 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901105;
	bh=Fhzy3KFyDdQSYQcQv9yXTQpFZz2nuIcDTt0lGpxe3/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nGL2oH2CVcATrDVDij5fG5rYPlJOUdlFZGoAqt4Qbtc2MoGu+RVp3LgJ2Zxv8OxYY
	 3BAUfDZbNO7fcOHw32VTqEGH8t/xhsSgns91pcJjGeRv9e/FUj5flaImrDin5yp9QH
	 BQUQFQrV9uEVqI6tFB9Zcq7Us/669xlLkVK7LsMrJD92863KHiPrI7eVf6XP7Ruwld
	 XoGBcS069sg0+q+hXmp4+2Hpy93rqYOjL8L+fJgcgrUyQQI7qkQKcuYfCpVhX9IPDg
	 5gZ7TsxnB2C7knPu8WLUkMmmxlPB1HQgPMq+0Iv4kODAhD32pVI2A16+D5x0L0pqJv
	 OD1VmW9IWISBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix fiemap wild read on empty truncated response
Date: Thu,  5 Nov 2026 12:51:43 -0500
Message-ID: <20261105175002.2263115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110448-freemason-fetal-7d15@gregkh>
References: <2026110448-freemason-fetal-7d15@gregkh>
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
index 2fe90bcc44b84..cf7c70a14730e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3915,6 +3915,15 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
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
@@ -3935,10 +3944,25 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
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

