Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629595;
	b=H7I6d5owrda1Qy+iHiKivPrlPdqgjeGydFw7/GbaLiZhmgisqTOvba753JveEAgHXiji
	 Zvat+hQZfMfAGq4/5ONi32TFKfnkL5tOfc/0S1sHDqOYBS5sAGL/zRcAVfyQQVfXkN4mu
	 jENSFEkzQlTvGB6NifA5zn5cvyTm6w/TkDU/5mjFCQc3gOtBJ/OWKzFtZ3i7zhaV19Ivo
	 wFoG3o6AFe8RRQhWBEFLkPndI0EUHLOR7F7jF2sj0UfYVNQwDiy75ckfBwCeNmrE/X/TR
	 kI+4t4YKbO9gnrENssX1meddHv02qByNpCZgTV6yEiwA9XG2wuhTU3Ud1ZyADrfqJvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629595;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iMNo6tuAe7SaitdPCFPKfii/XrdfXH0XRtnp+xEhqig=;
	b=kkEjwUNRR03pBZzJhJZPwz4npAaImfjIp7gYu5vDD4mN0wJsjUqGJ0AAjjGkkDmxU0SU
	 ZS9uyl11XSAVR8IkeRstqPuE3mETIBvk2OtyN1jokCjjRNxnQhfLs2IgL47L9PyBBgHVp
	 a+ZRn4q8iHAtqIzW33BuPcHeJNr7DKoFjFi2n4g37VLr+SDFxHp54v8ErP2zD9tJpCizS
	 RnYlJMGCL4OPel7ynH5FfoPl1JzCcxMbawxplFKqolho0Lo1HwqOGNrU7Vy/SGtieyFrs
	 LBWLBcJRixJMj5EEWxdY2XlxVNz42NGzDxhkuPOXipdom9A8MpdM5iN0SlCL9CVscIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcElcqCP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E8606A331
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcElcqCP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E9A1F000C4;
	Sat, 14 Nov 2026 04:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629595;
	bh=iMNo6tuAe7SaitdPCFPKfii/XrdfXH0XRtnp+xEhqig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lcElcqCP+iVD5alX8GlK9xbmt8+7kYnxFsg6LzGiQxgBkXITMT7GSKnacWeRLkXcL
	 2WPJOPTSG/vLYgh7bTx2t0KISDi6rp+a+mg3Ot7ByWtd92/9ZwOpG6YzgPIctDnd4Z
	 GmgFGnOnt0HXJVGDws8loWh9tzd/J/k4a+9QjLfVJHP1qbl9ha883jKmcW3uRaxXGV
	 on3NYYlTmlQSqH0VagpO3OKKbOJ1r/Xu6dhHfqYqczHfxkheu6pYu2eQUsegazR4oa
	 nadSO22/JFmAQ361YO0DRDwAm945cNH6kfxoIA2q7n/mkrw8Ij3rFuGTUdWfGEUX0u
	 vhhi5XzUKG8Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/shmem: preserve allocation errors when swapping in large entries
Date: Fri, 13 Nov 2026 23:13:13 -0500
Message-ID: <20261114035328.2743455-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200304-failed-6.18-f4ce23b1feef@kernel.org>
References: <20261109200304-failed-6.18-f4ce23b1feef@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit f4ce23b1feef16d435aa1188b6c2a637a5373ed5 ]

shmem_swapin_folio() adjusts swap to the requested slot within a large
swap entry before allocating a folio. If allocation or charging fails,
the error path compares this adjusted value with the original entry
still stored in the XArray in shmem_confirm_swap().

Unless the index is at the start of the entry, this turns -ENOMEM into
-EEXIST even though nothing changed.

The caller retries -EEXIST, so persistent allocation failures can leave
the task spinning instead of returning the error.

Restore swap to index_entry on allocation failure so the existing error
path checks the original entry. This preserves the allocation error if
the entry is unchanged and still retries if it changed concurrently.

Fixes: 91ab656ece13 ("mm/shmem, swap: tidy up swap entry splitting")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-12-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Duplicated the swap = index_entry assignment across separate direct and cached swap-in failure paths instead of one shared error block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6828611bcdfe0..e7c4d134b8255 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2376,6 +2376,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			if (IS_ERR(folio)) {
 				error = PTR_ERR(folio);
 				folio = NULL;
+				/* Make sure to validate the original value. */
+				swap = index_entry;
 				goto failed;
 			}
 			skip_swapcache = true;
@@ -2384,6 +2386,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			folio = shmem_swapin_cluster(swap, gfp, info, index);
 			if (!folio) {
 				error = -ENOMEM;
+				/* Make sure to validate the original value. */
+				swap = index_entry;
 				goto failed;
 			}
 		}
-- 
2.53.0

