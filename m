Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048125;
	b=cxl8Y9YH8QTbpEOEf7uXk5Py6eYtupaNrIMk1wDdLS1vPXdsxlL4sewf/lc7Q8q0lpM3
	 of7joSHbyAFlwHgXgDircUXkn4SZs40W7eUNINVVn6j7Iol9nrQuf80s+0sRk5TeAcqJN
	 aFFdSAF/8B7cpMfixqAaUmZee+5qvIo46eZEnnPbxhUdMCkOdjx2Wl1XsPW89jDyB6YTz
	 UkzpHGAK9ffMrWYaIZsPPa2Ph0RxDU9UIypG2pp0wGssjYtaLFbHBcXZtV9Dd8PPXG72C
	 q/KvxKAMt8eJbf27z6Axa++yELEcCuGmIj6QVTnBGGrIaVlwnGI9jMdpKPhMCQuIr0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048125;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EhFPW4WwrrQxXgf68Ly3TkYrtq4Nk4ZmsWWuAr0xmgk=;
	b=0J06oYW3Xg3W8JHbejlSOvJRl5dTOJnCxKPQHf3SB7i5LSKJwiSPUW8IfwKZTKmiprUj
	 uNOI0ognyDqfA84TmPET8HiYUkW0G6SBqW6xknkMGaaUVMhUC+nmzPnJGodpBKO95Xhi3
	 QQq3iQoU4vSylgHCEC3KxlivlnvZpVFprAjtW9V0w5StjbQ7x0co77d/agvZMXbpDaSvi
	 BWkvF3gptTtu659JSyR1dUWqqjwxx6K1kwgO+WOv38qhvEMptX8mJLPa9ObTO0KM7z8IU
	 +aic73uYhqEOAlhDnd9vshulghq9WKSFrJ6ViYxcFmGTd6+xlvfitHHYFK546KUkJdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqFdKddc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D2606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqFdKddc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03F81F0089F;
	Sat,  7 Nov 2026 10:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048125;
	bh=EhFPW4WwrrQxXgf68Ly3TkYrtq4Nk4ZmsWWuAr0xmgk=;
	h=From:To:Cc:Subject:Date;
	b=LqFdKddcH+I+RQtBSdaaXa61R/TNBZMmqYr2CsmxMMJMguJOHHYtp5eja0CKSesSh
	 oxcLXbz7a0T75K6Da9n2KqaNRBBGUN+l/4/+Tr5/3hYqa/NY3oWJxkJXvBPbaB68Q6
	 jYpENe1EsORGLMkugfQIM6XkWxgd4VOdw9QecSp8yKBI5/vMVNGVWKzwCZUARDMGa5
	 vJ47D5ML41BggT4XLyXeLMJGdeNXFx2dgigpAilTPP6iZBgyAq1NvC1/9m1W7ExvRZ
	 bcrXyBeR9Xq9k92eA1Ah7kjMRLzrFPo4MXbfkJZJt7Vqpd8Y/w6kuIV5AT4Rgw/tzk
	 pr9b2wgRqS5BA==
From: Sasha Levin <sashal@kernel.org>
To: imre.deak@intel.com,
	luciano.coelho@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Fix configuring FEC for a disconnected stream" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:03 -0500
Message-ID: <20261107054203-failed-6.1-270681fbffbb@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 270681fbffbba2b6ccf5b7e3c34b8b563b36167f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054203-failed-6.1-270681fbffbb@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




