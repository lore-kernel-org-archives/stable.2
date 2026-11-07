Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045794;
	b=R2cZ7fPknVQmphjanFIFnhEnyZgDMLJc/C2j82bf7ppJ0xlIRyVG2y5CL69INZ9H/WPh
	 NuocIG5Iiuc3US+AIVN6Gadz2mMwL6vJyXmE0RoA7vZqo3lvBrHmMrZ6FcwyL8Dfe0eg/
	 AJ7PWgt0Ku265uZPBwrRbPMeLfRU94WTDnWcojY5O+swvgCnmTk2rUb7sMFEEzpZNRYQ5
	 p8FZo4ahYSjRxBVjQBfMRCXWiwBwoqZ1caazN0f0DtExgBAUjIeb9Lh/PKfBbJvClOhd/
	 BXoGEgPMAtMnOgYt4ypPGDxL6CWdI7yMC0p26YCGU8m+eQNY+9zVXGQMtM0FsHZ5sMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DeAvFJCS031cl/E+Q8VXXOLqGYdzwPyK51g0xGmQOAw=;
	b=Ixf/zrtc8295/meW5jH74Lg++Bti+wD3CH3AITsQm0iUL3EhUCuEjc+Ro7/Vc2Jq5o/z
	 x5UJgGI6dWOSSGIN5zARLFBEgQJ1fCWgkfOejX/pp+ZuhgA61WitSdYwTYAsip+NfBQ+y
	 X393Qk+Viwpg5ZhpxA9gs3IrsYtteTenQBhL6W1BU9WnrMdTr5jQjcQqgBH3PPJsKhixs
	 uA+R1kjTmfJ5SBKfBG1EaLhYtQjFTgoQs13Zj2PaXMol6YOfBUeirhrIsKS+JEJ7TFnCY
	 flKndwBAmrHYX8YGtweemCeHm3LmreMcMTppYmGPPQg1zE2G0RqeKjoHtEGOFJZEG5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSWFKClX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5843606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSWFKClX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114301F008A1;
	Sat,  7 Nov 2026 10:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045793;
	bh=DeAvFJCS031cl/E+Q8VXXOLqGYdzwPyK51g0xGmQOAw=;
	h=From:To:Cc:Subject:Date;
	b=BSWFKClXfpy0Dg2qY4fRdmrT5JdR+iNPMnK4RRlxMIXWBzh2Og7gdC8eqkOBVVCxg
	 N2CY4v3ZOi2NaCZEcDDdJZtORi6h9f/RthIneAKFiiqhKNFdcuvLfV6llUDg5NXDqT
	 TW2C9nEBErOvOFbUAF23KnzxOOYGXfTQJGCcGPr+3j6HiHcK4nJopZK2IAobGTIgen
	 N5HWly40Wr7OkwsBlIziiwj4UPRsF23H14SyQiugavlwO7q1elJl3mEQUlO6Et0w2h
	 8i+83CApICDP4C7B6EBe32b6Edmlou0DlZEeKIom0TDQNs/EENhu1F27wl9oWxwleh
	 dzNs3DTzVtYog==
From: Sasha Levin <sashal@kernel.org>
To: imre.deak@intel.com,
	luciano.coelho@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Fix configuring FEC for a disconnected stream" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:11 -0500
Message-ID: <20261107050311-failed-7.3-270681fbffbb@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 270681fbffbba2b6ccf5b7e3c34b8b563b36167f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050311-failed-7.3-270681fbffbb@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




