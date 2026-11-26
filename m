Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674976;
	b=pc+svURVK80Wd5n60vvjY31262ZPCAgYAlADc8ohlyBqxAXSXAkIse7jmLIfiLbcki72
	 Bojr5Qg/eygv3Pd7ebvAG3xE///wG15JGsTRMW4H+TvWWeXpm48fFtTrgjb+yO3aUL6MU
	 7lRACyOTZNDH9UFlPbU1Dy3rVEy3N/30e08ZQp6HN2n9svY1FE/jeSndDJ5GKOf1n2uM9
	 gWbC2eT50p/gh+sL/jlq4PivXBqQwCL8yHod8cnsVwgOXMpUq1F7OC07xQ5nkWntXjSCV
	 0NmWVAt6ipR2D4I0sk0LpEtqy1nslYdtKTGM1iK2u/FqjyF7i2RVGP56Q4tgpMlZ+Yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674976;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=p9bIKjrcw0PQ/+kX6tszNGHc1L7hkY73UaPnoiDSCcc=;
	b=3olZcXvyn1TZpDeI+OVN9i4b5A931Wz+BdD+promxBEbcP8xWrEWBdxwBrGa1LzsuoKh
	 RoaBvNtLe8u0ScOabL+09eZWm6Ecz3FiR18InJVGHxubgVAFNggvhbzNYGtX1nzxpgklI
	 uKd1RPjXL+MxmyJ6SKpxcgjuJBmyAlVAjWyD4RinSwhIbcZa6eFTdzZKlu1hetHhqWo8f
	 qjYf7TaVePegqZuoIkwg2aWIGfa1KekpoB8++boLTQYNDZEv2nHaeENU8Z86jl07+m+ln
	 lWb+sgWvpH8Qeqft235y6OmfUxRQHorMgnunIpJBCX0Ee6h9OAC/8hz6WVHOl5ZtFvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLDysAmv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94769606A31E;
	Thu, 26 Nov 2026 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLDysAmv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674975;
	b=Emi1Oj78smEpps9IXoLE4/zPhp82VoJzrcnt4gYeLi+kzQkBnNoLdMRnP3rpjcAD6IbL
	 SdisLdKm7fvHl/CllRrelXNqnmAqJMDTTxY/tK8HLiv140RCj5qwx3YpWzZc7t6Qna6e2
	 dCfAUr70ToBzVlBy3vNO8KQgik7lgYjQJH+mVPxp5amLl00cclAazPvShF37AiYPFYzJv
	 uKvs3RU1GQ02jn3owX2BCaMX9WtImEG1xeawIvDMUHxbeWxTXHNG5Pnm8cCT66fQD5+93
	 XDCSAHb4GG0G/QHgAgsGfLQ/X34zzIMFtQWfWpkKgcFdys2jIO5eaxqTth+0u+bdqJw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674975;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=p9bIKjrcw0PQ/+kX6tszNGHc1L7hkY73UaPnoiDSCcc=;
	b=Gejps0FTJwNWPi8BkJHR2laPPcWfITEYLqO+osDekuUtTd87OfNnQtVBPSVGmujVheqN
	 7i8kVIKt5mNCeJ6r2y4GwRMmlGMm9jYWV6rTqAFCcyPaeojJwPyTn73GYLhQicvthVCIP
	 h9ILUmIcD3Bl0YcznGve2cZu5lRYNXYLLXsqFPA/+KK187X+fKXKN/dISF6SzhW6S+udU
	 dlJRPG2sWuEc1X5535Cq5qOjIMW3vXmR+LBAVEGE3QK22zvwpp1ov9k7xoBSpkkl4ivRx
	 CztHH3p4J5L6D3/I+g0T7uiOB8fmecUFgt6iIQ7gYXGMsBYjNl+0HA0yPGxuUajhWmQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 25FEE1F000E6;
	Thu, 26 Nov 2026 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674975;
	bh=p9bIKjrcw0PQ/+kX6tszNGHc1L7hkY73UaPnoiDSCcc=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=DLDysAmv/Bn4r8jgYmIkaQb4NqCnGp16g8TtntuCgZ1+v2XbVoWxqVpMtjM1lZGLz
	 r7FYw0Y5apt418Dj3k9OC67ZKp4rqD1LN6dPoTiAZrMupRSUltIrrd1cjg50/hBzlm
	 f7/DpBV4k5E3zQd1GvKaV0q3pnTQ8pR1oTcUrkVsTxSdDB8YSf/gIsIIplPRLmMxWd
	 kPS08SLqglSlgr3UqvL4NnkLRs1Ffa/Ph9DwCUEdreD3Rmsc7qj0UnmKa1cakepYiG
	 14MzA/lNL3wZRt6yXd/2SZo9r1B0zWJbKdRWpcs9eZXHn6qobDyRhqFG8oUv9TY5PA
	 uItK/YelM6Sew==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A6B174D281;
	Thu, 26 Nov 2026 06:35:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Subject: [PATCH 6.12.y v2 0/4] virtio_balloon: quiesce balloon work before
 device shutdown
Date: Thu, 26 Nov 2026 06:18:40 +0000
Message-Id: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
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
X-B4-Tracking: v=1; b=H4sIAEHPB2sC/02NzQ7CIBCEX6XZs1sLUWp8FeOBn8WuacAANpqm7
 y7oxeN8mflmhUyJKcO5WyHRwpljqEHuOrCTDjdCdjWDHKQSQipcOBWO6DnoGU/jURwGM3qnNdT
 JI5Hn11d3AdUL2b/h+uP5ae5kS3O1ptGZ0CQd7NRQpuBKjDM2vv//gG37AAinix2lAAAA
X-Change-ID: 20261126-virtio-final-875140b7fdaa
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
 Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795673921; l=2322;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=ZT+5Ez28VjKU98DLLctCFr+rz8Hd8Cde9lAjru5yUy0=;
 b=9PfDIFEZgwlj/0l2msItZnuU1f/ifDvV1DPMOF0MTpIPRGlvQ40tpsR/ME6W4BEt+4zezYW5c
 bohXAhM7CJbDT4iCY/6pU+kWr/jsadhOSHaL5irOxQGJhyiS+YAstjQ
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

Hi,

This backports the fix for CVE-2026-90129 to 6.12.y, the same four
commits 6.18.y has:

  183a08715af1 virtgpu: don't reset on shutdown
  0d8aebe089b4 virtio: add virtio_device_shutdown() helper
  29536a923a94 virtio_balloon: factor out virtballoon_quiesce()
  7e17eef04600 virtio_balloon: quiesce balloon work before device shutdown

Since 8bd2fa086a04 the generic virtio shutdown breaks and resets the
device while the balloon's work items can still be running against it.
Patch 4 quiesces that work first. Patches 1-3 are what it builds on.

3 and 4 are clean picks. 1 and 2 needed small changes. 6.12 has no
reset_prepare/reset_done in struct virtio_driver, so patch 1 adds only
the .shutdown member. 6.12 has no virtio_irq_get_affinity(), so patch 2
puts the new helper right above virtio_dev_shutdown(). The function
bodies match upstream.

Tested on v6.12.119:
- x86_64 allmodconfig W=1 build of the touched objects, base vs
  patched, no new warnings
- x86_64 defconfig plus the touched virtio options boots and powers off
  under QEMU/KVM
- The race needs a balloon with free page reporting plus a reboot or
  kexec while it's busy. I didn't reproduce that.

6.1.y and 6.6.y need this too. I'll follow up for those once they're
tested.

Changes in v2
v2: resent through a whitespace-safe path; v1 was damaged by my mail client and does not apply.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

Thanks,
Dickson

---
Denis V. Lunev (3):
      virtio: add virtio_device_shutdown() helper
      virtio_balloon: factor out virtballoon_quiesce()
      virtio_balloon: quiesce balloon work before device shutdown

Michael S. Tsirkin (1):
      virtgpu: don't reset on shutdown

 drivers/gpu/drm/virtio/virtgpu_drv.c |  9 ++++++++
 drivers/virtio/virtio.c              | 41 ++++++++++++++++++++++++++----------
 drivers/virtio/virtio_balloon.c      | 34 ++++++++++++++++++++++++------
 include/linux/virtio.h               |  4 ++++
 4 files changed, 70 insertions(+), 18 deletions(-)
---
base-commit: e2e4b92c2b2a3ae78423cb343951cb5d2241b405
change-id: 20261126-virtio-final-875140b7fdaa

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


