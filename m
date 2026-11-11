Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386766;
	b=T5JwiQR+seJDMyKi5VcL046gGJQ1pHpzCpjRW4RMLSPkT22UI6CEE8/6rvWRXZjVl9u1
	 lsTPSlN6GD1/bC+rMOgMZCgwqqLfoOovbXnBoIWylrcOQ7/x1yVGwz66j7nny1IcSnLfn
	 cEzX5FwH7EgeziTuuiTX38fZZGZL64vrv4x+MVgX8IWCH7WMoR330mGIbjzeUxyayNamy
	 BAjRMshNzAt+xN6Jc6Jdfqys4wcwD7/f5cgxyuzB5FokbHqwiWWsffa8sNfDxQuDD1+kq
	 zekokAeOcLavxw6u0CidKVbnrGHz+QWTVAURBni0o0J8rdlizfLghWoMjo49SQUKEmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/9IvjTxyM4LdWMjExg8wu4Ta4lNWPMsKxY0SwENgoys=;
	b=cC1kepvNCl7B+2Rbb14yTkumxb1uS0gQoE0l0yi26VSl1UiMjd0bmzV087gHo4mETCbU
	 Oyvgv5Aa1gJ1Dltp35z5BQ+TwODiylNLLb9PydUHRBDgJfJCQ75pY5KQzk8fu0ohiquMs
	 PR5ftJI3SvrFzc64uqFFWwp4laHggatiziVw5uR2h3ci31rsv6L3PZCWbsW5VuPEKPKiV
	 4wRJ9Guf4zB7wnQXnPMp2ccUebHq8+asBa1OuczGIFBA/bNbFNjV7RTl2+Z0RFgSPEGYx
	 k2pZzXuZULoCJ2hDmK27/vZnDGEUk0bTGY/VCQwKluysocLpj1fj/aDuVXapjMK189w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="e6Z8T5/e";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E64606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E64606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e6Z8T5/e
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a315ed211so3265520eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794386765; x=1794991565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/9IvjTxyM4LdWMjExg8wu4Ta4lNWPMsKxY0SwENgoys=;
        b=e6Z8T5/eW8FAz0b80jYDGKUHvB4HANfS/VNHF4HoRAMouMzZObLis0iS8oMkcLON8/
         Epw1/gu4leERwGLLZXMq/2xJeJ491+Wa0rJGje6PnY+OsYOOQWyFrssEQSw1wQd/kpiw
         u3UwowBZhvTcPSNJtVwhZDGTMRAsCsIc2cYOuucb1Hs12itWkpTQaPK87QMvtheEx3NV
         Y2YkM9b/PqXIMPCOhmo6OHW4Pu9bDus+OAGFgieBuAKY84KwKAifP4x1yhFUesiu4VMj
         YQZCcutJWnGnO2FL4Cz0vFE2yN8AQh8kfwiEX4h0hwtREzs7DeKKYsa61eVQdfuWdmnM
         fhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386765; x=1794991565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/9IvjTxyM4LdWMjExg8wu4Ta4lNWPMsKxY0SwENgoys=;
        b=iip5qpdfDZUachaJ4bDfe7XkLL0cLF0J8my8tXZ1+QHPBO6RYdFLNNziDrVW1NnZW6
         Zxz/q4gBbc75cAPqwiVahc2KBkrNEASg5ifu96J/Tr8SytCcVEuGSiCLMaccWkaQsUed
         t4TPh29qDph9tynT4SAT5OqWCGF55wB4RRxDYoCBMqyzLUzDxNmubs8+aFB1n3inPDJb
         0i5QQZO93Id1CJze5dERlKDvyz/SIoQ6S0nQhSE95nZOx2YmnOcZDKAfFJLydFCEnbEH
         Kod1i03rmDxcFY64UsLrEyvAFbkyLpXw93Pr3Bs22MeJNO14M4y/iMfCsWcSdXOXoy3K
         bZHg==
X-Forwarded-Encrypted: i=1; AL+hErFETnuqpUe96oFrG0wPvEmj/8lxSjQsW8bVq1XkDPKKi1O3ZC/tPnW+CcI+ljO3uy0A1gpjB3w=@vger.kernel.org
X-Gm-Message-State: APuU4Z89cWw1jnwWDl8PMJdVmbqwGKJT0QquWPy8EXBCyMUb7a9lNXD7
	tYSJFyfPXuL4y3p4AoPwb0ZBxqMc+wcivJGIsHH2zyf3oEZWtGVXExB+
X-Gm-Gg: AYBFou3r3qCIR7c4QlE4ERim0a6hHJF1oJMmM4waIPkdJ2hvaFLRk8KjMWBBRd0Qu8B
	1XxPMzUKbVRSLUdCQ2yO7aaa9unUhyxp433e7K1RuCspmXuupAQ8aHapv2s9DZFEcnUkAFE/N8c
	KmTIQ/Ui2ONPvWLyjuXWaMKhDjyKUzVqaG9sFVaP8rOEF23E9kjvosxZt7sRjb0DcH/XqT0CJOy
	wDhb2osY4dkIPf3s9vIXdEFLbV1UpeZTO+jb/8Ung5L3A3uGf9jongkfuDoS0B0Iwj5ccZDgK6m
	HdC/PiHeY/76PH6XHAieUw2HQqYWqETgh434/D9H+6qzKaNRRB6Ejo/RLue3zo3DSFM3OxBYz8Z
	TKqY52MGgEHUtW7k+giTk1volVstcrGa/MhLq9DKLgRqIan9DJhFTPLLGCEOU1J9XY48pNr9Oz/
	ugL0Q/vPE0UDRH3sRrYNXNW6TiQ+Ctyx6zGJW7nFtixFsL73zBdbaD924WGsKbuhYVEjtLGZykR
	8pvfv+SD0JOfV2WAOlSRl2zujTkD8xDr8Z3pQtMf6BdcgAjULWERPLVv0tnKc/yGFTTMhnQomF0
	Y60p/yAkZ7bqSDc06K4WCrwRypIXg+V1AAHLN1UzRSwzs0aF
X-Received: by 2002:a05:693c:830b:b0:358:c5c9:2661 with SMTP id 5a478bee46e88-37686755b1amr1894499eec.10.1794386764680;
        Wed, 11 Nov 2026 00:46:04 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm12811395eec.3.2026.11.11.00.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:46:04 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/kvm-hv-pmu: don't allocate under lock_l0_stats in kvmppc_init_hostwide
Date: Wed, 11 Nov 2026 17:45:52 +0900
Message-ID: <20261111084553.3039506-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

kvmppc_init_hostwide() builds the hostwide L0-stats guest-state message and
buffer with kvmppc_gsm_new() and kvmppc_gsb_new() while holding
lock_l0_stats, which is taken with spin_lock_irqsave(). Both helpers
allocate with GFP_KERNEL (and kvmppc_gsb_new() does a further GFP_KERNEL
allocation internally), so they can sleep in atomic context, triggering
"BUG: sleeping function called from invalid context" under
CONFIG_DEBUG_ATOMIC_SLEEP.

lock_l0_stats is a spinlock because it also serializes the PMU ->read path
(kvmppc_pmu_event_update()), so it cannot be turned into a mutex. Build the
message and buffer in local variables outside the lock and only take the
lock to publish them, rechecking for a concurrent registration.

Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 arch/powerpc/perf/kvm-hv-pmu.c | 70 ++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
index aa72b96b5a8c..deba59cbe234 100644
--- a/arch/powerpc/perf/kvm-hv-pmu.c
+++ b/arch/powerpc/perf/kvm-hv-pmu.c
@@ -314,53 +314,67 @@ static struct kvmppc_gs_msg_ops gsb_ops_l0_stats = {
 
 static int kvmppc_init_hostwide(void)
 {
-	int rc = 0;
+	struct kvmppc_gs_msg *gsm;
+	struct kvmppc_gs_buff *gsb;
 	unsigned long flags;
+	int rc;
 
 	spin_lock_irqsave(&lock_l0_stats, flags);
-
 	/* already registered ? */
 	if (gsm_l0_stats) {
-		rc = 0;
-		goto out;
+		spin_unlock_irqrestore(&lock_l0_stats, flags);
+		return 0;
 	}
+	spin_unlock_irqrestore(&lock_l0_stats, flags);
+
+	/*
+	 * kvmppc_gsm_new() and kvmppc_gsb_new() allocate with GFP_KERNEL and
+	 * may sleep, so build the message and buffer outside lock_l0_stats,
+	 * which is a spinlock (it also serializes the PMU ->read path), and
+	 * only take the lock to publish them.
+	 */
 
 	/* setup the Guest state message/buffer to talk to L0 */
-	gsm_l0_stats = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats,
-				      GSM_SEND, GFP_KERNEL);
-	if (!gsm_l0_stats) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	gsm = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats, GSM_SEND, GFP_KERNEL);
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
+	spin_lock_irqsave(&lock_l0_stats, flags);
+	if (gsm_l0_stats) {
+		/* raced with another CPU; use the existing registration */
+		spin_unlock_irqrestore(&lock_l0_stats, flags);
+		rc = 0;
+		goto free_gsb;
 	}
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
2.43.0
