Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795752549;
	b=q7ITvdcO+BmCLWcG4/wpV/nGCd5H0sQKa+H3SGEeKqfMf+uA93tZrJg6qhLK1/pg+eao
	 fp2lfXZAIqTr7SdsWjkF/h5nFA+VaaSK07K0darsC0OcGlxBJ4S13zcbCgdeToJwD4Kev
	 HQCzii5lMOxHcS1UsdRt1laME/9rashOmT7YyLFoyFamvmi65qDyiVPgArvmxVVIXqytE
	 1jLp84RFSBGuRu0l3SsJqgXI9uu+iHTkQfS4CPyaedRLhKDrZJUn4HJmgkXgHpUbk59bw
	 Ya/Fd1IRF5O5qFAzbfrJwYEvKLM9re5yNAmaQ0f8JNE4PY6z+RtD+yVWkr1i5OvBe3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795752549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HjpF0P5UyQ9nLom4QODoSUXMxsk2mmPrm0eKHuDGnBg=;
	b=QigB+ZwvXtBJbK63wzFOhAsygYg7Euhz5Gbdbt0/yKxcxNgKjfEDABQgppz8O4YhdMRg
	 Fz9WelDRysYuKe1AjrQB9i03DMo9vWFjPtgdHuI1Ya5mtiToYLt38Rmdf941xYTc7YBKJ
	 HtI6gD6QKodINyS5Cr1Dt+DhElIQ0p7aFk0YR14UYoojtZKMxVyrzL0/+498qQS1Pp9e7
	 13iUGt5fHOYSFRcgT0Nil5CD5rJPEnXy/qq9uQ4Y7tEAqshk4ldiKYTJ1MRTLhNjAgNTw
	 SyaTMhKY0RzoW3U2FUoIHAPiCPqqqR67i3ZZKlp25dv5sbYGCEA3rnFK60CAOpqMv0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZViEjrH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B3606A323;
	Fri, 27 Nov 2026 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZViEjrH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795752548;
	b=F8gkl5dz2zeGG5mwBRtAPBVa85fTWVoyJRHI6/kjMN2mRFJGSOr1eln+qVxZt94pT2cr
	 6XtgMgTy5ofpH152BbruRV+M8S4Ek3Hk9xoe6sO55xtG/859P8u7h1JQCpyeI32rKjhum
	 v33kRSGCxNHsI+xaeWm5zfZqyCyuqOSf6ZxtTOfMc7qqI9hLNQfIBF9Oo5aq1AdY9ji2F
	 bex3OtMDKFH8NgW4OyYsrWLr9DtDnI4ORXKHjh1YHdh4pVrma0ZGWryohNtLqiCvqqDTO
	 CSva5i5UUd07eqOgKx7DbDwE4ap7MiDbINwY36RFfbrA4+LWjVIWW/g0cwMgdDuzMEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795752548;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HjpF0P5UyQ9nLom4QODoSUXMxsk2mmPrm0eKHuDGnBg=;
	b=GMwVXg7wlL4Eks+yB+NQdw+OnNiSVw/T2CgJp3hzGK+F8dOAhgmxINHZEtjxZOAdR04m
	 kSx+TOkCWTZjeA5mkvmdKTbJavxKy/p61zfNd+8j45htAeGqMFkGJ8D88E2sCYB6/Mid1
	 uUUNqncOjkVfkbcRx2pPu1pHOY936TG7kU0xLa9ZL0+l5iYCXMXz3CEJ7JAY+Facv6wf0
	 EHwFct42tpeEt0F6aN/eMXpwSXV0yRT9bQNh1hpmkHXf5nJtJF/6EaJalhjeRkCk69YMo
	 II1q7aFNlqVIg701BfSb+cksKDOW3vxUewi1kgZqdt/AB0FLS3/YnWJco8K9Djhdagg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4A2AB1F00924;
	Fri, 27 Nov 2026 04:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795752548;
	bh=HjpF0P5UyQ9nLom4QODoSUXMxsk2mmPrm0eKHuDGnBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jZViEjrHv7dvOmMePsATDqUzpBYEctt0Ldy+QMYHQPLrNh83CcrUuaKNva7rTo50Z
	 ENdNGgZUwuetP2UKbzMBfyJGieqgzrjbGr/eHme5t/DydC4YaONuKfELSI+HbaGCNQ
	 yrQjOHtYew5wmW1jQyTmv6xHFg+Lxl1fEuD8EoC42AxS8x1uYlfg0SMdSQQn79EXky
	 RU+Rc1G/2uJhJ2BqKYPFc+8oi88yHm8E1mIDFwBt2WNfzK1CTnG79B50FZQgtaiQsx
	 wupuDgJw7nvmEmcpvf1SwEQrToINvLy15Eh1q0uP6epiEEpwrKteIBUpvqiYDXFEuV
	 KYO/V5A546rjg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D081C4B558;
	Fri, 27 Nov 2026 04:08:51 +0000 (UTC)
From: David Crawshaw via B4 Relay <devnull+david.exe.dev@kernel.org>
Date: Fri, 27 Nov 2026 04:08:39 +0000
Subject: [PATCH 1/2] fuse: update i_size before unlocking the EOF folio in
 write-through writes
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
Message-Id: <20261127-b4-fuse-wt-eof-v1-1-e055e2af652d@exe.dev>
References: <20261127-b4-fuse-wt-eof-v1-0-e055e2af652d@exe.dev>
In-Reply-To: <20261127-b4-fuse-wt-eof-v1-0-e055e2af652d@exe.dev>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Joanne Koong <joannelkoong@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: fuse-devel@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev, 
 David Crawshaw <david@exe.dev>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795752531; l=3912;
 i=david@exe.dev; s=20261127; h=from:subject:message-id;
 bh=aneCOpdxoK+BoX+KlAWJghFJrKt6ILqgZAIYQqmiW0I=;
 b=pZh3gDBUojjRGzwL5hg+aYbb26zpqEM71Wd+/shQt6BrHzKj9HuOjKvTby6mb6BA9RCczfdJ0
 lSNoakYmogFAEnBL4QI0J56eiQi7rzmRlhRFMuxLCktZNcYpBh3J7L4
X-Developer-Key: i=david@exe.dev; a=ed25519;
 pk=eQfKiR9S2peqiHuuNGCAaWlxwP+RerhKT2wVxakCrjQ=
X-Endpoint-Received: by B4 Relay for david@exe.dev/20261127 with
 auth_id=1661
X-Original-From: David Crawshaw <david@exe.dev>
Reply-To: david@exe.dev
Content-Transfer-Encoding: 7bit

From: David Crawshaw <david@exe.dev>

Since FUSE writeback was converted to iomap, a write-through write
that extends the file within the folio holding the current EOF can
lose its data if writeback of that folio starts while the FUSE_WRITE
request is in flight.

fuse_perform_write() copies the data into the page cache folio, unlocks
it in fuse_fill_write_pages(), sends FUSE_WRITE, and only updates
i_size after the reply has arrived.  If the folio is dirty, writeback
can lock it in between, and iomap_writeback_handle_eof() zeroes the
folio from the old i_size to its end.

Depending on timing:

 - the page cache is left with zeroes where the write's data should be,
 - the FUSE_WRITE request itself carries zeroes, as its pages are the
   page cache folios and are only copied when the server reads the
   request, so the server stores zeroes,
 - a later writeback of the zeroed folio overwrites the server data.

In each case the write returns success.  Before iomap, FUSE writeback
never modified the folio and cropped the request to i_size at send time,
so this window was harmless.  iomap, on the other hand, expects i_size
to cover the data in a folio before the folio is unlocked, as
iomap_write_iter() does for the writeback cache path.

Fix it the same way for write-through writes: keep a folio that
straddles i_size locked over the request when the write extends the
file within it and update i_size from fuse_send_write_pages() before
the folios are unlocked.

Reproducer: a thread repeatedly stores into the EOF page through a
shared mapping and calls sync_file_range(SYNC_FILE_RANGE_WRITE) on it,
while another thread pwrite()s a few bytes past EOF within that page;
with a server that delays FUSE_WRITE by 200us the data was lost in
493/500 runs (the selftest added in the next patch fails reliably), and in
0/3000 runs with this patch.

This patch written with an AI coding assistant (Shelley using Opus 5.5).
I reviewed and tested it.

Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: David Crawshaw <david@exe.dev>
---
 fs/fuse/file.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 993a1d2b315..ee3bdc3cb04 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1287,6 +1287,15 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	if (!err && ia->write.out.size > count)
 		err = -EIO;
 
+	/*
+	 * Extend i_size before unlocking the last folio, so that writeback
+	 * cannot see the newly written data beyond i_size and zero it.  See
+	 * fuse_fill_write_pages().
+	 */
+	if (!err)
+		fuse_write_update_attr(inode, pos + ia->write.out.size,
+				       ia->write.out.size);
+
 	for (i = 0; i < ap->num_folios; i++) {
 		struct folio *folio = ap->folios[i];
 
@@ -1305,6 +1314,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 {
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
+	loff_t isize = i_size_read(mapping->host);
 	size_t count = 0;
 	unsigned int num;
 	int err = 0;
@@ -1366,7 +1376,16 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (tmp == folio_size(folio))
 			iomap_folio_mark_uptodate(folio);
 
-		if (folio_test_uptodate(folio)) {
+		/*
+		 * Keep the folio locked until the reply if it is not uptodate,
+		 * or if it straddles i_size and this write extends the file
+		 * within it: writeback zeroes a folio beyond i_size
+		 * (iomap_writeback_handle_eof()), which would wipe the data
+		 * just copied, both in the page cache and in the request,
+		 * while i_size has not yet been updated.
+		 */
+		if (folio_test_uptodate(folio) &&
+		    !(folio_pos(folio) < isize && pos > isize)) {
 			folio_unlock(folio);
 		} else {
 			ia->write.folio_locked = true;

-- 
2.43.0


