Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F664A689C;
	Thu, 17 Sep 2026 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643507; cv=none; b=D/5sRIkb+6oyU/lI1fN/z/IldW1kfrwZQmuWsdP4KAt/fvFMMMUungYPbZebtsltW814sZdbB4HkhV9O5J/f1B8aWmLjKyr2oaOrULiFEjb15AzvqwP/lfFd4eVVU+oPyKpM9ObSnI9YUTMawU+WtfTAe8WD3gIqNx/LlgwFQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643507; c=relaxed/simple;
	bh=qh5Y+45S8fP3fTfy3DAmQWodM3jVM78DvY+H+Po0hDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnRHnsZle6hrFYguYF6QNiBcEWTKAbM89RANuf0UxCki8NwCkCbboMBNPJBullJrZFpd/O6mKb/r8QvbTR5En0b68XwDhdcJfVxfq/VnzJGy+SAyEdxp1vaK8MVt9cSGoQSrrvusd0N75s3HvynF6TRzA0xiSzGU5ZKnLzc7j8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH8z3SyqtqWUl_CA--.1419S2;
	Thu, 17 Sep 2026 19:11:14 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	kalyan.kodamagula@intel.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	michal.swiatkowski@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Date: Thu, 17 Sep 2026 11:11:14 +0000
Message-Id: <20260917111114.2148482-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH8z3SyqtqWUl_CA--.1419S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4fAryDKry5Ar47AF48Xrb_yoWkZrbE9w
	47Zr93Xr4UuFnYvw4Fkr17u3s29r1UXr9YvayIy393G347Ary5JrykWrn3Xr4IgFWkCa4D
	Zw13uFyfC3W2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgkYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxU7H7KDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMNA2qrrRle+gAAsb

ice_get_vf_by_id() takes a reference on the VF, which the caller has to
release with ice_put_vf(). The switchdev mode check now happens after
the VF is looked up and returns -EOPNOTSUPP without dropping that
reference, leaking it.

Use the existing out_put_vf label instead.

Fixes: 83b49e7f63da ("ice: check if VF exists before mode check")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..202224dba1a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1384,7 +1384,8 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	if (ice_is_eswitch_mode_switchdev(pf)) {
 		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out_put_vf;
 	}
 
 	ret = ice_check_vf_ready_for_cfg(vf);
-- 
2.34.1

