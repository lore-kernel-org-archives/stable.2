Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794045372;
	b=1JyK/J1BtFWBFU9Elgk52z6Sl681c4+mKS36mbtrQK+iUczOuVoOwlGyo5ob7e8HuWv3
	 Zih2PQSmn0rDitkgORJcDkkQN97S+14t0ENi0B/d4Ek7asKy3Dnkp5ELEdHVq+DDQyGzT
	 eHRCKcEhJPkFNV6jO/9uf7D5J1afBDyv+Rcz78Etq2JQvrKCDqAPoifT+9fxhRWklyNKP
	 i01qa/zkXZzs8zMcuNtWARhHdIrSJwEJ43EZdb83wJw+QY617bSsJD5MzN2NcDaMhrrJn
	 7acHmDBV4Chz7ZDc50HSkEIeaJ7IpzswhLz3Zq91W8yQCIfBbYqat1qoq3Fg+Jvv9Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045372;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=krp+w0NhnIhU6G1S3RDYS3X6sctkl/kWyiY9YHcQw50=;
	b=E2UMBEX2ejGEyHwh0vk6dEpdBMvDU3xaimrKl5CNdJQkFbSfM9yksenauQeGmBpZG4ne
	 8mkOpFqs8f5IA1MwndsdiXbCRqMQZ61ifhPT+8Kl/RLPnJ6WmPzjoW4GTulhffcBtr14e
	 IKQSI8VPQ0LF0Y1AhvCMRFQ/W4KB3udobwc1qiyZhJ/HZgrPoHydROwwK4RWCThMjpVYi
	 gB+SpUVseMFGUly7cL8u4y35Z1f1NsxARe+bU57glVQ09iWUTh5QisKuGFaxZNW2ikqZ1
	 O2Y3exDl3Wy9JrpJ+LLw7smxRVlgTs2SEOYXgK0tDcy9ZQmHE4YDK0nJb++6OA0B61w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZvbwX6Md;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB33606A333;
	Sat,  7 Nov 2026 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZvbwX6Md
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794045371;
	b=zw2o5BhNzadqctqSpLOSF3RQUpTb8JCDcUi+QKbQduqcEIbqc8dBllvzG7boKTqPpdA8
	 1dlxf/aRgesxQHgDC4zXRMk8vq1fiTQc2R859LfaC/ae3bx/nAuLL5vIGhCFqQjBpJO8X
	 40WLryobTDD8NtGOgVWRWEKUZiyLgA3dEMl4G+P1FiMU51xr0LkIl5aBD+W9naoMNr4ju
	 DIxoYd5M88GLR11iZBrowck3cJJKS9+kOSm8saYmxR3YTc7H+R9ytSPgrKGvHIs+6eN0s
	 vVSIySSqVq5evW4vkXK6k8qF57Rs3ynGIOrqZ7VT4JWA4sqciqHmzIt8W2+FnHCfb1Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794045371;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=krp+w0NhnIhU6G1S3RDYS3X6sctkl/kWyiY9YHcQw50=;
	b=Kj6tu/2+AxjA9PIheKYC1lMZ6Q4LfOM38UptwLDN3swfA1l70uoNrWXvt+rCM3ZIF0tj
	 0uS1yacmmZlcE91sIZHr+1OQefM7+KUMCY7/SaJkWJFjrzKFS/MwLZ1u8Oa6EBvE03pfS
	 L1TlFudTKAGKbclGbXvLb13V7X7qfi6xdbDDAazSweLPr9cj5Fe89EJoxa3YFz8IQbV1y
	 fI1MAFdq/SqRoNTWpD256OSzA0A0B6PMtUK/p/59MZILEpLWK70OQId+0jxuztln8LdtD
	 rpDTBTqPxgfwiMtsuznbxC7R7za8pYjty8fpJfHofFBSrKZJO+4Xfaa8NxIcxMqOy6Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1A32A1F008A2;
	Sat,  7 Nov 2026 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045371;
	bh=krp+w0NhnIhU6G1S3RDYS3X6sctkl/kWyiY9YHcQw50=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ZvbwX6MduvXUUCZb6g3blwb5Lw1YkQRmUlA0irZuL9Z9bqYymP3sRJipiEnV6d1+/
	 XlF1bt6htXygkjoQ5+lPuakp96GBGY3Xnp98FeF2Udd/9N8SygX0cmnEdJvqQwT0Zm
	 KHtEyS9XTrdk8+eIWZVV/q7NCeH/TPY2y3G0t91Qe42wrSEFiAwDXP0zpHvfar0cAJ
	 9q+KIG3RcdGpPiCaZz4tCt606FPbRPawqK8HDVW01d1PnTPOqMSQs/Rg+PGjplbsNz
	 AHrkHp/fENxvTasJ9dLCtf1AZwV0UdDqciA17LEfmh8Cs0R9unaon0k7t5be9HG/jK
	 WXMk3Jv+HIHFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9E96147B4A;
	Sat,  7 Nov 2026 09:56:10 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] usb: gadget: gadgetfs: fix ep0 request lifetime and
 event counter
Date: Sat, 07 Nov 2026 17:56:08 +0800
Message-Id: <20261107-b4-gadgetfs-ep0-v3-0-62089dc0ec07@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/2XMyw6CMBCF4Vchs3ZMB7EFVr6HcVHaaamRS1okJ
 oR3F3Rj4vJPzvkWSBwDJ6izBSLPIYWh3+J0yMC0uveMwW4NucglkZDYFOi19Ty5hDwKdCUVhgp
 FSlewvcbILrw+4vX27fRs7mymndkXLg4dTm1k/SurP3nOkdCWZSWZtD2TuvhOh8fRDB2s6xuxe
 VP0ugAAAA==
X-Change-ID: 20261106-b4-gadgetfs-ep0-f814c14717a9
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jing Lin <kayano050408@gmail.com>, 
 syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794045369; l=2005;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=uuCOM4XxxKSay1DeLkiMJMLE9TgnzXP9EieCXzNPA98=;
 b=q3gwY2s2RvIl6xOyiZM0y9SxSfJKYitmPLTvrFGMJv3Fj/YS4mJ7qmhRRZQLU8eGl9YpWB2CA
 0wSWaZbBV0eCvqFOrY3vSoiMi/vBK/lV3vXvxg0wjNQ8gsl5xqdL/iA
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com

gadgetfs_unbind() frees the preallocated ep0 request after disconnecting
the gadget, assuming that no I/O remains active. With dummy_hcd, a
delayed userspace response can leave the request queued when it is freed,
which triggers the warning in dummy_free_request() and a use-after-free
when dummy_udc_stop() drains the endpoint queue.

gadgetfs_setup() also reuses dev->req for a new control request while a
completed delegated OUT transfer still has setup_out_ready set waiting
for ep0_read() to copy the payload to userspace. This overwrites req->buf
with a descriptor pointer, so the later clean_req() frees the descriptor
buffer instead of the request buffer.

Keep the pending OUT payload in a separate buffer, track whether the
request is queued, dequeue it before freeing, and do not leave ep0 busy
after a zero-length status stage. The second patch prevents the ep0 event
counter from underflowing when a concurrent disconnect or connect purges
the queue while ep0_read() copies events to userspace.

Changes in v3:
- Replace the v2 -EBUSY rejection with a separate buffer for pending OUT
  data, so a new SETUP can reuse dev->req without overwriting unread data
  or leaving ep0 permanently busy after a zero-length status stage.
- Dequeue a pending ep0 request before freeing it in gadgetfs_unbind().
- Add a separate patch preventing the ep0 event counter underflow.
- Link to v2: https://patch.msgid.link/20261107-b4-gadgetfs-ep0-v2-1-d8896e1ad517@gmail.com

Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
Jing Lin (2):
      usb: gadget: gadgetfs: fix ep0 request lifetime on disconnect
      usb: gadget: gadgetfs: prevent ep0 event counter underflow

 drivers/usb/gadget/legacy/inode.c | 102 ++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 25 deletions(-)
---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261106-b4-gadgetfs-ep0-f814c14717a9

Best regards,
--  
Jing Lin <kayano050408@gmail.com>


