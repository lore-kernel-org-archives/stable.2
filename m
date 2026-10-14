Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAE51597E;
	Wed, 14 Oct 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984634; cv=none; b=iRyTFsFi25J/o6oMnRoi2mcq9pewBVXVXCCejotZnuFsgNIhkb4ILZZEWMF/xpHGJAwIVpvvu2T+W9xOoO6Vqqo7PkJmeJxUme22Tzei8BUTsKNzNap/szLyD4msgMhQjwFKONWlpWY3m9QYPHvjQ5O1J1eFEJpsHuHhztEThck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984634; c=relaxed/simple;
	bh=jdV7b2gUh49PVFevZlZiVMcJSvlJs711GT3ZiWU6oq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHNMIVaQMGq8bdSrT6yWen0bk8whM/+rlzWyRM+RKi8jQ4k2uLWnOSMmN0XeQR8//rSx2qeU3TwXVrKNVvDNXIa4Ts189JiMTN4r/7ThffHxeLoS27QYiYWTNuKwMK/rgciHQRckeiXhAJWfk+8NoRD0iUY+n2hMezT9/n8v3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YIIESCSf; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YIIESCSf"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AB08280A6B;
	Wed, 14 Oct 2026 15:30:25 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zsIsvv6vk9F0; Wed, 14 Oct 2026 15:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791984624; bh=jdV7b2gUh49PVFevZlZiVMcJSvlJs711GT3ZiWU6oq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YIIESCSf+ix9BmmqfuZQdlTVuhqxmujxDQSgS5vcmhWKOoE2xWdjMwlGp7gsl9WcE
	 uzeW/arxC4jkHRTcTtFXozd/e44TP5ZL8Lky5ie31ErU8acsN9fqU7atJKr/46GlEv
	 ZiimUGlk0N3YnpNlMjL7ni8/OeLCGHLhf912aYrxcx8yyzyyfATruRsDuz43VCLDHb
	 GzQF5e3tMBBT1otg/vlNSTzCKbOSIedDI7YAgHFkdudMa0onyfbcDCIAvZUXMgIyCO
	 NTKUK15ZRMV24gUKvgC3AC8FaH2bKtnqCXg6LD+Xkph08Hvep3UT4FA2mU5+lJ38Gi
	 BWYuYtKkrmayQ==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rong Zhang <i@rong.moe>,
	Charis Stratakis <c.stratakis@proton.me>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ACPI: utils: Add exclusive AML evaluation helpers
Date: Wed, 14 Oct 2026 16:30:08 +0300
Message-ID: <20261014133013.94097-1-aliamemis@disroot.org>
In-Reply-To: <20261014132703.93355-1-aliamemis@disroot.org>
References: <20261014132703.93355-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ACPICA drops the interpreter lock while AML waits, for example around EC
accesses, so two methods can run interleaved. Some firmware relies on
methods not interleaving, for instance by switching an EC page selector
without taking the AML mutex that the other users of that page hold.

Add acpi_evaluate_object_exclusive() and acpi_evaluate_integer_exclusive()
which serialize the evaluation under a global mutex, for callers that are
known to be affected.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 drivers/acpi/utils.c    | 56 +++++++++++++++++++++++++++++++++++++----
 include/acpi/acpi_bus.h |  8 ++++++
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index d499b72574ab..f28680424f14 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -243,10 +244,34 @@ acpi_extract_package(union acpi_object *package,
 
 EXPORT_SYMBOL(acpi_extract_package);
 
-acpi_status
-acpi_evaluate_integer(acpi_handle handle,
-		      acpi_string pathname,
-		      struct acpi_object_list *arguments, unsigned long long *data)
+static DEFINE_MUTEX(acpi_exclusive_eval_lock);
+
+/**
+ * acpi_evaluate_object_exclusive - Evaluate an object without interleaving
+ * @handle: ACPI handle of the object or its scope.
+ * @pathname: Path of the object relative to @handle.
+ * @arguments: Arguments to pass, or NULL.
+ * @buffer: Buffer for the return value, or NULL.
+ *
+ * Same as acpi_evaluate_object(), but serialized with other exclusive
+ * evaluations.  Use it only for methods known to break when interleaved.
+ */
+acpi_status acpi_evaluate_object_exclusive(acpi_handle handle,
+					   acpi_string pathname,
+					   struct acpi_object_list *arguments,
+					   struct acpi_buffer *buffer)
+{
+	guard(mutex)(&acpi_exclusive_eval_lock);
+
+	return acpi_evaluate_object(handle, pathname, arguments, buffer);
+}
+EXPORT_SYMBOL_GPL(acpi_evaluate_object_exclusive);
+
+static acpi_status __acpi_evaluate_integer(acpi_handle handle,
+					   acpi_string pathname,
+					   struct acpi_object_list *arguments,
+					   unsigned long long *data,
+					   bool exclusive)
 {
 	acpi_status status = AE_OK;
 	union acpi_object element;
@@ -257,7 +282,12 @@ acpi_evaluate_integer(acpi_handle handle,
 
 	buffer.length = sizeof(union acpi_object);
 	buffer.pointer = &element;
-	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
+	if (exclusive)
+		status = acpi_evaluate_object_exclusive(handle, pathname,
+							arguments, &buffer);
+	else
+		status = acpi_evaluate_object(handle, pathname, arguments,
+					      &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_util_eval_error(handle, pathname, status);
 		return status;
@@ -275,8 +305,24 @@ acpi_evaluate_integer(acpi_handle handle,
 	return AE_OK;
 }
 
+acpi_status
+acpi_evaluate_integer(acpi_handle handle,
+		      acpi_string pathname,
+		      struct acpi_object_list *arguments, unsigned long long *data)
+{
+	return __acpi_evaluate_integer(handle, pathname, arguments, data, false);
+}
 EXPORT_SYMBOL(acpi_evaluate_integer);
 
+acpi_status acpi_evaluate_integer_exclusive(acpi_handle handle,
+					    acpi_string pathname,
+					    struct acpi_object_list *arguments,
+					    unsigned long long *data)
+{
+	return __acpi_evaluate_integer(handle, pathname, arguments, data, true);
+}
+EXPORT_SYMBOL_GPL(acpi_evaluate_integer_exclusive);
+
 int acpi_get_local_u64_address(acpi_handle handle, u64 *addr)
 {
 	acpi_status status;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a10a591c18b2..e7a671dba624 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -32,6 +32,14 @@ acpi_status
 acpi_evaluate_integer(acpi_handle handle,
 		      acpi_string pathname,
 		      struct acpi_object_list *arguments, unsigned long long *data);
+acpi_status acpi_evaluate_object_exclusive(acpi_handle handle,
+					   acpi_string pathname,
+					   struct acpi_object_list *arguments,
+					   struct acpi_buffer *buffer);
+acpi_status acpi_evaluate_integer_exclusive(acpi_handle handle,
+					    acpi_string pathname,
+					    struct acpi_object_list *arguments,
+					    unsigned long long *data);
 bool acpi_evaluate_reference(acpi_handle handle, acpi_string pathname,
 			     struct acpi_object_list *arguments,
 			     struct acpi_handle_list *list);

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.55.0

