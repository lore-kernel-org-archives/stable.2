Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9E344DB7
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316246; cv=none; b=jsmGQqbjAVlYG5t0l+r/8xTCaXxJTRRikCV2KWIV+lIhtASDnbDldGUKvbg28d1usH8FtafvShOSL/tjwHqQCD0IF9+pFwV5PQeMO4KC+IyAfVSzR0g5ebRSizMkmjhOB/RhLlZLCsZTcjgb62MYYNpmU/546rpN+2HgednsH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316246; c=relaxed/simple;
	bh=IPL8E7q/6wpBe5cEFL3yJUGacPI8wVEmEstq0HdNQcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JT/LIXCbjF2e4eMBi0z2c4dzanIZwTMNqMVd1taZ/MPKoTLRcX0B2rR41rTDbXcaYNi4o2faQ4dU84LEal1cJ0627g2FaeiCI9gu6dOKQ4Q9z5bEpuWlpizzYRP5AOGEEH6LkpuPzqq+PSEGVj9ayMGQv6UImeHGdCkv9sjpK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfJUEecU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfJUEecU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3FA1F000E9;
	Fri, 17 Jul 2026 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784316245;
	bh=cpi7nJuEacgO/2JNylh/1exy0dIrrJIvRsWdLdcDBec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfJUEecU4SqD1vKqJnk0/NtX7dO4/vlf3Og/igaz/Nnl8kGNYDvkpoYoUNRCwxfbg
	 tyK3rdaICy4SAOfg0nYrbwfaUAkU+/odarRaPmWnmZde12NGTm1nWdrV2bADfarOPg
	 xpzfNIVr/XUXW74V8azHe2n6C9Ryo5z+i6PSbPqhJ1uCJlhWYOhCQnYfnayTYfD6OZ
	 ZlIT86ql1q6gWC5vqMHMKdwox19hVVtxsdxpLvrWNrp71aZG8UPc7bk5m+eP8XF+AU
	 DyWdIG0iCYuwYZ0HKtzApoXMEl5dZnArTDQ4FVDMt8yeBMFlXm3Efoqyn51t2arQV6
	 scfKD8ow04mxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] HID: pidff: Fix missing blank lines after declarations
Date: Fri, 17 Jul 2026 15:24:00 -0400
Message-ID: <20260717192403.2131944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071445-promoter-disburse-fa77@gregkh>
References: <2026071445-promoter-disburse-fa77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit 42a2bd61650f13605f9283b5a9e6b1a26b7d4ec2 ]

Fixes chackpatch.pl warnings

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: b251598b8bf3 ("HID: pidff: Use correct effect type in effect update")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 566eba0e045fab..f6c294a0a318ca 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -249,8 +249,8 @@ static u32 pidff_rescale_time(u16 time, struct hid_field *field)
 {
 	u32 scaled_time = time;
 	int exponent = field->unit_exponent;
-	pr_debug("time field exponent: %d\n", exponent);
 
+	pr_debug("time field exponent: %d\n", exponent);
 	for (;exponent < FF_TIME_EXPONENT; exponent++)
 		scaled_time *= 10;
 	for (;exponent > FF_TIME_EXPONENT; exponent--)
@@ -354,6 +354,7 @@ static int pidff_needs_set_envelope(struct ff_envelope *envelope,
 				    struct ff_envelope *old)
 {
 	bool needs_new_envelope;
+
 	needs_new_envelope = envelope->attack_level  != 0 ||
 			     envelope->fade_level    != 0 ||
 			     envelope->attack_length != 0 ||
@@ -733,6 +734,7 @@ static void pidff_playback_pid(struct pidff_device *pidff, int pid_id, int n)
 static int pidff_playback(struct input_dev *dev, int effect_id, int value)
 {
 	struct pidff_device *pidff = dev->ff->private;
+
 	pidff_playback_pid(pidff, pidff->pid_id[effect_id], value);
 	return 0;
 }
@@ -1233,6 +1235,7 @@ static int pidff_find_effects(struct pidff_device *pidff,
 
 	for (i = 0; i < sizeof(pidff_effect_types); i++) {
 		int pidff_type = pidff->type_id[i];
+
 		if (pidff->set_effect_type->usage[pidff_type].hid !=
 		    pidff->create_new_effect_type->usage[pidff_type].hid) {
 			hid_err(pidff->hid,
-- 
2.53.0

