Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049496;
	b=fxZ0tfL62fzgpa7oKwnnfKocxO5O/La+fuSTGPy7sScLRyaJLLGZBORAxKRD3lD7LWyA
	 mRJw1WdaCS/FQiIhYJUfA3VyjpFJsVmS23e8KD6j9mpT4Hcvd4ZulNJxXhdytVc9MzO8x
	 hGIBcE9wdhtok76+9DUdgJFoQWGJ3BAPyFQasULlbHp6j42OtzfSkgWAoyHWNyr0z6tcV
	 gjsO7ZYhTtAApapZJPU5eVeq3esft6jptDfDDKVHXl717pgomhJYs/6U0jHBPinXXAEOA
	 VWenRtf115XkbKMIbPtK4fA5qASCSm7aQxweRBxWQFtuaWfJOrVnGvLooRNXWEEMHYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049496;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n9wYlwtKSf9nI0vshTNms41ir7MCrAkgrPC5TqrJSI4=;
	b=LlMn0/DwAA8fSXpQKDLelFik51TBSMFH/35xAYA1Hhc/AbBgskazzlhWreR0gMUXE7Lp
	 qnQDgCsxzmnPkUw7SL+fnvLi+LrresuV990VE66ycBieY/0BHGLq81+6uviC+BzhA/vjx
	 kHE5X6R0wIbWqNYTLs37yJMsJIgq/nda8RZXz8hTmN04EulsUQsoI1uKvytqj5dDrX8ZC
	 93JtK7gobsn6lgXTyF/EPq9c5PLvCm19mUuFY7sq2cvDGmf5UMtCAnYAhZEtBzwkVizWJ
	 Khkw+f6vCYxsdUaJsC2KmRD5CqDAyO3cMcKtseMZOmWo6gQxyRMAKvDVNxADtuZ6y5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN2znav3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58CE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN2znav3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511DD1F0089F;
	Sat,  7 Nov 2026 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049495;
	bh=n9wYlwtKSf9nI0vshTNms41ir7MCrAkgrPC5TqrJSI4=;
	h=From:To:Cc:Subject:Date;
	b=YN2znav3I3Ixyu0LuDwhwoZM9yov6DKGlahKXeU0eDxij1Ohc3Ani7Los8dn8y1/v
	 kT7/mCsy0DHoti8NkOEx7EYdgfI4ursZ2alSOfPfkBjVLnNc0Mu71fOlTuEwCVcB/K
	 TqlweY2YtNUijwBL33cwvzmfYgyONKxBVDIeCb1cV0BOge24JvUZMuEhVRyupjDQKD
	 xikex2MkOXcv0BoIAiUfpOM/JasJVATOuvsvaTP05tZZovpFCx0TyEYX6JgIxwJzJ8
	 +73fNPzmF0PDU8cn+e8V0v2rXZ7ELYDb74ABq2ca/tRgq8ed8iJUxFQC2mB2daLPdd
	 V9AlOC8J61fdA==
From: Sasha Levin <sashal@kernel.org>
To: mario.limonciello@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86/amd/pmf: Add AMDI0112 ACPI ID" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:54 -0500
Message-ID: <20261107060453-failed-5.15-325bcc126cf7@kernel.org>
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
git cherry-pick -x 325bcc126cf7a512a0e2da0efddad665f69badac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060453-failed-5.15-325bcc126cf7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 325bcc126cf7a512a0e2da0efddad665f69badac Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 26 Aug 2026 11:36:11 -0500
Subject: [PATCH] platform/x86/amd/pmf: Add AMDI0112 ACPI ID
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AMDI0112 ID is used to bind the PMF driver to some platforms.
It doesn't have any Linux side code changes relative to the most
similar AMDI0105.

Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260826163611.2268377-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/amd/pmf/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index b4eae65e675b8..5966190d1496b 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -454,6 +454,7 @@ static const struct acpi_device_id amd_pmf_acpi_ids[] = {
 	{"AMDI0107", 0},
 	{"AMDI0108", 0},
 	{"AMDI0109", 0},
+	{"AMDI0112", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_pmf_acpi_ids);
-- 
2.53.0




