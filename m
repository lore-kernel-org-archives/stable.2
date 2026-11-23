Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447990;
	b=25EvwzZtEr1hZw31geYXkn5vyzGbkWVs6nhUUAF9DyDJLBYiaHX0NshxUDOehc1upHyB
	 v/0enHrzk5MeXImGJpoSgQuCEn2KOZRQ2isqXIWIRD3/+auBe80ZuqVjvLf5TK+Krq5wQ
	 bL267Al8r+1+XWKtO1aigeggrNxprb1yxeVbB5RqlBTQOKjJKVSVZNDqTGff4XWyReueh
	 EmRRkSWxfm4HOnxy6QNGYJ1HZsWmPJvn3CxIiyiTe75fCW3uceHHY6+zkI1w4sNpggrj+
	 dBoak8p+wre+07d9YRRwx2goJp9IEudL5i42BRlU8JP7HyasmpkR2K3gGElJqBp/fvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Om3+ZF0XtREIm6HCfdv7ugOGpXmbs7kvx8h4qtcjszM=;
	b=49ccME19Pao+wkFuP6BNQJBnOQCTenuvoMOIh2jFQpRHqk0vulMc0HE9UKfkd9QRHdfA
	 yXahHW98SoCDOyg5WWPQ6WVv1jLxiH7wPFteCEvEk2mAOs+UrfoQ6Byman6YQ8zq22wXw
	 DLCKPfRc2aaNAaCQzFTRcganbi4xbTXpL/fkUMKDWcz/Cn3Xauyzq8Ui2SNIcuaPOVU9J
	 I882MFSKYUzckxu/PnNgtrj5I7hw1cjrbE3kr6p9hCpdm2NRoDl0fN5I97F4wUx+M4SgF
	 bdDirSxcnkGuBTFycT8uwV7LRlI7X5/pko4xamt5rSGu4N1/FWqyQtvtKLKnyKoyP8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=PDpaJYuZ;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596CC606A684
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 596CC606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=PDpaJYuZ
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38699cf08dfso3307663eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1795447989; x=1796052789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Om3+ZF0XtREIm6HCfdv7ugOGpXmbs7kvx8h4qtcjszM=;
        b=PDpaJYuZb+DORPk4kwRe6ZpuRcQHMCKRWIbtR2XvtYy7GdBAgIH2GezVfCd2rGjJ/m
         5rT5z5RSWLl+ftMa7vlJPFotH8mJMWu2CrcEm5RMDRWU8d2bkS+Z3C/phqgJUa9eWb2u
         vRZOgjAG6HY0Xg+nGeLndPrxNDTdJNzCO1jsRN/vPHvTTilRiRPPmku299ZIt+FF22Bd
         4abR9gbzYe4ZB04LCtHIb+foAkU33R8OGQJJIpvfjuM3CDKzXR0fSQh6EeOtL7Hd4L53
         VvQl9Ol7LHDS12NQB5k2i9m531Q4Z8bTahV/i+OEi1Rtd2o3zIiMS65VwcYGnbPMARGb
         juDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447989; x=1796052789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Om3+ZF0XtREIm6HCfdv7ugOGpXmbs7kvx8h4qtcjszM=;
        b=LSEMwVz8uu8guW/uvX+r6XtIheTapzHda3aVQ3xamdWHC8Hpk6b0XVEWopVtBgesJI
         p4OQ//pdeTABT1JKF1EPhZGVzjRhQA9CcJsri8pIAmX/zO13N3bTDALu4B0OGMw3ROu0
         0vk0N+S5BUDfyDc6Z3vk1eLd7RqZFdyiAP+hJkWVdg8n0lIFtOKz3gXn+aXDCUJ/TdGZ
         146NZ1BtD3s6bxglV4lg1X4s+gpWojAlvd2fQQS6XI65PkQ8woo5SRX+9iijAUAEjTvN
         KJqAbYxz/sVPlkejUIE0t7MYsYQyy6O2eH+b9ZKJdr5dmO9pGl5G4g35ng1TERxx/64m
         VaUA==
X-Forwarded-Encrypted: i=1; AL+hErGRYE7AUTyxJMM45MtV8nhj5FSNvcconaV/YFKemTm3NDlHTK5btyIFp60k3zEwaj0vWcZ5mII=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q3KVoNg/VSZ1a6zV9K5XJIgp/XePPJQ2ykiK3J3xK1solkyiF
	Y9gS4jGDzljwE6Gs2BN+XIIy2uhowXVOodJMgQGpiV2fjHEH4h487Qf8XI8vLnjTMg==
X-Gm-Gg: AZFdTZeTE237637Sq/JRCGNmZn7pAGSYvjiuoStHSPshTOadDtYUqEePO6/xud73XPC
	dGemThAtb20gdDvvW20kx60ddXAz4Sm3uDI5QU9xPahIjClqcRLlSZSCYOFyz+PAFE7UsBJyXRC
	kwxc9q8JSp+pii5MY35oXdXHWh2ZTn1KEwcR+EK9EidXzniDFmGCCWIC/wV+kDWYS2CO8cb5Cyn
	03wJ5WLkyDAMbQFxgEnJ0qlBfpEfVD8vH88AGLpFWIuDCvxik1lAqaUVFLHggVhU5zARiSnJ7qk
	ugHlTm4Q95vZfQxpAfi21e/5Bm4VcIZBaPL34okG+mjSqueOhTBpa15P6gRytIuBMC1AKxUAs5h
	J/gatP7xxyVfz+iMJvn5iJP0ot6Xy3DYsp7w9f1VHVoagUeoK1jft43R8kWINB6R0ZhyA6CYlnc
	RtY8baYUM3D+7juwRvxq6RaWbYQJ9C1zxwtxjiGuRPnr+jY+qcC2qImgaQuKBFPoO2NKi59lKEM
	YplPVgQ//oeTShewiIrm1DdPPtGtaqKzTez/wpu9+ZsP1jWm0tUigFNHZUr/tfl/8YGaqlmylhd
	efG4C30ohu9FOuwJMgz/gko/mHBDRZhr6fRCOjH51Q==
X-Received: by 2002:a05:693c:8947:20b0:386:9ef2:8e01 with SMTP id 5a478bee46e88-3869ef28fe2mr6486341eec.0.1795447989335;
        Mon, 23 Nov 2026 07:33:09 -0800 (PST)
Received: from localhost.localdomain ([2600:8800:1e00:25f0:3391:10c3:1717:1522])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm34601237eec.16.2026.11.23.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:33:09 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Mishra <smish149@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] KVM: Disable preemption while pushing to the dirty ring
Date: Mon, 23 Nov 2026 08:32:37 -0700
Message-ID: <20261123153238.1036972-2-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123153238.1036972-1-smish149@asu.edu>
References: <20261123153238.1036972-1-smish149@asu.edu>
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

Disable preemption in kvm_dirty_ring_push() so that another push to the
same dirty ring cannot run in the middle of it.

kvm_dirty_ring_push() selects an entry with dirty_index, fills the entry,
and only then increments dirty_index, all with preemption enabled, e.g.
when vmx_flush_pml_buffer() pushes the logged GPAs on VM-Exit.  If the
vCPU task is preempted in that window, kvm_sched_out() calls
kvm_arch_vcpu_put() while kvm_running_vcpu still points at the vCPU, and
kvm_steal_time_set_preempted() or kvm_xen_runstate_set_preempted() marks
a page dirty, which pushes to the same ring.  That push fills the
selected entry and increments dirty_index, then the interrupted push
overwrites the entry and increments dirty_index again.  The entry after
it is never written, its flags stay zero, and the entries after that one
are dirty.

Userspace harvests the ring in order and stops at the first entry that
is not dirty, so it never harvests any later entry, and the GFN of the
overwritten push is lost.  A VMM that tracks dirty memory with the dirty
ring, e.g. for live migration or to restore a snapshot, then misses every
page that the vCPU dirties afterwards.

Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Mishra <smish149@asu.edu>
---
 virt/kvm/dirty_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 572b854edf74..1ed8b8771c3e 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -221,6 +221,8 @@ void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 slot, u64 offset)
 	struct kvm_dirty_ring *ring = &vcpu->dirty_ring;
 	struct kvm_dirty_gfn *entry;
 
+	guard(preempt)();
+
 	/* It should never get full */
 	WARN_ON_ONCE(kvm_dirty_ring_full(ring));
 
-- 
2.54.0

