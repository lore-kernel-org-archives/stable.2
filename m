Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048466;
	b=Z45a9yUl79zE2NY23Cq896M8SJ9s9yAcRqGHyFWhWEocgnbGfNt6olR/+mgXSK+fnwlX
	 bihe+hhrbHivUXUoxC4zAil1DSjfUPel9939VTtjG9O6vPWaNtGbJZuSTZnLbzzIak7Xy
	 PtyuwP0BveQd3P5/dISTUnEDFlW9Ayqa6u0OO96bHJ3MkYO+64YZiNWvYKyzdq8/LELQE
	 lssrHc9VJTOnKWct3UvKRv9u3JumCJukV4VRZacHmj32GYgyD+BSpQ8+zlysp6iVeyFW1
	 PhTOQuINQn4C8H0fNDYLOlinQlOxqOZxB4HtlqNxNd1E9gbNzb9bIMQmHL/8Q0tVkFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZCF8/XsmnL3CkzwiBC8C+1ZWr9CkyK9KqlWsH9PZzMY=;
	b=NgN9JNEGl8daDInQiBIZvHFnyp2zZbM9Mo4rQiy7VXV1KsRUm26hxT+hjBW/sdR80d41
	 uqYmdVDGx04Z6qL4NxMVntsZ7tCA2iCq0EYQZhAkBYqVBEHfUYRhCFbPjBpGzkueoa3Un
	 tLWWSAMdUQPk3t0+N60YdfKhZs041hJpqoQWNUsTZt42fFxyxcW1M0T+eLXXMrcAh1J55
	 tIsc4GHxftiBYNXTcxz1EaIJ43l66j9oo23ADaFjh0e/wW6hxJn7dAFc+xc/aaKILXms8
	 /c8iRyhgzQX7lGN5D212HfrRl+B9mHzNSumrdIsqwKl/8XHaMfd8ufJP0YqxM5mIdZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOQeFp5r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A2606D821
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOQeFp5r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA491F008A5;
	Sat,  7 Nov 2026 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048466;
	bh=ZCF8/XsmnL3CkzwiBC8C+1ZWr9CkyK9KqlWsH9PZzMY=;
	h=From:To:Cc:Subject:Date;
	b=TOQeFp5rxTKvrHHgr1uyr2t0FuFeZ1ea0KCXeHYhKjH8PRNy5i9kjxVjvc7DEmaMB
	 sD/Xb2pF0ZifPQXd5/kLDGylqkdlySNNmygEU+Lke4cTj4D6mjzm2aPEtrBojQr5XB
	 R2Qcrt9Ak1RELFFdy0EgWY7nduUqseeU9SyQF8oxWXdEHKft2xOK4vExZMf1D2lSrg
	 olLU8/EYjV1JfvGLVlNIVvpSZkDE7QGrppk8EdzQOGsXVMX81tNgwiDxs7LxPds0bd
	 it8JCwJOXG/3Io4r2peT9YgXtwfaCVAcxIIkz5S2htHV4RDS4QFFOabmbxhmPuiaO+
	 4QHc0c+xwyK0A==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: simatic-ipc: fix platform device leak on registration failure" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:44 -0500
Message-ID: <20261107054744-failed-6.1-9523698252fd@kernel.org>
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
git cherry-pick -x 9523698252fd583d6987582b9c34ec6500d10986
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054744-failed-6.1-9523698252fd@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9523698252fd583d6987582b9c34ec6500d10986 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 24 Sep 2026 19:56:17 +0800
Subject: [PATCH] platform/x86: simatic-ipc: fix platform device leak on
 registration failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

register_platform_devices() registers the battery, LED, and watchdog
platform devices in sequence. If LED registration fails, the battery
device remains registered. If watchdog registration fails, the LED and
battery devices remain registered.

These failure paths leave successful platform_device_register_data()
calls without the matching platform_device_unregister() calls.

Add an unwind ladder to unregister previously registered platform
devices in reverse order before returning the registration error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: dd123e62bded ("platform/x86: simatic-ipc: add main driver for Siemens devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260924115617.1578309-1-lgs201920130244@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/siemens/simatic-ipc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 7039874d8f112..4a4509fc9263e 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -92,6 +92,7 @@ static int register_platform_devices(u32 station_id)
 	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
 	u8 battmode = SIMATIC_IPC_DEVICE_NONE;
 	char *pdevname;
+	int ret;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(device_modes); i++) {
@@ -139,8 +140,10 @@ static int register_platform_devices(u32 station_id)
 				pdevname, PLATFORM_DEVID_NONE,
 				&platform_data,
 				sizeof(struct simatic_ipc_platform));
-		if (IS_ERR(ipc_led_platform_device))
-			return PTR_ERR(ipc_led_platform_device);
+		if (IS_ERR(ipc_led_platform_device)) {
+			ret = PTR_ERR(ipc_led_platform_device);
+			goto err_unregister_batt;
+		}
 
 		pr_debug("device=%s created\n",
 			 ipc_led_platform_device->name);
@@ -153,8 +156,10 @@ static int register_platform_devices(u32 station_id)
 				KBUILD_MODNAME "_wdt", PLATFORM_DEVID_NONE,
 				&platform_data,
 				sizeof(struct simatic_ipc_platform));
-		if (IS_ERR(ipc_wdt_platform_device))
-			return PTR_ERR(ipc_wdt_platform_device);
+		if (IS_ERR(ipc_wdt_platform_device)) {
+			ret = PTR_ERR(ipc_wdt_platform_device);
+			goto err_unregister_led;
+		}
 
 		pr_debug("device=%s created\n",
 			 ipc_wdt_platform_device->name);
@@ -169,6 +174,14 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	return 0;
+
+err_unregister_led:
+	if (ledmode != SIMATIC_IPC_DEVICE_NONE)
+		platform_device_unregister(ipc_led_platform_device);
+err_unregister_batt:
+	if (battmode != SIMATIC_IPC_DEVICE_NONE)
+		platform_device_unregister(ipc_batt_platform_device);
+	return ret;
 }
 
 static void request_additional_modules(u32 station_id)
-- 
2.53.0




