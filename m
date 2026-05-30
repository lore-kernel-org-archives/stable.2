Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B51E5201
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141143; cv=none; b=J1QNBWCGsOYWf+ihb1pB67kPd4yD553LqJj5PzT13ieQ+ZtyJEcdlJUmvUe1U7tioSRcIoA7GhzBCcui58tuxYHoevon0W8Yb4V37eB8i6jFS3X+79iv2CjmoCBbRlGDvYZGYocE3KHtZss1oqvTRUw+G6j1W4Wwy0vnEEMV4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141143; c=relaxed/simple;
	bh=BN8A7MNUorO69BXjnsfRd5o/8ikIJc9wGpafnby6rRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3L7PomWZ1ShqB5Bcom1S1kEtYjfTL03j7DaqWbtnh9Pc8WS+YIZ4RM7AljhIUWg8vTf++J9Jw97XXbL8MDfLS5zVmalRwKwQIbjijL1R0fKBbYY+TqS5Vuwmo503C/HX6rNi0eR8RAAjZNUe7Qv+pPwnoP7AHtdJ+v2ApbT5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAUPAHVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAUPAHVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6801F1F00893;
	Sat, 30 May 2026 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141142;
	bh=wsqtOpJopb1Xi3TXG5eqHQVu2N40nDuLPUbzM1OMN7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NAUPAHVlA+QJQ4FWXiQ8FMtacs6dZ6IDPjFpgS5BKdMamKATcSo98t2eMIri0VJfQ
	 SYCLVhmNNglBod3QpAGMRW9U2ECMznqzrh1F1YWTTioDxsHMhYDACz/YyRiMoTXUAC
	 Tyt/h1vQmAroRjZA3gMsixrSE1mVuYA44oKdiAOETP1wLieEQjSNFAPJUj6CIjNKGC
	 Al7lq6ZhihjQR20WYqSJBFVOIXRyC34XsJ57OOWfoaxdf1opha0rxDPnKunGQISBG4
	 QvKyKPEVZvm+O9BnRBpiqCdmH/+Y/l9sktMmPYPCmRDJ+7mupKJT7kWKqeqDcDR+97
	 WhJ4gyDBmiyRA==
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
Subject: [PATCH 5.15.y] ice: fix VF queue configuration with low MTU values
Date: Sat, 30 May 2026 07:38:58 -0400
Message-ID: <20260530113858.1937093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052805-scant-urologist-faac@gregkh>
References: <2026052805-scant-urologist-faac@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index e4e25f3ba8493..f93551ee3cb4f 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -3585,7 +3585,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
-			     qpi->rxq.databuffer_size < 1024)) {
+			     qpi->rxq.databuffer_size < 128)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
-- 
2.53.0

