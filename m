Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046669;
	b=xGElSW//4/tu5V1bCBlMFvSLOuPv8AFqop1QUbztBD10cuB+CK5QpZ2+JMzVg0BMeNF4
	 tvH1oaRSiJGaI4oSPPzX56nCsZo3/XFusvDmQhRgYI7SWYbVjxOJ5+B27aim4pGP7TU98
	 IVjdZ2IStUVoiwJUo86SfV3a+6iBBwJn6tlqcv9O7BNl1etTkDwKsPKjF9mhy+TI6vlL8
	 BOq6wgCBR+FPwN8l0Ff+E783QTQDxLP5JZGX1AHI7cefsc5M3t1Ip+YRY9/pgWAfITfq6
	 dVeF9yXk03DYB7C60kne2Nzxk4sVms3XWQfG0Np/9C+Bj7p2/FSPgTOm6p+vD2lR0cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BYpWcL3mfEhj0SNqyPAaCDFxMo8HQS5G4AcEQTj1PNo=;
	b=KxajZ4hFhotxaIrTsDdMEsOviM6hsYUAkp6s0P+O0UPbX/u1QMPnYFO/JySzSqC2ubod
	 554o/w/Fkm8wbzbro7DCIiqatgjE/NlUbqTNu4yBStCniQFz4xs7oSuww3RP2JJUCx1go
	 ceri61r4chDdvTHHE+J5kozANGs462x01ikNddNSe/oePeDcdAuYgg875d2ML29hIYxea
	 fLNbm5Y5eUXFcRvk+McbJFWzCulaadFLlLEe7v8EO7iZCRY3xqKN/DhOmK/dcN3MQV1Xs
	 /JWqFbzUlOBpryhwYdFuSHGUF/lqP0m70nm2ChzIJpHZcGB484XeBpLMFbHzKS9FkTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BZbN/INu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D7606D807
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZbN/INu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3AE1F008A5;
	Sat,  7 Nov 2026 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046669;
	bh=BYpWcL3mfEhj0SNqyPAaCDFxMo8HQS5G4AcEQTj1PNo=;
	h=From:To:Cc:Subject:Date;
	b=BZbN/INugYgEjswi/kR8BoIVgGs/FUsg1AmNdt7AyEsDjZydpvnDSAWFFVEWWKH9Q
	 OisGP13ariNnFPpf09WkR3PACdC8V6uXmNZmlapOpQHsvggBda8Q3OFL0Cec9wW5eH
	 AMwjtHGFAuMT9HC5LUZkejajrIcFWMnYxI3Fyzeha2y6/KEJjGfCSStZsFVrf0hORn
	 trxb/0fj+Z5Jr/tBKPyRiiBldZWSNjo/083Mw3yGgtAIb0XOqie5jqzNzUDCS/prOP
	 /uEPJ/HjrJmXFe1xbG5lTYx2ekOU7xUl5MOiTb7m9WqU4VDnS95APf7OEhhznMUQsP
	 46R2sX7Uc2rHA==
From: Sasha Levin <sashal@kernel.org>
To: joannelkoong@gmail.com,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fuse: don't drop destination page cache on a zero byte copy reply" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:47 -0500
Message-ID: <20261107051747-failed-6.12-f7585e1ce341@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f7585e1ce3418ec282485854b3d8d31c6a961e37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051747-failed-6.12-f7585e1ce341@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f7585e1ce3418ec282485854b3d8d31c6a961e37 Mon Sep 17 00:00:00 2001
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 15 Sep 2026 16:53:41 -0700
Subject: [PATCH] fuse: don't drop destination page cache on a zero byte copy
 reply

__fuse_copy_file_range() clears the destination page cache after the
server replies:

	truncate_inode_pages_range(inode_out->i_mapping,
				   ALIGN_DOWN(pos_out, PAGE_SIZE),
				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);

A server may legitimately reply that it copied nothing, eg if the source
file turns out to be shorter than the size the kernel has cached for it.

If pos_out is 0 as well, the end of the range is ALIGN(0, PAGE_SIZE) - 1,
which is -1. lend is a uoff_t and truncate_inode_pages_range() takes -1
as its end of file sentinel, so rather than clearing nothing it drops
every folio in the destination mapping.

That is not only a cache drop. truncate_cleanup_folio() calls
folio_cancel_dirty(), and fuse_writeback_range() only wrote back
[pos_out, pos_out + len - 1], so dirty data elsewhere in the destination
file is discarded without ever reaching the server.

Skip the call when the server copied nothing, since there is nothing
stale to clear in that case.

Fixes: 9b46418c40fe ("fuse: copy_file_range should truncate cache")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3bf7cb5905385..2aa575a02e054 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3062,9 +3062,11 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		goto out;
 	}
 
-	truncate_inode_pages_range(inode_out->i_mapping,
-				   ALIGN_DOWN(pos_out, PAGE_SIZE),
-				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
+	if (bytes_copied)
+		truncate_inode_pages_range(inode_out->i_mapping,
+					   ALIGN_DOWN(pos_out, PAGE_SIZE),
+					   ALIGN(pos_out + bytes_copied,
+						 PAGE_SIZE) - 1);
 
 	file_update_time(file_out);
 	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);
-- 
2.53.0




