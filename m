Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097575;
	b=PpnjWLMtQSk37968BzuDgcLUnO+baAY3ByMYW6CGOcLo2d2wA8N8AfpU9asQk8rbUb9e
	 EbGKOWq7+cqdymm59wGDtPZkksqWSdTrwWjT1k2TtiOpO3yDNHMgQSoTkLdjJ/7UVZvD2
	 EPSwilC9O72bpUlVPhuSa+F1Z5sRhbi4HMXA8k5GYMFmFXZ8yYsuaYLHgnJa00IhNOngG
	 JkVyLCeK1cz0oHeWSX1sXVzPR+2tIm7/Pxn17U3F+ExLNE3y0OEfvqJM2FAciZSRWC3Wi
	 yy01s7fX4/3SCEXdvkVaO2P6FtlQRTevjzjzcC5TbEUFSd4DrIJKS/KYpwiuFA655Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=iAg55S3TxhURmgbu+oeHbyE50eo1n0cGlF6c1aYE3Jw=;
	b=EFIpGhlCIErbj9taEmTd7X3K3UucU969qqgNJQ8ey/S0Bm0M8+sU4ng/OVcMUS62M0OE
	 kbo7+ZznJx61jpD/W/f6Or9XOVzgRJp1aQ0YaWRj/MgRktXznJREVRjiYa4wF47ibt/FN
	 Z+xDZtb/HrlajJ5ZGxfbXk6418ugXGXS8c7WmUmigdtak2KzPbvUPCqKckeUBnyXjGiOL
	 EFdIOQpw1Jk5habLexnSLIsj6zJJ+Pcj55GFeKRHBV3BPqrWCUDqvnW6lU/cmliXRvGHV
	 zqFtdIpz/LKeVuyDKSTWTEMhdhoD+FNs7HaVwdQkPrZ8qom7oL/li1btYojGH14i5kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TiPAy+wO;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD3606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CFD3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TiPAy+wO
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48fcb657f32so1404166f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795097573; x=1795702373; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAg55S3TxhURmgbu+oeHbyE50eo1n0cGlF6c1aYE3Jw=;
        b=TiPAy+wOkKeOQswsLMkrW9QEZWJKNvMrD3Fdp11IpIcMxieKWpjjwaq9dDQoc84qdh
         Ck1bXKOgJd3jfj1iiecnvsPTewNpM6si6anqH0nU1WPxRTxZoKp6aLML4kVhMXPc1fYi
         Zk6fX8qtpI6+mldX/i9VbzHIEeav5swWpCx9igxtBnA05S9THqBfTDhSmgWZlpOmYa3R
         i5Wty+Ucd8VWYQdyffVYfFcTUS0edofhhEqpreL3FXhugpZmyKAgnQRGNfH3U7X5PNfZ
         E+BlJi+SQ9B20ahhm6c/Oaqpxao+P7rvMOMZA3Oj2zAEQRGwd3Lc+nwNu0HjrEPY/UB1
         g9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795097573; x=1795702373;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iAg55S3TxhURmgbu+oeHbyE50eo1n0cGlF6c1aYE3Jw=;
        b=suSZszCiEjZcCGzPC9nEWokk+ll4AI6BWA9nzANAq3jvUVTTr+y+COsb5oJfb3JT1O
         RDglOmLEFgmxyV49ifT69xl703nSn4tB8i5h/4Qo0m1VhI149HAg17H3GnlWswJ0a5rj
         d11p9RX/KoF3/JZD3e+jPh6+rQn1CuVz9zfn/T7Rywa9lYWkT4lZhsj2gv9/bk9h/3rq
         Vy1c3DznGLfusNbsDIzN76WnD7R9/PErtHiM5CzeHhN2zbUAVYmCukR9trg4GMU4I3ny
         8MiP9RigcfFGjs6et0WwYVeqM/5DrMimwofaOAldHkofcAQrYZJ6HBaFYcoLdkih1zMR
         Xdyw==
X-Forwarded-Encrypted: i=1; AL+hErELcLWZf21kPmTY1cELyU3INRxvNbd8peiiqEqzRtkcrivXKVZcZfo+88Cyp7Dc4+Rq7g2xbjo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Vu+k239qQAQ8MoUu1+xPxTJa3ZC21H1Izj1ykl3B14wKErwMb
	2pfQQAnpOlAvGKToSbe8HAjcbvcsBpi96xsvO77QfdwTYPtYuOQVoEw+WRzFT98v/FNhhJSTb2f
	F1/XytfSOvdg47bzs7g==
X-Received: from wrbgv29.prod.google.com ([2002:a05:6000:461d:b0:48e:662f:5b55])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:220f:b0:4a7:8406:1e91 with SMTP id ffacd0b85a97d-4a7840621e8mr11084389f8f.30.1795097572994;
 Thu, 19 Nov 2026 06:12:52 -0800 (PST)
Date: Thu, 19 Nov 2026 14:12:41 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANkD/2oC/12Oyw6CMBBFf4V07ZBSoK2u+A/DAmGAhkd1Cqgh/
 LuFGBcuT27uyVmZQzLo2CVYGeFinLGjh+QUsLItxgbBVJ6Z4EJGPBJAs5vgaal7zDgjyFSXFa9
 vqBRn/nQnrM3rEF5zzzXZAaaWsPhpuOYqkqlIRRjr5KxVChFURUdZhzRiH1pqdlVr3GTpfaQt8 S78Vgj+X7HEwAELVaqk8rPUWWNt02NY2oHl27Z9AP8vLRjoAAAA
X-Change-Id: 20261012-rust-workqueue-658cd0fbe770
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4508; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=khfXhip+b6bKgqmY3nzEIDnd1JlpCzVD1cRmFRun0y4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/wPd3umD72NcCTCoIRkLPRpzluxRmCnf31ziz
 R0WOxkLmyaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCav8D3QAKCRAEWL7uWMY5
 RmEgD/0V28ZmwmzcZhOThJ1+bl/9Iufb84QTqdi+se5nEgbTBYJc37dRFXfxlo8N1aFnUCEd/eh
 LoYKbK1vAM86EsUl2H7La11CX505/YFpeOx5pmTJ109iEI6f8KX0aCwDUSGkXOMM+QdgfSgQDCr
 +Ri5DfzpEY2J47NPoV9cH9BowpSqoCVUtjirnMu1+aS0RMvlor7gtzhBotjmH86M3EviVvL73Ee
 SSptZNvaeKruKbJdq5qGFguVE6EZ8Vp2vk+yrrC1xmxVlPS/8N8Nw1e0sZjtqd/AXvveBQfpZpj
 PNF7VlZV2a9X6YSSjtYRa4+eXONjM2QrncmbGMeJKLHOAb1HxHy06pcHOSFGKBJxK3PPK71lCoD
 YQzwsScCN29j081rTKNsx7nWfK+beZwDVKvGRje75AgRAsUEw8dvmHpbWcLSofHrKWS7Rldh4Mk
 FS7zLDqMQrN4wrpE2LgQ86dAB4FsrFGrhXu/HsvSiWsyB1mNij5rkOfEmd3sn/wvqQCMMLIe2NB
 bCCU/tsGu7DcEitRSM614Ev+ZpWDHk0b6W8iMn/Sa76fCYdUc8DsBTAt7Kn11WthVscSfWyk1+m
 VnbowVaNCBitlF3z1NL3sTGbO9A3Z1JqI/K2bHpl1Ky6fRzU719GzPEwthrWJZQyQddy6yNhrmj fNQnrZnm0AUxzvw==
X-Mailer: b4 0.14.3
Message-ID: <20261119-rust-workqueue-v4-0-707c68994940@google.com>
Subject: [PATCH v4 0/5] workqueue: OwnedQueue and ScopedWork
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
	John Hubbard <jhubbard@nvidia.com>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This series extends the Rust workqueue bindings with the ability to create
custom workqueues (OwnedQueue), and introduces ScopedWork, a work item
type that cancels synchronously on drop, allowing drivers to use
workqueues with lifetime-bound data.

This is a continuation of Danilo's v2 [4], which picked up my earlier
series [1] and Onur's ScopedQueue work [2].

Patch 1/6 of v2, "rust: workqueue: replace deprecated system_wq with
system_{percpu,dfl}_wq", is a fix that was sent separately [3] and
landed upstream in v7.4-rc1.

The soundness of this series depends on the ordered workqueue cancellation
fix series [5].

[1] https://lore.kernel.org/all/20260312-create-workqueue-v4-0-ea39c351c38f@google.com
[2] https://lore.kernel.org/all/20260617144645.253444-1-work@onurozkan.dev
[3] https://lore.kernel.org/all/20261014-rust-workqueue-system-fix-v2-1-c018b8f870f9@google.com
[4] https://lore.kernel.org/all/20260807165252.3849875-1-dakr@kernel.org
[5] https://lore.kernel.org/r/20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
  - Rebase on v7.4-rc3
  - ScopedWork: bind ScopedWork<'wq, T> to &'wq Queue at construction and
    replace Queue::enqueue_scoped() with ScopedWork::enqueue() so a work
    item cannot be migrated across workqueues
  - Add patch to pass object_is_on_stack() in init_work_with_key() and
    call destroy_work_on_stack() when Work is dropped
  - ScopedWork: call destroy_work_on_stack() on drop for
    CONFIG_DEBUG_OBJECTS_WORK support
  - ScopedWork: initialize data before work_struct in ScopedWork::new() so
    init_work_with_key() is not called if the data initializer fails
  - ScopedWork: add INVARIANT comments in ScopedWork::new()
  - ScopedWork: require Sync on ScopedWorkItem
  - Add Queue::as_raw()
  - Pick up Reviewed-by tag from Philipp
  - Link to v3: https://lore.kernel.org/r/20261020-rust-workqueue-v3-0-ea7c74d02068@google.com

Changes in v3:
  - Rebase on v7.3-rc7
  - Split out the system_wq patch and send it separately as a fix [3];
    this series no longer depends on it
  - Drop ScopedQueue: with the ScopedWork changes below it is no longer
    needed to enqueue non-'static work items, and it has no other user
  - ScopedWork: make ScopedWork::new() unsafe instead of
    Queue::enqueue_scoped(), which is now a safe method accepting
    &ScopedWork<T> on any queue
  - ScopedWork: drop the WorkItem/WorkItemPointer/HasWork impls and the
    public ScopedWorkRef type; embed the work_struct directly with a
    dedicated callback, and keep the Opaque-wrapped payload private
  - ScopedWork: drop T on drop (Opaque does not run destructors)
  - ScopedWork: propagate the initializer's error type from new()
  - Builder: new_power_efficient() uses WQ_PERCPU | WQ_POWER_EFFICIENT;
    remove the now pointless percpu() modifier
  - Pick up Reviewed-by tags from Daniel
  - Link to v2: https://lore.kernel.org/all/20260807165252.3849875-1-dakr@kernel.org

Changes in v2:
  - Merge scoped_work.rs and scoped_queue.rs into scoped.rs
  - Introduce ScopedWorkRef<T> and wrap it in Opaque inside ScopedWork to avoid
    &mut aliasing in drop
  - Pass &ScopedWorkRef<Self> to ScopedWorkItem::run to enable self-re-enqueue
  - Add Deref<Target = Queue> for ScopedQueue; remove duplicate enqueue_scoped()
  - Add Send + Sync for OwnedQueue
  - Fix stale workqueue::system() references in docs
  - Drop Work::cancel_work_sync()
  - Make sysfs() available on ordered workqueues
  - Add #[inline] annotations throughout

---
Alice Ryhl (4):
      rust: workqueue: support stack-allocated work items
      rust: workqueue: restrict delayed work to global wqs
      rust: workqueue: create workqueue subdirectory
      rust: workqueue: add creation of workqueues

Danilo Krummrich (1):
      rust: workqueue: add ScopedWork for non-'static work items

 MAINTAINERS                                    |   1 +
 rust/helpers/workqueue.c                       |  16 +-
 rust/kernel/workqueue/builder.rs               | 370 ++++++++++++++++++++++
 rust/kernel/{workqueue.rs => workqueue/mod.rs} |  86 +++++-
 rust/kernel/workqueue/scoped.rs                | 410 +++++++++++++++++++++++++
 5 files changed, 874 insertions(+), 9 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261012-rust-workqueue-658cd0fbe770

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

