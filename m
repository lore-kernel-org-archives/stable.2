Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413958;
	b=AkWH/wZKVRkcIDWbiuAG7vSgj7zSHyGrRzbku/VMeqauvMundwOCd1OYA1kScS1WXy+M
	 8orF2ysmEjg9AvdYYTuew4/vuj/cLO85nuuVJnklyAB0h9xSH7PNXOrBWpvKvaNlPTH1Q
	 J1Jbi8rZa/FaYyhvhzk/Rgjw8nGa5DowEa1tkg3dwKJqz56VMSYUv1uBqieK3ppwrSF2j
	 R2C6rlRvKxjc17lRRWq5dF1vtxHg547wuPHC0c9J6FxK02Cigc1bJD0Etiq2Rc6+nrXJs
	 halLDzSWl9FcGt9bCOoIGb8ykr2INWQSN7PGcrgSSbAQSoC3mXSC2nJBnUFFHMp1Upg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JIa7fg+iWKuPXcPSAWBZkQBM2VGcFWtEjrXe8f+qo3w=;
	b=eZPH4Zh6o4KnhGqdK2nr5WRnTdal0+DQn2SWkgx1CHDHPhsHkFVqI4JWd/+LxUF5z0m+
	 3a+Tf6RNNA0tO0dJT6VZHLL9TPPPqqszu5V3z+RzYRHi35ZvtVhgaenMEsszBkuFsOLuv
	 uX9hOK9P+V+n9/iA5N6VG1UhWxArZ/ntWl5ClSZC7yMD0LZifawaGBDbJfSN0mNjJrwrr
	 542NS42/78KfBQPUgzsFld2i2jh/lW6DE28/H4vw0Vk82ne2Rhk2xL3YgbP8WRS7su2/f
	 CCryuNHUZ1azv8XRVDu5nJJqNTOqLUaBdjtCBw70xBlJ9hmpzuScuT2sdwuNmPTgrsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxFu9TpF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6D606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxFu9TpF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858E61F00A05;
	Wed, 11 Nov 2026 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413958;
	bh=JIa7fg+iWKuPXcPSAWBZkQBM2VGcFWtEjrXe8f+qo3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxFu9TpFW7HCW9EY9cVZUxIWv/neinhbnfoxkKQIW+tM1t1wcbvzFUojp7l2IYMQm
	 Jrss+ZcvXUd2AbUGG84I24OGD/suKYFiakK1iaGNTauprbs3/cvclZN9iuFrmAj9xt
	 u/LHNwtG5bV+RHzOPDBzN6gS6wr+wjwdnY2HRf3/64jPjpZF7elbgBj3h6ePIZKEgL
	 SrVPCB4zXEjzH8uk4VCStS8tfx8mUAMB2Syf5VjhZXAsB3QroqOXHldlikrreVAFeG
	 qNbfJfBP88O6cFjqrj/xT0z661TwYoeoOSUvzl6DlN1EA/Jh3QtmvW27CY6vTWJ3S1
	 P64X38JU60lxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ACPI: APEI: accumulate the queued flag across error sections
Date: Wed, 11 Nov 2026 11:19:16 -0500
Message-ID: <20261111161904.3180519-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054655-failed-6.1-f341307a1489@kernel.org>
References: <20261107054655-failed-6.1-f341307a1489@kernel.org>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f341307a14895e5da056fb419a31ef7fb534ab18 ]

ghes_do_proc() walks every error section of a CPER record, and
ghes_handle_arm_hw_error() walks every error-info entry of an ARM
processor section.  Both assign to "queued" instead of OR-ing into it,
so only the last iteration counts: a later section or entry that queues
no memory-failure work clears the flag an earlier one set.

Instead of reassigning the variable at every time, just do an `OR`, so,
if there was a single match, it will return "queued" as set.

The comment above the check says "If no memory failure
work is queued", which is the semantics this patch implements. I.e, only
SIGBUS if there are queue was not handled at all. If we want to SIGBUS
if any event was not handled/queued at all, we will need something more
sophisticated.

Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
Fixes: ccb5ecdc2dde ("ACPI: APEI: fix synchronous external aborts in user-mode")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Link: https://patch.msgid.link/20260925-ghes-queued-accumulate-v1-1-df50553957d4@debian.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ sashal: Adjusted patch context to match the older ghes_do_proc() implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fff97db7779ef..517ed5f77008f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -529,7 +529,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
+			queued |= ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -671,13 +671,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev, sync);
+			queued |= ghes_handle_memory_failure(gdata, sev, sync);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+			queued |= ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.53.0

