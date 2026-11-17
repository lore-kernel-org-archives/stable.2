Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925551;
	b=wOn5j27Y7evwvWHE5JN7yhvQl/GPIPhgB5FikbVQQ6b9kAAm1ZUQKyGSVMog270gbiAQ
	 1vi5F6iS/FdHXVsMOqynM6LDwJ0nD4gpfuEWIIauVHZ3wuZL4PQOTsSK2XfibiifQpku0
	 XF9DxdHJkHcgRNY5Kitnf0KC8ITrz5UFMsx86kNzjb6vju12l8FsjNj4YeqkMw2xTK5At
	 n+m9alLdKiQloGh/M2jDDv68DvMDOhUykBNxdI7DjabwrkpNZSLWt8UiaaqOxslzebo1d
	 BfjWNjWWmQhvhA6C6u+RbiWhVzNl9SGj039VRPrNzTzKCXI1D7UBJLCdrDqCcuHXdVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
	b=zExnyPs7y43/cDT9mo0xl7Hh1vLfOoBVVUwZy/QrC+Yl/WLbGC/mn2ZYnHobqKW4t6WS
	 ftyE8D/6kTbOIi5FCDDPIBiQV+Zj0skKQ4sCkpRrNpLGNUB+TnLq/L3ssL1vGnM4oJSZv
	 91oeAyRWCjXrt+rU/o1cncnrF6pe80sSyWzVGh71l9fw1OxVffbXxVZBQbWRtGAnqPEgV
	 u4OvLugsqz3vcyB9D+s1QeGI9RECrsXfHOrVV2SAC3VL/LvTpSNU77IYnRzn1qeX4X7tM
	 bezfAkIglWaLgrK76/0gHIuI+mA/ijJAC4giaE/XBOhv8eVMLbrlb6zYhEYneX+xPKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f34hIFPx;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC8606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93DC8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f34hIFPx
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-71ac9e15640so2423068eaf.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925549; x=1795530349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=f34hIFPxBpV4kXVxhr38KIhjXIBlnyKMpw4eYk9AZXIaaS75lQCG5xHvOTqlqOf72r
         DsRCS9MDKuhImz+2AUSj9K7JiuFXBU5/UsZYlBYLP3NsjzUy/G0sbdLV9x7QYLrY2E+f
         sH+tvgYXEyrPwN5v3SAj02S0TmTxrWxu8CwGd4V4etXld0HnoLYY31FNkbxsUNtJ23/D
         bHsyT5mrgw/xJt133gORKoqZRYUXP8dqnsmVr9XJ36TKUS/WLS+Bb30i7zPwj61AgD38
         yYWWAoZ4BCsljc+uBh5TRAWJmNX4tTuQfNHICNi0dbE6M/ySvDqb9e2todGULn5ol/ft
         tpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925549; x=1795530349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=a4F0JEkxEkvcqT3nchiicRojBcgCyhUhENrnTyKGZbMI0/0w+L0C4m8I2xQXBQlcWy
         m/RFE9AR6fbHnBwy+Q03Qi47s2zW9hQPpRDLABXgi19NZG0e7XUGQTV0gRT5Mghvk4Qm
         0oZ2h9rl/pEzT3sif3pY+PI9ixJGgVT4bA3XbPfh2s1ve8VqBE65ouJZORtQfDp+E5HG
         +cO4MoQT2LeGL6Y+V17k0sTZs9uP5U9cCjQnNbzATIN0y8dsA1zrd+hXaotxI2QKVUAH
         1zFuoiol5S2LfKFi/d6jBJIb9Qxi61vMuHga7SNhpL9Dr/n0bedB16bzXKBiyCz4Wm5b
         2jEg==
X-Forwarded-Encrypted: i=1; AL+hErEUpXNCH+hCxEqlqApEf5CONj/s/oudXyxj8G8F5SR5XgxyECoHgigWHgtcUkQ+FEbtsEVhsVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3n+jNU7Wv9/CGFv/39Km9Dm28EPEJmIqTO/DJEzuO5yzWjie3
	L65DfyEcD+AXVdUZWcJjh6OsjHQnyV0LFjeWt4t6a+8ssH1arK5+NUGJ
X-Gm-Gg: AYBFou1dCi21r9Xbf04qW84beGyhJvSzjAIMN/88DeyLUku2KnuN9TcezzY96I3pC/6
	vdUelyelM/8vbke+z3BO6TOIIxSlUngC85UybgeoUdFiWIf7tUCoOQriMXk1Z67AFYYXw9r+XXs
	W3c9bIfuWkyfeifC/O+C9r2OLTf+AjOZRPeCb7zzHHLZdEOvTBx9xJkTR7pnFTyBcd+AEwSDN2T
	T/C3DFyGNjDWdLHnm0M/vqgAxL0BRtU1xcmynxRXqCaH6MqtGtjwY7YOYmxaAGgVn2pTDagi5FU
	8rPSV5Ir4uuGHePv4N3BFEHtizMU+8ZOWqBtNymhjPKIHovwqsiAGCcJ/8iKc1svKZcgfBTQb5v
	HAeJOD+ovflfKA6NFBTrpvZ/h1nV1OMZ9/MwNDaHNMccqVP9BbTcxmOMSlkPQ9xuKIaRxOEP9yi
	3ePoTARxEYLu9EJYH6V6maQgP8jGvls70DM9EbGT6DMZzXA5rAj2rCYjVRhfllzTmZGHoMHbvSA
	3wdzYBP43aDzIcgWcn5d8Ezta7aRwbrCGoZuM02lsokzeHfcruut4I7K6Ozw/Xa0GJs90Ni70By
	qnIwrDgZHhzBX23WyMHE7G0mTN9GiNbiGw==
X-Received: by 2002:a05:6820:2207:b0:716:bf6e:a4a5 with SMTP id 006d021491bc7-71ab52173d6mr7833605eaf.81.1794925549512;
        Tue, 17 Nov 2026 06:25:49 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71af0a8a18csm5313709eaf.4.2026.11.17.06.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:25:48 -0800 (PST)
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
Subject: [PATCHv2 3/4] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
Date: Tue, 17 Nov 2026 19:55:19 +0530
Message-Id: <f52c0f92dacb6d9102a92aa9c6059b3edfb694da.1794924821.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794924821.git.ritesh.list@gmail.com>
References: <cover.1794924821.git.ritesh.list@gmail.com>
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

