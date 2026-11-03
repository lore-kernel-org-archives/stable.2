Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689088;
	b=yuycVe9GKC5k8u99CiyBUcSPV1KFEa/z/1d4EmwNt7MTIsjTPFaELXErOgWIl028W6O5
	 OFA6EELFySj/npjguGqomv0xWGZk+GiNhvVe7r+3EttDY0VObr/nGXmif/qC77+HVs9Eg
	 t2/XlErsWVz/vHR/sKWoTA69g/Se0FzKthrHPse6EsnfAVmzwK+IuRaeA/QQ1QUAJZtHP
	 D8UgVoqeX/t6I52vzUxOyxt4RszxCbpZV7X+Uu1ehXweUTigk5H1wJaGMK8gCvaKgzGKm
	 PS4+Nuk6+gKLus6DAiPHcfbhWOXfFVv9ttcPwM4c6Fk0i0PbKkJ41OH+7tFgAsWaTvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689088;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=4omSNZFU8n6e/bCufwqMpmwrJkXGiKO2sJtcy3vHDHI=;
	b=fBumlS7I8RrLujE0SDJJ+vcc5ko5b12fcEdz2MMmIaRBzvYly4PlUTxIEsyD5QrypnIl
	 Lz6IbaW7S77byVyEl24uYE631dVY/HHfteKRXqqN8VhinDms++vYXaeSfGeyrcOLUdEy7
	 p221z872QNb+l6dgr5JJSDzgq42fIWaQfv20DvWHZrlwAg6GSFbVgivI5nQTTsDt/CA/X
	 DhnmDYxI2y1h+sSrXORGmnCi/0Au61KDeqzECWeT7VPOjcuusHSgcbBn06DVwwsaXb88K
	 OTyQjlx3vMwzTURQLhIHVQLMTrpNFiDkMcJRnt+qQ9V9HGs+7+h2rHhDQNqU2xciBMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63287606A329;
	Tue,  3 Nov 2026 06:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63287606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnt5j5helqZ5Y5AA--.344S2;
	Tue, 03 Nov 2026 14:58:01 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/pm: Balance the runtime PM reference when ioctl resume fails
Date: Tue,  3 Nov 2026 06:58:10 +0000
Message-Id: <20261103065810.1075142-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowACnt5j5helqZ5Y5AA--.344S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr18KF13XFW8tFWfCF4fuFg_yoWkWFb_Gr
	45Zr97XF4jgF1DJwnrAFs8Z3s2qFy8uaykXF10ga4fJr42vF4DX34jqF1DZ39rJw43Ar1D
	t3WjgF1fZFnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmeH
	gUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIAA2rpWwqQZwAAso

xe_pm_runtime_get_ioctl() uses pm_runtime_get_sync(), which increments
the usage counter even when resuming the device fails. Its conditional
runtime PM guard only runs xe_pm_runtime_put() after a successful get,
so failed resumes leave an extra reference behind.

Use pm_runtime_resume_and_get() so a failed resume releases the usage
counter increment before returning the error.

Fixes: 23cf006beac3 ("drm/xe: Runtime PM wake on every IOCTL")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/xe/xe_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 4f1035ab1eb2..52c2a15e642f 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -860,7 +860,7 @@ int xe_pm_runtime_get_ioctl(struct xe_device *xe)
 		return -ELOOP;
 
 	xe_rpm_might_enter_cb(xe);
-	return pm_runtime_get_sync(xe->drm.dev);
+	return pm_runtime_resume_and_get(xe->drm.dev);
 }
 
 /**
-- 
2.34.1

