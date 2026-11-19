Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086319;
	b=CQKbXTM13xaCeM41QaMTSgiy1WDgMcMe7UnwkxZzrU43qinXH9rQx9vDMC/CEb/m5uVR
	 2wyRYQzx4HyJXZrI2ktMoVxogUpTjgtdZ+KJ11I4clGQ8xREoXFiGLOS42b+j50C69iVH
	 3cjs/yAt+0ouShIyD4jrRxC9Xdq9SgyvaciXD/S2q2lUCEAh6WQqBUZofDdD9kCS6OYMJ
	 Hv/jH2iGYGDSF1w0urRO3uvDiZhBifaP++B2ZaX+i4Q0FR82c5/UUHyxZjxtLw/gfGiAO
	 m7aot1trHzPm41lx7Yo1NHPjlK6ADqsuHL/evzMNHUrWX0YugRZFnoeNezVmFTw9iQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086319;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer;
	bh=9yy2efd8MRgR21pP9OhK3i1+O8syULk2PKytS7vzEMI=;
	b=J9wem7HjZZS1kJrx3tUAM23CyBxZDuAY0BUNvcQvRoyFzjiVN5sOC4IaEPdpLI6en84A
	 tCMfu1DPtAvVLkbmTCsDF8x9OGkEpuunZYLVaqbA/yfr9TMgckyr07ytBh287EMFKgc73
	 EbkSfEdynOnHSOQk6y5xZXxp3FC+Z+Xcl+PaA/i/TzWBxJYBzeV8bZks5ZPyBtlnYkQj2
	 F7/s6muQzbgCsLEF3vZBxGH6SN406kO/OjqJxbAdPafdTwNkQBthbBKiDKvqpuj5Hcnff
	 cp5jIWJ+2dfIRwIMzsUlI2CeHkPVVUqtuLNbhX/joXZzTaLUySK6Ac6dRtizyOS/UPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SLsi0h2W;
	arc=none smtp.remote-ip=91.218.175.101
Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFC606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DBFC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SLsi0h2W
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P4Y+SlRQH2A9M5O3Hr/bduLBhcl/3bc2nLtBCL3hMXc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795086317; v=1; x=1795691117;
 b=SLsi0h2WBl0AKHvhBnb8xAdF6wnMT0oxhwyH+JCKzgzFS8PAiwcARk5WMEPKlVWOYUfmO2Lj
 QGFCyr7dvkJV/moNCmCArSsOiNlsN80s+4FVQYmQo3yhoRioKPhQWennHl7dyxl8v3PU4AYBFhD
 +clgkRAL3ngrNHj7nqMpIZ3I=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b32b83f3dee707fb;
	Thu, 19 Nov 2026 11:05:16 +0000
X-Mizu-Trace-ID: b32b83f3dee707fb
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v3 0/3] dm thin: stop waiting for grace periods when
 activating and removing thins
Date: Thu, 19 Nov 2026 06:05:05 -0500
Message-Id: <20261119-bug-dm-thin-rcu-gp-v3-0-c80ecc475e1e@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOLX/moC/23NTQqDMBCG4atI1p2SH03arnqP0oU6Uw20URINF
 vHujULBhcv3g3lmZoG8pcBu2cw8RRts51KoU8bqtnQNgcXUTHKphRA5VGMD+IGhtQ58PULTA8o
 r5pXJS15dWDrsPb3stKGPZ+rWhqHz3+1HFOv65/QRFwVwEDmhKrTBUtH9bd04nZEiW7ko98T1k
 JCJ4EWBWhqjVa32xLIsP5qInM33AAAA
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Activating a thin device waits for an RCU grace period in thin_ctr(),
and removing one waits for another in thin_dtr(). Tools that create and
remove thin snapshots for every container, such as the containerd
devmapper snapshotter, pay for both each time.

Patch 1 drops the grace period from thin_ctr(), which isn't needed.
Patch 2 fixes the pool worker continuing its walk of active_thins from a
thin that thin_dtr() already took off the list, whose successor may have
been freed: thin_dtr() now marks the thin as dying and takes it off the
list only after its last reference is dropped. Patch 3 then lets
thin_dtr() free the thin with kfree_rcu() instead of waiting. Activating
a thin device gets 50% faster and removing one 20%.

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V2 -> V3:
- Patch 2: mark the thin as dying in thin_dtr(), take it off
  active_thins after wait_for_completion() instead of in the last
  thin_put(), and skip dying thins in requeue_bios() and
  error_retry_list_with_code() (Benjamin Marzinski)
- Patch 2: correct the Fixes tag to 17181fb7a0c3 (Benjamin Marzinski)
- Patch 3: keep kfree_rcu() out of patch 2, so that the fix can go to
  stable on its own
- Rebase onto current mainline and remeasure

V1 -> V2:
- Add patch 2: keep a thin on active_thins until its last reference is
  dropped, so that the worker never continues from a thin whose
  successor was freed (Benjamin Marzinski)
- Patch 3: rebase onto patch 2, which already skips dying thins, so it
  only replaces the grace period with kfree_rcu()
- Patch 1: add Benjamin's Reviewed-by
- Rebase onto current mainline and remeasure

v2: https://lore.kernel.org/r/20261119-bug-dm-thin-rcu-gp-v2-0-055d627763c3@linux.dev
v1: https://lore.kernel.org/r/20261116-bug-dm-thin-rcu-gp-v1-0-14ed3567da3e@linux.dev

---
Qiliang Yuan (3):
      dm thin: drop the grace period from thin_ctr()
      dm thin: keep a thin on active_thins until its last reference is dropped
      dm thin: free thins with kfree_rcu() instead of waiting in thin_dtr()

 drivers/md/dm-thin.c | 61 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 25 deletions(-)
---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261114-bug-dm-thin-rcu-gp-d29d4b74a0b8

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

