Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605991;
	b=DrWkmMN0G5tzM9PVHKqoQsEZeIUZOuo/duB6aN9H2TvTsxIWfLRLSUJDZbeu5J1Cvgcn
	 H8WhxetlYZWqGzc4Rj7PUj+sbYyt/nK5JnkfrpIcSrJESgSPGjEAkNOHOUHJrkfLnDv4H
	 eVbycJidxynaexRDT9w5UI6j3MmzzSKichskUbDgfNCVBJEAj3s+PzkOTOth98SDTbrND
	 qscgjhGvBGYg02YUQXKeOHO9SuYJeingcxxpoCcpPTtwXFvdw/7fu0nYx8w0rvjiIPt/R
	 /Xel8AlWlan1n3DtpZTNowQ79PwlFjHXB91rAnhXzEWUAth2oW6h5yXrYfJ0XA3+Blg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t/NXDxEHWsDao0rnWpCVQG6KZLiH+Zawh7LgTLx2e5I=;
	b=YIafhtrw1YYiqh7bnIbdjeKnDxjDNANz7eB1409KwCOYifUK8rI85RmSHAfQIRPWbkW4
	 n+6ehv2nHhZBl7GFouc3KzvtA3HgPC/g3qB3ua/r3jSJI3iQv3J6SNDG0yR/NiJTtdmQj
	 0XF1fXGe1kEQHNqKVMLAW2YrY6TtXSG/WJZ2KaMRlsH6eS6mgmR13EhH+jTNALir3BJ+U
	 DMwXeXtW8RjWDVJcWqE/H4jt1IlC8e2rw/KyQfd24+ViRc9W+1Iiu0XUbICvyNTGHumzB
	 XNv8wyr9GM+74J7Xf0NbEtgJFc2NgxDEOmGMjNUcA31MgwLz1kpFp+85YUrjJt6uTmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YGis0H9z;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9D606A685
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA9D606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YGis0H9z
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-380c28f9e35so6779064eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605990; x=1796210790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/NXDxEHWsDao0rnWpCVQG6KZLiH+Zawh7LgTLx2e5I=;
        b=YGis0H9zPpnomUtOcSt1o1Halha0XPoZ9N6HqjtFNkZ/IWNmk5D5cemWJkeBv9OFQH
         xygjJFfoFoQ0VpjXNITy6sc91CsWjw6r2gIakp7XNeHAday064EikUPwqmxFievKGkYF
         Q3Ma0x0XOAEM/arBTOKQ9XtPpoTy7BixXwNZUskz/LBAnW6rwvkshEUqH+ni0hz3Hall
         +CjCo/LTqgFZ6O4d4heTNh49DQ+/O28oVBAy6P7bR4Jp/ir1PYL7DnKClt0iy08mYG4m
         FEn6uE3NLHgDlNzgYAAUVw5qyXyxk0kTr5tV7ynbgd+MV9ycxJqwDW3zPnH7qnXptFBH
         nrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605990; x=1796210790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t/NXDxEHWsDao0rnWpCVQG6KZLiH+Zawh7LgTLx2e5I=;
        b=SXNd/QDJSovQHm1cPSN5UOF9i2Rcm7VAoWDWA2e0KTnZlXvI+i6mZPcczHpbcRzNt6
         g72mWhkci0XtCNp9g0kKiE+MekWDhXwjFvFY4zUmIIDRV0QvqVJotSZXijBljuJcMe/4
         eMGfd43sapu9psQv1uBrCvfiL/XLIvJ56zL95FPZ9Dl9vrhrCrqXHTJG+Sm1hwsWrtoe
         LCTlywJVKPAHCu/ci+1Bqb2nOuzyVlAs3m7BMfWvJf9U5SqVVlbQejMge3DqWo9Mdk9O
         ruK8XqsYJraEm8RAwo/iHUBKd89MKJ3HfJ8KMfsFuCezPDg4+i/0NfXGr3FnthfEAEP1
         lv4A==
X-Forwarded-Encrypted: i=1; AL+hErF7Hfec1/zGgVPTAAypY3XDTyYz/v/jcPdphvHQOxyBlCGbAxMiwpdFmHXixqkwea3WSRYonLY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9u9mm/Fiw+sgPuhg3m0FyVLyQghxTkCW/g37ptqkir+kbEVtlH
	uoW7mLnNTD9AtIniycYSIyb9T6f2ZllMFBBgB0a+BiGhJo7ArcO8D99r
X-Gm-Gg: AZFdTZcZ8oSLFJRmVXWmG7ltnE6LxhukpPpp/XxNDqP+edTdGW1R08TTfmLkJ2smMp+
	9g2IO0bAoGBfVbnz1GL9loLZqlRUP16qhGyU4aMhNZBBwtiXvY+szbnI6YuZ+fV6zp2RH4HSc8e
	HBohq3pUUzOWMqegY+2waowyVYajCuGzSy7rAi7qSPSP2Ipjhz2qpf2XrjObJJ2Cm//2Oabz9am
	oZR5tVwGVDQKawJOd+JauKXUTJLngioXjvE5RlvOVzsvBmDq/ZkUMYQHje/ykyYMqfD9b0m4M52
	wd4K+4e1Aet1oKAc81x1OxNjyl3uMNtE/3tcztEg2itSPiboxMkIzYeTXTCZRqC2TQCgDun/Ch/
	nxqtUJIH8yo6pmykBS7xT2vyXFsEvwSNDQXr7E17z50FyThfXx5ly3An4jhKJKvRzQOuFNQ6V9d
	pmyeQdP5fYeaMVgfWhtBIDZqc0U334MqN19jA1wEdf1QXFmZp/wmFV072s9ctrpgDR/R3c1mwYM
	AfcDYBeO3MZuC6r2nM4eOvI5fVCne80tZyRQRJleJZRu/KaaDlLOgN21Clnr88dENyVwtyRR481
	qTwQhvUu56SSJ64ShYD/J2ihh7MnKIfvlw==
X-Received: by 2002:a05:693c:414d:20b0:382:cd5e:dc9e with SMTP id 5a478bee46e88-3869a1501f1mr16719896eec.13.1795605989447;
        Wed, 25 Nov 2026 03:26:29 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm11778380eec.17.2026.11.25.03.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:28 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv4 3/4] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
Date: Wed, 25 Nov 2026 16:56:05 +0530
Message-Id: <3847b27ac12ae19b2256ff1e025304d93af2d739.1795603946.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795603946.git.ritesh.list@gmail.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
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

kvmppc_init_hostwide() takes lock_l0_stats with spin_lock_irqsave() and
then allocates the guest state message and buffer with GFP_KERNEL. On
a nested API v2 host with DEBUG_ATOMIC_SLEEP this warns at boot:

  BUG: sleeping function called from invalid context at include/linux/sched/mm.h:322
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  locks held by swapper/0/1: 1, on CPU#0:
   #0: c000000004ad95b8 (lock_l0_stats){....}-{3:3}, at: kvmppc_register_pmu+0x50/0x270
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.4.0-rc2-00028-ge5a8bf3a3ee9-dirty #124 PREEMPT
  Call Trace:
   dump_stack_lvl+0xe8/0x150 (unreliable)
   __might_resched+0x190/0x30c
   __kmalloc_cache_noprof+0x4dc/0x760
   kvmppc_gsm_new+0x68/0xcc
   kvmppc_register_pmu+0xd4/0x270
   do_one_initcall+0xac/0x48c
   kernel_init_freeable+0x3cc/0x7f0
   kernel_init+0x3c/0x274
   ret_from_kernel_user_thread+0x14/0x1c

The lock is not needed for the allocation of gsm and gsb buffers.
Allocate and fill the message and buffer without the lock and only take
it to publish the two global pointers.

Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/perf/kvm-hv-pmu.c | 65 ++++++++++++++++------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
index aa72b96b5a8c..a58634f656e9 100644
--- a/arch/powerpc/perf/kvm-hv-pmu.c
+++ b/arch/powerpc/perf/kvm-hv-pmu.c
@@ -314,53 +314,48 @@ static struct kvmppc_gs_msg_ops gsb_ops_l0_stats = {
 
 static int kvmppc_init_hostwide(void)
 {
-	int rc = 0;
+	struct kvmppc_gs_msg *gsm;
+	struct kvmppc_gs_buff *gsb;
 	unsigned long flags;
+	int rc;
 
-	spin_lock_irqsave(&lock_l0_stats, flags);
-
-	/* already registered ? */
-	if (gsm_l0_stats) {
-		rc = 0;
-		goto out;
-	}
-
-	/* setup the Guest state message/buffer to talk to L0 */
-	gsm_l0_stats = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats,
-				      GSM_SEND, GFP_KERNEL);
-	if (!gsm_l0_stats) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	/* allocate the Guest state message/buffer to talk to L0 */
+	gsm = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats, GSM_SEND,
+			     GFP_KERNEL);
+	if (!gsm)
+		return -ENOMEM;
 
 	/* Populate the Idents */
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP);
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
-	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
+	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
 
 	/* allocate GSB. Guest/Vcpu Id is ignored */
-	gsb_l0_stats = kvmppc_gsb_new(kvmppc_gsm_size(gsm_l0_stats), 0, 0,
-				      GFP_KERNEL);
-	if (!gsb_l0_stats) {
+	gsb = kvmppc_gsb_new(kvmppc_gsm_size(gsm), 0, 0, GFP_KERNEL);
+	if (!gsb) {
 		rc = -ENOMEM;
-		goto out;
+		goto free_gsm;
 	}
 
 	/* ask the ops to fill in the info */
-	rc = kvmppc_gsm_fill_info(gsm_l0_stats, gsb_l0_stats);
+	rc = kvmppc_gsm_fill_info(gsm, gsb);
+	if (rc)
+		goto free_gsb;
 
-out:
-	if (rc) {
-		if (gsm_l0_stats)
-			kvmppc_gsm_free(gsm_l0_stats);
-		if (gsb_l0_stats)
-			kvmppc_gsb_free(gsb_l0_stats);
-		gsm_l0_stats = NULL;
-		gsb_l0_stats = NULL;
-	}
+	/* setup the Guest state message/buffer to talk to L0 */
+	spin_lock_irqsave(&lock_l0_stats, flags);
+	gsm_l0_stats = gsm;
+	gsb_l0_stats = gsb;
 	spin_unlock_irqrestore(&lock_l0_stats, flags);
+
+	return 0;
+
+free_gsb:
+	kvmppc_gsb_free(gsb);
+free_gsm:
+	kvmppc_gsm_free(gsm);
 	return rc;
 }
 
-- 
2.39.5

