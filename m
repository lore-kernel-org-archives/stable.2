Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621E3AFCF1
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669749; cv=none; b=UvOxMofN+ZjltXflcgDowxRwZJgsRT0/zZ3TP0MX+8p3fSLLhGGthn7ny2kuqzKLAJfvAJDD4jIy/fxGvgRsbv90CVkD4J/29YnTh4qRZJiRRZTwCo/zV92x52PhxgZInew5QamvwYwwe+kgMskiOdN6eLWvvdVbdz4vStYbHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669749; c=relaxed/simple;
	bh=YdF4mJof0XqZs+KpPAmlOR4G7NNz9W4iRsbMHUHao2E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kW/b1KWvJdCRuwIhPotGnIEoVeLltFhMLEUzzC0rU+Un1ih8rq+ww9RPJ8QckzYqOyumxobk9g4cSEttlDe+rK9VideT0uvEOkf3R7SeDnzvfVpfEElpL0okZA4x93CbxJr4obMnynuZzt9K8cpemRKt7EhRifWWd0cveDBYIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vjR/ESDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vjR/ESDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9851F000FF;
	Tue, 29 Sep 2026 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790669748;
	bh=r+q/dSvCPJ20cuEjfzX1SrNz4hcY/zeP9H8rfqSXBIo=;
	h=Subject:To:Cc:From:Date;
	b=vjR/ESDiSbCj8yrIwopcBMYG3XLpdl0i5Eg/R/lJO2EhQ1KeSldkExeqZ0FZ2Yepd
	 aWUjZKEWOzEpoQIWAhVRnjBqQ+rMYtYhj1ROHJZfqOTUL7ymMU1du2BsVvb/NA7mrK
	 ajQbdrF73Mis7o2Kr4UpVxU4ThWQn0Afe0oB/F7c=
Subject: FAILED: patch "[PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus" failed to apply to 6.18-stable tree
To: ankit.k.nautiyal@intel.com,annoycc@gmail.com,jani.nikula@intel.com,nemesa.garg@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:15:42 +0200
Message-ID: <2026092942-evaluator-keenness-e26b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 5271d81f99dd01d983d439930eb056952485e15e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092942-evaluator-keenness-e26b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5271d81f99dd01d983d439930eb056952485e15e Mon Sep 17 00:00:00 2001
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Date: Mon, 7 Sep 2026 09:15:55 +0530
Subject: [PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus
 14-ew1

The eDP panel on the HP Pavilion Plus Laptop 14-ew1xxx advertises HBR3
while leaving the TPS4 support bit clear. The output however flickers, once
link is trained with HBR3.

Until commit 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink
doesn't support TPS4"") such sinks were capped at HBR2 by the TPS4 check
which incidentally kept this panel stable. That check was reverted because
other panels legitimately need HBR3 without advertising TPS4, and the
per-machine QUIRK_EDP_LIMIT_RATE_HBR2 was introduced to handle the affected
machines instead.

Add the machine to the list of devices that need the
QUIRK_EDP_LIMIT_RATE_HBR2.

Fixes: 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink doesn't support TPS4"")
Reported-by: Annoy Cc <annoycc@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16743
Cc: <stable@vger.kernel.org> # v6.18+
Tested-by: Annoy Cc <annoycc@gmail.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Nemesa Garg <nemesa.garg@intel.com>
Link: https://patch.msgid.link/20260907034555.2753846-1-ankit.k.nautiyal@intel.com
(cherry picked from commit 550b703fdbb2a2022faa75b4b11ab135241afbd9)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 33245f44c0d5..7d7db774d8c7 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -257,6 +257,9 @@ static struct intel_quirk intel_quirks[] = {
 	/* Dell XPS 13 7390 2-in-1 */
 	{ 0x8a52, 0x1028, 0x08b0, quirk_edp_limit_rate_hbr2 },
 
+	/* HP Pavilion Plus Laptop 14-ew1xxx */
+	{ 0x7d55, 0x103c, 0x8c31, quirk_edp_limit_rate_hbr2 },
+
 	/* Xiaomi Book Pro 14 2026 */
 	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
 };

