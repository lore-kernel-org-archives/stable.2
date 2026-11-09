Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215732;
	b=OvoNzAiHYjKy2MgkkwTp9s7wsRUqLPQa2GVaqhMeM2hhJnx9STfDBm6LkZwW+rcaebVr
	 Tr6i0AYtwmsZNbDpxLnoz/TtLaMmT/+bovQFYFK5DDe+S7a8NWkUvzsZD/JBKFSuqFLZ/
	 Wus+sR3MQwiHq/OZMD9m12ulWyawPwI963mNaWVS7oZpGju5G0HExIeBV+WHixOjB1J0I
	 G5O6x1wovoCe66H9mw5s7h1Gq+HTqZvvtmi0T1oAp5igt2wbtSrI6uMVoCcOLQIHwIAuw
	 Q+uZgx+fS4VCYOYTD0yy7G4dyEPC8Gk+ReTuJR2agc+A3r9zQjEYbg1Iwqu/3AkIIgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nAZcXDlQZddbY3M/muInvcNY1JTv1MgI/C6goEt1No4=;
	b=ws2zW9vxp+qwJmvc5W2CYnmFpNdRZi0OE4pcFxo3DzK1XD+dyw4Rimf1lAv/5RC8n20w
	 kzAMl+blJcQGHq2+ND4AU914qPmpvrpL8rqPZadvFC/SJkrJkLsoVfPhnO4AHyfRWVBjV
	 /myktjjmy8r8aLN+iBTg788e45gkgVqHlVzkgSsRQZa6/PAzHh+SZjMpUCdT3thhlYbBf
	 x1MD2eWJtmHNwDV1oSwTt4SKUsRui+cDStgycHgZBHj5s55tIBOMQbUTNfW9ZdBReZq+B
	 uuC8eH9i+4fFKBBJ/Hmdai41yVMwod6FfVjuccyifle8gEvXo9tfnJp9iopnJOBjK/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EumOcsGU;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A8606EEA7
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F6A8606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EumOcsGU
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so740804c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794215731; x=1794820531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAZcXDlQZddbY3M/muInvcNY1JTv1MgI/C6goEt1No4=;
        b=EumOcsGUVgvV6f4EIH+ss1Yo0OuOX2Lpnk3VvwxNMWYoLWsAbpCyFZAEUxaiJGfm+c
         34QwvxyCf+23hcUVfaIHJDmgVm0XoqZiNbgTZ5TUn/mLejXnDp1MO+SgBB66yCsEUVKu
         96+aPOeNGOaR0Nn/W7Xzr1BvqfFtScUfIhDfa0P673LMDBqZ84oLuk1jSwSeDSwPQ7D3
         NC/jq2knesGuifhSLeY7+1mEf335ndDq28JT8tcAcHVCjf7hXuBq/547XOl502ngw1Cs
         W/FXfsvSERSAIeHHrTGkDnsbbVywHUyVCTv+57PhzoRpgj4x6/vHXC7xMJFkK5ROj0HX
         xQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215731; x=1794820531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAZcXDlQZddbY3M/muInvcNY1JTv1MgI/C6goEt1No4=;
        b=DgQOZpQbk5MZHTMJGo02QtOiC0W6uCLSaNi0PPqWvPwejpxGuq87MjqZ9Wb4nlmAW7
         Ks7NQ5Y3X5SKpsjfHgTsY21rpxwoG0J2oi8Ba2IawKZd9ivJyRkiw+OyVsgndEwBLOdk
         06LwexSldSMB8Sjfah3UygJ72CKoAwYjRsUqvp4rqgHMofl1sWk9lL72+xYCCye4dFC8
         wKCqvYFHM74XauOwE5mDua7cG4s50lY0JNymiGm6RylvLGcGP2StygwABzYNAZlaxDjO
         ua4tecHNSDuAz2gu3jfjmlMqUTR9tUnTAHPiMhBNYE45v9MFmbqrqWnq8vNifpctBDqI
         j5ew==
X-Forwarded-Encrypted: i=1; AL+hErF9MTc2WAL1P+M8d57nPIw2VhaawTF36wzhFK+j7p2x7XSIH7ZdQ/LCqUfzHN3H4ro+UlsywZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xwsC78Y3F1uluw8Dh9AW5AekLe4nzi+qLFUl57WFl1n05pNre
	40hEQ3I83JSdgd5YL151cfTOacOM06SSZe9BqN0m4nPC9FR9zr+U7/v5
X-Gm-Gg: AYBFou3x/c5waCYODTOb+U7LL2nBnNgxObReWYbFeJY1o+tP1Ie18oI/8qi4kAqGgbD
	wLc/hRg7eYRY/Jc2UbVIElfyGmoxWWiCDwoRq9BZ+MBy1NGfsWlKI4Sz273ciMMhd/QCk4gxp7N
	Y2sD7wHLFamALdBEjLJQ30ySObG3fuVLlMRXDjOKJKffbHU/xf58H3ilDbzHtytJ/CXY5kNcJld
	65CQCXABdxrthp9H46tzARlawKt/fHiTkCkFTPQoVRkLPBTQTsA+HVbYDAXswbY3wFSSXtVZ5IF
	VYYEJrvOK5Svftpa3Q2H/51+mlk+C0KuitjqulHi3VEpHX9Av7+0OuvkVN51Tu1f0SUwpKAP9TY
	ysZNpiDYiiCR03tSVjX/wNm2CUXpEgpMcGyBIvoFyvktjr0prm4JrHVQxuHhB0bb8+ZND8Tljv1
	tK19UusbwsLx2t3fTTYeqQ7327tjZmA8DixUTVx/vWtfchucIolJqJCN2TFc88fC9Z0Vj2uGBY7
	/qWEBPeHswwgawsQ9LsNRRfE3KRDvNVquazFy02KeD1UX5rniPKNJINZQnmIMYc1v4OOFeziN2p
	QTkyzZJ8gXmsdME74X/qc+ynKb0TC0gXXxMpCP8USOeuW66c8B+vIefiuYC/+BHNNw==
X-Received: by 2002:a05:7022:e803:b0:1ad:4ef5:ffed with SMTP id a92af1059eb24-1b39fefb9e8mr5783381c88.38.1794215730818;
        Mon, 09 Nov 2026 01:15:30 -0800 (PST)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([47.11.106.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375604109sm14379505c88.10.2026.11.09.01.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:15:30 -0800 (PST)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	fujunjie1@qq.com,
	vishal.moola@gmail.com,
	roman.gushchin@linux.dev,
	Trace <tracekotae@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/filemap: restart mmap readahead on sequential faults after many misses
Date: Mon,  9 Nov 2026 09:14:44 +0000
Message-ID: <20261109091444.128521-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105192517.228523-1-tracekotae@gmail.com>
References: <20261105192517.228523-1-tracekotae@gmail.com>
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

Since commit 9b0fcac3cfe7 ("mm/filemap: do not count FAULT_FLAG_TRIED
retries as mmap hits"), about a hundred sparse mmap faults push
mmap_miss over MMAP_LOTSAMISS and turn off mmap read-around, as
intended. But mmap_miss only comes down on hits on pages that
read-around brought in, and with read-around off there are none. A file
that is then read sequentially gets a synchronous single-page read for
every page until it is opened again.

When a miss above the limit is on the page right after the previous
miss, start readahead the way a sequential read() miss does, with
page_cache_sync_ra(), and keep mmap_miss at its cap so that hits on
that small first window do not bring back full read-around for random
access.

Tested in a KVM guest (x86_64, 2 vCPUs, 3 GiB) with ext4 on virtio-blk.
"base" is mm-hotfixes-unstable. "95b8e" is commit 95b8e432265f ("mm: use
zone lock guard in __offline_isolated_pages()"), the last one before the
series of 9b0fcac3cfe7. Commit 0b9c0aeba938 ("mm/filemap: count only the
faulting address as a mmap hit"), the first of that series, gives the
same results as 95b8e for the reproducer.

Reproducer from the report, read_ahead_kb 128, major faults:

                                         95b8e    base  patched
  sequential only                            1       1        1
  sparse pass, then sequential               1   16384        2
  sparse, MADV_SEQUENTIAL, sequential      512     512      512
  sparse, close and reopen, sequential       1       1        1

Touching 1% of the pages of a cold 20 GiB file, larger than memory,
MiB read from disk:

                       read_ahead_kb 128        read_ahead_kb 8192
                      95b8e  base patched     95b8e   base patched
  random               5656   215     215    344731   1032    1032
  stride 2053 pages    6545   216     216    419003    992     992
  random 2-page runs   2992   215     528    173093   1099    2248
  random 4-page runs   1570   216     594     86797   1266    2301

After the sparse pass, reading 32 regions of 2 MiB in turn takes 512
major faults per region on base and 2 with this patch.

Not tested: NFS, the GPU workload from the report, and other
architectures and page sizes.

An AI assistant (Claude) helped with the analysis and the approach, and
wrote the test programs and drafts of the comment and this changelog.
I reviewed, implemented, built and tested the change.

Fixes: 9b0fcac3cfe7 ("mm/filemap: do not count FAULT_FLAG_TRIED retries as mmap hits")
Reported-by: Trace <tracekotae@gmail.com>
Closes: https://lore.kernel.org/all/20261105192517.228523-1-tracekotae@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Gopal Malaviya <gopalmalaviya53@gmail.com>
---
Notes, not for the changelog:

- Keeping mmap_miss at its cap is the least obvious part. Without it,
  hits on each small window keep mmap_miss near the limit: random 4-page
  runs at read_ahead_kb 8192 read 25896 MiB instead of 2301. A cap of
  MMAP_LOTSAMISS * 2 gave the same results as the full cap in all tests,
  since each new run sets it again. The cost: a reader that jumps
  between sequential runs stays at 2 faults per region, where without
  the cap it is back to 1 after 16 regions.
- A full read-around on the adjacent miss instead of page_cache_sync_ra()
  also fixes the report, but random 2-page runs on a 2600 MiB file at
  read_ahead_kb 128 read 379 MiB instead of 76 (38 on base).
- At read_ahead_kb 8192, this guest's default, the reproducer shows 1
  fault for "sparse pass, then sequential" even on base: the 8 MiB
  windows reach the next sparse pages.
- Patched results matched within 1% over two runs (the 32-region test
  ran once). checkpatch is clean; mm/filemap.o builds without warnings
  with W=1 for x86_64 and i386.
- I can send the test programs if useful.

 mm/filemap.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 371a4bbd06..1548021472 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3398,9 +3398,27 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		/*
 		 * Do we miss much more than hit in this file? If so,
 		 * stop bothering with read-ahead. It will only hurt.
+		 *
+		 * But without read-around no hits are left to bring
+		 * mmap_miss down again, so a file that turns sequential
+		 * would stay without read-ahead. Remember where we missed,
+		 * and treat a miss on the next page like a sequential
+		 * read() miss: page_cache_sync_ra() starts with a small
+		 * window and only grows it while access stays sequential.
+		 * Keep mmap_miss at its limit, so that hits on that window
+		 * do not bring back full read-around for random access.
 		 */
-		if (mmap_miss > MMAP_LOTSAMISS)
+		if (mmap_miss > MMAP_LOTSAMISS) {
+			pgoff_t prev_index = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
+
+			ra->prev_pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
+			if (vmf->pgoff - prev_index != 1)
+				return fpin;
+			WRITE_ONCE(ra->mmap_miss, MMAP_LOTSAMISS * 10);
+			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+			page_cache_sync_ra(&ractl, 1);
 			return fpin;
+		}
 	}
 
 	if (force_thp_readahead) {

base-commit: 09f140d2cb078edfcd08a40a23ead0bdceea30a4
-- 
2.43.0

