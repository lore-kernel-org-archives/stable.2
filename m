Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050147;
	b=OwxW0OZ+axKuCKkoAfatN/ip+xS1aYkV+0AIeofN3qG2U9witziFbVHYsogu7m4a70cf
	 ztT3xQ3wk/PgSmz5mzhEZJ/ANMRH6buaBCePqMHvg6ekFgUcD4Ly2zTzttd89WuEPrZEG
	 +nWpc/HgVQhbhz4CUZuA4RF9GLw+yxWbbkjVahFHzjXJjnHfZQxBLvNiDMpN/C9ExVds1
	 MTZhxGimQPPBZeWmAhK2kqURDRHs+p9TPMEJMTg6McOWJc/cS6gkDkYTqXgzLBDb8k5QX
	 JPxUAxuJAJiwehLzVCcXRGJEg0jflngUtKs/wJHfhYN3SDQrpoD/G/lFldh1zmxUxpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050147;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uE90tTE2gnnP6wnjAzU45vmth2j8d9uCpt7/KvzVmAo=;
	b=4J4KDMEGdIJ0xl8+QNynSSv9MF8st7kvOv2l0MODuA0oquJziBgW91YAFFSn9zonI68+
	 o2lz7KPN06lX29SpsNGPlf2hyIuoNJHk/OueH93sLAFnnd1HGBQCM2SitjaVTXVLAG5nr
	 /1Fc45N9kx8nAY5woTEAtrA8yNAmWF2vuZdAYFMPwcLXIMWSCg0rCd7Xh7d1OX7OSj117
	 ZAWTB7uJbIr3j1+xugVFnF5NiEf6b/cSX8f9WmsbFKzJmw0gJkya1WFqRpaWxdJoaji0x
	 bq9hzOZhvA4e6B/2CkwDUkG4jC8id3oncN+aW/xILKF9HV7s2Do73gcYAIzc0pNIs5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxCXi1Es;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196D606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxCXi1Es
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C9F1F008A2;
	Sat,  7 Nov 2026 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050146;
	bh=uE90tTE2gnnP6wnjAzU45vmth2j8d9uCpt7/KvzVmAo=;
	h=From:To:Cc:Subject:Date;
	b=gxCXi1EsRmBOXJlanmWvxiVrm/SsqGKCTdoFDLeEl3PSePEUOmxRCbBq2YwZ3P9Kn
	 4lnlhjUz0AdOkxQ9ufVxBINhckwTlfx2MQvYQzE1ZVo2N0xNg1x2+ccxQ2raVj8STI
	 hdVW78AL5RfpZhduxJTLTuGRhjP70gvos7Imv7ThV8LDdPlHFjs6i5547p1YuzYRUD
	 IZR355c93ZPJ6gRjpXR/v9AQu6spjZc55Bj0ID0fJFGT/7y0Huh2hAFdBpjFmS9xev
	 uknO6a3OsTFo8nUAL2J/46N3HqOw7x1aeeMTljY4rxUpJW8TI3fVoHSaNLooC3vZsX
	 XhdZxV1imvd4w==
From: Sasha Levin <sashal@kernel.org>
To: imre.deak@intel.com,
	luciano.coelho@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Fix configuring FEC for a disconnected stream" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:45 -0500
Message-ID: <20261107061545-failed-5.10-270681fbffbb@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 270681fbffbba2b6ccf5b7e3c34b8b563b36167f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061545-failed-5.10-270681fbffbb@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 270681fbffbba2b6ccf5b7e3c34b8b563b36167f Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 7 Sep 2026 20:44:12 +0300
Subject: [PATCH] drm/i915/dp_mst: Fix configuring FEC for a disconnected
 stream

During an atomic commit after all the MST stream CRTC state is computed
the driver ensures that the FEC is configured the same way (enabled or
disabled) for all the streams on a given MST topology's link.
drm_dp_mst_port_downstream_of_parent() used to determine if a stream is
downstream of an MST port will return false if the whole topology is
disconnected, since in that case it can't verify that the port/
parent_port passed to it is in the given MST topology. This is a problem
during the above FEC configuration check, since
intel_dp_mst_check_dsc_change()->get_pipes_downstream_of_mst_ports()
will not return all the stream CRTCs/pipes for the topology as expected.
Since passing parent_port==NULL to get_pipes_downstream_of_mst_port()
is meant to return all the streams for the given topology (i.e. mst_mgr)
skip checking if an MST port is downstream of a parent port in this
case.

This fixes a problem where the FEC configuration check explained above
failed to ensure that all streams' FEC is configured the same way if the
topology was disconnected, leading to a FEC state mismatch error.

Cc: stable@vger.kernel.org # v6.10+
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
Reviewed-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20260907174413.741851-1-imre.deak@intel.com
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 6a869d0f6ffc0..20766b6c0bcfa 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -856,7 +856,8 @@ static u8 get_pipes_downstream_of_mst_port(struct intel_atomic_state *state,
 		if (&connector->mst.dp->mst.mgr != mst_mgr)
 			continue;
 
-		if (connector->mst.port != parent_port &&
+		if (parent_port &&
+		    connector->mst.port != parent_port &&
 		    !drm_dp_mst_port_downstream_of_parent(mst_mgr,
 							  connector->mst.port,
 							  parent_port))
-- 
2.53.0




