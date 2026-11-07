Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048447;
	b=tFbVBaWkG5AOsGzWAPF8Q4kvUWcYfcMnr7wffFxPmzgYY5PRVcgIHn/Iz6xodwn5W3PO
	 wE8AlgcqhvJ1rshnWgVDnUnMde8X9FiPyNoYqbz0eSwFGQQ32YxW0qXf7n/XHqsvyK8vj
	 hc+JIL8SzHEkUk9n2uBQaE52xV23sixs/lWCbB489jtvAmUWErKXU210kllAygt4gdOPs
	 NYkBUNhvz4bMoWv1vcIY3Y+tvK7RdMXuucu6y0jJ1GZk/F+rDNPvMsAHCMaq9yXLYoIkH
	 uSPmFy3Lr3e9Ct4av63Yi1YPqiXG+fISyhYyV9M7nfEyL9VNri3LNab9q2SU028+VHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QxAO+pRwdGiRYfdVEAWBl5AGr6w3j36TNWvtAj0dzuo=;
	b=G7uVw/z0ZhpWXZpdy8Zqkx+2FCNLLp9Gdf78Y0QVxsjON2QRgV/XbHhEIjqL1S86ZxOP
	 ei5i3C7VcuNVZEYJXArSmaK9qdndbVqVo8EYPBNihdf71TQDYaFYb8jtEsQM/rZ8RAqJb
	 Od46EUjyRQK+K8wYlwVVNs4xMXw71BXvuwRDxmwNT1xlyLohHQ+syIfMIEiwaqSwFAIZI
	 L3EOxwoZSlc6ogH0OvOXq7vh5nTS7lXFa/0W6gNDQV1+RLtq5k5wBuv6YQ8RVUTGMX5qP
	 DvKV0DaZu9oAQ4nh6LAVaCZY9FffCn3JeBw8Ven5g5ycxEYOoiZkv+kxhdFHCv5ifjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UCHOR/5F";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA99606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCHOR/5F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA501F008A6;
	Sat,  7 Nov 2026 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048446;
	bh=QxAO+pRwdGiRYfdVEAWBl5AGr6w3j36TNWvtAj0dzuo=;
	h=From:To:Cc:Subject:Date;
	b=UCHOR/5FfhsmOPEp3vBStAlRMY72LMZAvo3rLtS3eR8Tp2b+BoaG6Tu0bu9qQMPUQ
	 oQsPkAhaHID7ZdvwZw1eiqqXdHOWCvBKFUkjoE5oRFzIMiyCA4DTUGsWsyMf2okm1h
	 UxhGZu2n9+HWA+IsHcveD3yy8KjyVfyoyvxKEPLHFZXKuHS63Y2qoA8z5Efh8gBNtM
	 z0k/gIseJ+mI+cXB8yB+VB6vkfym3xwpxM7WVwAhG3HcIeu8Ger5GgyCK5Lo7PL8UC
	 Z6BjPLHRcdBMqOhZX8SVumotzRBkrRX0VdR2SObrYVS22EOVmUgWWmui+2AV4qzYrr
	 cBuvOWHOCcLXA==
From: Sasha Levin <sashal@kernel.org>
To: mario.limonciello@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86/amd/pmf: Add AMDI0112 ACPI ID" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:25 -0500
Message-ID: <20261107054724-failed-6.1-325bcc126cf7@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 325bcc126cf7a512a0e2da0efddad665f69badac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054724-failed-6.1-325bcc126cf7@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




