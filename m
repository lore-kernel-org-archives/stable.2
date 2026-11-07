Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046217;
	b=wKl0QnAGEtDafHT9aPcm8d+5YLiczOows/cZfJqCNhcTDJ/2/WSVulmGODnqHdF98Nwp
	 XpByHSsv7vcKNevAqR1DjXm42Mz7+d1FXotjAhCmHj3Fx2axM1SSAD6o7PdzhjnPJlO7/
	 38qF2nKP385pdz5XRjOZPfa/+wcyrEmi9ZkjE/hV1YEiDB+VCGqEGgnuDUzQ4zQPA0/vA
	 1Do8QBPLFo8so8eAkfrL2O+NI4J1xN/Qgzw4Y6r5fv8JcO3d/h6BQJT72z4J952eQbVlk
	 f+DF16Z+X6tlu1YvRzGNZVsk7IftmfLoGjAyBrl3SvbSGm6wZWd2fkY0ddPvjfX1WvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046217;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kLSFpHpu/Xppobr7G+z/55qcw8DoAFm2MuQRmbZExUw=;
	b=S/hf99XfvGuw8sVlWLAhW7vtn7BrcZghv2dP82LS3JIE9vAwFq64HkbYFjs2O8SOF8CZ
	 UV+G7tPKsk47qEMuj2RgFYmxGUCg7Ijw/kQVYd4vU94g4IxSBjplMEhMjSQnHZHEkCI4D
	 TWXKOJvfCtIRk5z1a6RmaRcd6g/GdmwQ5odN5Q1sV8IpossdcpVzb3XgGgrQnxEjhsc+8
	 lSYhxd/LqfH94PGrpaHX2sQyZtm9zqMP+ZoJDPHW/58N2ggRKJsq2S4EVQ6RGwUFSSmWi
	 AACvfTPTf8yEKgleA59twjetVKppc9MZYq6nF1pHomQv8wbXB9qO4kzGFDrOE362UPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcikHNTc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcikHNTc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8DA1F0089F;
	Sat,  7 Nov 2026 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046217;
	bh=kLSFpHpu/Xppobr7G+z/55qcw8DoAFm2MuQRmbZExUw=;
	h=From:To:Cc:Subject:Date;
	b=GcikHNTcbLymlrWk83AZJs1WJrCnSFDGdeTSKPB+dLNSCGXddtGW/FxvOYqDBWEQ3
	 fL7ODAFtaJ7oo7Ji2Jgardad/m03mVMt+wOQRhWyQ0rVkHQwhIVgP3SCQmUZ4b4dLz
	 ei3AZv/s44KOxMmuYcjP99iJo1q/VjbGXPMeFkKbsseFsQv8jL9u4TGpBP74zfr4f2
	 xRp2QU28HaC+PrFRTsl68XmB23OaAlAzuvXBbY8Wm3M0l7duuHsylXexm6RWKZjNr+
	 P7cIGOzXbbJ1jz0T2WNomTja0OCEX+YM+8aNAjy1ZbxAI4orDW6fikia0MVs58ulOI
	 ayIL8wW8QpVjQ==
From: Sasha Levin <sashal@kernel.org>
To: leitao@debian.org,
	xueshuai@linux.alibaba.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: APEI: accumulate the queued flag across error sections" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:15 -0500
Message-ID: <20261107051015-failed-6.18-f341307a1489@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f341307a14895e5da056fb419a31ef7fb534ab18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051015-failed-6.18-f341307a1489@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




