Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414289;
	b=xkLMvduRPpT2mSSa1DEZ/rMpp7skz4FCPkRyscAWW4g7d4M8wkcw9fb5jgUkW7dMrjtC
	 4hj5sTgyEw6TDhg5HUq7DxmOkKyd/ssZFuYymxnQf5+J74RrzIBCTPu6Ha4PZ+bOVBS9v
	 nnt+EdT19xwJToNpWBH3qIriey3MhIjsisTb+OsiekjXitu9kYAe4ijM8+DS9Ssk8sUBZ
	 RPrxUFq7G2dUUH0BYybp0VhmFUesP35DNfXfEjZ2E3kVbAi5AOXH6/OB8EUkBb6GwUEJT
	 0Gay7b9sSqJzrgEzLGZthATwpzAvTpP+FppsTTbr6NYMNxt+4GPaBratMwVrbKtkLGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9o+7CjfQtp9Y/tzb8Xt+QywHEuZThcPNtv4MLQPgFZU=;
	b=avn7GqerxPOtxAKf/6FuRKqm5xNOgtV+hr9Ajh0lwL5mFEU1T4YR8S//ALAWm6P6Bfz1
	 xC2TiEypk46j5sD3tLNTKOc6oZfSVtVgydOavnLHAVAa+vKCV2rPCIR0MntcWL63vyWBE
	 WbC613wmPuE0RtL+yqYaNwvNZC5BVAyRtJ4EjUep//o87q+ndF1Su5Lvj11F4VMmyJHw5
	 hJ0jKjNpxvDDjlqhld2cbN8GdWVmC4uQsA/+eMmt5ve33E7cZ7Ugpf7+4KIlZXhe0XcGf
	 55KvBmvpTLbiIDsvT/P53AB9I/FMkq8neUH+0AUCJ/D7l+Yiie7BLjWsXsmveB4Aeuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9MznJ7a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EB606A339
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9MznJ7a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3091F00A06;
	Wed, 11 Nov 2026 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414289;
	bh=9o+7CjfQtp9Y/tzb8Xt+QywHEuZThcPNtv4MLQPgFZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f9MznJ7ahHBTSCmbIgWtlwpTZ97bLpGpOicRIzYqqHJkM9cZZJvwnWVILqze+DLER
	 TkTzyOUqxiI7E65Chs7+YspKFC/7Hd7rrfvMaOdlCuSSaOOupRME1LVTiYGvyQ481H
	 TZSrsbA3DBFIU6UiYrxeUJOc5fHDKwb3U6VUC4jVRzwqMTWIUJmvLEDX4UshMWUbpB
	 XCbzZMudUAsTvQ33VyiajW2Umy4wAzrHulgP418V/V29AdTU5B6D9PAdDTm9/c8qzy
	 yyhuWwKx3+HQhHQWIMKKdLzM1voroMcqSrwayJRZNOjxtEOnQ1C/OeU8KXd/ltaN+M
	 WVWsPDqtoNCrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ACPI: APEI: accumulate the queued flag across error sections
Date: Wed, 11 Nov 2026 11:24:47 -0500
Message-ID: <20261111162434.3276815-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062103-failed-5.10-f341307a1489@kernel.org>
References: <20261107062103-failed-5.10-f341307a1489@kernel.org>
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
[ sashal: adjusted context for the older bool-returning ghes_do_proc() implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 88c01d4a7f8fa..29cece11ccb22 100644
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

