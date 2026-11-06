Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793970893;
	b=MVrWGHkHR/TkJHvIM81AHbIX2onNzND1BNEGU+ovk3cRe1ArniiJqvdmr4luK3wrbtdA
	 7F530+iyfjTnJLIjlKiGZvds4t3rYbrG23TQ9AzhNUDLhToA/Ygn8VCUxZ7m2uL7YGM/u
	 hT2MDbxVTGuMvMKUIWSBTm4pmQtNDWWdcTSMPiBgZJRjaDIH0hvmrldA2uALmdsUXmur4
	 AFDBRb5PVhz/Mxi+lkHDRM8wPaHntMmpiP9KrqSFgMDBuuf18GcGk1pk2zGiTAj9FX5wb
	 NVUORZAJsMTEBcChtbz50QQ6jCsln9avvjg2C7VxvRR3UOMkjtq5svxxoC6nel8yt2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970893;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/CRMzZYyn/B4bVMs1J06QgSseyrMwQE3tkNJskd511I=;
	b=csCtuKtulVVxsBqGabubpxbz7bA7k+8u4RyTMuS553I5i2yPoDFcHaZJBrMOB0d6KvEJ
	 t+jot2U8wPZ6CBxXMfBifbhXvIR824z4K6WMxjVvWbKtIpAbh/H0K1eghCP+T6evYVERR
	 zdqdVtC4QZel+8Wge/epgElcroyga2Riryrbvy4Eqr3bw0T6/hmtBMbvx2MyZVfjDLrav
	 wihhSGhhCCixqcND0po3nMYdfSul++NbrZb27VqzUAQB2KopC+vDgGRfThup6zSLFxTXQ
	 TmMtF2ZUgWr2xswnZwelJJjHz/Nnh2ctx9OdWPaFPnp3o9aOJfq7sCNTYvQxVeb7zxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrc0ZDI6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0D606A32E;
	Fri,  6 Nov 2026 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrc0ZDI6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC401F008A1;
	Fri,  6 Nov 2026 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793970893;
	bh=/CRMzZYyn/B4bVMs1J06QgSseyrMwQE3tkNJskd511I=;
	h=From:Date:Subject:To:Cc;
	b=mrc0ZDI6FptHzOTzoAR1dixzdjZRcHma4QM984BQCGtUlAnyuKhmuLnQn2L/11QRi
	 MWWLstX6x4RMVwZax575V7cr5PULD+1pjz536CsbQKLkKlB3AWtCsCHYNhYuk+L0Ps
	 EGfbCE0JS7IVDlAw5rdYZ9vWK8AErK3HcZeZVZVX10i6fGkoFbnVMQ/5rPMt4zXwhd
	 Hf/OJhTns7n1JQtPtg5P/GfdysT8HQ3vyQWaQrtXu/6LPw6LLnNozYWcXf5sckzLwU
	 VOXpN7ROtwjPSJn6DexKMLxM0B3ta4+hK5F/SYFN0szbtsT4f2tQFhTGUbiHjvrWiL
	 gDf1pJ9tOwsZQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Nov 2026 14:14:35 +0100
Subject: [PATCH] fs: fix the SEEK_CUR f_lock condition
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-work-file-seek_f_lock-v1-1-5b9a6c2928d4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03MTQ7CIBCG4as0sxZSaEOiVzGmARws0oBh/Eua3
 l1GNy7fyTfPCoQ1IsGhW6HiM1IsuYXadeBnmy8o4rk16F4bpXojXqUmEeKCghDTFKal+CT8ENx
 +NGrQaoT2e6sY4vvrHk+/poe7or8zxgtnCYWrNvuZT8xKZuUfK3kE2/YBqQ6OxqYAAAA=
X-Change-ID: 20261106-work-file-seek_f_lock-c3fb94613214
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 stable@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=brauner@kernel.org;
 h=from:subject:message-id; bh=U2veAtMtI6xEELERchwEl5/0cnEe41ur7uX2eoDA0eA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9vXRi+e09vzfbi7f8Nz77Mu5KmH5EX8hczpp1sy+G5
 GswtO/W6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIQiXDP3NNppuHS3QLF0qu
 fWgTKH4u54j1R4ujW39Ndagr2iwX+YGRYbZj6sw45uKjVvyz566ZunHqf4Prt4KeZhee3DT/eGi
 VARcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Commit da06e3c51794 ("fs: don't needlessly acquire f_lock") wanted to
skip f_lock for SEEK_CUR on files that already serialize f_pos through
f_pos_lock, i.e. FMODE_ATOMIC_POS files and directories, and keep it
for everything else. The condition it added does the opposite:
file_seek_cur_needs_f_lock() returns false exactly for the files that
never take f_pos_lock and true for the ones that do.

So since v6.15 a SEEK_CUR on a shared block device or on a character
device that uses fixed_size_llseek() updates f_pos without any lock and
two concurrent calls can lose an update, while regular files and
directories pay for a spinlock they don't need.

Invert the condition.

Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Commit da06e3c51794 got the condition in file_seek_cur_needs_f_lock()
backwards. Regular files and directories still take f_lock on SEEK_CUR
while block devices and fixed_size_llseek() character devices, which
never take f_pos_lock, update f_pos unlocked since v6.15 and can lose
an update. It's a one-liner.
---
 fs/file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 4cd40dfa6129..fd08d34874ac 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1387,14 +1387,18 @@ static inline bool file_needs_f_pos_lock(struct file *file)
 
 bool file_seek_cur_needs_f_lock(struct file *file)
 {
-	if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_shared)
-		return false;
-
 	/*
+	 * Files that go through f_pos_lock when they are shared, i.e.
+	 * FMODE_ATOMIC_POS files and directories, don't need f_lock for a
+	 * SEEK_CUR. Everything else does, since nothing else serializes
+	 * the f_pos update.
+	 *
 	 * Note that we are not guaranteed to be called after fdget_pos() on
 	 * this file obj, in which case the caller is expected to provide the
 	 * appropriate locking.
 	 */
+	if ((file->f_mode & FMODE_ATOMIC_POS) || file->f_op->iterate_shared)
+		return false;
 
 	return true;
 }

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261106-work-file-seek_f_lock-c3fb94613214

