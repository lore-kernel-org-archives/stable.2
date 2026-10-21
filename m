Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575763;
	b=ubwmrNFhs4TxEIAEWsQHtbze4o6DRqgPlVSgWcU7D2MvhyjHHijFn2zC8dSimX9MfuAv
	 NYTwHkpl4KrfPLhqZY0VrhTQTnrrwFhm8SB+eiwR2IIAVnLUK7/esYhxkmZnWMOvdtDmA
	 u9rd20mUZNSpf5PHYl0/XmXHFQPUHT5nvpHsIkqxztLTMAM0AzBiO/9XsqYXnJdNGohDa
	 3sD029oG5rSXzgIIx7wTX5vK1fwjYXmmcKCbrAocCmTNY4FHcebEf7sFaht0FYOXE4bhG
	 q1Ui38i1psJJ0BRI9XfBam67hN19GhEIuqRWucetEdVcOkngmSdlxVUTkqhlKsh1U3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575763;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GJzeaTpZqVIxVkIIE61LYZXU2u51XkZg/vAcigcjOTM=;
	b=ehXGhxmx/VaLbHjhwre3sD7Qzmym/FPENK67yXwQM9EbnZNKJKNqwegl6en7kKRUVcAu
	 bzE8wKLq9bCg9Yh136LFHXUoQ/MFQ9Qev8Lbd7aBpbxaMvaLi1d+Yy+f9GMwR16deg8f/
	 Vtb3rKdibx0E/FXL7Z8EbF/jrdp4QsKZjN6hu+FFTCBhplzvWm44HPU7WEslXVDwH2M/q
	 +CZxhWftspbHMDTuiMsh4mr4PVuzajFr8XOC2U+CH9gTm/HQmBGNHPbBv2CWYqvREXXG2
	 N5Ny6fKf8KT+yP0BKrCNUuNUDgJMbqEPARiEXITyDlchG5HV4e11MwAwHdPEBr21A5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Vbml+9K5;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18A606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 09:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED18A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Vbml+9K5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=GJzeaTpZqVIxVkIIE61LYZXU2u51XkZg/vAcigcjOTM=; b=Vbml+9K5aEDDr0uW8tfzbFoFN1
	2FbVEuhxYwvHhIDdHddnORqBNbKD71jKX+A86uw0SJleFfaos6m2E3t2dFSxyN9aw/pndlhWhAIFk
	DwaqinXA073Yyn+kCuejPwuBoykDIa1PuyycVXxcyvQ6T9DNsjaRV60X7t6HaDe9imlfWv6VdHZlU
	qZwIm76hNM+Qy+IzYoj2PVHIzfsnOaAWePWatG+rmhSpQagMsLOQ1r1r6hlDNc/vEUvMZYAoJ9ugI
	cda06MhDQpFUILPr1zWNhgkt6QxGADgOIs0kZbuvwmuuP2N/pE/5BU1xZ03o4MlWLQl9dkng+FipL
	MzJlT7Qg==;
Received: from [81.79.79.1] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xJSq6-005Uf1-HH; Wed, 21 Oct 2026 11:42:30 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing priority at runtime
Date: Wed, 21 Oct 2026 10:42:27 +0100
Message-ID: <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
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

Another consequence of the recent revert of
77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run queue")
is that after the revert we need to adjust entity->rq_priority when
runtime priority changes are requested.

Only amdgpu does that so the impact is minimal. Also considering dynamic
priority changes are largely broken there, due currently broken entity
scheduler list handling where the special case of a single scheduler can
never change it's run-queue. And coupled with the fact for the rest a two-
tier approach of drm_sched_entity_set_priority() and
drm_sched_entity_modify_sched() is used, where later directly maps to
different hardware queue priority by replacing the set of schedulers
completely.

Hence the regression is limited to rings which have multiple instances
other than compute and graphics, which would be SDMA only, for which I am
not sure any userspace actually does dynamic priority changes in the first
place.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: <stable@vger.kernel.org> # v7.2+
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e12709b7bd0c..03e68b4102d5 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -456,6 +456,8 @@ void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 {
 	spin_lock(&entity->lock);
 	entity->priority = priority;
+	if (drm_sched_policy != DRM_SCHED_POLICY_FAIR)
+		entity->rq_priority = priority;
 	spin_unlock(&entity->lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_set_priority);
-- 
2.56.0

