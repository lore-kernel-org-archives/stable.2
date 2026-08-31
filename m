Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2B374A05
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203234; cv=none; b=bd/HwqsH1IhoS7MA/2IOdBJhhfxzkdJyoURbhg4hnTcbhQndneTEuDyz3rKHJFz2YkxOAhrG9vpfZS8eXuJZqPPhkloCgMTdOndni2pPm67SXgxklwaEh8UCrJIe+enVLWUm1Np2fz50nOTmxt6hc9SL0horM5kI4D5f1Kwn2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203234; c=relaxed/simple;
	bh=YfZqeRZrcJPBWry4Smdt/KH6SXG+19VL5sgSi8beNLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DC9yUUSrLCWhB7SaOkot6fVNnpx1QC5Y4TX66cATTfR+PzCOo7p+Ai7/JbHMPoA7oLP+9iVgtNQxpR1Z5CnVldsmz6jL1QZKDCI3+mr0I8zGb/6lABCGTGC0nqn7erygT0giV60pd0Z5hwVt5k6hTVoJ1vBh1rnTWcN8M4cYfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVxOY1im; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVxOY1im"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so117427a91.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788203232; x=1788808032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhr6N2Xsb/i2x+PD9jyfBlndkAPLcSMGtFPyBSSzCz0=;
        b=aVxOY1imqlB8dB0UcfYnOn/zmcm7xzkdt5r5jxzay3eBVTLPs+WmcUddQE0DAkWbNQ
         uO3T6Ts0Rg5cktaCbamw8HUamRy8QiESAfk5KwepDoKJuZ0sjVQ0Wl49nnchOhWLYkgq
         5a5XDWnWW0ZG031ldKyUJYe1fWfkgyLeanqYEqCFxiqh7XjFRO8FvPnVPW89JOps8oL9
         9Ng8/shhxcAiONr3Reni3kjlVcXMEDO12Yhrb7bDUvHTaZ+IKE2+pl2Q2n0FNjS4dAZW
         gqV23SEFdIRrOf6bb0LLb67Ehz/y7WaHGEiN++pzFY7CD9n4JxwJPm5FOODktr+Xp6+j
         A6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788203232; x=1788808032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hhr6N2Xsb/i2x+PD9jyfBlndkAPLcSMGtFPyBSSzCz0=;
        b=rot8d9pRi7900zYfF7DHRjySBK/5vrF8KXFeaK+ARqcl+RU9AdiKEh6eb05JjiwYNG
         5wXz7wRBfgv0lMi0vV3nwQ7j+pqh+54oTDmU43YGt6aE8pCuBqRtt1nw2/sguOhHfnzs
         GXgkcyqaPHfkQxvmhGlffG0LoqrGOZj/VdIWnoFa2Wci/KrawlEeMiG0wt0s++gH2pzf
         ANjCFaIWikJ3Ajtvlhhttf1er/t8GZFXl2B9jQweZ3S/GbdVTgpj4KcckaJcCY/q3icn
         OOIydyM2QxkGdQdwsWPp379CDeQ35jjH7L9IoN7YKd7QBfE/s0TGpfeAPKWRBovxbXF+
         0f1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxVpDDUhb5GomczTySe2UV9QfhHMpjxnfv6/Q5UH9ZWS70hIifnF8oX+i25w7mR/DF27ZS8/c8=@vger.kernel.org
X-Gm-Message-State: AFuF++nNwRxVutpV7hkpC+oyqgD0Dx3H1dXTl+q8oeJzE9TIgweRpdD+
	6JsMBT0Pt94ie/t7UiJmSZv+eECdvYpHJT8Zm7wizK16jE5lsRFtiV5r
X-Gm-Gg: AYBFou3MaJGmYgwXvRH/6rU3rN67CrkIuydtpulJOtxgnCMKWK/VD1axFBGBAq4bU6/
	IINREZED1QN703tThs9WWO6PIcQCNkclXaKfQnqsy53YG0rncOw+thrrvCXmcYNhm8J3Zo4zHCF
	NBO+kfJg5h+QvnmhFVJg/ADeCG9HmjrvM7wmJR8F1/ycgSTm2SAYLRsLud3j2MKgjegnGRcrV+I
	cS53tQMNaQeWbF+gTJdMFomYhhpCIa1GPYupFuJd/Y5rVmzyaIDtRDh2+PEh4rq6fwb3GI4WzS4
	hW15VUz3J1y7m1qJs+Lan8Scff+Vs8+oKoyhmK2qYFKrZhF+DaDO+4sAU0gIl69rT4oMs3q25wj
	et9t/RHHTUYEAC3U1QYBOiIjFdYVw5jTnwvJcpqc6mlHqvLuKZWoiEFEhTB/LADur/uBk3JR3tU
	PBIQhGwY8UCaJBBdoiFWD2dxTJ4Nnvo1PQZNt8U8AezQqv+bhIhmTv8t7tcFc7jYe+muejxtUuF
	YKwWkZuHb0d0tkgp+zitZTy4EHAHSHpTF4jnLE=
X-Received: by 2002:a17:90a:e7cd:b0:395:f0e8:9e13 with SMTP id 98e67ed59e1d1-396d0e71ad7mr40889615a91.7.1788203231598;
        Mon, 31 Aug 2026 12:07:11 -0700 (PDT)
Received: from localhost ([2409:40c4:13b:7a31:95ce:ef4b:57cf:6fd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d2e465sm46219699c88.4.2026.08.31.12.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:07:11 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathieu Fluhr <mathieu.fluhr@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Subject: [PATCH 2/2] xhci: drop 120ms U3 LFPS wake retry wait from runtime resume
Date: Tue,  1 Sep 2026 00:33:49 +0530
Message-ID: <20260831190349.29590-2-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On auto resume (is_auto_resume), xhci_resume() used to msleep(120)
when there were suspended USB3 devices and no pending port event,
to give USB3 devices time to resend their U3 LFPS wake (at 100ms
intervals) if the first wake signalling failed.

The hub driver now holds the SS root hub awake for
USB_SS_ROOT_HUB_U0_WAKE_TIME (120ms) after a resume, which covers that
same window and lets the pending port event be picked up through the
normal hub event path. Therefore, this legacy wait in xhci_resume()
is redundant and can be removed.

Cc: stable@vger.kernel.org
Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
---
 drivers/usb/host/xhci.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index a9e47e178c28..b0caba8ebf18 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1083,7 +1083,6 @@ int xhci_resume(struct xhci_hcd *xhci, bool power_lost, bool is_auto_resume)
 	struct xhci_segment	*seg;
 	int			retval = 0;
 	bool			pending_portevent = false;
-	bool			suspended_usb3_devs = false;
 	bool			reset_registers = false;
 
 	if (!hcd->state)
@@ -1245,18 +1244,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool power_lost, bool is_auto_resume)
 
 	/*
 	 * Resume roothubs only if there are pending events.
-	 * USB 3 devices resend U3 LFPS wake after a 100ms delay if
-	 * the first wake signalling failed, give it that chance if
-	 * there are suspended USB 3 devices.
 	 */
-	if (xhci->usb3_rhub.bus_state.suspended_ports || xhci->usb3_rhub.bus_state.bus_suspended)
-		suspended_usb3_devs = true;
-
 	pending_portevent = xhci_pending_portevent(xhci);
-	if (suspended_usb3_devs && !pending_portevent && is_auto_resume) {
-		msleep(120);
-		pending_portevent = xhci_pending_portevent(xhci);
-	}
 
 	if (pending_portevent) {
 		if (xhci->shared_hcd)
-- 
2.55.0

