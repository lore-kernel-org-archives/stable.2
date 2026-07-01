Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91D40B39F
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901117; cv=none; b=Cq2ANde7rbpw8n8za+pOAN+VmTRVXBuHpiu68/3+JEiHTrubNX2Jp1/jTFktBJE6uNGL/BT/7c/nEuhMTH2MHI4FLcMOVGeekj0eYboI6sPIei9rE1P6qtsgICfeBSR6m09lrToSUd0iMRqovCNBHrB0PdRoiHW5vzQiYAF8uIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901117; c=relaxed/simple;
	bh=kvLyuRe9D7WbnGLttVyglhdwKtXJoydg9KcgCYYzFls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWqK3i3uk8EsHFf6ctSZxOFoI9aSOqp9eG+FLXxqoooma2k5nd4UnK1XKfieb+G51ncMqzyyJ53rErcFqYYMSNmIPUm2vUa3qiGi9ckUz1I/SQJjPtTZCTCCCBUiA+c0XpwOL2VOYcEgnqmjAVfKAhuFHRPYDv3e5HyRkXS3UE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3tFyGAg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3tFyGAg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782901115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AIb0aVoAuZLgnmmFOQkbVKf1JhNZALcK4GmvrwRR/Ew=;
	b=J3tFyGAgm0NtBnvmFEkvZcvEd0gxHCBq+pQtjOyjNUpv9ZA+J/zX1UdB1gR8K0lZ4sXpEt
	BJyr3XlTS3/dQsjSMTblyZT0loO+yXzdv0FvFTaexcz4t6Yg2CA9r3Q9cvAcMkfEcBUP5S
	U9cj5cChHy/IU+VOwI7N/6NXfLJRTJU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-1zAQ_GYINI6Y8xiFz9n3ng-1; Wed,
 01 Jul 2026 06:18:32 -0400
X-MC-Unique: 1zAQ_GYINI6Y8xiFz9n3ng-1
X-Mimecast-MFC-AGG-ID: 1zAQ_GYINI6Y8xiFz9n3ng_1782901111
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD639184B0A9;
	Wed,  1 Jul 2026 10:18:30 +0000 (UTC)
Received: from nixos.redhat.com (unknown [10.44.49.208])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E152A36936;
	Wed,  1 Jul 2026 10:18:27 +0000 (UTC)
From: Sascha Grunert <sgrunert@redhat.com>
To: linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sascha Grunert <sgrunert@redhat.com>
Subject: [PATCH 0/2] usbip: fix device disconnect loop with isoc endpoints
Date: Wed,  1 Jul 2026 12:18:24 +0200
Message-ID: <20260701101826.894848-1-sgrunert@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Forwarding a USB device with isochronous endpoints over USB/IP causes a
disconnect/reconnect loop. Hit this with a Turtle Beach Velocity One
Flight yoke (10f5:7001) forwarded to a VM.

The first patch fixes a TCP stream desync: when get_pipe() returns -1,
the remaining PDU payload stays on the socket and corrupts the next
header parse. The second patch prevents activation of alt settings with
isoc endpoints, since USB/IP cannot forward them and the failed
transfers cascade into a device disconnect.

Sascha Grunert (2):
  usbip: drain remaining PDU payload on rejected endpoint
  usbip: block SET_INTERFACE for isoc alt settings

 drivers/usb/usbip/stub_rx.c | 96 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

-- 
2.52.0

