Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352113;
	b=NODhgitvyGd93U8gexdZ5K9xFxW7hZVHjliCQRZ0XTtQJhZqKcRzH6X2SbGXbOag01/s
	 YDgcxLdcQrSCd7x+ftPlTn6Pgn2ADLg0S+9t8VbQnSWNTJ7b6AknCv7K5sV5fVeXZ6fT1
	 KsuK4xsBHh5+QPQlRU5/i8+oKpWoD51uLQMkz/8xwYwkM3sWLl641Gmc+6S13d22OtA4N
	 YPALvMiNOoJ1C/k4FEBaQ68VyRhSaIpX5bBK4jJ4BRAOD9FtUoofH/leOQmeR/atGKiU0
	 wnZUVbaO1Z/rlEZFkMTZzayyA12JsBtIpWQVNA3/AYy1+YbvUUBvAFBKlrL3lT7TNBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352113;
	h=DMARC-Filter:DKIM-Signature:Cc:Mime-Version:X-Original-From:Received:
	 X-Lms-Return-Path:Subject:To:From:Date:Content-Transfer-Encoding:
	 Message-Id:X-Mailer:Content-Type;
	bh=Rl7hUBDgjTnfIzu7sgeiF6Xol7EVQjp53Fwucyf1OiU=;
	b=1jkmgZbuUoOSRIcYHbwBgBC592l/WsVv6U+kNgIY2OeGTLsKwGspHCGXAhrAzIW5rYWB
	 EGA7dH65U1OTLbj+ELuCcJ+0zoESWjjbpTKruv7JUTqr+bHcvHvczuJn6yyesuFnT1m1A
	 Hh3afUFNkPs+FMDkZ4GvL8DlXlCveAoqJzuHHbJU9oKCsv0y+pe4aHQIrZU93bgahjVVF
	 iVWQeGWeqWpHIRFmcbdafnbwb4iFfNZFhmHtM45tSOv8CCU4sE6Pv2MIyo3bXeZlvpKMV
	 mNplZ+aw7hOI2RSrGE8GXT9EUCQJt3B6wOqVfhmo+sHj6rxei+d3IrWRtWLH6mL1MsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fnnas.com;
	spf=pass smtp.mailfrom=fnnas.com;
	dkim=pass header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=lGNkKn2J;
	arc=none smtp.remote-ip=209.127.231.54
Received: from va-2-54.ptr.blmpb.com (va-2-54.ptr.blmpb.com [209.127.231.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA62606A327
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA62606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=lGNkKn2J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1793352102;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Rl7hUBDgjTnfIzu7sgeiF6Xol7EVQjp53Fwucyf1OiU=;
 b=lGNkKn2Jcnm+rXW1N09WfZMiHsjLY2HMRR9TKyNzIA/wKaBj73aRvw4oi6E2WgNRvMQE2i
 aIKPm6smnHPkVVHsdH1pTgVIXNMkdrXa6r7aLbCdbYeLrJUoZmdStwZZsAl/BHCxW6Vj3X
 6iWdFtq8dyNixVMg/rc3hDUTPK7e7J47gk/NjDKZtlAqSNlrMc3BJLnKRQkMwQuWG7GMPm
 OaJ675xPeciLNRedZRuFz5dpIlz7/e082HmvTcwWxPta6GLTJBdBK9PJ4sZ4/PPRkISH12
 VaIF9T9dPi2Gm3YkepOaNILEood2pLIIpNJEQTwpJQdQ3rvS7sdLyjrPzTkWdQ==
Cc: <stable@vger.kernel.org>, <yukuai@fygo.io>, <chencheng@fnnas.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: chencheng@fnnas.com
Received: from fedora ([183.34.162.132]) by smtp.feishu.cn with ESMTPS; Fri, 30 Oct 2026 17:21:36 +0800
X-Lms-Return-Path: <lba+26ae461a1+f67f4c+vger.kernel.org+chencheng@fnnas.com>
Subject: [PATCH 0/2] dm snapshot: fix discards spilling into the next COW chunk
To: <dm-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>, 
	<bmarzins@redhat.com>
From: "Chen Cheng" <chencheng@fnnas.com>
Date: Fri, 30 Oct 2026 17:21:27 +0800
Content-Transfer-Encoding: 7bit
Message-Id: <20261030092129.1671254-1-chencheng@fnnas.com>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset=UTF-8

From: Chen Cheng <chencheng@fnnas.com>

Hi,

dm only splits discards at a chunk boundary for targets that ask for
it with ti->max_discard_granularity, and dm-snapshot never did.

So a discard can arrive starting in the middle of a chunk, or covering
several chunks at once.

zero_exception() zeroes the COW chunk using bio->bi_iter.bi_sector, which
remap_exception() has already turned into "COW chunk start + offset
inside the chunk".  The zeroing window is shifted by that offset, so the
head of the chunk we were asked to discard keeps its old data, and the
tail spills into the next COW chunk, which belongs to a different
exception.

Patch 1 sets ti->max_discard_granularity, so dm hands dm-snapshot
discards that are split on chunk boundaries.

Patch 2 makes io_overlaps_chunk() also require the discard to start on
a chunk boundary, and completes the discards that don't cover a whole
chunk with bio_endio() instead of sending them to the COW device.

Thanks,
Chen Cheng

Chen Cheng (2):
  dm snapshot: split discards on chunk boundaries
  dm snapshot: fix discard writing into the next COW chunk

 drivers/md/dm-snap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.56.0
