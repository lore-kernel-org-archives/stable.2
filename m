Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049505;
	b=38R+XDcYvkXJxndNf0EoOKZAMtlohbgX1iSw1lNRfONrOCqat+e/gvQ46M5DrAdKXoIc
	 4+uc9ZmtZRSqxJrwbuLm+ny5GrrjYOTSHdJF5pUzmKoTPFN5iTYQnWAlEUDkFYmAsm87b
	 WmxdCx1rOosnrCKH2yu42Wi1b6fQSS1u4LhA2DjMk4mo3OB5fDPkss4QlF9RxQZ8Axucg
	 A1Vn5J6fWZtbu9A3Z3r8spBIaokOECk2Dg4053KDp0gU60LSjRT3/rAUQqXaXuA/gB3Ee
	 ODz2dnhUaxcWavURojbINgu9ye9v/aoj/0J7XcgGUhrXmLHBIyUAtu1fxKsVkp1I3Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049505;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yH7tKB3wNZFghaVgwEbpw9JTBn4hpjHLb+NZmEzxxe8=;
	b=Dx2VmHHLogRpe7LkdWMuxXiDIplpbdD7rrAa72HfGRU0uwYpNOr0sw94g/RpvcMih24X
	 StVLHgUfmlDcmeFFg31O8OQ/3oxn/p6Oy6zeL7cavfGEmlz1cKsE81a+UGEVae3y496Ca
	 D2oRVw6emBgM9Fu9X3ONXy4h9H7R/YVrFSGsAUiI9ZhmCWvowK8kxYZNss4N05CpC80wx
	 +d0C0fjexYS6RlPLji8WbW5hYHKLiBWXZpQuZ5xEf3eG3f9ZtP8gd2F+9sJi4H4XwDmq4
	 /sGVFGLVm80LxG0M2knDQRNw4WwSFppJByNcNMiJpxDImN4CeaRtul9dwEojVJHSphw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afs+tH+G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afs+tH+G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEF51F0089F;
	Sat,  7 Nov 2026 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049505;
	bh=yH7tKB3wNZFghaVgwEbpw9JTBn4hpjHLb+NZmEzxxe8=;
	h=From:To:Cc:Subject:Date;
	b=afs+tH+GA1U/Xh730ZePL6haBYNuc68p5Mg13YujhYkA2d4X6vvLWivOBHjeh14iM
	 S9zQwCLzJj/0+2Cc+eEqj1aQWYHmh+03DcbPBRwlaKcnqsl6XPwhdTa+6TzaxNMBA3
	 9k9KE8xIwaSIDK0AQXyN4UvV/eNyqohOtXQcf/cwb2MWE4fEqpmtrF4Untrhg3YWPQ
	 FJMQVKAxkqWp0v+JMw5pkElI66jYvpUHvYVC46XLhva+osUNYzACTCITxXIA/kdhoZ
	 RzI4VIQ/yNpirJLcAdBlj035lScPoTRtCi9vYOjO8RC79ffc8MWswpfyhTkoT480f0
	 O+MHZ5JaRKzig==
From: Sasha Levin <sashal@kernel.org>
To: meatuni001@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:03 -0500
Message-ID: <20261107060503-failed-5.15-6dea092b261f@kernel.org>
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
git cherry-pick -x 6dea092b261f04d632411c2be52d13190f5f67b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060503-failed-5.15-6dea092b261f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




