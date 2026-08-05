Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968246A618
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934667; cv=none; b=IkkHDkci3PMY2OVPU023/mgIHNhZg5VD5DtOjy11DYzp/nnl7JKPulXQGkSdNd37Cu2q5ptnH6FTuNccW4SZMZx9sqVER+NXSTyAC/zXEptJ+bmkJ2eSH2bpX2mJZtTI4YDS2NxHoDbqsRPthFNNeIOEp92HCUomPL7bWtUjVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934667; c=relaxed/simple;
	bh=C0712y9v+3Cnwu+fzKHEe+5eb6C88dqmH0oQugUbpT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaVnH9sZHapJLITZVOwIWLpGNHk6Bm/y37BfsSeLmUtk1wEck7zevDA13LycSoJuU65I+xJiFe41BNAwRw9ejcscraqlJADeU1UtR6hdwOxFYy+0KUmpw1CW/Ar8V5wrCTKOWNO8HHABwgjnYGdhH7YeXgISp14rNhP0aGfqXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHNxoAi3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHNxoAi3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cad68425a7so1246925ad.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934665; x=1786539465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=88i/kpHkeSfRDq0C8BDJPfVUyr9cy+9c455SwktNUuY=;
        b=MHNxoAi3DFsaRGPHiPwJE2znH4cJ8jjVkHG9CyqdgiC1bHzRUk73syVhlaztM712wx
         hT0NOXtCaCq+sFSwIa7RH0Ia6PawqD4jIq7i0m6DhdXoWBkB9RgJKUOlfAvGRJ4XSshY
         Zz7zsqkWlXYgXj0fXqrdX+5Und8khp9WWPcJY7kCz11ftUQHWTXDpmBAmfv3QmsbOQiw
         gf6OQriBN0sFWI7WTLH3h+Azda5TpsjPQ13cbdCtP6enYvkhc/pZglOKlO1XpR3SJjHP
         vf1BV0HZucE7n6urXDUTpchjcbPPNAHGDhG6TiQplK0SBMEea2ZwKkZoYoHmo3w/M8s5
         hOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934665; x=1786539465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88i/kpHkeSfRDq0C8BDJPfVUyr9cy+9c455SwktNUuY=;
        b=qSm4mXggLQKDYvVF/BK5uCFNRpTgOqo8TcYyUqIPw9db2PmdSqT5boVTL8eSvwewdR
         a0j6a52bO4ra3h2bdQ4dUvAs4UlpBG4YekGAdwu3jVy7aMTgaefwZUgRSSvLsWKVEF5p
         8v/3m0VgXCrf3UjtD4Va66hfF3qNp4o0NVMiCswpDap6CeJWj1LRu7+nvv/bs6g8QZsh
         rx5TfQriU1trtFXY/7BaWzRruhJd1JQjZ10A1dzjLP+j3F1SNOY0Ir00HR6QhMjkE18i
         tKXr+q65GYIl24DEJHPYmATMvp9SoxIQU7+YEa+U5HN2VwEqbgK4+6oijODwIRtS8YWV
         IW4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqI2FEEtdJkqAy/BBWKcN4qrfP3WfD7RwcjlsJqXkln5vx65/r+BSmU45TFFcAi8axbsqTbL6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2VYKMIGysbYmWr7JLzKBYHWNiSyudSBrSkOFXvsY/+QM91wm
	9C0kEJ5PgPBroN5rvPcad1FgbnY5l4OK6quNY/a9ZP6b75bRu8r7iXer
X-Gm-Gg: AR+sD13RvdUE9HOxlm1wJTXWQBvqrxvW3r7uufwAq4nJovAxgG93iFJwiUMbAtkniR5
	JWOvY4aSs5Y86LjydbFRiIGL6ZG2s4HckIt3b4cVDNcT5XWeAZi7vVISCaJROcTbO1v5omOkQga
	qFirh5BrSdA7Cmmwo40lnfZNVjRDZTFSJJUJrWXWY46hVFJj7IVRRw1tkHvbk5xvHjjg/zU+3HJ
	DLO5Q/5D2mkZ1NldGBeZvRi1h0XTvptKl7BT4c50VB0jcxLrRJhHlvlopSLxGtLnL5VkWGeiNPj
	VoiRo17flsc+9zzQA9pqTB8LBjspCgo5Bzs1ONH3zmrya76kvEbxnrYNOZkUjOt5prG7F5FlFnl
	JFFQm6ALVbU5mPM20KK1Huo50RmKlg3WZIYQdoYC4WL3gyZJ0H0Q8SViZOixIFGysbpMnfopD60
	5+Fk5tXY6LBSpNtuEi3Bzr5MTm4SNi8/syoiMD9t7fK9A0srP0/E1tlU5REYW6VyuC9yqlI6z3T
	3QQY8WbcbKE9YLutSxNnsd59Yn7P+v7aHeJ0ZtAokllgOJoOLA=
X-Received: by 2002:a17:903:2f8f:b0:2ca:d803:5c8f with SMTP id d9443c01a7336-2d0ca73a210mr51760455ad.1.1785934665055;
        Wed, 05 Aug 2026 05:57:45 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f8fb4bsm16514625ad.5.2026.08.05.05.57.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 05:57:44 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v6 0/3] net: fix hard_header_len races in packet send paths
Date: Wed,  5 Aug 2026 20:57:26 +0800
Message-ID: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

The packet socket TX paths read dev->hard_header_len independently for
skb allocation and header construction. Concurrent netdevice
reconfiguration (e.g. bonding device type changes) can change this value
in between, leading to mismatched headroom and copy length, and in the
SOCK_RAW case to out-of-bounds writes.

Patch 1 removes the CAP_SYS_RAWIO zero-padding branch in
dev_validate_header(). That branch sizes a memset against the live
dev->hard_header_len while operating on an skb whose headroom was
allocated from an earlier hard_header_len read, so a concurrent increase
can write past the reserved buffer. Removing it first keeps the later
snapshot fixes bisect-safe: they do not replace an earlier skb_under_panic
with a silent overwrite.

Patches 2 and 3 snapshot hard_header_len once per send and use it
consistently for allocation and construction, in the non-ring and TX_RING
paths respectively. The separate SOCK_DGRAM consistency problem between
hard_header_len and header_ops->create remains out of scope, as noted in
the commit messages.

v5 -> v6:
- Fix Signed-off-by to use full name (DCO).
- Add patch 1: remove CAP_SYS_RAWIO zero-padding in dev_validate_header,
  before the snapshot fixes for per-commit safety. Suggested by Willem de
  Bruijn.
- Add Reviewed-by from Willem de Bruijn to the TX_RING patch (given on v5).

v5: https://lore.kernel.org/netdev/20260730082925.93759-1-q.h.hack.winter@gmail.com/

Qihang Tang (3):
  net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h | 11 ++++------
 net/packet/af_packet.c    | 45 +++++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.50.1 (Apple Git-155)
