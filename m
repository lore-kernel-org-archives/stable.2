Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC93B14A5
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650749; cv=none; b=onfJj+gAmdwaGR5+xqZ1vJtQE2JvIuY1Kfij2F6QfibtNLxtrI6FOW/DHchtbUqWkWQO3Gy7EAxsnf9DXBmI8dzmrOsiazgCq8i6JNRlg3YeqV2UrnS7pctyuTqByPIcEKdb3y86auSzRsse/ANaymFNtdZipxUXIu9Tp04IAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650749; c=relaxed/simple;
	bh=R+OeSbxoAWNLSxz61jl19A3bJcZeqOhotzsemQIFDzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGpZfaY5OzCq7ViKu/obH6DcCoKAIMlGq0pOzIj9m2sucsUwClxvDgNEWUjdpsT874DHAXXt85/mtZrxdV1RB8Jo//Udi7XFSdeQXam6NNlFCRyN5hvgPnKui02g3NxnKt+uz2BXIZOY7D1JQ/PoUK/acbUDhuPx8nxwJPsc4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ShmuWe79; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ShmuWe79"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso4288486eec.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 19:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790650743; x=1791255543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hOMETCPD6rhV8uZSv0/8O7XOYDjSnTdePZNVI177FQs=;
        b=ShmuWe79rCHt+PVRIy48e1bQBkceG3dgar4hDuo+GwHOcPBihfZ1PfTFqbKSmCE0vi
         8yEmhBqzA2qFqpeIqbdRUAG4pVljh8eHjgZEjObNCCoV8mwUGrVR4RVPnyi4fpaK3/xP
         GCgeSociyVdS3LtaRlhqNCwmm5/yr4TlQkENq0pwGOAulQTa/u2l7KoMJzzNroncSr+M
         UYLseGFJCJDj2y4wySXIPwckyOlaTcsv3Ks2SZ57rxcoIEVsebt9lXMS3p5qwYezrs+E
         Hr+nPL9eeUOrp8CdaR0vo7ulZ2QZ/o2L/dLRLQPi7Dl1CtxrP+yHGY9sk133Y9oysbXj
         ljIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790650743; x=1791255543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hOMETCPD6rhV8uZSv0/8O7XOYDjSnTdePZNVI177FQs=;
        b=fal2ouPPSvpLa8hpSxLf+JhTpsCjJbo7NHqV+ki5/ljUQhrjhYsTAmlSybpSbLFACL
         fyZNGks//4Xa5UvNO8twc2kPOutXWjTIXRQ/vt0XuKGgnTgdCXSzw7U2eF/+7EoIZAYy
         yspAtKHCDzpKgGMA0eCr7g7zW+MloyjrjiBBPBRrn3sIEqedeO+XAO8QFBVbKh8NOQaX
         hJ8tzo8FLL/ycE8qPGr7DD9i+I76qvrY5Cg+Po+fZT89xDTpeC97y1UbXANqV6N3MtV5
         lVOphl4mVcz2MqzKdowktV3lvHgQ7ld46yOPQg1OPabUEtYekSi5xwmvLy/71M5hOJSM
         +XdQ==
X-Gm-Message-State: AFq9FYJi42bR5F7zvy+OEUcsvJce3OFDfapiRxo0+d5IogH1mZN7DLV+
	sBMZfyKGFMpvTdU75vR8eKqBDsnU+GvhVaQdN8LO1tXJG9WtX3nU7zCIMhFzeDGiSemRysyJTZY
	BUSubeo8=
X-Gm-Gg: AYBFou13S4xyi1Y0qSBU8rMVSN77VrJGyL4LtlTUUr2ik9blNrg+jzdJX3RO/TJGcg9
	GIzQ13Kv4/UtiVnd6++I6DJpirX8KKe5hOpMTKXYwWJyf7t7Y7fD6wXkNXAIwNcCQu5/tiAHVGy
	uUw/MfX5QzTeROjHxnItqClnMvm3vMCpiJJKwat9Tg3S/prWXqf1mDi5AEcKlLp/BAKtvIGSYXW
	D2HZmY4tCEf846kmYvTFFVn5Y93ncGSmflsi1xpMcDxsuFpCmZylqZ1ZrtPY6gAuqtXdNRbpYok
	0flHIwB7KCVS9H/MsvnoztvyQtsECzY2kvP8a+sGuh9lMXvr3CRTc7lLssHdJ3Q2jrH9CQl0XHp
	Rw9Hy+8GhunxKdampjeShDf1bkRGh1oScEPywCsElynM6G1soR7LWFbgEAoCCDjoO6BPfOo+1MK
	xdRAuCFZSINDVM9OgGKGK3d0FLBzNIzK3D21ob62MM1R5JigdUPkj+oEAmrAn1osYoBBJnK33nu
	4iMmyZDSwk+6gjm1HXqNCjaw2J01Dgx6bGHWDumt6B0J0xjcTjQfrNY3ZXsUxqUUV4ObqE=
X-Received: by 2002:a05:693c:20c9:10b0:343:4ed7:6825 with SMTP id 5a478bee46e88-3434ed76a39mr10306743eec.41.1790650743013;
        Mon, 28 Sep 2026 19:59:03 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34571658054sm13111683eec.8.2026.09.28.19.59.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 19:59:02 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_jjohnson@quicinc.com,
	Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 6.6.y 1/2] wifi: ath12k: fix kernel crash during resume
Date: Mon, 28 Sep 2026 22:58:53 -0400
Message-ID: <20260929025856.85683-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929025856.85683-1-artem@trailofbits.com>
References: <20260929025856.85683-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 303c017821d88ebad887814114d4e5966d320b28 ]

Currently during resume, QMI target memory is not properly handled, resulting
in kernel crash in case DMA remap is not supported:

BUG: Bad page state in process kworker/u16:54  pfn:36e80
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36e80
page dumped because: nonzero _refcount
Call Trace:
 bad_page
 free_page_is_bad_report
 __free_pages_ok
 __free_pages
 dma_direct_free
 dma_free_attrs
 ath12k_qmi_free_target_mem_chunk
 ath12k_qmi_msg_mem_request_cb

The reason is:
Once ath12k module is loaded, firmware sends memory request to host. In case
DMA remap not supported, ath12k refuses the first request due to failure in
allocating with large segment size:

ath12k_pci 0000:04:00.0: qmi firmware request memory request
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 7077888
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 8454144
ath12k_pci 0000:04:00.0: qmi dma allocation failed (7077888 B type 1), will try later with small size
ath12k_pci 0000:04:00.0: qmi delays mem_request 2
ath12k_pci 0000:04:00.0: qmi firmware request memory request

Later firmware comes back with more but small segments and allocation
succeeds:

ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 262144
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 65536
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288

Now ath12k is working. If suspend is triggered, firmware will be reloaded
during resume. As same as before, firmware requests two large segments at
first. In ath12k_qmi_msg_mem_request_cb() segment count and size are
assigned:

	ab->qmi.mem_seg_count == 2
	ab->qmi.target_mem[0].size == 7077888
	ab->qmi.target_mem[1].size == 8454144

Then allocation failed like before and ath12k_qmi_free_target_mem_chunk()
is called to free all allocated segments. Note the first segment is skipped
because its v.addr is cleared due to allocation failure:

	chunk->v.addr = dma_alloc_coherent()

Also note that this leaks that segment because it has not been freed.

While freeing the second segment, a size of 8454144 is passed to
dma_free_coherent(). However remember that this segment is allocated at
the first time firmware is loaded, before suspend. So its real size is
524288, much smaller than 8454144. As a result kernel found we are freeing
some memory which is in use and thus crashed.

So one possible fix would be to free those segments during suspend. This
works because with them freed, ath12k_qmi_free_target_mem_chunk() does
nothing: all segment addresses are NULL so dma_free_coherent() is not called.

But note that ath11k has similar logic but never hits this issue. Reviewing
code there shows the luck comes from QMI memory reuse logic. So the decision
is to port it to ath12k. Like in ath11k, the crash is avoided by adding
prev_size to target_mem_chunk structure and caching real segment size in it,
then prev_size instead of current size is passed to dma_free_coherent(),
no unexpected memory is freed now.

Also reuse m3 buffer.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

[ Backport to 6.6.y: carried target-memory reuse and prev_size tracking;
  the target already retains core resources and reuses M3, whose size
  check follows in patch 2. ]

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240419034034.2842-1-quic_bqiang@quicinc.com
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and wifi ath12k maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-40979. It tracks the actual target-memory
allocation sizes across firmware resume requests.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-40979
Upstream: 303c017821d88ebad887814114d4e5966d320b28

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/net/wireless/ath/ath12k/qmi.c | 20 +++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/qmi.h |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index c49f585cc39656..7a9868dbab02d7 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2152,8 +2152,9 @@ static void ath12k_qmi_free_target_mem_chunk(struct ath12k_base *ab)
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
 		if (!ab->qmi.target_mem[i].v.addr)
 			continue;
+
 		dma_free_coherent(ab->dev,
-				  ab->qmi.target_mem[i].size,
+				  ab->qmi.target_mem[i].prev_size,
 				  ab->qmi.target_mem[i].v.addr,
 				  ab->qmi.target_mem[i].paddr);
 		ab->qmi.target_mem[i].v.addr = NULL;
@@ -2179,6 +2180,19 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 		case M3_DUMP_REGION_TYPE:
 		case PAGEABLE_MEM_REGION_TYPE:
 		case CALDB_MEM_REGION_TYPE:
+			/* Firmware reloads in recovery/resume. Reuse an
+			 * unchanged allocation rather than allocating it again.
+			 */
+			if (chunk->v.addr) {
+				if (chunk->prev_type == chunk->type &&
+				    chunk->prev_size == chunk->size)
+					goto this_chunk_done;
+
+				dma_free_coherent(ab->dev, chunk->prev_size,
+						  chunk->v.addr, chunk->paddr);
+				chunk->v.addr = NULL;
+			}
+
 			chunk->v.addr = dma_alloc_coherent(ab->dev,
 							   chunk->size,
 							   &chunk->paddr,
@@ -2197,6 +2211,10 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 					    chunk->type, chunk->size);
 				return -ENOMEM;
 			}
+
+			chunk->prev_type = chunk->type;
+			chunk->prev_size = chunk->size;
+this_chunk_done:
 			break;
 		default:
 			ath12k_warn(ab, "memory type %u not supported\n",
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 4c1ba3196a403d..a996c6d57aa7b8 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -97,6 +97,8 @@ struct ath12k_qmi_event_msg {
 struct target_mem_chunk {
 	u32 size;
 	u32 type;
+	u32 prev_size;
+	u32 prev_type;
 	dma_addr_t paddr;
 	union {
 		void __iomem *ioaddr;
-- 
2.39.5

