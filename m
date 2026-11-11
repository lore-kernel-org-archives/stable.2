Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436581;
	b=M0L2zSDPbdoKg9bmJHsJtmPOpOW96cFrlfK/g4hm5OT7Lj5dpNfRkS3/bkfHpxEmj+1J
	 UOxJ+JxpTyge7jptg5Z7D9cDcPvYs8H5fxgOEtnt+fI8zZkDvA7KTyUdTTtK2elvaduqR
	 6OygKknQCB6FA+iJuBNgOQ7KQtHjSsLzKjHSdjCioXCWFzE6NogLFgaKnh/oGX7CRsMSl
	 pptabBwAwDzqPPz60ZY2uRm4uvriNB6zgAvxb3xHXWf+dEIj55uk5Oh5CCB248t1WwiRC
	 kl33uocf2MBzmRWDvyNuvcsK/RY5PGDmHHae8T8McwmEWbRyEui4yYUAgeDbtOJ+Vkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BUHN9tEdVmSq27BmVyNI04Mcl7hDwS1QoQLik9wXEkU=;
	b=2Ap9Pmgb5QVy+x9bV99aHxn37GN0RLwumQD8WO5Kl3DaHXZ4BLnMdK4O94IHctEEr5js
	 SB7kHzNA6c+gtFC15aD/P5Sq9omWj6ReUaAau5KFQY2d/ge22HJorKI1lTK3tT7Uwe86D
	 4akaKyFivwgnYCUs4GIGBrrqvEXJVEBnF53i8VunNk3LNPxOMaNlxl2QfWu1ykMYe/pmM
	 demjtNUsDPc+mfohNUyDNu/D5P8d0qEEfF6CXSenfvkyEaGTc2uNXMsyh2lftwACsYjTt
	 k3JeUqBiHpDeRptkCuQXABKccRX9hjawRXpyKjAzou/01W8JmplKPHjMY480qT5DhOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="o11LB/ZZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1760A2607
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o11LB/ZZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C5D1F00A0A;
	Wed, 11 Nov 2026 22:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436581;
	bh=BUHN9tEdVmSq27BmVyNI04Mcl7hDwS1QoQLik9wXEkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o11LB/ZZVfnZl8Nm1bdNFoZnufKSJ3T4wPRAP5vQm6UIiK1EMjHP6H6quy8xSYCgh
	 DhDNTDthiouIGd9Nh7R+V8NkgycsSeXgfFRh/BfNFo525SadadEH7TMmkAhbavVPBR
	 8eBB4Sw+INMt0rLvXuxC4TMQaATZO1SejPBaWDIMkTI6z9s8dCVJsriBZa1WePZNcg
	 H9a1BbYuZm8lVefzmQx2vzaGBEcj/GTjIYo3TiR6o85G2EC9M+lnoMewoR8uF4yv1N
	 Dclyw7ODzZd6tPCucajvRxc6kKY65GCOf34/1R8/BJo2hrh9qrjO9udoBLQo5jmnaq
	 unyOQfWC3hNEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>,
	Rong Zhang <i@rong.moe>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
Date: Wed, 11 Nov 2026 17:36:18 -0500
Message-ID: <20261111223612.68828-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111223612.68828-1-sashal@kernel.org>
References: <20261107052518-failed-6.12-f91c2cd6dbce@kernel.org>
 <20261111223612.68828-1-sashal@kernel.org>
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
 drivers/platform/x86/ideapad-laptop.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index c7e8bcf3d6239..6349defc17385 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -282,12 +282,16 @@ static void ideapad_shared_exit(struct ideapad_private *priv)
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
 
@@ -309,7 +313,7 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 	in_obj.type = ACPI_TYPE_INTEGER;
 	in_obj.integer.value = arg;
 
-	status = acpi_evaluate_integer(handle, (char *)name, &params, &result);
+	status = acpi_evaluate_integer_exclusive(handle, (char *)name, &params, &result);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -321,7 +325,7 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 
 static int exec_simple_method(acpi_handle handle, const char *name, unsigned long arg)
 {
-	acpi_status status = acpi_execute_simple_method(handle, (char *)name, arg);
+	acpi_status status = acpi_execute_simple_method_exclusive(handle, (char *)name, arg);
 
 	return ACPI_FAILURE(status) ? -EIO : 0;
 }
@@ -379,7 +383,7 @@ static int eval_vpcw(acpi_handle handle, unsigned long cmd, unsigned long data)
 	in_obj[1].type = ACPI_TYPE_INTEGER;
 	in_obj[1].integer.value = data;
 
-	status = acpi_evaluate_object(handle, "VPCW", &params, NULL);
+	status = acpi_evaluate_object_exclusive(handle, "VPCW", &params, NULL);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-- 
2.53.0

