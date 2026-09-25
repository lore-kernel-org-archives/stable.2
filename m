Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402F4A4EE7;
	Fri, 25 Sep 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348987; cv=none; b=rxgM+cpBPrXZShUcZmU1h9hf6KELaTuvA5Kkas8gAxptverU2s1HbBkmwQOfDJsjyf+KqD3dWm4U3wtP0VNmaEDs1/0eqo/QFlFg/k2C1ban7QLEbVEhP3EYX03HZxS9bin6VbCnLsv0eBXUFGC9BWP8E2CqbCNmrTnH9E57rKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348987; c=relaxed/simple;
	bh=VW/XrB+qV68/FcIQ5eMC74++xgOoT9nZOvKItukui0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZclRZGW7eYpacRvk7SCO6s+th6G4Wil9RTKuNT4XqweN6B+ibi/cSf1G2YLlRydq1bwivzKFMTxjMqtpbx2Opmym6kmNZMuupGsSDjBVgOyTtZJ/qm1Gi+D7LBamVGfC7JRgRiOUevGhoJKSd0Zm1RGaZFzDos4djK4zPUcABHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hobvotZH; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hobvotZH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=8ZsRdp36EZWb0DJkYc8BpcrrbAf/mTTeVBAJoAH0lws=; b=hobvotZHAGf8k17uWJCa0M633j
	Xgu23JcquGP8lXWipCmZh/G5kobCcsQQgbPcHmuGoMq96+PQL+Jad5Ov52BpZ7TFaGP0d0jOSmGWj
	6kiqbW57/z7+9gDCZlJxAb5O4dOE/JVX2ZKWKt8xx3MWpWEum2UudXPmjoR32fXhHqY5ifLUsQOTb
	sUBNeBh8euK5zvvxWA405zJ5cIHTdHnqODY/WrLKnjJnYtN9o3DyO6Kav1EFwCUs9a2/93UMT5QLu
	6tIiG1WpkOTSbEA+Gd7Nk9H0+EuCUZuNf3rAtEHNd2MvyT9Tj6pmN4LpdWSlSaaJkQ+67idAKuFMp
	dpCZQ1NQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA7Y7-005OBd-3C;
	Fri, 25 Sep 2026 15:09:20 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 25 Sep 2026 08:09:11 -0700
Subject: [PATCH] ACPI: APEI: accumulate the queued flag across error
 sections
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ghes-queued-accumulate-v1-1-df50553957d4@debian.org>
X-B4-Tracking: v=1; b=H4sIAJaOtmoC/yXMQQ6CMBBG4auQWTsJlEDEqxgXZfoDYxS1Q4kJ4
 e5WXX6L9zYyRIXRqdgoYlXTx5xRHQqSyc8jWEM2udK1ZecaHicYvxISAnuRdE83v4CbrpKjl7q
 vXaAcPyMGff/G58vflvorZPneaN8/uRej5noAAAA=
X-Change-ID: 20260925-ghes-queued-accumulate-591c8ac3b32d
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558; i=leitao@debian.org;
 h=from:subject:message-id; bh=VW/XrB+qV68/FcIQ5eMC74++xgOoT9nZOvKItukui0g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqto6cfmYO00v2L5iB3D85pOjejWCOxbWqEF6kF
 qwUy4rKhbuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaraOnAAKCRA1o5Of/Hh3
 bWocEACQACuoZbczHAR3Rz/S8hB7WnO0Vizvw1vb4qil7D1UuTHVGfBa5Yq/CEMt0OpJ/5hTy8D
 wkUu/gKIGVue2gswaJh5dy1CkheOC0xhz1sWpOaBV7ppyuIJ794lQEBhfyknXQslfc5FwHdEGVV
 ssJHzJANQ0WPGcvnJYgm9p+oK46hGKpURxGvDDRET0+YJuqa9simwd0l3IHB5jgILRn7OC6F3PP
 0NTjURh1DrHb02TzaoCFNc9obI1TavcnYT6VY9NFBWFVsTKB5sRxbACa74lwHKh9eyeGOP7VaDZ
 2R/B/WJI6ztT4r+OUBKcc0TeTO0MaAtLFgcJRlH0SG1uKrNx4S5YqM/4WGEdsu91HTVXBIKL0YJ
 jBiHe5BJRu0rT3+6gVO0Maax1MVE4FHFvcIU+8ZE9y9zc7fMZ0W4Gnd4XEbQK4SlQABU6qJndEl
 6/ytsZNye/i3lNsWC7OrGYguBBqlt0DxKL1W6+vOZhm4PFlGKeZlTLbBu79BeAfoPcY5ebJ674t
 nHVRmSgk+4LVl6GM6YtyxKsN1jyYc1kAnE0vMyEDV04Wq8U6UmBHoMyYTnRKEuzUddfKZJLGb78
 j5I9HMLf221Of0Rp/rI+40pxpvJDkxoDiwcYY/txMHa1Dys3Sbi8moPMPz2K/rwQ6Lx/HCBee5l
 AuiUvgm0Z2A0+2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

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
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/ghes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fe10ab0e02f68..ec2d5ca51db02 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -603,7 +603,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
+			queued |= ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -951,11 +951,11 @@ static void ghes_do_proc(struct ghes *ghes,
 			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev, sync);
+			queued |= ghes_handle_memory_failure(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+			queued |= ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
 

---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
change-id: 20260925-ghes-queued-accumulate-591c8ac3b32d

Best regards,
--  
Breno Leitao <leitao@debian.org>

