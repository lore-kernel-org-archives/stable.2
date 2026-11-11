Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413723;
	b=H6FTn8gZjEeKIQ62u0UAZ9IR0xuS2LitoaTNZTVhy+btdDQHCSGOwfPDKE77HHXivavj
	 7mlMr9kXoXhWT8DnY/MZoJ5pBAxK3uH/x1zbACE32nj8BmOT/2EbHZv40wI88bNhBcpjw
	 i1CyjD4SWa61NpefuexbkMLZsed2YtqM9ftjuX8zNU1i8FYj92TUmltwiqaL2uopMU5ka
	 /cR9ocv3vNLhOaPApDEVuaiguqeAAnKyhqbmMea2YSNRZcnMMmIMpp9D1CO/Alc3x6IUZ
	 QvJqZBnWzKdpXBHa8Mf7fSRhnG8Qdsqrha6cpvaUn1xEz0qZ0x6gUqY457unRL9pUSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413723;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M1JkT3Z+DDFJJ97Db9IK3mgsdiaCw6BZO4UpHNB89r4=;
	b=1CKciVcCLMc5WNyRMtI5MJZjqlqPoN7w1jfIVweO9coq1Kk/tdXkfWzD10MofzjI/hCS
	 E3Jkfzja/YL5aGDebJx0/BtyhaFT1wXUrKnDO7GCckfkpRumix725dDrDf8twYBmRJvDA
	 ZNyyIABlNlSL3uer5RYbMWkrPVvv8odObBGPrNSqN8jLxhqf7a7zXZkfdVqKNaPFAVVkP
	 nfUdMvnj0ukvV5IyVLTc6uWSxoQ1JybIy491iWdrTs+hwDeMD9mkXcNFFljq2esHlGwa/
	 REVCrmTOQk2dZ5kjqAqFZzyiYxVcSmLPEHh60oWJp6uSNxHD/dZg9aO2NalXDpOas1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHRx4lU7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB2606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHRx4lU7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4451F00A05;
	Wed, 11 Nov 2026 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413723;
	bh=M1JkT3Z+DDFJJ97Db9IK3mgsdiaCw6BZO4UpHNB89r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHRx4lU7etS9GtLB/SDlYIJQx4axr2ZRblsmWTQRd5QS+7e7pgxIpLReZKbbw0OXz
	 pfK5ReJQ+ybax6nhutW2eEB5Vk/sm5EC/PtgLpIgHYoc3sz6URSAYHSA7CsqnDdE8W
	 xexvu4CabJ6Epsfpk5TyIXP9vB8yoDfVrEZkBf4CXlH5T53lJjKN7Ho4hpx8AJCJEF
	 vt+EyOyDT+eeDtPPPPV4X/IO/xjGt9T44JVbCb4e6zw8BDXWM3EWcjDeiepzqxs72C
	 0OBX6IfHFR+gzl7J2hqnB57HRvHjruN/DM+xpLe3DXC/rA2mdzySvWiu9h9e8rhXd2
	 RMoOntWPd3X5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ACPI: APEI: accumulate the queued flag across error sections
Date: Wed, 11 Nov 2026 11:15:21 -0500
Message-ID: <20261111161509.3259382-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060420-failed-5.15-f341307a1489@kernel.org>
References: <20261107060420-failed-5.15-f341307a1489@kernel.org>
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
[ sashal: adjusted context to match the older ghes_do_proc() error-section handling layout ]
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

