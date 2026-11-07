Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050496;
	b=FpvMWqM7H3BgHuS4PzLQ3njQslh8/DvE4xfBG9s/va7FdwjG0RYk3f+8nrqM3XUpL2Cl
	 XKLIaVaU9aSh/r29p+bssTuUlbbaimjNR+XrV7D3s20Ln0cpNnTlif6tQmOfLuXrQobRl
	 /zZkZ5LWezkiWGald7S3O1j4fWVuq5s9lOvRMe21nIY91JUUOjMChTdYfg3wR1jlJeoYW
	 2k4IhNvLk/uLgHkN7+a6IqRgUKxC3UnL9R2mBUqQtcPB/Wuc9bvjFrNjH0d297oaTNEey
	 aHvuYuokaoohDPa8NHnfLRKPjXVQg06TnfkkuV/SE3fXZ9Kw2vTgk0NGrqWj5DUFmJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050496;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6dCr9LfP7M5qpltFTiTnl6QMQDnWSNhOqn8CqIN1uY8=;
	b=xnOGfc9/0rm6YQYPXF9OMMzs9Z2qqRgcFB0wPA8Y2g9gFGI9XzmBgCf0ngP7UZJ4Ht30
	 OeIs6O6vq9fHCmm+P1tHuev8yiVp6F83+Sme2tvOYBg4H4SWimQUi+xzMBA5Gz++RfG1o
	 fusOqAePQsw1Veq16vN9IrO8BzdcqfldriQxGzrdowPw/22GpzI+c795QGVdlm1CuCZnI
	 gWccQ5NB+U7J58bvM5ieSn+Q9/vp8NEnYEM3SsAKycubg/m9N+1Wxs/yXWer06Y6Vn2BO
	 XIQD9kWXfyo0lwHWL5W2JVHIxt5ipwBtKDjxQvQhj7NmbJqaew6CYPkGmEVKzSMmP0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfXIqrZK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00992606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfXIqrZK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738331F008A5;
	Sat,  7 Nov 2026 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050495;
	bh=6dCr9LfP7M5qpltFTiTnl6QMQDnWSNhOqn8CqIN1uY8=;
	h=From:To:Cc:Subject:Date;
	b=TfXIqrZKEaGoJEdUWxXtyD+9EFR+Of6e+AOJdxqJOSxdR1Z/twNBJA0V6qccRfXek
	 hNWIfEZ00ZBve3tAjgY7AhxYpYXPcPN4tI4XjI3/1pKeA3Ffi4Naa0f3RCpfZ/LnRS
	 XVQqpW7dhNYC1R3dau+iPofeLsAfe+WbPDyVd1aa6sNQJCEzpeYUU+bXmBJLorZE0Y
	 fA7vxukMUMqWSxziuG05ktBJ9XptQUWaL76CtlViFv+qzwbYfHIKcqzUPx20CTSECG
	 RhMhX/plk/lDuMIG6wx+5f8B+PBXHSbAqhCIugkreymRgGe7xeBGePnJTQgJlrbztW
	 EB7IJAf9cXLHw==
From: Sasha Levin <sashal@kernel.org>
To: mario.limonciello@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86/amd/pmf: Add AMDI0112 ACPI ID" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:34 -0500
Message-ID: <20261107062134-failed-5.10-325bcc126cf7@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 325bcc126cf7a512a0e2da0efddad665f69badac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062134-failed-5.10-325bcc126cf7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




