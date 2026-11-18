Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032804;
	b=1nV0ioSe/laVgI/xbtHANega8ZnKILLmRlJKejlfJRkH8/0OHYEDnP78o+DPG6fUmJO+
	 O6JGlRsxzB1fnDdRZvQ5fEHg+4G+Ob0hRDXx9PLx0lZPhz3jq/w0uAjWxqJutyg1XcFoh
	 sj+U8bSjZ/hJrF472wFZjseFTCXgaHypxyqn6b9XIFgACeXtUOBn3D6Fbt0d3CDW215Gs
	 VkXrWNqkvTawbo/1kATkDyLJjiw7dgSN2JeOatd5v/kiRWw3XaS/ykPhBps0XlNPkbcEu
	 LKCz0Whifwxb64xoparBKoIOTpAOOmisk3Cjvcj4JESHfBj6fYrpXKFvL3DI9P9lvkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CWo9gG2M1aL8kOtpEn9bnir/HcJAmR4CCoFL4v530ak=;
	b=45NTiKV6s3md3fHS2KmntZIQt4HStkt1Oh3AB+b4Pxo/FIBFDfOYCIHf7KNvURs0qfAF
	 rXCVMLmIPrvvufY7aJBfgknWmcVpOD+WLg3HXyHGSGRKVk2aQDiQ04Yyq7TWC+3pPcR6Z
	 Dqwd7d3JU15clejv+kjTf/UPcAHJx4KC3M5R9PbJ6ee4VPG+Iwpt9zWeT1ipoK4+cS+nT
	 oilsdrWYFa15zfDV/Ovws7GshfVIgSVtcS6DPfJuGD9Xa2ytkeGndK4X+lA0LNj5ASvZK
	 LT779zRsm5rF/QweAyENizFeclAWK6JDOORpqtK7Z0nsl04eIkcPi3dEnC7ZpNnsWRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFoe4SGS;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389E606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 20:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9389E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFoe4SGS
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so11226525e9.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795032802; x=1795637602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWo9gG2M1aL8kOtpEn9bnir/HcJAmR4CCoFL4v530ak=;
        b=RFoe4SGSoAriNsO7IBJF+93KSgN7VqcuHBIqO/XDArIqXiKGxaz9iQNC9Qqix7DdlV
         xAWFF5MI8jkawVifyg8d0vzokL84+v3zLoLoNvM352wDBwYSn95qnzdl7h1fcjruenRO
         uDaig58D01pppI3Fjm4VYEIqKvkPPnEReWN8GE1FejzlIJVmPAuAKusdOhY/9umO4+yN
         j45sRvIvdmd23/yGunQWXb64EePXYy9GOw8L/bUwMITt1sD3gZ7S/N75gJWDsTPP76d0
         yrxLez2avHI+QHpEQUEuXTZTxaqhn1Bf0Mtwb4dgB9v9MTVsG3/dKJI8rIG7nBsllIB7
         Dyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032802; x=1795637602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWo9gG2M1aL8kOtpEn9bnir/HcJAmR4CCoFL4v530ak=;
        b=G+7BXrfRvYqrIKUw8Wg8+nxcVGEaFWSSQwi1dTqatQlIM8qez5ZAQ54SnH7RI7XVVx
         MC2KAsbp3gilBf6B2k+9MzsXcS7XljatbolUoyx+VhbfGWGhlq9M5qkkvHtmpt/EWcT3
         qAHCnfslO5Uj+rZ/p+/YcPf4wF1mI8ulmEKd0tl6XDTifAM3EeOneAcXXDEe1+KsA3iM
         dJEGW+UfIB5DDMh1182T0hLR+xIh4Ajid5uqvFffJSG5dL+GPzbJfj35abYgSZ+THDPJ
         qmaC9XSF2iMET0S0Yg8rPTTDc+x+JJqqGh5R+OMrSsdas6Ca8MR3Q5Z2HwT1d6HXlMmX
         oDhQ==
X-Forwarded-Encrypted: i=1; AL+hErGbKR1Wrezm6acASWEepYqbdnxHhPT27ElH1Jts0EyddDgEpBYEH6vHY1KlZdZcNE/j6g0VQy4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xE9Dc9lJUmvb19aeeF3YWeNXW9/q8LDfQ/e7h81rfrU1xhzb5
	ElQZ6X4XqOIPQTB0Q4T+esRGzCjuSxCe1TJqzhhubusSjfpCn76ERBth
X-Gm-Gg: AYBFou2VQJFF/YKJYs73qFer/9Jh9vt6f4hTzANIZ2lzbF1BMpiaY0Cj61jTRx2mNW3
	mLKyCx3IKYhkEP3Z8kG42YLiCI9+7qky2gNRFq0T9BXg/lqiEkqMltn8ttYRLDMGBp48GGXuhmI
	wVuCPSBmz4sUrhOucOKhXJ7bp3dwsNuwB7RKUy5ZyNpdq2gFG5468q0IVNFccPe5WqDDH0OAoMt
	ZCgTx9AP/176yTf+0fL5DCcp7IK0ofKCp/mIz2x/LZ4528p13pX/tmBDr7tBD4kOHaYn+TwcWwt
	qyC15pOCM8riY1qF3jdcNfEIP1Qoq7FXSB3kvPgnms6M49JLL/XKTQAtz9tsIGZO0YaObhLo7mz
	kT+V5zvUXkFEJYWQ3LkTHMUPc1wt/YO561FLARUCaF910bKQkbisMMtioVbq7Lbk8/3az0VURc5
	7Tq16Prxz6hID4QrSv3AuKXlmNqpKw0JZafcECjtznFY7+gSMz09wV9foEgdx5on8LegUlJFmJX
	anZe+afCaESxBd3wT6Z/vq/uR5nFd92B2xxWdI5sg6q4vYv1YGm8435nqi7CfT3eBxNteQTxN4k
	RiMIQWcorFbkDQw46c2FZMUFYRH9BADyKw==
X-Received: by 2002:a05:600c:3492:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4bb7da1a5b8mr67234445e9.15.1795032801596;
        Wed, 18 Nov 2026 12:13:21 -0800 (PST)
Received: from localhost ([2603:c027:c000:3cde::f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e588eabsm47120145e9.3.2026.11.18.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:13:21 -0800 (PST)
From: Louis Sautier <sautier.louis@gmail.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>
Cc: MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: Fix out-of-bounds cpu_msix_table read on CPU hotplug
Date: Wed, 18 Nov 2026 21:13:16 +0100
Message-ID: <20261118201316.326943-1-sautier.louis@gmail.com>
X-Mailer: git-send-email 2.56.1
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

mpt3sas_base_attach() allocates cpu_msix_table based on the highest CPU
online at probe time, but _base_get_msix_index() indexes it with
raw_smp_processor_id() without a bounds check. Once a CPU with a higher
id comes online, I/O submitted from it causes an out-of-bounds read of
the table. The value read is sent to the firmware as the reply queue
index. When it is not a valid queue, the IOC faults and I/O fails.

On a SAS3224 (FW 16.00.01.00) running v7.4-rc3 with KASAN, booted with
maxcpus=1 and CPUs 1-95 onlined later, read-only fio pinned to each CPU
in turn triggers, on CPU 1:

  BUG: KASAN: slab-out-of-bounds in _base_get_msix_index+0x1de/0x230 [mpt3sas]
  Read of size 1 at addr ffff88812fdf51c1 by task kworker/1:1H/1528

and, on CPU 16:

  mpt3sas_cm0: fault_state(0x1500)!
  mpt3sas_cm0: sending diag reset !!
  I/O error, dev sda, sector 3873068048 op 0x0:(READ) flags 0x800000 phys_seg 1 prio class 2
  mpt3sas_cm0: removing unresponding devices: start
  sd 0:0:0:0: [sda] Synchronizing SCSI cache

Allocate the table based on nr_cpu_ids instead, and map every CPU in
each reply queue's affinity mask, including offline ones. Managed IRQ
affinity already spreads the vectors over all possible CPUs, so a CPU
onlined later uses the queue whose affinity mask contains it.

The online-mask restriction and the bounds check added by commit
4a8842de8db4 ("scsi: mpt3sas: fix an out of bound write") are no longer
needed, since the table now has an entry for every possible CPU.

When smp_affinity_enable=0 or a reply queue has no affinity mask, the
fallback path still sets only the entries of the CPUs online at probe
time. A CPU onlined later then reads 0 from the zeroed table, and queue
0 is always a valid queue.

With the change, the same fio test runs without errors, also while
CPUs 1-95 are taken offline and back online in a loop. With maxcpus=12
(12 reply queues), I/O from each of the 96 CPUs completes on the vector
whose affinity mask contains that CPU.

Fixes: f92363d12359 ("[SCSI] mpt3sas: add new driver supporting 12GB SAS")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Louis Sautier <sautier.louis@gmail.com>
---
The table is used when there is a single blk-mq hardware queue, i.e. on
SAS2 and gen 3 chips, and on gen 3.5 chips with host_tagset_enable=0,
smp_affinity_enable=0 or a single non-high-iops reply queue. Gen 3.5
chips also use it for internal commands. It is not used in
msix_load_balance mode.

SAS2 and gen 3.5 cards were not tested.

This patch does not fix the fallback path in
_base_assign_reply_queues(), which walks cpu_online_mask without
cpus_read_lock(). A CPU going offline during probe can make
cpumask_next() return nr_cpu_ids, and the loop then writes the byte
after the end of the table.

 drivers/scsi/mpt3sas/mpt3sas_base.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 5c957044eded..b33a3e49608d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3264,11 +3264,8 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 				goto fall_back;
 			}
 
-			for_each_cpu_and(cpu, mask, cpu_online_mask) {
-				if (cpu >= ioc->cpu_msix_table_sz)
-					break;
+			for_each_cpu(cpu, mask)
 				ioc->cpu_msix_table[cpu] = reply_q->msix_index;
-			}
 		}
 		return;
 	}
@@ -8409,15 +8406,18 @@ int
 mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 {
 	int r, i, rc;
-	int cpu_id, last_cpu_id = 0;
 
 	dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
 
 	/* setup cpu_msix_table */
 	ioc->cpu_count = num_online_cpus();
-	for_each_online_cpu(cpu_id)
-		last_cpu_id = cpu_id;
-	ioc->cpu_msix_table_sz = last_cpu_id + 1;
+	/*
+	 * Allocate an entry for every possible CPU, because
+	 * _base_get_msix_index() indexes the table with
+	 * raw_smp_processor_id(), which can be a CPU brought online after
+	 * the adapter was attached.
+	 */
+	ioc->cpu_msix_table_sz = nr_cpu_ids;
 	ioc->cpu_msix_table = kzalloc(ioc->cpu_msix_table_sz, GFP_KERNEL);
 	ioc->reply_queue_count = 1;
 	if (!ioc->cpu_msix_table) {

base-commit: 141b164bbe186423e295b139e40e8e2d11cf1341
-- 
2.56.0

