Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6A47987B
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262351; cv=none; b=IMzTpYht9AL0XzFzp9LQC7aokIL5FayZCvsU42Tgx0aWb/mA/khx8WRBN5fSZa567m2fTu4Os88qloxY8pzywC8nKqfCZETg+t62dE0zJcrZwPf0RfY1ceY1g/bVp4sf2WVcCs/ZkpoH74dNLkmcvg3GydPJBt9yoDzGbuvfC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262351; c=relaxed/simple;
	bh=kNRZN1iExbgAEESoNBlpBPYNvF3zFeAgrQXMHDuvDyc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UCRsAzSU5z/7AUDoXUDYwF32QWZM1t+hq4AdPmYTHL+XYk+WgQxo2eUGdAbx7WKNJPjbNc7I2U+JGMRyL86GFHY7Y8NflMZ+AbYohUnCqsu2XXkGlCf4MfIb8t9Xg2uh7xCFWIsyIUOziifjGW1j5Fc4Z/fYGp6zvqLFAcNj4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev; spf=pass smtp.mailfrom=cressey.dev; dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b=cpjlR78D; arc=none smtp.client-ip=91.218.175.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cressey.dev header.i=@cressey.dev header.b="cpjlR78D"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kNRZN1iExbgAEESoNBlpBPYNvF3zFeAgrQXMHDuvDyc=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787262347; v=1; x=1787867147;
 b=cpjlR78DIUoWInrz6BvknqI5c/6Lx1YB3T1vzqT5PQ0w/iTxQR18Ofcb4YXyBx26cReH6xJx
 F6W1S/3+29Nw+FVyUnyaxW4xUq6RbD+bQOF2khjd4/Nto5nJPdNSN+M6wilpJBLjX4AeQBXLa/5
 obVPgjdRiGqTMG8Y7ZtW+FtSDy1gb8tBaDKZNzkxhbmsWyxeWaRpdfrlg6xnlkkUuYwPOwfxIoE
 b6E5bmQQh/my/QZTDACYgtzGouM/13cq/eatn8Qv6wMKPRFOKYcuNSrwo5I9i3avQmZFzYA21FG
 5zlC5BcdCQYI/3xnQROHcChSosINpIm8+8RQkx8+r168w==
X-Envelope-To: stable@vger.kernel.org
Received: from coder-bcressey-whiskers-0.coder-bcressey-whiskers.remote-dev.svc.cluster.local (35.83.186.167)
	by smtp.migadu.com with ESMTPS id 0b27810bfabba616;
	Thu, 20 Aug 2026 21:45:46 +0000
X-Mizu-Trace-ID: 0b27810bfabba616
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Subject: [PATCH 0/2] dm-integrity: two fixes for the discard path in
 integrity_metadata
Date: Thu, 20 Aug 2026 21:44:56 +0000
Message-Id: <20260820-dm-integrity-discard-v1-0-196d3618d09a@cressey.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFh1h2oC/22NSw6CMBCGr0JmbUNtxFSvYlz0MYXR2JJpRQ3h7
 hbcuvz+5wwZmTDDuZmBcaJMKVbY7xpwg4k9CvKVQUl1lFpJ4R+CYsGeqXyEp+wMe3E6aGm87kK
 nA9TqyBjovc1erj/OT3tDV9atNWFNRmHZRDes0sg0mYKtS6/Ed+R28/99wbJ8AYcA6J21AAAA
X-Change-ID: 20260820-dm-integrity-discard-9480ad85f58f
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, Shukai Ni <shukai.ni@kuleuven.be>, 
 Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Mike Snitzer <snitzer@redhat.com>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, 
 Ben Cressey <ben@cressey.dev>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

Two small fixes for the REQ_OP_DISCARD branch of integrity_metadata().
The first one fixes an out-of-bounds write introduced by the keyed
discard marker patch merged for 7.3: when the tag is smaller than the
digest, the checksum of the last block in each batch is written past the
end of the buffer. The second one fixes a much older endless loop on the
kmalloc-failure fallback with tags larger than 64 bytes.

1/2 is ordered first because 2/2 on its own would move the 1/2
overflow from the kmalloc'ed page onto the stack.

---
Ben Cressey (2):
      dm-integrity: fix buffer overflow with keyed discard
      dm-integrity: fix infinite loop on discard with large tag size

 drivers/md/dm-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 39c5aa3bd8ec3912d2cd0b3fe092642b0d2b0713
change-id: 20260820-dm-integrity-discard-9480ad85f58f

