Received: from mout.freenet.de (mout.freenet.de [194.97.212.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E447A887
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.97.212.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047327; cv=none; b=kjw9TZ3+cSgXXDSKvdj1AWPSg3RxTZcGlB6yf78l5AB2sZphatETDTZhGjasEs+CNUdEoMNM/C5mALkUna4Z1yt3jy9fQo5ZyefYZBKeY8VkCZXEEk+wWuFKVP7SWz49svCDIIYPMb6A9Dck8s1wJa0vuMzLIvbY3bg1N49vYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047327; c=relaxed/simple;
	bh=F47v+CqVRHVHhzgSDdecuHutSp2HwoHKJ5RsQoOtAhw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FXaUtWDkrGaqhfQ2v8quPc6tzEWoaYzHha//z2MgUWMXbeS6G01fHjFOibS/cxWg6sJJxdd9NTcEb0rCuXhZg7bscz/y8Kx2s8el7xjynVcDSC43+6gZZSqqBywiyrz9OFy9dEFOCBeBRUZMEV77VeGb81Lsc5/T1fvhqUpmJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=S0+8FXHg; arc=none smtp.client-ip=194.97.212.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="S0+8FXHg"
Received: from [2001:748:400:3319::3] (helo=sub3.mail.fnrz.de)
	by mout3.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port 25) (Exim 4.98.2 #2)
	id 1ws4Pl-0000000DqNW-3ceX;
	Thu, 06 Aug 2026 22:10:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=tfWgs6bBT62hg3N7YvNHXQrbORtcMVZXfA9nOxUq4F8=; b=S0
	+8FXHgcJw8luOYUSLZSq92f15xPnryh5QHz9vTVjNDdUqMy1zLwkHkjiP1ZpyZo9jCTNQCLCRSp+T
	hB5zsBEvg7/SH87+DQSl3a3Z41Ps7pUwpfJZjSfPplLDJ1QgM4yyVhBrm5TKxBqMOBuzpi9dnnH9I
	nqYXFr1+FU0P561JRUZi0rNlKNdmpbzQQcCsDcW8cTdkAK3Ncycjs+UdTOFaThEBaNmwzRq5wBPJI
	FT0XAEWdIi2o7aWn6GmkjQSyD3CGJIbojIqudxsdDpCbTF6WXbgyHnQWQ0Xc6lxTZxla3H7EomqbV
	iyQjpSFXjlqMNjqHoBguNiZ9mpURNZLQ==;
Authentication-Results: freenet.de;
	iprev=fail smtp.remote-ip=2a02:8071:a85:f020:3062:7ec0:dda9:d77d;
	auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:3062:7ec0:dda9:d77d] (port=37380 helo=[127.0.0.1])
	by sub3.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.98.2 #2)
	id 1ws4Pl-0000000GlkV-2wax;
	Thu, 06 Aug 2026 22:10:05 +0200
Message-ID: <a464c560-8f7b-4609-8bbe-b7048f603d26@freenet.de>
Date: Thu, 6 Aug 2026 22:10:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: Wayne Lin <wayne.lin@amd.com>, Ray Wu <ray.wu@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, daniel.wheeler@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
Subject: Drop "drm/amd/display: Add AV mute wait frames to dce110_set_avmute"
 from stable queues
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-FN-MUUID: 1786047005DED04348A5B5O
X-Scan-TS: Thu, 06 Aug 2026 22:10:05 +0200

Hi Greg and Sasha,

I noticed that the following patch is in the queues for the 7.1, 6.18 and 6.12
stable trees:

From 443290d70b01e9c35830c300e3247c06581b594c Mon Sep 17 00:00:00 2001
From: Ray Wu <ray.wu@amd.com>
Date: Mon, 13 Jul 2026 22:23:34 +0800
Subject: drm/amd/display: Add AV mute wait frames to dce110_set_avmute

From: Ray Wu <ray.wu@amd.com>

commit 443290d70b01e9c35830c300e3247c06581b594c upstream.

Port the three-frame wait logic from dcn30_set_avmute to
dce110_set_avmute so that older DCN versions (1.0, 2.0) also
wait for GCP packets to be sent out before proceeding.

This ensures HDMI sinks properly process the mute state,
preventing garbled display after link re-establishment.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5167
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 414da24137ace80d8c59fefd43ba3ec9f5f854ba)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |   21 +++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1320,8 +1320,27 @@ void dce110_blank_stream(struct pipe_ctx
 
 void dce110_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 {
-	if (pipe_ctx != NULL && pipe_ctx->stream_res.stream_enc != NULL)
+	if (pipe_ctx == NULL || pipe_ctx->stream_res.stream_enc == NULL)
+		return;
+
+	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(pipe_ctx->stream_res.stream_enc, enable);
+
+		/* Wait for three frames to make sure AV mute is sent out.
+		 * Some HDMI sinks need additional GCP packets to properly
+		 * process the mute state, especially after link re-establishment
+		 * with HDMI 2.0 scrambling enabled.
+		 */
+		if (enable && pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg)) {
+			int i;
+
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			for (i = 0; i < 3; i++) {
+				pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+				pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			}
+		}
+	}
 }
 
 enum audio_dto_source translate_to_dto_source(enum controller_id crtc_id)
---

Please drop this patch because it leads to a regression which I reported for the
mainline kernel here:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5557

A fix for the regression is already available, but it hasn't landed in the
mainline tree yet. Since the patch above fixes an annoying issue, I propose to
postpone it until the mainline tree has the fix so that both patches can be
applied to the stable trees in the same release. I will notify you when that
can be done.

Regards,
Viktor
