Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207911;
	b=umhCQEwK9lSqR2SKwTRsKciJf8LdJ4SsGwypiJK7j4pmmWsYo4upM5dFFrT4jBpL/uFn
	 pgwvq2iF/g9aPRxrNU9bIdDAOCyIbQ+5/4cFOP+9K6QNx1T8NR/zUhGeRP1YYSk/bFpQ2
	 ykzIVKR0uJcDkGJ0rDdsFeNfBuV+bFu8bQEXMIQ3PsocdtZmAGpTShfJ7y9Fqodra1FZc
	 38LXavw/CLApe7dsfYX6qtiDdBjTd/hqpqC4TjlRgYBD3R6UJTX6xmw9VEn70E6tlsKUh
	 6gheXDOCtP+o3V4AQNe+qObpAyvYX1HwVZQBge+1absb9gEw/Vu9C+KMv2UWKvxxWYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=eyUZ7G9iu0uZKAz8I4enYkWl7REhlZiOYtfQA4gLnsc=;
	b=192y+xXv7S2lI5xDZW68eLi+jkbwJ9R5ikoIeVqAQmk9Si2MCl99qe6JyrDke+IStEcz
	 qnAPP2GHtejrC/LAnO6fMvCi0FIIgztqDj337JhC65WCNj7qY+gQGCF0ZZ//6FrIQIp+S
	 N60Bp65j0UgyDfTLNUSpiXC9W/sVDZaM9PVsC82oXeaq4my9d6Jt0Q1udrKj/bEhJ8p0f
	 v02EqoKrgVVJi5bMDZxgWxGj7A04WxWLCNjAWeXoy/bIYfWPN378PZVgeycyFFa4/R9Y4
	 WyHB4IbFFIyGNvn2+bCkMTdtImOLz89EsO/76ZKW2GV1lnwEPPU6aMUEZ2HPVo4fIjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Z+JPX2uq;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EC606A6B1
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF4EC606A6B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Z+JPX2uq
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55d2dcbb905so6165851cf.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795207908; x=1795812708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eyUZ7G9iu0uZKAz8I4enYkWl7REhlZiOYtfQA4gLnsc=;
        b=Z+JPX2uqFgQUf2qBa5aPjGm8brVyUCVrt4Uvi45wDyt5e56O1uhY6dCBzRCKTJ67lj
         S61/2kSfShOdrcbRjiMN7jQb9H/uc0Asteuc4l/pNrQIGMJZcFeDty8MaUkX+vWHi6Qk
         a/fyDRAAHKzImSu8CTjVMSeaHezN254HfpvVzKICwA/6S0M8FcdEfTojNSRoQ+VdH1TY
         Hg0oEO+EfuKw+BmX2XRpFxTfUmkeTXJQILrLIOYb/XtbXSCZyUsNojew+0q+wTjTf+zD
         9mLtnNBfJUc6+7BM+NeMOjqS6Wuaadd0l2FBXYkUJah0GkSZjyBjy4vKnL3MCzky56cP
         iCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207908; x=1795812708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eyUZ7G9iu0uZKAz8I4enYkWl7REhlZiOYtfQA4gLnsc=;
        b=CWQk0rAHWreTk6YCUSyonpr7aXknz6m3EqIG7tp0slxLhsQD35rxlK3pC/tjtM50a0
         xJx/rAworQkoXcLpVgDtS5C8WzcJCF3RTdj4b4VNmw9FVHWWGyxRog4bA+f/6kTAIgOk
         elbTBnbkKOGqw8VuYgA3uIrPfWmL6aBnWc1xJFVZyePLdi2S59o42UeSQdirfL6oQJYu
         7ajVw0Q3c9P02RYhlLfuruVs/hmxUpxWwNGZtAZSkcH7pwHy4log+3pq63rKUX+mKMF4
         BMDoRqHKpxLDk1EvQ54g5lSQ4BRak2Lhd9xUFCvh2wowRQtbHTXE7ij9BT3q0pYYcPz5
         wvsw==
X-Forwarded-Encrypted: i=1; AL+hErEmcBeHwrxrFCnMyC0hqlCBc74B1dm5cc3o+XahLUUGe/qFB7SUcYACPnSpMYSrQqTxaHgIAPM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NGheW5xn01/P7SVwyuOX5Y+gkFA0Kym0tEwB24Kf7NboRAyr0
	T4OcVlj1DGSKW84TmTWQXlfdLnVzmZrmTQIgwgUYH/jNMdIOp1XwOekZpBnudJrPsPo=
X-Gm-Gg: AYBFou0sbQSieBVDUbWBZiLASOe2vtoebImHDAaLvzJTd1cznqn5jnBEF8GVBBgpRco
	5iWk81v5nIyF90crbwxwxKkux7zhKH7jC4yEERPbgZ35Z7f2Yn17b8pckfG0SHjoMU0h/azR+Ju
	XLAI0LD2RXnIvOpcuJcDLvPDYwTt+83W6aGjASIiOx8fe50XeTfhysV6oms0pHWFQRpZy8B6DPE
	aj3Wx7esHN1rPvygOi5VK9cq/lLA4O0zPjj0aenIKQ+3RP/ukH9BIMUpod4EMirm/+vItdaOQMc
	PirsBksUOTGFCqyGvoIOiuOZe9nu1O/61MHlcHYJG0MmBSMt9iLratVmRbmt29lQghaVENEQeSu
	fGrVZg4+Jfzqm/FsJ8dbAfOEJsi7fUsCtXgmALPB84/yy6pJJl+a2AHQsZ9S15bqZ4W8JSDtYlW
	PRM/CcwUKjf6/i6IEsSq0dcbeiqgo3uZjvP37+EAvk+b8ydDgSrPsi1xUjS4lS90N8mMwhGIrf/
	jCNGo6gllqmGmrH6Ip8Cg0gM8yl7g4ImQaQPlU4ETKzKa8QleX6oql4vvWeLDI9tnC19Pm+w2lO
	awrl0c/XwIWtURG0B38mkH9oM4iP3tsYjAeAKem7bBzeaUQ=
X-Received: by 2002:a05:622a:684d:10b0:55d:7c14:85aa with SMTP id d75a77b69052e-55d7c148660mr42515981cf.51.1795207907754;
        Fri, 20 Nov 2026 12:51:47 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d784517casm32269551cf.3.2026.11.20.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:47 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 20 Nov 2026 20:51:30 +0000
Subject: [PATCH v3 2/6] btrfs: clear dirty blocks after a delalloc failure
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
Message-Id: <20261120-b4-btrfs-data-integrity-v3-2-4de4b91b826e@toxicpanda.com>
References: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
In-Reply-To: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1795207902; l=1729;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=lfsEFhyOfftP+0hFE5S+FeSjbmCQrO4zPPBNoXWEW6o=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFtUlv0JwXDje5hCiQ4tr67g5MCERqnXG7hDBVQQQO/oSjgWiz+GtFA4bFxsNxd3z6def3tOsXI
 hhpioHWyGrQ4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

If writepage_delalloc() runs the first delalloc ranges of a folio and
then btrfs_run_delalloc_range() fails, the blocks that already got an
ordered extent are finished with an error through
btrfs_mark_ordered_io_finished(), but their dirty bits are left set. The
next writeback then submits blocks whose ordered extent is gone, or is
about to be completed a second time.

Fix by clearing the dirty bits and cycling the writeback state for those
blocks, as submit_write_sector() does for a block it fails to submit.

Fixes: 72dad8e377af ("btrfs: fix double accounting race when btrfs_run_delalloc_range() failed")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b2739838c646..036d8c0f04ae 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1746,6 +1746,14 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			u64 start = page_start + (start_bit << fs_info->sectorsize_bits);
 			u32 len = (end_bit - start_bit) << fs_info->sectorsize_bits;
 
+			/*
+			 * The blocks are not going to be submitted, so they
+			 * must not stay dirty. Otherwise they are written back
+			 * later without an ordered extent, or worse, with this
+			 * one if it is still around, and invalidating the folio
+			 * would account for them again.
+			 */
+			btrfs_folio_clamp_finish_io(fs_info, folio, start, len);
 			btrfs_mark_ordered_io_finished(inode, start, len, false);
 		}
 		return ret;

-- 
2.55.0

