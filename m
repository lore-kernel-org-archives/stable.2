Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106291;
	b=B0LAGOVgFfJZ1S1la0oEXB7+JmcVwgVYGwVZIp4t+nyJNFgnoafM8BEbOe5DnXIzQ8Rj
	 uH/E81vaVl+A3dQG0SvrOcCmPB0kLOi58Ppf1DiF1osM7ElL/D3zEIfRs3boceLuAIqzg
	 lmoCHp2rnY4AiJHnwc9xAcnJ2HC36llm3GLmAEkTNiynpAisJKVcRpnE0AHH+jVBoLIVW
	 z3Ni8OLnuPWAMCF3HnAOubg5RpTZPoKC8AER/CSWM2Dj0sbKd+5Wn+yiqfZLIfaZ1znbd
	 KsuGNTPGX0XuCfaYOy6jRTEkOvOuA0aKE/72KOHKSingMKyjiB6L7llsDFx2a1vdp8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106291;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=C9CW95GOpUZS+JdbNzdoy8x8Ek3CYVhYSlyIeljBRJw=;
	b=o5/IQHKoksY10E0rOMnYcPM8vpYVWZTKugo6OszCHY5OtCBcGI9sQ8FKXTONQF2MkDtX
	 tDB8F8cmGKJjpg7qBzU2NXsnAJliOTG8/17frrNhuYCrPB3v9D0gYGQTMd3FEand5JpZN
	 1UT5KdvstC/MCT+IxS1LhJl8fFSpNwZv3yhJjFBjVrMsL9F/xpQzAC2wsvIprNM7oJ20z
	 kBJ3PW/BD7Ax6abfWi9GZZbcuoeqwYHJxy4er4KFomWA8DwRM1aDRXAOYWIa6kV7WxNDn
	 xZzd6wThcdCMVPL3/VM4OFRcdAIW5Bm2d681bH3JEi58TuJKElabWEebzrRzWrrbQgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg7AV3Jy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467260A260F;
	Tue, 27 Oct 2026 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg7AV3Jy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446AA1F01829;
	Tue, 27 Oct 2026 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106291;
	bh=C9CW95GOpUZS+JdbNzdoy8x8Ek3CYVhYSlyIeljBRJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lg7AV3JyrpqCFTdtN8/Irbsn7pw4xNIm8fnXR3opnpD7q8JY2TuW2TwvubuRQce28
	 NCYj2M1SN5DdsCXQy1aSscJ9FgDFhTpDT3Gi29M3VRD5uPNxumZCcd9T3sRCDGE4Xi
	 30TVlxdQjL/cnGRjNPLdzXB4yY7lPCuRkXmrHNzB5nTLcI1OWS4cfCqfB/DsVhJGoS
	 9lJSxiFMmVCkVZFi22QfjZZFOyVHMjQmob0uy3IrkN41vMx9gNUAeZCXRVIafu+gXX
	 bRnp1ebGBgEYaRN1Dz+r/BtbOFf85lTXepz+jkS4EPHLzBK7i2t7eOh8LhUMTMdInY
	 kkuD0yPuzSuAw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:16 +0100
Subject: [PATCH v2 11/14] mm/shmem: preserve allocation errors when
 swapping in large entries
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
Message-Id: <20261027-fixes_shmem-v2-11-86a00952acb9@kernel.org>
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
In-Reply-To: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=david@kernel.org;
 h=from:subject:message-id; bh=VFsqS5vseIV2DxJFz3mK6fhGor3WImrNW4kFky6FZTk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBScy2N1p9Nrfctd3iZLSV9jz3efdHc6/7l4KftAS
 tdbDob7HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEykS4/hf96XOGkGlqBl4T9s
 VjXd8cn1O8xx3uSEmMhNlqOnWtXa6xgZVh+bMJtlzoKNv9Y9EmX4H35Kc7ag3QL7zUXLDtlKP+y
 I4gEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index a538b37fe739b..9a11de010ed7b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2528,6 +2528,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			else
 				error = -ENOMEM;
 			folio = NULL;
+			/* Make sure to validate the original value. */
+			swap = index_entry;
 			goto failed;
 		}
 		if (fault_type) {

-- 
2.43.0

