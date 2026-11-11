Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411640;
	b=AMzMPVxmUObprPv0Vpsg7dvRxqpEaasUDqgknlf0eE2RLkaLTJpzWNis6yiKZfXSYRDa
	 kUwcrKdv3lTqjxelZY76dYpK0tt8GomMQt2BSIWiyKNBBXLRot+mAUda5YpMJW1kxTKia
	 0Pzc/yJGaYyQ311ebeCRMhjeh0QFMkYVpSzJI4M4FJldq1Drrv6pBHAgNrg9TFvUZ8Rwx
	 7JzTALzvvGJPM0jtc57WfIAoOekzBoKva26EoAhMAV8KQBjmrGspnDx7YbR3/5QajgoZJ
	 y8a+uoOYlS2WWIRGNTuVION+5smefZfz5PUa1l8XdUBNcBPhyooOp+W1RDbYS/C6g0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7psbhEe83ARPQGQMdJuc9eUmH52qRk1QiQuWpxhrKQ8=;
	b=TYtfTdYffTObiDvflVREulN9gwNdS10VRTHuYLXfgsxAAD3tmAbmCeh+ytpjPOZwSEUj
	 zdAg3q8O/i+RtXmFAIs4OoCsVnw+zQ40Ts4+bBuoHQOwwf5ijRA/ILFHoAK7omMBsYe62
	 OKPpPuFkSIfwMNIXMH5oJM/uV6dE176dIHRZGkROdocq1vU/JBqvSo7eZDiuSNAnEspOa
	 mD3EkJXI/PwcKhII38x5si+WteCOZxzh9fZXxdSjSGD/lJBw/VETd9GIPWG9+vogiw6BD
	 /IfkxoYkhQyEH3qmz3NFNpGSllFhkUiD9oR4H3hIl0BHtmv394V7bqN2V3pQgNJZD5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XuX3KTRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21C606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XuX3KTRj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9DE1F00A07;
	Wed, 11 Nov 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411639;
	bh=7psbhEe83ARPQGQMdJuc9eUmH52qRk1QiQuWpxhrKQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XuX3KTRjKdti7b+gKKWJ6bvOpBj5V8IocD1ZfJhojTW0FcSF88XagrP9CGXIi4awZ
	 nhixJ6u3VywO9m5LeWhfxEKYEYrDODFeujHVBphJ0jjuzNYsDpRckj/Ekb5Tj4NUdO
	 mZkPLcdS1ujQKBLI8n/rrHc+0TPTKwD60lcRnV3QAstKJ1Tty5qjJq0CF1Fbouh1gQ
	 8b5tjPBc8SaGIU1bdSyanaZ5kRS/GfMJGmsErwJRaTi9fa0deTIT/dzD0JvOHwAhGs
	 o2/SsDD/8KkmfdBtGfoJ6vDJ4ss951JdtzX3qs5sOXQT0TxjmfNfZJyVncSwrZu2Fy
	 05KPPucagtnzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] splice: avoid stale f_pos writeback on error
Date: Wed, 11 Nov 2026 10:40:36 -0500
Message-ID: <20261111154025.2714356-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111154025.2714356-1-sashal@kernel.org>
References: <20261107055657-failed-6.1-79b496ebe382@kernel.org>
 <20261111154025.2714356-1-sashal@kernel.org>
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
index ea92caf95a385..418c03d9b9f84 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1101,10 +1101,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
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
@@ -1121,10 +1121,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 
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

