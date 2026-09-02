Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1D433050
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351045; cv=none; b=jjIOetT+zcdkaCHjWJFNMmfCutYRf8lePvzspDxlgpnXEY5JXaxDG8k2lVjqRiu6FOeB0suexT66vNhe7yGkaljtzVtAvpNukmBkkTLkzDMY9Am2eMkJzM1RUjnFrYIp+qZP5mmgoGJaxSZOdhbilAj1P4aZl/tah9rM+ox7CqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351045; c=relaxed/simple;
	bh=NhQmeJ7xXtC2qhhuZdlM1pf4BctUAxpJW0Z9jOz1lXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaVRiyaZ5/Kd8RtBVhMq0IiFIgCfQivGetWFT98YPrt4doq7PvINK5RFu2y/LCpSzHnXBy+lbp4YjxajVacvHq139xY9Gq39WNRRiz5pW1hSOfV9Y2v98SbGmf8SCi8Onh95ofh9ARdPZ3q5aZIJ5SzCbYihrXe4H6gwjD6Uc10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTNW4ugA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTNW4ugA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788351040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQ4xYgPisX1eloJMBrUIHWw1g1geoI0YKTxulh3uSC0=;
	b=iTNW4ugAxdaEBcknU7OMTOysxaRn+JoBc69/lYFWb3cx0hibUrahKb/ppG3P7VROGY+0XY
	luqSqHjMNXnS0Y08AttT+jQnDaV42qG9z9Iz+mAenec+9PEb3WmYVlWvnUbalNxQN4kh00
	JldPLsvBzYc0TGRdd/ggkDe7Blnq378=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-cGpnszrpMNaoY7iEI94stQ-1; Wed,
 02 Sept 2026 08:10:38 -0400
X-MC-Unique: cGpnszrpMNaoY7iEI94stQ-1
X-Mimecast-MFC-AGG-ID: cGpnszrpMNaoY7iEI94stQ_1788351037
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80056180217D;
	Wed,  2 Sep 2026 12:10:37 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70EE61955D67;
	Wed,  2 Sep 2026 12:10:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] afs: Fix missing kunmap in afs_dir_search_bucket()
Date: Wed,  2 Sep 2026 13:10:19 +0100
Message-ID: <20260902121024.3328255-2-dhowells@redhat.com>
In-Reply-To: <20260902121024.3328255-1-dhowells@redhat.com>
References: <20260902121024.3328255-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix afs_dir_search_bucket() to kunmap the block it's using in the "bad:"
path.

Fixes: a5b5beebcf96 ("afs: Use the contained hashtable to search a directory")
Closes: https://sashiko.dev/#/patchset/20260716103030.3065561-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/afs/dir_search.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/dir_search.c b/fs/afs/dir_search.c
index 104411c0692f..4977ad81fa82 100644
--- a/fs/afs/dir_search.c
+++ b/fs/afs/dir_search.c
@@ -173,12 +173,11 @@ int afs_dir_search_bucket(struct afs_dir_iter *iter, const struct qstr *name,
 
 	ret = -ENOENT;
 found:
+bad:
 	if (iter->block) {
 		kunmap_local(iter->block);
 		iter->block = NULL;
 	}
-
-bad:
 	if (ret == -ESTALE)
 		afs_invalidate_dir(iter->dvnode, afs_dir_invalid_iter_stale);
 	_leave(" = %d", ret);

