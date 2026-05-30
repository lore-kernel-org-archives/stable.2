Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC91E511
	for <stable@vger.kernel.org>; Sat, 30 May 2026 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103873; cv=none; b=MoDv0I5tCFAAA4zFshQeDD4JPW3b9+alSxfMKclUZHL4TiLWb/lh7sFE2E2zcUUd30SRz2MU/B5R39yWsihZyYksvMvEMeZVXl2+pMXU6wUwI3Xk3n2H+H9Ofmn84VtUc+T7Alxu+bAss+51DmkLwbN3rSwh9c4Wv8G6/HUbSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103873; c=relaxed/simple;
	bh=SzyZI3+Q4pAmeaKZJcyPuda4Jmcspa2KEro0bEBZCi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEc4b4Q6u7cSC1AftldY9sU+slNh35HxDY3uoGOOSr06vyQ4T+TUOQDu5/BrlxFMzpNXMQe+uFlKiNL4saR7KLpkhxXVJ6CABC4nvWNe6hbp1XD5ObdV20yIqQw74aGVDHkNXa2kT8lNxtlHLfPVuq0bWU8jPefFarM4faUGPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3gUOVYX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3gUOVYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C21F00893;
	Sat, 30 May 2026 01:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103872;
	bh=hioexobH9K1jk6RdtkivkU9bnE2XD04AYmOQluJiGdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q3gUOVYXDBM6PqF0DZ0EVLjnsSdpa5EK/rFZP9SxSRP1OQAvF6B9H8HX+YGJ7ntww
	 AEElm45h/O2F9UgmBEscAI5XcGfRoBkTuzCcqu24owUslgBy5oEEM5tJfNpUGIM+Q+
	 3iNRiEcHVbHuvWXO+9GXwhc8oDzHdXhCv/3Qi2uwtO73faFfZJEUtoHruIw55UOlJU
	 hvc/CgzpE/+xfR1Z4/R1TfPRmvvKgaduSnLHJ09BRkLwSCAnWAkTVXNUAr5/UdvRLu
	 DOQ0vLZgQ+PEMVA7BSNOJAE5j9Ebli/vH8vkULjkMWBrRyuGxckketoIsRsKu6UXj2
	 2e4oM1Ya4PFXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ice: fix VF queue configuration with low MTU values
Date: Fri, 29 May 2026 21:17:49 -0400
Message-ID: <20260530011749.2555710-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052802-enigmatic-canyon-c282@gregkh>
References: <2026052802-enigmatic-canyon-c282@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit 3ba4dd024d26372733d1c02e13e076c6016e3320 ]

The ice driver's VF queue configuration validation rejects
databuffer_size values below 1024 bytes, which prevents VFs from
using MTU values below 871 bytes.

The iavf driver calculates databuffer_size based on the MTU using:
  databuffer_size = ALIGN(MTU + LIBETH_RX_LL_LEN, 128)

where LIBETH_RX_LL_LEN = 26 (ETH_HLEN + 2*VLAN_HLEN + ETH_FCS_LEN).

For MTU values below 871:
  MTU 870: 870 + 26 = 896, aligned to 128 = 896 (< 1024, rejected)
  MTU 871: 871 + 26 = 897, aligned to 128 = 1024 (>= 1024, accepted)

The 1024-byte minimum seems unnecessarily restrictive, because the hardware
supports databuffer_size as low as 128 bytes (the alignment boundary),
which should allow MTU values down to the standard minimum of 68 bytes.

I haven't found the reason why the limit was configured in the commit
9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message"), so
with no more information and since it is working, change the minimum
databuffer_size validation from 1024 to 128 bytes to allow standard low
MTU values while still preventing invalid configurations.

Fixes: 9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message")
cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260515182419.1597859-3-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied the change to ice_virtchnl.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 471d64d202b76..e98acbc41a813 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1746,7 +1746,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
-			     qpi->rxq.databuffer_size < 1024))
+			     qpi->rxq.databuffer_size < 128))
 				goto error_param;
 			ring->rx_buf_len = qpi->rxq.databuffer_size;
 			if (qpi->rxq.max_pkt_size > max_frame_size ||
-- 
2.53.0

