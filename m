Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273816;
	b=EcELIjJ/ubu/Te+adpVVWJLifN7GedwETRI5VW0JxhCO4t6IgEEBcf518VGrUUTFSqRH
	 qE7+ax1tGpn/aTQ4KufyLycFoG3PIj1ijoOz39VDwQEIwH1NggsIOrWzIF93qWM9sN05w
	 NeMVV1slC1L/dyDf1iC4lt5ZIW5d1YYIQanZkI+3bL1CsYdgoPx5vl7tuAe5ReiecmP5T
	 VKxsUj6ZOVO2bwkXRwjeDZB1j0Jhfnr0XuJZEJsdaGPlTXoelEBbuiVYorFUKp3bl2B6d
	 oyT0L1WIuDW0vM1T9sWzQysbXaDC8fI57P7cmWbkm5r8IZXcyiYEMvPjixZFluO7NWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273816;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/Y16WRWfVu20cxxxkxxFxP01WY1Gr7aJJPtKSLfZyAo=;
	b=Pie7UJfF62/UI/8PvygAgebAGAmy6M7czofE75fXBwnZPaojNlamjtyTvOL5XGl5ttVp
	 rZag3DIezD7RrG/q3+qk2INTix0AT+AslrGKTwIU1PW4rQ4Ujeg8WCHphY9bXjTm/y0i5
	 WnmlJMo6gSjHG8EwxajidHBXBiTXZPFJJDDV8B6IofkGmgZve9WJI6tdr9OsXLVFzYYIJ
	 EWcXLTBilSEwt1pCWDhuTiFuU4tawfq++tnIgt7XD401ZbeVNgbxD6OYf9lincxCymeHv
	 kHO14xwPMx8UO61PhKacfRsf4ebbWjlDRlst+sVCgOAulzbiUbNoTNZjyH3ohGP+78w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QammfUbs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5160A261E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QammfUbs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9311F008A3;
	Tue, 10 Nov 2026 01:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273815;
	bh=/Y16WRWfVu20cxxxkxxFxP01WY1Gr7aJJPtKSLfZyAo=;
	h=From:To:Cc:Subject:Date;
	b=QammfUbslZGu0ISpnE5Vbp/IRfURuN6lcgF2NF14ImsskHdZMTk5nfj2nTDRTKlRp
	 3HLP514HEofOfhLAK7xJ6SwsWeCRd8w+EZ1RaRG/ENSnuIJ+hDfhDS2p14MFZuTOJf
	 OO3ecYA5ywBknl7thcRHRAmij82+Xejtl/oHvx09KE+wMK6gKU9eFHdLmaNmdesZom
	 rT8w7Oz25hwAmeY8O40riuOYHmJ75WIbdpBc3sgQE1Ep3aCZpcguCjQW+nKCbBIgbL
	 z8a0Dt9oh51a1dVwCprpq6DiptGGlLes8AFXg8aU8/puHCwH7QRTIt5Yg7NSo2dFH3
	 GjyMRhcBKQR4Q==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	dev.jain@arm.com,
	usama.anjum@arm.com,
	lance.yang@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:33 -0500
Message-ID: <20261109202333-failed-5.15-b4417d08034a@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b4417d08034a7b4a3083e0e2d95429d4542524f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202333-failed-5.15-b4417d08034a@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b4417d08034a7b4a3083e0e2d95429d4542524f2 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:59 +0100
Subject: [PATCH] mm/mremap: use pudp_huge_get_and_clear() when moving huge
 PUDs

move_huge_pud() reads the old PUD and clears it in separate operations.
Hardware accessed or dirty updates between those operations can be lost
when the saved entry is installed at the new address.

The raw pud_clear() also bypasses page_table_check_pud_clear(), while
set_pud_at() accounts for the destination mapping. This leaves the
checker counts unbalanced for mappings tracked by page table checking.

To fix it, simply use pudp_huge_get_and_clear().

Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-30-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0d06d7f37f19a..16e736c72d9cb 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -509,8 +509,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
 	/* Clear the pud */
-	pud = *old_pud;
-	pud_clear(old_pud);
+	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
-- 
2.53.0




