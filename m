Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202173242BA
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418892; cv=none; b=IznAcwIkknw9siQBuPoAkCSUZZiZcLJoHcFawNr0kQYM9r6zaZBEMF4RfHkFsEgT/ON0m1hWi1acVVqc16XrAzdP81ZznzmBw2XSEcjEXp2XSMreGuqwFbuQMjFzjxZ9c8F/Hm0myaMDqmEKIbsNrEsNdpid03IltasmCf2oduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418892; c=relaxed/simple;
	bh=Z1UMnQkQ7RHnbzSQtXUxBC+spluPC7yPs/hg1k9MK/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6azLO9vbjgG1YNfAS1lHnBcxt5kZ3Z0dLbp4Hcqe9Yk5k43T6JPZTbknEXyNIDloEAmkUxj8TlhXKFlnPM08Tn0Q7JfAFEPWPoprcNC3Z0o5Ib2ZFburp1uN0YYp1rGvH5UDPvSmxKIkfQ7gabP7ICUdGvQleeZbNQOyxYTxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RdWMXj2Y; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RdWMXj2Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786418879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IZ63MsPGPL9yGX0NSI+upDbrCQu3p5KU0q6reB3Ro8w=;
	b=RdWMXj2Yxakg8Mxj+b3v3CIvjVUZ76PWmjIC5fMG4crMK/ePeoRVMTcd3NDFpvUn5sxd3q
	oQ9qYP1UIbRjxlI16WKz0eJnD3SxYC/oOgDVF5fPTeHGouufGbbsVtajBGQyTNy+lwPl6m
	b9m4WscOJdQKr3YwcAOWYvmHMoByEys=
From: Yi Cong <cong.yi@linux.dev>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 0/2] Bluetooth: virtio_bt: harden probe error paths
Date: Tue, 11 Aug 2026 11:27:00 +0800
Message-Id: <20260811032702.67908-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

This small series hardens the two error paths in virtbt_probe() that
currently leak or leave dangling state behind:

  1/2 - if virtio_find_vqs() fails, the allocated 'vbt' and the
        'vdev->priv' pointer that already references it are leaked.
  2/2 - if virtbt_open_vdev() fails after hci_register_dev() has
        succeeded, the hdev is freed without unregistering, leaving a
        dangling entry in the global HCI device list (UAF).

  Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")

Yi Cong (2):
  Bluetooth: virtio_bt: fix leak of vbt on virtio_find_vqs failure
  Bluetooth: virtio_bt: unregister hdev before freeing on open failure

 drivers/bluetooth/virtio_bt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.1

