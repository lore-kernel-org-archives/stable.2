Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773033;
	b=odPlQniok4n59YjSds7VBXMO2ZFrPz0zNVPF2oZE8ufNIw4mhBmCKqKdmHrqOhSeBPvd
	 6+MlF03s2TBghn7ZiB6J5rJ7ZqLVWx6sMrTayj+ggQtAGtPimoEeiVPJ6UGhKLKKxVZ13
	 887NdPKK2U7V9JONcAuXNnEaiXD2hCkRSYMjmDnGGazb4g9L9TQW3YqrGLxqJphmWzIIX
	 WbkMoyv2hPzF3nBfmNxiNuGl3rHiKPgxpotibc6SvJAWD7Uhkx647knb9GbSX4fztRzlJ
	 JGcMxugAmAredt8tn7nZNv4xgNZ8rIUdCE9UaZJTQZw4ZV2zZWMcIsZ8ELG1j5LZkhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773033;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bidR1AFwHCujHiY0WSU8gaeAW4HDxTP44acwR3nISts=;
	b=J61a7O0HMvvxgymb6dS8NILFps5merHJkbOVjBktKWhTlYfKrpETCvtXaKh0kDuP3yv0
	 RHmQRTHyY0o9YE8b8bO1ktdVMR6uLMLjf5gsLET7ZM54q1mL2B+y0ZylryHSLOolbbx9P
	 JG78/gcqmksRConXlQJjH5bcJ0REaI3LcXcltRfl8yeO/vf/b+wy/WMW3GmELhINBPBT0
	 ozB5/4t9Z1FU7V7BLqJZpwXsbUJCnG6uc8jRaEW2txzaikZ5lLx8ijACd5VrduMCKGJ8u
	 NEtZLjDc6gA5AxiN6sf+bs/+XVOSdZTB2jA75rBxScG5VaEwsR6ga4jmmNZaMw9MVVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aQIF54pb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518F606A332
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aQIF54pb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6FF1F01828;
	Fri, 23 Oct 2026 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792773032;
	bh=bidR1AFwHCujHiY0WSU8gaeAW4HDxTP44acwR3nISts=;
	h=Subject:To:Cc:From:Date;
	b=aQIF54pb2bE4IrlfaAoJxN36qK9iOfHLmKxBuC56XfvT2Fy3m4mfvaE/fYDYj5xnx
	 fYOsc1guLN/D7i6WauoictCtcliD18o3am9PEAuToP+NoiEacqquouiuviQHPbpv+k
	 TcD7vNSWwy+Fka6yE3WWeOinCBnEN7+QJZJVlqzU=
Subject: FAILED: patch "[PATCH] ACPI: scan: Avoid registering platform devices with resource" failed to apply to 6.18-stable tree
To: rafael.j.wysocki@intel.com,andriy.shevchenko@linux.intel.com,julien82453@gmail.com,pmenzel@molgen.mpg.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 23 Oct 2026 18:29:08 +0200
Message-ID: <2026102308-twisting-bazooka-12b5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f234fdaae1cad8c39265e7ca0a14633076ec7154
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102308-twisting-bazooka-12b5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f234fdaae1cad8c39265e7ca0a14633076ec7154 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 7 Aug 2026 12:22:37 +0200
Subject: [PATCH] ACPI: scan: Avoid registering platform devices with resource
 overlaps

If acpi_dev_get_resources() returns overlapping I/O or memory resources,
the subsequent registration of a platform device will fail with -EBUSY
due to a resource conflict.  This is reported to happen on Acer Aspire
ES1-572 [1].

Avoid that by adjusting resources returned by acpi_dev_get_resources()
to eliminate partial overlaps between them.

This has not been regarded as necessary before because putting
overlapping resources into the _CRS of one device is really pointless,
but now that the issue has been reported to actually happen in the
field, it needs to be done.

Fixes: ab06eb920401 ("ACPI: scan: Register platform devices for fixed event buttons")
Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")
Reported-by: Julien <julien82453@gmail.com>
Tested-by: Julien <julien82453@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/linux-integrity/CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com/ [1]
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ rjw: Tweaked the new message ]
Link: https://patch.msgid.link/12955541.O9o76ZdvQC@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index a09636a4168e..373c94de7590 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
@@ -71,6 +72,36 @@ static struct notifier_block acpi_platform_notifier = {
 	.notifier_call = acpi_platform_device_remove_notify,
 };
 
+static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
+						   struct resource *new_res,
+						   struct resource *resources,
+						   unsigned int count)
+{
+	unsigned int i;
+
+	if (!(new_res->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+		return count;
+
+	for (i = 0; i < count; ) {
+		struct resource *res = &resources[i];
+
+		if (resource_type(new_res) != resource_type(res) ||
+		    !resource_union(new_res, res, new_res)) {
+			i++;
+			continue;
+		}
+
+		dev_info(&adev->dev, "%pR expanded due to overlap\n", new_res);
+		/*
+		 * Eliminate the previously processed resource that overlapped
+		 * with the new one because it is not necessary any more.
+		 */
+		memmove(res, res + 1, (--count - i) * sizeof(*res));
+	}
+
+	return count;
+}
+
 static void acpi_platform_fill_resource(struct acpi_device *adev,
 	const struct resource *src, struct resource *dest)
 {
@@ -151,10 +182,14 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 				return ERR_PTR(-ENOMEM);
 			}
 			count = 0;
-			list_for_each_entry(rentry, &resource_list, node)
+			list_for_each_entry(rentry, &resource_list, node) {
+				count = acpi_platform_adjust_resources(adev,
+								       rentry->res,
+								       resources,
+								       count);
 				acpi_platform_fill_resource(adev, rentry->res,
 							    &resources[count++]);
-
+			}
 			acpi_dev_free_resource_list(&resource_list);
 		}
 	}

