Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049829;
	b=WWbGSdwj+DAfUu3aqAKybqVNSB9Lo+c9OmGJb1slg9q0exLReq4lffgDF9Pr90nMp/n3
	 SRzXS96lWloChVLv/tccXKhFdQNh3t7qYbjo12jWkO9i+oG9mE0phW9idE3Ltf3eRBTnG
	 IUxyMO8hjVvM61LyxSUtkfrJfYTjTLAhwnuHrExtmeFGrrBUE5eIteqa4H1ecLkTGnfzh
	 5sUeRtu1idM/B7SEsgEWZXv6cDODmczJW17kA9d9mef0Ovl8tx6vpXeYZ6mOkU7jyxPJ+
	 D0blOVb2GAd7SzMyHBD5QEqPrkcF1yCgy3ykAgQgQX5u5cCy2pCtu/aIUFlp1p0Pihg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=E5uz/fEzS6TMbtZL6F8gwWg56i0GIhfMZYL8v5zGicg=;
	b=LpH9w04nu1jgpb5eCEMUemz2dhcc3RZUOeVY87cOD9W8khS0dsMkycLBfkM2tIs23cWb
	 T4vnXtkw2rc206cC7+qImEZVMWkeZOFcHr4/3Pu/ho4QeefAlJ3D3POSbjW07J92dNwAY
	 ntvMYjIu1RiUvG6j/40JfbaB/vhHxZ2MKsxkUoNRxU765YxAtHhvX/ygau3Oppu5autTR
	 pJkO/A/e128+KarIInzRluES982kjRpY8CMj33ZY7XFwmZ3zRUKXf76mwwoF/H3FSP0nx
	 B4rahvDoQgVpECqKwHDGRFtQW9XIy5rANcR5go8w/BSkE3/z6GYnMQ84W1DrNc0huQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezqSvtIo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB40606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezqSvtIo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322D81F008A2;
	Sat,  7 Nov 2026 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049828;
	bh=E5uz/fEzS6TMbtZL6F8gwWg56i0GIhfMZYL8v5zGicg=;
	h=From:To:Cc:Subject:Date;
	b=ezqSvtIova2kqHXgvkwPaQ6odsNZBHmtJwhqwbZzg44yK2//T2ZoKE1wADOZhPOxg
	 3xRgZ9f8CUT2HjfPLv0EYTwojsVUHitC6NX4ISvQYpD810IqMholgKMruuJDOl1waM
	 2sgu/kAcQOcWWhm//hL46yKP0sfC2ks4DVqD5dwtQS0OEZ2zL8iy30RD2v+ykdPAcW
	 KJB3QPkxF7v1+/mRv8DgMun5+IpF0VFI+La6EZamUN+ndZ6tBBoO0Bx4KijiYuyowa
	 ZpVywH7cLFxrsuYDM/bVcignA+OPIR/FwA/0GedNecfhD5SJRz2npHpmu1dNm9isQT
	 zrqCHw0jfLPfw==
From: Sasha Levin <sashal@kernel.org>
To: aliamemis@disroot.org,
	i@rong.moe,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:26 -0500
Message-ID: <20261107061026-failed-5.15-f91c2cd6dbce@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f91c2cd6dbcedf52e227b2eea8d7b99ecbac7552
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061026-failed-5.15-f91c2cd6dbce@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f91c2cd6dbcedf52e227b2eea8d7b99ecbac7552 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
Date: Sun, 18 Oct 2026 15:23:48 +0300
Subject: [PATCH] platform/x86: ideapad-laptop: Evaluate ACPI methods
 exclusively
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
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




