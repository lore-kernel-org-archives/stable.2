Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17226525A9B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572573; cv=none; b=MfKYHqozvZZtfc7Y5n9Aqu0nCPkatsNzsxtoJTo/YquWigEpNAw4Iyi84DzUo+s8RUr6jpJpGZcL/AlrIAAeJuMRPwUHq9zJyiB9hnAgtlEUOz/pox6umbq7vtBQoflx9uxLqYV9oFjg5BwpdvN2iU1q0e9IalNYKhmVyOhZmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572573; c=relaxed/simple;
	bh=13nl9TrzL6yXpf2VpunQ0dQlJxuafccpC1OP7FMrVk4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZJLObLA+G2eeKjQVyFJC2hp3/PFOQ5NS03FBe33qAYuapdjUvi+TXmUgYBPLOnbHpT9pvqVayRlMLQVUNWOX+L/qg1rQQMVqqEYdacnEzGtvDN/wpJp4RKTvPXelqxZRUXT5Wv3GDdADIdlBszhqk1uAEOW6+n2kkD+M57z5DG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tGNeBl9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tGNeBl9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C201F000FF;
	Wed, 16 Sep 2026 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572568;
	bh=cBaz0gTsajHh38oz49jOaGJwj01eKMtymVi/Vz03FkA=;
	h=Subject:To:Cc:From:Date;
	b=tGNeBl9xj8wgWJOUZ5Lixb4wIaffR5mH0f2ow3oblT5Dy4AV+s5YoyuaqZ7MKI5Gl
	 r5cJI09u6qtvjupbVsqnO/UJozVPyobdH/Zr9nSfA4ZebHs2VoQjx1YYMuoYSF3wES
	 33bq5VKR7mEdwgigKAB834mKPmbaA/i4YZq2gIko=
Subject: FAILED: patch "[PATCH] drm/amd/display: Rebuild InfoFrames on output color space" failed to apply to 6.18-stable tree
To: sroy14@alum.utk.edu,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:20:05 +0100
Message-ID: <2026091605-cavalry-polygraph-51d3@gregkh>
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
git cherry-pick -x 8cfd9e22eb5c04b15b82985ff913944f84673d4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091605-cavalry-polygraph-51d3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cfd9e22eb5c04b15b82985ff913944f84673d4f Mon Sep 17 00:00:00 2001
From: Satyajit Roy <sroy14@alum.utk.edu>
Date: Sun, 30 Aug 2026 03:52:13 +0000
Subject: [PATCH] drm/amd/display: Rebuild InfoFrames on output color space
 changes

resource_build_info_frame() derives colorimetry and RGB quantization from
stream->output_color_space. A Broadcast RGB-only atomic commit updates
that field and reprograms the output CSC, but none of the InfoFrame update
predicates include output_color_space. The sink can therefore retain the
previous AVI InfoFrame range while the source starts transmitting a
different pixel range.

Treat an output color space change as an InfoFrame change in update
classification and in both stream programming paths.

Hardware testing on an HDMI 2.1 television confirmed that its automatic
black-level selection follows Full to Limited and Limited to Full
transitions in SDR, HDR, and HDR with VRR active, without a modeset or
visible link blank.

Fixes: 6eb4c13a3845 ("drm/amd/display: Support "Broadcast RGB" drm property")
Signed-off-by: Satyajit Roy <sroy14@alum.utk.edu>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d6faca79f5720893843e649e70aeb19147ee0578)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a98ed4617a03..519ac878ada1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3198,6 +3198,7 @@ static struct dc_update_descriptor check_update_surfaces_for_stream(
 		}
 
 		if ((stream_update->hdr_static_metadata && !stream_update->stream->use_dynamic_meta) ||
+				stream_update->output_color_space ||
 				stream_update->vrr_infopacket ||
 				stream_update->vsc_infopacket ||
 				stream_update->vsp_infopacket ||
@@ -4188,6 +4189,7 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 				hwss_add_setup_periodic_interrupt(&seq_state, dc, pipe_ctx);
 
 			if ((stream_update->hdr_static_metadata && !stream->use_dynamic_meta) ||
+					stream_update->output_color_space ||
 					stream_update->vrr_infopacket ||
 					stream_update->vsc_infopacket ||
 					stream_update->vsp_infopacket ||
@@ -4370,6 +4372,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				dc->hwss.setup_periodic_interrupt(dc, pipe_ctx);
 
 			if ((stream_update->hdr_static_metadata && !stream->use_dynamic_meta) ||
+					stream_update->output_color_space ||
 					stream_update->vrr_infopacket ||
 					stream_update->vsc_infopacket ||
 					stream_update->vsp_infopacket ||

