Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049462;
	b=W6uWANSuM+Ufn+IGNC/g+rV3CEGRhapPQ93WedVzAQ3zCcwe0iIBEBhLQ7GURD5XQ5R7
	 Ch/Fy3kwaceBv7wTY5azLLn8R0qlxyT1oIyC8Z8fuomh3zcTWjKMkUiBAyQSPHyuOLxJ7
	 po7+sJbjcu2G9NJJjxIrVUjsR3+XbPDj1OxFEq00uX8nr0UQMa5LS0Sn3OOyHdB+n3tHr
	 /pzu+KG96YgI5Mezvz7zeOA80aIPf72I1awujm9ov5yaQ71hE1hvaE89Y5mPwfOIYC/Gw
	 N3BJVw8SsRUlb1rIGWENn5PdHRRqx3dqxzrJ7bpM4wdf1rZ0oqyMVoWaEd8wK8nXgjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049462;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QepDhSPV2L6mTy6UtHRJvyL8oM1gqHC/pi8A+OEYcaQ=;
	b=f6HXQCToMJw8g163Ej7qgeumnBI+9/eRi2jmfE88M7EmmoRtvwO2/fcTHXo0RB30OzHN
	 NyVIf73dgBGjUx1nrhhgcuzof0LCPftYTCWl15kmLeo0TRIl9GohA8vSoGNsifrPuppWs
	 YY1TAByUnMFUFnw0Qy+XSKummUG9gwuNvpzHrhQowinFL7KyD4uEeiygT/a0NTWyvnlFf
	 tM2TFyNRZDisT7+90D9oOomz7wQH4WXqreHSJdFFz75rfWSnM5fyWz2WhIbNVsGem+pSv
	 6w//WDS71Rmw7+l5q1/U/yvAnl1mR05IgSmMJWyH0wP8xrGXVbWQY4O7OXT3+2Fqo2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8rP2Cxo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476A606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8rP2Cxo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5F11F0089F;
	Sat,  7 Nov 2026 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049462;
	bh=QepDhSPV2L6mTy6UtHRJvyL8oM1gqHC/pi8A+OEYcaQ=;
	h=From:To:Cc:Subject:Date;
	b=L8rP2CxoD2qM7A5Sbj/FkdF21lrTIPk5cVv2bDTq4s1AJ6PA3enNuLC8V8KL8hljj
	 7lmR33c7JJvOL0L6irhwOZDM/24PyJfbwGIlJ9kKFvGSHdb2mKWpB9Jm66vM1URIBZ
	 qj2S7QeUgR85phqXr42NSTlXKJQIUcaJTkdtXLqrkscJrfJCfvB30oNa0eAi903jVt
	 G1VG2MZ9Oiy1qdUn9beyeSfcG1/pq9suh6UALG6bBvSMFk9788xX+uu8JRhi4C3laX
	 24Abqx3pnHAaTVh5g2VuGxr8kmuYPLV51bNPuGUt5HzmAhZMd7P8gOsSlPm2ALjGof
	 7G/fvpLkVPvwg==
From: Sasha Levin <sashal@kernel.org>
To: leitao@debian.org,
	xueshuai@linux.alibaba.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: APEI: accumulate the queued flag across error sections" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:20 -0500
Message-ID: <20261107060420-failed-5.15-f341307a1489@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f341307a14895e5da056fb419a31ef7fb534ab18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060420-failed-5.15-f341307a1489@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f341307a14895e5da056fb419a31ef7fb534ab18 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Fri, 25 Sep 2026 08:09:11 -0700
Subject: [PATCH] ACPI: APEI: accumulate the queued flag across error sections

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
---
 drivers/acpi/apei/ghes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ade1cc8c9f8d1..663dc2e601cf7 100644
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
@@ -1000,11 +1000,11 @@ static void ghes_do_proc(struct ghes *ghes,
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
 
-- 
2.53.0




