Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047646;
	b=EmIPSXsKft857NNie16aWduodaqnUFiR8TvWaCKzTqL8846sIn5qC7MRC2iMmpTiORSe
	 DbPyswoGuKE8+Eqhqcn2lFfpE3ErKWVKz5ev8JH+511bcPA6mMru5ZCcwKHxuFzeBDMGd
	 tDmEBMYvi8ScqkWr8LkO+DXDKP7BgHNnQsXNM1r24BRkz54ScQ4+smr0h1rxmqfl0w5VX
	 HIC1wnFmaHnqQTWQHKjvmSKmU6kQ1YCflC21YkQuUWGyyg8T8CFwlr5iGrvl4AGuB31pa
	 1TlKFh9BpWdMxFA+QnFl8F1qzYKOzWfDrGGxAn1HL+pzzdfnEuTs3QwCWZwuZe7MTgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047646;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=En9QPARRURzu8ByYaUYalOGOgVr/ZkCIjBwMOEKN/J4=;
	b=Aof78tKAlM8CSMdaZslNK4yKephy3s7NqOa8bOH7Gs4xnQMKqoZqTzjwT8X/esxqz5/K
	 MSaVvziRuE09v1ptw188/cNdyCD4hsNdr8p3oyL6fOcUa1/6801ieYikecK0SGp1+yuAy
	 noV2N88qK2F1s/Av8HeusoxYgxeET009zs1JAQiqYgB/pnHkiHOe5y2m6okRbicVkvaQz
	 drlL/B+9//6xOdhcrOHftT6d9KJMyxYBZVkLL9Nl/UkxCfA+Ylb6dZ2R5M8DGKgydyAV7
	 gcCXQRCwvKu5rZ1g5eUQF5bmgqieVm8jxtTe9ZghIEKT0Hwu7wdmmVFLFCtCzfGHtYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzepTDue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzepTDue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F78C1F008A1;
	Sat,  7 Nov 2026 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047646;
	bh=En9QPARRURzu8ByYaUYalOGOgVr/ZkCIjBwMOEKN/J4=;
	h=From:To:Cc:Subject:Date;
	b=nzepTDueJJODpqbAyGW3e8lef9NbAG8qsP6NoEK7f80nXu8NsQYsbWQ+O4PjTA6A6
	 kY+LKhSWokOemW5Hv1xVmcgyr6FaPDtJnH4xtzVhatTxnSfPPsbFivEiAiIwtHQOA+
	 u56h57T8ApYSd7/Xi+O53OZ6QyLQbXHNaq+os3SFMWF6yxdbQUBv9VXIQjteH01KKW
	 exeW5DAyCNRslPLsiVbAE1e2SpCzieA/slaIPKQtmUpvSDkh8LCXCzY6gAyz+DVzUG
	 JAzOOlxmpoUbwHsNcBES89Ue9q6fTwS1aL9kcjNSDI0Fek1WmfUKM1YLACIgiLUtN8
	 lbBPujB6M/a4A==
From: Sasha Levin <sashal@kernel.org>
To: mario.limonciello@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86/amd/pmf: Add AMDI0112 ACPI ID" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:04 -0500
Message-ID: <20261107053404-failed-6.6-325bcc126cf7@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 325bcc126cf7a512a0e2da0efddad665f69badac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053404-failed-6.6-325bcc126cf7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




