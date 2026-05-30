Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBC86334
	for <stable@vger.kernel.org>; Sat, 30 May 2026 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104056; cv=none; b=Eqcc6K0Y/f3dYx92O6w0/R5zW6ihddo0bOaogC8GaQSi1Qw9PHPyKxOZLOmjgCbb5HppGIlJhDnTlyblwCf3qVEK4djxnDJc/4d2yqf3kZtx0vImjzoH7SYqmvyy3A993iWfy4A+9B7xP9vzGU88HACCXljeAH4xEaKUCDA7raA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104056; c=relaxed/simple;
	bh=9Jbml+IZhGpfs4onsDDJDmgwABzznVk8ScqQbKIhWpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDmIySUtUng1oJQwAAlaSwHavwdzxiMdg5VNx2BtB9QeW7ZjKXoL6f9ziTLpk8lu4F10GlkElJ+lUBa0t4FVnNaX9iAfzGw/fZyZHMmhlalRT2KZxHPigBLfjSNzgvxcEI5XeQkeic+BCA+t4qfU5XQxQ+0EqLveaqYK0bG/TcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfz4ilTQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfz4ilTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256641F00893;
	Sat, 30 May 2026 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780104055;
	bh=ru8BqlWIKVS6uzvtmM8c6hrO++cXlHjRWVNEoPMgmkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kfz4ilTQw448EZFpj1D84XKxVvAHAt0LglQDNJMXjY6DbqSwJukrhF7jUAzod7vn4
	 B9PGeNpL1bFgK9Epq7B78IdgCS3091g5zdUU4DchuvVUYP4CoDKM9KvUAjf4K3su8M
	 kv0a1dMAeovQRJh0kEf6Y/lC7Ccx9k/pmd6nqngHuvxFMAAMIohohJ4BGdNRnntCDp
	 U4VG/9hWCkp57y0pPkbLdu2uVcF4d/TVo/YoBRtDSt7ij5qfM29Lq5VCn1CzjKu52l
	 YjYeSchymyLS+P4JAafVLEVtaLQ2CZ2dMgQmRqFwKqXdYrKrnKPDW2RlqfT1oomG4A
	 seJyjVd0OCfLA==
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
Subject: [PATCH 6.6.y] ice: fix VF queue configuration with low MTU values
Date: Fri, 29 May 2026 21:20:52 -0400
Message-ID: <20260530012052.2574044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052803-argue-spendable-595e@gregkh>
References: <2026052803-argue-spendable-595e@gregkh>
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
index 1edcf93031831..61c40219de1a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1681,7 +1681,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
-			     qpi->rxq.databuffer_size < 1024))
+			     qpi->rxq.databuffer_size < 128))
 				goto error_param;
 			vsi->rx_buf_len = qpi->rxq.databuffer_size;
 			ring->rx_buf_len = vsi->rx_buf_len;
-- 
2.53.0

