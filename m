Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B41A6807
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783862569; cv=none; b=C2Sl0VlL2pT3NvnAdZCmzeGBKKy3MU1AW9BYWBg4TuxYeeonuSChVJGxlNUEXNJ0ztWuRG47CiJHRAL/1AkBKiVqiFIX+ZGX1MaC+O+s8ypXZ19TPMRCy+ZXpKsWaUjbhR7QPZI15ijNAt0P2zuV3FaA2TfwvGpV2LzLzeTgvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783862569; c=relaxed/simple;
	bh=xAwWrn135mVWGuRJMRuBayOCkroezRocDlu6CZpN8Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipNsiswRD1xbTrzq8GxjDS/fKloSNEimSYzN1kDKn/PxfTZbSwXLTqNvnQXoJXWRnb1ED8xnqqcTemdLf1k192561dKP6GZXholJoIWVm3mK3QucbT6scaX51oLXshn1NuiHOSCKUWbxuvxJs4bXo7ZetEPofX25kUYExDpwWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwGd66Lo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwGd66Lo"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so8584345e9.3
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783862566; x=1784467366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+YFzVviG3DzxMqpa6xeKwhT6SuFAN+/OdOMSnwiZgU=;
        b=lwGd66LoMamqnIsdxcCBSbsxNB6gIYf3m3vmJmXe/TYUwBmVoTkA1QZ6iD/LTm6BS9
         9gM/tmdCkjAHHHlskU3IKfeMCIrvuQ9m1oeqWN25I4G+6oPUw3Y1BUOPgD0EUX790wbK
         eqAxQVrjbNaUIopyCcrBK2vi46BeBuSaBLCEJpkBSbMXQVE9iJDOPUt1+V4SBfuMZX4o
         wQgDBdsE7OE9mrQCxt0S6f7kA47bhI6UU2tzxtNa6e0solnlmWpjRWk9urmamJVgPDOt
         PdFtLOu9YVjSPYnlcZ0GJKUJ4U0zHxLQvyjTvpMUOwPD5D3H/eKTXSEe6qKstRkHuCrJ
         kAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783862566; x=1784467366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+YFzVviG3DzxMqpa6xeKwhT6SuFAN+/OdOMSnwiZgU=;
        b=qqcI9CHTqKz5qCXcTks2lBz1x1gHS/1J5MO3FZ05CByjGFrzfmqrD9SbiVkXTAPgde
         3386Rxi3UCl9V2/JAN96AQnCepAQ2uq6jZ+9JHznfbSFzwvkjZeabwg7vo2mXRAZLs8l
         USOSTXnmAs5HXtNOklekDLdoSVWRHdyJqAswKeacXnVhyt4vl2yt+mLo2W+zgn39wsJH
         2EJ+01L4Y4RiOaJoO+s9QJUU27wCwkpVjsuAe4ts4mikMtSYjor8olX7eDVouIfQqpcb
         4upkw2RS2Zj0Zk7i9xa85VrSVMpicl+G0H6Wioz+lZaPCbB52x5VhvMBpvZops//0xPv
         wcuw==
X-Forwarded-Encrypted: i=1; AHgh+RrPB4aPhhTsRF5IdDDGSGObcxIkE5X3MnUNxYwbryevDnRGBruMnbiVN1j+dJUmRTX0egeOQL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rRP8hAWzQjyMySvxIgVrKxia/3MePhqxNMzXIKHTm6MFh7Va
	70yIxQThlfbkYE+e3DhBt1YLmYmgqPZQoUQPGnaGgu17OzfhfGx98V5o
X-Gm-Gg: AfdE7ckW9wX8KpwAyNdJdOaaD5o5Ie1EQ5CzZuwMjDMEasLZcvNwir6A7ZCK/VVDeIY
	3iTjnsqd1FX/prFuELNE6UshczWrdYaa74WfXpj4HBgRKX5T6B082MHnQ/HLCeXrr5oMmcCVf+6
	Kx+30BJnuSBWcH2uPyUd2a7fi6tyf4RTnqAm3uXkzyDsV+ubwcl8P2PIPlVIcHjKaVCFe0PujwF
	z54Quse6QrpvyvnHenWXB01t1vSfyP+RQa5ipKEGP7ITN8aHc08sbMTWabXZxV/SJxtnVQ2pYAb
	uErzN7G1q6b6h399vvs2JuLZp2YzT5/cnwhIKupPVRxlCPQDgDLQJd2EXcn3zxo9KeN1j8C0lZf
	pfv4SFYL6kp2Ua5k9jPM7nXzfb5tsLSsEyWJVwqrYvynjHHUHFkRwpP+v0naxnLpP+euN35cnRs
	5oz8/Io/wUUryuKGASbCGOOHkAGZhhQHcocy9br6hTU9M8iF4gdj7Gc8eE/xQJTc1Hv3qTMb58
X-Received: by 2002:a05:600c:8b52:b0:492:53e8:3bc1 with SMTP id 5b1f17b1804b1-493f87f3cffmr58484955e9.17.1783862566268;
        Sun, 12 Jul 2026 06:22:46 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm180883955e9.13.2026.07.12.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 06:22:45 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	aleksandr.loktionov@intel.com,
	advoretsky@gmail.com,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net] igc: remove napi_synchronize() in igc_down()
Date: Sun, 12 Jul 2026 14:22:42 +0100
Message-ID: <20260712132242.223254-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
full budget on every poll, so napi_complete_done() never clears
NAPI_STATE_SCHED.

igc_down() calls napi_synchronize() before napi_disable(), so it spins
forever waiting for that bit and the interface never goes down. Drop the
napi_synchronize() and let napi_disable() do the job -- it sets
NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
polling has stopped, matching the recent igb fix b1e067240379.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..b3883a5a7d7a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5352,9 +5352,8 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
-			igc_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
+			igc_set_queue_napi(adapter, i, NULL);
 		}
 	}
 
-- 
2.53.0

