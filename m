Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420928;
	b=N75l9RSNfkEb9f68rtMTxAT2QQtQLTlkVABmZuEVrg51g/+gycQpxZyxbcPk1j2pUm4/
	 nzlVIf+RQYfvaz8BTSUOY2W82VWTcj7nX1OdbUAVAdxerYiRf0oV01aff4kCOm1tUFqeW
	 F5YbGlKQctnQj0jtk+68cXYnlvjbYAcQsFXw8OS0myqZcTWx7mi44PBV8D7+gl1gu3v1q
	 nilCHxfFZTlNzMxcw+uuYEcyuejlxFyvZM+rf1sighKWR0ib8J2mrOIILHrdeQUXKz12k
	 JlN70QGUhvnux5stIIQIXsBuYFaBDokOmKdAYNpEKwW0FKHfMGjkZPU5bcqGhSWPdWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420928;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/og5Uhf95J9kveBkAm0grQ3O8w2sq19wcFkN9LBdY1Y=;
	b=wGDuGfe9K+aptQKjcExcRFRYJaecefYeyZeyLy3z4ZrrwaA6kJMaDbFx2YyBSJ3NEcj0
	 PBrJexdprw7XJSU0p7Xu/mjd+DfSb39vjwCJWr6q7OIeyQv3hkLQzUhaaexWa8SSYr6Vc
	 /RFWz+xb2t/jSSDNk3TdqCsZVDz/MXEqPdKJQ1Db9jnlW2VVLR9NcUbZJkjIaDakoykMc
	 XabzgJxm7E5VM58l7y1O31MBnD0YSOSqS+RLWE+ZRZRYTM0QZnYoHR2KxNLN9wUGePlcC
	 nQRds9JW2OTOMup/whWml/ys209jSHqj8Usp0/VoBwJzelWM6Nq6cVn3yfRWD54Qr0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfBrjCyC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA4606AE24;
	Wed, 11 Nov 2026 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfBrjCyC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7123A1F00A06;
	Wed, 11 Nov 2026 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420928;
	bh=/og5Uhf95J9kveBkAm0grQ3O8w2sq19wcFkN9LBdY1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PfBrjCyCEH4wXB5O/qCXaz4drr/LxPt30HG6A9qGicPPmSwUDubQFA2D5zBSLO2jq
	 oZi8G2hRwvOpkhyIt4F/cX2r5HbwH5ITk7ZWHxB9LrXWR6w9QYZGsSGdIW+UQTt9rL
	 EOQ+S63htwEV/veE+Moi8ecIDP6WHQvXlRFrLvw2q+8uzfVq+m5lj94H5oc1JXAiIR
	 yioz/2yhUIwbp2FcscmdFPS9D/EfDfC+z1691Ycaj0vXo4zju1ADuLpLgny38G5sEy
	 dp5pAOYctwKt/HKvlfEXhEo1cLie8WihfnUcjkKUa/tyMX5xonS6Uc9NPCt/8I0gCb
	 wF61DPm2msXew==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:22 +0000
Subject: [PATCH 08/13] mm/migrate_device: fix ksmd oops on a migrated KSM
 page
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-8-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=ljs@kernel.org;
 h=from:subject:message-id; bh=a2nM5nYZYqHBeImIwabwKtGvLlr/iYuSs+KhVwYHkrQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMjW/fH5seTsZY377rZ/cdzgfHf1r9Pnjh6YE9Gwf
 FFC5tyH9zpKWRjEuBhkxRRZnn8R3x8kEjav84K/G8wcViaQIQxcnAIwkehAhv+Vytnz/JS1RGX7
 7suXrb/xL/Lx7Jg1QZx3zB6LNPC61K1iZHin25NzzX2imY4Ic4sGs/rs/osaatdEllQu3xE74Z/
 qR34A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

After a KSM page is migrated to device private memory, ksmd can oops,
and KSM then stops until reboot. A process that maps the page can also
loop in page faults when it next accesses the page.

The problem arises because KSM doesn't know not to try to look at device
private memory that does not exist in the direct map.

Disallow this from happening by explicitly testing for this scenario in
__migrate_device_pages().

Fixes: a5430dda8a3a ("mm/migrate: support un-addressable ZONE_DEVICE page in migration")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: tweak commit message, comment ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate_device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 45e571dbfb4c..7ebd02ec303b 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1205,6 +1205,15 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		}
 
 
+		/*
+		 * KSM doesn't know not to try to read device private pages, so
+		 * disallow the combination.
+		 */
+		if (folio_is_device_private(newfolio) && folio_test_ksm(folio)) {
+			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+			goto next;
+		}
+
 		if (folio_is_device_private(newfolio) ||
 		    folio_is_device_coherent(newfolio)) {
 			if (mapping) {

-- 
2.56.0

