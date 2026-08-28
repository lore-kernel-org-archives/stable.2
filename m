Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4E220F2A
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787890772; cv=none; b=jbLSzpTixXeD7U+3Sjao2axmh31Lt7Y/lFrXqNiC1rktMjK1xbaSZJw/GSQSwRz6enigIs2K3XwYSR3E/3PUT2BpAlWIDUnVacbuE/by5KyS/NAbiv+1cJ6x3zM59F4CXOWe+YMK/zhOxiAQ5IJKZP8P9qv//1NB/lwW9DWSfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787890772; c=relaxed/simple;
	bh=8TnsSCO6rRn51bAw5WulNUp6C1eYkXeVIKjsJTUUS5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdUjCqc5uMiZ00XQvFd+SLu9+9lxrw9RXuxt9tZtM/qaLYVspeEAvnifjfC59H1Muuxoprb8favabvINnRcNUILszpLCw0+AhCFypfFaKezg4WA7fGiYC4EypNA5GwxUXOjgjEdqMy7W12B0qBYq9aMVNJ2E/sqX/tas4OsvfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kge2OCCp; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kge2OCCp"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66e452df0easo771316d50.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787890770; x=1788495570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GvQBCeK2pDC31wjSOrIf5IPUWWi4fTFaqcGwpyiTbzo=;
        b=Kge2OCCpAJlfS2mY5TQhs8VBrmgVktQquCIQS/WcuzK5w68i4eNFFPb/6lQ1YcJX16
         I29lY6MMqkCSkOR33tEkX7cgLBhvWmkK0RtLvc/iri2HsJAVdmSSS2ueB1YQO8KFsIvm
         FzuFMt5Iq97VKR0sKlv6mYvdnIBIvZRhG6zo+VkakSjQIkEO01kP7t/E8Emh7jdzEhdj
         xL3hQRnf/9h1s6JvHGm3rR5wju2dIlEITEwrD13a8ZF+LQ8rIXeImNKdl0XoqpTzLFt6
         q0Iad1lsL/ypgmFXtolLtr1GOnhTKA6JMYlsIRvUN5JW+vwbh1yUCJlEkloM9LBHFKIx
         H98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787890770; x=1788495570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GvQBCeK2pDC31wjSOrIf5IPUWWi4fTFaqcGwpyiTbzo=;
        b=l57Ciy+I0V73BzJmdFJd6sM2oQ6YLTbQDavROnVh7hM7/UCmkOcyPn3Jx241zH8/M7
         zUV9q96coTIgPrRWgC0g1B4+S9/wV1M6q3zWLAO4jOaXdpdQ31wdJC/stTXgPWEU6UGD
         klRi5+HZb7X6s96mfdgCh321tnI1/rS4efT7/amxbthrQ1zKhOJJCea3SVuqp721eSVV
         FcgT9rQSRqs/TBKuarDY4ry7gIArLWEegF2LFklrUXZcXf/DiXIusT+g6diaMOyNyAji
         lOdGRCvMVNkQZUmhBsLdp7jzEIV1cHiG3oKiCAkkjoEgOv2JYAwbPTYCrh+S1xlnBDf3
         su2g==
X-Forwarded-Encrypted: i=1; AHgh+RpFNfnvdnNDXdkxXXkWE9qwg7+1OuYrPWqisQerZj41KFz9Y3Z4kiKow/X5LLxWaJ/LtoySL/U=@vger.kernel.org
X-Gm-Message-State: AFuF++njCGQj+Sx4Mdre/CsFlcrqPZRdbyATjT9r2xYpZFR2Sawn+OeZ
	RGN+nUQCzqqR84EZH241e1FBG4vsZZ8rRwzUIffAOnLex46ndPu84W+S
X-Gm-Gg: AR+sD12XNLkBLQ+ypSUW4dSnevbMwMl09VQ5TUw7hzEXjuTVmn/6BubCU9qTwZzKuMl
	5QPsNwWpbXr2pLInfoR1jAlNp1gcNstugWc0vdRt3ssodfDsinQ0bYxEupJGhqHFWofehsfClZ3
	Y0DhBPy9+9pgE2W/+pzd4HgX3Arvytyu3wzG/nQcFNm0NQIKgwbsfJS5nRs4kMcM+ADIDIgo7n1
	5C/N0pEeThTdWQBa5l2NhP0vYjDXFblw6u+6kaUZwENgdW7pVfV+LCngOYUOxdqk+PwJ7erCpOa
	PQlQUCia53Edi4VFIMzMduskJh4tKfDw4w2X7+9zt+79BChJrTAMzoQd0KeJPW8rCGEDAWHHTpM
	7KJwdRV2+lEGm1WKk05b3Yl+NTfrbHy+5nRliiXlN4QX3BsHztr1SbgNDhz5eFIgt3U5woqubWN
	fWeqxYlznlZQobdIezWwrN5xSriaZQVrIzjcYxbI1pwVr+Vw0PdhNf1R7D0SdlMuaBLTY=
X-Received: by 2002:a53:c286:0:b0:667:e855:ecdb with SMTP id 956f58d0204a3-66e4c664521mr905723d50.3.1787890769747;
        Thu, 27 Aug 2026 21:19:29 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed2a78bsm290978d50.20.2026.08.27.21.19.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 21:19:29 -0700 (PDT)
From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
To: cel@kernel.org,
	jlayton@kernel.org
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	bfields@fieldses.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH] nfsd: hold cl_lock in client_has_state()
Date: Fri, 28 Aug 2026 00:19:25 -0400
Message-ID: <20260828041925.36758-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

client_has_openowners() walks clp->cl_openowners and reads so_stateids
without clp->cl_lock. nfs4_put_stateowner() unhashes that openowner under
cl_lock and then frees it, so a concurrent EXCHANGE_ID with mismatched
creds can use-after-free the nfs4_openowner.

BUG: KASAN: slab-use-after-free in client_has_state+0x10a/0x140
  fs/nfsd/nfs4state.c:3718 client_has_openowners()
  nfsd4_exchange_id
  nfsd4_proc_compound
  nfsd_dispatch
  svc_process

Take clp->cl_lock while client_has_state() walks the openowner list.

Fixes: 4eaea1342507 ("nfsd: improve client_has_state to check for unused openowners")
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
 fs/nfsd/nfs4state.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 18e17232cf94..8d7a4c2eadbe 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4216,12 +4216,18 @@ nfsd4_set_ex_flags(struct nfs4_client *new, struct nfsd4_exchange_id *clid)
 static bool client_has_openowners(struct nfs4_client *clp)
 {
 	struct nfs4_openowner *oo;
+	bool found = false;
 
+	spin_lock(&clp->cl_lock);
 	list_for_each_entry(oo, &clp->cl_openowners, oo_perclient) {
-		if (!list_empty(&oo->oo_owner.so_stateids))
-			return true;
+		if (!list_empty(&oo->oo_owner.so_stateids)) {
+			found = true;
+			break;
+		}
 	}
-	return false;
+	spin_unlock(&clp->cl_lock);
+
+	return found;
 }
 
 static bool client_has_state(struct nfs4_client *clp)

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.55.0

