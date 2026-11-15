Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794733145;
	b=02grKOPo7lMbps0CXQaXZpa2nCEoEqbXVr5Sa6xLwgDgE+beg6quTQBTd8Y05HKUbMff
	 BCzGDrdB90oCUhIJtqGuiX+uN9++O3rh/Ah0+w+riz7THmuGW07NhNVnyH3cS6gOLWCOz
	 axkCMz3pAFeizBKsp810jjgRfiRAmtTwtSRunyq1eAhUp2FI7LbDUe/+5jD7dAZXzTWHF
	 mRxMCALveUY4aZRRN36TyOgZieyQrdAXrVHsBzuR/8/mKs2hlmi1ZX3MqiVsgtQm8bEtw
	 X8SmEg5EfB+FICoxDwQGbv2vDPrlP1CQU33K0KOIJqm/Gi4DOQbgf4EAKWA9e7wZsiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733145;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=w4c5EyXhPB8AqpXcztYFqZ1wWsQTa6fMhtyUitpIppk=;
	b=B6IP9wSc8lS6g2u1ckCynjEXjfOHmwQwqvmMjth+Mm06BC0agevyJvEKisnFIHgbQVDW
	 NeJ1e0BQFO+hM2tXc+eJ1UXzDwADu1v0zQ6GeMUYKXnlPoIHwDmvQZwHso9bcfvwKJZku
	 UPrfq2p7RVvz18ltkNjqfcM5bJLAiyN2MOIQlTbMhGd2leEqmUnQyw0mpBKVJXOuInnwj
	 mEU1l//BEysxgtNLjKcw4v/YKUfTWlE4ZyjtdXnt6slqnGNPswUF2rT2Z9VEDR04kFxIk
	 DcOTz7KJnAk42qiPrFLkOf2cTFSLjJYErDcpfdQLyI+4L8nz+V4IBEZjcdO4zIqQgQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvhXCykB;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED6606A31E;
	Sun, 15 Nov 2026 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvhXCykB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794733144;
	b=PYH7ONLnJweS27rUCQirrrXMrtw6Zn6TYAD0IkMivTQwH9m63GNmBpV+xaXJ+ChyKtGf
	 ruZh8/PepZj2bvQf5lXjSEDH6Dy0WXNiZqbqiPWQKpv0jMU+WdWpkHCYCiww3Hir4oZPO
	 YRVJBzGzWLwx/1uG6km196DwSQClhXlecFH2HdTOFAzhiuJQD2yWzAjk1HxVQRn92tc1n
	 JUokxEQu3YkzuulNGxMLf7eb6+awP2h9R8gl1B9ThmNlGZBVl+ALUjgzxBzJB4BsgaqAO
	 +UeC3xJpXUdU5wsL7lGUDilLaYP6TdYKzofvSuFdowdH+tVy1xZaC7SDXKG7mtJqTBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794733144;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=w4c5EyXhPB8AqpXcztYFqZ1wWsQTa6fMhtyUitpIppk=;
	b=ORPvgim5FyIBjt3UivUfsr4l39n3WxXPkIsZ8ZW1V8cHRHb2+3CZJvlUUSsComeH5Vp6
	 0dZkbB2yDZ9NChWW+r1IqM+XZHQgQcvPisgEo4hW9IHkDzNaAD5t0TvPYwdGTWLBFN2Xa
	 +3Lvwkit72T2mfexJwEsofSmQy7fKRyMPmQW7DwxgZecnE3cfX0o44hpFLMAi3fgFanxL
	 kGgXAU+017r4KfA+gdINT4ejcetjVs3fSJGBhc/jnVm/btCOJfXwNIuJPl68PlWM9zAcx
	 Z1lZR0oQA5NLniBhMepxoVMzI60OwSh691kA19h28Nw1pGpWH41nAYQxtxs4/EJYpiQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 41B1D1F000C5;
	Sun, 15 Nov 2026 08:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794733144;
	bh=w4c5EyXhPB8AqpXcztYFqZ1wWsQTa6fMhtyUitpIppk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=WvhXCykBnqMPlcGOtGXn1Ekqm+4XA/c3st/eF4qp5/ogHYJR1hwRnN4yARdjlRwLT
	 SwkNtVoagvK8zpqwgl47s/rBiUbwGOCoYcufIJO5BaAEcYoj5ekao0gQb7rN6iazSp
	 HsKAD0Ro6VomJlisbhnuZ227ITYQcUCKnXXGXsqSSDudqocEs05VFSshh6MPTF+AmF
	 McDsU+6y7+6ndfC1eWjOCOPlEQLsHcogZQJgEZhkTArhuH3hwjESvH8SBDoAE4lAvx
	 cuiNxR1MiAaV0Le2kKnF2935E63hHSxxnkKVm/0cYk6qs8MHD3Q3ymxVZu8IxWBnUc
	 rEWrtrkRdsW5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF54C4A015;
	Sun, 15 Nov 2026 08:59:03 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/2] media: verisilicon: av1: Fix two reference reads
Date: Sun, 15 Nov 2026 08:59:03 +0000
Message-Id: <20261115-b4-vpu981-av1-refs-v1-0-c65769715db9@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4atI1gZMKcPUq4iLauMYFyqNFkG8u
 9VZfg/ef4JyFFaoixMiJ1FZ5gwqC+hHP/8YJWSDqcyHiCx2FtO6uy+hT4SRB8XgLDk/kOEqQD6
 ueZXjjTbt37p3E/fbU4LrugFy+K5TdgAAAA==
X-Change-ID: 20261114-b4-vpu981-av1-refs-d9419af12e0d
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794733143; l=1051;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=KuW65qSSVnoaFOMXDWaytG4qSD+RtxeDkZRMmT3rxPk=;
 b=GOhE6FcdPqzO/RtJbvJshne/Kp5GWQEHTECh5RXURiF95TRQfXKzfe9d1oCbDfeH8DvnmWExC
 M/RJavEVeFIA1odvmPCM5B1scSIkoTHp/JQ0Wc7VbALqViO4CTSVN9r
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The RK3588 AV1 decoder (VPU981) can read a CAPTURE buffer freed with
VIDIOC_REMOVE_BUFS (patch 1), and reads the segmentation map past the
end of a smaller reference after a switch to a larger CAPTURE format
(patch 2).

Found by code review; neither was reproduced. Tested on an Orange Pi 5
(RK3588S), 7.3-based tree with these patches: fluster AV1 test vectors,
no new failures.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

---
Arun Iyengar (2):
      media: verisilicon: av1: Find the reference buffers by timestamp
      media: verisilicon: av1: Read the segmentation map at the reference's offset

 drivers/media/platform/verisilicon/hantro_hw.h     |  1 -
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c       | 45 +++++++++++++---------
 2 files changed, 26 insertions(+), 20 deletions(-)
---
base-commit: 48fe5a7834cc10081887d7bcd9ff0a4cadc3fa8c
change-id: 20261114-b4-vpu981-av1-refs-d9419af12e0d

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


