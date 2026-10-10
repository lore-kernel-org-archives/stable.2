Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F53264F7
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660435; cv=none; b=txDHp5mpRDRj/zyiyQHI8hIAzoLePdQEvdp567UwdFTMdruM+NEw6+GXYbdH4jpytF57XCi5HGJ9PqQBfHSfjNCvwSvDAHrIR9b+ZDeCFsna+oaqQ65b+0kQL1z2UdedmRw1PWqtq+NZW8rKY7wOpBi7LzuHPMwMqKQsedtC/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660435; c=relaxed/simple;
	bh=ec8nIuloHgqueuWiPectNTRxxXUD0xgmT3NqvP+fKfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRqmmIo3AN+0fX+80cR8MJRNJKDI9VUFpVrZWGSTulRz8+GRXm0h61mVzUwNFu2TQhM+M5W9rH3hCokPbBWoKl4QaeEruhoCiVH+fM5O4DFmH0lv0YfJzvcwslQaHnZ3JeFV32OlPqFlae8PHwrbH8eqczhx+xqYkFS2Ll1AoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Y4ySRClv; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Y4ySRClv"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3515f9a5d25so2018617eec.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791660428; x=1792265228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bfk5yrsogadbKnMj1jh+Cdq2RJyiLqyab9B5qMCFxFw=;
        b=Y4ySRClvRZCEAae9QBepinQAifx0yP50BtxtzBLVBvv2I6OIVHtht6exZ6QjU9XwOl
         7q/CxcIep1e9W1wCts40cUlV5Arkba83GQkDF2NUnTlPufmyCvcgt2aR2DxXFelcLwk4
         C2fNAgPhNgjpdTYJYG/Nu2Dvqco0HF6RjQkPns3EP73ehuoVxKsn48BqTXV08RDgFYD4
         UAzuvG8D6BFSrS8NDHx6Y9XQXYdem/KYiyJjaj+Q0Ynros2ob5dRkM+hG5moYDrr/z6w
         W/aFZEH3cQ0uuc++i0MsqczDi9aLO+/PB0qnZrM/MFGhOROa8E8wVsVjij2b+1acIEsE
         dtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791660428; x=1792265228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bfk5yrsogadbKnMj1jh+Cdq2RJyiLqyab9B5qMCFxFw=;
        b=1mD5VWWvpyEXYB2j6WeSfAY154pjm3gLXdpBYXYk4pxw4wlXm5hMYPVZz/KtkQMKHQ
         UH9Lz91VkV7TRx7OcdybfGWV8cApryTWefZ4aKI70qJBmHuA1dSowcfwN9dm2FUcSmiZ
         pPeMr/D3QjXPFz8ExY2Tjc0hyVCJgzfmkLs62EOuQp79yTbSt2g2/sMuK6LvaF7SazyY
         iW2PiZ0ADIqp/yfTj5MZKDdirvoA+LJzCVSArzbkox0nKRt0o5lCemKEJdbIMbkBA/0T
         QRlCOVoMSIOqzp5axKtDG9N1fmt/2i9XxFDh4VBIh1ajxQqXPpV+RyqrBDD98iW1bdMD
         0/wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzomk6YRksd71C96KeGbULtDwu/vZiGlVtJMyHJD64paubNoHN9GgkAtCWmJ1xul2BJJe65Xfk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQWehGHpmOJosyssojhUCGgffgK4e1ua2xvm0lbQA+r/PagOF6
	+DFyZSLtS/FrANXAC+05yu2ZSVYC06kkoDbp7jsJbIIa2MjS2mPGyxEZvx1wACiUjoM=
X-Gm-Gg: AYBFou0OgRVSSTw7ilmxUG9MIZ1nRmKwLOVhj+OSwGXGhjz8cAHoa22SFL+0Y1qY7B6
	/Iw0/qxOmdZdU97VN5NxYJsp78MZ6qb38Os3TX4gMu0UM3zcry2Rzrjr5Tmla65SCxFojIVz3E7
	IW9stka5jCxjkFwMrNeexgz2sdsKmMTqSdRjst3iBYwLCHGSD1sUvMejPJxHMvM4MIhcVwvk+c0
	CfA5exeonDEpfGnx+frqREhJD10HGpC5RR+12QWg6HTJBpnidFnkD9MzTWsR59Z/lUiZ6CbxUoO
	ey6R/EC2A6JIl7sY23QeELnk1oTqFmJyBl2UNL6nR//GRhTzfKLW10FYqVgxmFK8arnInMR6rVh
	QUSMI/c/usoMGyvCnh5zo2qfVLV3LeC69wFZiqSbR7ezR/nB69qL+VWu4ba1/t1JirGJiKGS7Sb
	ydOW0zCskn1xxyomXQUwn5uJNoJSqKDfiVgT/RwE4AazulpjDJiiY1XSIcR4gjps0+1ZRgybr1N
	5CN/npT5hJwFyD78XvpOQ==
X-Received: by 2002:a05:7300:a92:b0:351:4d5d:39b7 with SMTP id 5a478bee46e88-3537e0a4a27mr8108185eec.38.1791660428253;
        Sat, 10 Oct 2026 12:27:08 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:9657:9541:a576:7d2f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm18641806eec.10.2026.10.10.12.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:27:07 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v2 0/2] eth: fbnic: validate the Rx completion path
Date: Sun, 11 Oct 2026 04:26:48 +0900
Message-ID: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is v2 of "eth: fbnic: validate the Rx completion buffer index".
Besides bounding the completion buffer index against rx_buf[], it now
also rejects a buffer-descriptor-queue clean-up head that falls outside
the ring in fbnic_clean_bdq(), and sets add_frag_failed when
fbnic_add_rx_frag() bails on a buffer that was never set up.  Both were
raised in review of v1:
https://lore.kernel.org/netdev/20261009175358.1598001-1-yhlee@isslab.korea.ac.kr/

Patch 2 returns a page-pool reference that is leaked on the
fragment-overflow path of the same function, found while auditing
patch 1.  It carries a different Fixes tag, so it is a separate patch.

v2:
 - patch 1: also reject an out-of-range clean-up head in
   fbnic_clean_bdq(), and set add_frag_failed in fbnic_add_rx_frag()'s
   no-buffer bail.
 - patch 2: new.

Yehyeong Lee (2):
  eth: fbnic: validate the Rx completion buffer index
  eth: fbnic: return the page reference taken for a dropped Rx fragment

 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 40 +++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
2.43.0

