Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505117;
	b=TUeRCjmj4p6g/GPTlSEoIXHUHg+7DwqyABfJKSXkYu3mmUDYv6TYNWT/9rI5GKJTm6sK
	 yCkHJbg9Q6FV6puqUUcx0qYJKdDmcl0K2f3zzz89YnUMaQvLo0L0cLdDumXvwS4adwBS6
	 fYDZscNcDosy5hi6xgE8jLRNXVwmqqsG7fUnlNG4UolI/n4PWGK18NbSno5GjrbinpPBB
	 Qv9OueGd68iv2VTxImA10qRtGvpol5W9F8Ml8+Gd758QRrDvYMz/gVsWTbLejAlexDWu/
	 Ui+cHr/kbh8c3zkwujr8dU3XKzbl82yn4nn3DUCCDOvV9bevzVScIALTCMHLXUZ24SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505117;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=6FLvIP+02fU3D3EgmUsZmg/BxYUoYrdtHX2qDoNfAQg=;
	b=G9MKSOeDT94/rqSLEPzF5/nZuHZFd+rqeQSEBlBpNNtNGe5pJxE5Q/r5IFXtmzbpY7vP
	 2fqnBzesUDnw3+oJnRb1Mmm2EZdbNVG6vqQR0l8QvM0Nk+FE5cCiEyW0J3AibN+mUh1Xw
	 EIzcnu/CDvaQ96e/SaZZNJl9qrGAUwt4t3Y4wA/LxnQ4jj+Wqv8tQ6Gc2NHGdr9RH/hdC
	 bc+lpF7xTxRU1XlXRuXL0pEzsVpy+hOrmWhVg0U0Q616HynjAXuzP8+B+YBgYGro5QS5o
	 iMJnQK8v4nMaHR7FuIKipWEcwXqrCFqq5XPeXiBSi6s7Bo4c/Dpp85w1Nz55k6pJF0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYmCQ62v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE0606CFE2;
	Thu, 12 Nov 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYmCQ62v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17701F000C5;
	Thu, 12 Nov 2026 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505117;
	bh=6FLvIP+02fU3D3EgmUsZmg/BxYUoYrdtHX2qDoNfAQg=;
	h=From:Date:Subject:To:Cc;
	b=IYmCQ62vcyGAlECdg2yNK4EBmQ0N2pVumUcV+aM8yemIWDbalFnkxINv12qk8EsCm
	 LgPnQ/WxzTcQoGOFK9ksV2JZdhoqvx21bldoapI3zR9oQzQ8gqriMC9Afykl2JaaUK
	 jlOzqpPJVwOeHTBYtPSSp9mqgvvH/p9U4Tg2KeWVK6rh/AJiqhQEWsfLVfPA1zHyaB
	 o5tjUIGuXWI+ZVn+GMrBbFB6aK8LzUA5J4bkNU5QI5ikb51kDhNWGL+NiLEpqX1EIx
	 ybWd+krBH9eoKS3LZboAMPfFMiBbO6Wg8fPz2l04Ah7bdih/etLOjcTQ0dSAt/WOkZ
	 OR2qr0jQPr5Qw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 12 Nov 2026 17:38:26 +0000
Subject: [PATCH] mm/madvise: disallow guard region installation in
 uffd-armed VMAs
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
Message-Id: <20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrCQAxA0auUrA00QS3tVcRFNJkaKNMysVUov
 buDy/cXf4ew4hYwNDsU2zx8zhV0auD5kjwaulYDt3wlIkb1kGmaP7impDiuUhQ9x7tGlAv3Z+J
 etHtAPSzFkn//99v9OH48gYlIbQAAAA==
X-Change-ID: 20261112-disallow-uffd-guard-install-a5294129ad7b
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, ljs@kernel.org, 
 Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4426; i=ljs@kernel.org;
 h=from:subject:message-id; bh=z0lXvuNFITlSBw/W7A69EZHiCMx/P/HmR1ujagLOP60=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+/py565nBh+S5gr8zV/1c4aC3+OoVrrXfg9817//ze
 I0jR+qK9x2lLAxiXAyyYoosz7+I7w8SCZvXecHfDWYOKxPIEAYuTgGYyMJ0hr8SQRty4qT8WP2m
 nBLcfaZhwp5jfxYmepQwbeMtWWFQ4byBkWHGb7PzTYtM2JpCH2Wk37RKXKBtu+b6lrPyp1csdWi
 /z80FAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

In order to establish guard regions, guard markers are installed in the
page tables of a mapped VMA.

However, problems arise when one tries to combine this with registering a
VMA for userfaultfd, as such operations may themselves need to install page
table markers such as uffd-wp.

When this installation is attempted the guard marker prevents these markers
being applied, which can lead to unexpected results (especially if the
guard regions are later removed.)

This is especially problematic because guard region installation causes the
regions to be zapped first, meaning that the removal of userfaultfd-tracked
ranges will not be logged in this case.

Therefore, disallow this.

This makes sense as conceptually, guard regions mark a part of a VMA as
effectively unmapped at the page table level, and removing the markers is
like mapping the VMA again, over which operation uffd markers would in any
case be lost.

Only check for this on installation, as a VMA can be registered for
userfaultfd after guard regions are established.

In this case, the guard regions cannot have new markers installed, and no
faults can occur in the guard regions, until they are removed, at which
point everything should function normally.

A survey of open source users indicates nobody is relying on installing
guard regions in uffd-armed VMAs. Software including glibc, android,
tcmalloc and CRIU were checked.

Fix the selftest to reflect the change.

Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
Reported-by: Tal Zussman <tz2294@columbia.edu>
Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu/
Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-10-00713d368976@columbia.edu/
Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu/
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/madvise.c                               |  4 ++++
 tools/testing/selftests/mm/guard-regions.c | 12 ++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0214efd2a014..268731e90f12 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1156,6 +1156,10 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
 		return -EINVAL;
 
+	/* Guard markers are incompatible with UFFD markers. */
+	if (userfaultfd_armed(vma))
+		return -EINVAL;
+
 	/*
 	 * Set atomically under read lock. All pertinent readers will need to
 	 * acquire an mmap/VMA write lock to read it. All remaining readers may
diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 02f69244f9a4..97da54dcf3a4 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -1476,7 +1476,7 @@ TEST_F(guard_regions, cold_pageout)
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }
 
-/* Ensure that guard pages do not break userfaultd. */
+/* Ensure that guard regions cannot be installed in uffd-armed VMAs. */
 TEST_F(guard_regions, uffd)
 {
 	const unsigned long page_size = self->page_size;
@@ -1526,10 +1526,15 @@ TEST_F(guard_regions, uffd)
 	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
 	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
 
-	/* Guard the range. This should not trigger the uffd. */
+	/* Now try to guard, should fail with EINVAL. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Once unregistered, we should be able to guard the range. */
+	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
 	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
 
-	/* The guarding should behave as usual with no uffd intervention. */
+	/* The guarding should behave as usual. */
 	for (i = 0; i < 10; i++) {
 		char *curr = &ptr[i * page_size];
 
@@ -1537,7 +1542,6 @@ TEST_F(guard_regions, uffd)
 	}
 
 	/* Cleanup. */
-	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
 	close(uffd);
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }

---
base-commit: 4318887a3efa4c53d6f083ccfd7105b809a3ac65
change-id: 20261112-disallow-uffd-guard-install-a5294129ad7b

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

