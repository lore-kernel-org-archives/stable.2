Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352216;
	b=0T3153wxHjpLhVwHzzPf063ffpcmwo7pfav08YO5Z9+1O+rVc+fXz1EdKPby8G5X0hlv
	 3tOdKJuuk2vDtHvi4UFzsSZlorjsVYCSWhmxzOvE36tJikUiSSvlwlKX4D/bMOQg475ng
	 ww6AAJATOHrdoKKGFEDpJQWcpip6QXWz67JJaS4QozPkSaVnozOIGjHzEchrbpG0wjmt6
	 itE3qMiouA4QTETSz6xNnASs2e5tzgPlV/yYdKVT0hpslgI4DrUv20ukxTEZCDECee3cj
	 HRE7XWbrp7AJQscfDpB3UwpC8nXkhunis/VfwutPe5CPba3c4w7vxUt0RoMLvTBxehQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZW+Y5/QuuIuCaQO3sddm+/qQ2fEFOMrrFGrJfh4lyr0=;
	b=Og1cmFkkPySjJOBc6RAMhlvc5PFiGWNbCZKvoIud9iP54ryrnAoLnc7Bt3nwkL4LWO67
	 ItDchFDILWtImoMV/1RAZlFKG1sc5ialZe4AGP89PoN7PBZHo0yxKHmA/LkCEP2gz9os8
	 AsDvgjJZq5MPV+jtQjNqpknLNI1pTWQ9ic9d3EEtwmgOQPr2meMD7ZdyCY3JIYOcIDbkq
	 vdz74AUJOCWpWCmL2Hf7GH/jaB/4ZsVyXnWpZmfRS5NvuX2XL09kdLjC/5sBfSFwTUtLH
	 6YIzCApLEuOPrt2iM+Eb1refMHV+gmMHo16fhEFixpBChlkGsRArmwD1yM3Dox2yfsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGTNe7zw;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A4606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A09A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGTNe7zw
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b70880c0a4so2898803a12.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794352214; x=1794957014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZW+Y5/QuuIuCaQO3sddm+/qQ2fEFOMrrFGrJfh4lyr0=;
        b=GGTNe7zwXf1NsZeh9fS0UGBzTUsvQNH9QElP81ultxi9WH99sWJjPl0vFpV9pY0XM7
         4603PM6u51XUluhtnueGvJuist9PvucY5A/jT0JhQ74YizGbz205Xx4ibYsT/5yaKI+t
         dbXJ0nGCF70KmjViIqbO0c9SMKbmTkHdW0MlpZJ9/en6trvrPvqm2baYhEHM4jQ2Ucv+
         Jipo88TmrekUyDUWYaZipTE4iljElUC2BP/yvQSMd37Na0jdNW0swbScupilrdzHEKBS
         egWC1tVTlQwX/NRzX6mx6/cVvliYjzg6xOYurUolUBIB2mMMLPoT6QmzlZXIoLeAPLEU
         977w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352214; x=1794957014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZW+Y5/QuuIuCaQO3sddm+/qQ2fEFOMrrFGrJfh4lyr0=;
        b=N7naeAuW0R/MfaVh8Z8g3txQbF4EUdBKUeLFN5MRC/bK0WnhVRCKamaL5+SgYnOfBn
         76R/J+9SZIin1GHc+RnYPfHR21FIhphCl7UoiWKTyV+EXlRvMIaPGSV9b1Qb9uRn8Dm2
         s3hUOI6ulJ0N0jgKm68a6oI80rBOT+izbEk3yZm2xV6et5ZeHpCE3oZLlftHR4x7CpJL
         3VBRXXbvyHQ/XVEkWlxfOuJw2D3bPNm0BlCNgBsj8ihKSOnIBK8GNl0GztklcVUf1mlS
         TwFG8KuYtCfrmh3JbyjI/LTyCPJWgHluFs5RHFYbKBk4ktwU1daswvHcj0tX9MiX/hmX
         G+bA==
X-Gm-Message-State: APuU4Z9TcIphFNsqmg2UI5a2hnU03HMSXlM8HeR6SifdkjbeBVCMBeKw
	SWWINGpNbbp0VZJ3I7CKBvDXQdRup6z7KIBKTV2k3wbPV+/Uy2t41xrg4F/Oh/FbdZ8=
X-Gm-Gg: AYBFou2Wgka/EBmZIXxVcnzvyMJY65BvIB5WNTnQIcz/8T9i5DadpQWQQXfhW974Q+W
	qjwQRJrffRXs0J8ljOJC4CtKZrTIogBFUxCFw8Va89Svdc047T/x4RxHckP7BTeYiJ87rIlTfVd
	fNn5dN03ckUZJU32p2WHNikJVrWxW3hSBhcEWOQ3W1xUb21WR70tENukOE3d9+D78gTgtbAQKUp
	HRf4KAzZPRTxHj1QzWhwqK8ki5CqU+XWdrkkgL8Z0vX/7RilbCZj7imc7ODJfVT/KZ00YWkw2oZ
	Qc5G7F3CQgsX6sPOrluQjETn5NsOQaaYlDCzqCDtesq8D1JPo9HEP7gr0IeU4AsLC4wQHdjmabF
	CXJfMc4GFmTFfFzmvlYP4pxdT4C/bL7OfSJ8dvaOEa2RW5VPwzQlLBDUX3LeQG09pXDc3avCYUn
	MDOh+kjtmdhOiWwsqAjH0jBqbIq2Ff7cSzTfyRaLdNLdfLafFiHdPz6W+ayRJsH22bg/sqyiyIP
	1sWDige9XFZEkMLwQIBWHHOcvw/x6O14Ombi4HPDYHrrI+g0lek/N0BWOtbCBz2ID3kdgsVXXLG
	IQxlzSPLyN24oyMaYMmJTLD0enMVjqRCV6Ay6IGpvIzL82yaizMOgZEZzPQGg9FeyV3DHLQ=
X-Received: by 2002:a05:6402:234e:b0:6a9:a3df:e4f1 with SMTP id 4fb4d7f45d1cf-6b7775f0ca2mr620507a12.25.1794352213558;
        Tue, 10 Nov 2026 15:10:13 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578beb01sm1636880a12.6.2026.11.10.15.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:10:12 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: stable@vger.kernel.org
Cc: Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH 6.6.y] alpha: load the MMU context when switch_mm() switches the current task
Date: Wed, 11 Nov 2026 00:09:51 +0100
Message-ID: <20261110230954.1151961-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107053624-failed-6.6-9b8be19d5dc9@kernel.org>
References: <20261107053624-failed-6.6-9b8be19d5dc9@kernel.org>
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

[ Upstream commit 9b8be19d5dc9525a408942e2e8012873199e7455 ]

The 6.6.y header still contains ev4_switch_mm().  Retain it, and omit the
unrelated do_page_fault() declaration move.  Of the direct callers
described below, 6.6.y has kthread_use_mm() and do_shoot_lazy_tlb();
sched_force_init_mm() is not present.

ev5_switch_mm() only prepares the incoming PCB. The context is installed
by PAL_swpctx, which alpha_switch_to() issues against that PCB on the way
out of the scheduler.

Direct callers reach switch_mm() without going through alpha_switch_to():
kthread_use_mm(), which borrows an mm for the current kernel thread,
sched_force_init_mm() on the CPU-hotplug teardown path, and
do_shoot_lazy_tlb(), which switches to init_mm from an IPI. None explicitly
loads the context, so the task can carry on running under whatever was
loaded before. For kthread_use_mm(), current->mm then names the borrowed
mm even though its context has not been loaded. The other two callers
change active_mm while leaving current->mm NULL.

The stale page-table root need not be swapper_pg_dir; it may belong to a
user process that ran on the CPU earlier, and the kthread's user accesses
can then read and write that process's memory wherever the stale mappings
allow. Translations taken that way can also end up tagged with the
borrowed mm's ASN: ev5_switch_mm() writes that ASN into the PCB, which the
next PAL_swpctx installs against the stale ptbr. An address the stale
tables do not map faults instead, and since do_page_fault() resolves
faults against current->mm without reloading the context, the same access
can fault again on return.

sched_force_init_mm() needs CONFIG_HOTPLUG_CPU and do_shoot_lazy_tlb()
needs CONFIG_MMU_LAZY_TLB_SHOOTDOWN. Alpha selects neither, so only
kthread_use_mm() is reachable in practice. Test the caller's identity
rather than special-casing individual callers.

The scheduler passes the incoming task, which is not current until
alpha_switch_to() runs; all three direct callers pass current. Test for
that and load the context the way activate_mm() does. All three run with
interrupts disabled across the switch, so this completes before any
shootdown can be taken and needs no asn_lock handshake.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Tested-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Link: https://lore.kernel.org/r/20261010142533.974797-2-linmag7@gmail.com
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
(cherry picked from commit 9b8be19d5dc9525a408942e2e8012873199e7455)
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 4eea7c616992..f2032373c9f6 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -132,6 +132,8 @@ __get_new_mm_context(struct mm_struct *mm, long cpu)
 	return next;
 }
 
+extern void __load_new_mm_context(struct mm_struct *);
+
 __EXTERN_INLINE void
 ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	      struct task_struct *next)
@@ -141,6 +143,16 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	unsigned long mmc;
 	long cpu = smp_processor_id();
 
+	/*
+	 * kthread_use_mm() and do_shoot_lazy_tlb() switch current's mm
+	 * without alpha_switch_to(), which loads the context. The latter
+	 * requires CONFIG_MMU_LAZY_TLB_SHOOTDOWN, which Alpha does not select.
+	 */
+	if (next == current) {
+		__load_new_mm_context(next_mm);
+		return;
+	}
+
 #ifdef CONFIG_SMP
 	cpu_data[cpu].asn_lock = 1;
 	barrier();
@@ -182,8 +194,6 @@ ev4_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	ev5_switch_mm(prev_mm, next_mm, next);
 }
 
-extern void __load_new_mm_context(struct mm_struct *);
-
 #ifdef CONFIG_SMP
 #define check_mmu_context()					\
 do {								\
