Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435821;
	b=iCZS5hXnavp8SMkyBDlBUdXx/aPuv4vAB2ikYmihX8d2BU2i3PxLb415deTTr823oV88
	 qlOAu1NvlB2VicqoUEVWtJosYIjfimBZ3bYtyv8xyNX4gMv4vbNmjRQcLhDuv6Wy0+tdP
	 MVuSDglen5Aq6RDm0RMWX/MSdFrftrojVbfbTyD1FRxmlVDEa3ipgefE6doXpWEPwICtd
	 zvmof4fT859tSECy8EtSa5TzX+OpArh0/ruI3Uidc2zxE7/9NHikP5Y5Ox9ciRnQDqOUb
	 awV1TzEmw08ZHCafSS2+1BOAd7lF/59AQDs1w0V/aX7/5q0UKhERrIStBBhN+dXEoZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=d4tcjPHu8NfAvLtUttlSvJOBVuVIPcZ3lpGiyioqQXI=;
	b=PaManuFvN+3cCC23FAWiFK3M85o0LAieIgNv8zSySb1JwDy3VwlF3SolHbAJu2Eb//Kv
	 JLn3MUFSvQaHeu3Joy8HiPHvHCxL39wKNIJqa/Rk+7AFHwByzsymXMXA/LnY7KiIq4xVb
	 jCWZ7FBNPf83wLru5xm2Wzx+vVs19EB1XIxxwgsZK4r6tgqZk37RW09o4rWtYrpyQZWKl
	 +AjpHHI+4UVlg7joEjkzjiKf/O6UqNAh5AgkkmnA/TQHS7zHbsy9q4jZU3URnlnLH5CY2
	 tN2Lb5O2yC7rmGYWCTM78u+9/Maj36KsIEZ8FIMupXk93RBgyhBRjTTSNcxT9tj5rfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GumSzl3J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F9606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GumSzl3J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BB21F00A05;
	Wed, 11 Nov 2026 22:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435821;
	bh=d4tcjPHu8NfAvLtUttlSvJOBVuVIPcZ3lpGiyioqQXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GumSzl3JD3hBAgPJbR24aLYYMlVZiIsuisNNErl7e17LkVe9EWHzHOkMWIF/Pia1z
	 HYwRd3+NZPHIFv0l80ijo3oyJnLjwfg71zE/t5ei3opN7FNIfOf2gP/H5qmjl132ad
	 6QvXImc7HlYxJm1Elx4eVP/Ks4FrT/z4X5ewiWvDOo+lkbQC39ghPdM/gxHqNsR9/p
	 +PTtsaQwK8MZ8bVx5DxDPwCIQfkNXIb3gZ+9WYGmV+3kn+cKrilUFYC6qNW5Pe+cNb
	 rjRBTfiE3RXDWe3I/mh2pHwyW0nOj2XEXLEehhyInMe9FS/gZMmDzovUZ89/P58+Zz
	 cP6OXce50qkAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>,
	Rong Zhang <i@rong.moe>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
Date: Wed, 11 Nov 2026 17:23:39 -0500
Message-ID: <20261111222322.26306-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050523-failed-7.3-f91c2cd6dbce@kernel.org>
References: <20261107050523-failed-7.3-f91c2cd6dbce@kernel.org>
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
Depends on <20261111164858.3300811-1-sashal@kernel.org>

 drivers/platform/x86/lenovo/ideapad-laptop.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index 8213524504eeb..1335f4e488702 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -297,12 +297,16 @@ static void ideapad_shared_exit(struct ideapad_private *priv)
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
 
@@ -324,7 +328,7 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 	in_obj.type = ACPI_TYPE_INTEGER;
 	in_obj.integer.value = arg;
 
-	status = acpi_evaluate_integer(handle, (char *)name, &params, &result);
+	status = acpi_evaluate_integer_exclusive(handle, (char *)name, &params, &result);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -336,7 +340,7 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 
 static int exec_simple_method(acpi_handle handle, const char *name, unsigned long arg)
 {
-	acpi_status status = acpi_execute_simple_method(handle, (char *)name, arg);
+	acpi_status status = acpi_execute_simple_method_exclusive(handle, (char *)name, arg);
 
 	return ACPI_FAILURE(status) ? -EIO : 0;
 }
@@ -394,7 +398,7 @@ static int eval_vpcw(acpi_handle handle, unsigned long cmd, unsigned long data)
 	in_obj[1].type = ACPI_TYPE_INTEGER;
 	in_obj[1].integer.value = data;
 
-	status = acpi_evaluate_object(handle, "VPCW", &params, NULL);
+	status = acpi_evaluate_object_exclusive(handle, "VPCW", &params, NULL);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-- 
2.53.0

