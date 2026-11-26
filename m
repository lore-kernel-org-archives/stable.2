Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661115;
	b=4YP9rraNNpjSMSpafefBM6Xejm1QgaHLbwaPwVNV9oVjMKyyhVb+fJ3PC1gtorOoiPdF
	 TiqboKMyWF3pgCEsW6bGRjgVcS+cP3L60WRYKDZ0nsMsOaBxvhD4imwrIo+p/Iskwzivm
	 9h0swrBVOLKqw0CaTHsdLT+FjqpSJaOUz4Wq3kRzELlW8sbQcwloj2db9dckmJ8CuIqfv
	 pWEhsroqwDXqT4hCqPXHd4VR+CmvUIJfruYeTZMmV+chw05m9sQV6418RXyhonM+tYvbF
	 aHmHNQgOcwGJmixTNbuHd1WNy1+HteqOnQqya8IqOIj3eGk9jIxPxhoEBz1ExtuGd8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=R6c2jmbYqWccEr0Zv9Hq/ZQeve0kZ7n3mGg4UZDjyvA=;
	b=r3be2tsb02BlSt/i4kbyWdGA2U2mDAp37407BsSOqNyHGIGvymQisQgD6St86BwJeJKB
	 ak4wKVC90Leh+oaV3eEVgYy8QwrZxwV4y6KoFjaSKhxN+nk/vciPXKep6bNq2fCP8s7cg
	 IQmnXu0r41hMwyDUF3LCuD0Uz/NZeJhA+x6wm/Hy0ki+w2RZ/No9EW+ogeyw8pP/9amlp
	 DSvDHc0ZPBSgnWJCXtHBUCxHq/F6agVTT/Hv/32XhJ6TjX8ANnCU++J/Os1lXmfkQTAeS
	 yzLHfLzMLQj03RoqhxIVClQOEmSS7qkBwjL0hW7GiLU74O9M5DJ+0vBazcUq1D7oHdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Q2QsICvw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFCD606A333
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFCD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Q2QsICvw
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67db5e13b0cso5960120d50.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661114; cv=none;
        d=google.com; s=arc-20260327;
        b=ie9mCB5evVnTqvqtKCn6cj4JU0rlGrgPc1Fu7dHIP6WAdSKx29CjYzA4hNKZfh5Nr/
         sKzUMdunW43bFlhQS1Xe04ASr73MypYhKZDRy4fIdsNQ2MqCU4+ULqlvk50gPeU77l3G
         sTJqbv16AcU1awK6WEGPMnicpidEW1q6v0l1ZCznRKaUpia58RsYERH2MEOFz9r46tLe
         zP887OrqbvotfYi/GRxdzlWxb28LHSEenqWWxlcWxJ15zmR375/agLkp185jFebY8YRp
         526vc6m2Noiuae57/bRshSL1cdtOisvZglYmrSPphJ5eLqJBIOY/L2LX72NYS1MZg/Fr
         8fCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=R6c2jmbYqWccEr0Zv9Hq/ZQeve0kZ7n3mGg4UZDjyvA=;
        fh=Cl8p86fIxraTdAPl9TMEjG1uOAHTz1nspTZpzog1E7w=;
        b=aoPVYAzRl4zFQjlgdYJ4ajVjhlwKfXVW71bbkzuNJL1PeT/irWZpC/SdGrJjx4XVGe
         MHRTG8WB7AeWZ+KmuazflbA5OBO/rKv9uswBMRWEug4vKu++nhQrTQKKV+sylYEKyYDo
         H3mELkjfSRc5LnsnOnNv4RUXpVrDR0LmHZC1r2ZCAh7FSmDVgnTfap35iyPnL4Zc4wNK
         KXrpvjsbILn3lrPy7z51euaibs9CE5cBW6smFM47MM8WEUaXWXD6/1hksxvYNlljBUhO
         QKQGS+/l5SnE3iJ/QuRT/oisNLMBEhk2KPSVT+066LiOwgvPN6rHSugMleHLk+RYviAn
         fyWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661114; x=1796265914; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R6c2jmbYqWccEr0Zv9Hq/ZQeve0kZ7n3mGg4UZDjyvA=;
        b=Q2QsICvwvl/oIqh2A/Pf8xC7m50NMOlOh14GmLJYQCSvh5IG/1Qcgfu/5DYrlvUsZl
         95aCnY4BjR62ZiSoCYGTYVVkAWRf7WlUGD9kkuk797iAmDRLFpaiCq1JErs4QDIcQe2p
         HsP2Hi11yzIclhUYgLR4YWxQZL9ysk5hxdTaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661114; x=1796265914;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R6c2jmbYqWccEr0Zv9Hq/ZQeve0kZ7n3mGg4UZDjyvA=;
        b=gI5khzizgryXAP/au9Pz8mtv06unUaXDGGd09n2PuIVgq15OFs8O96ROjx1nKabD1A
         zXuP5Xv5cMPJCs24DamUnfgMCD9jDidh0sXU+gFE0DIz8zNytEAbO4NoqJHCXAsbt3dx
         LBoBtKgfzqUTL9NZ9Zr5Iy2a1y752CQyxUQ6ZLkjo5a4/8BMwJ1SbVDbDoCk+nTE0nUC
         hWCoxoO6N3AOdhEUN7xqCBzmqRjzHA0y7LrOyQQnZflUtkXldLwDmsrAkwWZpRVIG3m4
         Ibt1yE14RS6NNXIHnQ3QVjjFvneOPnI6LVsueyY0tEIHlave7WNXI1sUyJ+uh4mHkQnl
         kqzQ==
X-Gm-Message-State: APuU4Z9I8EftYV32XWRuEKtIkNT+Ly93+4WP6Si2HIaZym3cZH3mNHzf
	3er17WebdOAKUrRERHzSRTrGSrbaukpuTKl1ooeDCXzXGgHy1l7s1P/MJpp5lVCghhRD+s8wPHD
	F//ZpjdAc2Cjo/yWEoLSlTA37BElapseHCRoPHnVnBCkSJ5RfhWLcimE=
X-Gm-Gg: AZFdTZc1M3aCesLCmWsLFeJe/bjQW2DhDtUWKvzmAkftEKQncOGacUUfFGLYR3qOzle
	gyqrp2B5uxNX39BZC0lXAPuMLX500UA50Cv+/aK/0Q7Qy8tmC/ZNEEFBmZL3XVKEf5SdGlql7Vc
	Y07Tir8yJwQDbGunCNbH26v8rI3V/l8iZ7zEmOORQGFjApHMKf+1DONyaDysjf0VWvl8eut/R1u
	UmVzqE+mVqOF711FY7QqrcnoU7n9B/Z2QT8d2XNIMoMjc8Einr/1FZvKF+uSvNqEB/XwtiZqoDl
	oCE7hiSQUCXHytHSCHLK4h+0UmA5NBxOgzDkivE6IIb7RCS7qN55+lY7iieBt/gaPtPnKJvn/OJ
	FUs7rOxD9ZyP1s0nygPyqiMSeO7iYZ/NspaQCbmNWlndhXFOA/iygNWuBdk5NpHqHiny4dtGYIW
	EIg/lOZ3CJ9wP175ssk/wmHVJCxJs1OyyIAR4QYGGJzYBIgGHTVEFL0HldMMHL9M1dU/udMQUnT
	z/cLLEpxw2e+JjPrkkgSMcwI8j9YuY9fnUv
X-Received: by 2002:a05:690e:440d:b0:67c:6e85:56c6 with SMTP id
 956f58d0204a3-67df442280emr3979707d50.32.1795661113738; Wed, 25 Nov 2026
 18:45:13 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 18:45:13 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 18:45:13 -0800
X-Gm-Features: Aa3M54paebocmbNVntVMdO9KFEoA8PWN3oNp27JwrB7O8xF9Ll5ZA1pgj1Og6sw
Message-ID: <CAFaZ9epp-Y8efod8a7CQuQqYEjk5L_ruwP+c1SoBRPjdu9uGyQ@mail.gmail.com>
Subject: [PATCH 6.12.y 4/4] virtio_balloon: quiesce balloon work before device shutdown
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: "Denis V. Lunev" <den@openvz.org>

commit 7e17eef04600c399c7e0f5ce765da5cf9d40d8e1 upstream.

Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()") added a generic virtio bus .shutdown handler that
breaks and resets every virtio device during device_shutdown(), i.e. on
reboot and kexec.

virtio_balloon provides no .shutdown of its own, so that generic path
runs while the balloon's asynchronous work is still armed. Once the
device has been broken, virtqueue_add_inbuf() in
virtballoon_free_page_report() returns -EIO and trips its
WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
ordinary reboot, for example a kexec based upgrade, into a fatal panic
in the middle of device_shutdown(), so the machine never reaches the
new kernel.

Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
inflate/deflate and OOM paths do not warn, they call
wait_event(vb->acked, ...) and would instead block forever on a broken
queue that can no longer complete. The device has to be quiesced, not
just kept quiet.

Add a .shutdown handler that quiesces the balloon via the shared
virtballoon_quiesce() helper while the device is still alive, and only
then breaks and resets it via virtio_device_shutdown(). Unlike
virtballoon_remove() the balloon workqueue is not destroyed, as shutdown
does not free the device and cancel_work_sync() together with stop_update
already prevent any further work from being queued.

Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260624140846.2616797-4-den@openvz.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 726aef5be178..efa77daa93b8 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1159,6 +1159,12 @@ static void virtballoon_remove(struct
virtio_device *vdev)
 	kfree(vb);
 }

+static void virtballoon_shutdown(struct virtio_device *vdev)
+{
+	virtballoon_quiesce(vdev->priv);
+	virtio_device_shutdown(vdev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int virtballoon_freeze(struct virtio_device *vdev)
 {
@@ -1229,6 +1235,7 @@ static struct virtio_driver virtio_balloon_driver = {
 	.validate =	virtballoon_validate,
 	.probe =	virtballoon_probe,
 	.remove =	virtballoon_remove,
+	.shutdown =	virtballoon_shutdown,
 	.config_changed = virtballoon_changed,
 #ifdef CONFIG_PM_SLEEP
 	.freeze	=	virtballoon_freeze,
