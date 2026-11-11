Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435862;
	b=VRTesDVBMPTENJk+UwkUkVSeM1yLk/RkwpoD6aSxDfC/H9c98M0GH3QBtvevysV8Qb3J
	 eJ87bBxA9wGmfKHBFuEmPxe2xCUHPvmHHKVntW0a/47FKYw0Qzmq57+RLCSyaCWcvTaut
	 pAz20Rt+RNezSlr9JRPqLFElzLoDxhwfT6h+fYUovSwEdmgfuJcyv0czsWBklRxngXz4I
	 RCUIImlKzS5I1TNnZrUDo8nNMdNE0ijl7zwMHBP4JeAde4rKFG/zi/2SiphGZYeuFc2Va
	 Ah4wotW1a5Zeixda3YSDa1opq28e4G56+yLQWBNA94WjNnwZzLbOj0O8mBU6H5ezvmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435862;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aQzy62bRNLUxLuXSwWAKMfchOE1zaljkfjwJ1urF5cE=;
	b=hE5hshLW/3yEZWlb/QfYJbvtdarxryfItkLGwYFcXTYsPBDy1aelUIAK0rL0ttCHgrv+
	 ER3ObaY1jYGOdXjbzlQUCglxYlEqjuoW09mh2uhSwkEykfEta52ndU1iBAi4KfR2V/4vQ
	 QAYj+E1vvffnbdGxCY9lsbk+yQy6bffqOP1mQpFT60uVIsT2Aa0NXMlHA6Xbvh8n5rIRL
	 ocWY5pOfi88y2bqBqrjo4m7zPt9iMQ6FJcvBdtloPlj3rl+hLGG4fjdBWzaP4REGCUDry
	 0Ba/itSPCq1l4b/tVfwW3GuZg5SLEH5zJ9CQGjCcvTlb8DC8oLEiULlJ6l5nC3uCD5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZ222hcN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE8606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZ222hcN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DFF1F00A07;
	Wed, 11 Nov 2026 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435862;
	bh=aQzy62bRNLUxLuXSwWAKMfchOE1zaljkfjwJ1urF5cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CZ222hcNCNTfKeZ5NW1eOPlOWqJhsJoMq6UA+77CTeXoNBEo65l4f2VPniReKCbc9
	 i+jJa/zb4RFYCLKpDwVoLtovSEVrvPvVwTtgfT67CV8sDbVkyCOcd43aUrF+MeB1S4
	 QkBs3pxlIODnwEx8rco7bJ6NtLQS7L+bCC+rPopTyesBWZg4b4lPaTNiWX+SOHulfO
	 rB0krSQ82Av7D3T5s8JQJyp67N3iciLp5HOOd8ODJ0zOJdst7m+s1gcxJ5pHHoXtop
	 oWgz3CpFqc5cyt5b9Ao5gUkw8P3uD86AJ5o52qaxIlnyNPI/QWo9rPi4iVIoA8zC6C
	 zCCCQI2YVqutA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>,
	Rong Zhang <i@rong.moe>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
Date: Wed, 11 Nov 2026 17:24:18 -0500
Message-ID: <20261111222411.33722-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111222411.33722-1-sashal@kernel.org>
References: <20261107051336-failed-6.18-f91c2cd6dbce@kernel.org>
 <20261111222411.33722-1-sashal@kernel.org>
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

[ Upstream commit f91c2cd6dbcedf52e227b2eea8d7b99ecbac7552 ]

On some Lenovo IdeaPad and Yoga models, the battery _BIX takes the EC
AML mutex and then calls the serialized RDER through RDIF, while GBMD
calls RDER first and then takes the EC mutex. When the two run
interleaved they deadlock until the mutex acquisition in RDER times
out, and GBMD returns garbage that is reported as both charge types
being enabled.

Evaluate all methods with the exclusive helpers, so that GBMD never runs
interleaved with the battery methods.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Link: https://lore.kernel.org/all/58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe/
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
Reviewed-by: Rong Zhang <i@rong.moe>
Cc: All applicable <stable@vger.kernel.org> # 80892972ff23 ACPI: utils: Add exclusive AML evaluation helpers
Link: https://patch.msgid.link/20261018122348.679126-1-aliamemis@disroot.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index fcebfbaf04605..690311eb930d1 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -285,12 +285,16 @@ static void ideapad_shared_exit(struct ideapad_private *priv)
 #define IDEAPAD_EC_POLL_MIN_US 150
 #define IDEAPAD_EC_POLL_MAX_US 300
 
+/*
+ * On some models GBMD and the battery _BIX take the EC mutex and a
+ * serialized method in opposite order, so evaluate all methods exclusively.
+ */
 static int eval_int(acpi_handle handle, const char *name, unsigned long *res)
 {
 	unsigned long long result;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(handle, (char *)name, NULL, &result);
+	status = acpi_evaluate_integer_exclusive(handle, (char *)name, NULL, &result);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -312,7 +316,7 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 	in_obj.type = ACPI_TYPE_INTEGER;
 	in_obj.integer.value = arg;
 
-	status = acpi_evaluate_integer(handle, (char *)name, &params, &result);
+	status = acpi_evaluate_integer_exclusive(handle, (char *)name, &params, &result);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -324,7 +328,7 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 
 static int exec_simple_method(acpi_handle handle, const char *name, unsigned long arg)
 {
-	acpi_status status = acpi_execute_simple_method(handle, (char *)name, arg);
+	acpi_status status = acpi_execute_simple_method_exclusive(handle, (char *)name, arg);
 
 	return ACPI_FAILURE(status) ? -EIO : 0;
 }
@@ -382,7 +386,7 @@ static int eval_vpcw(acpi_handle handle, unsigned long cmd, unsigned long data)
 	in_obj[1].type = ACPI_TYPE_INTEGER;
 	in_obj[1].integer.value = data;
 
-	status = acpi_evaluate_object(handle, "VPCW", &params, NULL);
+	status = acpi_evaluate_object_exclusive(handle, "VPCW", &params, NULL);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-- 
2.53.0

