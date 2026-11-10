Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316029;
	b=qGZ2bf+uZrzPI4w/z9ISPK3oyH8jhGbzYu/u2O1hov6acGqYlPmglHIBgxNMg6N7rqrp
	 we1biYSnqEISPF3oMy5F9YWCNW7SFD23Gn1ps/HyjY3iv6e26Rv/AYvkjj+NaLPQWObSO
	 ePiV5qT8If2z7UpMemFkbpSOIND+k2Ob0JAHksXXhxGjUPQggHs4+8x0vWCOzxVvrKvTQ
	 zr0WGx73iqO1M2BprUxh2YnZnU4kL51KKdImDhWk9vN6Nbh7chXB8PKXHyJRZWcSvZLUY
	 NTUhfIBNN2UY63GadYyLJQKTjidBAebcESeWmXn/wsPIE2zhzVj7j6C7OtMRPWMS7VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316029;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zPARzp3ijAZvsXvFPW/SzpwF7CrW5vg7p7oo+aie1Hk=;
	b=bxgiNv+/dkU1dSIP79PfFql2QTKkP+ttDvC9sCe/43BGn2C5qfVUjnizhMN3rKEGIcc8
	 FpzrwbQtN1K0KavPnVBe5TN90InbdjEXzsi+dEPYUXkeUAnnwI8DiTpN6BK9/poqChqIq
	 zn/RKAMzbyTAD73GSTKN3Ebepp6qXUh9rTi6ml40lxw53IkDPIdni+j/4ZNMq4KreuUC2
	 IeykcUNrywLzNDfx9+qIX3mDLMya8TyLcKBzmkC/NpM2LfVaxQfAa5XRXEMYEGuF2mkrO
	 5VaLvhgCy8qRzJAjuH1gM5r2gzQQaVvM+0GtDIgUtL5noJ2P4DiSSYdmPElAeefZwIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTeFptdW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D5606BFE1
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTeFptdW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493B61F0089F;
	Tue, 10 Nov 2026 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316028;
	bh=zPARzp3ijAZvsXvFPW/SzpwF7CrW5vg7p7oo+aie1Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTeFptdWvr20gVPhdVFSGhmggD8jRA4uoxKrQIacVJ0w5PFpugnkHSPzHJZ1fVu5e
	 hclTFGCuqSBjRNDgRi9pdc9aP1Mx80pRhB7jl8GSIddHKd6kuvavvWMjjMn8xdLpF9
	 FPKYbfdCXJNSFKPjvKYVyMV/19hPT+3+yUz3DWi8KJ6gmsM8ikmIq8CZrwcUlQA56W
	 5q1u9BFaM/R4ar/iLKR0Pj/CeXTWkenWK06cpWMZW7kyJJFZ2kuiXpjxAeBwD57HKi
	 KzpwhboF2qEQ00lTzStDILfgYSuj9uVD4JQAsHoCPYmGMOOMzpmFw7FpdEZ5iRQEsa
	 YoqaNO1mRv5aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
Date: Tue, 10 Nov 2026 08:07:06 -0500
Message-ID: <20261110130655.1622252-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050401-failed-7.3-1383cff4ccf3@kernel.org>
References: <20261107050401-failed-7.3-1383cff4ccf3@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit 1383cff4ccf3c8833c6255edffa29eb67c6419bb ]

In f2fs_sync_meta_pages(), whenever i becomes zero inside while loop,
below check may be skipped, it failed to check the continuousness:

	if (nr_to_write != LONG_MAX && i != 0 &&
		folio->index != prev +
		folio_nr_pages(fbatch.folios[i-1])) {

Cc: stable@kernel.org
Fixes: 580e7a492608 ("f2fs: convert f2fs_sync_meta_pages() to use filemap_get_folios_tag()")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: adapted f2fs_sync_meta_caches() changes to folio-based f2fs_sync_meta_pages(), using folio_nr_pages() to advance the expected index ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4b59f30ef45d5..fd758a98b355d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -610,7 +610,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, long nr_to_write,
 				enum iostat_type io_type)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
-	pgoff_t index = 0, prev = ULONG_MAX;
+	pgoff_t index = 0, next = ULONG_MAX;
 	struct folio_batch fbatch;
 	long nwritten = 0;
 	int nr_folios;
@@ -629,9 +629,8 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, long nr_to_write,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			if (nr_to_write != LONG_MAX && i != 0 &&
-					folio->index != prev +
-					folio_nr_pages(fbatch.folios[i-1])) {
+			if (nr_to_write != LONG_MAX && next != ULONG_MAX &&
+					folio->index != next) {
 				folio_batch_release(&fbatch);
 				goto stop;
 			}
@@ -659,7 +658,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, long nr_to_write,
 				break;
 			}
 			nwritten += folio_nr_pages(folio);
-			prev = folio->index;
+			next = folio->index + folio_nr_pages(folio);
 			if (unlikely(nwritten >= nr_to_write))
 				break;
 		}
-- 
2.53.0

