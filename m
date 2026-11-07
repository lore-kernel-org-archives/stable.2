Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061785;
	b=gTh6HKgmXbBglYinT30Tm4detOCy200WdIevAN8TIEMX/mGYPqqX9Wda7uBpE3RBfOQH
	 WNmqApC/8nQn92jhUYy+Ltenst3ruoLeotbxFvF4d/DPl/OAe9qonCvLTQ/F87pdKy7eb
	 wVHnP/Zrus4WB/XI/MNWZQg+clh/VPhNavO2gUKZT9/cjA0Gl70ndeqxZd6Bl3g3wbDZo
	 Bg7b05rXdR5K72XLtxf6GGF2dtTERvFg0JE06ou/20QwRiSSU12w5PL4n8Uf+QhLY5YQF
	 1zRtIY7v6+3xfpHRIdV8slYPeQzV0R3zyzeZtXV+s7hCVrx2x84cs/NlmuAAo49/60w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=envJoJ9R8JXDgidxnGQ9ix8YkGksaPR+QBhomUAEfcE=;
	b=V1ZoZHOrtUh0qSOfl56JrCWUjC0YSfmNOU9vLNnhZbzVDmhKz4ozZu17dgfpA+z2EjGL
	 kYLmO7uQiGVUjI+PJIvORwcZvnBc0goF9aeT3mVrxIjV/XEldHF7EBLlSybd9Lq4G1n96
	 nm21eTBRfb5OQ1pH00QbIlY5LZf3xWcDLHQdyNsoaaBmet/PItQY7bbuDGfnlyb6GgYy+
	 96IwElDu79BYeok1pG/NAiN/qO3atRKareuD6h0eOqRy8CMHIPvxVlCsJ/bEIbNbcesyl
	 VG2R/PRwL0o4W06l+FJ+mSq9SfZKMbFBksUzVaLBN+qwCzTlPMa0zF8aWf/r3eboJRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stellman-greene.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRzplsFm;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4B606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC4B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRzplsFm
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5365f9a04c5so24081181cf.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061784; x=1794666584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=envJoJ9R8JXDgidxnGQ9ix8YkGksaPR+QBhomUAEfcE=;
        b=WRzplsFmldKcXnYw4OafhEkJcnmhPWZnd/nauEL2ClK6FUDlDaO9720METkvRMe5gY
         uZ2uLK/csWDhGTXhMJcQglTfUZfwqDMrav2Zd5MACj6/9ksgl/jaQSxPW+Ypm720/dJd
         6wZ3sJnc1DmI8c3hcNkfwWXTImH6PbsyPf+mol3Aaa+fj10lyAsZ9tWdpC8E2snEVKdM
         aDIgVG38ebZmaCeRXDzfnT+y/NErk7l1roLs/bYGha3o5+OEU2ie5S1yHVGaZFlXi3PC
         BaUUiKh/sM2YhCO6B0U2otk8fNe3gVTnZax2GfI+2w/CySmTF8BbnT9C32IOBbaryeMz
         f/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061784; x=1794666584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=envJoJ9R8JXDgidxnGQ9ix8YkGksaPR+QBhomUAEfcE=;
        b=NsheLXgM6n7nx+9GVXxFnrUAqvz51ZT6GQHofvE/ozSOTMJHxo15XnI+LgeYPp2j0x
         OBnTsAaGDyoQu/VxgmAZnhfvYM5XoxsTMoTnPy0j7Hvimfyzi1HP3cONt0j/lGEkXNl8
         rcPz2le4Jy+ADLkPTxAQwsbjzX69B21rh/RLhCIidbZKdAk5GtJzmdLxYC43bu0xc1gm
         pYieAsUQG/HQ24UC6Y4B3bYdb6JxW1eVlWcX5ArmWNkyT7ApRZuOyqtuhHkDqpsFx4J2
         tdTN++DNoTBbIP0BID+xo3JpbKAb66Jhy+ki4HZHnoHdpt63km7P+MNMyGXjql+hU4t2
         lYcQ==
X-Gm-Message-State: APuU4Z95ZWAOI0AY9TuYa9bt1BIEMSoGLCXNJKrKUiN2hD/R6vCIu8rI
	D9cScDYI/Un/oEd11LM/f9+2fwyMePz+hA3hK+lWyc6UdU1C+Lu1TnQsJBtwJ5Szd2g=
X-Gm-Gg: AYBFou2+RrkqkDZNKQFZ7touUF+rKRRbFs4/W/a0L6Us5FPES9jgf1SxWKvIa1mQggY
	wo1jaut/P1EYVE4luj5GQehlLatPQZoUg0dYW/ea2TLw/5iAP5YQyxZ/P0d82pcQ1IkFpwXr/iM
	xnMPoKaSkLeKiaXQz6EbQ4nGnidofqoBnDactZtKpGQ1T+ywBIBFM1dQ96e3EMcJf4TNqDajVnG
	X8WXv0TS4ONRQ/p5gBPjXycuCoRtMgj5oOFIc4lBfrsFPly6UK33oGSzl4WjqbkYiR9C9ZVsDhK
	Bm8SoxaVjNylCI9EmsRuwwFqXJRxEdsSRgC2zTTHhPBxdimizd4W6s/bI80sbKlYPnNUri+Qqqz
	C2NYmBOPXBhLWz1h34CqtAvK4QWj4Dm7jpNi8Ah7YeivetautsesQcz8TzpWCRBHwPPgOpo5kcW
	g8WQSdQ9EFBr2tSJj5IvMIRSEn0bo6HyL7lj9C7U/KjZda1tsVtw0fJWxsmiFwZlOH4LbjzPo2x
	kFeFNhD0TuXbIYj9TIwVCkeEm3fdhlCuTOLWJsIaxG7luUYhquDHkatMveJ6uZjr19NAhSfTT+G
	1Z+ZaPmEXGiNlrVyNoOJ6iYTeB6i4xWauczrM+QDtLghNRyjqa+PVl+ioWLoU4P0s0FmmDKTxlN
	1hSDJvzQ4D02IGmuk096wPa2gEEpnLxAkEb5Y/pNjNyfvK++mhWRQM2xHOwb0vTvaAAetYexjkx
	INpjwr8GqCOgIzBk8huWcryHLp0UU=
X-Received: by 2002:a05:622a:251b:b0:536:5663:5558 with SMTP id d75a77b69052e-54e102ed954mr90135811cf.7.1794061784040;
        Sat, 07 Nov 2026 06:29:44 -0800 (PST)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:397b:6557:89ab:c2a8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26259cf0sm47006661cf.15.2026.11.07.06.29.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:29:43 -0800 (PST)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 6.6.y] nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()
Date: Sat,  7 Nov 2026 09:29:41 -0500
Message-ID: <20261107142941.61983-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054023-failed-6.6-d1512773a0d5@kernel.org>
References: <20261107054023-failed-6.6-d1512773a0d5@kernel.org>
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

[ Upstream commit d1512773a0d539669440bd9f6d050b8e12923b5f ]

nvmet_rdma_map_sgl_inline() bounds the host-supplied in-capsule SGL
offset with "off + len > inline_data_size", evaluated in 64-bit
arithmetic. off is taken straight from the host SGL descriptor
(le64_to_cpu(sgl->addr)) and len is promoted to 64-bit, so the sum
wraps: an off within len of 2^64 makes it small and the check passes.
off is then used as page_idx = off / PAGE_SIZE to index the fixed-size
rsp->cmd->inline_sg[] array (NVMET_RDMA_MAX_INLINE_SGE entries), so a
crafted offset yields an out-of-bounds scatterlist index that is written
through in nvmet_rdma_use_inline_sg().

The mapping runs while handling a received capsule, before the command
executes, so a remote RDMA peer can reach it (the Connect capsule is a
write and takes this path on a queue that has no controller yet). The
host controls only the low bits of the resulting displacement, so the
expected impact is an out-of-bounds write that faults the target
(remote denial of service).

This wrap was reported, with a KASAN reproduction, on linux-nvme in May,
and the check below was suggested in that thread. The fix that was
applied, 48c0162f647b, reworked how the offset is mapped but kept the
original check, and its page index turns a wrapped offset into an
out-of-bounds index into inline_sg[].

Reject the offset before it can wrap.

Found independently by static analysis with AI assistance, not
reproduced at runtime.

Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
Fixes: 48c0162f647b ("nvmet-rdma: handle inline data with a nonzero offset")
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Closes: https://lore.kernel.org/all/LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me/
Suggested-by: Keith Busch <kbusch@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 380c0aea8..7104540e3 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -865,7 +865,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
-	if (off + len > rsp->queue->dev->inline_data_size) {
+	if (off > (u64)rsp->queue->dev->inline_data_size ||
+	    len > (u64)rsp->queue->dev->inline_data_size - off) {
 		pr_err("invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 	}
-- 
2.43.0

