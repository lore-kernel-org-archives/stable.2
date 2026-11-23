Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476697;
	b=PoPJ3vE3rRMeKDLhwdj+zCunABXUxvAHNq9VTuRk0m6/vGpJWAY/5YkMx2daz3F62civ
	 50+OdAB1NizeFZN+qWucdP5e3AWQL6ThrRhu4VJQcXx8jyfKX4KK7/l8o/FQMB0uTTfaO
	 /udPdNSBBKZzGmCnLyv34Av83uaNKe9aSjaXaHQW9ld9bCrCbPk/WQN7XsetsPi0hqU0/
	 YohFHValFF4uupcxFMwCGSsLOdZjcYgqX98ILYgPY420GxtsQKSPEs+8VG7xr6YZjuaWN
	 AWH08ahS4HjyQsQN+i9xz1zmlxmCQ3FPw7cBPtDl7x1HOKwHIYayC1esze9Mn2L5K1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476697;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fQfsc4rVCAOvoysXvULvyWwSbKyZo7lhdAuc6dF+pqI=;
	b=bzAUy/Z0lKJbYm7D9rOcymLf2J5Uo69V7x0SYSMA8KbRq6XwEB+1oCaeadUMZZIiBymj
	 lfWzNlNJg5tN/OXCQ09vjMMaPWiIv/kV1Um31eWqrLQvwptPqTv8yoGS9hGPgfWvzj7Pq
	 cYd9+t/cQcVcLVOK3EDem7krgQiGesmFytDgpx7Q+4T+sE8irXv16bb50jV5/r61LEEEz
	 uH6js4Z4QBmIjgiaD960uRTXYnj5SEZ5OzK8rhBE3DT6v4IJVL1w6gcsbu+i1YPdv4PjS
	 JmoS0d6Gw0Zsoy4E743Jrwh95Ym+qTDX+mJ8zwdX2ZXGuYK2FzlaJyrMqn7ZpLutq4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="LilXw/b2";
	arc=none smtp.remote-ip=203.205.221.245
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30095606A321;
	Mon, 23 Nov 2026 23:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30095606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LilXw/b2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795476687; bh=fQfsc4rVCAOvoysXvULvyWwSbKyZo7lhdAuc6dF+pqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LilXw/b2cu+Y6BHk9N2DxVm9YLxM+V0kcb7xKtKlDP0X/PZF68MfB82QxuUuoaRw+
	 tcEepW2HU5EI/uwJOeTKBp0nuAXit2yZN6tfemNUW9bOQ4LbB2UsCyPxenrZlFMH/f
	 jybM6oyRPxgExIUr2UAacukML+iLInB5pK5rqQWY=
Received: from lxu-pcd ([111.198.225.163])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 7D5A6A85; Tue, 24 Nov 2026 07:31:21 +0800
X-QQ-mid: xmsmtpt1795476681t801nvuw2
Message-ID: <tencent_FD9527C5C6F712D4C674C98B6EDB2EC5CC06@qq.com>
X-QQ-XMAILINFO: MfEY9GD3w9KSRUrRcH0c3PLqeDMD5na/w9K8VkUf93MNT0Xav4CCq2Gr26PLI6
	 /4zZbJJX8IdiAvtHDvYw/0FnOE1maV+S4fdmCy6Swm/zwvoCJyyhaWDNCpREd+pMRrU1MR/sB7JG
	 IOOh4xJTY7tEtgrCxy+IcgQ8a7igodqGVtlj2GMZlvgHn2P7rTDrFdqMJ/xhFzXVkw5PIJmtnW9/
	 FMi4OGnI+uk1xnBGJPmx8K11FWwyDAWyqJaJPPufMyaZQh+AEIOYFGBotLmPdc35gxKwAbthD3HR
	 NMj9H9pmb89RoJC62Q1hhsAfs8IhIei64KxX444nTcCkePJLZ2Y7bZXYbVQdq4/EiTniF0NVjrWS
	 wYHprnKSEdD99qwcMX4mQBpNTh56SKHXEgN4YXcaJcoMJa2DqX3iQcv+pqpRCFHex6TUdME+sm3m
	 Ot0zXtU7X/G/B0aoQarrlAMe9mQVLP0GCzg33KivlNBu6+dO6MgO4pXkSQeBUXjffHHCeKWn8iII
	 Sg/EN762nUh0iw9jFQ1dGzfqvuC3KrfUhSbU0vMg5dJM7v9BJcbLnO02JINxptUndbcyNHWf0Lx3
	 vckS6uMLfJq9kXA246bh6D5M1ZtMZNsR3ZoOf27V3zs1vH4iiSRaywGtewF539dhV1+f9mPHczh8
	 komHHC59PSun8252BYNjGx+EXIfK3iGcy0xMJMi2JxsNEGGmuoYPZvDu0zegGmxbyNOtFcsdMUvo
	 NPQjK7bm2Jbv9Lezd/m8smCm9npdDwk4C4cfEGSEn/FbWR1GUHN7omulxVhVnz9hUbVzSinGvBzw
	 EwemBTmTt6wrdyQT7qFkGcFyyjjBlzMDjqdNn1Zfc/OLdHUnNRtVBSaJUESr5IKOqwFWCl7kdw1x
	 GDk7dhXLGa8q3hAobaQy+QgpKpE28P7DstWWCaXjmqq6EOJUB4MC5h6XYmbnIey3X+AeMgV8dbZQ
	 QWFwmzXsUfEkPGaLx1P6MRxrDEF4wlAw2VnNB/UbwjuAn7NFLlKJ0JegzTV6qzcCFBXOEfHMFF4w
	 koWx+3gx34UKjqm7GWGlAj7J+1O3PjKS+MhfUEzQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Edward Adam Davis <eadavis@qq.com>
To: brauner@kernel.org
Cc: axboe@kernel.dk,
	bigeasy@linutronix.de,
	bvanassche@acm.org,
	clrkwllms@kernel.org,
	cui.tao@linux.dev,
	eadavis@qq.com,
	hch@lst.de,
	hdanton@sina.com,
	jfs-discussion@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	penguin-kernel@I-love.SAKURA.ne.jp,
	rostedt@goodmis.org,
	shaggy@kernel.org,
	stable@vger.kernel.org,
	syzbot+2e5cf2352e9f69ebf172@syzkaller.appspotmail.com,
	syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com,
	syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
	syzbot+ecf51a7ccb6b1394e90c@syzkaller.appspotmail.com,
	tom.leiming@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/2] jfs: fix lbmDONE races in lbmIODone() (was "loop bug saga")
Date: Tue, 24 Nov 2026 07:31:22 +0800
X-OQ-MSGID: <20261123233121.161079-2-eadavis@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org>
References: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org>
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

On Mon, 23 Nov 2026 14:02:17 +0100, Christian Brauner wrote:
>      jfs: wait for lbmDONE under LCACHE_LOCK in lbmRead()
>      jfs: set lbmDONE before dropping LCACHE_LOCK for lmPostGC()
>
> fs/jfs/jfs_logmgr.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
Same issue ?
https://lore.kernel.org/all/tencent_3AEEC18CAA27D286CE92DAC674C9B02EEC06@qq.com

BR,
Edward

