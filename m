Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775726;
	b=LAkhSMl5wVsS4PdeRyxePG7kU9KFA9z++TRIZy6hdUxYcAQoxVbh5dz3BanbOrnjz1V6
	 Ch7TRMcOfsPSF+mEW9R53ak0Q9UGbOacH5csXhdwrNx8sxF9tC2gA4GYOS/+1Cv099a3V
	 eNuKI2bRF8YRdYBlj8w2vfnfsvb9djHMo1o/UetBWTpmZkjzFN4LTNBfvNL/WERP104lv
	 v+og2DktNYs3ggzDLugTxta0gLGhldDHJPg6TUaFE8XRo2eemEpxjqtHE1tP2nv77epEc
	 KExh8KwZBj2OKrrX2anMHdWRtmBD4SY5cDWiNa+febi5GxNT4Blc8e96bpAnCGfubMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775726;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:DKIM-Signature;
	bh=cEoK95BmIiRTWYQ320m84PwqZyyVLheWWFuoNvEb4Us=;
	b=jEIEpDIhVxO5h4a3nUkkfZvijEq+ZMe+0Tmvsm3yFETXJSl9j1nmFURbwxCD8E4gnb1p
	 sQNDLnTkr6vHJUzkEwfdrwC3iz+/8fQBp+QHTKLmQV17oChbCTZ2ZknZvXEFyCpEx90Ip
	 3uxzgIgcWGN1Ie6Ir8/PGiDCD6bVlTioyDsHAIujJpP6Qo0Ie6wzV/LtHeDL+TNww5+1H
	 FBvy4GqAEjw1PTfsbslhqOd1T8eWRbrCphoULBSeCzL1HOYcEGcwKXRE3XiOkVCfnKmc2
	 pAldI2FcIMfKkUbOz2+woJq0TZ3fO2hW2QjHVn9pYcc3I9HghdmIwcKG/Bz1BJpkNaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=kdo1PtV1;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4C103606A31B;
	Wed,  4 Nov 2026 07:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C103606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=kdo1PtV1
X-MD-Sfrom: lizhaoxin04@baidu.com
X-MD-SrcIP: 172.31.4.16
From: Li Zhaoxin <lizhaoxin04@baidu.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Zhaoxin
	<lizhaoxin04@baidu.com>, <stable@vger.kernel.org>
Subject: [PATCH] cpufreq: intel_pstate: Use rdmsrq_safe() to read MSR_MISC_PWR_MGMT
Date: Wed, 4 Nov 2026 15:01:49 +0800
Message-ID: <20261104070149.41393-1-lizhaoxin04@baidu.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc6.internal.baidu.com (172.31.50.50) To
 bjhj-exc18.internal.baidu.com (172.31.4.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793775720;
	bh=cEoK95BmIiRTWYQ320m84PwqZyyVLheWWFuoNvEb4Us=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=kdo1PtV1rmaykAl+MYYH8xzRmVyG/Qr0SwYY6dEmISAoHCVugf6eQpVXeXnx1j4Nm
	 Fq6yg5mB28GF8/aATQpXBbT28oCeYBJIwl6Ur1ZXXp3Oka+V7qBdgAxx7X+cCHkBAN
	 HzT+sdqqgJrLBeG8JpugJ7PCGLgGTyDvoQCSUgVDYaMJVmWygYB/WeymlFEsAc2tCr
	 YwNn8THXROuR1NKcXJ+AYccPhbmcL/peBDVo/R4lyrWxItB+y77lSfM1xe69FiolD6
	 gsPwkzb142ydRKxpRd+w7kI80L30Eh12ARB8MT/gyjyK5JkfibAZq+N2zlFgdr/5qg
	 a27mwDjyWHhog==

From: lizhaoxin04 <lizhaoxin04@baidu.com>

Commit ed7cad0504e3 ("cpufreq: intel_pstate: Relocate platform
preference check") moved the intel_pstate_platform_pwr_mgmt_exists()
call to the beginning of intel_pstate_init(), right after the vendor
check, so it now runs before "no_load" (intel_pstate=disable) and the
other checks.

MSR_MISC_PWR_MGMT is model-specific and KVM does not emulate it. In a
KVM guest using a CPU model listed in intel_pstate_cpu_oob_ids[] (for
example "-cpu host" on Emerald Rapids), reading it raises #GP and the
unchecked rdmsrq() emits a warning with a call trace on every boot, even
with intel_pstate=disable:

  unchecked MSR access error: RDMSR from 0x1aa at rIP: 0xffffffffa4009342 (native_read_msr+0x2/0x50)
  Call Trace:
   <TASK>
   intel_pstate_platform_pwr_mgmt_exists+0x3b/0x220
   intel_pstate_init+0x1e/0x500
   do_one_initcall+0x59/0x350
   ...

Before that commit, such guests typically returned from
intel_pstate_init() earlier, either because of intel_pstate=disable or
because intel_pstate_msrs_not_valid() failed on the zero ratios that
KVM reports in MSR_PLATFORM_INFO by default, so the MSR was not read.

Use rdmsrq_safe() and treat a failing read as "no OOB mode". The
exception fixup already zeroes the result of a failed unchecked read,
so apart from the warning going away there is no functional change.

Fixes: ed7cad0504e3 ("cpufreq: intel_pstate: Relocate platform preference check")
Cc: stable@vger.kernel.org
Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0e6ae4cdda5d..67447280e86a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3649,12 +3649,12 @@ static struct acpi_platform_list plat_info[] __initdata = {
 static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 {
 	const struct x86_cpu_id *id;
-	u64 misc_pwr;
+	u64 misc_pwr = 0;
 	int idx;
 
 	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
 	if (id) {
-		rdmsrq(MSR_MISC_PWR_MGMT, misc_pwr);
+		rdmsrq_safe(MSR_MISC_PWR_MGMT, &misc_pwr);
 		if (misc_pwr & BITMASK_OOB) {
 			pr_debug("Bit 8 or 18 in the MISC_PWR_MGMT MSR set\n");
 			pr_debug("P states are controlled in Out of Band mode by the firmware/hardware\n");

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

