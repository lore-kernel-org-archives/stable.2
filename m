Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627936;
	b=PG9lP4jABImfl/fPGOIgGKNBEph1hA+MQE92F0PkjZ89tJQpA6QAPt7dYFEGM1vPtrWb
	 vYR6M0N73TGbJHG7l2WEKuOYD6L6c0dHszTv35GhA+ofIM587eWEV5K6mfEnP0UDkMEmM
	 O7lrrie+aqHCUQQV7D3ptPqDQpCxQshCeNDtt9grQzyvGYwkF2qyjoEHj/2OoAoXItUed
	 aQV3w/CEMWQfhFmah/S2PAlyB6y4HULKzQCwbWuva77IfYytUs5VNaKU2lAQgl9oqowqr
	 Z6G47NLk2Zd1x9Ovsbvr2D5ZJs8P2+XS1IRiUFN73bxeh8DZa2xJjhkKYh/RuIYuM+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0HkGUAt0TkownVkXwCMu1x41EkVyymRWNHmR1Em1gck=;
	b=jkF52LFlj6mkT6mwPnVnjEj0K87l+ybYIgP0d9lnTvPqskmkhgaR/9RwOaCUgp4keoSA
	 f2E5cfFPgjbGKapw5KaS5j1KdsYKDLpBQCDCfzNYD2HU2v8WL+9yks8KN19Y90+2n8khm
	 mUSGeK2wzcaiRBhRUc+HsNDxQKpy8zV0enzms5Z8ubRdVEuL7p/iMI+XFfN0ERiXWDnZX
	 hnXkwAOe6Utm5S6sCy8Ro9E1we5p85C4Zy7kVSDsJlR29qZ0toILtmfUZuEJtjsAQzvOl
	 v2OeBcDgn54MgeEXaSFkhqzkKh2nV4hq2iq0tH9qxUScchu+POcIw6ekQYuEEJIcdfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b="U165c6/a";
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDE606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2FDE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=U165c6/a
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b4c685c751so53774157b3.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795627935; x=1796232735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HkGUAt0TkownVkXwCMu1x41EkVyymRWNHmR1Em1gck=;
        b=U165c6/aZO6PCaTP1gi0+DzvxzmItJj0Ii1VSWCGVKRW8JNwSeZHA1wUZ9q/eGLeYH
         yNjnw8VgP7iWrGEf4UAupDv4MdO1cE1AgLJrsy0/pXVU2mCQw6DF0kA5lJK+Ar5JfGMI
         B02AayfnZIkW8hp+6r07ZbH3pzuICVhRxBb0gULHaJNtSccZRZtyUqJk5Zl+AIH6h2JA
         u6mncC1Ay8v4ZmbBf3gXCHXviCIU27J2iUp0qN1P9oz+MOrDWY09qEGQcQp2XItCagzt
         i0A+zKJ/MCxXTqR0mpPbAPlYcP8v0Qg0PQ1jGG9tQqzCZsekk/Z7HTDvelaXgwbm3WC/
         DwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795627935; x=1796232735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HkGUAt0TkownVkXwCMu1x41EkVyymRWNHmR1Em1gck=;
        b=TYhb1KiS7t8nhRYjXXrkvNqofSggMxOzoO4h07pBw6+8Uf9g9BKSM6jpjyNzKjfj9b
         SCE3CsiZYbhBH7AWznQPgfaMWp0Pxvc6aiSWDRA8jA50ixNIBScoWcxX7IKkn3vp35zC
         uT/20CwfMRGuU0umI31EgiGvR/P5VRYQljW4W3LCsUAIZB5ZiW3GvTX0+aVwcKjViS2d
         N4GNXmnUET4CBFnTyhDqTYClvMwOoc7wCQ8s+tYSsuCRUuVwJRF49lGeTMgDKyjI1xx1
         YHa1oYsBnz0WcezC5Gni+O3G+L440gQSluUO1EE2N/4zLcmRR76Jve829SyB5bfZI4rv
         Q9kA==
X-Forwarded-Encrypted: i=1; AL+hErEA+Lkq1EiNfgqVsxltsbVIJjuH9ainhWZ7OM9xI/qnZ4qup2sEmnhqJj6tzuYanW4s52+6g9Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8R7iVmY6avl2AL+2Lb0TvVt4KsrIfOiG50PqvkwSwg8nDXDMfb
	Gq731KlzUqn0M7raGKhlHa49zuFmqX56x54JD1viknAfJ+KAq32hVdinsP9hLfvKPA==
X-Gm-Gg: AZFdTZffOsiipzDY/8imfyfjLArrtf7SSGYwk0XekmWTSgrUCMPHKv0lI141myDd2Zv
	brV/oIfIJO0uX8B2vq1zg1/Txc4rpq7YJ+bPBxmZ4tSiSaqsXIRXTyO3MIVsYy/agbI9gp7a/en
	Xv4TB4MaaHfElR6xua7gGCyALZu/aNikNBDPf8uwhmdJ1LoBKucsc1hsw8xA4wIVlaHHi+ExRuZ
	bKKF9WMclQ59wHXaPqjkJoRi4ThIBrJSnG+eX9v6Inl0QfnNNIIT5Kdwo3JYrtD9GPBK/QbXyPt
	dzUxUbPDfvoNymWWN+BMaaf6gUVR/UFM/24ayyQmj9XW+gNVjCixwLz+24yTSSGhkBG+ySrj5Ik
	GvzV3bbVndTfthc5ER7EtDHX+lBjUqLJnZICg2jaBOSp8kZwiUgUAbDQtYLW4TN7EyfQes5ATZ4
	hzLhUKLsmma0pmQgtfNFAkknlQDND+QKDDKVdiFsIV5a3h0TfFvMZwDyWDv/iW52K9TsSeykNhv
	iMFCcJCAqzNdL18+GTEzlV9GrvA1vl3yhuVU/3gb9AuIqSCA8R/WSdaQ2D/esNT7wADbNghDZd2
	+S75Dzy/upiRUWTVTWUFLFsiOmlBxfBr8o3P5LNXaJvryi9VG41H
X-Received: by 2002:a05:690c:6988:b0:8b1:70be:d4d0 with SMTP id 00721157ae682-8b52047d511mr73732187b3.48.1795627934796;
        Wed, 25 Nov 2026 09:32:14 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52030d5c3sm75406057b3.32.2026.11.25.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:32:14 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Baoquan He <baoquan.he@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/gup: fault in ranges that start at address 0
Date: Wed, 25 Nov 2026 12:32:02 -0500
Message-ID: <20261125173202.3636133-1-hengyul@cs.unc.edu>
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

Commit a7797e74bd39 ("mm/gup: clean up codes in fault_in_xxx()
functions") made the loops of fault_in_readable(), fault_in_writeable()
and fault_in_safe_writeable() stop when the current address is 0, to
detect an overflow.

However, the loops then do not run at all for a range that starts at
address 0, and the functions report that nothing was faulted in. As of
now, a write() from a buffer at address 0 fails with EFAULT when the
page is mapped but not present yet.

The issue can be reproduced with this program, run as root:

    #include <fcntl.h>
    #include <stdio.h>
    #include <sys/mman.h>
    #include <unistd.h>

    int main(void)
    {
            int fd = open("file", O_WRONLY | O_CREAT, 0644);

            mmap(NULL, 4096, PROT_READ | PROT_WRITE,
                 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
            printf("%zd\n", write(fd, NULL, 7));
            return 0;
    }

Before commit a7797e74bd39 ("mm/gup: clean up codes in fault_in_xxx()
functions"), the result is:

    7

After that commit, the result is:

    -1

With this patch, the result is the same as before that commit.

This patch will stop the loops when the current address is below the
start address instead, which is only the case after an overflow.

Fixes: a7797e74bd39 ("mm/gup: clean up codes in fault_in_xxx() functions")
Cc: stable@vger.kernel.org # v6.16
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Tested on v7.4-rc3 with KASAN and lockdep: with the buffer at address 0
and at 0x10000, on ext4, tmpfs and xfs, write(), pwritev() and O_DIRECT
reads and writes give the same results as before commit a7797e74bd39.

 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2b405cce2ca5..a174e93327e9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2074,7 +2074,7 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
 		return size;
 
 	/* Stop once we overflow to 0. */
-	for (cur = start; cur && cur < end; cur = PAGE_ALIGN_DOWN(cur + PAGE_SIZE))
+	for (cur = start; cur >= start && cur < end; cur = PAGE_ALIGN_DOWN(cur + PAGE_SIZE))
 		unsafe_put_user(0, (char __user *)cur, out);
 out:
 	user_write_access_end();
@@ -2144,7 +2144,7 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
 
 	mmap_read_lock(mm);
 	/* Stop once we overflow to 0. */
-	for (cur = start; cur && cur < end; cur = PAGE_ALIGN_DOWN(cur + PAGE_SIZE))
+	for (cur = start; cur >= start && cur < end; cur = PAGE_ALIGN_DOWN(cur + PAGE_SIZE))
 		if (fixup_user_fault(mm, cur, FAULT_FLAG_WRITE, &unlocked))
 			break;
 	mmap_read_unlock(mm);
@@ -2176,7 +2176,7 @@ size_t fault_in_readable(const char __user *uaddr, size_t size)
 		return size;
 
 	/* Stop once we overflow to 0. */
-	for (cur = start; cur && cur < end; cur = PAGE_ALIGN_DOWN(cur + PAGE_SIZE))
+	for (cur = start; cur >= start && cur < end; cur = PAGE_ALIGN_DOWN(cur + PAGE_SIZE))
 		unsafe_get_user(c, (const char __user *)cur, out);
 out:
 	user_read_access_end();

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.53.0

