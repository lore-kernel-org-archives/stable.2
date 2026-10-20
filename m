Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500770;
	b=247m4ssXOE8NJz3Qp09blwXTnvcnGAh6cAesbbemJHmg9J8bP/8C3rjHfqO5SXvnyPAP
	 FO9SucZn3oAsu6+jy6Re5RsIEecFf4oYTJ1Wsh0bR6Irw8lWKAqd6BcqrDRpEjMLpuqlI
	 Fj6oUAlCN+fhw6z4l2jPYxJtyJsApYwjpLOUpeHWlTQfbPn9pYORFMxW6ayP28diY3hKo
	 pLAfVsg1K2IzGwkRnoFFeYjE45NoJyqyzzvrHTGhM09bxffc7La5YgHIAaWxS8Q0xYZ2x
	 O+gJim08SQD/QeK8adv4FoiNYWEz05r5Dy7Cd55JQysDwBRH7HG7MmYv6N1bCsN8b4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=h4dSeWA0TZhH/a30MaXIOvSiMoTtdnOH3PXIJsbEBS0=;
	b=wI56A44nnX5BhSNOvohpjovIGRJZFNUXb2ztSNQ1cHlA0ERnhYjadYIq0G2NXIDwVU4p
	 Zu/N3W4KIBHPZ8d7X2Z5sZTx/3Sb1YXGvACvqEPtODxuXHxT9iPGdrVzeaqah2/F2Jnd8
	 KFsmW9tg8jaUdqAOlF5mYGazC/yBqlnxSuxh4sa2tVrAGiLUNHP865kTkP9QFwJgbbCHs
	 Vm4/CLg8cOHhB+jeRXcYbaRPKlVu4a7I27dx7T7dXT2Rk9hNjQiGfJGaimPcwnH1GD/36
	 G9WjsK6Uk9sq/jfuDwydakRKRQB/fVrOQDY/vAxn0zWCt/oNoefCW8XfEQvZWFwYJfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Hb+sXrL1;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0EB606A320
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB0EB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Hb+sXrL1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so2028134f8f.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792500768; x=1793105568; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4dSeWA0TZhH/a30MaXIOvSiMoTtdnOH3PXIJsbEBS0=;
        b=Hb+sXrL1A3qp3CXvy3N9jCrBC5c3n2L0LCYOi4aQCCOwzOBOLLKtI+Cb+2wEAJic7q
         z4Eh88dX83J1XOnNYjkokMHB7EtKTFAbmD5nU4Qz0aWWoF5bhAXteoCiHccPTbxAkHqu
         r8ypT+pIzoxy8JjciI2kd1H2ZNblq/U/WiwinrBi49ydTZeBdqLJrkY1t5RiKWYq+VYp
         3rJudVa24glVh17W9LujSWf0DbUSMyBwAFjsMccAqdX6inVKWATsYroU35IIWbOoNGyA
         fY2MqmIQ0pghdDSQjuNPwxYlvPA7cmr467yR8eGxjYn2HHlSAhT7syN6C546thNm0y7t
         RsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500768; x=1793105568;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4dSeWA0TZhH/a30MaXIOvSiMoTtdnOH3PXIJsbEBS0=;
        b=dHf6APerTjCwMuh6QUc5QAkXdbK6IJdI452gNwm2fkWPgprOIpFj2d3JwGl+ZtA5ew
         sOefO0RRayUFW/IeEiiOyjRw+c9SJX0uu5fB8RVoGw8hf8Yw/XRF9AVHfGj93EQsZKRy
         NATnjMWOXLfPUJU+kyd13hkzUagxLVAzfHkn33W8GIFK34HFeZKYJ7cvCP6MiyB2bUkp
         2tzux8ldAdrBMklVPZYUY76ZXqSw6IpzrhlzJh614+heYT8hIz4geilBgfJaus56tasm
         Eu3G2pTYAoVwkaYp2bh3kPUod4t+/xu6rMF/b6Q0nhmXkhh0KNNHgebVoJdT3R8WZ9q9
         6icA==
X-Forwarded-Encrypted: i=1; AKwUvBzHQbgtl2GRtxmse1cigDpK2I128raTHNaLbIZcXT96tnrvIoDOoZRVAuEyMLLGmQLcmcQ8A1Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYl5qPFlZgSAtMVsWSoP/CAODfmQAJFGimfe8nhhuow9X88Dx7
	ssOJoN18P890O/BXKsYZLja8Bx1Zbi/W5o6qT+9DbV9Q6yHDuoTAW1aOUa9ubaiqDQ8aOYCso4J
	ddxl9sYuN1f9Viq7lzw==
X-Received: from wraz5.prod.google.com ([2002:a05:6000:4685:b0:48d:f161:cdaf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4694:b0:487:b4a:3f54 with SMTP id ffacd0b85a97d-48e07f9da3amr16892672f8f.29.1792500767961;
 Tue, 20 Oct 2026 05:52:47 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:52:35 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABNk12oC/z3OSw6CMBSF4a2Qjr2kLfYhI/dhHCC9QINSuaVqQ
 ti7jSEO/8H5clYWkTxGVhcrI3z56MOUozoUrB2aqUfwLjeTXGrBhQRKcYF3oHFOmBC0sq3j3Q2
 N4SyPnoSd//zAyzV3R+EBy0DY/BluuRFaSSXLyh5P1igQ4JqRziPShPcyUL9ThHPKl5bd27Yvw 3h11rAAAAA=
X-Change-Id: 20261012-rust-workqueue-658cd0fbe770
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3393; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=YrUDzBvba3x+3LL60N6o4S9VKs85idwu0qTHG71exFU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq12QZrkSDCsbkM2IX5DEGwRjx/zHb9Od523ya1
 3XI8gry9hSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCatdkGQAKCRAEWL7uWMY5
 RoBfEACiWD0gE1O0ceXwL9CpqVv8XFZCxtiaC8q3opv8DXffNsmlHiTwX9t3gu1d2PnsimZiX/J
 xRXEmLvsTQihvJRGkI8BLiw+MB+EGfpWbp8bVlmS9UkHLnY4OoNH41NEsV4RKz5RVglf5DXV4m+
 I2RQTDrB7EdjbWHR/Pf4KHVHkwSFNkG+KlFb1RLTwmUDMOFo0OhT/CpX/1z5Ody6yYVLGuuBgn6
 xvrsiFWPN2xW18EJ/ZE+IzfeSvTLHPKx3ypx9bA6qUc2EvxvEy6gLKTzt3Eza3Sv3oTdaUNl6Em
 z0N+Y5R7KU3Zy7W7sxKPCyFldpmqgo+2NkA0lzXgSyTd4PGgsZDUDXpyNTKupCQO5Hlc1xqiw1k
 XZWD8xYbYnfzK3V9Ysh++FH3YI6Bdfbqq9ZX8dijM+S70wCC4Biy11xB1rQcm7nOI3qfGaWIxtT
 jflXXxPY6hueGgZY26K9ClhXjpGoETj/KVFnY4kbDcD/azMte5yrux6XpqtP+9mzyDLyKB38x3D
 u2WVj53xlkxHxAcBJqHfpQkZInayArnmGke2Ghl2k89avYmneMftOltaeASHkMjPX46zeqG8NrV
 k5gVY6oqgYLa8sq9vnGaOM1jatiaZ8yKit/grQGO9nkZBH2h/Ay469VwgjejNx6avmzxGw7FRIc m0nsqlMabHT3GoA==
X-Mailer: b4 0.14.3
Message-ID: <20261020-rust-workqueue-v3-0-ea7c74d02068@google.com>
Subject: [PATCH v3 0/4] workqueue: OwnedQueue and ScopedWork
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
	John Hubbard <jhubbard@nvidia.com>, rust-for-linux@vger.kernel.org, 
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
system_{percpu,dfl}_wq", is a fix and has been sent separately [3]. This
series no longer depends on it.

[1] https://lore.kernel.org/all/20260312-create-workqueue-v4-0-ea39c351c38f@google.com
[2] https://lore.kernel.org/all/20260617144645.253444-1-work@onurozkan.dev
[3] https://lore.kernel.org/all/20261014-rust-workqueue-system-fix-v2-1-c018b8f870f9@google.com
[4] https://lore.kernel.org/all/20260807165252.3849875-1-dakr@kernel.org

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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (3):
      rust: workqueue: restrict delayed work to global wqs
      rust: workqueue: create workqueue subdirectory
      rust: workqueue: add creation of workqueues

Danilo Krummrich (1):
      rust: workqueue: add ScopedWork for non-'static work items

 MAINTAINERS                                    |   1 +
 rust/helpers/workqueue.c                       |   7 +
 rust/kernel/workqueue/builder.rs               | 370 +++++++++++++++++++++++++
 rust/kernel/{workqueue.rs => workqueue/mod.rs} | 108 +++++++-
 rust/kernel/workqueue/scoped.rs                | 342 +++++++++++++++++++++++
 5 files changed, 823 insertions(+), 5 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261012-rust-workqueue-658cd0fbe770

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

