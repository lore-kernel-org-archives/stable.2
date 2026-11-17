Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794888794;
	b=CV6VIHYo5siGVWGAzCDjdcRXuBneKVmuSwz1YspuB3EEiA7G8w/VivKWy2iE+wyad/nV
	 Z14OTQ7UDTbiN/CI2ED7Ol9YWLFq8RE2yNIfBTahH1UIzJOPNisMPlGmgdnZ57exqgqFK
	 n/60ntUXGyocwetcUrcVRcKThRWNZh2Dyz1JenGCsjK7WooShLL35nIVuJDK3tupMknBi
	 GnZNrL3EmxnLfHTFyzHK9epBtuMe80bB4giZN4dYnpvjo8PSQha9AgLr0Laos5cW5WHMe
	 5oy5kouiDIkJTgg/e/VsNrTPb7+7oE5TS+rXYfedFLj4AdKWXGwFiHwU0/0YrxxaYkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794888794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
	b=kJoGluNgueGLyTk7nQz/xLDaq0Z69XDXe99bx6ZMzAC/Fl3MIIzjXu5JThcluI/RajF9
	 Xgexg7wNR6s9e9STTmqPDpmzwxFRFR7d/uSS5fPTC6N1Fke9xZW//ArtseGpOQmeUUk9t
	 dn53fcrm9uQgOC4U3YObcMNjbhS6O5tkoykNdwQ+LlSgBDK/Bm6dbUHaPThM7qiBLv6yW
	 /mIGm2nn/rwvg0jikE8FhHj9qQHW+Ae+PYHF65qLAbRfWl0OpO/6FqI+syBoc7FTSBSjH
	 TsYKf5/25jSNg0NapER7+2bAO25xXDBrWoLdI4WsC8TFClVtrfdNd9KwKOOKULZ9HEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lG5AZuII;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E73606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81E73606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lG5AZuII
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a2761c69fbso425009c88.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 20:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794888794; x=1795493594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=lG5AZuIIJascP0svvooQZmTYuY69JAc+MnpbSEymeWQf5XhceIUDTTHQGiU/todZQZ
         itCV+tHmyjyEcTXcpWByzYtRaYH39ygujEIov8l7JKhqzr8SitKV9AHZyADR0VB9ksWR
         XdEp5b5D6hnkxeMMWOosLyTUmJXJGMo1TzwvI8SzzNxli3izP19JBn0yEsk09wwY1lSf
         F56vqXeQP/MN5qPHW6Hn1ogyjGUVvo0EqJcftZs0M69WMVP8BwjxvdrC6sbEKWONOdKL
         FwHior7IgMA9ZbJPehFyDB+MjrqvvIs4mbl7kqn0zQ9iA3/zVMfLe5khvXmGzm0XcmYV
         wKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794888794; x=1795493594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AK+gHSxZdcAvKZ7cQ385RlBq7MDtihQM1tWGeZNK/Ig=;
        b=VhKF/PTgLDi1ZwN0w4IUpNzOVVMBGR5kvWjnhPMC2qnaY2do0tQ7ws1fcDa8bzhA/R
         HqSc7QZU4Twr6PDzH2Muq4RpFGJO9tbwxT07+6pE5GisShqgZgf++smKtM4LZYHaARh5
         AECHcSrxX6eaUeZ59Dc2By+aEo/5Z44hXtATT3xTooBfizdyA6jCmNcmdxxTtn9igSsC
         F10kf3tN1u73Uod8at0QPaT4cXOWCZRT1qLBQnt85PzqYnIYPvfrmJuCMNGLjsJUh9bY
         0sRpUavQkSv9G3PFUd3i2hkd8ZValmciXMoA5HjYELz2p2fP7h3tJxXHP1K+YjCOsjsr
         LVsg==
X-Forwarded-Encrypted: i=1; AL+hErF8O0EVgmztqFYeer7zrfb/KWYFaG4SD/7ubVI++6u+GtiWVU3d3SSV6g3MhbAg/prsW+9z4l8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6Cwf4Zc2UE5W72aXEiGWWJ65j4Zoj+Y0jYBBL8y2dq4QjC+sD
	R+VIhTukWEy+8nqtHWgz3wbaapOk5ideARM04c/HnaUvJx4YhnEgi8PpVE2SM7Af
X-Gm-Gg: AYBFou2a8W/AFx71+8PCsw+vwV/uwpe3JRP1KJa5prJghUYiXU3UgjAeqFayS3ZwHxM
	RdWnVT4XxQYSNo9BiNQ4Maqv1QfyMM7CC0HnejH4WfR/NPINJwZZUKkfqkZfY1Xr943l3iTxLxa
	6tJDFcEpPA8dOyZMaqRc57R8oU/qmvMDfBORKF/6NychOegFuT/0s7mY2mQ1zMdMGYQhiR/A/W4
	Nfc0DK6GmGVRC5BqkNdmZyyyhlMwed8vVwHADGQ0e9lD4cv9XQq8TkZuxQygfxDWNwN8RPhXXtg
	20UvR8vaMoypMZiymb5IdGTjV6p9mrvRLQkPwKHXssKYFaMSeaqEoFIi3StNv151OAa6Bqqrj+4
	YkaKBRfjHWGMt9Hjn6xSb+z61z+wZuSWKIzMKNHPb26lppigK7cVn8E2put0T0Rguy3jMOHNQwj
	o6PS5/y1KZPSPozgw9a09hUY4z8C0AfRx3hvcNJ12Lqlx9FL2PuXPfYTQ8pYBbis4+09Cune974
	WH4/TSy8+wSbEHGX2i4a5+qOxnmtYVWIIFc4jLmuhX3tuTMLVN9Z1jiUqqHGtLjU+LWKDsk+2wp
	jUfqSCjjp4/tcC96qUtDeH0lQbkGfBkXWBfIN8Z57GfbOK7fmPg+dnQ=
X-Received: by 2002:a05:7022:2529:b0:1b4:fa58:9d8 with SMTP id a92af1059eb24-1b5031759b2mr18176689c88.20.1794888793525;
        Mon, 16 Nov 2026 20:13:13 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm40433851c88.14.2026.11.16.20.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:13:12 -0800 (PST)
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
Subject: [PATCH 2/3] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb GFP_KERNEL allocations under spinlock
Date: Tue, 17 Nov 2026 09:42:52 +0530
Message-Id: <871eecaace022e3d49e5afbbeadf0b26d16f10dd.1794887659.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794887659.git.ritesh.list@gmail.com>
References: <cover.1794887659.git.ritesh.list@gmail.com>
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

