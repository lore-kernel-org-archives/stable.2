Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B4D40099D;
	Fri, 31 Jul 2026 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503413; cv=none; b=W9X5l+wCHhGtpWEd/eqa/TL60ubxfK37GaIMgZe/k/tIZ5vqAj51DpALnuqsP7YAU25GpTD8ys/PzmP+12TqWPJZCIYz2D2YHMeAcPXkE0TRWfLSF60AZzf1LtMi8YHipgupQBBFksqpGZ1nz+Fo9f/yrkUKGPvB/K8jR44bK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503413; c=relaxed/simple;
	bh=9WVkLD2lLcg0SFcbtY3rhbmFcO0wynNwKdmGgeYUQz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/jCzTap24AzDTKFKs0PwkNQPW4jtPjLG+Yeood/WY4Z+B0Wt6w2fJ+1lafD+wl2+mRA6k+zwrxXPCrXVtFaIsJvkzoRYvSdd1sSOe/VifDswBfcZTfVF3SiPbHxjTWfQmkn940WU+pPEr0X+sVFHZnNlc5IucJKArbfrh3qWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=YkLoNMaH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fWVsSrV/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="YkLoNMaH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fWVsSrV/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8569F1D00101;
	Fri, 31 Jul 2026 09:10:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jul 2026 09:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785503410;
	 x=1785589810; bh=0MZZibYW67xADGTAt/lSyot78KbHgOWc+Oa0nMmO+Js=; b=
	YkLoNMaHpk47MLjfAChDj3IJN8DAEoueUAmLjjfU4Gwy1lCUbW/UmLbx91AzhsIK
	diHVLAcZ/+32O73cem7qQuvkS0fZnJ65mTksqyDqtODLz40PoGNoeFtqX8tXp+Ds
	m/oePy+ch00dBSh/tKKh8uZmVr/0pX/3WogZybKufLyjmonR/lPYyG1vr+J+bKXA
	ydGyv6on30CeRcXm4Yn887FrxI03C6elYdq7IwREMN4mwju1Z9E9cMvVZfCb5pu0
	DWQiGHXq/dofGym4l8vQsWyfEL6zQjWuAEd4WfjPdwJZKFl7CjaCvR2B1c2J7/ci
	J5+/FEQ14YSwDvBPw34YKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785503410; x=
	1785589810; bh=0MZZibYW67xADGTAt/lSyot78KbHgOWc+Oa0nMmO+Js=; b=f
	WVsSrV/nO7PK9we9ol1qxpz9iK4beucyqdrDdGSQenjX6RbdbY3F1nVLyOyiViRp
	iAcgwzl7y81n6r5TkAgV7v5bTDZ53Qs2S+rfIJAIJrISpMLpSdySTMPhKAgR9YAq
	Y+Ox88xaGLFJ1C3Xfqyr7f/f0osqddPSUtuAZ9PksI1Q3ZUsonDpIRwR0/M+jQB/
	Gw2FooIBLYXcz7LdnMhSuPxXHrMxMV6YX1W08LD5RYJ4mCShUM5NZIbXXg2Tjbrq
	+29NUACAQLuLlaRsbMUlvBOb/H4q71xRlKunN7yXmPOkxqpk5ChHwHZsDMjGWrzW
	A6C/QbQMNZAJDwYKTaJSw==
X-ME-Sender: <xms:sp5saraxsOlhaqGR3AjHBeO8wkzfByac6ri5piNr539PYfi-ru7y7Q>
    <xme:sp5savXjOfWk5PpfIxcD5PQ03b9Ws-ivfhqLijnJw_h8z0QNX29OJTBQJY_HTaCoK
    DqbDLLSktjc1PG7QAolVCleB7zA_zdyZRl2ID1X6-jclP_SXthtkQ>
X-ME-Received: <xmr:sp5saiNd0Imt598bUzkSYMDWcBXDz9kaP4buVEhLCHOwOvjigh5IwENajEo1WziM5cnustjpjIVolBSp2Q>
X-ME-Proxy-Cause: dmFkZTGMegkBMIH5qpuWckrHEVUojchyzO6NIccURlPweuDN5JEQfNBPKB2dx8aRw3it3i
    NomNL1wqkeY81e/5vakyroDkM6w/fDio/T0pdAjdpFYi+Jg+yVmD6AsSDBfcEAbtqnSP2t
    ha449OU03nVQnhvYCjWFMbLNB8Tdz/A2v0UOo7ku1DmRssgZvhtavxt18+GuAj/fFieLyY
    wZm+pBemDfKPZ6kYaDyYI6tViNLSSHpw/6sSNQcSte+67NNpFWbI4S370yB0qyh04gxlxu
    h+Ucl6Rv4poGjf/HB0TkxiEREK1mv2QDn5eWXCEd/mvPFuglFk2AebFTAqeX8tKYkHTEf5
    qzmP+70NDUVeqG0u4/dPeSos8mRrEQloINL+gSeP+q57Mn+pxM7PN1Ket2GSMtoJHpxpUN
    Bs7ko/Gks/SOa8H34E29O5lpdLhUUSSPT4V2K32ZQURt5+6E/yGNebdBSDvtpQR8Gemq49
    SRCmcuax7RIVzD6OAF9dj/rUfOdlNLpZMOH6/uJPd7MB03HQl/SE7p0hpRNgg9Z10GFYyD
    0T2+OXkfhhNABWud9FBAsk35h6VUx2CWOknSebIDBBrUAZsEes0i8nP1VS36hSAZJ0d1Ov
    zcYaRv8LTZviVuJLKdVkfvKSe3ceLVO2oiH8A3RfuxFReoJHBbez4MvHgMhg
X-ME-Proxy: <xmx:sp5sahbQSilzXWhmLhGkXI5l-pOPOPZSRL72yyGk3r_pvRsbmULSGA>
    <xmx:sp5sap9ZHX1dnl-TFH5SZalZncJCBtC40n4U_Vc0_zt-_nqwRaPivQ>
    <xmx:sp5saqTpY5w2zIyPqlCIhTSqz6ZBN3I36kFA6QwntOJWGUiO2SSwiA>
    <xmx:sp5sarcLSml_57ulZxDpWZK15AEgSX3GVfPDZ6NDTVmdjf9JfGk7gQ>
    <xmx:sp5samC0uKAiAl1Ui_ss23l64AqaG7naU3LTsIIqKpCvN9MwXOToC7IJ>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 09:10:08 -0400 (EDT)
From: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
To: Ulf Hansson <ulfh@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	=?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] pmdomain: core: Wait for device link removals before dropping genpd->dev
Date: Fri, 31 Jul 2026 15:10:02 +0200
Message-ID: <20260731131002.142671-1-linux@jaseg.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ivkwuomer5vsajf2lq6otpgxwqljkwooh3p7e5ne23j37pv22t@iluamo6gxmq3>
References: <ivkwuomer5vsajf2lq6otpgxwqljkwooh3p7e5ne23j37pv22t@iluamo6gxmq3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

genpd->dev is embedded in struct generic_pm_domain and its release
function is empty, so providers free the containing genpd with a plain
kfree() once of_genpd_remove_last() returns, ignoring its refcount.

Since genpd->dev is registered on the genpd provider bus, fw_devlink
creates device links to it, and those are torn down asynchronously.
Nothing made genpd_remove() wait for those teardowns, so the provider
could free the memory backing genpd->dev while the queued workers still
used it.

This is reachable at boot on qrb2210, where the firmware rejects PC mode
and psci_cpuidle_domain_probe() removes all the CPU PM domains before
returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but shows
up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
causes the kernel to crash a few hundred ms into the boot.

Call device_link_wait_removal() before dropping the final reference. All
link removal work is queued from device_del(), via
device_links_driver_cleanup() and device_links_purge(), which precedes
genpd_free_data(), and flush_workqueue() waits for it to complete.

Assisted-by: Claude:claude-5-opus
Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd provider bus")
Cc: stable@vger.kernel.org
Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
v2: remove this note from the commit text.

Note: This patch was LLM-assisted. I reproduced the issue and tested
this patch on hardware, and I did my best to verify it by hand. However,
I'm far from an expert in pmdomain, so YMMV.

 drivers/pmdomain/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 842c4169e290..4eeb980e5a40 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2348,6 +2348,9 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 
 static void genpd_free_data(struct generic_pm_domain *genpd)
 {
+	/* Pending device link removals still reference genpd->dev. */
+	device_link_wait_removal();
+
 	put_device(&genpd->dev);
 	if (genpd->device_id != -ENXIO)
 		ida_free(&genpd_ida, genpd->device_id);
-- 
2.53.0

