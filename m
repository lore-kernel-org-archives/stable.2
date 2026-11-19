Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101579;
	b=w19EFEmVMfF+G7vawRw3tqaxp1n8s3hkytcSVjY2T5krGAfMyHC1n8BFQ2xsf/03Fb/z
	 NJVku2MVnor2Dax17/i8VOp7RP2OTTepdbD1v95kGYidQvVPPAj95Cy7sITgPunkfjl6x
	 1MnHOVZ1S82ptkTZpVbsxvQHTmksFrYXkqMRMLZXQJzZq8SYlkXbjDh8ShbYBOx2m0nDV
	 ePisQ3Aq588OR7oxbKFQaf/yfrrYL7FlwFE4VYV7BW/fC1LdyoghgH/3VWvGg+pptc+fQ
	 +VVh/hfhUWkZpZG2JZOwmPFwfmOBd0OVV6z87ksRIRuMPEDmInGQKQB8VDVF0bP9ZmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101579;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0c0iYf8SnsF78dce9dVRMwoU6TCYhcEsgg4tPhKPWUk=;
	b=e9JZfUrS8p6tTwdEPmTpmsqPWIRmi1DEGDALpS9gukuObSWODCwP8Fp2ODs33z2hXA7/
	 sJtlswVkCjPK0+C3FNCBPSrnJ80MrWX6kvDny0mJjO+9feeyc+mZYWCOtDIw9Pp+/JkJ2
	 Kh4KU7R53fYnJf7cPGzRJJBk7ay6V1Vq5Sv6ykG7C41a/Hau4048IRBdQdMBTYr8BX2wu
	 hH/pvAKzRXzI887cS/eGix6mQB/ui8nJWmKkXFLgWBBEWTppLK7Px/FodeBxxKDUh/A9B
	 Tl35M1NX9xa6ptEcpLIQTE2nH8EHSmblTq76Zqiecz867MKmmymopLRRiZTv76wacbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZPIty8Ws;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF841606A324;
	Thu, 19 Nov 2026 15:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF841606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZPIty8Ws
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 372251575;
	Thu, 19 Nov 2026 07:19:35 -0800 (PST)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA0E93F882;
	Thu, 19 Nov 2026 07:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795101578; bh=c0VxNeat9RMxxsyhQ2qh1+xhFnQ8+vLDzzO8XL7Quv4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZPIty8Ws7WrVO1fl7WCU84seph01KQl4vKV+x2sjxQ8rcxebW0s6IzZvwt4jqXR1g
	 khMfT1py8V9sEUMWSeM71b8jeMlFT2ihV+r112yiFWbF/p+T3KQAYcKK6F7V2WWNbG
	 Q8NK0rg+yQ/Z2/qGk6anL64au0AGDflLrzKg4V24=
From: Andre Przywara <andre.przywara@arm.com>
To: stable@vger.kernel.org
Cc: Ben Horgan <ben.horgan@arm.com>,
	James Morse <james.morse@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7.3.y] arm_mpam: On saving mbwu state read the monitors before clearing CFG_MBWU_CTL
Date: Thu, 19 Nov 2026 16:19:31 +0100
Message-ID: <20261119151931.335561-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Horgan <ben.horgan@arm.com>

commit 197a7a41e6e006916fe68c952e96d768933104fe upstream

In mpam_save_mbwu_state() the monitor values are read using
__ris_msmon_read_locked() which checks if the configuration provided
matches that in the hardware and if not then resets the monitor. To avoid
resetting the monitor before reading the value that needs saving only clear
the configuration after the monitor is read.

Fixes: d056d29aefbe ("arm_mpam: Use __ris_msmon_read() for saving MBWU state")
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[backport: drop error returns, adjust to changed context]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

this is the backport version of this patch for v7.3, as discussed on the
list before. This avoids backporting two lengthy patches that do not
make any sense for v7.3 (introduction of error return checks only used
in v7.4-rc1 code).

Applies on top of stable-rc/linux-7.3.y (commit "Linux 7.3.6-rc1").

Please apply for v7.3.6!

Cheers,
Andre

 drivers/resctrl/mpam_devices.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 30d08d1634a2b..aabbe2ad8f1af 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1716,7 +1716,6 @@ static int mpam_save_mbwu_state(void *arg)
 
 		cur_flt = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
 		cur_ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
-		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
 
 		cfg->mon = i;
 		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
@@ -1748,6 +1747,8 @@ static int mpam_save_mbwu_state(void *arg)
 			mbwu_state->correction = val;
 		}
 
+		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
+
 		mpam_mon_sel_unlock(msc);
 	}
 

base-commit: 62eba995b019cddac60e54392601f157010821e9
-- 
2.43.0

