Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794883163;
	b=FUBu4L7PPxXUwZ90nyDvYS2C0HB6HVM6ePBgZWB/hbjC+wTr1yYUg/EU5BTeiV+9r2O4
	 tBdlN2jyiIf4p8BBU03SoMo8UFi/egSuNSsnH7/pVMaGn03XrU25bJOg5rV//+y66SxSo
	 6xnrMjIGGN8LNHFNfjSUHbvftRY5Cxsm8/psLyqurAi57kTYn9s0YwDL4CkLSrneK8ipE
	 JUFUbTTX0ezibqpuKBZ1O1+syYk2G+VqNjS7nLeSqeOxMQAJQttUoGzjA5g6g63puxopG
	 805wYI//p9ACaOReJrYrDlpxXwWFD8ydNJ5a1WNKeM7be02yinQWZIsaq7Ldove2/fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VU3RfTLNpfs/n3MAsR8jkSfjakNJoajlPmMOjTMtrf0=;
	b=rReV51Ebq5FNuT5FQKrQvwFFJaV3O+/RaQtjWMEqmwNPVae4cU70aytswx0ZuHCwymtD
	 2YyrTx7iaZKrR/wNOF0I1Aeofb4x7pz4HKsSKrjzvasbOyZ64t4J19EvLi95o1A2AFIJH
	 4L9s6WeN06AdrQOP5U5ISWsJHA4fMhyueF2Y7hZK+kTsRhMdz8mvc+G4RviBuHBFeSM7N
	 5rZXWrsssYHiiV0ocgwPqoOunP+UNWZChb7sDfWb9sP46hF1mP6Igmg8eg6SuKHTpua1G
	 ngWMPewDms8RCQ6b9UjHFOZ3QIx131LqZxdLxzU5NuQQAPjcPv5qbi8Fa9nAN/9ePRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=W+1sDqUH;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A0606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F0A0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=W+1sDqUH
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b4d5e645d1so13591907b3.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794883162; x=1795487962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VU3RfTLNpfs/n3MAsR8jkSfjakNJoajlPmMOjTMtrf0=;
        b=W+1sDqUH8u3YPzkIDI6wFLBLurH2ysyw1bzTrxjAJmgZ+EnUMnn2iu60LCktKbyfvw
         IYL9SOTZSXOviDvvE/WWzlL9n+eTMMTqyDbf7pv/gIW0J1SKBPEMShw0KZl93EJU8OKH
         Dn5sGBiH9r/8xXzWUuExhW91ExzBBzAbEFyMK3zfCDDJj6ICSkE0KfdJeTgQmiYRMErf
         vUxomOjiDazJrb5dC++7nUwCtHZSMt10GQT9VY2F11xr034sr7ABUhx9XX0XfEWD7haq
         mvDoGF2lv4mxI7M09Sjn9UckB6Qny9wnEmCM1O53fi9A99JwUJ0wcXs50fe3r/4/TOUZ
         Sllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883162; x=1795487962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VU3RfTLNpfs/n3MAsR8jkSfjakNJoajlPmMOjTMtrf0=;
        b=QBuIcSMTQYllhe8o/+IlcYKkz5NBzDzr66igVGvpGUrvogdDHE4+Et6CCkPwFnOcQ8
         9/RSKuenD1OP2NyrKSc38wJ5SXOe8zQSoMI9p2Joogbt2vtUYzVdWgI+G8fZ25BkhGtx
         SDECjIL3ed6QW8ynPSy5b75JeJsil9Kgr5CYe/SI+tbZMtBcMAUafHFnjSvGd4hX+8UJ
         CTaewGnJRRy4vDPHc+//baq4AO8T8Nw1E2ykR4+FAXSwGvUIcbn6QrbNmNkRfvVGxHp0
         jZg1oqlglGybEyacRkNjBtMAAYwu2Ok/A1TM4+PwVVB2I50V2xSHrctGebOhZJNUjmZD
         zW2g==
X-Forwarded-Encrypted: i=1; AL+hErEJ9bR8PmMk2Xc5Bcggehguyy5xnEkISI37ItveFQvyt3b7hHPqJlrSnDYi3IG3Frl4kgPNbqE=@vger.kernel.org
X-Gm-Message-State: APuU4Z91b6h1IxVqsqq36z965xVuzj1H4bC0IgZP7HsmmOIprf89krUG
	Qw4LCaFC735PEhnh4Vxp/R2ZAsIApmLH/Ob9Q/rPUpnnQJ1cbSRhw0Bkffu1bpqkKrUF/qAg6T0
	ke15RfXwy
X-Gm-Gg: AZFdTZd3BFh/2c/bLVoRJhnBzsgjgXXnBJqQTTnjZRaeUK9nBKXxrJ/G7W58An/KH8o
	fgZNW+eEvb7uYw+wRyKuADqM6KRV9fkcOkj1Dp7mHVI0rM6aWKfSz8TUvVptsLoNgZEBLMVik12
	NmVSTWCDAIYaQB8K2AQIHwdUTcgzFPZP+Vdhjjpxrkx8mbWohZA4UOBHOJGPT0ISKhkwMjxePkS
	IXufo/cRPuBMWhquyRS0p++QUvpfBDA6/gLcs/YzrDmoeztvP9/QlJZK+KAxzWekYtpxQT2fjyP
	OFWfbt3+e2c8njD0Cvh+Ly4U07N5VbyTg58/zqvLq5JAWhQfmRj8QWfmrKkaqD0RiEau30rp0D5
	4X7WWWCtX94CeFqel0PHgJoztzDdJp7P+Hf6pGzTw6cSXpR6P3lFt3TsLw3rH4wNbRmpV7GMhAw
	VWV1Vc6ZSLKJZnVPO7mPumFZyvL/gHrtZP2HY9vCS2eUc/I1Ac2iU1QkMuCteriE21vvjjKW316
	zrR7SSXadcIJrN43JsaMnzGsNDl8Y3HSi65/OhupIjbj/emKWmgRDYhiUGelpId2GHx17nIdlWt
	wlSWAjfK2ars2bzuVXkvhX3oWYdpdb8AF1s5fRXBumDKESqf47Y9Hw==
X-Received: by 2002:a05:690c:e08a:b0:8b4:d882:4a14 with SMTP id 00721157ae682-8b4d882572bmr17276377b3.5.1794883161880;
        Mon, 16 Nov 2026 18:39:21 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec46a9d2sm13822747b3.45.2026.11.16.18.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 18:39:21 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix data loss when zeroing post-EOF data of a compressed file
Date: Mon, 16 Nov 2026 21:39:17 -0500
Message-ID: <20261117023917.1583819-1-hengyul@cs.unc.edu>
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
Content-Transfer-Encoding: 8bit

Commit 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending
file size") made do_zero_post_eof_page() zero the rest of the last
page with fill_zero() and write the page back when a file is extended.

However, fill_zero() does not decompress. When the page belongs to a
compressed cluster and is not in the page cache, it gets a page of
zeros, and the cluster is written back with that page. As of now,
extending a compressed file with write(), truncate() or fallocate()
replaces the data from the start of its last page to the old end of
the file with zeros.

The issue can be reproduced with:

    mkfs.f2fs -q -f -O extra_attr,compression /dev/vda
    mount -o compress_extension=txt,fsync_mode=strict /dev/vda /mnt
    yes | head -c 16000 > /mnt/a.txt
    sync; echo 3 > /proc/sys/vm/drop_caches
    echo end >> /mnt/a.txt
    sync; echo 3 > /proc/sys/vm/drop_caches
    tr -d 'y\n' < /mnt/a.txt | wc -c

Before commit 5eced87b7d19 ("f2fs: fix to zero post-EOF data when
extending file size"), the result is 3, the length of "end".

After that commit, the result is 3715. The file has 3712 zero bytes
before "end".

This patch will prepare the cluster as a write to it does, which
decompresses it, then zero the rest of the page and write the cluster
back.

Fixes: 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending file size")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Commit fda0c0dcefc2 ("f2fs: do f2fs_zero_post_eof_page for all the
time") in the dev branch drops the fsync_mode=strict condition. With
it, the commands above give the same result without that option.

Application impact (Ubuntu 26.04 user space): rsyslog 8.2512.0 appends
to syslog.log on a volume mounted with compress_extension=log,
fsync_mode=strict. It is started 16 times and gets 400 messages each
time; the volume is unmounted and mounted again in between. On v7.2,
the file has all 6400 messages. On v7.3, it has 6327 of them and 9620
zero bytes.

Tested on the dev branch with and without fsync_mode=strict: files
extended by write, truncate and fallocate keep their data, and rsyslog
keeps all 6400 messages.

 fs/f2fs/file.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05061254c3b2..59480c3ba2e8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -63,6 +63,33 @@ static int do_zero_post_eof_page(struct inode *inode, loff_t new_size)
 			return err;
 	}
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (f2fs_compressed_file(inode)) {
+		int log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
+		void *fsdata = NULL;
+		struct folio *folio;
+		struct page *page;
+		loff_t start;
+
+		/* a page of a compressed cluster must be decompressed first */
+		err = f2fs_prepare_compress_overwrite(inode, &page, index,
+						      &fsdata);
+		if (err < 0)
+			return err;
+		if (err) {
+			folio = page_folio(page);
+			folio_zero_range(folio,
+					 offset_in_folio(folio, old_size), len);
+			f2fs_compress_write_end(inode, fsdata, index, true);
+			start = round_down(old_size,
+					   1 << log_cluster_size << PAGE_SHIFT);
+			return filemap_write_and_wait_range(inode->i_mapping,
+							    start,
+							    old_size + len - 1);
+		}
+	}
+#endif
+
 	err = fill_zero(inode, index, offset, len);
 	if (err)
 		return err;

base-commit: 9b12299b437e0cc3ebf402e7b36a89cc69151238
-- 
2.53.0

