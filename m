Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046238;
	b=1lJK0DAHf5GNbSzBMFkjrh0rWSpGKG/TtGqjBmBYrzkzc4e7tlAau9XHxDtOfmFQ3Aq0
	 nQmzAuejO68qmEzJL+n7QRAIRSCf1VrjoiBs7IhA6jQl5w2uKTYp+xFGjs3kR4Seu72mV
	 0z1U6N2vRcX6PYhuc2w8kKEMmOKTiJf7SJjFirZc/YUVYjilDqmi+WSIG+kGq7q6Av8Nh
	 p77gAK/J52UWjBd6ziWFP00f5k74dmDAJI1M473BPdjvXyKp4kwmrG8q+5ARlw1UY7o3H
	 tf2rtRoJDCLw3h3xJivh+sJFk/xyhztQgoygmp0S9Layv5tatJ2QQ2V/7z1VhhHCATA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046238;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=povoQKGbx7hmk6a1etFnXxWDZVyEvOxeZSqLGs7wu4Q=;
	b=aD17gTVqcwntkSEG9DzhkWV+KVGe0yKSMGBSsa36HbuwV26CMGjgPUIDYuneZy2cnleq
	 UVLoO4h1P1OFGsiZXn3KWQLqNfe6C48XYi8iSyMtLnbhNRbSlEsQVmd2GPYmtHz9cIcxg
	 S5X3sV4UzugvXywqn1tZYn9gdM373COAjv7oK+I6ueQ3S+EZfaX9urIf9Zo74DUgKqYr6
	 dJsdbW6rYnyXwA2bTbRcje8t6c1b7TcBwMpLoeqK9QvPUQTqO1S2omJ/POXP6TNh8/vkK
	 pjau24kE3ysEFbrdU2EbU8vYIXofgeZibf/qf134GQxDK48KCg+0IcpiQV7tOrWDyLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8VdG5+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91105606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8VdG5+F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091C41F0089F;
	Sat,  7 Nov 2026 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046238;
	bh=povoQKGbx7hmk6a1etFnXxWDZVyEvOxeZSqLGs7wu4Q=;
	h=From:To:Cc:Subject:Date;
	b=G8VdG5+FnBY+bx/1bfvbGMxiXdixHmfYnA064cSQnKGXDwXM2wSlVtCoo1T9FEQoP
	 ZUSNMsqxCC84rOFMFi+ePVlkhBTRsEdFbc3p6kGag0akhkcLyjWrInpKgYv+ihFedo
	 lh6mKhsNY70hq5ZFkL7nb8JE14+cZdWFvP7QYXH5advJ2TrQ3/r9MZ/RCbqdrjV8k6
	 bajonyHEZd/xyNZyNptTCT/2Muo+MzrSgRMJfKM4L0L2HnDwQemH1EKkNpFLj75wVM
	 Hena5by+YlNI0RJd5xzo4DyDm0fMb9aWaNbZKT+a9g5ISUB6czo1bJVPr7nVduwAg/
	 p6Dn/CsgsApDg==
From: Sasha Levin <sashal@kernel.org>
To: mario.limonciello@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86/amd/pmf: Add AMDI0112 ACPI ID" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:36 -0500
Message-ID: <20261107051036-failed-6.18-325bcc126cf7@kernel.org>
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
git cherry-pick -x 325bcc126cf7a512a0e2da0efddad665f69badac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051036-failed-6.18-325bcc126cf7@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




