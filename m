Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E462DEA68;
	Sat, 17 Oct 2026 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792242440; cv=none; b=N4R6YGqIDVtXDvx+u5Ckr7wRGsIm/KC8NkhXpOjoHQEyh532aiFL1HUF0gxNBV8o/4WQhw928SIqc/ScUOoxBuCWatQ1I9auHhsH/vbdUvnU+JPaEgM/BTGeBKHSQ54CdpY+gsCRPETbt3taEbpvLFtOVoU9VyURfYaY0A98rsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792242440; c=relaxed/simple;
	bh=pIYeMnTkKAuy7QyZn9CsGAjfFACt5x393T6mP99fSlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0ZO/pvVc+8Y5OEF9tuF+ZwZh8PO4/AyWkYu2sy6t1NpLUWfbVfkcuo/i297Ruvf4iC20Rsyr2z6GOvhqJ8fkzR0CsvXDHeX/cLKCBvBbjIBmma22CeT8wLTTjQ5rIM5YeXfFlESYl40KYvHzpK58bNtegZxFdg4++8HnUxMcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EhhVUwRb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EhhVUwRb"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3ED2E82AD5;
	Sat, 17 Oct 2026 15:07:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CocdGDbeRhuI; Sat, 17 Oct 2026 15:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792242428; bh=pIYeMnTkKAuy7QyZn9CsGAjfFACt5x393T6mP99fSlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EhhVUwRb/gIjBHQ0FPvAWtVzaEnN468lNWdesk1ZHp9TNW9jSp7dLjCdAIgXWGeSA
	 RjRCWnD6r78IZXr24kp3ogOpDnWAIAXbuS9oksimzo4AU9svpQpqTvd8/PLzPOkr2E
	 cDLIl8B+FioRnqK7XLjIqMmOBqnw1oM0ZJ0UViPEma4u7twGLtfAXsKuH0mtl1JmAW
	 2zTjvEVeer/oEBGeLqwKapO850vmkkTFN5XiNubUvsrM56tZHrI5r3qbU2Duabv/JE
	 Qhscnz1kgJhNaJ2XykZrgSdshhqcGjCZGIa8UoMe0aFnUfnK4F/8C65iieZfSlx6U9
	 HM7kbYIYIK8cA==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rong Zhang <i@rong.moe>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ike Panhc <ikepanhc@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Charis Stratakis <c.stratakis@proton.me>,
	Avraham Hollander <anhollander516@gmail.com>,
	=?UTF-8?q?Jeffrey=20W=C3=A4lti?= <jeffrey@waelti.dev>,
	Rick <rickk1166@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] ACPI: utils: Add exclusive AML evaluation helpers
Date: Sat, 17 Oct 2026 16:06:34 +0300
Message-ID: <20261017130652.318778-2-aliamemis@disroot.org>
In-Reply-To: <20261017130652.318778-1-aliamemis@disroot.org>
References: <20261017130652.318778-1-aliamemis@disroot.org>
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

Add acpi_evaluate_object_exclusive(), acpi_evaluate_integer_exclusive()
and acpi_execute_simple_method_exclusive() which serialize the
evaluation under a global mutex, for callers that are known to be
affected.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 drivers/acpi/utils.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  7 +++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index d499b72574ab..ea8cb876c12d 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -243,6 +244,28 @@ acpi_extract_package(union acpi_object *package,
 
 EXPORT_SYMBOL(acpi_extract_package);
 
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
+acpi_status acpi_evaluate_object_exclusive(acpi_handle handle, acpi_string pathname,
+					   struct acpi_object_list *arguments,
+					   struct acpi_buffer *buffer)
+{
+	guard(mutex)(&acpi_exclusive_eval_lock);
+
+	return acpi_evaluate_object(handle, pathname, arguments, buffer);
+}
+EXPORT_SYMBOL_GPL(acpi_evaluate_object_exclusive);
+
 acpi_status
 acpi_evaluate_integer(acpi_handle handle,
 		      acpi_string pathname,
@@ -277,6 +300,16 @@ acpi_evaluate_integer(acpi_handle handle,
 
 EXPORT_SYMBOL(acpi_evaluate_integer);
 
+acpi_status acpi_evaluate_integer_exclusive(acpi_handle handle, acpi_string pathname,
+					    struct acpi_object_list *arguments,
+					    unsigned long long *data)
+{
+	guard(mutex)(&acpi_exclusive_eval_lock);
+
+	return acpi_evaluate_integer(handle, pathname, arguments, data);
+}
+EXPORT_SYMBOL_GPL(acpi_evaluate_integer_exclusive);
+
 int acpi_get_local_u64_address(acpi_handle handle, u64 *addr)
 {
 	acpi_status status;
@@ -685,6 +718,14 @@ acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
 }
 EXPORT_SYMBOL(acpi_execute_simple_method);
 
+acpi_status acpi_execute_simple_method_exclusive(acpi_handle handle, char *method, u64 arg)
+{
+	guard(mutex)(&acpi_exclusive_eval_lock);
+
+	return acpi_execute_simple_method(handle, method, arg);
+}
+EXPORT_SYMBOL_GPL(acpi_execute_simple_method_exclusive);
+
 /**
  * acpi_evaluate_ej0: Evaluate _EJ0 method for hotplug operations
  * @handle: ACPI device handle
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a10a591c18b2..8b1d329455f7 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -32,6 +32,12 @@ acpi_status
 acpi_evaluate_integer(acpi_handle handle,
 		      acpi_string pathname,
 		      struct acpi_object_list *arguments, unsigned long long *data);
+acpi_status acpi_evaluate_object_exclusive(acpi_handle handle, acpi_string pathname,
+					   struct acpi_object_list *arguments,
+					   struct acpi_buffer *buffer);
+acpi_status acpi_evaluate_integer_exclusive(acpi_handle handle, acpi_string pathname,
+					    struct acpi_object_list *arguments,
+					    unsigned long long *data);
 bool acpi_evaluate_reference(acpi_handle handle, acpi_string pathname,
 			     struct acpi_object_list *arguments,
 			     struct acpi_handle_list *list);
@@ -48,6 +54,7 @@ acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 bool acpi_has_method(acpi_handle handle, char *name);
 acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
 				       u64 arg);
+acpi_status acpi_execute_simple_method_exclusive(acpi_handle handle, char *method, u64 arg);
 acpi_status acpi_evaluate_ej0(acpi_handle handle);
 acpi_status acpi_evaluate_lck(acpi_handle handle, int lock);
 acpi_status acpi_evaluate_reg(acpi_handle handle, u8 space_id, u32 function);
-- 
2.55.0

