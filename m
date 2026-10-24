Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839444;
	b=WtL5tf6gYUxIQYNtEqlovpV2Q/7gZSIa3qICA6BZUrAIREH+0CjvFrhBAGgIbfgj9IEz
	 puvejZzIrth37FDN7RHn2/wFTIPY7s4RSk5f437pcGG+VLcma0g2sCz+Vl9xQ9RoNliH/
	 XsDzAGnC/3mXl1pH+JNjpHoXxxVA6KUEJblSR5Vt50lIBn1URf7hZ+wD6ACTnzOGcjw1l
	 GXAOV8WS8Zy3d0HicpIjyJY4tw6ZzGKmN6VZig2+wyc0wuFuH8zrsTsAF3gDRWk+Z1ECn
	 7+pzbayqkAue7wY8vMSeXscJLrmDgNFXLYN/yOLPTN8qVp7Yojv6CtfNCy2VLTugf0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fDoOd/huNso3Qjc7us4cwB4PnjlswnbSJ2MQY2Ura/4=;
	b=1Qm88gImdaYhAA7SI2yCEaM319r+e68VmqO7FAZWH2loNqiXetJWWPobj4eUo2hqdvbE
	 7PGtadKAJPjkuDoy/kjftHVqpDc1yBCEtn8WuPfJmGuDZNQpVpA3KMcC3TnjY4D9v2cVQ
	 r1bQGUTwcX25f5HokzAr7lxgZb7Xnedo7iG0QL5V7lxf+0IMvXHFq/ayZUxAS8NgfUVz9
	 9nVA5HL3zOGcDe/8Jv0GzjVA6JPc5GxBobxceghfCjmIAdw/Z5ixrfcUlhQD4Xetwdb60
	 0fCNcIKN7HXEuB31Xl4YUC/LRkp9tcQElXrHUo/gB/HbXl/Am9xU0nFBSnbxiKLu4aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z0w4XDg6;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6C606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28C6C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z0w4XDg6
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso816716a91.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792839442; x=1793444242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDoOd/huNso3Qjc7us4cwB4PnjlswnbSJ2MQY2Ura/4=;
        b=Z0w4XDg63tUvVcepZZ35k3b7yKxs71R9cdho5OPsKtDVTWmsoEpFCGymEeHp2keFsm
         80Ns0AI5HjL2Cewk/K9KUrH2Z5DRGh9dvY2XMf6dIiOde4x2yER/yubqCDJyHYJcC25t
         TZgs0QS1T5Jf6H5gmuWbRcGzLwVQyb1y6XpgmCEfj2zbRwMPghhlKDTtApa4BaR1HuGL
         p6dLSNZqiapHpI2hixHFrFyLeC+vb0Hnzk7V1MfiPA8N7T6iGePbzk1TCVLS+2YyZ/G4
         g37R47BTEaBeDHwPqGTMnISxcJemxdhkofNqAGVDN5EPcnyIe1fPXDFDYuingDKrFuOk
         /7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792839442; x=1793444242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fDoOd/huNso3Qjc7us4cwB4PnjlswnbSJ2MQY2Ura/4=;
        b=yfvb3VTSlTg4aierDWOQ+T1GMuc4yg8zOs5pk/UNnRoVJ9b/WP187K+c/9ohXnY8YI
         vmSx7YybsbItj7IhWd7BQzAle9NPla2W79NeqOid34QD8vTO2UTrOFtHRKrRL3Vuj3Zq
         f6t/6J4nvH70S6F77N08rXIjFStRS+sZPTsh4ICQPWxJCw76CsYvvNM3+J7pi+66UHQJ
         QQmc/nvJ8mGYNEq/koNdRqiSFVoAeWM26wDS+6ashUyc6k+WZDgHa1LMndhAEXJ3Atn2
         qW3S2xh+xYOS72vIrirPSx2wDFB1SL9HIT2N78Bfa7bDbLuz1p31QLoGwUYhgJeu1+FX
         diew==
X-Gm-Message-State: AFq9FYIX1gxnYrsclaiXvk5u3bH8SObyup3ge3fV/wiyVMHk8KDHaQ6f
	/cLF62rXNna0Vd739aVQA9lYtusDZieyvBxlyFosKBtzFCEULTMJkHUUQirLK7eDaiY=
X-Gm-Gg: AYBFou1ugiGlozzcHBVdNur/dHvT6Tdnhflxm3PLaGcWMP5m4GeYqkYSFv4mArUBJQ8
	r7yjZV+QrQfWQjFD/O52x7UuSeBFN2/xzXrGm7gcJ8X93Qdngpw2mFITgKdGccY5Cd0I3I182YT
	Y3jkc/MwQpF9L4SKrKZUoOVD0jziafKlctbbjaP5VvV3xLp6sqhVn2kbkfasOllb8ZnwfuEL7+E
	7cfUaS8T19V3V6wSListenZKn8sqWBZg+59QYt/cYxCqFMysXlG+EAdo61MPUf5dvpBGLIe0amx
	z3ahn7xvX0trudh4fr2I3KiUBjaiSCNm0YepwVDBWHO/HFwrg0F3/Brj8QS+rC59r1vXcCEO/2X
	V2MrdJnvFAe7p4Y/FFoh3DFTG7DFus3f0TCVdTzEAXpCYbCNi9V7NKehUMnIvvTLdbgXGolN8Xw
	kZQ9kF+cqPQAmbJnXV2KzNKekPRCEM1UypGsSBjTwZOXIbujd7lMdDRp7MoNbDeTYxyTRHLapyJ
	22nvJDWfX3NPQZl9bNsjZ/8H6WR/WdID7eFC+cmxtHZ97nFk/k3tt7UQVHx2okPdPU3W4aeChNp
	OHaPJsWZdnWCL6wrsEcA9XVraLinnFrfqUWBOh+dFzgGwJwFRczzJDEWe53/czKWzhj3EXZDBcK
	xtAOw+GnLXPPcTBD+UQNoLuq7j+rIwmup6RHs62QrZYZkZd/c9S+cLVgfBQAIDtCGTqPmidmjj9
	r2ZQhnetmTTQkzqoEMpR1FdNddOM9fOd6OBvBO3YFdZAxvDX3FiKCD+DLI
X-Received: by 2002:a17:90b:5647:b0:39e:6a7e:ee18 with SMTP id 98e67ed59e1d1-3adeae8342bmr1401579a91.36.1792839442246;
        Sat, 24 Oct 2026 03:57:22 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm2565666a91.4.2026.10.24.03.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:57:21 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>,
	Wolfgang Walter <linux@stwm.de>,
	Bob Anderson <kernel@ametros.net>,
	Domenico Suppa <domenicosuppa@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.18.y 1/3] ACPI: scan: Register platform devices for fixed event buttons
Date: Sat, 24 Oct 2026 18:57:08 +0800
Message-ID: <20261024105710.593-2-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024105710.593-1-ue081723@gmail.com>
References: <2026102308-twisting-bazooka-12b5@gregkh>
 <20261024105710.593-1-ue081723@gmail.com>
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit ab06eb9204010c61e754bf4e71ee6f554584714d ]

On platforms using ACPI, power and sleep buttons may be so called "fixed
event devices" in which case they are hooked up directly to the Fixed
Events register in the platform via dedicated lines and there are no
corresponding device objects in the ACPI namespace.  Nevertheless, in
Linux they get corresponding struct acpi_device objects with special
device IDs, either LNXPWRBN or LNXSLPBN, which are then used for driver
binding in a ususal way.

However, the function creating those struct acpi_device objects for
"fixed event device" buttons, acpi_bus_scan_fixed(), does not register
platform devices for them, unlike the generic code handling device
enumeration based on the ACPI namespace.  Consequently, if an ACPI power
or sleep button is represented by a device object in the ACPI namespace,
it will get a corresponding platform device, but if it is a "fixed event
device", it will not get one, which is inconsistent and prevents the
ACPI power button driver from being converted into a platform driver.

For the sake of consistency and to allow the ACPI power button driver to
become a platform one going forward, modify acpi_bus_scan_fixed() to
register platform devices for "fixed event device" buttons and update
ACPI platform device registration code to work with non-device ACPI
object types, so it can handle the buttons in question.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/3731144.R56niFO833@rafael.j.wysocki
[ Ting-Han: 52d864019636 ("ACPI: button: Convert the driver to a platform
  one") was backported to 6.18.57 as a dependency of fe80251152fe
  ("ACPI: button: Fix ACPI GPE handler leak during removal") without this
  prerequisite, so fixed event power buttons (LNXPWRBN, e.g. on QEMU q35)
  have no platform device and are no longer bound to any driver. ]
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/acpi/acpi_platform.c | 38 ++++++++++++++++++++----------------
 drivers/acpi/scan.c          |  4 ++++
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd78..52c8d602f 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -114,10 +114,8 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	struct platform_device *pdev = NULL;
 	struct platform_device_info pdevinfo;
 	const struct acpi_device_id *match;
-	struct resource_entry *rentry;
-	struct list_head resource_list;
 	struct resource *resources = NULL;
-	int count;
+	int count = 0;
 
 	/* If the ACPI node already has a physical device attached, skip it. */
 	if (adev->physical_node_count)
@@ -137,22 +135,28 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 		}
 	}
 
-	INIT_LIST_HEAD(&resource_list);
-	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
-	if (count < 0)
-		return NULL;
-	if (count > 0) {
-		resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
-		if (!resources) {
+	if (adev->device_type == ACPI_BUS_TYPE_DEVICE) {
+		struct list_head resource_list = LIST_HEAD_INIT(resource_list);
+
+		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+		if (count < 0)
+			return ERR_PTR(-ENODATA);
+
+		if (count > 0) {
+			struct resource_entry *rentry;
+
+			resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
+			if (!resources) {
+				acpi_dev_free_resource_list(&resource_list);
+				return ERR_PTR(-ENOMEM);
+			}
+			count = 0;
+			list_for_each_entry(rentry, &resource_list, node)
+				acpi_platform_fill_resource(adev, rentry->res,
+							    &resources[count++]);
+
 			acpi_dev_free_resource_list(&resource_list);
-			return ERR_PTR(-ENOMEM);
 		}
-		count = 0;
-		list_for_each_entry(rentry, &resource_list, node)
-			acpi_platform_fill_resource(adev, rentry->res,
-						    &resources[count++]);
-
-		acpi_dev_free_resource_list(&resource_list);
 	}
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7f9dd2704..c382bed50 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2644,6 +2644,8 @@ static void acpi_bus_scan_fixed(void)
 				device_init_wakeup(&adev->dev, true);
 			else
 				dev_dbg(&adev->dev, "No driver\n");
+
+			acpi_default_enumeration(adev);
 		}
 	}
 
@@ -2656,6 +2658,8 @@ static void acpi_bus_scan_fixed(void)
 			adev->flags.match_driver = true;
 			if (device_attach(&adev->dev) < 0)
 				dev_dbg(&adev->dev, "No driver\n");
+
+			acpi_default_enumeration(adev);
 		}
 	}
 }
-- 
2.53.0

