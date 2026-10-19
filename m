Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425484;
	b=z8sF+kt6PYml/Bo09byzbOaPivvXo+uap/c+cx2+H68LPeJfR2cfso4dbQmZLSvTp8nF
	 EtYoA4FelpEGMGhuuUAfvkZWbZu/U7uMxDG02uK0Ysz+1WjTjDBGppX7paMH1ckcbIiKX
	 H/0QMABcDZY0QXBc/x9QVTfF8brHXHqV0KSvna8G1X0YvmJwPWIP7sVeHMF/ch9BVYlmI
	 TrLfEr2qyzHojUdEQvmEV3jAGgwhuo+FzGFVjq9i/IxQi2VCcZ3sznIPiBPONAjJye6Ov
	 xEDac8G18LkSJXLHkze4rsUhg8IhvJLYXD49Ehsrpt21nCqSckMgmmWCW9lg8pt4wlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425484;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Yntcu++Bk23KyJ22PYNQhhCbRirZ3yVnoNv98kbGCE8=;
	b=u8baVuiIiC+xsZ2xvGVZbsYiNmanbcYoceaixYNyr/s+Amm7e2DNXCwDoIp4+epEQYcx
	 jsRUYSmaKV5icuyqO08/F97LpFvCjTkwwWcHmsAM9Kwt800ypCtyseqOs5JLb41LVFHjj
	 rqimtYQWwrA7ulJVbUkJ1TvjZVK02uKrusPJTVp39S8Rd6MpOTHk9it88qzteKrhkyQcW
	 8BShBgjQicivCJ0WnrnXnpSV6K+w6/ujVtsHHw8/O5zyqlmFSvY7coJccqtyTA6FmmSxT
	 J3k4u7xyj4RskQptqMda1d4GCM4V3L02ksrCWHgfTtR4CB2V+s2nXDOSV5RYNlnMEKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPTiOnBr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C7606DA54;
	Mon, 19 Oct 2026 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPTiOnBr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18DD1F00ADF;
	Mon, 19 Oct 2026 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425484;
	bh=Yntcu++Bk23KyJ22PYNQhhCbRirZ3yVnoNv98kbGCE8=;
	h=From:Date:Subject:To:Cc;
	b=mPTiOnBrcRiYvhdEH48MA8B3jLhdSuY0CP12o1xMeV0yGsm83xnedw0bOdtFNDy0A
	 tLly8RCPgWjBB2dILWnJbn0Ag2CKgUNDflqRW4Alutb7HFPMh4tpeOoK6JPKyC7iqD
	 mToXV3F31lMwwHiPKSoz1RKjEbsuEUdEtnjUFdJOuzZIXEyp3L3u1SADAG51SZzgib
	 H6cxf+xT8XNDFvBoiea0DLC5HBB39ssEBEXASkCVe4Rf600WLt6Amb1qew0rGBtaq/
	 A2O3foqkJ7FxcCXnVHh4FCRFPS4QVHW3zG6cJAc1GJ7RV3ZoanIIL2z1kTuEXyI7Nb
	 t8GkAzjVnzBtQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 19 Oct 2026 16:57:48 +0100
Subject: [PATCH] mm/mremap: correctly uncharge accountable VMAs in error
 path
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
Message-Id: <20261019-other-mremap-charge-leak-v1-1-d94477fe6545@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G2irFOpXxEPVqMGVVEQQ/27wO
 DAzDyQSpgRV9oDQxYn3TcHmGXRT3EZC7pXBGeetsQH3cyLBVWiNB6oiqiwUZ2xL54vCd8aFAJo
 fQgPf/7pu3vcDFbuVVWoAAAA=
X-Change-ID: 20261019-other-mremap-charge-leak-b426336c0299
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Brian Geffon <bgeffon@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ljs@kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2175; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Pa2pyigwPtTmiQmHbxbptIgogTHVgWu/s511reRaxWs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKu2XGyWPy44dQzj7H2zceTUzcuUn+teVrHOffv106Wt
 shbi+L2dJSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiJ58wMrz8fkrB78jDXH2/
 kMJtRq4dO6y+Wqy6sag8wja/YbpleAHD/4ys1X/nXDr2x85UZH4o56mNfQz3DC/OzHjwXHQejzz
 7DC4A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The mremap error path is a fragile and unwieldy beast - it reverses the
page table move then updates vma_remap_struct state to swap VMA, length and
address between old and new VMAs in copy_vma_and_data().

If the mremap() operation didn't specify MREMAP_DONTUNMAP then its caller,
move_vma(), invokes unmap_source_vma(), which unmaps the new VMA rather
than the old one.

For accountable VMAs when MREMAP_DONTUNMAP is not specified,
unmap_source_vma() unsets VMA_ACCOUNT_BIT during this unmap in order that
only the delta of a VMA expansion is charged (performed by
vrm_calc_charge() earlier).

Therefore nothing uncharges the expanded VMA size, and there is a permanent
leak in global Committed_AS.

Resolve the issue by uncharging when MREMAP_DONTUNMAP is not specified.

Fixes: fdbef6149135 ("mm/mremap: don't account pages in vma_to_resize()")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Issue was found when I had local AI check the other mremap() fix from today - it
raised that this pre-existing issue was present.
---
 mm/mremap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 6970783fc445..1620006028c4 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1338,6 +1338,20 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 		pmc_revert.need_rmap_locks = true;
 		move_page_tables(&pmc_revert);
 
+		/*
+		 * When copy_vma_and_data() returns, the new VMA will be
+		 * unmapped rather than the old one.
+		 *
+		 * When an accountable move is being performed, this unmapping
+		 * will not uncharge any expansion, so do that now.
+		 *
+		 * A move is accountable if the VMA is accountable and
+		 * MREMAP_DONTUNMAP is not specified, so only do so if the
+		 * latter is true.
+		 */
+		if (!(vrm->flags & MREMAP_DONTUNMAP))
+			vrm_uncharge(vrm);
+
 		vrm->vma = new_vma;
 		vrm->old_len = vrm->new_len;
 		vrm->addr = vrm->new_addr;

---
base-commit: 4dbe24720eb3811563cd56b35d87ddf3f9beed2a
change-id: 20261019-other-mremap-charge-leak-b426336c0299

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

