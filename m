Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420D364024
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341243; cv=none; b=OkA4lrR9wD/OpWelVx5tYD+Hz1GfORJv6iBC4ERzeu6jRNUU2FcH4fC3l5jPhpoGSAYsnVbkeF4xkP08hNmp2tPXnO0fBKB26faxGbT6+ZzeoWLnwjTfnQL2JmZFX59scqx1NFDsEnER7rIqp6C+Gvrt/nctZL93R8oIgD2BTI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341243; c=relaxed/simple;
	bh=hD9ZyK/6hHSNBHm2d6rNF/7VjnRepNqxvoX09MKzYjQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gv7z11vHT0udZNBdEmKdmZKsIr1KvexHZJdLMG7904GHswP8ikW+sO3nSTQZC0/3MDAUsHejLfcGxzxroMcM9CIkzE9cmF+JXyB0ymsgbcqLJdGPx8SXyNxJuzIkQz8WaAVdHVNT1j6D4ZRK/yx7Sna7xW6pM7AMZNqjzfzAa1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ncHLTk+1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ncHLTk+1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=y99MWSkT3U44gIyTsTR6uqD1N8j0ka6iS4rLudm/EkE=; b=ncHLTk+1zSXdLat/q5YeVhwesa
	3lAJY/GpD2KZT3HIWoYgM7jFpwEbj4evQfcMCVKjmIfKh4d52vDDZflihuhNVA1L+7tZ7lKbC1wsU
	5yKA/84HZ+2ROhNIApNT8RMQZnXuH6vLlNYEePHPNK1wbGmUkJiEk2iQ3QUbfcRqLFvtmFWYOw1dG
	gTkVl+Y0frkk3uWDYWHJ8mA2GQqDdoHX0FR1rQxevjn5NiL0ER1XPizrm8e3oBSFrWZHO7Cvsxuqo
	tr75NCEA1+YPm5wDc6kqBOiPuKzpv0pDOBur7s60p3lvrGLcXSr1jMIelYpghUP1WOeq84MdODFzJ
	d4FrpDDQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wU85C-00BGx8-G7; Mon, 01 Jun 2026 21:13:54 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/2] drm/v3d: Fix indirect CSD jobs with zeroed
 workgroups
Date: Mon, 01 Jun 2026 16:13:46 -0300
Message-Id: <20260601-v3d-fix-indirect-csd-v2-0-aaebf035b936@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NywrCMBREf6XctVfyMLG68j+ki5BHe0HTkpSgl
 Py7sbh0eYaZMxtkn8hnuHYbJF8o0xwbiEMHdjJx9EiuMQgmNFNcY5EOA72QoqPk7Yo2O9Q90zY
 IZtTZQJsuybfOrr0PjSfK65ze+0vh3/QnlOy/sHBkyJWS8nLqtZbhRqN5kDna+QlDrfUDR2EQk
 LkAAAA=
X-Change-ID: 20260516-v3d-fix-indirect-csd-6806cf20a57a
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=hD9ZyK/6hHSNBHm2d6rNF/7VjnRepNqxvoX09MKzYjQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHdnvcGOnhYyEe7HVEnHErw4S4WeA1u3BS63mu
 MZE/kWvhKmJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah3Z7wAKCRA/8w6Kdoj6
 qnjDB/9e+uRJ2DLb/Jj+tUpb0bIC6PFJxNw46qvBJn29fiRs99QE5TeGn338iud6qzN0BjzGMgc
 4XZMQYWCakrcssM51og8rT5BdjzQ1iDUh+17z13pLklbx27LFYkrCcglu+ORm2aexoPRk6U/anK
 F4x/mlaSkUIktNYWyfsBS0XFwWBZhvsOd2gjxy9xlaA5gcO7eibGji+gOa74iIhA63eO+Asa/dn
 np4OoUyS72osheT/DrfntGZxfnv/PP39TJypr8BzoBrcRJwEO/WydQSAEIFl2i3Ffx0a8BBTu/0
 bEpxPzv7dXoOBPVlWhWCg1JmsDPtXl1D+3PNnSkCA/g3jUyM
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

---
Maíra Canal (2):
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      drm/v3d: Skip CSD when it has zeroed workgroups

 drivers/gpu/drm/v3d/v3d_sched.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)
---
base-commit: 5ab62dd3687bcc2cc542b99385aabac5c996db6f
change-id: 20260516-v3d-fix-indirect-csd-6806cf20a57a

