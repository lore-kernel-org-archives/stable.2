Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633668;
	b=ceChTsQsNJJdx8RK2Hpcbp3JWhDXtiFPu4+3ylSY/S/yDfbsmrziZPThzeiXp1izoO0o
	 zyAOwhrJ3ENhse8coSbFgjvoczNCbSGXxTTKJP72xn4jT7/ue1m8HGa4FZ80UzJVWcFuS
	 V+nkJm7csCwb3bqZGkPwGGTm6chdu6NM/O9R95BLfSAoGOM0AvU+bcTpFfcHegVKgmlin
	 xkgyHyD9cU5A5B1UwgG+Pcj11l6mTYm6oTxqLrhtKOM1r7s8DQdLCLjN1A4pkxnyiJ4iD
	 5LJV748D549EGXTMeNr3Qi7rmbIgP0NAxIc+WBbSF7CG4nvt0kDrjO6Ah4nDGEgQH0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633668;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ssev+d3N/hYw4nDhurPhFsInIDXMVK3Uu74ReL/3pqw=;
	b=F3lVkq7WYteZRsy8pnE9EJ8hImJHxsNFpjh6v/cPpawUKPwBJAHccr1oPSMKFYVIJV8x
	 jxg5BtqaCZEF9mjNaidqikJBR2S2WKvFT/MGCyEsGWzMC1m4d/qLcQcyvrMS+vSc2JRb4
	 UrvZG5cUgrgi4hZ3MGgMlXK26oS5hgU/4IeR+/3AdGbfeuudD5HdVCC/S8L+vRiV7dRnV
	 TZRrktSb+vOs3t5nmB0qWLgOV5KL8lSNOXCn0e6S0f+YY0rJSqyYflOVm9F9/LeKtN3tr
	 v43swtWUIodV2jeUx1E5fy9hjgGMAAewsG4dmi/r/5tWVi5shabPBOSB1jMVUwqYupw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T9q8k/sD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE65606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9q8k/sD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B09B1F000C4;
	Sat, 14 Nov 2026 05:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633668;
	bh=ssev+d3N/hYw4nDhurPhFsInIDXMVK3Uu74ReL/3pqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T9q8k/sDctPERbKnBHl4KuWDyK5emla2NG18jY+lxWGr7DyNFIdJyMYRyY94s9Wg5
	 N2ZLsYIDQWWzTRMqOKoDtniKRYBVwshLHz8qWn2udBA7In5+1YGzY253554ifVkl24
	 HE4UCHa9BP6PicywWgvakDbmy8lsDIPIBDanRP2Nlb4jWGCfjQ701gmQdxIlKykS9C
	 AaLGOHcpY5aKgZHMe0jhgK/pNDlBlUT3oPrfHcacCdDovr4/+ozIT0yiGsEYsd3j+l
	 g/wJiJmUG6nBp7+nMq7fv/rXxW3jga2LyboltH34CdSrfwqmpeiMgv2Txg69XJB5vn
	 PTE5hD+mJ3P9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/userfaultfd: compare exact registration modes before skipping
Date: Sat, 14 Nov 2026 00:21:06 -0500
Message-ID: <20261114052055.3073345-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201334-failed-6.6-05f64f211a25@kernel.org>
References: <20261109201334-failed-6.6-05f64f211a25@kernel.org>
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

From: Gregory Price <gourry@gourry.net>

[ Upstream commit 05f64f211a25f7d9771d4fde109aad97174a1cf3 ]

Changing registration from MISSING|WP to WP returns success but leaves
MISSING enabled. The no-op check sees that WP is already set and skips
the update, so later accesses to missing pages still wait for userspace.

Skip the update only when the current and requested UFFD modes match
exactly.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: apply fixup from Lorenzo ]
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-26-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced upstream bitmap flag helpers with a direct vm_flags mask comparison using __VM_UFFD_FLAGS. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 260d8e5d1724b..ba138f968526f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1490,7 +1490,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
+		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)
 			goto skip;
 
 		if (vma->vm_start > start)
-- 
2.53.0

