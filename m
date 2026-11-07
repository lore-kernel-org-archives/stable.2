Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046388;
	b=zsxENhlxRfX8AOaY7mGVwoMSEeOBxIPIKK8VJhWDDp/AC3v0yLGdA23WHnILhNZPuADe
	 sSotrnuoq9BZelP0rvc6kQPNQilGWiGmRZGrUCReE1z1I+dngnp3Y0bq73SNjKqGn9w/G
	 ykjb1/aL7h+at9zuCZiMWzh3mSB9NUj2m2/gbQ87kqlqe8U1cVKSWbHYuy9HsdA2Z1yOz
	 syuMKEMWBEBYswS1v/xdiZ4C73AenVqTW5SjX8u1bys0ZmuxZkdWmOUyyCQsGjzQVcQZb
	 i4y6+sTLptffZ4ZQeHcVJmO3MkCbf1P55s4tYUGxZ5cS3MMPxUOeD08OpwTrSsqSU8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046388;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NX9AdNXTJA71Fyvf+VQZ8nuP55lcPRvzqjXyglmZqzk=;
	b=drvFN8YdgyPbHK5luWNuuCVIiBzz/rpJMviiiGtfpV9EKvj95DuLdqlM82IsnXv7WnJp
	 BUnBkanhssYzN8ymMK7LrsPNpzuDe6FVVPa/OwxzQ/aYi/bUlWJvN+kveTkMs+yWyVvRA
	 /TEsqHFhP5sepPMnSuwlF4zdClRVQVS7eNmJQgr7znqJSrI4pBKUtP61U+hWUBwr87SWw
	 pJGvkOOg0rGVS7L46Vemn9tUOONqxAK8WFEJRqMkGfph76fIOTqzBILKFPka4cgPgN3gm
	 yutWpNHW1pECkExc6pvcoIV2S0ZKtel4QpSyzME75O66rOI7P5SgPSDqEHnAQ/MDOYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRgkODuR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3327606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRgkODuR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB921F0089F;
	Sat,  7 Nov 2026 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046387;
	bh=NX9AdNXTJA71Fyvf+VQZ8nuP55lcPRvzqjXyglmZqzk=;
	h=From:To:Cc:Subject:Date;
	b=RRgkODuREow+W6oUoZ5h+IPLDI2YiA/SNpJIcxP1RfGhCDB0IrKZHwOdcwCjCOxp7
	 yXBCcb7GCMNGGRt2HzlmwNKeIwBHUBtVMuD5+gJzyViR93WZMy6tivLn3wK4zQ5Fx/
	 KwlY+0a4gAo1af4hOD8HoZ8vLCvnVRZx+8Q8/+aXhF7DLTaiDeSa6wJa7+ItSak1BW
	 kok8bW+AFup98j7A48J79XwOchliVIrlOSwj8Q9SSUeyOh0cALQqwv7ZKz38oQpb0b
	 liu5NvpfygNKS4apj87U2+GybRml2djcG9pjom8S7XbqAu4oUX7ToxCgaaDvrP0Z+r
	 UyDDUtmL+XcvA==
From: Sasha Levin <sashal@kernel.org>
To: i@rong.moe,
	navonjohnlukose@gmail.com,
	derekjohn.clark@gmail.com,
	mpearson-lenovo@squebb.ca,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: lenovo-wmi-capdata: Do not stop the AC notifier chain on error" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:05 -0500
Message-ID: <20261107051305-failed-6.18-3b53e691e907@kernel.org>
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
git cherry-pick -x 3b53e691e907086672b72d0544e4bf27efd4250d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051305-failed-6.18-3b53e691e907@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3b53e691e907086672b72d0544e4bf27efd4250d Mon Sep 17 00:00:00 2001
From: Rong Zhang <i@rong.moe>
Date: Mon, 19 Oct 2026 23:02:24 +0800
Subject: [PATCH] platform/x86: lenovo-wmi-capdata: Do not stop the AC notifier
 chain on error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Returning NOTIFY_BAD to the AC notifier chain stops it by preventing
later notifier blocks from being called, but our error is non-fatal for
other AC notifier blocks, which should continue to consume the event.

Return NOTIFY_DONE and add a dev_warn() on error, so that the AC
notifier chain continues. This also aligns with hp-wmi.

The function documentation was copied from elsewhere and makes no sense
here, so correct it as well.

Fixes: e1a5fe662b59 ("platform/x86: Add Lenovo Capability Data 01 WMI Driver")
Cc: stable@vger.kernel.org
Tested-by: Navon John Lukose <navonjohnlukose@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Rong Zhang <i@rong.moe>
Link: https://patch.msgid.link/20261019-lwmi-wmi-new-api-v5-2-71557d28d058@rong.moe
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/lenovo/wmi-capdata.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platform/x86/lenovo/wmi-capdata.c
index d5e9615661364..58787da959b4a 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata.c
@@ -774,13 +774,11 @@ static int lwmi_cd_setup(struct lwmi_cd_priv *priv, enum lwmi_cd_type type)
 
 /**
  * lwmi_cd01_notifier_call() - Call method for cd01 notifier.
- * block call chain.
- * @nb: The notifier_block registered to lenovo-wmi-events driver.
+ * @nb: The cd01 ACPI notifier_block.
  * @action: Unused.
  * @data: The ACPI event.
  *
- * For LWMI_EVENT_THERMAL_MODE, set current_mode and notify platform_profile
- * of a change.
+ * Refresh cached capdata on AC status change.
  *
  * Return: notifier_block status.
  */
@@ -799,8 +797,16 @@ static int lwmi_cd01_notifier_call(struct notifier_block *nb, unsigned long acti
 	switch (event->type) {
 	case ACPI_AC_NOTIFY_STATUS:
 		ret = lwmi_cd_cache(priv);
-		if (ret)
-			return NOTIFY_BAD;
+		if (ret) {
+			dev_warn(&priv->wdev->dev,
+				 "failed to refresh capdata on AC change: %d\n", ret);
+
+			/*
+			 * Our error is non-fatal for others, and we still want
+			 * the other event consumers to process it.
+			 */
+			return NOTIFY_DONE;
+		}
 
 		return NOTIFY_OK;
 	default:
-- 
2.53.0




