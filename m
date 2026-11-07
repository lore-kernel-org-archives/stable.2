Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081025;
	b=chNYmGEsxdL5uxN9Wj8ygNGbwm/JOBuo8QLLmWOjqXTkCQwArQjHvN1BxVzdJzBqWC8M
	 el7CASil10H+XiJCkQdgrOTNSAlbGO0C7XtrltRVXfHEGK/zhIIQYlNDVNZEt5QqgILFr
	 +1ZypOYmvzBBjZe+oZFhqa88JcHUr7Vv1L23Op49GK9t0uDBGp8fZBT32zX8ETXMmcen5
	 8/N5v2Db6mTeYYoeOArarbz+GFbdJJqV9PWe5gC7o6owqpZdrJRBu/1gO7Q+s9PeAbgVU
	 U+BzhAMNdVnZ5iX/dGmTfZawtqrXzXD/Dyy5KbyA88JY71kwDgnC/EnznaJZrt9DMQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081025;
	h=DMARC-Filter:DKIM-Signature:X-Change-Id:To:Cc:Subject:Mime-Version:
	 X-B4-Tracking:X-Mailer:Content-Type:From:Content-Transfer-Encoding:
	 X-Lms-Return-Path:Date:Message-Id:X-Original-From:Received;
	bh=K1F94lpgRjwfdExX3+hXbcyK+LhehLvQceSbB/nuEyM=;
	b=XQ8ydYwWJrkJa0hTaQplFdnsx9XkQoklbhL9whw95/ze61yDw+aY5sH+6ak8Wf8LhewS
	 ohER5thudtJsK3NdqKtZJa9Y27D0VMAPA5dWxlBIEQk0ckwTJG3CRP8MFDfesY4OxFY0J
	 J3rOz/Tg9FprVkfEcdONBCXylEZT5Kd1Nkk6PmW5jiMMSlmt4k/K1nZLqcytISbKhTZRZ
	 T4f0Z86lHo+PiVFncflYHgal29OcOE1NNlHpP4k7RIfZzBtiAirREJsYHI5CxaU2GzvUp
	 6hjEF6ZWv/GGTI1QzG5zRGeuRymeEnV+gVjEO0iXA+X8+irFFzRnX8xCB2RCj42bepA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=wGQ07F5y;
	arc=none smtp.remote-ip=71.18.227.2
Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE647606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE647606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=wGQ07F5y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1794081011; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=K1F94lpgRjwfdExX3+hXbcyK+LhehLvQceSbB/nuEyM=;
 b=wGQ07F5yPwFP2lUcYc5hmRoZQJYtqKvgEgaqAOHabzrbTOva4UzlSqscPKJTQtv3VdwUUy
 RWwfeSZg4AAUqUn8Ggml6tYF8fyWCjFFtUtBi4cs7cpH0wOCQQKJ1eorpXZn7ZEWFEAKUW
 cYLVbNwvlYkp9VczVP55U7he64wgpsL13uGo3HNAu12Foh5egwAdYu9oxVY5eondZoagVW
 M2JeKNZlSPeVBwCXcrgbiknMu/E8BRFXokURqeMLJdv2xbS0iVAVx2x9LL0ia4DXzIhTkW
 yCGJAe544nzAx6XjL4DQlVLIOH1hVrtLq3VlKuLa2PaqToTuyFlU8ultVuz39A==
X-Change-Id: 20261106-twin-20261106-fs-xfs-da-node-e319621e1c48
To: "Carlos Maiolino" <cem@kernel.org>, "Long Li" <leo.lilong@huawei.com>, 
	"Darrick J. Wong" <djwong@kernel.org>
Cc: <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>, <stable@vger.kernel.org>
Subject: [PATCH 0/3] xfs: bound da-node entry counts
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOWA72oC/z3MQQ6CMBBG4auQWTMJU00jXMWwwPZHx0UxHVASw t2tmrh4i2/zNjJkhVFXbZTxVNMpFUhdUbgN6QrWWEyucV6k8Ty/NPFfo/FaigOnKYJxkNY7gYT jicrikTHq+t2f+59tudwR5s+T9v0NLO3uO4AAAAA=
X-Mailer: b4 0.16.0
Content-Type: text/plain; charset=UTF-8
From: "Shengzhuo Wei" <me@cherr.cc>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26aef80f1+0d34c3+vger.kernel.org+me@cherr.cc>
Date: Sun, 08 Nov 2026 03:49:57 +0800
Message-Id: <20261108-twin-20261106-fs-xfs-da-node-v1-0-0d4bd47938ba@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Received: from [127.0.1.1] ([111.40.58.155]) by smtp.feishu.cn with ESMTPS; Sun, 08 Nov 2026 03:50:08 +0800

The da-node verifier cannot distinguish directory and attribute geometry.
With multi-block directories it accepts an attribute node count that is
valid for a directory but larger than the attribute buffer.  These
patches add fork-specific bounds in xfs_da3_path_shift(),
xfs_attr3_node_inactive(), and xfs_attr_node_list_lookup(), preventing
out-of-bounds reads and the inactivation write.

Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
Shengzhuo Wei (3):
      xfs: bound node entries on path shifts
      xfs: bound attr node entries on inactivation
      xfs: bound attr node entries in listxattr

 fs/xfs/libxfs/xfs_da_btree.c | 5 +++++
 fs/xfs/xfs_attr_inactive.c   | 8 ++++++++
 fs/xfs/xfs_attr_list.c       | 3 +++
 3 files changed, 16 insertions(+)
---
base-commit: d68ce4e71248e1ff5af9654b407541d9260b3ba5
change-id: 20261106-twin-20261106-fs-xfs-da-node-e319621e1c48

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
