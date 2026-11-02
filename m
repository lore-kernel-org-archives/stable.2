Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620241;
	b=il2TMlAmE6ZvwnAnWvv/3QHUHbA5Kv+r2NG8ACmPa/tTvbtZ3sLjcs0NwAcmE49y+Rkm
	 KbYc0coDMZPnelgdcxVBWQiXkrgYuBecJuhzmWa0YmODE85DuOGHiWTwB4f9Ws6MAZdrK
	 mu5DerBexMTvCOxv9xkDYMhaTK2qBstD69by0hGaFFiN2ITUDApoA0UsjPYbjQKA8Heyr
	 jlTbZIGFYe5PhsCcup//p2agm5wn1PAk00WaO83tVrzqTXPKc0O6OicXNf6TTSZKPLwrv
	 CjphmMJM009TJ/NaabwizYmO/cCrp9yGPEY9YAZeQpHQxiAyUy2kUauZ5xYWS1OR5OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620241;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=IO3YFHnhAuew1qKAqNJkEYxad9XP8pflUZUw4Tx+Jd4=;
	b=yItGpSsnJao/QDgKwDDTQjiGA9kF64sycE6o8rKow24vPoBnYxLA8iCSvmnYZtRMtLYl
	 kEwtctcGps2rA1qOc3KHX09b7I/i7Yy774TiGp4iyTj+fCVoyNoVp3AUcN9Sy65DlQrxG
	 yPndmO0h4CHRrSgnv/dtqFUQ6EKLnYK5wo8PkXM8mIVt1XxyL9LD5XF8giGxEjOOvaq42
	 muYdjz2mEpOaOo+Cdu00cWFUxNlTJxgN4aTPFcd4A4jJJmPeEtiBLNyMTbtw40wZmBh20
	 rebNPSxJl+toVMwyRJJ/IWzd4yeFTH7TxuwSxO/ipY7rd21pouCwmrN7G4awhRF7L5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B4606A326;
	Mon,  2 Nov 2026 11:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jJ94m28Tgz59tjr;
	Mon, 02 Nov 2026 19:50:32 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A2BoRSc068839;
	Mon, 2 Nov 2026 19:50:27 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 19:50:30 +0800 (CST)
X-Zmail-TransId: 2af96ae87906b1d-7b9b2
X-Mailer: Zmail v1.0
Message-ID: <20261102195030814Aeehrb4WmExc085745ldN@zte.com.cn>
Date: Mon, 2 Nov 2026 19:50:30 +0800 (CST)
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
To: <richard@nod.at>
Cc: <linux-mtd@lists.infradead.org>, <chengzhihao1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvM10gdWJpZnM6IGZpeCBhbiBhdXRoIG5vZGUgbGVhayBhbmQgdHdvIGVycm9yLWhhbmRsaW5nIGJ1Z3M=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A2BoRSc068839
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 02 Nov 2026 19:50:32 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE87908.000/4jJ94m28Tgz59tjr

This series fixes three independent problems in ubifs, all found while
auditing the error paths around the GC write-buffer, xattr creation and
authenticated node hashing.

Patch 1 fixes a leak.  move_nodes() allocates the authentication node for
the GC journal head and writes it into the GC write-buffer; the buffer is
freed only when one of the steps fails.  On an authenticated file system
every GC pass that moves nodes therefore leaks ubifs_auth_node_sz()
bytes, so the loss is unbounded on a long-running system.

Patch 2 fixes state that survives a failed operation.  create_xattr()
sets UBIFS_CRYPT_FL for inodes that carry an encryption context, but its
error path clears the flag whether this call set it or not.  A setxattr()
that fails before anything reaches the journal, for example because its
journal buffer cannot be allocated, therefore leaves the in-memory inode
marked as unencrypted; the next inode write persists that, and after the
next mount the inode is no longer treated as encrypted although its names
and data still are.

Patch 3 stops five call sites from ignoring ubifs_node_calc_hash().  With
authentication enabled a failing crypto operation leaves those callers
using an uninitialised stack buffer as the node hash; it is then stored in
the TNC or in the master node, and the affected nodes fail verification
later.

The three patches are independent and can be applied in any order or as a
subset.  They are listed by severity, not by dependency: the leak first,
then the persistent state loss, then the error propagation.

All three carry Fixes: and Cc: stable.

Testing: the patches apply to next-20261030, pass checkpatch.pl --strict
with 0 errors/0 warnings/0 checks, and fs/ubifs/ builds with
CONFIG_UBIFS_FS_AUTHENTICATION, CONFIG_UBIFS_FS_XATTR and
CONFIG_UBIFS_FS_SECURITY enabled and W=1 without new warnings.  They were
not exercised at runtime: this machine has no UBI/MTD tooling or
emulation, so there is no mount test.  Patch 1 is the easiest to verify by
inspection; patch 2 needs an allocation or I/O failure in
ubifs_jnl_update(); patch 3 needs a crypto failure inside
ubifs_node_calc_hash().

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
