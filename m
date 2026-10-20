Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520564;
	b=m6rJFPp8apid+FNJrHaQtk2WcNIuRLf4Sc+16ZC7tUk/c6ZG8/NuCpk1Rzao6xIrEdfY
	 XrapHmj/ZfBPRhGiRm5JAeKAZb11vKdV02lkbR6SRgBmsp4joQiNmjMhnmvEqu/Ir4XD4
	 YHGF1AW3PiOVjjqjAAVl//21Nr0O8hVsf6vuMGuFFT39ey4aZer035+5054N799aTYR62
	 a8q2xpEHPYUnCJxaUiw8o26E5Ea5StC6V0vZtqgwkOPi85Hz9Nq9JLMoVtX2fgW6h0Lwv
	 j6hqfTYEHq6sPMQltaKkSqdgGjEXJ5EGr8e2b1Gr56EimOVFkyOqW/0/oo/u+0YXoiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QBkELidHnujeG3xBjThPr+adF0FJwgUwsd5WBy30Lkc=;
	b=NmctDYSFG9tjp5tGHdN3aHR41Oz6HQ57Hsl7YHkwyR35HMtlFAqzFiZidUnXidZJWTJ7
	 dwr4HfNmCm1kS6oC4kpCoRrQIPIiHtYrngtpXvKgIKxqEbTYjuVp4MvJz0zF9RxiL6IKg
	 i5Nps7aB0x6KEIayx05TL1XlZIzeY6iVVuB22DJHhctMhFqWO9DgbrXs3FcIw2q9kONkh
	 C8XYsc/0OTjZn1KrW9e96ZJvGVuJCjcy/vsrm3PDOkRu66V1qlouhCBHXBJegl1NferDo
	 7M/v6zTx4Fn3UDqi8mcqdlEpo0+ms3zKEUctUPMTjkuovReePB+BhJl1tTO0PocE9RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UCiKwgE1;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C4606A326
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B63C4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UCiKwgE1
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3514b90bb89so9736886eec.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520563; x=1793125363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBkELidHnujeG3xBjThPr+adF0FJwgUwsd5WBy30Lkc=;
        b=UCiKwgE1munICdPucccsS61rgAr8sNDaXJOSU/TLALuS9a1Dr23yGosoCSNij4gb5N
         aMItYkFB9I8uAu5e5l+qi7ilgNrv+u4c8WgoXeTS2GplpXRa/KlRUxzGg2cl+GEGAuEe
         pfHXIe5HE5dtKMBixNO6bpP/CdhGjFqSW0Wg29BHp8X704DryyV1PnCKszt4YDmpZyLS
         IbIz4GjiQxwRTdUwFuZbSaEv5et6adr71xuAb+NOjTVvvCgAgMwK5hFVWtP/4DHYs+xd
         Ydjy65sfKvXYuJcbyZ+TmlK+G44mejeyiWB5i58vYOXiJSAyxZ6YImS5hyFm8+g5Mew/
         DPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520563; x=1793125363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBkELidHnujeG3xBjThPr+adF0FJwgUwsd5WBy30Lkc=;
        b=oHQDbpi/fGEcPHgQ90MkoEU3QYT002R5ZEBdRTjh9Y9TwpkpugW0jan9u7SuqPVp/w
         Nm59X7uyXEZeN8YsVItsKlrtoqfz2vr/leLjKyrygm90GlWG/+SZgRdNI76Ni/wX2LwU
         D8iKj5bsXcuwZxGuitYZmHMu5CD11N+kPOlVc40TrAqktBciRHCuJdx/zjoj4sp71rEE
         7vFV4mdTRJj6a1mbSU82gn8hXumLj5A7M5T/5rVUU62PqBKQPZuPH2lkC86XgBtY7gM1
         oWC+oHr7kjqLrC46lz0IJzK6HKlW1+YD5HB1uIC/VTnr4O/TdFcvUXnePUIKzNYulIgP
         oUyQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8CXgQbNPvFB2qu2pXZkdFvLJVWBOcK3LXkegBaKHBEYGPqiuBLUWpcfcHQ8/hi+swnnwhQxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIE2bv+iV3eBpJEgywt6p4XwySFgWuPHrP+WTxtoESAyPZdbZ82
	AoY9Fms7HA8UpVcxjiMcHFUd2zW3miHhzJbJsiNX5ieEcNTRXm7HFJ1UpVzgetEb
X-Gm-Gg: AYBFou2eqHGzm8sa3OsGYIX6GLIPYHf/a5B9VoDrT1acC1ZuIe5STv5FfRfkucdmJjl
	Lgqa/HjqSCqO2voXOH1XIhKUt/VFz88ai7w0qlAexY2CxqPfXVSMjYp8XwMT77wx/uzwge9Ej1t
	YZHgBnkMAhZI9qmoe7CTHBjnWjPm2UmkcpKEaAfu++i8eI1lSkiBDWpu3cs5wtJrIWG/zjU+8OR
	l6IA6dbhj4fG6wsjxb26eMJlhQ8dCE5b88CitRz5NQ7axwWiC4f84xek+Pu/o4DB52Ph+2H57Kw
	WIh8aqDnKSs3Bjoc5VCLWFTDXR1sj/ZnnTyY9nFXFOwj3rksnbVDJHCoKlquUeJnRFZicHPzLzn
	s/KzgIeKEu99tCXAh6flZ+ECTO5mbXFFZr1aMcDEMmJoD9VZlbHiyvFqRDaMA9UpFKBKW7XL6z/
	M7dhSUcMS12turAHDYLV3gyNh4l0W6TtaLbRF6fBtfzV0IX//MhRC8hklC61Hq9RlFrptTt3JOu
	3XAfgX2rY9ILry/Uus+1J4AA52G5i2Cl6f4KsimaJ10MlQ4JLlLfmo=
X-Received: by 2002:a05:693c:65cc:b0:367:23b6:94e1 with SMTP id 5a478bee46e88-3674e25bf5cmr71459eec.41.1792520562401;
        Tue, 20 Oct 2026 11:22:42 -0700 (PDT)
Received: from localhost.localdomain ([206.206.192.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8439sm402866eec.11.2026.10.20.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:22:41 -0700 (PDT)
From: Yibo Liu <yiboliume@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+0845f49852fd568f@bugs.sh,
	Yibo Liu <yiboliume@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drbd: validate digest size in checksum resync and verify requests
Date: Tue, 20 Oct 2026 18:22:00 +0000
Message-Id: <20261020182200.236875-1-yiboliume@gmail.com>
X-Mailer: git-send-email 2.34.1
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

receive_DataRequest() sizes the digest buffer of P_CSUM_RS_REQUEST and
P_OV_REPLY packets from the length the peer puts in the packet header,
without checking it against the digest size of the negotiated csums-alg
or verify-alg. w_e_end_csum_rs_req() and w_e_end_ov_reply() later
memcmp() crypto_shash_digestsize() bytes of that buffer; the D_ASSERT()
on the size only logs a message.

A peer that sends a shorter digest thus causes a slab-out-of-bounds read
in the worker, and a peer that declares a huge length makes the receiver
attempt an oversized kmalloc() that triggers a page allocator warning.

  BUG: KASAN: slab-out-of-bounds in memcmp (lib/string.c:676)
  Read of size 8 at addr ff11000007b9d630 by task drbd_w_r0/601
  Call Trace:
   memcmp (lib/string.c:676)
   w_e_end_csum_rs_req (drivers/block/drbd/drbd_worker.c:1182)
   drbd_worker (drivers/block/drbd/drbd_worker.c:2189)
   drbd_thread_setup (drivers/block/drbd/drbd_main.c:314)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

  Allocated by task 605:
   __kmalloc_noprof (mm/slub.c:5439)
   receive_DataRequest (drivers/block/drbd/drbd_receiver.c:2715)
   drbd_receiver (drivers/block/drbd/drbd_receiver.c:5371)
   drbd_thread_setup (drivers/block/drbd/drbd_main.c:314)
   kthread (kernel/kthread.c:436)

Reject the packet and drop the connection unless the declared digest
length matches the digest size of the corresponding transform, or if
no such transform is configured.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Reported-by: co+0845f49852fd568f@bugs.sh
Signed-off-by: Yibo Liu <yiboliume@gmail.com>
---
Changes in v2:
- Drop patch 1/2 (P_DATA_REPLY size check); this is now a single patch.
- Check the digest length only in receive_DataRequest(), before the
  buffer is allocated, and leave drbd_worker.c unchanged: with the exact
  size enforced on receive, the sizes compared in the worker always match.

v1: https://lore.kernel.org/all/20261015222800.85928-1-yiboliume@gmail.com/

 drivers/block/drbd/drbd_receiver.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a8..d45c4e68f83b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2711,7 +2711,17 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		break;
 
 	case P_OV_REPLY:
-	case P_CSUM_RS_REQUEST:
+	case P_CSUM_RS_REQUEST: {
+		struct crypto_shash *tfm = pi->cmd == P_CSUM_RS_REQUEST ?
+			peer_device->connection->csums_tfm :
+			peer_device->connection->verify_tfm;
+
+		if (!tfm || pi->size != crypto_shash_digestsize(tfm)) {
+			drbd_err(device, "%s: unexpected digest size %u\n",
+				 cmdname(pi->cmd), pi->size);
+			goto out_free_e;
+		}
+
 		di = kmalloc(sizeof(*di) + pi->size, GFP_NOIO);
 		if (!di)
 			goto out_free_e;
@@ -2742,6 +2752,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 			goto submit_for_resync;
 		}
 		break;
+	}
 
 	case P_OV_REQUEST:
 		if (device->ov_start_sector == ~(sector_t)0 &&

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.34.1

