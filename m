Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06835674B
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401438; cv=none; b=DtUWNy9RELKTQSOhGVktMJ51ltJgnQsE9YIsH4aFJFShh9wYTg1Q6ZJblYzAhEbXKc9gYJYd0r5T2D2+rdAjKpKt78slBHuALGQ37jaygjSN0xp+JiH/uj7uWOwHyWodg5JGc+RUiLtkwn4KmAEaBeUuK68I5YySR/h6uJ8UDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401438; c=relaxed/simple;
	bh=xVzNQGTQpR3ArjteG3mXq0M0AhmRGBBW97tblgH89XI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YPScIeErKM2aE2HuSZbA5avwPl9p92yojkqc/r0A9O4FZGusntvLpvM6UkVPF8IMc3ahPDm/pp6xmwnSo8hmhdU5HLA0zfySwww2maaZhoPYCbxT/SEhGqSy0C6QSNpieLLJcT3PxYcrukWtrLFjhsxFnzohdblkmGHyPjP/qRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=S+4bM8BA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S+4bM8BA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OqITYPON+V4iTiCCn+FZ5G5jdIoo/ylqj7tFBDOvcwU=; b=S+4bM8BA/V3ou7ChjXhvga8/Zz
	kY9+sdIaz5vJEbouqbJKOLZHeMnAqhF3MlHuUJ5jtp1UNhj37+lxsAL1U6VmCN9HH+uDPGbQu0iML
	nneUppltx9e8v/K/2DUXfYbp3UWJQpycuaUfRZYnoZaxg5h0ibTCElOQS6cphtutO/qK6P+0Zsshs
	9l07wOZgVw1ghT/h4ZzTR84aiLo2E3xRHEM2yZKS3bFu/mSQEQfhvTBWJFn7xECiFD+GguItwwARw
	YrqKp2pErug7EfEhxFhwZeCKw4xaBNtOvgen2DVu0103tWhR89z35BE//2h33kYm95M1veMFhjI98
	mYQiSmJw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wUNk8-00BgWO-UB; Tue, 02 Jun 2026 13:57:13 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 0/2] drm/v3d: Fix indirect CSD jobs with zeroed
 workgroups
Date: Tue, 02 Jun 2026 08:57:05 -0300
Message-Id: <20260602-v3d-fix-indirect-csd-v3-0-cc79e06e543c@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNzQrCMAzA8VcZPVtpGxunJ99DPHT92AK6STuKM
 vbudkMQQY//kPwyseQj+cSO1cSiz5Ro6EvApmK2M33rObnSTAmFQkvkGRwP9ODUO4rejtwmx7E
 WaIMSRu8NK6f36MvOyp4vpTtK4xCf65csl+kbBPEbzJILLrUGOOxqRAgnas2VzNYON7aIWX0UF
 PKPoopijG+CAN0cAL+UeZ5f1WbBjv8AAAA=
X-Change-ID: 20260516-v3d-fix-indirect-csd-6806cf20a57a
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=xVzNQGTQpR3ArjteG3mXq0M0AhmRGBBW97tblgH89XI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHsUVRRPK71dGGp1ythC6+++t0WQQrT7h+jqvm
 d+NH2HQOXeJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah7FFQAKCRA/8w6Kdoj6
 qrtrB/wPt7+4QHY5Sm9fdtAdOi4x0S2Y22/EzNzo8mwNT6bmAsQfzk3ME2H5qQ2S+5jCGlnEnHO
 ip3q09+xlmi+5CgwrGN8rdoUvggL2EygeNch7ngm1yxr5C72b74NdXeRb/dn7H/7SZvMiBy0uxF
 GCKoYUKN65RT3mwPV39N71xGNDoJbgUq+iOLwFfr2nR5sXSa8v+xoPcjNYQsAtsyhVeE4TmoqFe
 NOviA0Agz9d56VaIx8CZcCR5hviuR5ZFk2VNEdYsc6HH6wbpEZOQcDvj6REt1lvA50v76MCSXOO
 YaaiYIzT7HGiL9bIuszQxgu2+PLkm1QGbFM7SDd3e1xfgxUr
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

Hi,

Indirect CSD lets userspace defer the workgroup counts to a GPU buffer
that is only filled at runtime, so the counts are unknown at submission
time and can legitimately turn out to be zero.

However, exercing this case exposed two issues in the CSD path.

  1. Virtual address leaks when the indirect CSD has zeroed workgroups.

  2. CSD jobs with zeroed workgroups shouldn't be submitted to hardware.

This series intends to address both issues.

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com

- [2/2] Don't check the whole cfg[0-2], check only the number of workgroups (Iago Toral)
- [2/2] Add a comment about how the HW interprets 0 (Iago Toral)

v2 -> v3: https://lore.kernel.org/r/20260601-v3d-fix-indirect-csd-v2-0-aaebf035b936@igalia.com

- [1/2, 2/2] Add Iago's R-b (Iago Toral)
- [2/2] Adjust the comment to make it more accurate (Iago Toral)

---
Maíra Canal (2):
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      drm/v3d: Skip CSD when it has zeroed workgroups

 drivers/gpu/drm/v3d/v3d_sched.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)
---
base-commit: ae0383e5a9a4b12d68c76c4769857def4665deff
change-id: 20260516-v3d-fix-indirect-csd-6806cf20a57a

