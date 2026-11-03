Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718411;
	b=5dtWkJV7A7CvIsLv0bvLKzchvVWBccX721FXWYRtBE/oE2gQs1WzLoZGDa6AHE4rp1RM
	 9K+bSWurHGvBUP25Zh41Ya8YcUcTmWph0qEUjyCJrHqb7Nyi6uEVoR9r1bMG3q+emhUDy
	 1lpAVuYOdpp/aGh1QvOZQ8cHDe+OFmSLhlZ08co8+v73ytvlO1BxPo0cGU9yz72VPKbMo
	 /+wgd2XLux+4ZaORNT1KrM4pQVSzqx9TQD7ZLZK3jRrz36q373wV4Px0hn+M2i+3qkWlV
	 mM4OMh9Nr+hSQ7G6o2PD8grh4hfQXbK621Dn0T4D70NIscs7vB+cLIA6MHp5amZIf/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718411;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dwcKPrRCoG0e2DBbHajp6Cl4HRcuIgwe2pYa284QzXA=;
	b=zEwabKOF8ihNZXfPwnXR2e/nFEDpaJPeDbItyJSTQzCtunynOkgWSpWGIQDwUEQzWUrb
	 ODO7bCoZ8EnPDISTHM49Cc0d7N19sVcvFvuqXO+fTnB8U8W7naDbt6trp+Hv6bAcETkAG
	 Uu7O9Ti4sCLKHnI+pIBl1+usOAhNdjk1yai0iqhPpVhcKLd9tA8Rot4QgCKBdNgTuCrd4
	 I6T1k9C3HPhMBatfcv9bBRoWgJ2BHbwGXEVjEJ2jOmhQSUAoJnf5p67sPiw1aLpeQikWY
	 PNFkHDEcp7+ybfRHuixjYQpyN4+MVcPcxXojfWo4+vm657XpZX0S5xu3fKI0r6KOD6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpC6yKbv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AA606A78E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpC6yKbv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E4A1F000C1;
	Tue,  3 Nov 2026 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718410;
	bh=dwcKPrRCoG0e2DBbHajp6Cl4HRcuIgwe2pYa284QzXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JpC6yKbvPUzHwolMEOtPXIXJTNJzq+xFBn4fLoszlTU4wyOZ9rEJwo4RoV1LTfvDx
	 vUAJDfHaYUGvdxrxNN2cD5axPuIhBdmH+8yIkOhLoC9n8Qk9UKuRvAw/dAenV7SxLP
	 4PJ+D1Z5xa/BH53mgXz61uhJR5CT0FnjJ0gyQOo1h4cYX53K/i79jSsdwHQZoc6EN5
	 4JENt/Yb6bdRSeJW67S6/PKnmxq5Et5DWj1s+2co9DmnaS2ZVYqch1j/rA76hcg6Cf
	 9fAfm9WLOwxD/ReJ4TwJcN4jCN5YjqYwCKurf6dJ9pra+Pzs0yX7CJtHVMgrzYvuBs
	 YHSa4BKW4upmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giorgi Kobakhia <gkobakhi@asu.edu>,
	Xiang Mei <xmei5@asu.edu>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fix overflow in dacloffset bounds check in build_sec_desc()
Date: Tue,  3 Nov 2026 10:06:48 -0500
Message-ID: <20261103150640.243909-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110348-unselfish-dinginess-65e2@gregkh>
References: <2026110348-unselfish-dinginess-65e2@gregkh>
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

From: Giorgi Kobakhia <gkobakhi@asu.edu>

[ Upstream commit eb96e2a0e817807c48dc8387ca6a5249fdeae3a0 ]

When the large dacl_offset is provided, dacl_offset + sizeof(struct
smb_acl) overflows on 32-bit builds and the check is passed,
Which makes le16_to_cpu(ppdacl_ptr->size) read out-of-bounds. This
only happens for dacl_offset in range [0xFFFFFFF8, 0xFFFFFFFF]. So
the oob read is max 8 bytes preceding the allocated ppntsd.

    unsigned int dacl_offset = le32_to_cpu(ppntsd->dacloffset);
    int ppdacl_size, ntacl_size = ppntsd_size - dacl_offset;

    if (!dacl_offset ||
	(dacl_offset + sizeof(struct smb_acl) > ppntsd_size))
	    goto out;

Commit beff0bc9d69b ("ksmbd: fix overflow in dacloffset bounds check")
fixes similar checks in other functions. But leaves this one out,
because it is only valid for 32-bit builds.

Reproduced on 32-bit ARM with KASAN, by a client sending SMB2
SET_INFO(SEC) with dacloffset=0xfffffff8, then QUERY_INFO(SEC) on the
same file:

 BUG: KASAN: slab-out-of-bounds in build_sec_desc (fs/smb/server/smbacl.c:1105)
 Read of size 2 at addr c2a273fa by task kworker/1:1/35
 CPU: 1 UID: 0 PID: 35 Comm: kworker/1:1 Not tainted 7.3.0-rc2+ #5
 Workqueue: ksmbd-io handle_ksmbd_work
 Call trace:
  kasan_check_range from build_sec_desc (fs/smb/server/smbacl.c:1105)
  build_sec_desc from smb2_query_info (fs/smb/server/smb2pdu.c:7676)
  smb2_query_info from handle_ksmbd_work (fs/smb/server/server.c:160)
  handle_ksmbd_work from process_one_work (kernel/workqueue.c:3401)
  process_one_work from worker_thread (kernel/workqueue.c:3473)
  worker_thread from kthread (kernel/kthread.c:436)

Add overflow check.

Fixes: 8f0541186e9a ("ksmbd: fix heap-based overflow in set_ntacl_dacl()")
Cc: stable@vger.kernel.org
Assisted-by: LLM claude
Tested-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smbacl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 05c7682257571..589aeb80ff9ad 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -973,9 +973,12 @@ int build_sec_desc(struct user_namespace *user_ns,
 			struct smb_acl *ppdacl_ptr;
 			unsigned int dacl_offset = le32_to_cpu(ppntsd->dacloffset);
 			int ppdacl_size, ntacl_size = ppntsd_size - dacl_offset;
+			size_t dacl_struct_end;
 
 			if (!dacl_offset ||
-			    (dacl_offset + sizeof(struct smb_acl) > ppntsd_size))
+			    check_add_overflow(dacl_offset, sizeof(struct smb_acl),
+					       &dacl_struct_end) ||
+			    dacl_struct_end > (size_t)ppntsd_size)
 				goto out;
 
 			ppdacl_ptr = (struct smb_acl *)((char *)ppntsd + dacl_offset);
-- 
2.53.0

