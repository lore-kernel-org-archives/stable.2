Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591712;
	b=b1qJ6ZG1bWED+ZBMctRvtSI4qdzGdRetnzayXOBKLjb9lDwg+WAk3qHb1JTHiHWVBWN2
	 q2kBEdLdSsvKemJecsVI5evnvRerFxLL/umkvzaxQ/yrvXKYLlfwsgd5Vw3aEDGR3d0if
	 g1Px1KWHbpVxradXs6uTDIk7+HhcJpb+EAgWBj+XQMgPGaDnP1QVgdR7Q5cYVT/kSurqv
	 EoAwqR9Kq5hCRdEtYzeqna6WRhMeSgUpMsIN0dzLgqA368gFxQ7bYiEGueN5XbuNUO5Xy
	 JZZOr1Qwb053Itau786ac/of2b7fi65jPjzOIO7L6rbgNN1zsf/c88AZHyqMK3uju0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591712;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=ihP7KjL+PAzK9/d/xv/d51pllI+qCv2Z/tVjLBC9h3s=;
	b=AtUFteNj3cmgYWn1kR9nf917COK4jtpT2P16clOxBBTUiQtBkKin6bDDSm8mxw1iZk7T
	 HVOAwk8+W3utFpgoJsETqqJxUgY9Qg3bobV6btbY0CG6zXoAz1/dP91eMbiqAKqpzH6n5
	 5HFlM0VqQwNbdhZ3aE235RSp66ITTOrXTS2ydnGQmMK02RmxYn7hdk/1ZOnqsDedzF0ck
	 2NGXeF/7InJoMlxyvKeVGIiGQCdYU06WUrD1CF0DuDp11geA/ORKyUAEzn7JTsVl/pqu3
	 k/oLfbwRL1uB8uZTaQBlg8NxtzYCctqZUL/ncQK4+SAFjbQ0f3YOivsZdBC/+QbpPog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=AWPJ+YLQ;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB260703FD;
	Fri, 13 Nov 2026 17:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CB260703FD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=AWPJ+YLQ
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4Lt6vGWz5B12g;
	Sat, 14 Nov 2026 01:41:42 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794591703;
	bh=ihP7KjL+PAzK9/d/xv/d51pllI+qCv2Z/tVjLBC9h3s=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=AWPJ+YLQonrXH6PkmDkVxuhbEr7kyqpXPzRqYLUpeBkXlem0ePoMhceFYEwn97/wr
	 RYpZ9MNF9Myp8M7vQqD6a6bed336RzCwQqGDbIDpiDdm8VJEN75gt0YTlN/JE1Mhe3
	 f/TfJuxFUN8l0s1PQntJUmuWlOcZk+Jpj4fMiteL0oqsGrmp/b0MAtfucXnF6/R2bQ
	 oUW0/uMnxC32lefCE9R+HvqF1guGhX12zglr/77861bg83OBM9rep/nj/iK0aZ2J1V
	 2CxnVQtUDN3c/WatKbMaDCfRGuYfb94fe3XHSvs1ut3c7mHlLthNtOEuLAJSSqwZ7V
	 vkl0H9jjqy3/Q==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ADHfURr084425;
	Sat, 14 Nov 2026 01:41:30 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 01:41:34 +0800 (CST)
X-Zmail-TransId: 2afc6af74bce9d9-0892c
X-Mailer: Zmail v1.0
Message-ID: <20261114014134444guLgF-vk0Xhi17ZUNemXQ@zte.com.cn>
In-Reply-To: <avcujpOaXJPfjgxQ@ryzen>
References: 20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn,20261112220120113cXLhRk6iDVvhfgGPoZ5vJ@zte.com.cn,avcujpOaXJPfjgxQ@ryzen
Date: Sat, 14 Nov 2026 01:41:34 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <cassel@kernel.org>
Cc: <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAxLzRdIGF0YTogbGliYXRhLXNjc2k6IHJlamVjdCByZXNlcnZlZCBiaXRzIGluIDMyLWJ5dGUgcGFzc3RocnU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADHfURr084425
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 01:41:43 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF74BD6.001/4jR4Lt6vGWz5B12g

On Fri, Nov 13, 2026 at 04:36:46PM +0100, Niklas Cassel wrote:
> READ/WRITE MULTIPLE commands are still accepted with the 32-byte CDB, it is
> only the count comparison that will be skipped.

Agreed, the v3 comment was misleading. The v4 comment only describes the
pio multi command check. READ/WRITE MULTIPLE is still accepted with the
32-byte CDB; only the short-CDB count comparison is skipped. The
dev->multi_count check, including ABORTED COMMAND for a zero count, is
kept for all CDB lengths.

> The reserved bits in place of MULTIPLE_COUNT are bits 7:5 of byte 10.

You are right, v3 checked the wrong byte. v4 rejects nonzero byte 10
bits 7:5 with fp=10, and does not look at byte 1 for ATA-32 at all, so
CONTROL values with the vendor-specific bits 7:6 set are accepted. The
commit message no longer calls them reserved or obsolete.

The function harness crosses all 256 CONTROL values and all eight
byte-10 high-bit patterns for a non-multiple command and all five
READ/WRITE MULTIPLE opcodes. It confirms rejection with fp=10, that
CONTROL no longer affects count validation, and that the 12-/16-byte
checks are unchanged. These are userspace tests with device and sense
stubs, not SG_IO or hardware tests. The libata-scsi object builds with
W=1.

I am sending the four-patch v4 separately. Patch 1 no longer carries the
v3 Reviewed-by tag because its behavior changed; patches 2-4 keep
Damien's.

Thanks,
Mingyin
