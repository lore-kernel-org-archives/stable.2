Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141055;
	b=ULlR3q0/9vuF9klbr4KggICPAdaiMMn7JrOwyxu7N63wviCIs4PfmZ97Ot9bFQ/ZZWPo
	 oQWrdKBFVl4VzsLXoKBe3i1WLvYaY8LUIs6NKjg43doBezhWre0l+DB9ouxqWj1cufWYv
	 XPGLBrTMcDURQ/cxczp4Xo5j+Tvc0x0vWNpLajmvV3tH2Tvk+7MOG1J10Qbc+jFNYNsDw
	 BMI06wExaeYtxMOPbQ99PB0ug5dG19XW70PGqUEMvYysYUeUVweUMPkjLlCS6dQJkLGdf
	 UHnk82q5eCEa4fOUWvi8N2ksLU/jIfLIWcEqIVLkXpvX37/cEIPVFultfAz7FM6T4tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qrne1U4Gq2URgk+EKe+uNj5xFft/8oosPyNbOoW67yY=;
	b=LHkJI2MhuFkvnXKQ5+WCxhZHGDFcqiBhRyD8BcoJoPEt+uHbQluGuKuCyEjZ76btQiVF
	 cncbsxh5xn94O2EUuDWIYVJY/ZEEpgh/bNKO9cp+Hajh47/lTMtXlE6JLR8WTymucp5iR
	 X51oBEQ9pHv6YCLnrdCWAlLGRIXXqtScZ7LDBLClO5iMuBmeykyrMumuJJWXIPg3lFG1i
	 lmmkPGeO/He+o9rc+bcOvYdrWxhZnTLgwt1DIS95j+Gf+ciSDmuqGQvGGuvVgTYeoOU1k
	 SGRXkzrWDPiMSCqmG61peH8BOo8nnOO3I+rvhU8vjpCBEamVZNZk/b7KDqCv8WxfxgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dk0wFmrb;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60608606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60608606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dk0wFmrb
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f046b0adc0so264175ad.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 18:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795141055; x=1795745855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qrne1U4Gq2URgk+EKe+uNj5xFft/8oosPyNbOoW67yY=;
        b=dk0wFmrbOWHHA/sZMb1BuFyOgxGpiAiMvFQVB45s+uDstllAlf6cJIerjKVe2hT1u8
         HFbF4W6Du4euIyp1k6G7BrLayOMBUxuX+sHDRyXSMLtfBeXnGwTzYzo1G6ZEE1J8Wtav
         RW5UcNb6YmJw98S9+GqnVGbGClgJO25945PdbKsmy4aosSw2xcJuKmBNL+SZHH6dwHIQ
         by1EEDkTGcYA+41idX6Thr5nbNaVhWQ4pTZBLkNYEsILqasoxo4dxy8MYsTPFp0oX0ls
         HujPzHoJ3eXdCDsCZodHmSAc80e+9DGhXtUSaxbwpwa0SExniobOtoKowV65sHxUmBRK
         nr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795141055; x=1795745855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qrne1U4Gq2URgk+EKe+uNj5xFft/8oosPyNbOoW67yY=;
        b=AGsql2z2VQsGl5i2pHQUtuiodIDMbvpqzZ3zUSgeKsBUs2I438QXNlCyG7wn5uDtzV
         qUd1xVKz41pNIT0rxz8iR8A8wuyXiKCB4qF23BoQm+CflaMEcX8AVbMDedf6FwWn0bXZ
         eYDC+A4JHoZw2xrtPo8lx9udOEOcgkcXT4sjCnP55S3hW+Xz9K6E+XsHypEuf00WTScS
         2ciKMWr7+7zgvRQHaxXEc7nfYWSFtujVbaumyxO5waWPWc/WDtwRgYpm6c/rtkSuzKIR
         aZOEAKPe2ybSM55bqRT8np5BMidqdcQhEpphT99ZIsFlOaTnreQA9Q3f71KxwXrShBqx
         plyw==
X-Forwarded-Encrypted: i=1; AL+hErHy9n2TobtTHjYLR1WwwL8MfyLIcBmHUE8AWe5EGZi3AJXEQTFM0l1GjAxfw7E/fYyLSHgiotk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Qf+4PcUEqj4tk8endCv2i/5yhaB5h/KZK2cHmRfOJjIlBSrPi
	Kr+zyqJyxa9W1f66ooEsE8bS+0DlTbhowAR87GITCfaznKRXJGs9KpIt
X-Gm-Gg: AZFdTZc9+s3ACtWD6jPLPsjz++72Loa+LrKkryjp5JgxzXxT/O/Q55vgadGK9H8u4w2
	dVUjbpseRxaAt8KhZmRRXSxSCCj3A63TiC4KsSmL/Xp5tD1mau/YhLZQYInhBz2mPlcGOt1lCqi
	+RA5PgbB2LiAEKpRGEBYUX6IBt8Krwsnu6tg2n+QlZk4lZHkpv3evBoICBucWFMuVr444CljOVl
	wmm9lfOL9uFSkY8biCevNywgruUUZ4t3z7wqUAJ7cHuHec52BXnPjIDcUD+ZPntdWfstibmVJH6
	DLn3nwvyAauxwcVuj8fu/NzoQtUBnqvddnB+QDA7NRASl68bA3yL1bkqLBd8WtZoKwdnPDv6VYI
	T0KEzipvTOwegJDzHRDY5ipfDpDIwhXzvL768+AXDg9vFuS6KjyUy/rJgZSae4bqPRX6/Pz4D+9
	EXFnZl2Ksgu5sWGJkYGS7ILCpLLqXxrfb1VNsR7pJscIoQVde3DDpZSxE0IkTjhYt0LYPH4lHA2
	4k8DOU7IcxuJs+/T4LiOE5Qjlp3N4DivKvlQp3gTbixLaKZj9R8BS7YmZUYp/hQINrMokxhuEKl
	hYx+8R6BfMxrU2rRDQ3UXi/8p1RtYCgRoLqHEXd7fdYZN9uQl/h811ZPBaE=
X-Received: by 2002:a17:90b:2c84:b0:3a5:c08:4c41 with SMTP id 98e67ed59e1d1-3b41c98a138mr1104076a91.50.1795141054397;
        Thu, 19 Nov 2026 18:17:34 -0800 (PST)
Received: from ysq-QiTianM428-A376 ([111.201.209.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41cfbaf2bsm708563a91.2.2026.11.19.18.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:17:33 -0800 (PST)
From: Franklin-Qi <yusq77@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Harry Yoo <harry@kernel.org>,
	Georgios Androutsopoulos <georgeandrout13@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	stable@vger.kernel.org,
	Franklin-Qi <yusq77@gmail.com>
Subject: [PATCH] rust: alloc: reject offline NUMA nodes in allocator
Date: Fri, 20 Nov 2026 10:16:29 +0800
Message-ID: <20261120021633.12274-1-yusq77@gmail.com>
X-Mailer: git-send-email 2.55.0
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

NumaNode::new() only checks that the id is in [0, MAX_NUMNODES). Safe
Allocator APIs can still forward an offline node into
k[v]realloc_node_align(), which may dereference NODE_DATA(nid) == NULL
and panic (GPF).

Reject offline nodes at the shared ReallocFunc boundary for nonzero
allocations. Leave NUMA_NO_NODE and zero-sized free/realloc paths
unchanged. A residual hotplug TOCTOU remains if a node goes offline
after the check; this matches practical C usage for rejecting
statically missing nodes from safe Rust.

Fixes: 7760b6421b6c ("rust: add support for NUMA ids in allocations")
Cc: stable@vger.kernel.org
Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/1263

Signed-off-by: Franklin-Qi <yusq77@gmail.com>
---
 rust/helpers/mm.c              |  6 ++++++
 rust/kernel/alloc/allocator.rs | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
index b5540997b..b61e54e16 100644
--- a/rust/helpers/mm.c
+++ b/rust/helpers/mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/mm.h>
+#include <linux/nodemask.h>
 #include <linux/sched/mm.h>
 
 __rust_helper void rust_helper_mmgrab(struct mm_struct *mm)
@@ -38,6 +39,11 @@ __rust_helper void rust_helper_mmap_read_unlock(struct mm_struct *mm)
 	mmap_read_unlock(mm);
 }
 
+__rust_helper bool rust_helper_node_online(int nid)
+{
+	return node_online(nid);
+}
+
 __rust_helper struct vm_area_struct *
 rust_helper_vma_lookup(struct mm_struct *mm, unsigned long addr)
 {
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index cd4203f27..15e17f598 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -101,6 +101,23 @@ unsafe fn call(
         nid: NumaNode,
     ) -> Result<NonNull<[u8]>, AllocError> {
         let size = layout.size();
+
+        // `NumaNode::new` validates the ID range, not whether the node is online.
+        // The C allocation paths require an online node for nonzero allocations.
+        // Keep `NUMA_NO_NODE` and zero-sized deallocations unchanged.
+        //
+        // Residual TOCTOU remains if a node goes offline after this check and
+        // before the allocator runs; that matches practical C usage for rejecting
+        // statically missing/offline nodes from safe Rust.
+        if size != 0 && nid != NumaNode::NO_NODE {
+            // SAFETY: The helper only reads the kernel's online-node mask. `nid`
+            // is either `NUMA_NO_NODE` (excluded above) or a value in
+            // `[0, MAX_NUMNODES)` from `NumaNode::new`.
+            if !unsafe { bindings::node_online(nid.0) } {
+                return Err(AllocError);
+            }
+        }
+
         let ptr = match ptr {
             Some(ptr) => {
                 if old_layout.size() == 0 {
@@ -116,6 +133,7 @@ unsafe fn call(
         // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and thus only requires that
         //   `ptr` is NULL or valid.
         // - `ptr` is either NULL or valid by the safety requirements of this function.
+        // - For nonzero allocations with a specific node, `nid` was checked online above.
         //
         // GUARANTEE:
         // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`.
-- 
2.55.0

