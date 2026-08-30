Received: from outbound.st.icloud.com (st-2002i-snip4-1.eps.apple.com [57.103.78.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5212CDA5
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788106516; cv=none; b=gzIWto+eZ5GWnnWnHAG+V8Zf369pQGtRcAFCN8HyoEk3FEndsnCKRN5o1HZJyG8BtE7BnWUHZAwpPyzhySbabb/L3dHa7gcAM7d0jFERMrKGPItk/v9aSMGUxdWgipUKHVTtlWSvxWKyUHDCU/fMfITJp6jkx1V5wLecsVZO8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788106516; c=relaxed/simple;
	bh=0YvZg/b1PcCaIjOCGPGt3M4h0Quv9cPKCsQ8QAwSktI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gslUu9ZxH/jJWHMow13d3btZpERuZBfvEnE5mE3ZgjQxJfav0WYDcEyRXo4gQpff+u6sy4e3EuJ2ctc5JtenWH99sZ8EMJOlm4Ve+NEh4tmyPsXPneQUiHtFGxr3hx7pjQgKVTfvUKZ5oRcuuq7lQ4TWW5/zxkSqo8pC44v2MBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=albertopimpo.com; spf=pass smtp.mailfrom=albertopimpo.com; dkim=pass (2048-bit key) header.d=albertopimpo.com header.i=@albertopimpo.com header.b=Ajz4XBWT; arc=none smtp.client-ip=57.103.78.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=albertopimpo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=albertopimpo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=albertopimpo.com header.i=@albertopimpo.com header.b="Ajz4XBWT"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPS id 4D08A1801603;
	Sun, 30 Aug 2026 16:15:12 +0000 (UTC)
X-ICL-RepId: 01a05374-178b-7aea-933c-9fa261cb51f0
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQBLHV4ARQNJCVYCVABLVxQEFVYtVgdQFUsMXB1eBkIfFxtcABcNVk1YFFEIRR9dAFAVQwIZCF0dGQpQUANLWhVVFw4CQh9QH0wWV0NEHxwZWhRcGFNFUR9UWEMZRVZpQQtPHV0ZWxxCZFhXCQoKXhJcCkcCRwJfAFZWUAJaS18ZXUUPXwdZBEABSwNcAVsHRAxWB10AXgNdCFVeCHcKXhJcCkcCRwJfAFZWUAJaVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=albertopimpo.com; s=sig1; t=1788106512; x=1790698512; bh=b6DoF00lVvV3bk6I8fcYuJuJ0yqSF17hOXgdFF9fyxY=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=Ajz4XBWTMj7bumd0nDMIsJLMFeLzTMlX8lN8ig164JxwciCRI0wRyhMxfF9YH3phSp0U/DyBRD/z0tMvxW8caXO3WVKGYA2T318OUVEfDtsygsSEP68LV/UybBuhmMBw1gTHDI8it/LfDGh32LUAbDQaT7HewcY7tBEpTgd6ZIgl4kqYqHb3FKiVkLkWDBXScGOFya9IYCW7TyLnDlM/uW8Sz+LPrsZ67Aa/Wq/tPsAqsS1DBD74bQ2cdOd5nQ/5+oblORSKBLxdjfj7DaNM3Cm7YH58ADayrGoXQv0Pk2eYUvc8tq2mXpwkXtNYoIIoUyrNdjtZLA/3XIGkzyYtIA==
mail-alias-created-date: 1786285329818
Received: from ubuntumacvm (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPSA id E8C581801638;
	Sun, 30 Aug 2026 16:15:10 +0000 (UTC)
From: me@albertopimpo.com
To: alberto.pimpo@gmail.com
Cc: =?UTF-8?q?Jos=C3=A9=20Mar=C3=ADa=20Mart=C3=ADn?= <jmmartinf@hotmail.com>,
	stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH] media: ipu-bridge: check all DMI entries when overriding sensor rotation
Date: Sun, 30 Aug 2026 16:05:45 +0000
Message-ID: <20260830160545.40751-1-me@albertopimpo.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dtzGLLeszth2AypTH7JZWB3IaMuIcT_j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDE0MSBTYWx0ZWRfX6C7M23d+B4YI
 TQKvb978bwcLtosYRfFQqV9VAhHUCGJw0Z/4y6pkWgrGpp7ab8PvVrTW9kKd61MoKpc3NehzHy3
 7Pwm1uFZr65n1p7r/PMTrc4z/wgCEo/vF3TR+szFbh4V47jOu5hy0o/LRfWjK9MGrMz6mkBThT8
 jYICt75A7j40kD8DOFUJCkCKQDE2a7w54QsOif96+qmmIspjp01HRlwTh0dqarN1RyPSS6U1QNO
 NDshhmmD2YBR4LIG+tN/iGtf2YQRcrA29JqUqD5KXtmcWhNoZb/zMLng/jnu7FoqA/y4rhtY6ZR
 D5nHIRqtFwwNfNiMv04MBqbGcpoARhqCfJN88bOwMaC5XKLryK8/XMZlzpYagw=
X-Authority-Info-Out: v=2.4 cv=JpP8bc4C c=1 sm=1 tr=0 ts=6a945710
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=69EAbJreAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=HSkZeuWznnyJT7cjWUcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dtzGLLeszth2AypTH7JZWB3IaMuIcT_j
X-JNJ: AAAAAAABBcpW7IxlWZSdz4zMW2U2geMISowXs6ZDoE20sh4LcuDXPqivRYTw6WAFVxxXILBniHj0UZgRGl6M2rheLp3Qb0rMig0XN//sri2Na/8rRPYQ0mQInJAeEmYTUSe1vH5uZ1bIfSCOz7xQ/XZpEsLrRZfgHhWAtSv5ZYcpBeKlsMVmHShujosapJ4udakxeSZjWxYizBjpHEnpu0G7rrwhRU9KpmadeVCSbJHiZH75VZHtlyOuCZQsyMY9UdernEFrA0OdNREqGdMG0vaGnOghOIHX7XHTQNHo0mh51JZQZRImchO9a6YMNEvY9qPbIwiftTkvWPz7LfakQGy0ojzWkjJ+vKwGplHWZvedH0//XwmRdZBOJwzQQkYOfQL5ZjnDpMSEThFmpJnT2tgVLAPQZW9F337YSmn5ztumrio10Pm2Qi75awo2b/YZ0k2KCuWLJqXY++zjeuk/MGRhOIB6LDpAI8zLUqaYPTT0AnvZJBT/53CYc/MFEbz37jtqv9QgL0MKmKuXxyWnwya3m5LbIK5pRw608alcEnUmQKwTVUEe1efVfqN5lex+Z/+GCiYD0xZG2j1Dmi9tCLwbKcHk62TaTsB1pN3vak3X9EMXcBhEYL5ceTAI09yWDz0b6liBtcBrN6zgPXkNugAOGQpmS/6frKbSGwrmHopFuLZ4Tcxf3M+nJVemVrJGtxCNmSkbRAKHAuhMVHNfox7BoquNBAvB4Xbn49KbkbcUfv/lAxS8h2xU0jVZpDqafhBY9Qd9w+gp8uz2LindzhpOb83tKPZSCHGe3VmSmmXYv2hN8WMEav1nsxBQ6oJoF4AD8yMXAIgMQKlCV4Aq6z5NWtdyF2G3prbBDPl+o2kz7FmmeVI028BYIw2T4h785jwvW1g09xwSzvjxSpgioRh2OY/THu2nmlmflP+kF2lS1dy/jT8W0tI2myRbQZcpqHE6+x5GpfatYaGJ4ND4d5vgHXobA4n
 9UW82r5khYkV5IN3XRHv/2FmYAWI9ZWDUCdxURON8R7atM7OOr9P2GTT9+BXNkXO6MIPEw0Z41Rk/Le5NSUH6XUY8IWTont3X/tlu5XrInIwyFxzJyov7jZoeW3XY0my8di3/IQhZ96y+sCBs+7jWlMb4oaAU+aVfECrOBQhvsD7usXkqd0s1fi5UjZ95dR6hiT8jLbXXXpa8yTreGej5QZ4Omx/QmNnsX64QUWQ=

From: José María Martín <jmmartinf@hotmail.com>

A machine can have more than one sensor whose rotation needs to be
overridden, which takes one upside_down_sensor_dmi_ids[] entry per
sensor, all sharing the same DMI match but with different ACPI HIDs in
driver_data.

ipu_bridge_parse_rotation() uses dmi_first_match(), which always stops
at the first entry matching the running machine, so any further entry
for the same machine is unreachable and only one sensor per machine can
ever be corrected.

Walk the whole table and match every entry for the running machine
against the sensor's ACPI HID instead.

Fixes: b75710155a82 ("media: ipu-bridge: Add DMI quirk for Dell XPS laptops with upside down sensors")
Cc: stable@vger.kernel.org
Signed-off-by: José María Martín <jmmartinf@hotmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index f9efa501e8cf..1bb3a3e98d6b 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -357,9 +357,11 @@ static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
 {
 	const struct dmi_system_id *dmi_id;
 
-	dmi_id = dmi_first_match(upside_down_sensor_dmi_ids);
-	if (dmi_id && acpi_dev_hid_match(adev, dmi_id->driver_data))
-		return 180;
+	/* A machine may have one entry per sensor, so check all matches. */
+	for (dmi_id = dmi_first_match(upside_down_sensor_dmi_ids); dmi_id;
+	     dmi_id = dmi_first_match(dmi_id + 1))
+		if (acpi_dev_hid_match(adev, dmi_id->driver_data))
+			return 180;
 
 	switch (ssdb->degree) {
 	case IPU_SENSOR_ROTATION_NORMAL:
-- 
2.53.0

