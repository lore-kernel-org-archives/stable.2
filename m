Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367714;
	b=pVSmkr3eW5pZ/bJE5BbnUBtZ7KFycAGjdjAAC8oW+U73yR1EpsvBEVBKVbrLHTOj3jAk
	 NbDsnT3KQrR63Ai+GFDpumGBajDapSHHIZbU/zfKu5HkzFJdGyx51cdiymxldPXSqHlRs
	 /5vOVODuqwv7Fv3+202LW6YzoIyMZMm8LuflWIYY6QtnbqZGwpSUMIe2w3/ERWam+XHCU
	 IhCtBU9nJW8genytue/fIV0lFT5oNS8JSRvXMse+dRFq71f+LPcEmm5XoiwQjCyIeXliG
	 QlBiaUaWpGTZVgZTE3510eZTROJXr32PzbH9ors9n45kfF/3iMokKcQA6RglnC6+AXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367714;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0ET0SvvYIOzg75SSEBDjhPHKpFI1XtiWifSmgl4C9ZQ=;
	b=mIZ5RukJC7rL6ibYUpefctumXWk58h+xV41unUPu3B+RfFctI0iT2N85zWbnmU9DDYyh
	 wl6FFCt+SQ8xkpg0o6vVVA6WXTop+ul+il2Opy+uXVWime0BngOvON+eoPZKnWCa+6OB3
	 VWzy2cctmqfPet8yAcRv2dhCKGmNWjarmJLMf4u0utuFU3bP9sJyG4/6c46X9c8g3Jd9A
	 peVbc3YiFWH0U2zmeL3hrCBgucdiS60ch+IYCcYQxWpGaZ1tXvYJXij/G/lUJZdfTRyB7
	 QlpgJa/wQD/K1F3kk8FuwsxfHv12x2hBv1hhLh/s59wDlSCtlkKz8O+49TwxTS71vkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mKE3cIH/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD85606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKE3cIH/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01B61F0089F;
	Wed, 11 Nov 2026 03:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794367714;
	bh=0ET0SvvYIOzg75SSEBDjhPHKpFI1XtiWifSmgl4C9ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mKE3cIH/L/jWnmXLsiRfyxLH3eKiLNvv5kmTePwuyMPVAGqVX+uJnm3sFSg6kY/bs
	 WfTlosEaPMiXHj6MDkxn+LpAbXuhJBJY1Ccx1sEYh4BqtxlUyyNY+DO8h+nqkRiTVH
	 1cV9MPCf9U5zUnHVZQ+3OfEHDVRdUEoKDqjSGB9eobjQ+Hg5R/Q3o2NMUt72QOhFvE
	 u2keA6HUjVjaD5/16PllRIXx0WfG46ZFFSTl0TX7yumUAASDnewyMk0+aPGuyYf9Pp
	 jM2XmrvNzcPBKvF8QsURG349Jp0I4awIpo0T1z/JBpu1ErfBoMF20XROdXVQGAs0b8
	 2m6FP9nP46LIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()
Date: Tue, 10 Nov 2026 22:28:32 -0500
Message-ID: <20261111032814.894700-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060503-failed-5.15-6dea092b261f@kernel.org>
References: <20261107060503-failed-5.15-6dea092b261f@kernel.org>
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

From: Muhammad Bilal <meatuni001@gmail.com>

[ Upstream commit 6dea092b261f04d632411c2be52d13190f5f67b1 ]

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
[ sashal: Adjusted context for the missing pr_warn() line that upstream replaces. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 94c358f261411..b56e4121d238f 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -261,7 +261,9 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 	if (!obj)
 		return -EINVAL;
 
-	if (obj->type != ACPI_TYPE_BUFFER) {
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(*bios_return)) {
+		pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -280,7 +282,7 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 	if (!outsize)
 		goto out_free;
 
-	actual_outsize = min(outsize, (int)(obj->buffer.length - sizeof(*bios_return)));
+	actual_outsize = min_t(u32, outsize, obj->buffer.length - sizeof(*bios_return));
 	memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual_outsize);
 	memset(buffer + actual_outsize, 0, outsize - actual_outsize);
 
-- 
2.53.0

