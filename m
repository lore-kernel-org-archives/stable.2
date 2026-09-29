Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE23B9D83
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698886; cv=none; b=paIbJnvWayLxGhNUlCxwUYLToST1r8JOxj43bz/etTNjfcM5gi4pElwprPrPmviresjs/e/043ZtllvPvhpDRhhCx/7m9eyw4FcZ1c3aAYBv6X3EepSb8U41lfgQeXI+/Al3ZeqUfnEpkssJwDA+7Jy5/LTOIVPu9q8Gb/HblVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698886; c=relaxed/simple;
	bh=jxGsU6Msw6PnCW7pjN8PDPxlPtUcN4nWBk6QLzEYvUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KITeRd//BJBmCU+bZ7ImGIuShhrrdvL61Ew3gV9bAVEqZE8sx10lysLogbypzp9msnwxeQCaaZzM0VhJyfCMUbyhh+gYJI6eX0VnCn7t4VokNd/Xo7Adf1zJqcoy5ioDSsVCAvebMr6GRpf+3Yl16axPtJmWRc/5wfIGAxdJ02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8/7rX6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8/7rX6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D0E1F00898;
	Tue, 29 Sep 2026 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790698885;
	bh=olTNj77v9bxtnxn7bHQMa83Gl+NOqY604QHIZVzoPUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8/7rX6HBvJOoayVDsFayJXSdvFfEg82iHIcRdu2nqggFJ+2tTb2vgRsNkrwfEhyl
	 kklhuCtRlDAPRCFPZ1sOpUmaeHzlEKwacamn8kTn3ZUzidWPibxc8Hq8d7cP41iGWk
	 U6LsItMgUR11bLESMuYZ/VcL4DwuJnaV+kWR+AaunXU+0A9SE+BjajnCydYJVojUFG
	 BiGOkGfqmp7w13BUHXSSaFrmveXl9IsLuHG75ihaAWtnGzbky/D4NONKJCydPJxFeD
	 P4tvfE4I3evUm/DnDS0xr+6dZScuysljvNBdCbz5na/9ULWLZbeRhMVla2VwzHH88z
	 BDJtwCHs8hOjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/i915/dp_mst: Fix configuring FEC for a disconnected stream
Date: Tue, 29 Sep 2026 12:21:22 -0400
Message-ID: <20260929162122.4190498-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929162122.4190498-1-sashal@kernel.org>
References: <2026092954-aliens-penalty-0786@gregkh>
 <20260929162122.4190498-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit acbe9a3b60b9a6ace8ef11fe898f586251c84592 ]

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
(cherry picked from commit 270681fbffbba2b6ccf5b7e3c34b8b563b36167f)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 4e66fade6301e..5d5d8adcfb6af 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -739,7 +739,8 @@ static u8 get_pipes_downstream_of_mst_port(struct intel_atomic_state *state,
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

