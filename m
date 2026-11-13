Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606420;
	b=DjazqXHFdewkaIoKM7vhF4ybyOu6Iy3DQ6yWCQhfRN/Z3+LdFho5tqjKINRZ9XGf8CxS
	 aVmwvbMeXHEpRbnGvQ/Cst3tb/m/QSw0WZeD0XmvguKZmpfkoR4gWpsycNG58SYvp9zjX
	 Dx4pweqfxqBffh1/4PUJna5qPfjSeQ6x1LCNqwVMlOviiolUXTgIJbOFXaZRpqsSDtfKR
	 Qgu8QwTZejyFL9LykQ5Erzxik0Ef89PA69jpAiJmI5UkTLQ1dRsqjN4YiSV2339Dsi7Z6
	 l034CgrPM0B9Evb0TIbLeU+M4tKMW828rRhX7J0zLPSnogsA2jkpXPZg5vC8hlkqZvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606420;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UXNdUwNGb/5NMrJMkhrM5V8CwKIF1k5k6UpTYIeOn6o=;
	b=Y2TCxhShqyltJMqH+pDbVxMVMdLHzG+oVkUTDT3ZSbKU0QBRNcqy9T2Sp69+qEXlwTRo
	 qCAac54TzpzIqhCTp3iprNUpI/7gE7GE2Jg2SZSYD9kJDdhBReSxKpNU8yC6eaUDsy3Jn
	 omqSBevrGk+fYsQuMoR2QzE1eFz4p3TPZvks36qHKVm+7HgLAfQUyyMhfTyV7MwDZHUr1
	 UhIXnJRfxvxkmgdQd3xS6Lzv/bPdv8AKLax2Dw7BVTCZVp2eBrJxYziacv44I2nBqw/WK
	 t1CCwYuu/mE8b71tpXtpym+Y+9CpG7VXmVO9+LiOKdR0PGAl2ZIQfk9hge0Nur98g3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCplhdpN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34137606A332;
	Fri, 13 Nov 2026 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCplhdpN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAB91F000C5;
	Fri, 13 Nov 2026 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606419;
	bh=UXNdUwNGb/5NMrJMkhrM5V8CwKIF1k5k6UpTYIeOn6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SCplhdpN4SOxZ7lUzltMf7KGoLgtjvpAng+X/qXAId63abfV2pfvo9oDBpoS3mNpm
	 g001QPNOHNEN6bf+OquYCFLy9Ex3eqnBUhe2JzWVVcGKhkHb+zC3KJ4epRDWTA48xL
	 JH3eJjf13w4dsuqpSocWNjX6M6MA+at3RVG7LwbRKW3h8QsfaD9zOYAuW/mqX54Sy+
	 wwi/qnriXRk2N9TCDRMdz0n0jaF5dAzVxXvc13X3xzI8hh9zYxEA3M0C0uDAOfHuwJ
	 n/x3AaxRQoKGytn8Pz5TMiB7h6vR12KmvOoI4bkUjSPWjyk9zmHGxhqswj6lRygI43
	 qTZYBR34aab8Q==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:26 +0000
Subject: [PATCH v2 08/13] mm/migrate_device: fix ksmd oops on a migrated
 KSM page
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-8-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Ks+7trH82YDke8ot4RopKlEtAXwBOms2oow2pqcZBhg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/ycPfflvzghXu7N29bfjrmzzCBvqm/Eor7vB5TFV
 6dFX0pO6ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEDm5jZJjAtMLnm/L8E9G3
 RUqTchXLOi+ciSw2YXXpUcn/66WVFcTIcHPJEd6YD6u2uMtMMbr+repY11ddzTqFQssljb/ZFtV
 c5AMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

After a KSM page is migrated to device private memory, ksmd can oops,
and KSM then stops until reboot. A process that maps the page can also
loop in page faults when it next accesses the page.

The problem arises because KSM doesn't know not to try to look at device
private memory that does not exist in the direct map.

In addition, ksmd skips all device pages when it scans, so it drops its
rmap of a KSM page which was migrated to device private or device
coherent memory.

Disallow migrating a KSM page to either by explicitly testing for this
in __migrate_device_pages().

Fixes: a5430dda8a3a ("mm/migrate: support un-addressable ZONE_DEVICE page in migration")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: tweak commit message, comment, also refuse device coherent ]
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 45e571dbfb4c..141d60d27e90 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1207,6 +1207,11 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
 		if (folio_is_device_private(newfolio) ||
 		    folio_is_device_coherent(newfolio)) {
+			/* KSM does not scan or track device pages. */
+			if (folio_test_ksm(folio)) {
+				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+				goto next;
+			}
 			if (mapping) {
 				/*
 				 * For now only support anonymous memory migrating to

-- 
2.56.0

