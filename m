Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956179;
	b=4frrPldKrhdhf8jmLckvXXpSmmKTBUh3Dj/1c8TdDBmU+vUoHsLPPD35eq2myDRnfJFs
	 Xp4y5BsSMG1KV38Vnu93eZ94Ercm5JEyyPsO4ONQKz4wtLjU1160RtwsSFcV+kkIuL/Xg
	 BTbu4l9ITkP+ZhGGJT8mxiD2ukr8xXGXqzVqnBRG9sbJQSHJbo+5YXIOKeaCrcVZKPAC0
	 x4/hXlaql8WkDXDR23KVlXdDfibOqpt1RadSgcuLCofVi/k344vyq1Muf+DVKtFW7vUiI
	 nZhvq5txOsWOTnuuP0sAETUcFWZImrHRdX0b4HBdD1jAHR1CENmyPVUrZ0yBiwltQsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956179;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Received:DKIM-Signature;
	bh=IoWcfpKKd2a3SOxxIECXvR8BBWpdj9i8qCmd2x6xdaw=;
	b=i8Bhg9Nm/4pq3P8F/zTp/7Gu6/zVedbXtPmYXo9KrbANR00BKhtKu8chG8ab99dJO1g6
	 zu/OFtFz1FW89l5+oZ5eBocpObjKXudz1AradY1b3b5fKw7rulxU2WHjS4nAFEt7moZ3Z
	 42kUT+G8kwKk5Oeoz1lA4OxHsKWilxDRWDOUgiOhyxcCqWH4GoGqaHkyQR3XJI1eb22Ww
	 CE1k6nmg7uyUVBILcRN0/7bLHLaaOR3Xi1Lxi38dTR+dFLOnIDrS85gpZLovxUk5jCec1
	 RviPo+yuLwAwbaC8vvVKHfBbsJ0KUUVvXmNPKqXenQTXL+puI2nOX2H6rrWa0Jy4iKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=hkJ9umYs;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B372606A31C;
	Tue, 17 Nov 2026 22:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B372606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=hkJ9umYs
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: netdev-bot+sashiko@kernel.org
Cc: Federico Musto <federico@rimpianto.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: atl1c: free the RX buffer when the descriptor reports an error
Date: Tue, 17 Nov 2026 23:55:11 +0100
Message-ID: <20261117225511.19650-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179410255769.994134.16589271793081668306@kernel.org>
References: <20261103225218.19206-1-federico@rimpianto.com> <179410255769.994134.16589271793081668306@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 72409802-4A8B-4BA6-8392-E6D007D5C986.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 17 Nov 2026 23:55:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=s20260314391; t=1794956111;
 bh=IoWcfpKKd2a3SOxxIECXvR8BBWpdj9i8qCmd2x6xdaw=;
 b=hkJ9umYsY89JZ22TWAjcPQAY6KUnSS3SjCNUOXYtiHrLxPnpCfxr9SLmVp1UREAwe5QK8x7qu
 V7/aoAWiF5F8so7q38W+wEjUgvhtzb99c5mZsgBmGMnUYMq4+rGQiwIzudS4KTgdvyGqHlUJQJz
 k6BbZuCR7KUZnmHhGcGz9wLCyvdpfpwg97ho9lR29b/O3dSq45NSw5RgZwXRtzV/PCZgSXTUCcJ
 Q5UpuWM+vrFKpy9DT4flk+Ps/MP3MjEA19x8TF52zh+GItHuf/vXIN0lLKJ+9h0cuVv0MsYH2Wo
 9Aqh5heURseluiGKAwcJaE7eg+Xn1lYA5Qw4QfZUJJ3Q==

Thank you for the detailed review. The findings are addressed in a
two-patch v4 series.

The new finding on the device-written RFD count and index is valid. Patch
2/2 now requires rfd_num == 1, rfd_index == rfd_ring->next_to_clean and a
non-NULL skb in the expected slot before unmapping or freeing anything.
On a mismatch it leaves all buffers alone and schedules a reset, following
alx_clean_rx_irq(). Both the good and error paths then use the software
index. The multi-RFD free loop from v3 is removed.

The same validation also rejects rfd_num == 0, so an errored descriptor
with a zero count can no longer be re-read indefinitely.

The pre-existing link-down reset race is addressed by the new patch 1/2.
After netif_carrier_off(), it waits for RX polls already in flight before
resetting the rings. Polls entered later see the carrier off and return
without touching them. napi_disable() is not used because the work item is
not serialized against atl1c_down(); a second disable can deadlock against
the first caller's napi_enable() while holding the netdev instance lock.

The missing dma_rmb() between the valid-bit check and word0, and the
pre-existing raw word3 endian accesses, remain outside this series. They
are independent issues and are left to a separate change rather than
expanding the leak fix further.

Validation on netdev/net:
- git apply --check and git diff --check pass;
- checkpatch --strict reports no errors, warnings or checks;
- baseline and patched W=1 + Sparse builds succeed with no new warnings.

The candidate was also tested with diagnostic instrumentation on a
MikroTik CCR2004-1G-2XS-PCIe, which exposes emulated AR8151 functions.
More than 1.5 million RRDs passed the count and index validation in one
traffic run without a mismatch. The candidate survived more than 15
MTU-change resets without a poll-wait timeout, deadlock, Oops or warning.
The errored-descriptor path itself was not exercised, and this is not a
test on a physical AR8151 controller.

pw-bot: cr
