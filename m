Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D743F54BD
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059330; cv=none; b=f8P7cROSbgMlz6HWcPqlnTUPIojUJTuJBD+TYA09pUVsZYnRF9MNvBXhmyeItfqFSjDXDuHZmkhRgwcDd1BmUnG4D3qVG7ILxL169WwJctA4iGZph8hLUZNwrQ9Us6M/qlolh/ZqljWkv9FuPAv6apRjOmkBunt4XadbhOn8MO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059330; c=relaxed/simple;
	bh=gcV3hWWvEgEWGlan+2hSwHn4wzHm8sq+Wz4j+zOl/oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+9ldMb/JMLPawGYzwA58W0lrufC2xVfIXTw8iDHCVUzy/oyS8HP0nZvZHpmh4R1/yily5OyapfnBMomDOSYsPoa92Hq+4rRpIlAv+jAXaVaZa/O7aOmBOWjTNH7z3fG05JLAgAHfrYt2GfPtdSEKEuaGF3QQp5dB84axIZYdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRK82amW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRK82amW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072CE1F00A3D;
	Tue, 14 Jul 2026 20:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059323;
	bh=YPMZbffzfxA2hUBW9q/1c1r3IvrBcbQhGkSpt6VixTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRK82amW/qM0o8Q/0i69VYtozebvyFK9yV8d3FsT3vpHIBtnwq9WDm/RcZBRS3Dtr
	 DXm+UQ813H9pCk5+DKozwWMsV6kji/eupyOVLF/nXEj5CcdWcejt/JQ7VJvKBmQLPj
	 jOWwoXRpIWvhXcb6QDC1oFkQP94dSgBgr8PFa3Xf/5GCJcdtZ8RYV5FwwlPB8uYE1T
	 5JWhSO/8clp9qy3Tz/RNXs/SB2H2MnPA9Chf6AqL/+VByavYcmUhQ5buc7n7O6Bi3N
	 DVrAyfEzWs9SMF/BI1Ubbxb8QID/wgqjX/DKsjyJynOZdJiBFd/6iZIPoJS72/84eh
	 gkow31BzhxiCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martiros Shakhzadyan <vrzh@vrzh.net>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/6] media: staging: media: atomisp: Replace if else clause with a ternary
Date: Tue, 14 Jul 2026 16:01:56 -0400
Message-ID: <20260714200158.3152137-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200158.3152137-1-sashal@kernel.org>
References: <2026071304-opulently-outburst-4960@gregkh>
 <20260714200158.3152137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martiros Shakhzadyan <vrzh@vrzh.net>

[ Upstream commit d4bc34d18201120b247506b4a6ed17af694dfcf7 ]

Use the ternary operator for conditional variable assignment in
create_host_video_pipeline().

Signed-off-by: Martiros Shakhzadyan <vrzh@vrzh.net>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: f4d51e55dd47 ("staging: media: atomisp: reduce load_primary_binaries() stack usage")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index ce39693547064a..e04116ac306f3c 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -3623,11 +3623,8 @@ static int create_host_video_pipeline(struct ia_css_pipe *pipe)
 		struct ia_css_frame *tmp_out_frame = NULL;
 
 		for (i = 0; i < num_yuv_scaler; i++) {
-			if (is_output_stage[i]) {
-				tmp_out_frame = out_frame;
-			} else {
-				tmp_out_frame = NULL;
-			}
+			tmp_out_frame = is_output_stage[i] ? out_frame : NULL;
+
 			err = add_yuv_scaler_stage(pipe, me, tmp_in_frame, tmp_out_frame,
 						   NULL,
 						   &yuv_scaler_binary[i],
-- 
2.53.0

