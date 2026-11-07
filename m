Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050719;
	b=szQqBtnLDQk3GmHzBbPNpJRSDp0SLthGpAvPsIgoLnINDosSWK75Tor7A3KLgAV0CeaL
	 Rn2rko8hOagjWP8W6fg7+BjWFEG9LjVf+9956SV7/EENL6plCtaozkQsy6UG6m6hqLkLo
	 YF5XW9veDxkl/dre4VX6m5DEfE4cJVZ1DxHOHJX6+m6KfcUkW12N7j/h2Si6gVPYEXVjU
	 pfokt5Q0htAI1Kz2uKn1/hF1qt2s8Hx1J4XzFRi6DlNCpy/NPiH68KCyB7+t4o7Z/B+dY
	 ZLeR5CT7/3rgtpua2F6pwa3qTTCRBa42puO66kiXvdXokNBbA/3vSPfAFM7Azk7lF+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050719;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=c6LYy4ZF8Vma5ApmtbpLyBVQNOghwVj2THva1RTL++4=;
	b=G/g0o/QetpkLQNyQK4ns7Ggs++jtCwW3whX81UEaRKnYiM6/zJbAfs9MsqdxUsNSV9Zr
	 IGUKh1IEJjXQpTG89wyfTocLoXsIXs/dzKThyrtpDWdNQEgP3gHyYzmNE7/TXB5WkgxXb
	 N8RvdEVSBOGlapnReySm9txAPrrWYfvm730wBuXoDz3egsWFbtyE4aqpwXRdOsu2DVNru
	 V+AVrLebvCYrCJIW2GAWe26OUkRYosxStnR8I5a1tgk5FomiO+q4WwH7ViXa9scA0LCwA
	 eRYCC5Pao18jRISCk0GoYBXm/AUHm2qui9PFA7CIzhJxD6HIhdpqpawmAr3Nhk6QQJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0VjH1kv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0VjH1kv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113711F0089F;
	Sat,  7 Nov 2026 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050718;
	bh=c6LYy4ZF8Vma5ApmtbpLyBVQNOghwVj2THva1RTL++4=;
	h=From:To:Cc:Subject:Date;
	b=Y0VjH1kvNcxM/bOxnnGlxqI5D2FXwezMPH9DSJXf/wtzhBJBHGYnWQOAP+H7HqPBc
	 ywmBTZvHDPF7FjnDqqpBSwcMCJESk9kzBW42XR2SgyivhtRqTZFlZJNff4rfJgXu63
	 wjh7fVq5UTtvWV4Wh4hPHdGyXQQmLjnvwWi4Tf11HEZn0670E2246NS5M6QKxu7Xtw
	 HURirW5yfrMWD/oAewpSdFhlwAL4POp2zzdSmVzbTAsUrAvhkT+QciRLLOR6fOyRd4
	 KOCg3a3NWIjhSWea8Qpf4Guh6IZKLgxYrgtGclKt7wkysSuVTDn04R0SqbEFeVqQ2V
	 CkGQVpz5Mexfg==
From: Sasha Levin <sashal@kernel.org>
To: jsjlee1020@gmail.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix submit accounting for IPU writeback" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:25:16 -0500
Message-ID: <20261107062516-failed-5.10-6d1f622b9c06@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6d1f622b9c069378cdb83088be2b15a9b480b8a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062516-failed-5.10-6d1f622b9c06@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6d1f622b9c069378cdb83088be2b15a9b480b8a3 Mon Sep 17 00:00:00 2001
From: Seongjae Jeong <jsjlee1020@gmail.com>
Date: Wed, 14 Oct 2026 11:26:29 +0000
Subject: [PATCH] f2fs: fix submit accounting for IPU writeback

f2fs_write_cache_pages() uses the submitted count, which is set to
fio.submitted in f2fs_write_single_data_page(), to update nwritten
and decrement wbc->nr_to_write.

In the OPU path, f2fs_submit_page_write() sets fio->submitted to 1.
However, in the IPU path, fio->submitted is never set and remains zero.
As a result, successful IPU writes are not accounted for.
This can cause asynchronous writeback to continue beyond its budget.

Set fio->submitted in f2fs_inplace_write_data() after a page is
successfully merged into a bio or submitted, so that successful
IPU writes are included in the writeback accounting.

Cc: stable@kernel.org
Fixes: d68f735b3bc9 ("f2fs: check io submission more precisely")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f6e1cb1c0b71d..92c3f255ea8fa 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4292,6 +4292,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	else
 		err = f2fs_submit_page_bio(fio);
 	if (!err) {
+		fio->submitted = 1;
 		f2fs_update_device_state(fio->sbi, fio->ino,
 						fio->new_blkaddr, 1);
 		f2fs_update_iostat(fio->sbi, fio_inode(fio),
-- 
2.53.0




