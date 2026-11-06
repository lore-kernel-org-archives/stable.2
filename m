Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924752;
	b=eze+AnhiutcUwtAdD3oQPZGkH1oJF5eCPfK3T3Jqon7J5YJT5e+q3djnOAdJL8k/V7K+
	 TM3gT2BDpKg70XCaMwiJczH0aXY2k4eCOeh21RfSPaW9sD+XfHibyUKFuYpAMou+u4j5D
	 eMDixmg4516SuwP0CwXjceCSmBjYm+DwrAqWT87au43HegkA6m1LYdJeTBLhN6sjeLeYx
	 5vpKwVxFaBVPfNFmwFtJXwrDjyCRbOROL0xIblXyXHgmyn/oyGE8d7531Uwq4Tcy9W5/a
	 PWWzh5mpnFFZWF5WuHWLFZF8WVP4PS8Ckc5yDq1zHLn5tOnLGsVGdkmDoLi4hGHt6IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
	b=S2iACsTXDBsj++BYnPuTkCFRBeoz9NV7BtjhhnWr9AX2/FclVNrfExd7AVuQ8ZCJLkEE
	 W6MFJK+uOyRk9L+f2MzKA5G04by5RD9fLSWhvzbPAt4PbGxFc4v/vvLGLG2yvlozU5whw
	 wOo7DudBiPPJO8a3vD3n1i3jG1k4QplZTovziKMtmV+YyN9iX0aaF819ujCHE+pHyXLTz
	 qJKw/nu0qNx4pO58zERZn3HaBOedH92RcSpJo8ADh7JvGsKerh3P5TBIPRh89tHrDLUBW
	 z38OERMv7TVN5soS0kJ3Jx71i/eu8UN1G8xbB/R3lw0V5YeYSAdfKr+A4/armzzWeuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dPxQOlzm;
	arc=none smtp.remote-ip=209.85.160.200
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3D606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C3D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dPxQOlzm
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5351f1b26e6so1073191cf.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 16:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793924750; x=1794529550; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
        b=dPxQOlzm/EecsuI7ecJmtBSeZKddd15hJzcNWEHbZOfkGkRrFLra1+pRgFfixRPIr2
         Vw6iYxZL9gg7ntrQWkdN0vZmtClduoY/dygZdYHSAXjN/ald1qENYJ72z4BzNJwp1p7j
         iAKy85t5ioYPYuJD68ghEy7SsARQQjKZGHKRP44Bbh1ooytror1Ys8Tn27rn3222DidO
         iAPz5IR58gBoD2DNR0J/YkAogCoPXnYROVrvkKmsn4emf4c9nbnhRSfQX426QYFiQiCY
         h52lkHE3bp57tJ1FK40ndSoF133yuKUthYlrRyllnDqvEA1ckg4QZqtSBBY0qnnFhrOi
         4j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924750; x=1794529550;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
        b=Qjm68gE7m7GmSXnzekjdAuaHv4rcO6FpFhOt+CYe44uDlWEJzPBsjx3r4QzWw79el+
         ezHxzIWMS1aX/oXh/FO69J9fqH520B5Ja7oia9oV1kDXT0GfyqNSWdIUZ4WaEmTKLqnL
         2y5EU34aYA2xEKf2QGIcOB6GRG/ciQNwjhUfx+Cmm4V6+/vq006BVAMhgD4HT5aYEAH1
         6c5saaesVeIktVzuEbPQ5Oeswr1Cg82lSkmLPu2vqCKepbLhosiPZzdzrhwVTIzm2vAb
         +qmCNGuaBi+c8M8Rjaaacm/bXoyZ6p9EcNQ7UD6OoV8DTU53C9vmkVo8ysr/QJvw3kl4
         ZejA==
X-Forwarded-Encrypted: i=1; AKwUvByAxYkdZ4NLX+dpwhPqfoCfzCk27r4CmYfdRObCE21oH+UGJ7+r/UdoRxa3gsBvsnLFKfbW4hE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5XJKAq6vTPktMT0J2ajo9h/kFo6PtfDNr81cKYjL4OOtwhX05
	2cPs+S1yqyClbEK/YzM/APf9XeHMeRTp1ouUnYd97uioV9uF+jjIJh8771m8eNaHNFEfRomU7uA
	GCr2grEVX51mZiYIUjpub/AGyDA==
X-Received: from qtvx8.prod.google.com ([2002:ac8:4d48:0:b0:542:fcb0:6027])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:3c8:b0:535:14f9:3f02 with SMTP id d75a77b69052e-54e1566b67cmr16452671cf.58.1793924750173;
 Thu, 05 Nov 2026 16:25:50 -0800 (PST)
Date: Fri,  6 Nov 2026 00:25:46 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106002546.2100412-1-namangulati@google.com>
Subject: [PATCH iwl-net v2] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
From: Naman Gulati <namangulati@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Naman Gulati <namangulati@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With header split, idpf_rx_update_bufq_desc() allocates the payload
buffer for a buffer ID first and its header buffer second. If the header
buffer allocation fails, it returns -ENOMEM and leaves the new payload
buffer in bufq->buf[buf_id]. idpf_rx_clean_refillq() then stops without
consuming the refill queue entry, and the next NAPI poll retries the
same buffer ID, again starting with the payload buffer.
libeth_rx_alloc() overwrites bufq->buf[buf_id], and the earlier payload
buffer is never returned to its page_pool.

Each such failure leaks one payload buffer. The pool's inflight count
never drops to zero, so when the queues are re-created or the device
goes away, the pool never finishes shutting down and
page_pool_release_retry() keeps warning about a stalled pool shutdown.

This happens when the header buffer pool runs dry while the payload pool
still has pages, for example under memory pressure: a header page holds
several header buffers and only goes back to its pool once the skbs
using all of them have been freed. This was hit under high flow count
TCP stream tests with memory pressure causing RX header buffer
allocations to fail, and validated on idpf.

Release the payload buffer when the header buffer cannot be allocated,
as ice_alloc_rx_bufs() already does, so that the retry starts from an
empty slot. idpf_rx_page_rel() also clears the slot, so the buffer queue
teardown cannot release the buffer a second time.

Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Naman Gulati <namangulati@google.com>
Tested-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v2:
  - Add Cc: stable@vger.kernel.org # 6.11+ (Alexander)
  - Add Reviewed-by (Alexander) and Tested-by (Brian) tags
  - Note how the issue was triggered and validated on idpf in the commit message
  - v1: https://lore.kernel.org/intel-wired-lan/20261104013606.1527767-1-namangulati@google.com/
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 885df6294ad94..7383d8241ead5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3745,8 +3745,10 @@ static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
 	fq.truesize = bufq->hdr_truesize;
 
 	addr = libeth_rx_alloc(&fq, buf_id);
-	if (addr == DMA_MAPPING_ERROR)
+	if (addr == DMA_MAPPING_ERROR) {
+		idpf_rx_page_rel(&bufq->buf[buf_id]);
 		return -ENOMEM;
+	}
 
 	buf_desc->hdr_addr = cpu_to_le64(addr);
 
-- 
2.56.0.455.g6c5a503b38-goog

