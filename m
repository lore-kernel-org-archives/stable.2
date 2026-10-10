Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698D327C08
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652795; cv=none; b=qGITYW1U5vQ9KqaiMulHdLjR/hyTCKQav7Twhd4xgL+pfC8WK/tVU78teZPq21Os7FrXwtk6E11pXFS3VspK4G4SSaeSbzUMr/DjqGajSmp06Knz+j7U7JbT9gZrJoaCDxtTxzwBGpU8fPJgrXf+JjY4WsrYjDF60rfqJuMLm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652795; c=relaxed/simple;
	bh=18dNR+LGECj8vGXix6nvkFcEmzUURhXJfVh59siSNWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwl+1BZpwpM4BhRmk71aZ+t4a0xQ1ewUzxUz6m4jgbDbMQO+bxgX0iEAgUCT/kBIXrMWMkUFcdxQ1usEKSxtGwjBFAYDp7dstZ3v4ZjY3a2T+dPTIcPqXfcYsosSdr6a7HBn/1fRnolVRKg3Fa3ifRujKCuIUGNwzgCtZEGZOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=vNIpNhU2; arc=none smtp.client-ip=91.218.175.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="vNIpNhU2"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=18dNR+LGECj8vGXix6nvkFcEmzUURhXJfVh59siSNWU=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791652791; v=1; x=1792257591;
 b=vNIpNhU2xRyFsPkti7peqX/BTeRpiPAyE+ne2SfOPZqNYtD+ycUc0h/38THAguD4AT6VQ/Oa
 kAxr5QS5XxAg1hxMuJX2lysZ/iCOmUmZZ+8yyecazM6FcPoJJRArSGYaO2ody1pgpJD2fxprjB1
 X8WEZCbjGgRecVaoM99vt8UQnO6NbzawZpyUeQ4zp/VFce2g2iuUGuR/YDyMLxzIUbx7XKEN4/8
 jXSBkYV3gsP43dvwJE6rLjqcNcDHqpU5j9mFdr11B658Tzl3x5foyTwEeH5A7zEvhZw/voCAYLf
 dG1M1CtvkoeT65xPLWDYc0f8QCS4ao+/I9omnev6NJErw==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3d10b0d0e088b810;
	Sat, 10 Oct 2026 17:19:50 +0000
X-Mizu-Trace-ID: 3d10b0d0e088b810
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Breno Leitao <leitao@debian.org>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: mt76: fix NULL dereference reading napi_threaded in debugfs
Date: Sat, 10 Oct 2026 10:19:47 -0700
Message-ID: <20261010171947.12837-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The napi_threaded debugfs file is created for every device, but only
devices that set up NAPI allocate the netdev behind it. SDIO devices
never do, and neither did USB devices before their receive path moved
to NAPI. Reading the file on one of them oopses:

  BUG: kernel NULL pointer dereference, address: 0000000000000343
  RIP: 0010:mt76_napi_threaded_get+0x10/0x30 [mt76]
  Call Trace:
   simple_attr_read
   debugfs_attr_read
   vfs_read

Refuse the read when there is no NAPI device, as the write side already
does for these devices.

Fixes: 08f116c9ea6d ("wifi: mt76: un-embedd netdev from mt76_dev")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
I read the file as root after fresh boots. Patched builds used each
kernel's own source.

  USB, 6.12 to 7.2, stock      13 kernels   oops, 38 of 38 boots
  USB, 6.12 to 7.2, patched     9 kernels   refused, 270 of 270 reads
  USB, 6.8, stock               1 kernel    reads 0, 30 of 30
  USB, 7.3-rc, stock+patched    1 kernel    reads 1, 60 of 60
  PCIe, stock+patched           2 machines  reads 1, 93 of 93

  distros    Debian, Kali, Alpine, Ubuntu, Fedora, Arch, CachyOS,
             Raspberry Pi OS
  machines   x86 and arm64, bare metal and VMs
  adapters   MT7921AU and MT7925U on USB, MT7922 and MT7927 on PCIe
  compilers  gcc and clang

 drivers/net/wireless/mediatek/mt76/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index a5ac6ca86735..d04199b50a29 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -44,6 +44,9 @@ mt76_napi_threaded_get(void *data, u64 *val)
 {
 	struct mt76_dev *dev = data;
 
+	if (!dev->napi_dev)
+		return -EOPNOTSUPP;
+
 	*val = dev->napi_dev->threaded;
 	return 0;
 }
-- 
2.56.0

