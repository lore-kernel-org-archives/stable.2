Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412638;
	b=oXl93NHZSgC/kXeX/ZJXt4in5mdNRp4TcdDOOJ+Bk5FQb3AM6ZfLRQAXNvBXPa3KHYgH
	 jfTYJ/zOVWBddPmy0vVEzSAtyX3tzr77Jx7eGtHAKc9ElbMFefxUzFy/YuhWMBUMHZGQw
	 yyHzsHQqgc9jGbrKHG+WWOl/FwBxQnzNXG0U37/SnWS4Y2GOaYKHQ+E63JTkRRtXGDFaq
	 W0y3LY6X2MpUX50OSYgSww8cQKWPyvWEtQRlpbPjVh2kkmMngnVDk7V+VbWw1QGEd2vB3
	 cFgYlX3ZP/fBMpA11Y70tkI752KoL1VXfmIEsGv00erIpg9UrCKRJqlPA42X+z9Rl7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v0K5Bre4dAzNqjJVv0l1Pcm4gWQLb5+uRk3BgjGFdJ0=;
	b=b3qw/SkpTrDTHkiSClAZ8I55jDqpj/4ZMepZtKBHdsFvxeSNzuLFdXqyFaTh9ciz8MWW
	 JMKM0a0eysYN+PjewzD3+hyN0nvPdD9uUhdogyCZbQPhpqEoppcVZr/wVMpH6FMv0uro1
	 5W3qo6aiw/eoe2c5R+x/aqZkgXUvr4BMFz+tM7ElsGccmqD/PDKQjw1VBDGSaxmp3CTl2
	 zvCzv9iDXzli8Nwhgb3jGNuorXfOcptlHj5LGfRZ7/OmWeykVEHrugnA7mKIP52wTkmcT
	 3smbYaTVXFcE61gZq7kqXr7MLpvXPwRgfZC/IW1li6AfA2YKX8tKY/K+7iQsGVWpmvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGKYRwM+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D19606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGKYRwM+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1FD1F00A05;
	Wed, 11 Nov 2026 15:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412638;
	bh=v0K5Bre4dAzNqjJVv0l1Pcm4gWQLb5+uRk3BgjGFdJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGKYRwM+JRlcRZ30xoC/dDAtlLxNimnbCI7bWP1nZ/RO29JCwoFSEfzSlxPqvkkX/
	 VrFdtTaIXZ7daK8VIOYsspCe8T3jxVXL1dHBSVI8+4FvXppueMEpf/Nz+O1RNGFTKm
	 WNIczlLCMwg9VD86CayPt983uNEv0i22ShXT+5kObPLlS8OtT5e8Rlc19S9jlOcITP
	 0NVqA3v0ageg0Sos2FtIInngWSslAlzf8xGzDrGt1Zd3CmLr5apGO4/zPrcvUbMahe
	 f0aOXEMb9u08DkbGmAOwg19ygu2FUk6Cww+i2Z04uZogdkbsif4dLL4ZhTDSRRjchg
	 q2Nn3/9V7E6KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ACPI: APEI: accumulate the queued flag across error sections
Date: Wed, 11 Nov 2026 10:57:16 -0500
Message-ID: <20261111155655.2806263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052116-failed-6.12-f341307a1489@kernel.org>
References: <20261107052116-failed-6.12-f341307a1489@kernel.org>
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
[ sashal: Adjusted ARM handler context for missing adjacent CXL protocol error handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 03cf3d63e609c..045acf13c1313 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -583,7 +583,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
+			queued |= ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -809,11 +809,11 @@ static bool ghes_do_proc(struct ghes *ghes,
 			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev, sync);
+			queued |= ghes_handle_memory_failure(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+			queued |= ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
-- 
2.53.0

