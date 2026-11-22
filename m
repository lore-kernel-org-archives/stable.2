Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358923;
	b=N9edINELcaLhfdd58vEMmWVthXA/FHo/RZEjWqivlSI5fO7yNlVZW71KwN9wXRhB9hPD
	 tjoEKZuacZ47GMuOH9ABoSsBeJdghlNryJgn89RFTjIV1Rngh2SKa2b1XRLk9MQwbx8vG
	 /l2P8t86game0lblQhU4Su+/WmWAzsmyAS6T/hA7Hok1nVDN3enoC8GP76JXK+MhVHv9r
	 lQjubR7d+nwiKIUjpNdZ3BaMRG2soJ0XfSw2pjvA0rOaXEMfrE8N9iEGJGR6XUY/eQ3gT
	 /lT39+C1hJm2S+1te60+a5uwHgptdB21xuetFziHNeapqE9KXzRBb+eluu3G1EN4Bjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358923;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=1z/aM03hr0IFRbAHonH6KNo37rpOIVOubHzUqF+7DhU=;
	b=MZBDV4TNqdFvYKhKCCxwCybKo3yV1PBpV8PgYdgVAyc2kk2FbhLSrt/M3MDcsCAzDwaV
	 IIUocnQ2emngbMKl15jd7WWu5/aHYwabt59LGS7xpZQEhqDiv/+xAG3kFu700lLl4dMhU
	 lRWGEyi4PUdEXgdEY425gGDabY4G8c5mFn/qW51onof8rb0k/3t2p72vBsDxxokcdc3ki
	 +xhvBeScY5VJM3nrB5imdIqE+Fm+aW6R3cqBuuIiVFYa3rJiA6W2zhn/uP3Jw+mklSNIj
	 TwnmWLw68BuaDoUzF7vH3YtG5Pqc3bxS51glj/eePFsxSAEEwU/eDG5MLhunIO86lPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=DvAHkUjG;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E6606A32C;
	Sun, 22 Nov 2026 14:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D23E6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=DvAHkUjG
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jXX4s4Nd2z5B7RB;
	Sun, 22 Nov 2026 22:48:29 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795358909;
	bh=PNrjjeQGGYwFBpiOY39LRC3DQq24ju8DGCOK4z6sWf4=;
	h=Date:From:To:Cc:Subject;
	b=DvAHkUjGAqymK67pME9oazGYu5kG0Vh7IqgOIIXJ3yu2+tl6WR0KmatqLw/g9GsYj
	 VfMMaDkuwqsU5LMIGJbG0ZLPHamJ0TZbDlIsBWHenZeTP+276fyQmHcFg/3+2ykNET
	 vBo8ddO7kHkJJRaZ8n2i+QSn4l2fJKA8vxk3yLzOt4q6XFM9EirJSo/gEMpG4qw+5Y
	 xUWZd/s+pR+d+6A9iCV7gmpWTUtV78+pvQCZPb0dAl3VNx9ctD2QGY7hwxg8tR+WLJ
	 kCz3R2BnsMd7x0F0vBY45aUo6y6bH7TTyaOn0zCD4gvmydMJUM9y0uC9ZpogmSA+uw
	 aAcs4FAoPltvg==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AMEmQaF029170;
	Sun, 22 Nov 2026 22:48:26 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 22:48:29 +0800 (CST)
X-Zmail-TransId: 2afc6b0300bd835-4e3eb
X-Mailer: Zmail v1.0
Message-ID: <20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn>
Date: Sun, 22 Nov 2026 22:48:29 +0800 (CST)
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
To: <kbusch@kernel.org>, <hch@lst.de>
Cc: <axboe@kernel.dk>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvMl0gbnZtZTogWk5TIGFwcGVuZCBsaW1pdCBhbmQgRkRQIGZlYXR1cmUgZGVjb2Rpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AMEmQaF029170
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 22 Nov 2026 22:48:29 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B0300BD.000/4jXX4s4Nd2z5B7RB

Two fixes from the [PATCH 0/5] nvme series posted on November 15 are
resent as a second revision.  The other members of that series are
settled: 3/5 "nvmet: validate the LBA format count of a passthrough
namespace" was applied as e52b8562e2ad, 5/5 "nvme: bound the reservation
report retry loop" as b80093c7d0aa, and 2/5 "nvme: map passthrough data
when the length is nonzero" is withdrawn, because reusing a command
structure for a no-data command regressed from success to EFAULT.

Shao Mingyin (2):
  nvme: zns: reject an out-of-range zone append size limit
  nvme: decode the FDP Get Features result as a dword

 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/zns.c  | 4 ++--
 include/linux/nvme.h     | 6 +-----
 3 files changed, 6 insertions(+), 10 deletions(-)

Changes in v2:
- 1/2: drop the dev_warn() for ZASL values that are valid but do not fit
  in max_zone_append, as Christoph asked.  Such values fall back to
  max_hw_sectors, and the changelog describes the representable range
  instead of calling the value invalid.
- 2/2: drop the structure that became unused, as Christoph asked.  I also
  looked into the Sashiko report on hdr.sze: the buffer is on the stack,
  so blk_rq_map_kern() copies through zero-filled pages and copies the
  full length back, which means there is no uninitialized read and no
  separate patch.

v1: https://lore.kernel.org/all/202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn/

base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
