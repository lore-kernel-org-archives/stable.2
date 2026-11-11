Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414001;
	b=dpu0PvZEmy7m3itWdupuOMnBjR19/O2JjiHGvXhH1mMVGruIUNbtn96O0PMW7gwM2Bk2
	 FG6FapBv9BTfQWKUsq1APHzoehbIAiV6E7CF93P4UyAZu7yjZ9+xmQ0zut7+r4rPXGBZ+
	 a4robxyE6mWD7QCfbMG9hsRntVvfjhM64UfwEHTceZFWhgxY2TF/tmxw2/Uw4LTYv0+kr
	 dhUDhQcJ8Oy8NtCIaJLZQ8t7isgl9ZWps0419zLuhrIWKx+p7Ca3RlqKb8DhH5cnhSeqg
	 6pmb7yO3t582otHvlH9+KmzprLkyvOVfqnX9i0XZRl+F1ZX149UKSwL59bK6cMhYNDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414001;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=81afY1w5fT54XaQnuizvBfCDI0iM1Cx6D8T2kIBJtXA=;
	b=xQ7durI+NimWIusTz+cJDvCCrNjMiYA/Vm0DzrP8QcbvfyDAomTW6BFsWoHKD4jrEYKF
	 IPkxKVsn8loSWTLUt0/PluscVr7AAfArYsJVVRdEa8l4fmX58dz+R6q4ahk1+o1phYk4g
	 LlTnWZtLySTBJOSJVWUSF3+TVfVqRaJAiWHQ3fHakgxzWD8iCE+a1POXRUaG3AsmZ79Ne
	 bGY8hHGZ4RMgtHRr0WjG7ksGNRMOAAVuC9cEGf5s4HbwFWBkEN0VqX3pTyL8QoXT3c9ru
	 YYSAOwOb8lI3m8CeNEYbngnuh1KqKBnqZG4Wox70esXhRFUbcShdeyf94goh3o1eOjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/Hsx855";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE660A263C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/Hsx855
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A436F1F00A0C;
	Wed, 11 Nov 2026 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414001;
	bh=81afY1w5fT54XaQnuizvBfCDI0iM1Cx6D8T2kIBJtXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/Hsx855mIUDYupEf37LVaMpeYmLvop5jc3wRL6zTJA+pW6bHTUawNjIFQsXV/HPI
	 kCYs0goJ7Nd4y0a2dZWOMMjp5xChz2Om9KlI6h6D3G15Y1UUtizNK2GGeFF3Un7+hn
	 jWou8mLgz9hLzz2G+2mp4D/+cGvYOED8QRg+ILaGG4hwBKMIQ2cIRBdMT/H0JwtWOR
	 F/iGxKBHLgMjJXSLsOvzk8/rtgImjhN2FpDfb+Spxji/8IzLyPrJLt3oiZRvBtPfnB
	 xhbQFmuHrvV9QCD9HncnX7evqZsG/mcaZofhng7UmWQIXFrH2IQ+lpIRKedDVcvhLB
	 gJWDM6RG0+ByQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] splice: avoid stale f_pos writeback on error
Date: Wed, 11 Nov 2026 11:19:56 -0500
Message-ID: <20261111161949.3187571-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161949.3187571-1-sashal@kernel.org>
References: <20261107063106-failed-5.10-79b496ebe382@kernel.org>
 <20261111161949.3187571-1-sashal@kernel.org>
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

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit 79b496ebe382866e3a05090b7dc9ae95e85e65b2 ]

do_splice() snapshots an implicit file position before calling the splice
helper. Since splice does not take f_pos_lock, another operation on the
same open file description can update f_pos while the helper is blocked.
If the helper then fails, the unconditional writeback restores the stale
snapshot.

For a directory without ->splice_read, a file-to-pipe splice fails with
-EINVAL. A concurrent directory mutation and getdents() call can advance
f_pos and refresh the filesystem's revalidation cookie before that failure
restores only the old position. The next ext2 readdir can then trust an
offset inside a directory entry and copy data from the adjacent page to
userspace.

Only update an implicit file position when splice returns a non-negative
result, matching read and write. Keep explicit offset updates unchanged.

Fixes: 7995bd287134 ("splice: don't pass the address of ->f_pos to methods")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Link: https://patch.msgid.link/20261018051708.2422394-1-4ncienth@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index a11d5ab38ca63..300302969fb34 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1078,10 +1078,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		ret = do_splice_from(ipipe, out, &offset, len, flags);
 		file_end_write(out);
 
-		if (!off_out)
-			out->f_pos = offset;
-		else
+		if (off_out)
 			*off_out = offset;
+		else if (ret >= 0)
+			out->f_pos = offset;
 	} else if (opipe) {
 		if (off_out)
 			return -ESPIPE;
@@ -1098,10 +1098,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 
 		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
 
-		if (!off_in)
-			in->f_pos = offset;
-		else
+		if (off_in)
 			*off_in = offset;
+		else if (ret >= 0)
+			in->f_pos = offset;
 	} else {
 		ret = -EINVAL;
 	}
-- 
2.53.0

