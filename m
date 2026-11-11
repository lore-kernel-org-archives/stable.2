Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435861;
	b=If9DOKfg32XQ3lTjtEC4PNC9FtFu/qW7Tp7pgTlwii+V0zV3SKLF6gPh9Cim6w//uxX8
	 OyTVj/FRePs2hIKTmlHG+DDK8XOAPUCwYTnngU8hu7be0jDVdlzXM1Q38i2/VNlicg03C
	 R+pEyxKUpLZPTYSyiKw+fyVVNZAvMvigq42VeZ0jfvpX9YaTWP4+AYs+n9AnmpqLtB9qi
	 SvoWQtXwW83EvXprrg8wkBX8Rwm+79d8kHL19K3R//G4S9aePHw113ofPzQEOnoAdR61p
	 aZhDaHIyyF+3c59nLetyQL+2Htp9ESjc8JASa9z3CPtgSkd90xiAGx348BNo1nz6V5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435861;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AY0YY4rIIbCwAMMw1LjcD918qobsIzhwTMNPSk9X6oE=;
	b=pMcj2r2WiBU9XMyzq3OcCggW8r/fjF0OhpthqtaDqFRSo5jyvAIQPG0GXs3IoGT79IDe
	 VCNHUcwQG4IznO7NVOqbcLkadcCdKggCzlod2oWr8qXbAASBNrKzcn8+ntwT057TLiEg2
	 QWZ4Ae2GxAr8ryqlNPA3hQG749CYkqmjIpJm3TN1jZuNaIqxdS3GwBOAC3K8LKzkIPEv3
	 Ufpm6Uxd2eikPbm93yq5+VshKf76t6dI91mwePAGV8CBOUldnTsnp2cpbzqFbi1DRlm+g
	 4WKeMYpzA/ncKMlchTQ2SPZpeaQQUmg4ESC16wDcnMvh1DD54UDMgdXtvlYBIRGDiGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEPBsWfS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E31606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEPBsWfS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8AD1F00A05;
	Wed, 11 Nov 2026 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435861;
	bh=AY0YY4rIIbCwAMMw1LjcD918qobsIzhwTMNPSk9X6oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IEPBsWfSR7bACGJnKjBU8jSiOztcTrZ+KQSa1XXhcXaqh74D1xy2vzUPfeZ3N5msm
	 zzMqYaAs4DQR/fPVLCQHSwZ6CGlrIFbxPDeDxCDQWC0g9BSoIWU/tiTvhUQo3Do4Jp
	 vnA2/ysXmM/ZQV10sfpyilJLy2x6eofalQv58+y0z2n/zkiFBzvSeE1u/YaZZX1x0W
	 3oBxVV7hPDi3c+RSz/l9EJBHbK3SbORcX3FcdqcRnAJ2VgsJzRup6QHmLHr79IwkRI
	 GDvljctSbsleEI0/7XayPPDarJgF56xL9aZd2tvFX5HJeaAf4iVy95XN6MnYElFXlj
	 +cbY4FBjAfHjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rong Zhang <i@rong.moe>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ACPI: utils: Add exclusive AML evaluation helpers
Date: Wed, 11 Nov 2026 17:24:17 -0500
Message-ID: <20261111222411.33722-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051336-failed-6.18-f91c2cd6dbce@kernel.org>
References: <20261107051336-failed-6.18-f91c2cd6dbce@kernel.org>
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

From: Ali Ahmet Memiş <aliamemis@disroot.org>

[ Upstream commit 80892972ff23bf0b9049230ef0931b34163aaed3 ]

ACPICA drops the interpreter lock while AML waits, for example around EC
accesses, so two methods can run interleaved.

Some firmware relies on methods not interleaving, for instance by
switching an EC page selector without taking the AML mutex that the
other users of that page hold.

Add acpi_evaluate_object_exclusive(), acpi_evaluate_integer_exclusive()
and acpi_execute_simple_method_exclusive() which serialize the
evaluation under a global mutex, for callers that are known to be
affected.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com/
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
Reviewed-by: Rong Zhang <i@rong.moe>
Link: https://patch.msgid.link/20261018122220.678822-2-aliamemis@disroot.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: f91c2cd6dbce ("platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/utils.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  7 +++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 526563a0d1886..92e977fb56570 100644
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
index 66fc14f869cb9..53aad501458f8 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -30,6 +30,12 @@ acpi_status
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
@@ -46,6 +52,7 @@ acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 bool acpi_has_method(acpi_handle handle, char *name);
 acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
 				       u64 arg);
+acpi_status acpi_execute_simple_method_exclusive(acpi_handle handle, char *method, u64 arg);
 acpi_status acpi_evaluate_ej0(acpi_handle handle);
 acpi_status acpi_evaluate_lck(acpi_handle handle, int lock);
 acpi_status acpi_evaluate_reg(acpi_handle handle, u8 space_id, u32 function);
-- 
2.53.0

