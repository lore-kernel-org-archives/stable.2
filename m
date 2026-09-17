Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3A38F932
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612424; cv=none; b=V81TviUnuPxVH8WsDGf2TLoyahpB5pAst4wdygf2yRSwlHuArTAkgGcmgILSgRwJc8syxO32BaUtuVNMn2szvoJ2/mXoYvhc5dmwbhluW0EPpx4cK3crOk8glh4TYVfIesq0kUL+Io7F3oOlHvYqzrVhBWrJFmledBgozRJMARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612424; c=relaxed/simple;
	bh=/1X1rgcZ9GfqkHpPMYCnDD3RXKq/Q6dsGMbjKO6V4eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvlHo5OiZ/zXPTES5wqxcHb0QpB4xTtV27qP7itm0oUkLMwQZsYHEMxEQF1cNfxwC+0BYrh5ZHWRVhnsXLqL0rkALeFoRZ6Q9xJGQDCYhnv0SxE0aQ3aeIbOz3flEvZpPaZ+4vD+6oMzEmnxmI17GZyCpInDt3IldrMg0TbFhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+zzOpBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+zzOpBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34EB1F000FF;
	Thu, 17 Sep 2026 02:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789612402;
	bh=TI8nd2QyNq9GMT1Gta2zTF+qL4m/AsIy5Nha+9800p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+zzOpBw4oM3G+embxirLZaPuyb9y3C1hvRU4OkbT1pbwizwqDYn/bHlwnN9cI4uR
	 3MoKfa/F3f0Yxb4aFmjaqdQhCMq+qaBfh9IEKIWMMAnh6V3h4jdf/CkLhkK+diij/6
	 sD5DIgSSOrH064gtoqb7eCdbmXltMpy0+iXFhaLcKcQV/jhwP1qHPZvyhOPFwibhCL
	 q+j5mlr8YWqVCwiPkeQvhQhkTiORPHlNO7h7BX7CgrjXSZmQYtuUvFOyT4/OpZsV8B
	 4A4HoN2CLbj8TDUkxAfJqioGEy60BC+jEy+N+rG7MXWN3xPQlSLRf+pE2lTZEzQqWA
	 yVbEv+2jJ4Ifg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: v4l2-ctrls: split up into four source files
Date: Wed, 16 Sep 2026 22:33:19 -0400
Message-ID: <20260917023320.3876251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091645-habitat-untoasted-f76f@gregkh>
References: <2026091645-habitat-untoasted-f76f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 71c689dc2e732d4cb190aaf0edea73116b1611bd ]

The v4l2-ctrls.c source has become much too big, so split it up
into four separate parts:

v4l2-ctrls-core.c: contains the core framework code
v4l2-ctrls-api.c: contains the uAPI interface to the framework
v4l2-ctrls-defs.c: contains the control definitions
v4l2-ctrls-request.c: contains the Request API helpers

And it adds a new v4l2-ctrls-priv.h.

No code was changed, but a number of checkpatch.pl warnings were
fixed (alignment, f == NULL -> !f, long comment block coding style,
unsigned -> unsigned int).

The copyright statements were updated as well since they were
quite out of date.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[5.10 dependency adaptation for dc694a9929f7]

Limit this dependency to renaming the existing stable v4l2-ctrls.c to
v4l2-ctrls-core.c and updating its object name in the Makefile. Preserve
the source contents byte for byte, including all stable fixes, and keep
v4l2-clk.o in the videodev object list. No functions are added or changed.

The target's HEVC PPS validation context already exists in this stable
source; only the upstream filename is needed for the target to apply.
Drop the remaining source split, private header, and documentation hunk:
those changes are unnecessary for the target, and the documentation file
is absent from this branch. The original subject is retained as required.

[ sashal: Reduced backport -- upstream 71c689dc2e732 touches 8 file(s), this
  backport carries 2. Not backported here:
  Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
  drivers/media/v4l2-core/v4l2-ctrls-api.c
  drivers/media/v4l2-core/v4l2-ctrls.c
  drivers/media/v4l2-core/v4l2-ctrls-defs.c
  drivers/media/v4l2-core/v4l2-ctrls-priv.h
  drivers/media/v4l2-core/v4l2-ctrls-request.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: dc694a9929f7 ("media: v4l2-ctrls: validate HEVC tile counts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/Makefile                            | 2 +-
 drivers/media/v4l2-core/{v4l2-ctrls.c => v4l2-ctrls-core.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/media/v4l2-core/{v4l2-ctrls.c => v4l2-ctrls-core.c} (100%)

diff --git a/drivers/media/v4l2-core/Makefile b/drivers/media/v4l2-core/Makefile
index 2ef0c7c958a24..a9926ef97db38 100644
--- a/drivers/media/v4l2-core/Makefile
+++ b/drivers/media/v4l2-core/Makefile
@@ -6,7 +6,7 @@
 tuner-objs	:=	tuner-core.o
 
 videodev-objs	:=	v4l2-dev.o v4l2-ioctl.o v4l2-device.o v4l2-fh.o \
-			v4l2-event.o v4l2-ctrls.o v4l2-subdev.o v4l2-clk.o \
+			v4l2-event.o v4l2-ctrls-core.o v4l2-subdev.o v4l2-clk.o \
 			v4l2-async.o v4l2-common.o
 videodev-$(CONFIG_COMPAT) += v4l2-compat-ioctl32.o
 videodev-$(CONFIG_TRACEPOINTS) += v4l2-trace.o
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
similarity index 100%
rename from drivers/media/v4l2-core/v4l2-ctrls.c
rename to drivers/media/v4l2-core/v4l2-ctrls-core.c
-- 
2.53.0

