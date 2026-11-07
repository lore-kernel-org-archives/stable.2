Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050509;
	b=PoXf0XnANa59KFA8FDghxl4tDwSFnt4VL7n59WN1HVYNII5TcyuROc6Tesx29ZnMvkfo
	 r/FzsK1PbrWIKMfBZvNz9rireUU6pz5HCjcHeCivBbi86vNAFrH8VPQrNakoepcBq1EEC
	 XKoGMyZFseUSTs+YCFU8QAmtGVP4nVdYHzv5hDU6RtNBI/z0PMzW7urWrM3PPg65QddJm
	 ClbjvpRwhWZE6TKpiSq+CGVWkXVjTTt1F/tbXxZ9v5aGLz/TdfCN/93C7AYb3xRCdRd/H
	 gdshp1gsqoahjxDbaNQDWAWgb+uPsi9bgd5P9qTGiIpB3Ded6SBK5bM6nCWefNqA0+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050509;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+0ECTfTOEDneOiCVNujN9Ijo5OnyRY6kF4HXDTPXp7M=;
	b=IJq1KguTMeIyU6TdvJ1cO3pjm8sQ7PhUjjvPrUxnOUgLZ2SQXqwxGrLIHrt5DQofgCwf
	 njWack7Nwbw2w03BPiOx0zqeVdXDAlk6cKgq+HI0B130ONEr16n43dmkSwOx9YDFgazxq
	 /aOjJPnG03p4i3neNuKpq9LDUl9/NszULk8KLFoAo1B0+5WETWFgskesIZb1DPRo62cmD
	 vDL5jMGr3eJqTIG0j1fpJxYxbIo1zFSh6R4B6bSB5pjdIGHXvRgedfZ/KNxGLFc/lawdL
	 ZVbD9+EQUJ2DiSsC13XwYAponExH+2qmALV+hRO3wVObxvU0jThEQJDp8zRWDtdWXaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIffVasJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04390606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIffVasJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B481F0089F;
	Sat,  7 Nov 2026 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050508;
	bh=+0ECTfTOEDneOiCVNujN9Ijo5OnyRY6kF4HXDTPXp7M=;
	h=From:To:Cc:Subject:Date;
	b=JIffVasJ3EoCmuE+iOFmuX+haZFrN1WCT7/SJbL6CBxSCRywtNgTuC2lT3JXq7ett
	 xTLtknm9n9/Pqf5ElJexbprDMttUTlyCC39+XqBYZRLnZ26IkWpurC9Jx7jG9n9gsI
	 HSygYkaN9vsXSbvkOW1TThLAcfQ0Nq+pcdToh6XYZaru9EjnFN0VUR6jxT7mwJp7v8
	 xj4bra+KxFIUsxTnjNmHQtiM+tDTui6oVjBbKuXrUB3ykuu+KA7AvATgrx9yj6NSRH
	 Vjk+IS6qHIGZbkXOv2l6PBgCBjsLJx4NezhaWs+bSXpwOybhpEbC2+5u0XsOLWVcvo
	 ODFgl3zDDxKIw==
From: Sasha Levin <sashal@kernel.org>
To: meatuni001@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:47 -0500
Message-ID: <20261107062147-failed-5.10-6dea092b261f@kernel.org>
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
git cherry-pick -x 6dea092b261f04d632411c2be52d13190f5f67b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062147-failed-5.10-6dea092b261f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6dea092b261f04d632411c2be52d13190f5f67b1 Mon Sep 17 00:00:00 2001
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 26 Aug 2026 15:30:12 +0500
Subject: [PATCH] platform/x86: hp-wmi: fix heap OOB read and memory corruption
 in hp_wmi_perform_query()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hp_wmi_perform_query() evaluates an ACPI WMI method and expects a
struct bios_return header in the returned buffer. However, it only
checks that the ACPI object type is ACPI_TYPE_BUFFER without verifying
that obj->buffer.length is at least sizeof(*bios_return) (8 bytes).

If the firmware or ACPI method returns a buffer shorter than 8 bytes:

1. bios_return->return_code at offset 4 reads out of bounds from the
   allocated ACPI buffer slab.

2. If return_code evaluates to 0 and outsize is non-zero,
   (int)(obj->buffer.length - sizeof(*bios_return)) evaluates to a
   negative integer (e.g. -8 for a 0-length buffer). actual_outsize is
   set to this negative value and passed to memcpy(buffer, ...,
   actual_outsize), where the signed negative value is cast to
   size_t (e.g. 0xfffffffffffffff8), attempting to copy ~18 Exabytes
   and triggering an immediate kernel crash. Additionally,
   memset(buffer + actual_outsize, ...) performs an out-of-bounds
   write before buffer.

Fix this by ensuring obj->buffer.length is at least sizeof(*bios_return)
before accessing the return code, and compute actual_outsize safely
using min_t(u32, ...), which is sound specifically because the guard
above already rules out obj->buffer.length being smaller than
sizeof(*bios_return) by the time that subtraction runs.

Fixes: c3021ea1beee ("hp-wmi: allow setting input and output buffer sizes separately")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260826103012.240453-1-meatuni001@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index bc2ada5dfa634..eeb66a7db346a 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -711,8 +711,9 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 		goto out_free;
 	}
 
-	if (obj->type != ACPI_TYPE_BUFFER) {
-		pr_warn("query 0x%x returned an invalid object 0x%x\n", query, ret);
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(*bios_return)) {
+		pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -731,7 +732,7 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 	if (!outsize)
 		goto out_free;
 
-	actual_outsize = min(outsize, (int)(obj->buffer.length - sizeof(*bios_return)));
+	actual_outsize = min_t(u32, outsize, obj->buffer.length - sizeof(*bios_return));
 	memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual_outsize);
 	memset(buffer + actual_outsize, 0, outsize - actual_outsize);
 
-- 
2.53.0




