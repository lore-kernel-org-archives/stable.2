Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE63FDBE8
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497839; cv=none; b=Cz6MaVXJitkWioh3ukKr99iXTbjHFjKefFZfxvMpbMwRN6Ao6IX/nzOY1c5X+xRZRE87ervN7jy1Q4XPbOZWUmvjswOvRuPzVZLKeBmZWIa8dpb4lWy1my8KZY6RiJjfmJ+bP08khMST9ijKaf53YZmWwpxHn2dwzV5az/lxN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497839; c=relaxed/simple;
	bh=Oj25IJB1EhXY1iJ3DYP/sJ8UkLScHYkAgx1T3/4ZTW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy0tVMzWXh7pEvj9bKS/96SnF9AWz82J2BltQZ9OhCOEdL6Y40+zbBaY0R1/UqJhEqp9v3Oyp5R87c1KQ03QNy2nN4+i8xhs+1XhpUBvfDSAAB8NAi+5cixRKRK5SlCet8+KKr6f1sxtphhAPJ5L05EfMlY9Pv55EvzaQ2dhF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6LLEpzW; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6LLEpzW"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4ab70b882c5so455571b6e.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788497837; x=1789102637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gq4JZO0Ufc5OYUCssT+L7USN1zx0iAoj0bDiy0KQpoQ=;
        b=V6LLEpzWqyhJdjlbtjayh/IaOl4qp3mA+IaAS9l1uAj2b9mBnhatFMKd+9Q0cMY6BO
         ypljvUeK7VD1koFJQrqB2NVCuQmRNhEZ8HFLaq7jlt25aAh5DSoB/1rT1AtEWH0yvnnZ
         XFy6dczghktNtpgK9FY6UEEPfiH5N+7fFjr0CqCq5TMFP6GOEzmi3JrayCUK7k2CHFiA
         1ysahA+3hwubEOPnRk0zwWwBZqu0mcIV5qa1/Of6RRKTPni/iKqdcPOJmjJZmPXa0RCw
         eXiOBbQZuPnoh6wT+qoWsWs6R1a9ft4RbRepVejWFS2/1iyPXQe7peqzVvI+jZWxCmUC
         cepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788497837; x=1789102637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gq4JZO0Ufc5OYUCssT+L7USN1zx0iAoj0bDiy0KQpoQ=;
        b=V1ubf4oXd6IGoDqUNl35ULDcRmILamfPrZdnwfidZOG8ZCdIQ4339/JLwtKqAu53Tg
         EV1HpHWtIdQ0Pflf3tHV/j4IvvdbbKK6555XzBsrY4q9zojML/OCaj+ASsTTi5Xjr0ek
         lUYHtEQ1tQq9xE2HT0ezlf1uRqOjp/N2oAo5kStuABJFNFB5QE/RoUtbEQruEt99ZEzv
         9cksUm09lpIsY8gEjeQRfn8cBktjfcHNOoGrTkelfvghDPF296bB9wYiPVagXKjs7I5o
         d3LC3/nDSM5b+tCzDkCtvV2b0gbzB5kqtnWDi4NT7K5eMFPKgL4inb51mQqRSUbtMN1B
         DrSg==
X-Forwarded-Encrypted: i=1; AKwUvBzbXvptiIAa4tVs/RsZKCpEP7dtQ0IAN2/pF20q0kWy8E2RaseWeOtpmefiu9qQvETBO+zwGYI=@vger.kernel.org
X-Gm-Message-State: AFuF++mWojHH5HNbPSqR9x7PAyL5eHV9IXC6NyGCW6RQ0h71QdG2qjHl
	WIIec5M+SZIoOqPBndSeUeLnlLcN9DzK0WxX5K2Lx0AiJntzL1O0YUeF
X-Gm-Gg: AYBFou0Ir7hMtHcmnfDVel/4nhsdNpmDLBPGZCBCJdR1d2sJRzjquVwLZ/shIGYNG5M
	gNJNT3Ts3BK2lnBIYDTVrZJ9QQnwNSrydAdd+CPb9LfN/5DEWbf8VxxhMt2CP/1d3fZ5rxU3cCo
	Xe5g/eUeBX32IJfGvCjjOztqCBmUJgvnhYsUfLTK8NoHnKUMpayDGp/Nkyl5GHP8mFPmBn4i+y/
	Cgsc81cE8NMlNmqolL/GwevPnaj77JKRC6ghejuIk/t7aFcTK8lezxaCMcOEF9ojI1+42vokA7W
	8o2Xcb7Jas4Fo64n941pOdluJEwFTyjfiDjsXkFjIeDecUJ6bvIhKeUdHMFUluYZe/Z4VAvklG0
	+1T8XmsvvVguCn3RZ8gQtA0zMhmb7AMcOd9uoaQwEY9eiPnPGuA/4EL58FKF4q4Vmf89dS8Z6qg
	H4sgxJs2261ohpcGN2eSmRVLqiPHFCuWNm8WVcTmRIwj9opOXev7Cq5eHYzMUBsEGExqKYvvmku
	IRgQyF5ka4r3gOAc943vV7wCk8aCyLj6FCMqzg0
X-Received: by 2002:a05:6808:1393:b0:4b9:a8ac:478 with SMTP id 5614622812f47-4b9a8bb6ae9mr1124101b6e.22.1788497836729;
        Thu, 03 Sep 2026 21:57:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971b97c72sm1376123b6e.15.2026.09.03.21.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 21:57:15 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] fuse: don't shorten the folio descriptor at LLONG_MAX
Date: Thu,  3 Sep 2026 21:56:50 -0700
Message-ID: <20260904045651.1442505-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260904045651.1442505-1-joannelkoong@gmail.com>
References: <20260904045651.1442505-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_send_readpages() and fuse_do_readfolio() both decrement the folio
descriptor length when handling the overflow case where a read would
exceed LLONG_MAX after incrementing the file position by the number of
bytes that need to be read in.

Shortening it is unnecessary (and for the virtio-fs paths, a bug), and
with fuse using iomap for handling reads, shortening it is buggy.

For fuse_send_readpages(), ap->descs[] is also what fuse_readpages_end()
reports back to iomap_finish_folio_read(). iomap accounted the full
length when the range was submitted, so the lengths reported on
completion have to add up to what was submitted. Reporting one byte less
leaves ifs->read_bytes_pending nonzero, folio_end_read() is never called,
and the folio stays locked.

This is currently reachable on fuseblk mounts configured with block
sizes smaller than the page size.

Fix this by leaving the descriptor length untouched. The reply will then
be one byte shorter than what the descriptor lengths add up to, and the
last byte will be zeroed in fuse_copy_folios().

This also fixes a bug in virtio-fs that existed before any iomap changes
were added to fuse. For virtio-fs, data there arrives by DMA rather than
through fuse_copy_folios(), so the only zeroing is in
virtio_fs_request_complete(), which compares the reply size against the
descriptor length. With the descriptor length shortened, the two are
equal and nothing gets zeroed, which means the unrequested byte is left
holding whatever was in the folio, when the folio is marked uptodate.
This is both in the fuse_do_readfolio() and fuse_send_readpages() paths.
This dates back to commit 2f1398291bf3 ("fuse: don't overflow LLONG_MAX
with end offset").

Fixes: 4ea907108a5c ("fuse: use iomap for readahead")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4bdf5dec2cb9..3bf7cb590538 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -864,18 +864,29 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
 
 	attr_ver = fuse_get_attr_version(fm->fc);
 
-	/* Don't overflow end offset */
-	if (pos + (desc.length - 1) == LLONG_MAX)
-		desc.length--;
+	/*
+	 * Don't overflow end offset.
+	 *
+	 * Ask the server for len - 1 bytes. desc.length still holds the full
+	 * length. When the reply comes back, it will be one byte shorter than
+	 * desc.length and fuse_copy_folios() will zero that last byte.
+	 *
+	 * For this reason, desc.length must not be decremented too. The caller
+	 * reports the full length to iomap_finish_folio_read(), which marks
+	 * every block it covers uptodate. Shortening the descriptor would
+	 * suppress zeroing and leave the last byte holding stale data.
+	 */
+	if (pos + (len - 1) == LLONG_MAX)
+		len--;
 
-	fuse_read_args_fill(&ia, file, pos, desc.length, FUSE_READ);
+	fuse_read_args_fill(&ia, file, pos, len, FUSE_READ);
 	res = fuse_simple_request(fm, &ia.ap.args);
 	if (res < 0)
 		return res;
 	/*
 	 * Short read means EOF.  If file size is larger, truncate it
 	 */
-	if (res < desc.length)
+	if (res < len)
 		fuse_short_read(inode, attr_ver, res, &ia.ap);
 
 	return 0;
@@ -1068,11 +1079,20 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 	ap->args.page_zeroing = true;
 	ap->args.page_replace = true;
 
-	/* Don't overflow end offset */
-	if (pos + (count - 1) == LLONG_MAX) {
+	/*
+	 * Don't overflow end offset.
+	 *
+	 * Ask the server for count - 1 bytes. The reply is then one byte
+	 * shorter than what the descriptor lengths add up to, so
+	 * fuse_copy_folios() zeroes the last byte when it walks the folios.
+	 *
+	 * ap->descs[] must not be decremented here. It is what
+	 * fuse_readpages_end() reports back to iomap_finish_folio_read(), and
+	 * iomap has already accounted the full descriptor length, so shortening
+	 * it would leave ifs->read_bytes_pending nonzero and the folio locked.
+	 */
+	if (pos + (count - 1) == LLONG_MAX)
 		count--;
-		ap->descs[ap->num_folios - 1].length--;
-	}
 	WARN_ON((loff_t) (pos + count) < 0);
 
 	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
-- 
2.52.0

